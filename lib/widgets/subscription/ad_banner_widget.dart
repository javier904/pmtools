import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import '../../l10n/app_localizations.dart';
import '../../services/subscription/ads_service.dart';

/// Widget per visualizzare banner pubblicitari AdSense (solo Web)
/// Nasconde automaticamente se l'utente ha un piano senza ads
class AdBannerWidget extends StatefulWidget {
  final double height;
  final String format;
  final String? slotId;
  final EdgeInsets? margin;
  final bool showCloseButton;

  const AdBannerWidget({
    super.key,
    this.height = 90,
    this.format = 'auto',
    this.slotId,
    this.margin,
    this.showCloseButton = false,
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final AdsService _adsService = AdsService();
  bool _shouldShow = false;
  bool _isLoading = true;
  bool _isClosed = false;
  late String _viewId;

  @override
  void initState() {
    super.initState();
    _viewId = 'ad-banner-${DateTime.now().millisecondsSinceEpoch}';
    _checkShouldShow();
    _registerViewFactory();
  }

  Future<void> _checkShouldShow() async {
    if (!kIsWeb) {
      setState(() {
        _shouldShow = false;
        _isLoading = false;
      });
      return;
    }

    final shouldShow = await _adsService.shouldShowBannerAd();
    if (mounted) {
      setState(() {
        _shouldShow = shouldShow;
        _isLoading = false;
      });
    }
  }

  void _registerViewFactory() {
    if (!kIsWeb) return;

    // Registra il factory per HtmlElementView
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) {
        final div = html.DivElement()
          ..style.width = '100%'
          ..style.height = '${widget.height}px'
          ..style.display = 'flex'
          ..style.justifyContent = 'center'
          ..style.alignItems = 'center'
          ..style.backgroundColor = '#f5f5f5';

        // Inserisci HTML AdSense
        div.setInnerHtml(
          _adsService.getBannerAdHtml(
            slotId: widget.slotId,
            format: widget.format,
          ),
          treeSanitizer: html.NodeTreeSanitizer.trusted,
        );

        return div;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Non mostrare su piattaforme non-web
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    // Loading state
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    // Non mostrare se utente Premium/Elite o se chiuso
    if (!_shouldShow || _isClosed) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: widget.margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          // Banner container
          Container(
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            clipBehavior: Clip.hardEdge,
            child: HtmlElementView(viewType: _viewId),
          ),

          // Close button (opzionale)
          if (widget.showCloseButton)
            Positioned(
              top: 4,
              right: 4,
              child: InkWell(
                onTap: () => setState(() => _isClosed = true),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          // "Ad" label
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppLocalizations.of(context)?.subscriptionAdLabel ?? 'AD',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget placeholder per quando AdSense non è disponibile (sviluppo)
class AdBannerPlaceholder extends StatelessWidget {
  final double height;
  final EdgeInsets? margin;

  const AdBannerPlaceholder({
    super.key,
    this.height = 90,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.ads_click, size: 24, color: Colors.grey[500]),
          const SizedBox(height: 4),
          Text(
            l10n.subscriptionAdPlaceholder,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          Text(
            l10n.subscriptionDevEnvironment,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget che mostra un banner con CTA per upgrade
class UpgradeBannerWidget extends StatelessWidget {
  final VoidCallback? onUpgrade;
  final String? customMessage;

  const UpgradeBannerWidget({
    super.key,
    this.onUpgrade,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.purple.shade600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.subscriptionUpgradeToPremium,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  customMessage ?? l10n.subscriptionRemoveAdsUnlock,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onUpgrade,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(l10n.subscriptionUpgradeButton),
          ),
        ],
      ),
    );
  }
}

/// Wrapper condizionale che mostra il banner solo per utenti Free
class ConditionalAdBanner extends StatefulWidget {
  final Widget child;
  final AdBannerPosition position;

  const ConditionalAdBanner({
    super.key,
    required this.child,
    this.position = AdBannerPosition.bottom,
  });

  @override
  State<ConditionalAdBanner> createState() => _ConditionalAdBannerState();
}

class _ConditionalAdBannerState extends State<ConditionalAdBanner> {
  final AdsService _adsService = AdsService();
  bool _shouldShowAd = false;

  @override
  void initState() {
    super.initState();
    _checkAdStatus();
  }

  Future<void> _checkAdStatus() async {
    final shouldShow = await _adsService.shouldShowBannerAd();
    if (mounted) {
      setState(() => _shouldShowAd = shouldShow);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowAd) {
      return widget.child;
    }

    switch (widget.position) {
      case AdBannerPosition.top:
        return Column(
          children: [
            const AdBannerWidget(height: 90),
            Expanded(child: widget.child),
          ],
        );
      case AdBannerPosition.bottom:
        return Column(
          children: [
            Expanded(child: widget.child),
            const AdBannerWidget(height: 90),
          ],
        );
    }
  }
}

enum AdBannerPosition {
  top,
  bottom,
}
