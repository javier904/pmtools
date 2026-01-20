import 'package:flutter/material.dart';
import '../controllers/locale_controller.dart';
import '../services/user_profile_service.dart';
import '../services/auth_service.dart';

/// Widget compatto per cambio lingua istantaneo.
/// Mostra una bandiera con dropdown per selezionare la lingua.
/// Sincronizza automaticamente con Firestore se l'utente è loggato.
class LanguageSelectorWidget extends StatelessWidget {
  final bool showLabel;
  /// Callback opzionale per notificare il cambio lingua
  final void Function(String localeCode)? onLocaleChanged;

  const LanguageSelectorWidget({
    super.key,
    this.showLabel = false,
    this.onLocaleChanged,
  });

  /// Sincronizza la lingua con Firestore se l'utente è loggato
  Future<void> _syncLocaleToFirestore(String localeCode) async {
    try {
      final authService = AuthService();
      if (authService.currentUser != null) {
        final profileService = UserProfileService();
        final currentSettings = await profileService.getCurrentSettings();
        if (currentSettings != null) {
          await profileService.updateSettings(
            currentSettings.copyWith(locale: localeCode),
          );
        }
      }
    } catch (e) {
      // Ignora errori - la sincronizzazione locale via SharedPreferences è sufficiente
      debugPrint('Errore sync locale Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeController = LocaleControllerProvider.of(context);
    final currentLocale = localeController.locale;

    return PopupMenuButton<Locale>(
      tooltip: 'Lingua / Language',
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localeController.getFlagEmoji(currentLocale),
              style: const TextStyle(fontSize: 18),
            ),
            if (showLabel) ...[
              const SizedBox(width: 4),
              Text(
                currentLocale.languageCode.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
      itemBuilder: (context) =>
          LocaleController.supportedLocales.map((locale) {
        final isSelected = locale == currentLocale;
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              Text(localeController.getFlagEmoji(locale),
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(localeController.getDisplayName(locale)),
              const Spacer(),
              if (isSelected)
                const Icon(Icons.check, size: 18, color: Colors.green),
            ],
          ),
        );
      }).toList(),
      onSelected: (locale) {
        final localeCode = locale.languageCode;
        // Aggiorna LocaleController (salva in SharedPreferences)
        localeController.setLocale(localeCode);
        // Sincronizza anche con Firestore per cross-device sync
        _syncLocaleToFirestore(localeCode);
        // Notifica callback opzionale
        onLocaleChanged?.call(localeCode);
      },
    );
  }
}

/// Toggle button compatto IT/EN per switch rapido.
/// Sincronizza automaticamente con Firestore se l'utente è loggato.
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  /// Sincronizza la lingua con Firestore se l'utente è loggato
  Future<void> _syncLocaleToFirestore(String localeCode) async {
    try {
      final authService = AuthService();
      if (authService.currentUser != null) {
        final profileService = UserProfileService();
        final currentSettings = await profileService.getCurrentSettings();
        if (currentSettings != null) {
          await profileService.updateSettings(
            currentSettings.copyWith(locale: localeCode),
          );
        }
      }
    } catch (e) {
      // Ignora errori - la sincronizzazione locale via SharedPreferences è sufficiente
      debugPrint('Errore sync locale Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeController = LocaleControllerProvider.of(context);

    return IconButton(
      tooltip: 'IT / EN',
      icon: Text(
        localeController.getFlagEmoji(localeController.locale),
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: () {
        localeController.toggleLocale();
        // Sincronizza anche con Firestore per cross-device sync
        _syncLocaleToFirestore(localeController.locale.languageCode);
      },
    );
  }
}
