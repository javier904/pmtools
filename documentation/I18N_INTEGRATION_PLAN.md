# Piano di Integrazione i18n con Sistema Properties

## Panoramica

L'integrazione i18n si basa sul sistema `UserSettingsModel` esistente che già contiene:
- Campo `locale` (default: 'it')
- Sistema `moduleSettings` per configurazioni estese
- Sincronizzazione Firestore

---

## Architettura Proposta

```
┌────────────────────────────────────────────────────────────────────┐
│                         FLOW TRADUZIONE                            │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  UserSettingsModel.locale  ──► LocaleProvider ──► MaterialApp      │
│         ↓                                                          │
│  Firestore sync           ──► Real-time updates                    │
│                                                                    │
│  AppLocalizations.of(context)!.keyName                             │
│         ↓                                                          │
│  1. ARB locale (lib/l10n/app_{locale}.arb)                        │
│  2. Fallback: Italian                                              │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

---

## Fase 1: Setup Base i18n Flutter

### 1.1 Dipendenze (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true
```

### 1.2 Configurazione l10n (l10n.yaml)

```yaml
arb-dir: lib/l10n
template-arb-file: app_it.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
preferred-supported-locales:
  - it
  - en
nullable-getter: false
```

### 1.3 File ARB Base

**lib/l10n/app_it.arb** (Italiano - Default)
```json
{
  "@@locale": "it",
  "appTitle": "Agile Tools",
  "actionSave": "Salva",
  "actionCancel": "Annulla",
  ...
}
```

**lib/l10n/app_en.arb** (Inglese)
```json
{
  "@@locale": "en",
  "appTitle": "Agile Tools",
  "actionSave": "Save",
  "actionCancel": "Cancel",
  ...
}
```

---

## Fase 2: Integrazione con UserSettingsModel

### 2.1 LocaleProvider Service

**lib/services/locale_provider.dart**
```dart
import 'package:flutter/material.dart';
import '../models/user_profile/user_settings_model.dart';
import 'user_profile_service.dart';

class LocaleProvider extends ChangeNotifier {
  final UserProfileService _profileService;
  Locale _locale = const Locale('it');

  LocaleProvider(this._profileService) {
    _loadUserLocale();
  }

  Locale get locale => _locale;

  static const supportedLocales = [
    Locale('it'), // Italiano
    Locale('en'), // English
  ];

  Future<void> _loadUserLocale() async {
    final settings = await _profileService.getUserSettings();
    if (settings != null) {
      _locale = Locale(settings.locale);
      notifyListeners();
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    notifyListeners();

    // Sincronizza con Firestore
    await _profileService.updateUserSettings(
      (settings) => settings.copyWith(locale: languageCode),
    );
  }

  String getDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'it': return 'Italiano';
      case 'en': return 'English';
      default: return locale.languageCode;
    }
  }
}
```

### 2.2 Integrazione main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'services/locale_provider.dart';
import 'services/user_profile_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(UserProfileService()),
      child: const AgileToolsApp(),
    ),
  );
}

class AgileToolsApp extends StatelessWidget {
  const AgileToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'Agile Tools',
          locale: localeProvider.locale,
          supportedLocales: LocaleProvider.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // ... resto configurazione
        );
      },
    );
  }
}
```

---

## Fase 3: Widget Selezione Lingua

### 3.1 Language Selector Widget

**lib/widgets/language_selector_widget.dart**
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';

class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();

    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_getFlagEmoji(localeProvider.locale)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 16),
        ],
      ),
      tooltip: 'Lingua / Language',
      itemBuilder: (context) => LocaleProvider.supportedLocales.map((locale) {
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              Text(_getFlagEmoji(locale)),
              const SizedBox(width: 8),
              Text(localeProvider.getDisplayName(locale)),
              if (locale == localeProvider.locale)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.check, size: 16, color: Colors.green),
                ),
            ],
          ),
        );
      }).toList(),
      onSelected: (locale) => localeProvider.setLocale(locale.languageCode),
    );
  }

  String _getFlagEmoji(Locale locale) {
    switch (locale.languageCode) {
      case 'it': return '🇮🇹';
      case 'en': return '🇬🇧';
      default: return '🌍';
    }
  }
}
```

### 3.2 Integrazione in Profile Screen

```dart
// In profile_screen.dart - sezione impostazioni
ListTile(
  leading: const Icon(Icons.language),
  title: Text(AppLocalizations.of(context)!.settingsLanguage),
  subtitle: Text(localeProvider.getDisplayName(localeProvider.locale)),
  trailing: const LanguageSelectorWidget(),
),
```

---

## Fase 4: Pattern di Utilizzo

### 4.1 Uso Base nelle Schermate

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.eisenhowerTitle)),
      body: Column(
        children: [
          Text(l10n.eisenhowerNoMatrices),
          ElevatedButton(
            onPressed: () {},
            child: Text(l10n.actionCreate),
          ),
        ],
      ),
    );
  }
}
```

### 4.2 Traduzione Enum displayName

```dart
// Prima (hardcoded)
String get displayName {
  switch (this) {
    case StoryPriority.must: return 'Must Have';
    // ...
  }
}

// Dopo (localizzato)
String displayName(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  switch (this) {
    case StoryPriority.must: return l10n.priorityMust;
    case StoryPriority.should: return l10n.priorityShould;
    // ...
  }
}
```

### 4.3 Extension Helper

```dart
// lib/extensions/localization_extension.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

// Uso semplificato
Text(context.l10n.actionSave);
```

---

## Fase 5: Sincronizzazione Firestore (Opzionale)

### 5.1 Schema Firestore per Traduzioni Custom

```
app_config/
└── translations/
    ├── overrides_it/
    │   └── {key: "valore personalizzato"}
    └── overrides_en/
        └── {key: "custom value"}
```

### 5.2 Translation Override Service

```dart
class TranslationOverrideService {
  final FirebaseFirestore _firestore;

  Stream<Map<String, String>> streamOverrides(String locale) {
    return _firestore
        .collection('app_config')
        .doc('translations')
        .collection('overrides_$locale')
        .snapshots()
        .map((snapshot) => {
          for (final doc in snapshot.docs)
            doc.id: doc.data()['value'] as String
        });
  }
}
```

---

## Fase 6: Migrazione Graduale

### Step 1: Setup Infrastruttura
1. Aggiungere dipendenze
2. Creare l10n.yaml
3. Creare ARB files iniziali vuoti
4. Generare classi con `flutter gen-l10n`

### Step 2: Migrazione Stringhe Comuni
1. Migrare azioni comuni (Salva, Annulla, etc.)
2. Migrare stati comuni (Caricamento, Errore, etc.)
3. Verificare funzionamento base

### Step 3: Migrazione per Modulo
1. Eisenhower Screen
2. Estimation Room Screen
3. Agile Process Screen
4. Retrospective Dashboard
5. Smart Todo Screen
6. Profile Screen
7. Landing Screen

### Step 4: Integrazione Enum
1. Aggiornare tutti i displayName degli enum
2. Passare BuildContext dove necessario
3. Testare ogni enum

### Step 5: Test e Validazione
1. Test manuale IT/EN
2. Verifica coerenza traduzioni
3. Test sincronizzazione Firestore

---

## File da Modificare

### Priorità Alta
- `lib/main.dart` - Aggiungere provider e delegates
- `lib/screens/profile_screen.dart` - Aggiungere selector lingua
- `pubspec.yaml` - Aggiungere dipendenze

### Priorità Media
- `lib/screens/eisenhower_screen.dart` - ~50 stringhe
- `lib/screens/estimation_room_screen.dart` - ~40 stringhe
- `lib/screens/agile_process_screen.dart` - ~30 stringhe
- `lib/widgets/estimation_room/*.dart` - ~30 stringhe
- `lib/widgets/eisenhower/*.dart` - ~20 stringhe

### Priorità Bassa (Enum)
- `lib/models/agile_enums.dart` - 100+ displayName
- `lib/models/estimation_mode.dart` - ~15 displayName
- `lib/models/retrospective_model.dart` - ~30 displayName

---

## Stima Effort

| Fase | Ore Stimate |
|------|-------------|
| Setup Infrastruttura | 2h |
| ARB Files (350+ stringhe × 2 lingue) | 4h |
| LocaleProvider + Integration | 2h |
| Migrazione Screens | 6h |
| Migrazione Enum | 3h |
| Test e Fix | 2h |
| **Totale** | **~19h** |

---

## Note Implementative

### Compatibilità
- Mantenere retrocompatibilità con stringhe esistenti durante migrazione
- Usare fallback a italiano se traduzione mancante

### Performance
- Le traduzioni sono caricate in memoria all'avvio
- Nessun impatto runtime significativo
- Cache locale per override Firestore

### Manutenzione
- Usare `flutter gen-l10n` dopo ogni modifica ARB
- Mantenere sincronizzati i file IT/EN
- Documentare nuove chiavi nel catalogo

---

## Comandi Utili

```bash
# Generare classi localizzazione
flutter gen-l10n

# Verificare ARB validi
flutter analyze

# Test con locale specifico
flutter run --dart-define=LOCALE=en
```
