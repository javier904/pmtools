# Agile Tools - TODO

## Stato Attuale
- [x] Progetto Flutter creato
- [x] Firebase project creato (`pm-agile-tools-app`)
- [x] Authentication abilitato (Google + Email/Password)
- [x] Firestore creato
- [x] Hosting attivo
- [x] File copiati dal PMO Dashboard
- [x] pubspec.yaml configurato
- [x] auth_service.dart creato
- [x] main.dart creato
- [x] home_screen.dart creato
- [x] login_screen.dart creato
- [x] flutter pub get eseguito
- [x] firebase_options.dart generato
- [x] estimation_room_screen.dart pulito
- [x] session_form_dialog.dart pulito
- [x] eisenhower_screen.dart pulito
- [x] eisenhower_firestore_service.dart creato
- [x] Build web completato
- [x] Deploy su Firebase Hosting completato

---

## ATTIVITA' COMPLETATE

### 1. Configurazione Firebase
- [x] Eseguire `flutter pub get`
- [x] Generare firebase_options.dart con `flutterfire configure`
- [x] Configurare firebase.json per hosting

### 2. Pulizia estimation_room_screen.dart
- [x] Rinominare PlanningPokerScreen -> EstimationRoomScreen
- [x] Aggiornare import widget path da planning_poker/ a estimation_room/
- [x] Rimuovere import audit_log_service.dart e audit_log_model.dart
- [x] Rimuovere import googleapis/gmail e http
- [x] Rimuovere riferimenti a ImportTasksDialog
- [x] Rimuovere metodo _showImportTasksDialog()

### 3. Pulizia session_form_dialog.dart
- [x] Rimuovere import team_model, business_unit_model, project_model
- [x] Rimuovere variabili teams, businessUnits, projects
- [x] Rimuovere metodo _loadIntegrationData()
- [x] Rimuovere sezione UI "Integrazioni (opzionali)"
- [x] Rimuovere dal risultato _save() riferimenti a team, BU, project

### 4. Pulizia eisenhower_screen.dart
- [x] Rimuovere import non esistenti
- [x] Rimuovere riferimenti a servizi PMO
- [x] Rimuovere export Google Sheets

### 5. Creazione eisenhower_firestore_service.dart
- [x] Creare servizio standalone per matrici Eisenhower
- [x] Implementare metodi CRUD per matrici e attivita'
- [x] Implementare metodi per voti e partecipanti
- [x] Correggere firme metodi per compatibilita' con screen

### 6. Widget estimation_room/
- [x] Eliminare import_tasks_dialog.dart (non applicabile)
- [x] Verificare altri widget

### 7. Build & Deploy
- [x] flutter analyze - nessun errore
- [x] flutter build web --release
- [x] firebase deploy --only hosting

### 8. Sistema Gestione Utente (Profilo, Abbonamenti, Impostazioni)
- [x] Creare UserProfileModel (dati anagrafici, stato account, auth provider)
- [x] Creare SubscriptionModel (piani, stati, billing cycle, storico)
- [x] Creare UserSettingsModel (tema, notifiche, feature flags)
- [x] Creare UserProfileService (CRUD Firestore, cache, helper methods)
- [x] Creare ProfileScreen (profilo, abbonamento, impostazioni, danger zone)
- [x] Creare ProfileMenuWidget (dropdown menu per AppBar)
- [x] Integrare ProfileMenuWidget in HomeScreen
- [x] Aggiungere route /profile in main.dart

### 9. Agile Process Manager
- [x] Creare modelli (AgileProjectModel, UserStoryModel, SprintModel, etc.)
- [x] Creare AgileFirestoreService
- [x] Creare AgileProcessScreen (lista progetti)
- [x] Creare AgileProjectDetailScreen (tabs: backlog, sprint, kanban, etc.)
- [x] Implementare Product Backlog con drag & drop
- [x] Implementare Sprint Planning
- [x] Implementare Kanban Board
- [x] Implementare Retrospective Board
- [x] Implementare Metriche e Grafici (Velocity, Burndown)

### 10. Smart Todo
- [x] Creare SmartTodoDashboard
- [x] Implementare liste collaborative
- [x] Implementare filtri avanzati

### 11. Retrospective Board (Standalone)
- [x] Creare RetroGlobalDashboard
- [x] Implementare board con colonne (Went Well, To Improve, Actions)

### 12. Sistema Abbonamenti (Stripe + AdSense)
- [x] FASE 1: Creare subscription_limits_model.dart
- [x] FASE 1: Aggiornare subscription_model.dart (Free/Premium/Elite)
- [x] FASE 2: Creare subscription_limits_service.dart
- [x] FASE 3: Creare stripe_payment_service.dart
- [x] FASE 4: Creare ads_service.dart (Google AdSense Web)
- [x] FASE 5: Integrare check limiti nei servizi esistenti
  - [x] eisenhower_firestore_service.dart
  - [x] planning_poker_firestore_service.dart
  - [x] smart_todo_service.dart
  - [x] eisenhower_invite_service.dart
  - [x] planning_poker_invite_service.dart
  - [x] smart_todo_invite_service.dart
- [x] FASE 6: Creare Cloud Functions Stripe (functions/src/index.ts)
- [x] FASE 7: Creare UI widgets
  - [x] plan_card_widget.dart
  - [x] limit_reached_dialog.dart
  - [x] usage_meter_widget.dart
  - [x] ad_banner_widget.dart
- [x] FASE 7: Creare subscription_screen.dart

---

## URL Produzione

**Hosting URL**: https://pm-agile-tools-app.web.app

### 13. UI Card Uniformity & Riduzione Dimensioni
- [x] Ridurre childAspectRatio da 1.25 a 2.5 in tutti i tool (50% altezza)
- [x] Smart Todo: icona 26x26 con check_circle verde (tutto completato) / checklist blu
- [x] Smart Todo: progress bar real-time con streamTaskCompletionStats
- [x] Smart Todo: criterio completamento basato su colonne con isDone=true
- [x] Retrospective: icona 26x26 con template icon + dot stato 7x7
- [x] Agile Process: icona 26x26 con framework icon + dot sprint 7x7
- [x] Eisenhower: childAspectRatio aggiornato
- [x] Estimation Room: childAspectRatio aggiornato

### 14. Tooltip Ricchi Partecipanti
- [x] Smart Todo: tooltip con 👑 Owner + 👥 Participant
- [x] Retrospective: tooltip con 👑 Owner + 👥 Partecipante
- [x] Agile Process: tooltip con 👑 Owner + ⭐ PO + 🛡️ SM + 💻 Developer

### 15. Validazione Server-Side Limiti
- [x] Cloud Function validateCreationLimit (functions/src/index.ts)
- [x] Aggiunto cloud_functions package a pubspec.yaml
- [x] Metodo validateServerSide() in subscription_limits_service.dart
- [x] Integrazione server check in tutti e 5 gli screen di creazione
- [x] Fail-open: se Cloud Function non raggiungibile, permette operazione

### 16. Localizzazione 4 Lingue
- [x] Supporto IT, EN, FR, ES completo
- [x] Stringhe smartTodoCompletionStats, smartTodoCreatedDate, smartTodoParticipantRole
- [x] Stringhe subscription limits (subscriptionLimitRetrospectives, subscriptionLimitAgileProjects)

### 17. Fix Session Limits & Voting
- [x] Fix createdBy case mismatch nel conteggio sessioni
- [x] Fix voting mode lock (startVoting imposta status active)
- [x] LimitReachedDialog aggiunto a tutti i tool

### 18. Agile Process Manager - Funzionalita' Avanzate
- [x] Sprint Review Enhancement (Scrum Guide 2020 compliant)
  - [x] SprintReview model con attendees, story outcomes, decisions
  - [x] ReviewAttendee, StoryReviewOutcome, ReviewDecision classes
  - [x] sprint_review_history_widget.dart (400+ righe)
  - [x] Dialog sprint review a 4 tab (Demo, Evaluation, Decisions, Summary)
- [x] Kanban Advanced Features
  - [x] Swimlanes (ClassOfService, Assignee, Priority, Tag, None)
  - [x] Column Policies (Kanban Practice #4 - Make Policies Explicit)
  - [x] Class of Service enum (standard, expedite, fixedDate, intangible)
  - [x] SwimlaneType enum
- [x] Audit Logging completo
  - [x] agile_audit_service.dart (11 azioni: create/update/delete/move/estimate/assign/complete/start/close/invite/join/leave)
  - [x] audit_log_model.dart (entity types: project/story/sprint/team/retrospective)
  - [x] audit_log_viewer.dart (widget viewer)
- [x] Methodology Guides localizzate
  - [x] Scrum Guide (ruoli, eventi, artefatti, story points)
  - [x] Kanban Guide (6 principi, board, WIP, metriche, cadenze, swimlanes, policies)
  - [x] Hybrid/Scrumban Guide
  - [x] Best practices e anti-patterns per framework
  - [x] FAQ per framework
- [x] Team Capacity Widget (dual-view)
  - [x] Scrum Standard View: velocity, throughput, story points/sprint
  - [x] Hours View: ore disponibili, assegnate, utilization %
  - [x] Capacita' ore/giorno per membro
  - [x] Date indisponibilita' (ferie/festivita')
- [x] Skill Matrix Widget per team
- [x] Google Sheets Export (5 fogli: Backlog, Sprint Planning, Team & Capacity, Retrospective, Metriche)
- [x] Story status 'refinement' aggiunto al workflow (7 stati totali)
- [x] Setup Checklist Widget per onboarding progetti
- [x] Real-time online presence tracking per team members
- [x] Burndown + Velocity charts
- [x] Metrics Dashboard widget completo

### 19. Retrospective Board - Funzionalita' Avanzate
- [x] 6 template (Start/Stop/Continue, Mad/Sad/Glad, 4Ls, Sailboat, DAKI, Starfish)
- [x] Sistema fasi guidate (setup, icebreaker, writing, voting, discuss, completed)
- [x] Icebreakers (oneWord, weather, sentiment)
- [x] Timer per fasi
- [x] Retro Methodology Guide con coach tips
- [x] Online presence real-time
- [x] Voting system con maxVotesPerUser
- [x] Guided column-by-column workflow

### 20. Traduzioni Complete 4 Lingue
- [x] 0 untranslated messages su IT, EN, FR, ES
- [x] Traduzioni Agile Process (sprint review, swimlanes, policies, audit, methodology)
- [x] Traduzioni Retrospective (template, fasi, icebreakers)
- [x] Traduzioni Smart Todo (sorting, actions, audit)
- [x] Traduzioni Estimation Room e Eisenhower

---

## Attivita' Pendenti

### Deploy Cloud Functions (richiede piano Blaze)
- [ ] Upgrade progetto Firebase a piano Blaze
- [ ] `cd functions && npm install && npm run build`
- [ ] `firebase deploy --only functions`

### Configurazione Stripe Dashboard
- [ ] Creare prodotti/prezzi in Stripe:
  - Premium Monthly: €4.99 (price_premium_monthly)
  - Premium Yearly: €39.99 (price_premium_yearly)
  - Elite Monthly: €7.99 (price_elite_monthly)
  - Elite Yearly: €69.99 (price_elite_yearly)
- [ ] Configurare Webhook endpoint per Cloud Functions
- [ ] Collegare chiavi Stripe in Firebase Config

### Configurazione AdSense
- [ ] Ottenere AdSense Client ID
- [ ] Aggiornare `AdsService.adClientId` in ads_service.dart
- [ ] Creare slot ID per banner

---

## Funzionalita' Future (PRIORITA' BASSA)

- [ ] Implementare import attivita' da CSV (Agile Process)
- [ ] Implementare import attivita' da testo (copia/incolla)
- [ ] Implementare export risultati PDF
- [x] ~~Implementare export Google Sheets~~ (completato per Agile Process - 5 fogli)
- [ ] Aggiungere test automatici
- [ ] Configurare Firestore Security Rules
- [ ] Integrazione Slack/Teams
- [ ] Integrazione Calendar

---

## Comandi Rapidi

```bash
# Dalla cartella agile_tools:

# Dipendenze
flutter pub get

# Analizza errori
flutter analyze

# Test locale
flutter run -d chrome

# Build
flutter build web --release

# Deploy
firebase deploy --only hosting
```

---

## Note

- Il progetto Firebase si chiama `pm-agile-tools-app`
- Hosting URL: https://pm-agile-tools-app.web.app/
- I file sono stati puliti da tutti i riferimenti al PMO Dashboard
- L'app e' completamente standalone
