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

---

## Sistema Abbonamenti (Stripe + AdSense)

### Architettura

Sistema modulare per gestione abbonamenti con 3 tier:

| Tier | Prezzo | Trial | Progetti | Liste | Task/entity | Inviti/entity | Ads |
|------|--------|-------|----------|-------|-------------|---------------|-----|
| **Free** | €0 | - | 5 | 5 | 50 | 10 | Si |
| **Premium** | €4.99/m o €39.99/y | 7gg | 30 | 30 | 100 | 15 | No |
| **Elite** | €7.99/m o €69.99/y | 14gg | ∞ | ∞ | ∞ | ∞ | No |

### Struttura File

```
lib/
├── models/subscription/
│   └── subscription_limits_model.dart    # SubscriptionLimits, LimitCheckResult, LimitExceededException
│
├── services/subscription/
│   ├── subscription_limits_service.dart  # Controllo e enforcement limiti
│   ├── stripe_payment_service.dart       # Integrazione Stripe checkout/portal
│   └── ads_service.dart                  # Google AdSense per Web
│
├── widgets/subscription/
│   ├── plan_card_widget.dart             # Card piano + PlansComparisonWidget
│   ├── limit_reached_dialog.dart         # Dialog limite + LimitExceptionHandler
│   ├── usage_meter_widget.dart           # Barre utilizzo + UsageSummaryWidget
│   └── ad_banner_widget.dart             # Banner AdSense + ConditionalAdBanner
│
└── screens/subscription/
    └── subscription_screen.dart          # Schermata gestione (3 tabs)

functions/
├── src/index.ts                          # Cloud Functions Stripe
├── package.json                          # Dipendenze Node.js
└── tsconfig.json                         # Config TypeScript
```

### Firestore Structure

```
stripe_customers/{userId}/
├── stripeId: "cus_xxx"
├── checkout_sessions/{sessionId}/
│   ├── price: "price_xxx"
│   └── url: "https://checkout.stripe.com/..."
├── subscriptions/{subscriptionId}/
│   ├── status: "active"
│   └── current_period_end: timestamp
└── payments/{paymentId}/
    ├── amount: 499
    └── status: "succeeded"

users/{userId}/subscription/current/
├── plan: "premium"
├── status: "active"
├── externalSubscriptionId: "sub_xxx"
├── startDate, endDate, trialEndDate
└── ...
```

### Servizi Modificati (Limit Checks)

I seguenti servizi includono check limiti automatici:

| Servizio | Metodi con limite |
|----------|-------------------|
| `eisenhower_firestore_service.dart` | `createMatrix()`, `createActivity()` |
| `planning_poker_firestore_service.dart` | `createSession()`, `createStory()` |
| `smart_todo_service.dart` | `createList()`, `createTask()` |
| `eisenhower_invite_service.dart` | `createInvite()` |
| `planning_poker_invite_service.dart` | `createInvite()` |
| `smart_todo_invite_service.dart` | `createInvite()` |

### Pattern di Utilizzo

```dart
// Verificare limite prima di creare
final limitsService = SubscriptionLimitsService();
final result = await limitsService.canCreateProject(userEmail);
if (!result.allowed) {
  // Mostra dialog upgrade
  await LimitReachedDialog.show(context: context, limitResult: result, entityType: 'project');
}

// Enforcement automatico (lancia eccezione)
try {
  await limitsService.enforceProjectLimit(userEmail);
  // Procedi con creazione
} on LimitExceededException catch (e) {
  // Gestisci limite raggiunto
}

// Mostrare banner ads condizionali
ConditionalAdBanner(
  position: AdBannerPosition.bottom,
  child: YourScreenContent(),
)

// Usage summary
final summary = await limitsService.getUsageSummary(userEmail);
// summary.projectsUsed, summary.listsUsed, summary.limits
```

### Cloud Functions

| Funzione | Tipo | Descrizione |
|----------|------|-------------|
| `stripeWebhook` | HTTP | Gestisce eventi subscription.*, invoice.*, trial_will_end |
| `createPortalSession` | Callable | Crea sessione Stripe Billing Portal |
| `syncSubscriptionStatus` | Callable | Sync manuale status subscription |
| `checkTrialExpirations` | Scheduled | Check giornaliero trial in scadenza (9:00) |

### Configurazione Richiesta

Prima dell'attivazione, configurare:

1. **Stripe Dashboard**: Creare prodotti/prezzi con IDs:
   - `price_premium_monthly`, `price_premium_yearly`
   - `price_elite_monthly`, `price_elite_yearly`

2. **AdSense**: Aggiornare `AdsService.adClientId` con il proprio Client ID

3. **Firebase Config**: Chiavi Stripe in environment variables

4. **Routes**: Aggiungere `/subscription` in main.dart

### Politica Rimborsi

**No-Refund Policy**: Cancellazione possibile in qualsiasi momento, accesso attivo fino a fine periodo pagato.

---

## Sistema Inviti Unificato

### Architettura

Il sistema di inviti è progettato per essere **consistente** tra tutti i tool, con:

1. **Modelli specifici per tool** - Ogni tool ha il proprio `*InviteModel`
2. **Servizi dedicati** - Ogni tool ha il proprio `*InviteService`
3. **Aggregatore unificato** - `InviteAggregatorService` combina tutti gli inviti
4. **Modello unificato** - `UnifiedInviteModel` per visualizzazione uniforme

### Tool Supportati

| Tool | Collection | Modello | Servizio | Ruoli |
|------|------------|---------|----------|-------|
| Eisenhower | `eisenhower_invites` | `EisenhowerInviteModel` | `EisenhowerInviteService` | facilitator, voter, observer |
| Estimation Room | `planning_poker_sessions/{id}/invites` | `PlanningPokerInviteModel` | `PlanningPokerInviteService` | facilitator, voter, observer |
| Agile Project | `agile_projects/{id}/invites` | `AgileInviteModel` | `AgileInviteService` | owner, admin, member, viewer |
| Smart Todo | `smart_todo_lists/{id}/invites` | `TodoInviteModel` | `SmartTodoInviteService` | owner, editor, viewer |
| Retrospective | `retro_invites` | `RetroInviteModel` | `RetroInviteService` | facilitator, participant, observer |

### Struttura Firestore Inviti

```
{collection}_invites/{inviteId}
├── {parentId}: String          # matrixId, sessionId, projectId, listId, boardId
├── email: String               # Email invitato (lowercase)
├── role: String                # Ruolo assegnato
├── status: String              # pending, accepted, declined, expired, revoked
├── token: String               # Token univoco 32 chars
├── invitedBy: String           # Email di chi ha invitato
├── invitedByName: String       # Nome di chi ha invitato
├── invitedAt: Timestamp
├── expiresAt: Timestamp
├── acceptedAt: Timestamp?
├── declinedAt: Timestamp?
└── declineReason: String?
```

### Flusso Inviti

```
1. CREAZIONE
   Owner/Facilitator → createInvite() → Firestore + pendingEmails + Email

2. RICEZIONE
   Invitato riceve email con deep link → /invite/{tool}/{entityId}

3. VISUALIZZAZIONE
   InviteAggregatorService.streamAllPendingInvites() → Lista unificata in HomeScreen

4. ACCETTAZIONE
   acceptInvite() → status='accepted' + aggiunge a participantEmails + rimuove da pendingEmails

5. VISIBILITA'
   L'entità diventa visibile nelle query che usano arrayContains('participantEmails', email)
```

### Componenti UI

| Componente | Descrizione |
|------------|-------------|
| `InvitesSummaryWidget` | Mostra inviti pendenti nella HomeScreen |
| `InviteDetailDialog` | Dettaglio invito con azioni accept/decline |
| `*ParticipantInviteDialog` | Dialog per creare inviti (uno per tool) |

### Deep Links

```
/invite/eisenhower/{matrixId}
/invite/estimation-room/{sessionId}
/invite/agile/{projectId}
/invite/smart-todo/{listId}
/invite/retro/{boardId}
```

### Pattern di Utilizzo

```dart
// Creare un invito
final inviteService = RetroInviteService();
final invite = await inviteService.createInvite(
  boardId: retroId,
  email: 'user@example.com',
  role: RetroParticipantRole.participant,
);

// Inviare email (richiede Gmail API)
await inviteService.sendInviteEmail(
  invite: invite,
  retroTitle: 'Sprint 42 Retro',
  baseUrl: 'https://pm-agile-tools-app.web.app',
  senderEmail: currentUserEmail,
  gmailApi: gmailApi,
);

// Stream inviti pendenti per utente corrente
InviteAggregatorService().streamAllPendingInvites().listen((invites) {
  // Aggiorna UI con lista inviti
});

// Accettare un invito
final success = await InviteAggregatorService().acceptInvite(invite);
```

### Firestore Indexes Richiesti

```json
{
  "collectionGroup": "invites",
  "queryScope": "COLLECTION_GROUP",
  "fields": [
    { "fieldPath": "email", "order": "ASCENDING" },
    { "fieldPath": "status", "order": "ASCENDING" }
  ]
}
```

### Visibilità Post-Accettazione

Quando un utente accetta un invito:

1. L'utente viene aggiunto al campo `participantEmails` dell'entità
2. Le query dei servizi (es. `streamUserRetrospectives`) usano `arrayContains` su `participantEmails`
3. L'entità diventa automaticamente visibile nella dashboard dell'utente
4. L'utente può interagire con il ruolo assegnato

### Limite Inviti per Abbonamento

Gli inviti sono soggetti ai limiti dell'abbonamento:

| Tier | Inviti per entità |
|------|-------------------|
| Free | 10 |
| Premium | 15 |
| Elite | Illimitati |

---

## Origine

Spinoff standalone da: `/Users/leonardo.torella/Progetti/dashboard` (PMO Dashboard)
