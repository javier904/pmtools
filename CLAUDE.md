# CLAUDE.md - Agile Tools

## Progetto

**Agile Tools** è uno spinoff standalone del PMO Dashboard, contenente solo due strumenti:
1. **Matrice Eisenhower** - Prioritizzazione per urgenza/importanza
2. **Estimation Room** - Sessioni di stima collaborative (ex Planning Poker)

## Firebase

- **Project ID**: `pm-agile-tools-app`
- **Hosting**: https://pm-agile-tools-app.web.app/
- **Auth**: Google + Email/Password
- **Database**: Firestore (eur3)

## Stato Progetto

Il progetto è stato inizializzato ma **non ancora completato**. I file sono stati copiati dal PMO Dashboard e devono essere puliti.

**Vedi**:
- `TODO.md` per la lista completa delle attività
- `documentation/SPINOFF_PLAN.md` per il piano dettagliato

## Comandi Principali

```bash
flutter pub get              # Installa dipendenze
flutterfire configure        # Genera firebase_options.dart
flutter analyze              # Trova errori
flutter build web --release  # Build produzione
firebase deploy --only hosting  # Deploy
```

## Struttura

```
lib/
├── main.dart                    ✅ Creato
├── firebase_options.dart        ❌ Da generare
├── screens/
│   ├── home_screen.dart         ✅ Creato
│   ├── login_screen.dart        ✅ Creato
│   ├── eisenhower_screen.dart   ⚠️ Da pulire
│   └── estimation_room_screen.dart  ⚠️ Da pulire
├── widgets/
│   ├── eisenhower/              ⚠️ Da verificare
│   └── estimation_room/         ⚠️ Da pulire
├── models/                      ⚠️ Da verificare
└── services/
    ├── auth_service.dart        ✅ Creato
    └── planning_poker_*.dart    ⚠️ Da pulire
```

## Cosa Pulire

I file copiati dal PMO Dashboard contengono riferimenti da rimuovere:

1. **Import non esistenti** (audit_log, team_model, project_model, etc.)
2. **Integrazione Gantt** (import task, sync stime)
3. **Dropdown progetti/team** nel form sessione
4. **Widget import_tasks_dialog.dart** (non applicabile)

## Priorità

1. `flutter pub get`
2. `flutterfire configure --project=pm-agile-tools-app`
3. Pulire `estimation_room_screen.dart`
4. Pulire `session_form_dialog.dart`
5. Verificare altri file
6. `flutter build web --release`
7. `firebase deploy --only hosting`

## Origine

Spinoff da: `/Users/leonardo.torella/Progetti/dashboard`
