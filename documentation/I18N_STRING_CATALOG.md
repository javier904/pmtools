# Catalogo Stringhe i18n - Agile Tools

## Panoramica Analisi

**Data**: 2026-01-18
**File Analizzati**: 126 Dart files
**Stringhe Totali Stimate**: ~350+ stringhe traducibili

---

## 1. NAVIGAZIONE E UI GENERALE

### 1.1 Titoli App e Sezioni
| Italiano | English | File | Key Suggerita |
|----------|---------|------|---------------|
| Agile Tools | Agile Tools | main.dart | appTitle |
| Matrice di Eisenhower | Eisenhower Matrix | home_screen.dart | eisenhowerTitle |
| Estimation Room | Estimation Room | home_screen.dart | estimationRoomTitle |
| Agile Process Manager | Agile Process Manager | home_screen.dart | agileProcessTitle |
| Le mie Retrospettive | My Retrospectives | home_screen.dart | myRetrospectives |
| Smart Todo | Smart Todo | home_screen.dart | smartTodoTitle |
| Dashboard | Dashboard | home_screen.dart | dashboardTitle |

### 1.2 Azioni Comuni
| Italiano | English | File | Key Suggerita |
|----------|---------|------|---------------|
| Salva | Save | multiple | actionSave |
| Annulla | Cancel | multiple | actionCancel |
| Elimina | Delete | multiple | actionDelete |
| Modifica | Edit | multiple | actionEdit |
| Crea | Create | multiple | actionCreate |
| Aggiungi | Add | multiple | actionAdd |
| Conferma | Confirm | multiple | actionConfirm |
| Chiudi | Close | multiple | actionClose |
| Applica | Apply | multiple | actionApply |
| Riprova | Retry | multiple | actionRetry |
| Indietro | Back | multiple | actionBack |
| Avanti | Next | multiple | actionNext |
| Esporta | Export | multiple | actionExport |
| Importa | Import | multiple | actionImport |

### 1.3 Stati Comuni
| Italiano | English | File | Key Suggerita |
|----------|---------|------|---------------|
| Caricamento... | Loading... | multiple | stateLoading |
| Nessun risultato | No results | multiple | stateNoResults |
| Errore | Error | multiple | stateError |
| Successo | Success | multiple | stateSuccess |

---

## 2. AUTENTICAZIONE (login_screen.dart)

| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Accedi con Google | Sign in with Google | authSignInGoogle |
| Accedi con Email | Sign in with Email | authSignInEmail |
| Registrati | Sign up | authSignUp |
| Esci | Sign out | authSignOut |
| Email | Email | authEmail |
| Password | Password | authPassword |
| Nome | Name | authName |
| Hai già un account? | Already have an account? | authHaveAccount |
| Non hai un account? | Don't have an account? | authNoAccount |
| Password dimenticata? | Forgot password? | authForgotPassword |
| Accesso in corso... | Signing in... | authSigningIn |
| Credenziali non valide | Invalid credentials | authInvalidCredentials |

---

## 3. PROFILO UTENTE (profile_screen.dart, profile_menu_widget.dart)

| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Profilo | Profile | profileTitle |
| Impostazioni | Settings | profileSettings |
| Il mio profilo | My Profile | profileMyProfile |
| Utente | User | profileUser |
| Logout | Logout | profileLogout |
| Sei sicuro di voler uscire? | Are you sure you want to sign out? | profileLogoutConfirm |

---

## 4. MATRICE EISENHOWER (eisenhower_screen.dart, widgets/eisenhower/)

### 4.1 Vista e Navigazione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Le tue matrici | Your matrices | eisenhowerYourMatrices |
| Nessuna matrice creata | No matrices created | eisenhowerNoMatrices |
| Nuova Matrice | New Matrix | eisenhowerNewMatrix |
| Crea la tua prima matrice | Create your first matrix | eisenhowerCreateFirst |
| Torna alle matrici | Back to matrices | eisenhowerBackToList |

### 4.2 Viste
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Griglia | Grid | eisenhowerViewGrid |
| Grafico | Chart | eisenhowerViewChart |
| Lista | List | eisenhowerViewList |
| RACI | RACI | eisenhowerViewRaci |

### 4.3 Quadranti
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| URGENTE | URGENT | quadrantUrgent |
| NON URGENTE | NOT URGENT | quadrantNotUrgent |
| IMPORTANTE | IMPORTANT | quadrantImportant |
| NON IMPORTANTE | NOT IMPORTANT | quadrantNotImportant |
| Q1: FAI SUBITO | Q1: DO NOW | quadrantQ1Title |
| Q2: PIANIFICA | Q2: SCHEDULE | quadrantQ2Title |
| Q3: DELEGA | Q3: DELEGATE | quadrantQ3Title |
| Q4: ELIMINA | Q4: ELIMINATE | quadrantQ4Title |
| Urgente e Importante | Urgent and Important | quadrantQ1Subtitle |
| Non Urgente ma Importante | Not Urgent but Important | quadrantQ2Subtitle |
| Urgente ma Non Importante | Urgent but Not Important | quadrantQ3Subtitle |
| Non Urgente e Non Importante | Not Urgent and Not Important | quadrantQ4Subtitle |

### 4.4 Attività
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Nessuna attività | No activities | eisenhowerNoActivities |
| Nuova Attività | New Activity | eisenhowerNewActivity |
| Titolo * | Title * | eisenhowerActivityTitle |
| Descrizione | Description | eisenhowerActivityDesc |
| Partecipanti | Participants | eisenhowerParticipants |
| Nome partecipante | Participant name | eisenhowerParticipantName |
| Aggiungi partecipante | Add participant | eisenhowerAddParticipant |

### 4.5 Statistiche
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Totali | Total | statTotal |
| Votate | Voted | statVoted |
| Da votare | To vote | statToVote |
| voti | votes | statVotes |
| attività | activities | statActivities |

### 4.6 Votazione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Vota | Vote | voteAction |
| Rivela Voti | Reveal Votes | voteReveal |
| Nascondi Voti | Hide Votes | voteHide |
| Consenso raggiunto! | Consensus reached! | voteConsensus |
| Risultati Votazione | Voting Results | voteResults |
| Media | Average | voteAverage |
| Mediana | Median | voteMedian |
| Moda | Mode | voteMode |
| Votanti | Voters | voteVoters |
| Distribuzione voti | Vote distribution | voteDistribution |

### 4.7 Azioni Toolbar
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Esporta su Google Sheets | Export to Google Sheets | eisenhowerExportSheets |
| Invita Partecipanti | Invite Participants | eisenhowerInvite |
| Impostazioni Matrice | Matrix Settings | eisenhowerSettings |

### 4.8 Lista Priorità
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Lista Priorità | Priority List | eisenhowerPriorityList |
| Da votare | To Vote | eisenhowerToVote |
| Tutte le attività | All Activities | eisenhowerAllActivities |

---

## 5. ESTIMATION ROOM (estimation_room_screen.dart, widgets/estimation_room/)

### 5.1 Vista e Navigazione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Le tue sessioni | Your sessions | estimationYourSessions |
| Nessuna sessione creata | No sessions created | estimationNoSessions |
| Nuova Sessione | New Session | estimationNewSession |
| Torna alle sessioni | Back to sessions | estimationBackToList |
| Nessuna sessione trovata | No sessions found | estimationNoSessionsFound |

### 5.2 Stati Sessione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Bozza | Draft | sessionStatusDraft |
| Attiva | Active | sessionStatusActive |
| Completata | Completed | sessionStatusCompleted |

### 5.3 Modalità di Stima (estimation_mode.dart)
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Fibonacci | Fibonacci | modeNameFibonacci |
| T-Shirt Sizes | T-Shirt Sizes | modeNameTshirt |
| Decimale | Decimal | modeNameDecimal |
| Three-Point (PERT) | Three-Point (PERT) | modeNameThreePoint |
| Dot Voting | Dot Voting | modeNameDotVoting |
| Bucket System | Bucket System | modeNameBucketSystem |
| Five Fingers | Five Fingers | modeNameFiveFingers |
| Sequenza Fibonacci classica con carte predefinite | Classic Fibonacci sequence with preset cards | modeDescFibonacci |
| Stima con taglie: XS, S, M, L, XL, XXL | Estimation with sizes: XS, S, M, L, XL, XXL | modeDescTshirt |
| Inserimento libero di valori decimali (es: 1.5, 2.75) | Free decimal input (e.g., 1.5, 2.75) | modeDescDecimal |
| Stima PERT: (Ottimistica + 4×Realistica + Pessimistica) / 6 | PERT estimate: (Optimistic + 4×Realistic + Pessimistic) / 6 | modeDescThreePoint |
| Allocazione punti per votazione silenziosa | Point allocation for silent voting | modeDescDotVoting |
| Raggruppamento per affinità di complessità | Grouping by complexity affinity | modeDescBucketSystem |
| Votazione rapida con le dita (1-5) | Quick finger voting (1-5) | modeDescFiveFingers |

### 5.4 Form Sessione (session_form_dialog.dart)
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Modifica Sessione | Edit Session | sessionFormEditTitle |
| Nuova Sessione | New Session | sessionFormNewTitle |
| Nome Sessione * | Session Name * | sessionFormName |
| Es: Sprint 15 - Stima User Stories | e.g.: Sprint 15 - User Story Estimation | sessionFormNameHint |
| Descrizione opzionale | Optional description | sessionFormDescHint |
| Configurazione | Configuration | sessionFormConfig |
| Modalità di Stima | Estimation Mode | sessionFormEstimationMode |
| Set di Carte | Card Set | sessionFormCardSet |
| Auto-reveal | Auto-reveal | sessionFormAutoReveal |
| Rivela quando tutti votano | Reveal when all vote | sessionFormAutoRevealHint |
| Osservatori | Observers | sessionFormObservers |
| Permetti partecipanti non votanti | Allow non-voting participants | sessionFormObserversHint |
| Inserisci un nome | Enter a name | sessionFormNameRequired |

### 5.5 Risultati (results_panel_widget.dart)
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Consenso raggiunto! | Consensus reached! | resultsConsensus |
| Risultati Votazione | Voting Results | resultsTitle |
| Rivota | Revote | resultsRevote |
| Media | Average | resultsAverage |
| Media aritmetica dei voti numerici | Arithmetic mean of numeric votes | resultsAverageTooltip |
| Mediana | Median | resultsMedian |
| Valore centrale quando i voti sono ordinati | Middle value when votes are sorted | resultsMedianTooltip |
| Moda | Mode | resultsMode |
| Voto più frequente (il valore scelto più volte) | Most frequent vote (most chosen value) | resultsModeTooltip |
| Votanti | Voters | resultsVoters |
| Numero totale di partecipanti che hanno votato | Total number of participants who voted | resultsVotersTooltip |
| Distribuzione voti | Vote Distribution | resultsDistribution |
| Seleziona stima finale | Select final estimate | resultsSelectFinal |
| Stima finale: | Final estimate: | resultsFinalEstimate |

---

## 6. AGILE PROCESS MANAGER (agile_process_screen.dart, widgets/agile/)

### 6.1 Vista e Navigazione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Guida Metodologie | Methodology Guide | agileMethodologyGuide |
| Seleziona un progetto per accedere alle sue Retrospettive | Select a project to access its Retrospectives | agileSelectProject |
| Cerca progetti... | Search projects... | agileSearchProjects |
| Nessun progetto trovato | No projects found | agileNoProjects |

### 6.2 Dettaglio Progetto
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| ATTIVO | ACTIVE | agileStatusActive |
| Sprint in corso | Current sprint | agileCurrentSprint |
| Membri del team | Team members | agileTeamMembers |
| User Stories nel backlog | User Stories in backlog | agileBacklogStories |
| Sprint totali | Total sprints | agileTotalSprints |
| Velocity media | Average velocity | agileAverageVelocity |

### 6.3 Backlog (backlog_list_widget.dart)
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Product Backlog | Product Backlog | backlogTitle |
| Archivio Completate | Completed Archive | backlogArchive |
| stories | stories | backlogStories |
| pts | pts | backlogPoints |
| stimate | estimated | backlogEstimated |
| Backlog | Backlog | backlogLabel |
| Archivio | Archive | backlogArchiveLabel |
| completate | completed | backlogCompleted |
| Nuova Story | New Story | backlogNewStory |
| Cerca per titolo, descrizione o ID... | Search by title, description or ID... | backlogSearchHint |
| Nessuna story trovata | No stories found | backlogNoStoriesFound |
| Backlog vuoto | Empty backlog | backlogEmpty |
| Aggiungi la prima User Story | Add the first User Story | backlogAddFirst |
| Mostra Backlog attivo | Show active Backlog | backlogShowActive |

### 6.4 Filtri
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Status: | Status: | filterStatus |
| Priorità: | Priority: | filterPriority |
| Tag: | Tag: | filterTag |
| Tutti | All | filterAll |
| Tutte | All (fem) | filterAllFem |
| Rimuovi filtri | Remove filters | filterRemove |
| Filtri | Filters | filterTitle |

---

## 7. ENUM AGILE (agile_enums.dart)

### 7.1 Framework
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Scrum | Scrum | frameworkScrum |
| Kanban | Kanban | frameworkKanban |
| Hybrid | Hybrid | frameworkHybrid |
| Sprint-based with ceremonies | Sprint-based with ceremonies | frameworkScrumDesc |
| Continuous flow with WIP limits | Continuous flow with WIP limits | frameworkKanbanDesc |
| Mix of Scrum and Kanban | Mix of Scrum and Kanban | frameworkHybridDesc |

### 7.2 Priorità MoSCoW
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Must Have | Must Have | priorityMust |
| Should Have | Should Have | priorityShould |
| Could Have | Could Have | priorityCould |
| Won't Have | Won't Have | priorityWont |

### 7.3 Status Story
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Backlog | Backlog | storyStatusBacklog |
| Ready | Ready | storyStatusReady |
| In Sprint | In Sprint | storyStatusInSprint |
| In Progress | In Progress | storyStatusInProgress |
| In Review | In Review | storyStatusInReview |
| Done | Done | storyStatusDone |

### 7.4 Status Sprint
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Planning | Planning | sprintStatusPlanning |
| Active | Active | sprintStatusActive |
| Review | Review | sprintStatusReview |
| Completed | Completed | sprintStatusCompleted |

### 7.5 Ruoli Team
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Product Owner | Product Owner | roleProductOwner |
| Scrum Master | Scrum Master | roleScrumMaster |
| Developer | Developer | roleDeveloper |
| Designer | Designer | roleDesigner |
| QA | QA | roleQA |
| Stakeholder | Stakeholder | roleStakeholder |

### 7.6 Ruoli Partecipante
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Owner | Owner | participantRoleOwner |
| Admin | Admin | participantRoleAdmin |
| Member | Member | participantRoleMember |
| Viewer | Viewer | participantRoleViewer |

### 7.7 Status Invito
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| In attesa | Pending | inviteStatusPending |
| Accettato | Accepted | inviteStatusAccepted |
| Rifiutato | Declined | inviteStatusDeclined |
| Scaduto | Expired | inviteStatusExpired |
| Revocato | Revoked | inviteStatusRevoked |

### 7.8 Azioni Audit
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Creato | Created | auditActionCreated |
| Modificato | Modified | auditActionModified |
| Eliminato | Deleted | auditActionDeleted |
| Spostato | Moved | auditActionMoved |
| Stimato | Estimated | auditActionEstimated |
| Assegnato | Assigned | auditActionAssigned |
| Completato | Completed | auditActionCompleted |
| Avviato | Started | auditActionStarted |
| Chiuso | Closed | auditActionClosed |
| Invitato | Invited | auditActionInvited |
| Entrato | Joined | auditActionJoined |
| Uscito | Left | auditActionLeft |

### 7.9 Tipi Entità Audit
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Progetto | Project | auditEntityProject |
| User Story | User Story | auditEntityStory |
| Sprint | Sprint | auditEntitySprint |
| Team | Team | auditEntityTeam |
| Retrospettiva | Retrospective | auditEntityRetrospective |

---

## 8. RETROSPETTIVE (retrospective_model.dart, retro_global_dashboard.dart)

### 8.1 Dashboard
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Le mie Retrospettive | My Retrospectives | retroMyRetros |
| Guida alle Retrospettive | Retrospective Guide | retroGuide |
| Cerca retrospettiva... | Search retrospective... | retroSearch |
| Tutte | All | retroFilterAll |
| Active | Active | retroFilterActive |
| Completed | Completed | retroFilterCompleted |
| Draft | Draft | retroFilterDraft |
| Nessun risultato per la ricerca | No search results | retroNoSearchResults |
| Nessuna retrospettiva trovata | No retrospectives found | retroNoRetros |
| Crea Nuova | Create New | retroCreateNew |
| Elimina Retrospettiva | Delete Retrospective | retroDelete |

### 8.2 Form Creazione
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Nuova Retrospettiva | New Retrospective | retroNewTitle |
| Collega a Sprint? | Link to Sprint? | retroLinkToSprint |
| Seleziona Progetto | Select Project | retroSelectProject |
| Seleziona Sprint | Select Sprint | retroSelectSprint |
| Titolo Sessione | Session Title | retroSessionTitle |
| Template | Template | retroTemplate |
| Voti per utente: | Votes per user: | retroVotesPerUser |

### 8.3 Template (RetroTemplate)
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Start, Stop, Continue | Start, Stop, Continue | templateStartStopContinue |
| Sailboat | Sailboat | templateSailboat |
| 4 Ls | 4 Ls | template4Ls |
| Starfish | Starfish | templateStarfish |
| Mad Sad Glad | Mad Sad Glad | templateMadSadGlad |
| DAKI (Drop Add Keep Improve) | DAKI (Drop Add Keep Improve) | templateDaki |

### 8.4 Icebreaker
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Icebreaker | Icebreaker | icebreakerTitle |
| Attività iniziale | Initial activity | icebreakerActivity |
| Seleziona l'attività per rompere il ghiaccio | Select the ice-breaking activity | icebreakerSelect |
| Sentiment Voting | Sentiment Voting | icebreakerSentiment |
| One Word | One Word | icebreakerOneWord |
| Weather Report | Weather Report | icebreakerWeather |
| Vota da 1 a 5 come ti sei sentito durante lo sprint. | Vote 1 to 5 how you felt during the sprint. | icebreakerSentimentDesc |
| Descrivi lo sprint con una sola parola. | Describe the sprint with a single word. | icebreakerOneWordDesc |
| Scegli un'icona meteo che rappresenta lo sprint. | Choose a weather icon that represents the sprint. | icebreakerWeatherDesc |

### 8.5 Fasi e Timer
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Timer Fasi (Opzionale) | Phase Timer (Optional) | retroTimerTitle |
| Imposta la durata in minuti per ogni fase: | Set duration in minutes for each phase: | retroTimerHint |
| min | min | retroTimerMin |

### 8.6 Colonne Template
| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Went Well | Went Well | columnWentWell |
| Cosa è andato bene? | What went well? | columnWentWellDesc |
| To Improve | To Improve | columnToImprove |
| Cosa migliorare? | What to improve? | columnToImproveDesc |
| Start | Start | columnStart |
| Stop | Stop | columnStop |
| Continue | Continue | columnContinue |
| Wind (Spinge) | Wind (Propels) | columnWind |
| Anchors (Frena) | Anchors (Slows) | columnAnchors |
| Rocks (Rischi) | Rocks (Risks) | columnRocks |
| Island (Obiettivi) | Island (Goals) | columnIsland |
| Liked | Liked | columnLiked |
| Learned | Learned | columnLearned |
| Lacked | Lacked | columnLacked |
| Longed For | Longed For | columnLongedFor |
| Keep | Keep | columnKeep |
| More | More | columnMore |
| Less | Less | columnLess |
| Mad | Mad | columnMad |
| Sad | Sad | columnSad |
| Glad | Glad | columnGlad |
| Drop (Elimina) | Drop (Remove) | columnDrop |
| Add (Aggiungi) | Add (Insert) | columnAdd |
| Improve (Migliora) | Improve (Enhance) | columnImprove |

---

## 9. ERRORI E MESSAGGI (multiple files)

| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Errore caricamento dati: | Error loading data: | errorLoadingData |
| Errore creazione matrice: | Error creating matrix: | errorCreatingMatrix |
| Errore salvataggio: | Error saving: | errorSaving |
| Errore eliminazione: | Error deleting: | errorDeleting |
| Si è verificato un errore | An error occurred | errorGeneric |
| Operazione completata | Operation completed | successGeneric |
| Salvato con successo | Saved successfully | successSaved |
| Eliminato con successo | Deleted successfully | successDeleted |
| Inserisci un nome | Enter a name | validationNameRequired |
| Campo obbligatorio | Required field | validationRequired |

---

## 10. LANDING PAGE (landing_screen.dart)

| Italiano | English | Key Suggerita |
|----------|---------|---------------|
| Strumenti Agile per Team Moderni | Agile Tools for Modern Teams | landingTitle |
| Prioritizza con la Matrice di Eisenhower | Prioritize with the Eisenhower Matrix | landingEisenhowerTitle |
| Organizza le attività per urgenza e importanza | Organize activities by urgency and importance | landingEisenhowerDesc |
| Stima collaborativa con Planning Poker | Collaborative estimation with Planning Poker | landingEstimationTitle |
| Sessioni di stima in tempo reale con il team | Real-time estimation sessions with your team | landingEstimationDesc |
| Accedi per iniziare | Sign in to get started | landingSignIn |

---

## Riepilogo per Integrazione Properties

### Organizzazione Consigliata in ARB

```
lib/l10n/
├── app_it.arb          # Italiano (default)
├── app_en.arb          # English
└── l10n.yaml           # Configurazione
```

### Categorie Principali
1. **common_** - Azioni e stati comuni
2. **auth_** - Autenticazione
3. **profile_** - Profilo utente
4. **eisenhower_** - Matrice Eisenhower
5. **estimation_** - Estimation Room
6. **agile_** - Agile Process Manager
7. **retro_** - Retrospettive
8. **error_** - Messaggi di errore
9. **success_** - Messaggi di successo
10. **validation_** - Messaggi di validazione

### Note per Properties Integration

Il sistema Properties esistente può essere esteso per:
1. **Sincronizzazione Cloud** - Traduzione centralizzata via Firestore
2. **Override Utente** - Preferenza lingua per utente
3. **Fallback Chain** - ARB locale → Firestore → Default
4. **Hot Reload** - Aggiornamento traduzioni senza rebuild

---

## Prossimi Passi

1. [ ] Creare file `lib/l10n/app_it.arb` con tutte le stringhe italiane
2. [ ] Creare file `lib/l10n/app_en.arb` con traduzioni inglesi
3. [ ] Configurare `l10n.yaml`
4. [ ] Aggiungere dipendenze `flutter_localizations` e `intl`
5. [ ] Generare classi di localizzazione con `flutter gen-l10n`
6. [ ] Sostituire stringhe hardcoded con `AppLocalizations.of(context)!.keyName`
7. [ ] Integrare con sistema Properties per sincronizzazione cloud
