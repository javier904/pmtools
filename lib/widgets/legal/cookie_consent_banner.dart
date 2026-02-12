import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/themes/app_colors.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:agile_tools/services/auth_service.dart';
import 'package:agile_tools/services/user_profile_service.dart';


class CookieConsentBanner extends StatefulWidget {
  final bool? initialConsent;

  const CookieConsentBanner({
    super.key,
    this.initialConsent,
  });

  @override
  State<CookieConsentBanner> createState() => _CookieConsentBannerState();
}

class _CookieConsentBannerState extends State<CookieConsentBanner> {
  bool _isVisible = false;  // Inizia SEMPRE nascosto per evitare flash
  bool _checkComplete = false;
  static const String _consentKey = 'cookie_consent_accepted';

  /// Flag statico per evitare che il banner riappaia nella stessa sessione
  /// se l'utente lo ha già chiuso, anche se il salvataggio locale fallisce.
  static bool _dismissedInSession = false;

  @override
  void initState() {
    super.initState();
    // Non impostare _isVisible qui - lascia che _checkConsent() decida
    _checkConsent();
  }

  Future<void> _checkConsent() async {
    // Se già chiuso in questa sessione, non mostrare mai
    if (_dismissedInSession) {
      if (mounted) setState(() => _checkComplete = true);
      return;
    }

    // Se già passato un valore iniziale dal main.dart
    if (widget.initialConsent != null) {
      debugPrint('🍪 Cookie consent già presente da main.dart: ${widget.initialConsent}');
      if (mounted) setState(() => _checkComplete = true);
      return;
    }

    // 1. Verifica SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final localConsent = prefs.getBool(_consentKey);

    debugPrint('🍪 SharedPreferences cookie_consent_accepted: $localConsent');

    if (localConsent != null) {
      if (mounted) setState(() => _checkComplete = true);
      return;
    }

    // 2. Se non c'è in locale, e l'utente è loggato, verifica su Firestore
    final authService = AuthService();
    if (authService.isAuthenticated) {
      try {
        final profileService = UserProfileService();
        final settings = await profileService.getCurrentSettings();

        debugPrint('🍪 Firestore cookieConsent: ${settings?.cookieConsent}');

        if (settings?.cookieConsent != null) {
          // Sincronizza Firestore -> Local
          await prefs.setBool(_consentKey, settings!.cookieConsent!);
          debugPrint('🍪 Sincronizzato Firestore -> SharedPreferences');
          if (mounted) setState(() => _checkComplete = true);
          return;
        }
      } catch (e) {
        debugPrint('🍪 Errore lettura Firestore: $e');
      }
    }

    // Mostra il banner se non abbiamo trovato consenso da nessuna parte
    debugPrint('🍪 Nessun consenso trovato, mostro banner');
    if (mounted) {
      setState(() {
        _isVisible = true;
        _checkComplete = true;
      });
    }
  }

  Future<void> _persistConsent(bool accepted) async {
    debugPrint('🍪 Salvataggio consenso: $accepted');

    // 1. Salva in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_consentKey, accepted);
    debugPrint('🍪 Salvato in SharedPreferences');

    // 2. Salva in sessione (backup in caso SharedPreferences fallisca)
    _dismissedInSession = true;

    // 3. Salva in Firestore se loggato (per cross-device sync)
    final authService = AuthService();
    if (authService.isAuthenticated) {
      try {
        final profileService = UserProfileService();
        final settings = await profileService.getCurrentSettings();
        if (settings != null) {
          await profileService.updateSettings(
            settings.copyWith(cookieConsent: accepted),
          );
          debugPrint('🍪 Salvato in Firestore');
        }
      } catch (e) {
        debugPrint('🍪 Errore salvataggio Firestore: $e');
      }
    }

    // 4. Verifica che sia stato salvato correttamente
    final savedValue = prefs.getBool(_consentKey);
    debugPrint('🍪 Verifica salvataggio: $savedValue');

    if (mounted) setState(() => _isVisible = false);
  }

  Future<void> _acceptAll() async {
    await _persistConsent(true);
  }

  Future<void> _acceptNecessary() async {
    await _persistConsent(false);
  }

  void _openPolicy(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    // Non mostrare nulla finché il check non è completo o se già accettato
    if (!_checkComplete || !_isVisible) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final isWide = MediaQuery.of(context).size.width > 600;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border(
              top: BorderSide(color: context.borderColor),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 24 : 16,
            vertical: isWide ? 12 : 10,
          ),
          child: SafeArea(
            top: false,
            child: isWide ? _buildDesktopLayout(l10n) : _buildMobileLayout(l10n),
          ),
        ),
      ),
    );
  }

  /// Desktop: single row - text + links + buttons
  Widget _buildDesktopLayout(AppLocalizations l10n) {
    return Row(
      children: [
        Icon(Icons.cookie_outlined, color: AppColors.primary, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: l10n.legalCookieMessage,
                  style: TextStyle(fontSize: 13, color: context.textSecondaryColor),
                ),
                const TextSpan(text: ' '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: _LinkButton(label: l10n.legalCookiePolicy, onTap: () => _openPolicy('/cookies')),
                ),
                const TextSpan(text: '  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: _LinkButton(label: l10n.legalPrivacyPolicy, onTap: () => _openPolicy('/privacy')),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 16),
        _buildCompactButtons(l10n),
      ],
    );
  }

  /// Mobile: compact two-row strip
  Widget _buildMobileLayout(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.cookie_outlined, color: AppColors.primary, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.legalCookieMessage,
                      style: TextStyle(fontSize: 12, color: context.textSecondaryColor, height: 1.4),
                    ),
                    const TextSpan(text: ' '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: _LinkButton(label: l10n.legalCookiePolicy, onTap: () => _openPolicy('/cookies'), fontSize: 11),
                    ),
                    const TextSpan(text: '  '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: _LinkButton(label: l10n.legalPrivacyPolicy, onTap: () => _openPolicy('/privacy'), fontSize: 11),
                    ),
                  ],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _acceptNecessary,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  side: BorderSide(color: context.borderColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(0, 32),
                ),
                child: Text(
                  l10n.legalCookieRefuse,
                  style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: _acceptAll,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                  minimumSize: const Size(0, 32),
                ),
                child: Text(
                  l10n.legalCookieAccept,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactButtons(AppLocalizations l10n) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: _acceptNecessary,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            side: BorderSide(color: context.borderColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            minimumSize: const Size(0, 34),
          ),
          child: Text(
            l10n.legalCookieRefuse,
            style: TextStyle(fontSize: 13, color: context.textSecondaryColor),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _acceptAll,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            elevation: 0,
            minimumSize: const Size(0, 34),
          ),
          child: Text(
            l10n.legalCookieAccept,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double fontSize;

  const _LinkButton({required this.label, required this.onTap, this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
