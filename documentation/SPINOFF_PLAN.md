# Agile Tools - Piano Spinoff

## Obiettivo

Creare un'applicazione web standalone con due strumenti collaborativi:
1. **Matrice Eisenhower** - Prioritizzazione attività per urgenza/importanza
2. **Estimation Room** - Sessioni di stima collaborative multi-metodo (ex Planning Poker)

Questa app è uno spinoff del PMO Dashboard, completamente **slegata** dal sistema originale.

---

## Firebase Project

- **Nome progetto**: `pm-agile-tools-app`
- **Hosting URL**: https://pm-agile-tools-app.web.app/
- **Database**: Firestore (default)
- **Authentication**: Google + Email/Password

---

## Architettura

### Struttura Cartelle

```
agile_tools/
├── lib/
│   ├── main.dart                         ✅ CREATO
│   ├── firebase_options.dart             ❌ DA GENERARE (flutterfire configure)
│   ├── screens/
│   │   ├── home_screen.dart              ✅ CREATO
│   │   ├── login_screen.dart             ✅ CREATO
│   │   ├── eisenhower_screen.dart        ⚠️ COPIATO - DA PULIRE
│   │   ├── estimation_room_screen.dart   ⚠️ COPIATO - DA PULIRE
│   │   └── planning_poker_invite_screen.dart  ⚠️ COPIATO - DA PULIRE
│   ├── widgets/
│   │   ├── eisenhower/                   ⚠️ COPIATI - DA VERIFICARE IMPORT
│   │   └── estimation_room/              ⚠️ COPIATI - DA VERIFICARE IMPORT
│   ├── models/                           ⚠️ COPIATI - DA VERIFICARE
│   ├── services/
│   │   ├── auth_service.dart             ✅ CREATO
│   │   ├── planning_poker_firestore_service.dart  ⚠️ COPIATO
│   │   └── planning_poker_invite_service.dart     ⚠️ COPIATO
│   └── utils/
├── documentation/
│   └── SPINOFF_PLAN.md                   ✅ QUESTO FILE
├── pubspec.yaml                          ✅ CONFIGURATO
└── TODO.md                               ✅ CREATO
```

---

## Cosa è stato RIMOSSO rispetto al PMO Dashboard

### Funzionalità NON presenti in Agile Tools

| Funzionalità | Motivo Rimozione |
|--------------|------------------|
| Import task da Gantt | Non esiste Gantt |
| Sync stime → Gantt | Database separato |
| Dropdown Progetti nel form sessione | Nessun progetto PMO |
| Dropdown Team/Business Unit | Sistema team semplificato |
| AuditLogService | Non necessario |
| Riferimenti a ProjectModel | Non esiste |
| Integrazione JIRA | Non applicabile |
| WBS Sync | Non applicabile |

### File del PMO Dashboard NON copiati

- Tutto il sistema Gantt (~18.500 righe)
- PMO Analytics (11 tab)
- Cost views
- Resource management
- JIRA integration
- WBS sync
- SAL sync
- Vacation system
- EVM/Control Points
- Admin panel
- ~120 altri file

---

## Modifiche da Apportare ai File Copiati

### 1. estimation_room_screen.dart

**Import da rimuovere:**
```dart
// RIMUOVERE:
import '../services/audit_log_service.dart';
import '../models/audit_log_model.dart';
// E qualsiasi altro import non esistente
```

**Codice da rimuovere:**
- `_showImportTasksDialog()` - import da Gantt
- `_checkAndOfferGanttSync()` - sync con Gantt
- `_showSyncEstimatesDialog()` - dialog sync
- Riferimenti a `AuditLogService`
- Riferimenti a progetti (`projectId`, `projectName`, `projectCode`)

**Import da aggiornare:**
```dart
// CAMBIARE DA:
import '../widgets/planning_poker/...';
// A:
import '../widgets/estimation_room/...';
```

### 2. session_form_dialog.dart

**Sezioni da RIMUOVERE completamente:**
- Dropdown Business Unit
- Dropdown Team
- Dropdown Progetto
- Caricamento `_loadIntegrationData()`
- Variabili `_teams`, `_businessUnits`, `_projects`
- Campi nel risultato: `teamId`, `teamName`, `businessUnitId`, `businessUnitName`, `projectId`, `projectName`, `projectCode`

**Da MANTENERE:**
- Nome sessione
- Descrizione
- Modalità stima (EstimationMode)
- Set di carte
- Opzioni (auto-reveal, observers)

### 3. eisenhower_screen.dart

**Verificare e rimuovere:**
- Eventuali import non esistenti
- Riferimenti a servizi del PMO Dashboard

### 4. Tutti i widget in estimation_room/

**Per ogni file, aggiornare:**
```dart
// DA:
import '../../models/planning_poker_session_model.dart';
// A:
import '../../models/planning_poker_session_model.dart';  // (stesso, ma verificare path)
```

### 5. import_tasks_dialog.dart

**Questo file va RIMOSSO o sostituito** con un dialog per:
- Import da CSV
- Import da testo (copia/incolla lista)

---

## Firestore Collections

### Struttura Nuova (Standalone)

```
firestore/
├── users/{odUserId}
│   ├── email: string
│   ├── displayName: string
│   ├── photoURL: string
│   └── createdAt: timestamp
│
├── eisenhower_matrices/{matrixId}
│   ├── title: string
│   ├── description: string
│   ├── createdBy: string (email)
│   ├── createdAt: timestamp
│   ├── updatedAt: timestamp
│   ├── participants: array<string>
│   └── activities: array<Activity>
│
├── estimation_sessions/{sessionId}
│   ├── name: string
│   ├── description: string
│   ├── createdBy: string (email)
│   ├── createdAt: timestamp
│   ├── status: string (draft|active|completed)
│   ├── estimationMode: string
│   ├── cardSet: array<string>
│   ├── allowObservers: boolean
│   ├── autoReveal: boolean
│   ├── participants: map
│   ├── participantEmails: array<string>
│   └── stories/ (subcollection)
│       └── {storyId}
│           ├── title: string
│           ├── description: string
│           ├── status: string
│           ├── votes: map
│           └── finalEstimate: string
│
└── invites/{inviteId}
    ├── sessionId: string
    ├── token: string
    ├── invitedEmail: string
    ├── invitedBy: string
    ├── status: string
    └── expiresAt: timestamp
```

---

## Comandi da Eseguire (dalla cartella agile_tools)

### 1. Installa dipendenze
```bash
flutter pub get
```

### 2. Configura Firebase
```bash
flutterfire configure --project=pm-agile-tools-app
```
Questo genera `lib/firebase_options.dart`

### 3. Build
```bash
flutter build web --release
```

### 4. Deploy
```bash
firebase deploy --only hosting
```

---

## Funzionalità Future (Opzionali)

- [ ] Import attività da CSV
- [ ] Import attività da testo incollato
- [ ] Export risultati in CSV/PDF
- [ ] Sistema workspace/team semplificato
- [ ] Pricing/Subscription con Stripe

---

## Note Tecniche

### Autenticazione
- Google Sign-In configurato per web (popup)
- Email/Password con registrazione
- Nessun sistema di ruoli (tutti gli utenti sono uguali)

### Database
- Firestore in modalità test (da configurare regole produzione)
- Location: eur3 (europe-west) per GDPR

### Hosting
- Firebase Hosting
- URL: https://pm-agile-tools-app.web.app/
