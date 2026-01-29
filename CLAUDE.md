# CLAUDE.md - Agile Tools

## Progetto

**Keisen** (Agile Tools) è una webapp Flutter standalone per la gestione agile dei progetti, contenente:

1. **Smart Todo** - Liste collaborative con colonne Kanban personalizzabili e ruoli (Owner/Editor/Viewer)
2. **Matrice Eisenhower** - Prioritizzazione 4 quadranti con scoring automatico e integrazione RACI
3. **Estimation Room** - 7 modalità di stima (Fibonacci, T-Shirt, PERT, Dot Voting, Bucket, Decimale, Five Fingers)
4. **Retrospective Board** - 6 template (Start/Stop/Continue, Sailboat, 4Ls, Starfish, Mad/Sad/Glad, DAKI) con fasi gestite
5. **Agile Process Manager** - 3 framework (Scrum, Kanban, Hybrid) con backlog, sprint, burndown, velocity

## Firebase

- **Project ID**: `pm-agile-tools-app`
- **Hosting**: https://pm-agile-tools-app.web.app/
- **Auth**: Google + Email/Password
- **Database**: Firestore (eur3)

## Stato Progetto

Il progetto è **completamente funzionante** e deployed in produzione.

**Nome App**: Keisen
**Lingue Supportate**: Italiano (IT), English (EN), Français (FR), Español (ES)
**Tema**: Dark Mode / Light Mode (con rilevamento preferenza sistema)

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
│   ├── home_screen.dart               # Dashboard principale (preferiti, scadenze, ricerca)
│   ├── login_screen.dart              # Login Google/Email
│   ├── landing_screen.dart            # Landing page pre-login (marketing)
│   ├── profile_screen.dart            # Profilo utente completo
│   ├── eisenhower_screen.dart         # Matrice Eisenhower
│   ├── estimation_room_screen.dart    # Sessioni di stima (7 modalità)
│   ├── agile_process_screen.dart      # Lista progetti agili
│   ├── agile_project_detail_screen.dart # Dettaglio progetto (backlog, sprint, kanban)
│   ├── smart_todo/                    # Smart Todo module
│   │   ├── smart_todo_dashboard.dart  # Dashboard liste
│   │   ├── smart_todo_detail_screen.dart # Dettaglio lista Kanban
│   │   └── smart_todo_global_view.dart   # Vista globale cross-lista
│   ├── retrospective/                 # Retrospective module
│   │   ├── retro_global_dashboard.dart   # Dashboard retrospettive
│   │   └── retrospective_board_screen.dart # Board con fasi
│   ├── subscription/                  # Gestione abbonamento
│   └── legal/                         # GDPR, Privacy, Terms, Cookie
│
├── widgets/
│   ├── profile_menu_widget.dart       # Menu profilo per AppBar
│   ├── eisenhower/                    # Widget Eisenhower
│   ├── estimation_room/               # Widget Estimation Room
│   ├── retrospective/                 # Widget Retrospective (retro_list_widget)
│   ├── agile/                         # Widget Agile Process (20 widget files)
│   └── subscription/                  # Widget abbonamento (limit_reached_dialog, etc.)
│
├── models/
│   ├── user_profile/                  # Modelli gestione utente
│   ├── subscription/                  # Limiti abbonamento
│   ├── smart_todo/                    # TodoListModel, TodoTaskModel, TodoColumn
│   ├── agile_project_model.dart       # Progetto Agile (3 framework)
│   ├── agile_enums.dart               # 12 enum (Framework, Status, Priority, TeamRole, CoS, Swimlane, Audit...)
│   ├── user_story_model.dart          # User Story (7 stati, stima, CoS, tags)
│   ├── sprint_model.dart              # Sprint + SprintReview + Burndown + Standup
│   ├── team_member_model.dart         # Membro team (ruolo, capacita', skills, disponibilita')
│   ├── framework_features.dart        # Tab/feature toggle per framework + KanbanColumnConfig
│   ├── methodology_guide.dart         # Guide Scrum/Kanban/Hybrid localizzate
│   ├── retro_methodology_guide.dart   # Guide retro con coach tips
│   ├── audit_log_model.dart           # Audit trail (11 azioni, 5 entity types)
│   ├── estimation_mode.dart           # 7 modalita' di stima
│   ├── retrospective_model.dart       # Retrospettiva (6 template, fasi, icebreakers)
│   └── eisenhower_matrix_model.dart   # Matrice Eisenhower
│
├── services/
│   ├── auth_service.dart              # Autenticazione Firebase
│   ├── user_profile_service.dart      # Gestione profilo/abbonamenti/settings
│   ├── smart_todo_service.dart        # CRUD liste e task
│   ├── agile_firestore_service.dart   # CRUD progetti agili + stories/sprints/retro
│   ├── agile_audit_service.dart       # Audit logging automatico (11 azioni)
│   ├── agile_sheets_service.dart      # Export Google Sheets (5 fogli)
│   ├── agile_invite_service.dart      # Inviti team agile
│   ├── eisenhower_firestore_service.dart # CRUD matrici Eisenhower
│   ├── planning_poker_firestore_service.dart # CRUD sessioni stima
│   ├── retrospective_firestore_service.dart  # CRUD retrospettive
│   ├── subscription/                  # Limiti, Stripe, Ads
│   │   └── subscription_limits_service.dart  # Check limiti + validateServerSide()
│   ├── invite/                        # Servizi inviti per tool
│   ├── search_service.dart            # Ricerca globale
│   ├── favorites_service.dart         # Preferiti
│   └── deadline_service.dart          # Scadenze
│
├── l10n/                              # Localizzazione
│   ├── app_it.arb                     # Italiano (template con @metadata)
│   ├── app_en.arb                     # English
│   ├── app_fr.arb                     # Français
│   └── app_es.arb                     # Español
│
└── themes/
    ├── app_theme.dart                 # Definizione temi light/dark
    └── app_colors.dart                # Palette colori

functions/
├── src/index.ts                       # Cloud Functions (Stripe + validateCreationLimit)
├── package.json                       # Dipendenze Node.js
└── tsconfig.json                      # Config TypeScript
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

| Piano | Prezzo | Entità/tipo | Task/entità | Inviti/entità | API | Priority Support |
|-------|--------|-------------|-------------|---------------|-----|-----------------|
| Free | €0 | 5 | 50 | 10 | ❌ | ❌ |
| Premium | €4.99/m o €39.99/y | 30 | 100 | 15 | ❌ | ❌ |
| Elite | €7.99/m o €69.99/y | ∞ | ∞ | ∞ | ✅ | ✅ |

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
├── participants: {escapedEmail: TeamMemberModel}
│   └── TeamMemberModel: { email, name, participantRole, teamRole, capacity, skills }
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

### Sistema Permessi Scrum-Compliant

Il sistema utilizza **due ruoli complementari** per ogni partecipante (Scrum Guide 2020):

| Tipo Ruolo | Enum | Valori | Scopo |
|------------|------|--------|-------|
| **Accesso** | `AgileParticipantRole` | owner, admin, member, viewer | Controllo accesso base |
| **Funzionale** | `TeamRole` | productOwner, scrumMaster, developer, designer, qa, stakeholder | Permessi Scrum specifici |

### Matrice Permessi per TeamRole

| Azione | Product Owner | Scrum Master | Dev Team | Stakeholder |
|--------|:-------------:|:------------:|:--------:|:-----------:|
| **Backlog** |
| Creare Stories | ✅ | ❌ | ❌ | ❌ |
| Modificare Stories | ✅ | ❌ | ❌ | ❌ |
| Eliminare Stories | ✅ | ❌ | ❌ | ❌ |
| Prioritizzare Backlog | ✅ | ❌ | ❌ | ❌ |
| **Sprint** |
| Creare Sprint | ❌ | ✅ | ❌ | ❌ |
| Avviare Sprint | ❌ | ✅ | ❌ | ❌ |
| Completare Sprint | ❌ | ✅ | ❌ | ❌ |
| Configurare WIP Limits | ❌ | ✅ | ❌ | ❌ |
| **Stima & Sviluppo** |
| Stimare Story Points | ❌ | ❌ | ✅ | ❌ |
| Definire Stima Finale | ✅ | ❌ | ❌ | ❌ |
| Spostare proprie stories | ✅ | ✅ | ✅ | ❌ |
| Spostare qualsiasi story | ✅ | ✅ | ❌ | ❌ |
| Auto-assegnarsi | ❌ | ❌ | ✅ | ❌ |
| Assegnare altri | ✅ | ❌ | ❌ | ❌ |
| **Team** |
| Invitare membri | ✅ | ✅ | ❌ | ❌ |
| Rimuovere membri | ✅ | ❌ | ❌ | ❌ |
| Cambiare ruoli | ✅ | ❌ | ❌ | ❌ |
| **Retrospective** |
| Facilitare Retro | ❌ | ✅ | ❌ | ❌ |
| Partecipare Retro | ✅ | ✅ | ✅ | ❌ |

### Implementazione Tecnica

**File chiave:**
- `lib/models/agile_enums.dart` - Helper methods per TeamRole (canCreateStory, canManageSprints, etc.)
- `lib/models/agile_project_model.dart` - Metodi permesso combinati (accesso + funzionale)
- `lib/screens/agile_project_detail_screen.dart` - Controlli UI permission-aware

**Pattern di utilizzo:**
```dart
// Verifica permesso specifico
if (project.canCreateStory(userEmail)) {
  // Mostra pulsante "Nuova Story"
}

// Verifica ruolo
if (project.isProductOwner(userEmail)) {
  // Logica PO-specific
}

// Verifica appartenenza gruppo
if (project.isDevelopmentTeam(userEmail)) {
  // Logica Dev Team
}
```

**Logica combinata:**
```dart
// AgileProjectModel.canCreateStory()
bool canCreateStory(String email) {
  final p = participants[email];
  if (p == null) return false;
  // ENTRAMBI i controlli devono passare:
  // 1. Accesso: canEdit (owner, admin, member)
  // 2. Funzionale: teamRole.canCreateStory (solo PO)
  return p.participantRole.canEdit && p.teamRole.canCreateStory;
}
```

### Traduzioni Permessi

Chiavi di traduzione disponibili (IT, EN, ES, FR):
- `scrumPermBacklogTitle/Desc` - Descrizione permessi backlog
- `scrumPermSprintTitle/Desc` - Descrizione permessi sprint
- `scrumPermDenied*` - Messaggi diniego accesso (per future UI con feedback)
- `scrumRole*` - Nomi ruoli localizzati

## Agile Process Manager - Funzionalita' Avanzate

### Sprint Review (Scrum Guide 2020)

Il sistema implementa Sprint Review come evento separato (non solo campo in SprintModel):

**Modelli** (`lib/models/sprint_model.dart`):
- `SprintReview`: data, conductor, attendees, demo notes, stakeholder feedback, backlog updates, next sprint focus, metrics
- `ReviewAttendee`: email, name, role (po/sm/dev/stakeholder/guest), isPresent
- `StoryReviewOutcome`: storyId, title, outcome (approved/needsRefinement/rejected), notes, storyPoints
- `ReviewDecision`: type (actionItem/backlogChange/scopeChange/technical/business), description, assignee, dueDate, isCompleted

**Widget**: `lib/widgets/agile/sprint_review_history_widget.dart` (~400 righe)
**Dialog**: 4 tab (Demo, Evaluation, Decisions, Summary)

### Kanban Advanced Features

#### Swimlanes (`lib/models/agile_enums.dart`)
```dart
enum SwimlaneType { none, classOfService, assignee, priority, tag }
```
Implementato in `kanban_board_widget.dart` con raggruppamento dinamico delle stories.

#### Column Policies (Kanban Practice #4)
```dart
// In KanbanColumnConfig (framework_features.dart)
final List<String> policies; // Es: "Max 24h in questa colonna", "Richiede code review"
```
Visualizzazione policies nel header colonna Kanban board.

#### Class of Service (`lib/models/agile_enums.dart`)
```dart
enum ClassOfService { standard, expedite, fixedDate, intangible }
```
- `standard`: Lavoro normale FIFO (blu)
- `expedite`: Urgente, puo' eccedere WIP limits (rosso)
- `fixedDate`: Deadline immobile (viola)
- `intangible`: Debito tecnico, no valore business immediato (grigio)

### Audit Logging

Sistema completo di tracciamento modifiche per progetti agili:

**Modello** (`lib/models/audit_log_model.dart`):
- 11 azioni: create, update, delete, move, estimate, assign, complete, start, close, invite, join, leave
- 5 entity types: project, story, sprint, team, retrospective
- Traccia: performer, timestamp, previous/new values, changed fields

**Servizio** (`lib/services/agile_audit_service.dart`):
- Fire-and-forget logging su subcollection `agile_projects/{projectId}/audit_logs/`
- Automaticamente chiamato da AgileFirestoreService

**Widget** (`lib/widgets/agile/audit_log_viewer.dart`):
- Accessibile da icona `Icons.history` nella toolbar del progetto
- Filtri per tipo azione, entity type, utente, data

### Methodology Guides

**File**: `lib/models/methodology_guide.dart`

Guide localizzate (IT/EN/FR/ES) per ogni framework:

| Framework | Sezioni | Best Practices | Anti-Patterns | FAQ |
|-----------|---------|----------------|---------------|-----|
| Scrum | Ruoli, Eventi, Artefatti, Story Points | 8+ | 8+ | 4+ |
| Kanban | 6 Principi, Board, WIP, Metriche, Cadenze, Swimlanes, Policies | 8+ | 8+ | 4+ |
| Hybrid | Da Scrum, Da Kanban, Planning on-demand, Quando usare | 8+ | 8+ | 4+ |

**Widget**: `lib/widgets/agile/methodology_guide_dialog.dart`
Accessibile da icona help nella toolbar del progetto.

### Team Capacity (Dual-View)

**Widget**: `lib/widgets/agile/team_capacity_widget.dart` (~847 righe)

Due modalita' di visualizzazione:
1. **Scrum Standard View**: Velocity, Throughput, Story Points/Sprint suggeriti
2. **Hours View**: Ore disponibili per membro, ore assegnate, utilization %

**Configurazione per membro** (`lib/models/team_member_model.dart`):
- `capacityHoursPerDay`: ore lavorative giornaliere (default 8)
- `skills`: lista competenze per skill matrix
- `unavailableDates`: periodi indisponibilita' (ferie/festivita') come List<DateRange>

**Widget correlati**:
- `lib/widgets/agile/skill_matrix_widget.dart` - Matrice competenze team
- `lib/widgets/agile/capacity_chart_widget.dart` - Grafici capacita'

### Google Sheets Export

**Servizio**: `lib/services/agile_sheets_service.dart`

Esporta 5 fogli formattati:
1. **Product Backlog**: tutte le stories con metadati
2. **Sprint Planning**: timeline sprint e allocazione stories
3. **Team & Capacity**: roster team con skills e capacita'
4. **Retrospective**: items retro e action items
5. **Metriche**: metriche aggregate

Usa Google Sheets API v4 + Drive API v3. Richiede Google Sign-In.

### Story Workflow (7 Stati)

```
backlog → refinement → ready → inSprint → inProgress → inReview → done
```

Lo stato `refinement` (grooming) e' stato aggiunto per tracciare le stories in fase di raffinamento prima di essere marcate come "ready".

### Widget Agile Completi

```
lib/widgets/agile/
├── backlog_list_widget.dart          # Product Backlog con drag-drop
├── story_card_widget.dart            # Card singola story
├── story_form_dialog.dart            # Form creazione/modifica story (3 tab)
├── story_detail_dialog.dart          # Dettaglio story
├── story_estimation_dialog.dart      # Interfaccia stima
├── kanban_board_widget.dart          # Board Kanban con swimlanes e policies
├── sprint_widgets.dart               # Sprint list, card, planning
├── sprint_review_history_widget.dart # Storico Sprint Review
├── team_list_widget.dart             # Roster team con ruoli e status
├── team_member_form_dialog.dart      # Form membro team
├── team_capacity_widget.dart         # Capacita' dual-view
├── skill_matrix_widget.dart          # Matrice competenze
├── burndown_chart_widget.dart        # Burndown + Velocity charts
├── capacity_chart_widget.dart        # Grafici capacita'
├── metrics_dashboard_widget.dart     # Dashboard metriche KPI
├── audit_log_viewer.dart             # Viewer audit trail
├── methodology_guide_dialog.dart     # Guide metodologiche
├── setup_checklist_widget.dart       # Checklist setup progetto
├── participant_invite_dialog.dart    # Inviti team
└── agile_project_form_dialog.dart    # Form creazione progetto
```

### Servizi Agile Completi

```
lib/services/
├── agile_firestore_service.dart      # CRUD progetti, stories, sprints, retro
├── agile_audit_service.dart          # Audit logging automatico
├── agile_sheets_service.dart         # Export Google Sheets
└── agile_invite_service.dart         # Gestione inviti team
```

### Firestore Structure Agile

```
agile_projects/{projectId}
├── name, description, framework, participants, kanbanColumns, ...
├── stories/{storyId}        # User Stories
├── sprints/{sprintId}       # Sprint con burndown, review, standup
├── retrospectives/{retroId} # Retrospettive con template
└── audit_logs/{logId}       # Audit trail
agile_invites/{inviteId}     # Inviti team
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
'/retro'           → RetroGlobalDashboard
'/subscription'    → SubscriptionScreen
'/invite/:tool/:id' → Deep link inviti
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
| `validateCreationLimit` | Callable | Validazione server-side limiti creazione entità |

### Server-Side Limit Validation

La Cloud Function `validateCreationLimit` fornisce un double-check server-side:

```typescript
// Input: { entityType: 'estimation' | 'eisenhower' | 'smart_todo' | 'retrospective' | 'agile_project' }
// Output: { allowed: boolean, currentCount: number, limit: number, tier: string }

// Limiti per tier:
// free: 5 per tipo | premium: 30 per tipo | elite: illimitato
```

**Flusso client**: check client-side → check server-side → mostra dialog creazione

**Fail-open**: Se la Cloud Function non è raggiungibile (es. piano Spark), il client permette l'operazione. Il check client-side resta come prima linea di difesa.

**Nota**: Richiede piano Blaze per il deploy (`firebase deploy --only functions`).

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

## UI Card Uniformity System

### Pattern Icone (26x26 container)

Tutte le card dei tool seguono lo stesso pattern visivo:

```dart
Container(
  width: 26,
  height: 26,
  decoration: BoxDecoration(
    color: iconColor.withOpacity(0.15),
    borderRadius: BorderRadius.circular(6),
  ),
  child: Icon(iconData, color: iconColor, size: 14),
)
```

### Icone per Tool

| Tool | Icona Primaria | Icona Secondaria | Logica |
|------|---------------|-----------------|--------|
| Smart Todo | `Icons.check_circle` (verde) | `Icons.checklist` (blu) | Tutto completato vs incompleto |
| Retrospective | Template icon (rosa) + dot stato 7x7 | - | Verde=completata, arancione=attiva, grigio=pending |
| Agile Process | Framework icon (blue) + dot sprint 7x7 | - | Verde=sprint attivo, grigio=nessuno |
| Estimation Room | `Icons.casino` (teal) + dot stato 7x7 | - | Verde=attiva, grigio=completata |
| Eisenhower | `Icons.grid_4x4` (indigo) + dot stato 7x7 | - | Colore quadrante dominante |

### Smart Todo - Criterio Completamento

Il completamento si basa sulla colonna `isDone`:

```dart
final doneColumnIds = list.columns
    .where((c) => c.isDone)  // Colonne con flag isDone=true
    .map((c) => c.id)
    .toSet();

// Il task è completato se il suo statusId è in una colonna isDone
doneColumnIds.contains(task.statusId);
```

### Dimensioni Card

`childAspectRatio: 2.5` in tutti i GridView (riduzione 50% altezza rispetto a 1.25).

### Rich Tooltips Partecipanti

Ogni card mostra un'icona `Icons.people` (18px) con tooltip ricco:

```
Smart Todo:    👑 Owner name + 👥 Participant name (per ogni partecipante)
Retrospective: 👑 Owner + 👥 Partecipante
Agile Process: 👑 Owner + ⭐ Product Owner + 🛡️ Scrum Master + 💻 Developer
```

---

## Localizzazione

### Configurazione

File: `l10n.yaml`
- Template: `app_it.arb` (file con @metadata)
- Output: `lib/l10n/`
- 4 lingue: IT, EN, FR, ES

### Rigenerazione

```bash
flutter gen-l10n
```

### Pattern di Utilizzo

```dart
final l10n = AppLocalizations.of(context);
Text(l10n?.smartTodoCompletionStats(completed, total) ?? '$completed/$total');
```

### File ARB

```
lib/l10n/
├── app_it.arb    # Template (con @metadata e placeholders)
├── app_en.arb    # English
├── app_fr.arb    # Français
└── app_es.arb    # Español
```

---

## Origine

Spinoff standalone da: `/Users/leonardo.torella/Progetti/dashboard` (PMO Dashboard)
