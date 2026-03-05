import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html if (dart.library.io) 'dart:io';
import 'package:agile_tools/services/presence_service.dart';

/// Mixin per gestire la presenza online in modo centralizzato.
///
/// Da usare su uno `State<T>` con `WidgetsBindingObserver`.
/// Gestisce automaticamente:
/// - Timer heartbeat con burst iniziale (0s, 1s, 3s, poi 15s)
/// - Lifecycle dell'app (background → offline, foreground → restart)
/// - Chiusura tab browser (web `beforeUnload`)
///
/// ## Utilizzo:
/// ```dart
/// class _MyScreenState extends State<MyScreen>
///     with WidgetsBindingObserver, PresenceMixin {
///   @override
///   void initState() {
///     super.initState();
///     WidgetsBinding.instance.addObserver(this);
///     setupPresenceWebUnload(); // Solo una volta in initState
///   }
///
///   @override
///   void dispose() {
///     WidgetsBinding.instance.removeObserver(this);
///     disposePresence(); // Pulisce timer e segna offline
///     super.dispose();
///   }
///
///   // Quando si entra in una sessione:
///   void _onSessionSelected() {
///     startPresence(
///       config: PresenceConfig(
///         collection: 'my_collection',
///         documentId: sessionId,
///         presenceFieldPrefix: 'participants',
///       ),
///       userEmail: currentUserEmail,
///     );
///   }
///
///   // Quando si esce dalla sessione:
///   void _onSessionLeft() {
///     stopPresence();
///   }
/// }
/// ```
mixin PresenceMixin<T extends StatefulWidget> on State<T> {
  final PresenceService _presenceService = PresenceService();

  Timer? _presenceHeartbeatTimer;
  PresenceConfig? _activePresenceConfig;
  String? _activePresenceEmail;

  // ═══════════════════════════════════════════════════════════════════════════
  // PUBLIC API
  // ═══════════════════════════════════════════════════════════════════════════

  /// Configura il listener `beforeUnload` per il web.
  /// Da chiamare UNA VOLTA in `initState()`.
  void setupPresenceWebUnload() {
    if (kIsWeb) {
      html.window.onBeforeUnload.listen((_) {
        _markOfflineImmediately();
      });
    }
  }

  /// Avvia il tracking della presenza per una sessione.
  ///
  /// Se c'è già una presenza attiva, questa viene fermata prima di
  /// avviare la nuova. Usa il burst pattern per propagazione rapida.
  void startPresence({
    required PresenceConfig config,
    required String userEmail,
  }) {
    if (userEmail.isEmpty) return;

    // Ferma eventuale tracking precedente (senza mark offline, 
    // perché potrebbe essere la stessa sessione che si riavvia)
    _presenceHeartbeatTimer?.cancel();

    _activePresenceConfig = config;
    _activePresenceEmail = userEmail;

    // Heartbeat immediato
    _doSendHeartbeat();

    // Burst di heartbeat rapidi per sincronizzazione veloce
    Timer(const Duration(seconds: 1), () {
      if (mounted && _activePresenceConfig == config) _doSendHeartbeat();
    });
    Timer(const Duration(seconds: 3), () {
      if (mounted && _activePresenceConfig == config) _doSendHeartbeat();
    });

    // Timer periodico ogni 15 secondi
    _presenceHeartbeatTimer = Timer.periodic(
      PresenceService.heartbeatInterval,
      (_) {
        if (mounted) _doSendHeartbeat();
      },
    );

    print('🟢 [Presence] Started for $userEmail on ${config.collection}/${config.documentId}');
  }

  /// Ferma il tracking della presenza e segna l'utente come offline.
  void stopPresence() {
    _presenceHeartbeatTimer?.cancel();
    _presenceHeartbeatTimer = null;
    _markOfflineImmediately();

    final email = _activePresenceEmail;
    _activePresenceConfig = null;
    _activePresenceEmail = null;

    if (email != null) {
      print('🔴 [Presence] Stopped for $email');
    }
  }

  /// Pulisce le risorse della presenza. Da chiamare in `dispose()`.
  ///
  /// Equivalente a [stopPresence], ma sicuro da chiamare
  /// anche se la presenza non è attiva.
  void disposePresence() {
    _presenceHeartbeatTimer?.cancel();
    _presenceHeartbeatTimer = null;
    _markOfflineImmediately();
    _activePresenceConfig = null;
    _activePresenceEmail = null;
  }

  /// Gestisce i cambiamenti di lifecycle dell'app.
  ///
  /// Da chiamare nel `didChangeAppLifecycleState` dello screen.
  /// Se lo screen ha già un proprio `didChangeAppLifecycleState`,
  /// basta chiamare `handlePresenceLifecycle(state)` al suo interno.
  void handlePresenceLifecycle(AppLifecycleState state) {
    if (_activePresenceConfig == null) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App in background — segna offline e ferma timer
        _markOfflineImmediately();
        _presenceHeartbeatTimer?.cancel();
        break;
      case AppLifecycleState.resumed:
        // App tornata in primo piano — riavvia con burst
        if (_activePresenceEmail != null) {
          startPresence(
            config: _activePresenceConfig!,
            userEmail: _activePresenceEmail!,
          );
        }
        break;
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIVATE
  // ═══════════════════════════════════════════════════════════════════════════

  void _doSendHeartbeat() {
    final config = _activePresenceConfig;
    final email = _activePresenceEmail;
    if (config != null && email != null) {
      _presenceService.sendHeartbeat(config, email);
    }
  }

  void _markOfflineImmediately() {
    final config = _activePresenceConfig;
    final email = _activePresenceEmail;
    if (config != null && email != null) {
      _presenceService.markOffline(config, email);
    }
  }
}
