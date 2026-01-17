# CLAUDE.md - Agile Tools

## Progetto

**Agile Tools** è una webapp Flutter standalone per la gestione agile dei progetti, contenente:

1. **Matrice Eisenhower** - Prioritizzazione per urgenza/importanza
2. **Estimation Room** - Sessioni di stima collaborative (Planning Poker, T-Shirt, etc.)
3. **Agile Process Manager** - Gestione completa progetti agili (Backlog, Sprint, Kanban)
4. **Smart Todo** - Liste intelligenti e collaborative
5. **Retrospective Board** - Board per retrospettive di team

## Firebase

- **Project ID**: `pm-agile-tools-app`
- **Hosting**: https://pm-agile-tools-app.web.app/
- **Auth**: Google + Email/Password
- **Database**: Firestore (eur3)

## Stato Progetto

Il progetto è **completamente funzionante** e deployed in produzione.

## Comandi Principali

```bash
flutter pub get              # Installa dipendenze
flutter analyze              # Trova errori
flutter run -d chrome        # Test locale
flutter build web --release  # Build produzione
firebase deploy --only hosting  # Deploy
```

## Struttura Progetto

```
lib/
├── main.dart                          # Entry point con routing e theme
├── firebase_options.dart              # Configurazione Firebase
│
├── screens/
│   ├── home_screen.dart               # Dashboard principale
│   ├── login_screen.dart              # Login Google/Email
│   ├── landing_screen.dart            # Landing page pre-login
│   ├── profile_screen.dart            # Profilo utente completo
│   ├── eisenhower_screen.dart         # Matrice Eisenhower
│   ├── estimation_room_screen.dart    # Sessioni di stima
│   ├── agile_process_screen.dart      # Lista progetti agili
│   ├── agile_project_detail_screen.dart # Dettaglio progetto
│   ├── smart_todo/                    # Smart Todo module
│   └── retrospective/                 # Retrospective module
│
├── widgets/
│   ├── profile_menu_widget.dart       # Menu profilo per AppBar
│   ├── eisenhower/                    # Widget Eisenhower
│   ├── estimation_room/               # Widget Estimation Room
│   └── agile/                         # Widget Agile Process
│
├── models/
│   ├── user_profile/                  # Modelli gestione utente
│   │   ├── user_profile_model.dart    # Profilo utente
│   │   ├── subscription_model.dart    # Abbonamenti
│   │   └── user_settings_model.dart   # Impostazioni utente
│   ├── agile_project_model.dart       # Progetto Agile
│   ├── user_story_model.dart          # User Story
│   ├── sprint_model.dart              # Sprint
│   ├── retrospective_model.dart       # Retrospettiva
│   └── agile_enums.dart               # Enum condivisi
│
├── services/
│   ├── auth_service.dart              # Autenticazione Firebase
│   ├── user_profile_service.dart      # Gestione profilo/abbonamenti/settings
│   ├── agile_firestore_service.dart   # CRUD progetti agili
│   ├── eisenhower_firestore_service.dart # CRUD matrici Eisenhower
│   └── planning_poker_*.dart          # Servizi Estimation Room
│
└── themes/
    ├── app_theme.dart                 # Definizione temi light/dark
    └── app_colors.dart                # Palette colori
```

## Sistema Gestione Utente

### Architettura

Il sistema di gestione utente è progettato per essere **modulare e riutilizzabile** su altre webapp.

### Struttura Firestore

```
users/{userId}
├── email, displayName, firstName, lastName
├── company, jobTitle, bio
├── photoUrl, phoneNumber
├── status (active, suspended, pendingDeletion, deleted)
├── authProvider (email, google, apple, microsoft, github)
├── createdAt, updatedAt, lastLoginAt
├── deletionRequestedAt, deletionReason
│
├── subscription/
│   └── current
│       ├── plan (free, starter, pro, business, enterprise)
│       ├── status (active, trialing, pastDue, paused, cancelled, expired)
│       ├── billingCycle (monthly, quarterly, yearly, lifetime)
│       ├── startDate, endDate, trialEndDate
│       ├── price, currency
│       └── paymentMethodId, externalSubscriptionId
│
├── settings/
│   └── preferences
│       ├── themeMode (light, dark, system)
│       ├── locale (it, en)
│       ├── enableAnimations
│       ├── notifications
│       │   ├── emailNotifications, pushNotifications
│       │   ├── sprintReminders, sessionInvites
│       │   └── weeklyDigest, marketingEmails
│       ├── featureFlags
│       │   ├── calendarIntegration, googleSheetsExport
│       │   ├── betaFeatures, advancedMetrics
│       │   └── agileModule, eisenhowerModule, estimationModule
│       └── moduleSettings (per-module custom settings)
│
└── subscription_history/
    └── {historyId}
        ├── action (created, upgraded, downgraded, cancelled, etc.)
        ├── previousPlan, newPlan
        ├── previousStatus, newStatus
        └── createdAt, reason
```

### Piani Abbonamento

| Piano | Prezzo/mese | Trial | Descrizione |
|-------|-------------|-------|-------------|
| Free | €0 | - | Funzionalità base |
| Starter | €9.99 | 7gg | Piccoli team |
| Pro | €19.99 | 14gg | Professionisti |
| Business | €49.99 | 14gg | Aziende |
| Enterprise | €99.99 | 30gg | Grandi organizzazioni |

### Componenti UI

- **ProfileScreen**: Schermata completa con sezioni espandibili per profilo, abbonamento, impostazioni, notifiche, feature flags e danger zone
- **ProfileMenuWidget**: Menu dropdown per AppBar con avatar, info utente, toggle tema e logout

### Uso nei Widget

```dart
// Ottenere dati utente
final service = UserProfileService();
final data = await service.getAllUserData();
// data.profile, data.subscription, data.settings

// Verificare feature flag
final enabled = await service.isFeatureEnabled('calendarIntegration');

// Aggiornare tema
await service.updateTheme(ThemePreference.dark);

// Toggle feature flag
await service.toggleFeatureFlag('betaFeatures', true);
```

## Agile Process Manager

### Struttura Firestore

```
agile_projects/{projectId}
├── name, description, createdBy
├── framework (scrum, kanban, hybrid)
├── sprintDurationDays, workingHoursPerDay
├── participants: {escapedEmail: role}
├── activeSprintId
│
├── stories/{storyId}
│   ├── title, description
│   ├── status (backlog, ready, inSprint, inProgress, review, done)
│   ├── priority (must, should, could, wont)
│   ├── storyPoints, businessValue
│   └── assigneeEmail, tags, acceptanceCriteria
│
├── sprints/{sprintId}
│   ├── name, goal
│   ├── startDate, endDate
│   ├── status (planning, active, review, completed)
│   ├── storyIds, plannedPoints, completedPoints
│   └── velocity, burndownData
│
└── retrospectives/{retroId}
    ├── sprintId
    ├── wentWell, toImprove, actionItems
    └── sentimentVotes, averageSentiment
```

## Temi e Stile

L'app supporta **dark mode** e **light mode** con toggle manuale:

- Colori primari: Teal/Blue gradient
- Surface colors adattivi per tema
- Bordi e ombre coerenti
- Font: System default

### Pattern UI Comuni

```dart
// Accesso al tema
final isDark = context.isDarkMode;
final bgColor = context.backgroundColor;
final textColor = context.textPrimaryColor;

// Toggle tema
final themeController = ThemeControllerProvider.of(context);
themeController.toggleTheme();
```

## Routes

```dart
'/login'           → LoginScreen
'/home'            → HomeScreen
'/profile'         → ProfileScreen
'/eisenhower'      → EisenhowerScreen
'/estimation-room' → EstimationRoomScreen
'/agile-process'   → AgileProcessScreen
'/smart-todo'      → SmartTodoDashboard
```

## Origine

Spinoff standalone da: `/Users/leonardo.torella/Progetti/dashboard` (PMO Dashboard)
