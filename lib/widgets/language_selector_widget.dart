import 'package:flutter/material.dart';
import '../controllers/locale_controller.dart';

/// Widget compatto per cambio lingua istantaneo.
/// Mostra una bandiera con dropdown per selezionare la lingua.
class LanguageSelectorWidget extends StatelessWidget {
  final bool showLabel;

  const LanguageSelectorWidget({super.key, this.showLabel = false});

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
      onSelected: (locale) => localeController.setLocale(locale.languageCode),
    );
  }
}

/// Toggle button compatto IT/EN per switch rapido.
class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = LocaleControllerProvider.of(context);

    return IconButton(
      tooltip: 'IT / EN',
      icon: Text(
        localeController.getFlagEmoji(localeController.locale),
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: () => localeController.toggleLocale(),
    );
  }
}
