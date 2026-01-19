import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller per la gestione della lingua dell'app.
/// Usa lo stesso pattern di ThemeController per garantire switch istantaneo.
class LocaleController extends ChangeNotifier {
  Locale _locale;

  LocaleController(String initialLocale)
      : _locale = Locale(initialLocale);

  Locale get locale => _locale;

  String get languageCode => _locale.languageCode;

  bool get isItalian => _locale.languageCode == 'it';
  bool get isEnglish => _locale.languageCode == 'en';
  bool get isFrench => _locale.languageCode == 'fr';
  bool get isSpanish => _locale.languageCode == 'es';

  static const supportedLocales = [
    Locale('it'),
    Locale('en'),
    Locale('fr'),
    Locale('es'),
  ];

  String getDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'it':
        return 'Italiano';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      default:
        return locale.languageCode;
    }
  }

  String getFlagEmoji(Locale locale) {
    switch (locale.languageCode) {
      case 'it':
        return '\u{1F1EE}\u{1F1F9}'; // Flag IT
      case 'en':
        return '\u{1F1EC}\u{1F1E7}'; // Flag GB
      case 'fr':
        return '\u{1F1EB}\u{1F1F7}'; // Flag FR
      case 'es':
        return '\u{1F1EA}\u{1F1F8}'; // Flag ES
      default:
        return '\u{1F310}'; // Globe
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    notifyListeners();

    // Salva preferenza
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', languageCode);
  }

  /// Toggle rapido IT <-> EN
  Future<void> toggleLocale() async {
    final newLocale = _locale.languageCode == 'it' ? 'en' : 'it';
    await setLocale(newLocale);
  }
}

/// InheritedWidget per accesso al LocaleController
class LocaleControllerProvider extends InheritedNotifier<LocaleController> {
  const LocaleControllerProvider({
    super.key,
    required LocaleController controller,
    required super.child,
  }) : super(notifier: controller);

  static LocaleController of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LocaleControllerProvider>();
    return provider!.notifier!;
  }

  static LocaleController? maybeOf(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LocaleControllerProvider>();
    return provider?.notifier;
  }
}

/// Extension per accesso rapido
extension LocaleContextExtension on BuildContext {
  LocaleController get localeController => LocaleControllerProvider.of(this);
}
