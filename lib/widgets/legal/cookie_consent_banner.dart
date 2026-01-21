import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/themes/app_colors.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:agile_tools/services/auth_service.dart';
import 'package:agile_tools/services/user_profile_service.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final isDark = context.isDarkMode;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 20,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            border: Border(
              top: BorderSide(color: context.borderColor),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cookie_outlined,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.legalCookieTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.legalCookieMessage,
                            style: TextStyle(
                              fontSize: 14,
                              color: context.textSecondaryColor,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            children: [
                              _LinkButton(
                                label: l10n.legalCookiePolicy,
                                onTap: () => _openPolicy('/cookies'),
                              ),
                              _LinkButton(
                                label: l10n.legalPrivacyPolicy,
                                onTap: () => _openPolicy('/privacy'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    if (MediaQuery.of(context).size.width > 600)
                      _buildButtons(l10n),
                  ],
                ),
                if (MediaQuery.of(context).size.width <= 600) ...[
                  const SizedBox(height: 20),
                  SizedBox(width: double.infinity, child: _buildButtons(l10n)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(AppLocalizations l10n) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.end,
      children: [
        OutlinedButton(
          onPressed: _acceptNecessary,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            side: BorderSide(color: context.borderColor),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            l10n.legalCookieRefuse,
            style: TextStyle(color: context.textSecondaryColor),
          ),
        ),
        ElevatedButton(
          onPressed: _acceptAll,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: Text(
            l10n.legalCookieAccept,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _LinkButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
