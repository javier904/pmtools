// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Agile Tools';

  @override
  String get actionSave => 'Salva';

  @override
  String get actionCancel => 'Annulla';

  @override
  String get actionDelete => 'Elimina';

  @override
  String get actionEdit => 'Modifica';

  @override
  String get actionCreate => 'Crea';

  @override
  String get actionAdd => 'Aggiungi';

  @override
  String get actionClose => 'Chiudi';

  @override
  String get actionRetry => 'Riprova';

  @override
  String get actionConfirm => 'Conferma';

  @override
  String get actionSearch => 'Cerca';

  @override
  String get actionFilter => 'Filtra';

  @override
  String get actionExport => 'Esporta';

  @override
  String get actionCopy => 'Copia';

  @override
  String get actionShare => 'Condividi';

  @override
  String get actionDone => 'Fatto';

  @override
  String get actionReset => 'Reset';

  @override
  String get stateLoading => 'Caricamento...';

  @override
  String get stateEmpty => 'Nessun elemento';

  @override
  String get stateError => 'Errore';

  @override
  String get stateSuccess => 'Successo';

  @override
  String get authSignInGoogle => 'Accedi con Google';

  @override
  String get authSignOut => 'Esci';

  @override
  String get authLogoutConfirm => 'Sei sicuro di voler uscire?';

  @override
  String get formNameRequired => 'Inserisci il tuo nome';

  @override
  String get authError => 'Errore di autenticazione';

  @override
  String get authUserNotFound => 'Utente non trovato';

  @override
  String get authWrongPassword => 'Password errata';

  @override
  String get authEmailInUse => 'Email già in uso';

  @override
  String get authWeakPassword => 'Password troppo debole';

  @override
  String get authInvalidEmail => 'Email non valida';

  @override
  String get appSubtitle => 'Agile Tools per Team';

  @override
  String get authOr => 'oppure';

  @override
  String get authPassword => 'Password';

  @override
  String get authRegister => 'Registrati';

  @override
  String get authLogin => 'Accedi';

  @override
  String get authHaveAccount => 'Hai già un account?';

  @override
  String get authNoAccount => 'Non hai un account?';

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Profilo';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get eisenhowerTitle => 'Matrice di Eisenhower';

  @override
  String get eisenhowerYourMatrices => 'Le tue matrici';

  @override
  String get eisenhowerNoMatrices => 'Nessuna matrice creata';

  @override
  String get eisenhowerNewMatrix => 'Nuova Matrice';

  @override
  String get eisenhowerViewGrid => 'Griglia';

  @override
  String get eisenhowerViewChart => 'Grafico';

  @override
  String get eisenhowerViewList => 'Lista';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'URGENTE';

  @override
  String get quadrantNotUrgent => 'NON URGENTE';

  @override
  String get quadrantImportant => 'IMPORTANTE';

  @override
  String get quadrantNotImportant => 'NON IMPORTANTE';

  @override
  String get quadrantQ1Title => 'FAI SUBITO';

  @override
  String get quadrantQ2Title => 'PIANIFICA';

  @override
  String get quadrantQ3Title => 'DELEGA';

  @override
  String get quadrantQ4Title => 'ELIMINA';

  @override
  String get quadrantQ1Subtitle => 'Urgente e Importante';

  @override
  String get quadrantQ2Subtitle => 'Importante, Non Urgente';

  @override
  String get quadrantQ3Subtitle => 'Urgente, Non Importante';

  @override
  String get quadrantQ4Subtitle => 'Non Urgente, Non Importante';

  @override
  String get eisenhowerNoActivities => 'Nessuna attivita';

  @override
  String get eisenhowerNewActivity => 'Nuova Attivita';

  @override
  String get eisenhowerExportSheets => 'Esporta su Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Invita Partecipanti';

  @override
  String get eisenhowerDeleteMatrix => 'Elimina Matrice';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Sei sicuro di voler eliminare questa matrice?';

  @override
  String get eisenhowerActivityTitle => 'Titolo attivita';

  @override
  String get eisenhowerActivityNotes => 'Note';

  @override
  String get eisenhowerDueDate => 'Data scadenza';

  @override
  String get eisenhowerPriority => 'Priorita';

  @override
  String get eisenhowerAssignee => 'Assegnatario';

  @override
  String get eisenhowerCompleted => 'Completata';

  @override
  String get eisenhowerMoveToQuadrant => 'Sposta nel quadrante';

  @override
  String get eisenhowerMatrixSettings => 'Impostazioni Matrice';

  @override
  String get eisenhowerBackToList => 'Lista';

  @override
  String get eisenhowerPriorityList => 'Lista Priorita';

  @override
  String get eisenhowerAllActivities => 'Tutte le attivita';

  @override
  String get eisenhowerToVote => 'Da votare';

  @override
  String get eisenhowerVoted => 'Votate';

  @override
  String get eisenhowerTotal => 'Totali';

  @override
  String get eisenhowerEditParticipants => 'Modifica partecipanti';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count attivita';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count voti';
  }

  @override
  String get eisenhowerModifyVotes => 'Modifica voti';

  @override
  String get eisenhowerVote => 'Vota';

  @override
  String get eisenhowerQuadrant => 'Quadrante';

  @override
  String get eisenhowerUrgencyAvg => 'Urgenza media';

  @override
  String get eisenhowerImportanceAvg => 'Importanza media';

  @override
  String get eisenhowerVotesLabel => 'Voti:';

  @override
  String get eisenhowerNoVotesYet => 'Nessun voto ancora raccolto';

  @override
  String get eisenhowerEditMatrix => 'Modifica Matrice';

  @override
  String get eisenhowerAddActivity => 'Aggiungi Attivita';

  @override
  String get eisenhowerDeleteActivity => 'Elimina Attivita';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Sei sicuro di voler eliminare \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matrice creata con successo';

  @override
  String get eisenhowerMatrixUpdated => 'Matrice aggiornata';

  @override
  String get eisenhowerMatrixDeleted => 'Matrice eliminata';

  @override
  String get eisenhowerActivityAdded => 'Attivita aggiunta';

  @override
  String get eisenhowerActivityDeleted => 'Attivita eliminata';

  @override
  String get eisenhowerVotesSaved => 'Voti salvati';

  @override
  String get eisenhowerExportCompleted => 'Export completato!';

  @override
  String get eisenhowerExportCompletedDialog => 'Export Completato';

  @override
  String get eisenhowerExportDialogContent =>
      'Il foglio Google Sheets e stato creato.\nVuoi aprirlo nel browser?';

  @override
  String get eisenhowerOpen => 'Apri';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Aggiungi prima dei partecipanti alla matrice';

  @override
  String get eisenhowerSearchLabel => 'Ricerca:';

  @override
  String get eisenhowerNoMatrixFound => 'Nessuna matrice trovata';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Crea la tua prima Matrice di Eisenhower\nper organizzare le tue priorita';

  @override
  String get eisenhowerCreateMatrix => 'Crea Matrice';

  @override
  String get eisenhowerClickToOpen => 'Matrice Eisenhower\nClicca per aprire';

  @override
  String get eisenhowerTotalActivities => 'Attivita totali nella matrice';

  @override
  String get eisenhowerStartVoting => 'Avvia Votazione Indipendente';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Vuoi avviare una sessione di voto indipendente per \"$title\"?\n\nOgni partecipante votera senza vedere i voti degli altri, fino a quando tutti avranno votato e i voti verranno rivelati.';
  }

  @override
  String get eisenhowerStart => 'Avvia';

  @override
  String get eisenhowerVotingStarted => 'Votazione avviata';

  @override
  String get eisenhowerResetVoting => 'Resettare Votazione?';

  @override
  String get eisenhowerResetVotingDesc => 'Tutti i voti verranno cancellati.';

  @override
  String get eisenhowerVotingReset => 'Votazione resettata';

  @override
  String get eisenhowerMinVotersRequired =>
      'Servono almeno 2 votanti per la votazione indipendente';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Verranno eliminate anche tutte le $count attivita.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Le tue matrici ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Inserisci un titolo';

  @override
  String get formTitleHint => 'Es: Priorita Q1 2025';

  @override
  String get formDescriptionHint => 'Descrizione opzionale';

  @override
  String get formParticipantHint => 'Nome partecipante';

  @override
  String get formAddParticipantHint =>
      'Aggiungi almeno un partecipante per poter votare';

  @override
  String get formActivityTitleHint => 'Es: Completare documentazione API';

  @override
  String get errorCreatingMatrix => 'Errore creazione matrice';

  @override
  String get errorUpdatingMatrix => 'Errore aggiornamento';

  @override
  String get errorDeletingMatrix => 'Errore eliminazione';

  @override
  String get errorAddingActivity => 'Errore aggiunta attivita';

  @override
  String get errorSavingVotes => 'Errore salvataggio voti';

  @override
  String get errorExport => 'Errore durante l\'export';

  @override
  String get errorStartingVoting => 'Errore avvio votazione';

  @override
  String get errorResetVoting => 'Errore reset';

  @override
  String get errorLoadingActivities => 'Errore caricamento attivita';

  @override
  String get estimationTitle => 'Estimation Room';

  @override
  String get estimationYourSessions => 'Le tue sessioni';

  @override
  String get estimationNoSessions => 'Nessuna sessione creata';

  @override
  String get estimationNewSession => 'Nuova Sessione';

  @override
  String get estimationEditSession => 'Modifica Sessione';

  @override
  String get estimationJoinSession => 'Unisciti a sessione';

  @override
  String get estimationSessionCode => 'Codice sessione';

  @override
  String get estimationEnterCode => 'Inserisci codice';

  @override
  String get sessionStatusDraft => 'Bozza';

  @override
  String get sessionStatusActive => 'Attiva';

  @override
  String get sessionStatusCompleted => 'Completata';

  @override
  String get sessionName => 'Nome Sessione';

  @override
  String get sessionNameRequired => 'Nome Sessione *';

  @override
  String get sessionNameHint => 'Es: Sprint 15 - Stima User Stories';

  @override
  String get sessionDescription => 'Descrizione';

  @override
  String get sessionCardSet => 'Set di Carte';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Semplificato (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Modalita di Stima';

  @override
  String get sessionAutoReveal => 'Auto-reveal';

  @override
  String get sessionAutoRevealDesc => 'Rivela quando tutti votano';

  @override
  String get sessionAllowObservers => 'Osservatori';

  @override
  String get sessionAllowObserversDesc => 'Permetti partecipanti non votanti';

  @override
  String get sessionConfiguration => 'Configurazione';

  @override
  String get voteConsensus => 'Consenso raggiunto!';

  @override
  String get voteResults => 'Risultati Votazione';

  @override
  String get voteRevote => 'Rivota';

  @override
  String get voteReveal => 'Rivela';

  @override
  String get voteHide => 'Nascondi';

  @override
  String get voteAverage => 'Media';

  @override
  String get voteMedian => 'Mediana';

  @override
  String get voteMode => 'Moda';

  @override
  String get voteVoters => 'Votanti';

  @override
  String get voteDistribution => 'Distribuzione voti';

  @override
  String get voteFinalEstimate => 'Stima finale';

  @override
  String get voteSelectFinal => 'Seleziona stima finale';

  @override
  String get voteWaiting => 'In attesa di voti...';

  @override
  String get voteSubmitted => 'Voto inviato';

  @override
  String get voteNotSubmitted => 'Non ha votato';

  @override
  String get storyToEstimate => 'Storia da stimare';

  @override
  String get storyTitle => 'Titolo storia';

  @override
  String get storyDescription => 'Descrizione storia';

  @override
  String get storyAddNew => 'Aggiungi storia';

  @override
  String get storyNoStories => 'Nessuna storia da stimare';

  @override
  String get storyComplete => 'Storia completata';

  @override
  String get storySkip => 'Salta storia';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'T-Shirt Sizes';

  @override
  String get estimationModeDecimal => 'Decimale';

  @override
  String get estimationModeThreePoint => 'Three-Point (PERT)';

  @override
  String get estimationModeDotVoting => 'Dot Voting';

  @override
  String get estimationModeBucketSystem => 'Bucket System';

  @override
  String get estimationModeFiveFingers => 'Five Fingers';

  @override
  String get retroTitle => 'Le mie Retrospettive';

  @override
  String get retroNoRetros => 'Nessuna retrospettiva';

  @override
  String get retroCreateNew => 'Crea Nuova';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeLight => 'Chiaro';

  @override
  String get settingsThemeDark => 'Scuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get formTitle => 'Titolo';

  @override
  String get formDescription => 'Descrizione';

  @override
  String get formName => 'Nome';

  @override
  String get formRequired => 'Campo obbligatorio';

  @override
  String get formHint => 'Inserisci un valore';

  @override
  String get formOptional => 'Opzionale';

  @override
  String get errorGeneric => 'Si e verificato un errore';

  @override
  String get errorLoading => 'Errore caricamento dati';

  @override
  String get errorSaving => 'Errore salvataggio';

  @override
  String get errorNetwork => 'Errore di connessione';

  @override
  String get errorPermission => 'Permesso negato';

  @override
  String get errorNotFound => 'Non trovato';

  @override
  String get successSaved => 'Salvato con successo';

  @override
  String get successDeleted => 'Eliminato con successo';

  @override
  String get successCopied => 'Copiato negli appunti';

  @override
  String get filterAll => 'Tutti';

  @override
  String get filterRemove => 'Rimuovi filtri';

  @override
  String get filterActive => 'Attivi';

  @override
  String get filterCompleted => 'Completati';

  @override
  String get participants => 'Partecipanti';

  @override
  String get addParticipant => 'Aggiungi partecipante';

  @override
  String get removeParticipant => 'Rimuovi partecipante';

  @override
  String get noParticipants => 'Nessun partecipante';

  @override
  String get participantJoined => 'si e unito';

  @override
  String get participantLeft => 'ha lasciato';

  @override
  String get participantRole => 'Ruolo';

  @override
  String get participantVoter => 'Votante';

  @override
  String get participantObserver => 'Osservatore';

  @override
  String get participantModerator => 'Moderatore';

  @override
  String get confirmDelete => 'Conferma eliminazione';

  @override
  String get confirmDeleteMessage => 'Questa azione non puo essere annullata.';

  @override
  String get yes => 'Si';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Oggi';

  @override
  String get yesterday => 'Ieri';

  @override
  String get tomorrow => 'Domani';

  @override
  String daysAgo(int count) {
    return '$count giorni fa';
  }

  @override
  String hoursAgo(int count) {
    return '$count ore fa';
  }

  @override
  String minutesAgo(int count) {
    return '$count minuti fa';
  }

  @override
  String itemCount(int count) {
    return '$count elementi';
  }

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String greeting(String name) {
    return 'Ciao, $name!';
  }

  @override
  String get copyLink => 'Copia link';

  @override
  String get shareSession => 'Condividi sessione';

  @override
  String get inviteByEmail => 'Invita via email';

  @override
  String get inviteByLink => 'Invita via link';

  @override
  String get profileTitle => 'Profilo';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileDisplayName => 'Nome visualizzato';

  @override
  String get profilePhotoUrl => 'Foto profilo';

  @override
  String get profileEditProfile => 'Modifica profilo';

  @override
  String get profileReload => 'Ricarica';

  @override
  String get profilePersonalInfo => 'Informazioni Personali';

  @override
  String get profileLastName => 'Cognome';

  @override
  String get profileCompany => 'Azienda';

  @override
  String get profileJobTitle => 'Ruolo';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Abbonamento';

  @override
  String get profilePlan => 'Piano';

  @override
  String get profileBillingCycle => 'Ciclo di fatturazione';

  @override
  String get profilePrice => 'Prezzo';

  @override
  String get profileActivationDate => 'Data attivazione';

  @override
  String get profileTrialEnd => 'Fine periodo di prova';

  @override
  String get profileNextRenewal => 'Prossimo rinnovo';

  @override
  String get profileDaysRemaining => 'Giorni rimanenti';

  @override
  String get profileUpgrade => 'Upgrade';

  @override
  String get profileUpgradePlan => 'Upgrade Piano';

  @override
  String get profileGeneralSettings => 'Impostazioni Generali';

  @override
  String get profileAnimations => 'Animazioni';

  @override
  String get profileAnimationsDesc => 'Abilita animazioni UI';

  @override
  String get profileFeatures => 'Funzionalita';

  @override
  String get profileCalendarIntegration => 'Integrazione Calendario';

  @override
  String get profileCalendarIntegrationDesc => 'Sincronizza sprint e scadenze';

  @override
  String get profileExportSheets => 'Export Google Sheets';

  @override
  String get profileExportSheetsDesc => 'Esporta dati in fogli di calcolo';

  @override
  String get profileBetaFeatures => 'Funzionalita Beta';

  @override
  String get profileBetaFeaturesDesc =>
      'Accesso anticipato a nuove funzionalita';

  @override
  String get profileAdvancedMetrics => 'Metriche Avanzate';

  @override
  String get profileAdvancedMetricsDesc => 'Statistiche e report dettagliati';

  @override
  String get profileNotifications => 'Notifiche';

  @override
  String get profileEmailNotifications => 'Notifiche Email';

  @override
  String get profileEmailNotificationsDesc => 'Ricevi aggiornamenti via email';

  @override
  String get profilePushNotifications => 'Notifiche Push';

  @override
  String get profilePushNotificationsDesc => 'Notifiche nel browser';

  @override
  String get profileSprintReminders => 'Promemoria Sprint';

  @override
  String get profileSprintRemindersDesc => 'Avvisi per scadenze sprint';

  @override
  String get profileSessionInvites => 'Inviti Sessioni';

  @override
  String get profileSessionInvitesDesc => 'Notifiche per nuove sessioni';

  @override
  String get profileWeeklySummary => 'Riepilogo Settimanale';

  @override
  String get profileWeeklySummaryDesc => 'Report settimanale delle attivita';

  @override
  String get profileDangerZone => 'Zona Pericolosa';

  @override
  String get profileDeleteAccount => 'Elimina Account';

  @override
  String get profileDeleteAccountDesc =>
      'Richiedi la cancellazione definitiva del tuo account e di tutti i dati associati';

  @override
  String get profileDeleteAccountRequest => 'Richiedi';

  @override
  String get profileDeleteAccountIrreversible =>
      'Questa azione e irreversibile. Tutti i tuoi dati verranno eliminati definitivamente.';

  @override
  String get profileDeleteAccountReason => 'Motivo (opzionale)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Perche vuoi eliminare il tuo account?';

  @override
  String get profileRequestDeletion => 'Richiedi Eliminazione';

  @override
  String get profileDeletionInProgress => 'Cancellazione in corso';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Richiesta il $date';
  }

  @override
  String get profileCancelRequest => 'Annulla richiesta';

  @override
  String get profileDeletionRequestSent => 'Richiesta di eliminazione inviata';

  @override
  String get profileDeletionRequestCancelled => 'Richiesta annullata';

  @override
  String get profileUpdated => 'Profilo aggiornato';

  @override
  String get profileLogout => 'Esci';

  @override
  String get profileLogoutDesc =>
      'Disconnetti il tuo account da questo dispositivo';

  @override
  String get profileLogoutConfirm => 'Sei sicuro di voler uscire?';

  @override
  String get profileSubscriptionCancelled => 'Abbonamento annullato';

  @override
  String get profileCancelSubscription => 'Annulla Abbonamento';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Sei sicuro di voler annullare il tuo abbonamento? Potrai continuare a utilizzare le funzionalita premium fino alla scadenza del periodo corrente.';

  @override
  String get profileKeepSubscription => 'No, mantieni';

  @override
  String get profileYesCancel => 'Si, annulla';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Upgrade a $plan in arrivo...';
  }

  @override
  String get profileFree => 'Gratuito';

  @override
  String get profileMonthly => 'EUR/mese';

  @override
  String get profileUser => 'Utente';

  @override
  String profileErrorPrefix(String error) {
    return 'Errore: $error';
  }

  @override
  String get stateSaving => 'Salvataggio...';

  @override
  String get cardCoffee => 'Pausa';

  @override
  String get cardQuestion => 'Non so';

  @override
  String get toolEisenhower => 'Matrice Eisenhower';

  @override
  String get toolEisenhowerDesc =>
      'Organizza le attivita in base a urgenza e importanza. Quadranti per decidere cosa fare subito, pianificare, delegare o eliminare.';

  @override
  String get toolEisenhowerDescShort => 'Prioritizza per urgenza e importanza';

  @override
  String get toolEstimation => 'Estimation Room';

  @override
  String get toolEstimationDesc =>
      'Sessioni di stima collaborative per il team. Planning Poker, T-Shirt sizing e altri metodi per stimare user stories.';

  @override
  String get toolEstimationDescShort => 'Sessioni di stima collaborative';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Liste intelligenti e collaborative. Importa da CSV/testo, invita partecipanti e gestisci task con filtri avanzati.';

  @override
  String get toolSmartTodoDescShort =>
      'Liste intelligenti e collaborative. Importa da CSV, invita e gestisci.';

  @override
  String get toolAgileProcess => 'Agile Process Manager';

  @override
  String get toolAgileProcessDesc =>
      'Gestisci progetti agili completi con backlog, sprint planning, kanban board, metriche e retrospettive.';

  @override
  String get toolAgileProcessDescShort =>
      'Gestisci progetti agili con backlog, sprint, kanban e metriche.';

  @override
  String get toolRetro => 'Retrospective Board';

  @override
  String get toolRetroDesc =>
      'Raccogli feedback dal team su cosa e andato bene, cosa migliorare e le azioni da intraprendere.';

  @override
  String get toolRetroDescShort =>
      'Raccogli feedback dal team su cosa e andato bene e cosa migliorare.';

  @override
  String get homeUtilities => 'Utilities';

  @override
  String get homeSelectTool => 'Seleziona uno strumento per iniziare';

  @override
  String get statusOnline => 'Online';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get featureComingSoon =>
      'Questa funzionalita sara disponibile presto!';

  @override
  String get featureSmartImport => 'Smart Import';

  @override
  String get featureCollaboration => 'Collaborazione';

  @override
  String get featureFilters => 'Filtri';

  @override
  String get feature4Quadrants => '4 Quadranti';

  @override
  String get featureDragDrop => 'Drag & Drop';

  @override
  String get featureCollaborative => 'Collaborativo';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'T-Shirt Size';

  @override
  String get featureRealtime => 'Real-time';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Hybrid';

  @override
  String get featureWentWell => 'Went Well';

  @override
  String get featureToImprove => 'To Improve';

  @override
  String get featureActions => 'Actions';

  @override
  String get themeLightMode => 'Tema Chiaro';

  @override
  String get themeDarkMode => 'Tema Scuro';

  @override
  String get estimationBackToSessions => 'Torna alle sessioni';

  @override
  String get estimationSessionSettings => 'Impostazioni Sessione';

  @override
  String get estimationList => 'Lista';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Le tue sessioni ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'Nessuna sessione trovata';

  @override
  String get estimationCreateFirstSession =>
      'Crea la tua prima sessione di stima\nper stimare le attivita con il team';

  @override
  String get estimationStoriesTotal => 'Stories totali';

  @override
  String get estimationStoriesCompleted => 'Stories completate';

  @override
  String get estimationParticipantsActive => 'Partecipanti attivi';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Avanzamento: $completed/$total stories ($percent%)';
  }

  @override
  String get estimationStart => 'Avvia';

  @override
  String get estimationComplete => 'Completa';

  @override
  String get estimationAllStoriesEstimated =>
      'Tutte le stories sono state stimate!';

  @override
  String get estimationNoVotingInProgress => 'Nessuna votazione in corso';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Completate: $completed/$total | Stima totale: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Vota: $title';
  }

  @override
  String get estimationAddStoriesToStart =>
      'Aggiungi delle stories per iniziare';

  @override
  String get estimationInVoting => 'IN VOTAZIONE';

  @override
  String get estimationReveal => 'Rivela';

  @override
  String get estimationSkip => 'Salta';

  @override
  String get estimationStories => 'Stories';

  @override
  String get estimationAddStory => 'Aggiungi Story';

  @override
  String get estimationStartVoting => 'Inizia votazione';

  @override
  String get estimationViewVotes => 'Vedi voti';

  @override
  String get estimationViewDetail => 'Vedi dettaglio';

  @override
  String get estimationFinalEstimateLabel => 'Stima finale:';

  @override
  String estimationVotesOf(String title) {
    return 'Voti: $title';
  }

  @override
  String get estimationParticipantVotes => 'Voti dei partecipanti:';

  @override
  String get estimationPointsOrDays => 'punti / giorni';

  @override
  String get estimationEstimateRationale =>
      'Motivazione della stima (opzionale)';

  @override
  String get estimationExplainRationale =>
      'Spiega il razionale della stima...\nEs: Complessita tecnica elevata, dipendenze esterne...';

  @override
  String get estimationRationaleHelp =>
      'La motivazione aiuta il team a ricordare le decisioni prese durante la stima.';

  @override
  String get estimationConfirmFinalEstimate => 'Conferma Stima Finale';

  @override
  String get estimationEnterValidEstimate => 'Inserisci una stima valida';

  @override
  String get estimationHintEstimate => 'Es: 5, 8, 13...';

  @override
  String get estimationStatus => 'Stato';

  @override
  String get estimationOrder => 'Ordine';

  @override
  String get estimationVotesReceived => 'Voti ricevuti';

  @override
  String get estimationAverageVotes => 'Media voti';

  @override
  String get estimationConsensus => 'Consenso';

  @override
  String get storyStatusPending => 'In attesa';

  @override
  String get storyStatusVoting => 'In votazione';

  @override
  String get storyStatusRevealed => 'Voti rivelati';

  @override
  String get participantManagement => 'Gestione Partecipanti';

  @override
  String get participantCopySessionLink => 'Copia link sessione';

  @override
  String get participantInvitesTab => 'Inviti';

  @override
  String get participantSessionLink =>
      'Link Sessione (condividi con i partecipanti)';

  @override
  String get participantAddDirect => 'Aggiungi Partecipante Diretto';

  @override
  String get participantEmailRequired => 'Email *';

  @override
  String get participantEmailHint => 'email@esempio.com';

  @override
  String get participantNameHint => 'Nome visualizzato';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters votanti, $observers osservatori';
  }

  @override
  String get participantYou => 'Tu';

  @override
  String get participantMakeVoter => 'Rendi Votante';

  @override
  String get participantMakeObserver => 'Rendi Osservatore';

  @override
  String get participantRemoveTitle => 'Rimuovi Partecipante';

  @override
  String participantRemoveConfirm(String name) {
    return 'Sei sicuro di voler rimuovere \"$name\" dalla sessione?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email aggiunto alla sessione';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name rimosso dalla sessione';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Ruolo aggiornato per $email';
  }

  @override
  String get participantFacilitator => 'Facilitatore';

  @override
  String get inviteSendNew => 'Invia Nuovo Invito';

  @override
  String get inviteRecipientEmail => 'Email destinatario *';

  @override
  String get inviteCreate => 'Crea Invito';

  @override
  String get invitesSent => 'Inviti Inviati';

  @override
  String get inviteNoInvites => 'Nessun invito inviato';

  @override
  String inviteCreatedFor(String email) {
    return 'Invito creato per $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Scade tra ${days}g';
  }

  @override
  String get inviteCopyLink => 'Copia link invito';

  @override
  String get inviteRevokeAction => 'Revoca invito';

  @override
  String get inviteDeleteAction => 'Elimina invito';

  @override
  String get inviteRevokeTitle => 'Revoca Invito';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Sei sicuro di voler revocare l\'invito per $email?';
  }

  @override
  String get inviteRevoke => 'Revoca';

  @override
  String inviteRevokedFor(String email) {
    return 'Invito revocato per $email';
  }

  @override
  String get inviteDeleteTitle => 'Elimina Invito';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Sei sicuro di voler eliminare l\'invito per $email?\n\nQuesta azione e irreversibile.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Invito eliminato per $email';
  }

  @override
  String get inviteLinkCopied => 'Link invito copiato negli appunti';

  @override
  String get linkCopied => 'Link copiato negli appunti';

  @override
  String get enterValidEmail => 'Inserisci un indirizzo email valido';

  @override
  String get sessionCreatedSuccess => 'Sessione creata con successo';

  @override
  String get sessionUpdated => 'Sessione aggiornata';

  @override
  String get sessionDeleted => 'Sessione eliminata';

  @override
  String get sessionStarted => 'Sessione avviata';

  @override
  String get sessionCompletedSuccess => 'Sessione completata';

  @override
  String get sessionNotFound => 'Sessione non trovata';

  @override
  String get storyAdded => 'Story aggiunta';

  @override
  String get storyDeleted => 'Story eliminata';

  @override
  String estimateSaved(String estimate) {
    return 'Stima salvata: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Elimina Sessione';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Sei sicuro di voler eliminare \"$name\"?\nVerranno eliminate anche tutte le $count stories.';
  }

  @override
  String get deleteStoryTitle => 'Elimina Story';

  @override
  String deleteStoryConfirm(String title) {
    return 'Sei sicuro di voler eliminare \"$title\"?';
  }

  @override
  String get errorLoadingSession => 'Errore caricamento sessione';

  @override
  String get errorLoadingStories => 'Errore caricamento stories';

  @override
  String get errorCreatingSession => 'Errore creazione sessione';

  @override
  String get errorUpdatingSession => 'Errore aggiornamento';

  @override
  String get errorDeletingSession => 'Errore eliminazione';

  @override
  String get errorAddingStory => 'Errore aggiunta story';

  @override
  String get errorStartingSession => 'Errore avvio sessione';

  @override
  String get errorCompletingSession => 'Errore completamento sessione';

  @override
  String get errorSubmittingVote => 'Errore invio voto';

  @override
  String get errorRevealingVotes => 'Errore reveal';

  @override
  String get errorSavingEstimate => 'Errore salvataggio stima';

  @override
  String get errorSkipping => 'Errore skip';

  @override
  String get retroIcebreakerTitle => 'Icebreaker: Morale del Team';

  @override
  String get retroIcebreakerQuestion =>
      'Come ti sei sentito riguardo a questo sprint?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count partecipanti hanno votato';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Termina Icebreaker & Inizia Scrittura';

  @override
  String get retroMoodTerrible => 'Terribile';

  @override
  String get retroMoodBad => 'Male';

  @override
  String get retroMoodNeutral => 'Neutro';

  @override
  String get retroMoodGood => 'Bene';

  @override
  String get retroMoodExcellent => 'Eccellente';

  @override
  String get retroAgileCoach => 'Agile Coach';

  @override
  String get retroCoachSetup =>
      'Scegliete un template. \"Start/Stop/Continue\" e ottimo per i nuovi team. Assicuratevi che tutti siano presenti.';

  @override
  String get retroCoachIcebreaker =>
      'Rompete il ghiaccio! Fate un giro veloce chiedendo \"Come state?\" o usando una domanda divertente.';

  @override
  String get retroCoachWriting =>
      'Siamo in modalita INCOGNITO. Scrivete le card liberamente, nessuno vedra cosa scrivete fino alla fine. Evitate bias!';

  @override
  String get retroCoachVoting =>
      'Review Time! Tutte le card sono visibili. Leggetele e usate i vostri 3 voti per decidere di cosa discutere.';

  @override
  String get retroCoachDiscuss =>
      'Focus sulle card piu votate. Definite Action Item chiari: Chi fa cosa entro quando?';

  @override
  String get retroCoachCompleted =>
      'Ottimo lavoro! La retrospettiva e conclusa. Gli Action Item sono stati inviati al Backlog.';

  @override
  String retroStep(int step, String title) {
    return 'Step $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Focus attuale: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Il template richiede almeno 4 colonne (stile Sailboat)';

  @override
  String retroAddTo(String title) {
    return 'Aggiungi a $title';
  }

  @override
  String get retroNoColumnsConfigured => 'Nessuna colonna configurata.';

  @override
  String get retroNewActionItem => 'Nuovo Action Item';

  @override
  String get retroEditActionItem => 'Modifica Action Item';

  @override
  String get retroActionWhatToDo => 'Cosa bisogna fare?';

  @override
  String get retroActionDescriptionHint => 'Descrivi l\'azione concreta...';

  @override
  String get retroActionRequired => 'Richiesto';

  @override
  String get retroActionLinkedCard => 'Collegato a Retro Card (Opzionale)';

  @override
  String get retroActionNone => 'Nessuna';

  @override
  String get retroActionAssignee => 'Assegnatario';

  @override
  String get retroActionNoAssignee => 'Nessuno';

  @override
  String get retroActionPriority => 'Priorita';

  @override
  String get retroActionDueDate => 'Scadenza (Deadline)';

  @override
  String get retroActionSelectDate => 'Seleziona data...';

  @override
  String get retroActionSupportResources => 'Risorse di Supporto';

  @override
  String get retroActionResourcesHint =>
      'Tool, budget, persone extra necessarie...';

  @override
  String get retroActionMonitoring => 'Modalita di Monitoraggio';

  @override
  String get retroActionMonitoringHint =>
      'Come verificheremo il progresso? (es. Daily, Review...)';

  @override
  String get retroNoActionItems => 'Nessun Action Item ancora creato.';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Rif.';

  @override
  String get retroTableDescription => 'Descrizione';

  @override
  String get retroTableOwner => 'Owner';

  @override
  String get retroTablePriority => 'Priorita';

  @override
  String get retroTableDueDate => 'Scadenza';

  @override
  String get retroTableActions => 'Azioni';

  @override
  String get retroUnassigned => 'Non assegnato';

  @override
  String get retroDeleteActionItem => 'Elimina Action Item';

  @override
  String get retroDeleteConfirm => 'Sei sicuro?';

  @override
  String get retroChooseMethodology => 'Scegli Metodologia';

  @override
  String get retroHidingWhileTyping => 'Nascosto durante la scrittura...';

  @override
  String retroVoteLimitReached(int max) {
    return 'Hai raggiunto il limite di $max voti!';
  }

  @override
  String get retroAddCardHint => 'Quali sono i tuoi pensieri?';

  @override
  String get retroAddCard => 'Aggiungi Card';

  @override
  String get retroTimeUp => 'Tempo Scaduto!';

  @override
  String get retroTimeUpMessage =>
      'Il tempo per questa fase e terminato. Concludi la discussione o estendi il tempo.';

  @override
  String get retroTimeUpOk => 'Ok, ho capito';

  @override
  String get retroStopTimer => 'Ferma Timer';

  @override
  String get retroStartTimer => 'Avvia Timer';

  @override
  String get retroNoRetrosFound => 'Nessuna retrospettiva trovata';

  @override
  String get retroDeleteRetro => 'Elimina Retrospettiva';

  @override
  String get retroParticipantsLabel => 'Partecipanti';

  @override
  String get retroNotesCreated => 'Note create';

  @override
  String retroStatusLabel(String status) {
    return 'Stato: $status';
  }

  @override
  String get retroStatusDraft => 'Bozza';

  @override
  String get retroStatusActive => 'In Corso';

  @override
  String get retroStatusCompleted => 'Completata';

  @override
  String retroDateLabel(String date) {
    return 'Data: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'Nessuna attivita in questa lista';

  @override
  String get smartTodoNoTasksInColumn => 'Nessun task';

  @override
  String get smartTodoUnassigned => 'Non Assegnati';

  @override
  String get smartTodoNewTask => 'Nuova Attivita';

  @override
  String get smartTodoEditTask => 'Modifica';

  @override
  String get smartTodoTaskTitle => 'Titolo attivita';

  @override
  String get smartTodoDescription => 'DESCRIZIONE';

  @override
  String get smartTodoDescriptionHint =>
      'Aggiungi una descrizione dettagliata...';

  @override
  String get smartTodoChecklist => 'CHECKLIST';

  @override
  String get smartTodoAddChecklistItem => 'Aggiungi voce';

  @override
  String get smartTodoAttachments => 'ALLEGATI';

  @override
  String get smartTodoAddLink => 'Aggiungi Link';

  @override
  String get smartTodoComments => 'COMMENTI';

  @override
  String get smartTodoWriteComment => 'Scrivi un commento...';

  @override
  String get smartTodoAddImageTooltip => 'Aggiungi Immagine (URL)';

  @override
  String get smartTodoStatus => 'STATO';

  @override
  String get smartTodoPriority => 'PRIORITA';

  @override
  String get smartTodoAssignees => 'ASSEGNATARI';

  @override
  String get smartTodoNoAssignee => 'Nessuno';

  @override
  String get smartTodoTags => 'TAGS';

  @override
  String get smartTodoNoTags => 'Nessun tag';

  @override
  String get smartTodoDueDate => 'SCADENZA';

  @override
  String get smartTodoSetDate => 'Imposta data';

  @override
  String get smartTodoEffort => 'EFFORT';

  @override
  String get smartTodoEffortHint => 'Punti (es. 5)';

  @override
  String get smartTodoAssignTo => 'Assegna a';

  @override
  String get smartTodoSelectTags => 'Seleziona Tag';

  @override
  String get smartTodoNoTagsAvailable =>
      'Nessun tag disponibile. Creane uno nelle impostazioni.';

  @override
  String get smartTodoNewSubtask => 'Nuovo stato';

  @override
  String get smartTodoAddLinkTitle => 'Aggiungi Link';

  @override
  String get smartTodoLinkName => 'Nome';

  @override
  String get smartTodoLinkUrl => 'URL (https://...)';

  @override
  String get smartTodoCannotOpenLink => 'Impossibile aprire il link';

  @override
  String get smartTodoPasteImage => 'Incolla Immagine';

  @override
  String get smartTodoPasteImageFound => 'Immagine dagli appunti trovata.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Vuoi aggiungere questa immagine dai tuoi appunti?';

  @override
  String get smartTodoYesAdd => 'Si, aggiungi';

  @override
  String get smartTodoAddImage => 'Aggiungi Immagine';

  @override
  String get smartTodoImageUrlHint =>
      'Incolla l\'URL dell\'immagine (es. catturato con CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'URL Immagine';

  @override
  String get smartTodoPasteFromClipboard => 'Incolla da Appunti';

  @override
  String get smartTodoEditComment => 'Modifica commento';

  @override
  String get smartTodoEnterTitle => 'Inserisci un titolo';

  @override
  String get smartTodoUser => 'Utente';

  @override
  String get smartTodoImportTasks => 'Importa Attivita';

  @override
  String get smartTodoImportStep1 => 'Step 1: Scegli la Sorgente';

  @override
  String get smartTodoImportStep2 => 'Step 2: Mappa le Colonne';

  @override
  String get smartTodoImportStep3 => 'Step 3: Revisione & Conferma';

  @override
  String get smartTodoImportRetry => 'Riprova';

  @override
  String get smartTodoImportPasteText => 'Incolla Testo (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Carica File (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Incolla qui i tuoi task. Usa la virgola come separatore.';

  @override
  String get smartTodoImportPasteExample =>
      'Esempio:\nComprare il latte, High, @mario\nFare report, Medium, @luigi';

  @override
  String get smartTodoImportSelectFile => 'Seleziona File CSV';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'File selezionato: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Errore lettura file: $error';
  }

  @override
  String get smartTodoImportNoData => 'Nessun dato trovato';

  @override
  String get smartTodoImportColumnMapping =>
      'Abbiamo rilevato queste colonne. Associa ogni colonna al campo corretto.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Colonna $index: \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Esempio valore: \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Trovati $count task validi. Controlla prima di importare.';
  }

  @override
  String get smartTodoImportBack => 'Indietro';

  @override
  String get smartTodoImportNext => 'Avanti';

  @override
  String smartTodoImportButton(int count) {
    return 'Importa $count Task';
  }

  @override
  String get smartTodoImportEnterText =>
      'Inserisci del testo o carica un file.';

  @override
  String get smartTodoImportNoValidRows => 'Nessuna riga valida trovata.';

  @override
  String get smartTodoImportMapTitle => 'Devi mappare almeno il \"Title\".';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Errore Parsing: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return 'Importati $count task!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Errore Impossibile: $error';
  }

  @override
  String get smartTodoNewTaskDefault => 'Nuovo Task';

  @override
  String get smartTodoRename => 'Rinomina';

  @override
  String get smartTodoAddActivity => 'Aggiungi un\'attivita';

  @override
  String get smartTodoAddColumn => 'Aggiungi Colonna';

  @override
  String get smartTodoParticipantManagement => 'Gestione Partecipanti';

  @override
  String get smartTodoParticipantsTab => 'Partecipanti';

  @override
  String get smartTodoInvitesTab => 'Inviti';

  @override
  String get smartTodoAddParticipant => 'Aggiungi Partecipante';

  @override
  String smartTodoMembers(int count) {
    return 'Membri ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'Nessun invito in sospeso';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Ruolo: $role';
  }

  @override
  String get smartTodoExpired => 'SCADUTO';

  @override
  String smartTodoSentBy(String name) {
    return 'Inviato da $name';
  }

  @override
  String get smartTodoResendEmail => 'Reinvia Email';

  @override
  String get smartTodoRevoke => 'Revoca';

  @override
  String get smartTodoSendingEmail => 'Invio email in corso...';

  @override
  String get smartTodoEmailResent => 'Email reinviata!';

  @override
  String get smartTodoEmailSendError => 'Errore durante l\'invio.';

  @override
  String get smartTodoInvalidSession =>
      'Sessione non valida per inviare email.';

  @override
  String get smartTodoEmail => 'Email';

  @override
  String get smartTodoRole => 'Ruolo';

  @override
  String get smartTodoInviteCreated => 'Invito creato e inviato con successo!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Invito creato, ma email non inviata (controlla login/permessi Google).';

  @override
  String get smartTodoUserAlreadyInvited => 'Utente gia invitato.';

  @override
  String get smartTodoInviteCollaborator => 'Invita Collaboratore';

  @override
  String get smartTodoEditorRole => 'Editor (Puo modificare)';

  @override
  String get smartTodoViewerRole => 'Viewer (Solo visualizzazione)';

  @override
  String get smartTodoSendEmailNotification => 'Invia notifica email';

  @override
  String get smartTodoSend => 'Invia';

  @override
  String get smartTodoInvalidEmail => 'Email non valida';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Utente non autenticato o email mancante';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Necessario login Google per inviare email';

  @override
  String smartTodoInviteSent(String email) {
    return 'Invito inviato a $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Utente gia invitato o invito in attesa.';

  @override
  String get agileAddToSprint => 'Aggiungi a Sprint';

  @override
  String get agileEstimate => 'STIMA';

  @override
  String get agileEstimated => 'Stimata';

  @override
  String get agileEstimateRequired => 'Stima richiesta (click per stimare)';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileMethodologyGuideTitle => 'Guida alle Metodologie Agile';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Scegli la metodologia piu adatta al tuo progetto';

  @override
  String get agileScrumShortDesc =>
      'Sprint a tempo fisso, Velocity, Burndown. Ideale per prodotti con requisiti che evolvono.';

  @override
  String get agileKanbanShortDesc =>
      'Flusso continuo, WIP Limits, Lead Time. Ideale per supporto e richieste continue.';

  @override
  String get agileScrumbanShortDesc =>
      'Mix di Sprint e flusso continuo. Ideale per team che vogliono flessibilita.';

  @override
  String get agileGuide => 'Guida';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Archivio Completate';

  @override
  String get backlogStories => 'stories';

  @override
  String get backlogEstimated => 'stimate';

  @override
  String get backlogShowActive => 'Mostra Backlog attivo';

  @override
  String backlogShowArchive(int count) {
    return 'Mostra Archivio ($count completate)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Archivio ($count)';
  }

  @override
  String get backlogFilters => 'Filtri';

  @override
  String get backlogNewStory => 'Nuova Story';

  @override
  String get backlogSearchHint => 'Cerca per titolo, descrizione o ID...';

  @override
  String get backlogStatusFilter => 'Status: ';

  @override
  String get backlogPriorityFilter => 'Priorita: ';

  @override
  String get backlogTagFilter => 'Tag: ';

  @override
  String get backlogAllStatuses => 'Tutti';

  @override
  String get backlogAllPriorities => 'Tutte';

  @override
  String get backlogRemoveFilters => 'Rimuovi filtri';

  @override
  String get backlogNoStoryFound => 'Nessuna story trovata';

  @override
  String get backlogEmpty => 'Backlog vuoto';

  @override
  String get backlogAddFirstStory => 'Aggiungi la prima User Story';

  @override
  String get kanbanWipExceeded =>
      'WIP Limit superato! Completa alcuni item prima di iniziarne di nuovi.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'Configura WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current di $max max';
  }

  @override
  String get kanbanNoWipLimit => 'Nessun limite WIP';

  @override
  String kanbanItems(int count) {
    return '$count items';
  }

  @override
  String get kanbanEmpty => 'Vuoto';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'WIP Limit: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Imposta il numero massimo di item che possono essere in questa colonna contemporaneamente.';

  @override
  String get kanbanWipLimitLabel => 'WIP Limit';

  @override
  String get kanbanWipLimitHint => 'Lascia vuoto per nessun limite';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Suggerimento: inizia con $count e aggiusta in base al team.';
  }

  @override
  String get kanbanRemoveLimit => 'Rimuovi Limite';

  @override
  String get kanbanWipExceededTitle => 'WIP Limit Superato';

  @override
  String get kanbanWipExceededMessage => 'Spostando ';

  @override
  String get kanbanWipExceededIn => ' in ';

  @override
  String get kanbanWipExceededWillExceed => ' supererai il limite WIP.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Colonna: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Attuale: $current | Limite: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Dopo lo spostamento: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Suggerimento: completa o sposta altri item prima di iniziarne di nuovi per mantenere un flusso di lavoro ottimale.';

  @override
  String get kanbanMoveAnyway => 'Sposta Comunque';

  @override
  String get kanbanWipExplanationTitle => 'WIP Limits';

  @override
  String get kanbanWipWhat => 'Cosa sono i WIP Limits?';

  @override
  String get kanbanWipWhatDesc =>
      'WIP (Work In Progress) Limits sono limiti sul numero di item che possono essere in una colonna contemporaneamente.';

  @override
  String get kanbanWipWhy => 'Perche usarli?';

  @override
  String get kanbanWipBenefit1 =>
      '- Riducono il multitasking e aumentano il focus';

  @override
  String get kanbanWipBenefit2 => '- Evidenziano i colli di bottiglia';

  @override
  String get kanbanWipBenefit3 => '- Migliorano il flusso di lavoro';

  @override
  String get kanbanWipBenefit4 => '- Accelerano il completamento degli item';

  @override
  String get kanbanWipWhatToDo => 'Cosa fare se un limite e superato?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Completa o sposta item esistenti prima di iniziarne di nuovi\n2. Aiuta i colleghi a sbloccare item in review\n3. Analizza perche il limite e stato superato';

  @override
  String get kanbanUnderstood => 'Ho capito';

  @override
  String get kanbanBoardTitle => 'Kanban Board';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Nuovo Sprint';

  @override
  String get sprintNoSprints => 'Nessuno sprint';

  @override
  String get sprintCreateFirst => 'Crea il primo sprint per iniziare';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Avvia Sprint';

  @override
  String get sprintComplete => 'Completa Sprint';

  @override
  String sprintDays(int days) {
    return '${days}g';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'stories';

  @override
  String get sprintPointsPlanned => 'pts';

  @override
  String get sprintPointsCompleted => 'completati';

  @override
  String get sprintVelocity => 'velocity';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}g rimanenti';
  }

  @override
  String get sprintStartButton => 'Avvia';

  @override
  String get sprintCompleteActiveFirst =>
      'Completa lo sprint attivo prima di avviarne un altro';

  @override
  String get sprintEditTitle => 'Modifica Sprint';

  @override
  String get sprintNewTitle => 'Nuovo Sprint';

  @override
  String get sprintNameLabel => 'Nome Sprint';

  @override
  String get sprintNameHint => 'es. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Inserisci un nome';

  @override
  String get sprintGoalLabel => 'Sprint Goal';

  @override
  String get sprintGoalHint => 'Obiettivo dello sprint';

  @override
  String get sprintStartDateLabel => 'Data Inizio';

  @override
  String get sprintEndDateLabel => 'Data Fine';

  @override
  String sprintDuration(int days) {
    return 'Durata: $days giorni';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Velocity media: $velocity pts/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Team: $count membri';
  }

  @override
  String get sprintPlanningTitle => 'Sprint Planning';

  @override
  String get sprintPlanningSubtitle =>
      'Seleziona le storie da completare in questo sprint';

  @override
  String get sprintPlanningSelected => 'Selezionati';

  @override
  String get sprintPlanningSuggested => 'Suggeriti';

  @override
  String get sprintPlanningCapacity => 'Capacita';

  @override
  String get sprintPlanningBasedOnVelocity => 'basato su velocity media';

  @override
  String sprintPlanningDays(int days) {
    return '$days giorni';
  }

  @override
  String get sprintPlanningExceeded =>
      'Attenzione: superata la velocity suggerita';

  @override
  String get sprintPlanningNoStories => 'Nessuna story disponibile nel backlog';

  @override
  String get sprintPlanningNotEstimated => 'Non stimata';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Conferma ($count stories)';
  }

  @override
  String get storyFormEditTitle => 'Modifica Story';

  @override
  String get storyFormNewTitle => 'Nuova User Story';

  @override
  String get storyFormDetailsTab => 'Dettagli';

  @override
  String get storyFormAcceptanceTab => 'Acceptance Criteria';

  @override
  String get storyFormOtherTab => 'Altro';

  @override
  String get storyFormTitleLabel => 'Titolo';

  @override
  String get storyFormTitleHint => 'Breve descrizione della funzionalita';

  @override
  String get storyFormTitleRequired => 'Inserisci un titolo';

  @override
  String get storyFormUseTemplate => 'Usa template User Story';

  @override
  String get storyFormTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get storyFormAsA => 'As a...';

  @override
  String get storyFormAsAHint => 'utente, admin, cliente...';

  @override
  String get storyFormIWant => 'I want...';

  @override
  String get storyFormIWantHint => 'poter fare qualcosa...';

  @override
  String get storyFormIWantRequired => 'Inserisci cosa vuole l\'utente';

  @override
  String get storyFormSoThat => 'So that...';

  @override
  String get storyFormSoThatHint => 'ottenere un beneficio...';

  @override
  String get storyFormDescriptionLabel => 'Descrizione';

  @override
  String get storyFormDescriptionHint => 'Descrizione libera della story';

  @override
  String get storyFormDescriptionRequired => 'Inserisci una descrizione';

  @override
  String get storyFormPreview => 'Anteprima:';

  @override
  String get storyFormEmptyDescription => '(descrizione vuota)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Acceptance Criteria';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Definisci quando la story puo considerarsi completata';

  @override
  String get storyFormAddCriterionHint =>
      'Aggiungi criterio di accettazione...';

  @override
  String get storyFormNoCriteria => 'Nessun criterio definito';

  @override
  String get storyFormSuggestions => 'Suggerimenti:';

  @override
  String get storyFormSuggestion1 => 'I dati vengono salvati correttamente';

  @override
  String get storyFormSuggestion2 => 'L\'utente riceve una conferma';

  @override
  String get storyFormSuggestion3 => 'Il form mostra errori di validazione';

  @override
  String get storyFormSuggestion4 => 'La funzionalita e accessibile da mobile';

  @override
  String get storyFormPriorityLabel => 'Priorita (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Business Value';

  @override
  String get storyFormBusinessValueHigh => 'Alto valore di business';

  @override
  String get storyFormBusinessValueMedium => 'Valore medio';

  @override
  String get storyFormBusinessValueLow => 'Basso valore di business';

  @override
  String get storyFormStoryPointsLabel => 'Stimata in Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Gli Story Points rappresentano la complessita relativa del lavoro.\nUsa la sequenza di Fibonacci: 1 (semplice) -> 21 (molto complessa).';

  @override
  String get storyFormNoPoints => 'Nessuna';

  @override
  String get storyFormPointsSimple => 'Compito rapido e semplice';

  @override
  String get storyFormPointsMedium => 'Compito di media complessita';

  @override
  String get storyFormPointsComplex => 'Compito complesso, richiede analisi';

  @override
  String get storyFormPointsVeryComplex =>
      'Molto complesso, considera di spezzare la story';

  @override
  String get storyFormTagsLabel => 'Tags';

  @override
  String get storyFormAddTagHint => 'Aggiungi tag...';

  @override
  String get storyFormExistingTags => 'Tag esistenti:';

  @override
  String get storyFormAssigneeLabel => 'Assegna a';

  @override
  String get storyFormAssigneeHint => 'Seleziona un membro del team';

  @override
  String get storyFormNotAssigned => 'Non assegnato';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points punti';
  }

  @override
  String get storyDetailDescriptionTitle => 'Descrizione';

  @override
  String get storyDetailNoDescription => 'Nessuna descrizione';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Acceptance Criteria ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Nessun criterio definito';

  @override
  String get storyDetailEstimationTitle => 'Stima';

  @override
  String get storyDetailFinalEstimate => 'Stima finale: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count stime ricevute';
  }

  @override
  String get storyDetailInfoTitle => 'Informazioni';

  @override
  String get storyDetailBusinessValue => 'Business Value';

  @override
  String get storyDetailAssignedTo => 'Assegnato a';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Creato il';

  @override
  String get storyDetailStartedAt => 'Iniziato il';

  @override
  String get storyDetailCompletedAt => 'Completato il';

  @override
  String get landingBadge => 'Strumenti per team agili';

  @override
  String get landingHeroTitle => 'Build better products\nwith Agile Tools';

  @override
  String get landingHeroSubtitle =>
      'Prioritizza, stima e gestisci i tuoi progetti con strumenti collaborativi. Tutto in un unico posto, gratis.';

  @override
  String get landingStartFree => 'Inizia Gratis';

  @override
  String get landingEverythingNeed => 'Tutto ciò di cui hai bisogno';

  @override
  String get landingModernTools => 'Strumenti progettati per team moderni';

  @override
  String get landingSmartTodoBadge => 'Produttività';

  @override
  String get landingSmartTodoTitle => 'Smart Todo List';

  @override
  String get landingSmartTodoSubtitle =>
      'Gestione task intelligente e collaborativa per team moderni';

  @override
  String get landingSmartTodoCollaborativeTitle => 'Liste Task Collaborative';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo trasforma la gestione delle attività quotidiane in un processo fluido e collaborativo. Crea liste, assegna task ai membri del team e monitora il progresso in tempo reale.\n\nIdeale per team distribuiti che necessitano di sincronizzazione continua sulle attività da completare.';

  @override
  String get landingSmartTodoImportTitle => 'Import Flessibile';

  @override
  String get landingSmartTodoImportDesc =>
      'Importa le tue attività da fonti esterne in pochi click. Supporto per file CSV, copia/incolla da Excel o testo libero. Il sistema riconosce automaticamente la struttura dei dati.\n\nMigra facilmente da altri tool senza perdere informazioni o dover reinserire manualmente ogni task.';

  @override
  String get landingSmartTodoShareTitle => 'Condivisione e Inviti';

  @override
  String get landingSmartTodoShareDesc =>
      'Invita colleghi e collaboratori alle tue liste tramite email. Ogni partecipante può visualizzare, commentare e aggiornare lo stato dei task assegnati.\n\nPerfetto per gestire progetti trasversali con stakeholder esterni o team cross-funzionali.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Funzionalità Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Prioritizzazione';

  @override
  String get landingEisenhowerSubtitle =>
      'Il metodo decisionale usato dai leader per gestire il tempo';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'La Matrice di Eisenhower, ideata dal 34° Presidente degli Stati Uniti Dwight D. Eisenhower, divide le attività in quattro quadranti basati su due criteri: urgenza e importanza.\n\nQuesto framework decisionale aiuta a distinguere ciò che richiede attenzione immediata da ciò che contribuisce agli obiettivi a lungo termine.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Decisioni Migliori';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Applicando costantemente la matrice, sviluppi un mindset orientato ai risultati. Impari a dire \"no\" alle distrazioni e a concentrarti su ciò che genera valore reale.\n\nIl nostro strumento digitale rende questo processo immediato: trascina le attività nel quadrante corretto e ottieni una visione chiara delle tue priorità.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Perché usare la Matrice di Eisenhower?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Studi dimostrano che il 80% delle attività quotidiane ricade nei quadranti 3 e 4 (non importanti). La matrice ti aiuta a identificarle e liberare tempo per ciò che conta davvero.';

  @override
  String get landingEisenhowerQuadrants =>
      'Quadrante 1: Urgente + Importante → Fai subito\nQuadrante 2: Non urgente + Importante → Pianifica\nQuadrante 3: Urgente + Non importante → Delega\nQuadrante 4: Non urgente + Non importante → Elimina';

  @override
  String get landingAgileBadge => 'Metodologie';

  @override
  String get landingAgileTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSubtitle =>
      'Implementa le migliori pratiche di sviluppo software iterativo';

  @override
  String get landingAgileIterativeTitle => 'Sviluppo Iterativo e Incrementale';

  @override
  String get landingAgileIterativeDesc =>
      'L\'approccio Agile divide il lavoro in cicli brevi chiamati Sprint, tipicamente di 1-4 settimane. Ogni iterazione produce un incremento funzionante del prodotto.\n\nCon Agile Tools puoi gestire il tuo backlog, pianificare sprint e monitorare la velocity del team in tempo reale.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum è il framework Agile più diffuso. Definisce ruoli (Product Owner, Scrum Master, Team), eventi (Sprint Planning, Daily, Review, Retrospective) e artefatti (Product Backlog, Sprint Backlog).\n\nAgile Tools supporta tutti gli eventi Scrum con strumenti dedicati per ogni cerimonia.';

  @override
  String get landingAgileKanbanTitle => 'Kanban Board';

  @override
  String get landingAgileKanbanDesc =>
      'Il metodo Kanban visualizza il flusso di lavoro attraverso colonne che rappresentano gli stati del processo. Limita il Work In Progress (WIP) per massimizzare il throughput.\n\nLa nostra Kanban board supporta personalizzazione delle colonne, WIP limits e metriche di flusso.';

  @override
  String get landingEstimationBadge => 'Estimation';

  @override
  String get landingEstimationTitle => 'Tecniche di Stima Collaborative';

  @override
  String get landingEstimationSubtitle =>
      'Scegli il metodo più adatto al tuo team per stime accurate';

  @override
  String get landingEstimationFeaturesTitle => 'Estimation Room Features';

  @override
  String get landingRetroBadge => 'Retrospective';

  @override
  String get landingRetroTitle => 'Retrospettive Interattive';

  @override
  String get landingRetroSubtitle =>
      'Strumenti collaborativi in tempo reale: timer, voto anonimo, action items e report AI.';

  @override
  String get landingRetroActionTitle => 'Action Items Tracking';

  @override
  String get landingRetroActionDesc =>
      'Ogni retrospettiva genera action items tracciabili con owner, deadline e stato. Monitora il follow-up nel tempo.';

  @override
  String get landingWorkflowBadge => 'Workflow';

  @override
  String get landingWorkflowTitle => 'Come funziona';

  @override
  String get landingWorkflowSubtitle => 'Inizia in 3 semplici passi';

  @override
  String get landingStep1Title => 'Crea un progetto';

  @override
  String get landingStep1Desc =>
      'Crea il tuo progetto Agile e invita il team. Configura sprint, backlog e board.';

  @override
  String get landingStep2Title => 'Collabora';

  @override
  String get landingStep2Desc =>
      'Stima le user stories insieme, organizza sprint e traccia il progresso in real-time.';

  @override
  String get landingStep3Title => 'Migliora';

  @override
  String get landingStep3Desc =>
      'Analizza le metriche, conduci retrospettive e migliora continuamente il processo.';

  @override
  String get landingCtaTitle => 'Ready to start?';

  @override
  String get landingCtaDesc =>
      'Accedi gratuitamente e inizia a collaborare con il tuo team.';

  @override
  String get landingFooterBrandDesc =>
      'Strumenti collaborativi per team agili.\nPianifica, stima e migliora insieme.';

  @override
  String get landingFooterProduct => 'Prodotto';

  @override
  String get landingFooterResources => 'Risorse';

  @override
  String get landingFooterCompany => 'Azienda';

  @override
  String get landingFooterLegal => 'Legale';

  @override
  String get landingCopyright =>
      '© 2025 Agile Tools. Tutti i diritti riservati.';

  @override
  String get featureSmartImportDesc =>
      'Creazione rapida task con descrizione\nAssegnazione a membri del team\nPriorità e deadline configurabili\nNotifiche di completamento';

  @override
  String get featureImportDesc =>
      'Import da file CSV\nCopia/incolla da Excel\nParsing testo intelligente\nMapping campi automatico';

  @override
  String get featureShareDesc =>
      'Inviti via email\nPermessi configurabili\nCommenti sui task\nStorico modifiche';

  @override
  String get featureSmartTaskCreation => 'Creazione rapida task';

  @override
  String get featureTeamAssignment => 'Assegnazione al team';

  @override
  String get featurePriorityDeadline => 'Priorità e Scadenze';

  @override
  String get featureCompletionNotifications => 'Notifiche completamento';

  @override
  String get featureCsvImport => 'Import CSV';

  @override
  String get featureExcelPaste => 'Copia/Incolla Excel';

  @override
  String get featureSmartParsing => 'Parsing Intelligente';

  @override
  String get featureAutoMapping => 'Mapping Automatico';

  @override
  String get featureEmailInvites => 'Inviti Email';

  @override
  String get featurePermissions => 'Permessi Configurabili';

  @override
  String get featureTaskComments => 'Commenti Task';

  @override
  String get featureHistory => 'Storico Modifiche';

  @override
  String get featureAdvancedFilters => 'Filtri Avanzati';

  @override
  String get featureFullTextSearch => 'Ricerca Full-text';

  @override
  String get featureSorting => 'Ordinamento';

  @override
  String get featureTagsCategories => 'Tag & Categorie';

  @override
  String get featureArchiving => 'Archiviazione';

  @override
  String get featureSort => 'Ordinamento';

  @override
  String get featureDataExport => 'Export Dati';

  @override
  String get landingIntroFeatures =>
      'Sprint Planning con capacità team\nBacklog prioritizzato con drag & drop\nVelocity tracking e burndown chart\nDaily standup facilitato';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog con story points\nSprint Backlog con task breakdown\nRetrospective board integrata\nMetriche Scrum automatiche';

  @override
  String get landingAgileKanbanFeatures =>
      'Colonne personalizzabili\nWIP limits per colonna\nDrag & drop intuitivo\nLead time e cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'Il metodo classico: ogni membro sceglie una carta (1, 2, 3, 5, 8...). Le stime sono rivelate simultaneamente per evitare bias.';

  @override
  String get landingEstimationTShirtTitle => 'T-Shirt Size';

  @override
  String get landingEstimationTShirtSubtitle => 'Taglie relative';

  @override
  String get landingEstimationTShirtDesc =>
      'Stima rapida usando taglie: XS, S, M, L, XL, XXL. Ideale per backlog grooming iniziale o quando serve una stima approssimativa.';

  @override
  String get landingEstimationPertTitle => 'Three-Point (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Ottimista / Probabile / Pessimista';

  @override
  String get landingEstimationPertDesc =>
      'Tecnica statistica: ogni membro fornisce 3 stime (O, M, P). La formula PERT calcola la stima ponderata: (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Bucket System';

  @override
  String get landingEstimationBucketSubtitle => 'Categorizzazione rapida';

  @override
  String get landingEstimationBucketDesc =>
      'Le user stories vengono assegnate a \"bucket\" predefiniti. Ottimo per stimare grandi quantità di item velocemente in sessioni di refinement.';

  @override
  String get landingEstimationChipHiddenVote => 'Voto nascosto';

  @override
  String get landingEstimationChipTimer => 'Timer configurabile';

  @override
  String get landingEstimationChipStats => 'Statistiche real-time';

  @override
  String get landingEstimationChipParticipants => 'Fino a 20 partecipanti';

  @override
  String get landingEstimationChipHistory => 'Storico stime';

  @override
  String get landingEstimationChipExport => 'Export risultati';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'Il formato classico: cosa iniziare a fare, cosa smettere di fare, cosa continuare a fare.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Retrospettiva emotiva: cosa ci ha fatto arrabbiare, rattristare o rallegrare.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - analisi completa dello sprint.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Metafora visuale: vento (aiuti), ancora (ostacoli), rocce (rischi), isola (obiettivi).';

  @override
  String get landingRetroTemplateWentWellTitle => 'Went Well / To Improve';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Formato semplice e diretto: cosa è andato bene e cosa migliorare.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - decisioni concrete per il prossimo sprint.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Action Items Tracking';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Ogni retrospettiva genera action items tracciabili con owner, deadline e stato. Monitora il follow-up nel tempo.';

  @override
  String get landingAgileSectionBadge => 'Metodologie';

  @override
  String get landingAgileSectionTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSectionSubtitle =>
      'Implementa le migliori pratiche di sviluppo software iterativo';

  @override
  String get landingSmartTodoCollabTitle => 'Liste Task Collaborative';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo trasforma la gestione delle attività quotidiane in un processo fluido e collaborativo. Crea liste, assegna task ai membri del team e monitora il progresso in tempo reale.\n\nIdeale per team distribuiti che necessitano di sincronizzazione continua sulle attività da completare.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Creazione rapida task con descrizione\nAssegnazione a membri del team\nPriorità e deadline configurabili\nNotifiche di completamento';

  @override
  String get landingSmartTodoImportFeatures =>
      'Import da file CSV\nCopia/incolla da Excel\nParsing testo intelligente\nMapping campi automatico';

  @override
  String get landingSmartTodoSharingTitle => 'Condivisione e Inviti';

  @override
  String get landingSmartTodoSharingDesc =>
      'Invita colleghi e collaboratori alle tue liste tramite email. Ogni partecipante può visualizzare, commentare e aggiornare lo stato dei task assegnati.\n\nPerfetto per gestire progetti trasversali con stakeholder esterni o team cross-funzionali.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Inviti via email\nPermessi configurabili\nCommenti sui task\nStorico modifiche';

  @override
  String get landingSmartTodoChipFilters => 'Filtri avanzati';

  @override
  String get landingSmartTodoChipSearch => 'Ricerca full-text';

  @override
  String get landingSmartTodoChipSort => 'Ordinamento';

  @override
  String get landingSmartTodoChipTags => 'Tag e categorie';

  @override
  String get landingSmartTodoChipArchive => 'Archiviazione';

  @override
  String get landingSmartTodoChipExport => 'Export dati';

  @override
  String get landingEisenhowerTitle => 'Matrice di Eisenhower';

  @override
  String get landingEisenhowerUrgentTitle => 'Urgente vs Importante';

  @override
  String get landingEisenhowerUrgentDesc =>
      'La Matrice di Eisenhower, ideata dal 34° Presidente degli Stati Uniti Dwight D. Eisenhower, divide le attività in quattro quadranti basati su due criteri: urgenza e importanza.\n\nQuesto framework decisionale aiuta a distinguere ciò che richiede attenzione immediata da ciò che contribuisce agli obiettivi a lungo termine.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Quadrante 1: Urgente + Importante → Fai subito\nQuadrante 2: Non urgente + Importante → Pianifica\nQuadrante 3: Urgente + Non importante → Delega\nQuadrante 4: Non urgente + Non importante → Elimina';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Drag & drop intuitivo\nCollaborazione team in tempo reale\nStatistiche di distribuzione\nExport per reportistica';

  @override
  String get landingEisenhowerUrgentLabel => 'URGENTE';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NON URGENTE';

  @override
  String get landingEisenhowerImportantLabel => 'IMPORTANTE';

  @override
  String get landingEisenhowerNotImportantLabel => 'NON IMPORTANTE';

  @override
  String get landingEisenhowerDoLabel => 'FAI';

  @override
  String get landingEisenhowerDoDesc => 'Crisi, deadline, emergenze';

  @override
  String get landingEisenhowerPlanLabel => 'PIANIFICA';

  @override
  String get landingEisenhowerPlanDesc => 'Strategia, crescita, relazioni';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGA';

  @override
  String get landingEisenhowerDelegateDesc => 'Interruzioni, meeting, email';

  @override
  String get landingEisenhowerEliminateLabel => 'ELIMINA';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Distrazioni, social, perdite di tempo';

  @override
  String get landingFooterFeatures => 'Funzionalità';

  @override
  String get landingFooterPricing => 'Pricing';

  @override
  String get landingFooterChangelog => 'Changelog';

  @override
  String get landingFooterRoadmap => 'Roadmap';

  @override
  String get landingFooterDocs => 'Documentazione';

  @override
  String get landingFooterAgileGuides => 'Guide Agile';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Community';

  @override
  String get landingFooterAbout => 'Chi siamo';

  @override
  String get landingFooterContact => 'Contatti';

  @override
  String get landingFooterJobs => 'Lavora con noi';

  @override
  String get landingFooterPress => 'Press Kit';

  @override
  String get landingFooterPrivacy => 'Privacy Policy';

  @override
  String get landingFooterTerms => 'Termini di Servizio';

  @override
  String get landingFooterCookies => 'Cookie Policy';

  @override
  String get landingFooterGdpr => 'GDPR';
}
