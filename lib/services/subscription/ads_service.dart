import 'dart:async';
import 'dart:html' as html;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'subscription_limits_service.dart';

/// Service per la gestione degli annunci pubblicitari (Google AdSense per Web)
///
/// Singleton pattern come altri servizi dell'app.
/// Fornisce:
/// - Banner ads (responsive)
/// - Interstitial ads (con frequenza controllata)
/// - Integrazione con subscription limits
/// - Session tracking per UX non invasiva
///
/// NOTA: AdMob NON supporta Flutter Web, quindi usiamo AdSense direttamente.
/// Gli annunci vengono renderizzati tramite HtmlElementView.
class AdsService {
  static final AdsService _instance = AdsService._internal();
  factory AdsService() => _instance;
  AdsService._internal();

  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  // ═══════════════════════════════════════════════════════════════════════════
  // CONFIGURAZIONE ADSENSE
  // ═══════════════════════════════════════════════════════════════════════════

  /// ID Publisher AdSense (da configurare con il vero ID)
  /// Formato: ca-pub-XXXXXXXXXXXXXXXX
  static const String adClientId = 'ca-pub-XXXXXXXXXXXXXXXX'; // TODO: Sostituire con ID reale

  /// Slot IDs per diversi formati (da configurare in AdSense dashboard)
  static const String bannerSlotId = 'XXXXXXXXXX'; // TODO: Sostituire
  static const String interstitialSlotId = 'XXXXXXXXXX'; // TODO: Sostituire

  // ═══════════════════════════════════════════════════════════════════════════
  // SESSION TRACKING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Traccia se un interstitial e stato mostrato in questa sessione
  bool _interstitialShownThisSession = false;

  /// Contatore azioni utente nella sessione (per trigger interstitial)
  int _actionsThisSession = 0;

  /// Timestamp ultimo interstitial mostrato
  DateTime? _lastInterstitialTime;

  /// Minimo intervallo tra interstitial (minuti)
  static const int _minInterstitialIntervalMinutes = 10;

  /// Numero minimo di azioni prima di considerare un interstitial
  static const int _minActionsBeforeInterstitial = 5;

  /// Probabilita di mostrare interstitial quando condizioni soddisfatte (0.0 - 1.0)
  static const double _interstitialProbability = 0.3; // 30%

  /// Flag per verificare se AdSense script e stato caricato
  bool _adSenseScriptLoaded = false;

  // ═══════════════════════════════════════════════════════════════════════════
  // INIZIALIZZAZIONE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Inizializza il servizio ads
  /// Chiamare all'avvio dell'app (solo per web)
  Future<void> initialize() async {
    if (!kIsWeb) {
      print('AdsService: Non web platform, skipping initialization');
      return;
    }

    try {
      await _loadAdSenseScript();
      _adSenseScriptLoaded = true;
      print('AdsService: Initialized successfully');
    } catch (e) {
      print('AdsService: Failed to initialize - $e');
      _adSenseScriptLoaded = false;
    }
  }

  /// Carica lo script AdSense nel documento HTML
  Future<void> _loadAdSenseScript() async {
    if (!kIsWeb) return;

    // Verifica se script gia caricato
    final existingScript = html.document.querySelector(
      'script[src*="pagead2.googlesyndication.com"]'
    );
    if (existingScript != null) {
      print('AdsService: AdSense script already loaded');
      return;
    }

    final completer = Completer<void>();

    final script = html.ScriptElement()
      ..async = true
      ..crossOrigin = 'anonymous'
      ..src = 'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=$adClientId';

    script.onLoad.listen((_) {
      print('AdsService: AdSense script loaded');
      completer.complete();
    });

    script.onError.listen((event) {
      print('AdsService: Failed to load AdSense script');
      completer.completeError('Failed to load AdSense script');
    });

    html.document.head?.append(script);

    // Timeout dopo 10 secondi
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        print('AdsService: AdSense script load timeout');
        throw TimeoutException('AdSense script load timeout');
      },
    );
  }

  /// Reset sessione (chiamare al login/logout)
  void resetSession() {
    _interstitialShownThisSession = false;
    _actionsThisSession = 0;
    _lastInterstitialTime = null;
    print('AdsService: Session reset');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BANNER ADS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Verifica se mostrare banner ads
  Future<bool> shouldShowBannerAd() async {
    if (!kIsWeb || !_adSenseScriptLoaded) return false;

    try {
      return await _limitsService.shouldShowAds();
    } catch (e) {
      print('AdsService: Error checking ads status - $e');
      return false;
    }
  }

  /// Genera l'HTML per un banner ad responsive
  /// [slotId] - ID slot AdSense (opzionale, usa default se non specificato)
  /// [format] - Formato ad: 'auto', 'horizontal', 'vertical', 'rectangle'
  String getBannerAdHtml({
    String? slotId,
    String format = 'auto',
  }) {
    final slot = slotId ?? bannerSlotId;

    return '''
      <ins class="adsbygoogle"
           style="display:block"
           data-ad-client="$adClientId"
           data-ad-slot="$slot"
           data-ad-format="$format"
           data-full-width-responsive="true"></ins>
      <script>
           (adsbygoogle = window.adsbygoogle || []).push({});
      </script>
    ''';
  }

  /// Genera un ID unico per il view HTML del banner
  /// Necessario per HtmlElementView in Flutter Web
  String generateBannerViewId() {
    return 'adsense-banner-${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Registra un banner ad nel DOM
  /// Chiamare dopo aver creato l'HtmlElementView
  void registerBannerAd(String viewId, {String? slotId, String format = 'auto'}) {
    if (!kIsWeb || !_adSenseScriptLoaded) return;

    final container = html.document.getElementById(viewId);
    if (container == null) {
      print('AdsService: Banner container not found: $viewId');
      return;
    }

    container.setInnerHtml(
      getBannerAdHtml(slotId: slotId, format: format),
      treeSanitizer: html.NodeTreeSanitizer.trusted,
    );

    print('AdsService: Banner ad registered: $viewId');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // INTERSTITIAL ADS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Registra un'azione utente (per tracking frequenza interstitial)
  /// Chiamare su azioni significative: apertura progetto, creazione task, ecc.
  void recordAction() {
    _actionsThisSession++;
    print('AdsService: Action recorded (total: $_actionsThisSession)');
  }

  /// Verifica se mostrare un interstitial ad
  /// Considera: subscription, sessione, tempo, probabilita
  Future<bool> shouldShowInterstitial() async {
    if (!kIsWeb || !_adSenseScriptLoaded) return false;

    // Verifica subscription (solo free users)
    final shouldShow = await _limitsService.shouldShowAds();
    if (!shouldShow) {
      print('AdsService: User has premium, no interstitial');
      return false;
    }

    // Max 1 interstitial per sessione
    if (_interstitialShownThisSession) {
      print('AdsService: Interstitial already shown this session');
      return false;
    }

    // Minimo azioni richieste
    if (_actionsThisSession < _minActionsBeforeInterstitial) {
      print('AdsService: Not enough actions ($_actionsThisSession < $_minActionsBeforeInterstitial)');
      return false;
    }

    // Intervallo minimo dall'ultimo interstitial
    if (_lastInterstitialTime != null) {
      final minutesSinceLast = DateTime.now()
          .difference(_lastInterstitialTime!)
          .inMinutes;
      if (minutesSinceLast < _minInterstitialIntervalMinutes) {
        print('AdsService: Too soon since last interstitial ($minutesSinceLast min)');
        return false;
      }
    }

    // Probabilita casuale (non mostrare sempre)
    final random = Random();
    final shouldTrigger = random.nextDouble() < _interstitialProbability;

    if (!shouldTrigger) {
      print('AdsService: Random check failed (prob: $_interstitialProbability)');
    }

    return shouldTrigger;
  }

  /// Mostra un interstitial ad
  /// Ritorna true se mostrato con successo
  Future<bool> showInterstitial() async {
    if (!kIsWeb || !_adSenseScriptLoaded) return false;

    final canShow = await shouldShowInterstitial();
    if (!canShow) return false;

    try {
      // Crea overlay interstitial
      final overlay = _createInterstitialOverlay();
      html.document.body?.append(overlay);

      // Traccia che e stato mostrato
      _interstitialShownThisSession = true;
      _lastInterstitialTime = DateTime.now();
      _actionsThisSession = 0; // Reset contatore

      print('AdsService: Interstitial shown');
      return true;
    } catch (e) {
      print('AdsService: Failed to show interstitial - $e');
      return false;
    }
  }

  /// Crea l'overlay HTML per l'interstitial
  html.DivElement _createInterstitialOverlay() {
    final overlay = html.DivElement()
      ..id = 'adsense-interstitial-overlay'
      ..style.position = 'fixed'
      ..style.top = '0'
      ..style.left = '0'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.backgroundColor = 'rgba(0,0,0,0.8)'
      ..style.zIndex = '9999'
      ..style.display = 'flex'
      ..style.justifyContent = 'center'
      ..style.alignItems = 'center';

    final container = html.DivElement()
      ..style.backgroundColor = 'white'
      ..style.borderRadius = '8px'
      ..style.padding = '20px'
      ..style.maxWidth = '90%'
      ..style.maxHeight = '90%'
      ..style.overflow = 'auto'
      ..style.position = 'relative';

    // Pulsante chiudi
    final closeButton = html.ButtonElement()
      ..text = '✕ Chiudi'
      ..style.position = 'absolute'
      ..style.top = '10px'
      ..style.right = '10px'
      ..style.border = 'none'
      ..style.background = '#f44336'
      ..style.color = 'white'
      ..style.padding = '8px 16px'
      ..style.borderRadius = '4px'
      ..style.cursor = 'pointer'
      ..style.fontWeight = 'bold';

    closeButton.onClick.listen((_) {
      overlay.remove();
      print('AdsService: Interstitial closed');
    });

    // Ad container
    final adContainer = html.DivElement()
      ..style.marginTop = '40px'
      ..style.minWidth = '300px'
      ..style.minHeight = '250px';

    adContainer.setInnerHtml(
      getBannerAdHtml(slotId: interstitialSlotId, format: 'rectangle'),
      treeSanitizer: html.NodeTreeSanitizer.trusted,
    );

    container.append(closeButton);
    container.append(adContainer);
    overlay.append(container);

    // Auto-close dopo 30 secondi
    Timer(const Duration(seconds: 30), () {
      if (html.document.getElementById('adsense-interstitial-overlay') != null) {
        overlay.remove();
        print('AdsService: Interstitial auto-closed after 30s');
      }
    });

    return overlay;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Verifica se il servizio e pronto
  bool get isReady => kIsWeb && _adSenseScriptLoaded;

  /// Statistiche sessione corrente
  Map<String, dynamic> getSessionStats() {
    return {
      'actionsCount': _actionsThisSession,
      'interstitialShown': _interstitialShownThisSession,
      'lastInterstitialTime': _lastInterstitialTime?.toIso8601String(),
      'adSenseLoaded': _adSenseScriptLoaded,
    };
  }

  /// Callback da chiamare al logout
  void onLogout() {
    resetSession();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// COSTANTI CONFIGURAZIONE
// ═══════════════════════════════════════════════════════════════════════════

/// Configurazione ads (per personalizzazione)
class AdsConfiguration {
  /// Intervallo minimo tra interstitial (minuti)
  final int minInterstitialInterval;

  /// Numero minimo azioni prima di interstitial
  final int minActionsBeforeInterstitial;

  /// Probabilita interstitial (0.0 - 1.0)
  final double interstitialProbability;

  /// Mostra interstitial al primo progetto aperto
  final bool showOnFirstProjectOpen;

  const AdsConfiguration({
    this.minInterstitialInterval = 10,
    this.minActionsBeforeInterstitial = 5,
    this.interstitialProbability = 0.3,
    this.showOnFirstProjectOpen = false,
  });

  /// Configurazione default
  static const AdsConfiguration defaultConfig = AdsConfiguration();

  /// Configurazione meno invasiva
  static const AdsConfiguration minimal = AdsConfiguration(
    minInterstitialInterval: 30,
    minActionsBeforeInterstitial: 10,
    interstitialProbability: 0.1,
    showOnFirstProjectOpen: false,
  );
}
