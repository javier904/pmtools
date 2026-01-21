// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Vai alla Home';

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
  String get actionOpen => 'Apri';

  @override
  String get stateLoading => 'Caricamento...';

  @override
  String get stateEmpty => 'Nessun elemento';

  @override
  String get stateError => 'Errore';

  @override
  String get stateSuccess => 'Successo';

  @override
  String get subscriptionCurrent => 'ATTUALE';

  @override
  String get subscriptionRecommended => 'CONSIGLIATO';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get subscriptionPerMonth => '/mese';

  @override
  String get subscriptionPerYear => '/anno';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Risparmi €$amount/anno';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days giorni di prova gratuita';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Progetti illimitati';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count progetti attivi';
  }

  @override
  String get subscriptionUnlimitedLists => 'Liste illimitate';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Liste Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Progetti attivi';

  @override
  String get subscriptionSmartTodoListsLabel => 'Liste Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Task illimitati';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count task per progetto';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Inviti illimitati';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count inviti per progetto';
  }

  @override
  String get subscriptionWithAds => 'Con pubblicità';

  @override
  String get subscriptionWithoutAds => 'Senza pubblicità';

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
  String get appSubtitle => 'Keisen per Team';

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
  String get eisenhowerSearchHint => 'Cerca matrici...';

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
  String get eisenhowerWaitingForVotes => 'In attesa di voti';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total voti';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTA';

  @override
  String get eisenhowerVotedSuccess => 'Hai votato';

  @override
  String get eisenhowerRevealVotes => 'RIVELA VOTI';

  @override
  String get eisenhowerQuickVote => 'Voto Rapido';

  @override
  String get eisenhowerTeamVote => 'Voto Team';

  @override
  String get eisenhowerUrgency => 'Urgenza';

  @override
  String get eisenhowerImportance => 'Importanza';

  @override
  String get eisenhowerUrgencyShort => 'U:';

  @override
  String get eisenhowerImportanceShort => 'I:';

  @override
  String get eisenhowerVotingInProgress => 'VOTAZIONE IN CORSO';

  @override
  String get eisenhowerWaitingForOthers =>
      'In attesa che tutti votino. Il facilitatore rivelerà i voti.';

  @override
  String get eisenhowerReady => 'Pronto';

  @override
  String get eisenhowerWaiting => 'In attesa';

  @override
  String get eisenhowerIndividualVotes => 'VOTI INDIVIDUALI';

  @override
  String get eisenhowerResult => 'RISULTATO';

  @override
  String get eisenhowerAverage => 'MEDIA';

  @override
  String get eisenhowerVotesRevealed => 'Voti Rivelati';

  @override
  String get eisenhowerNextActivity => 'Prossima Attività';

  @override
  String get eisenhowerNoVotesRecorded => 'Nessun voto registrato';

  @override
  String get eisenhowerWaitingForStart => 'In attesa';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Voti anticipati che verranno conteggiati quando il facilitatore avvia la votazione';

  @override
  String get eisenhowerObserverWaiting =>
      'In attesa che il facilitatore avvii la votazione collettiva';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Esprimi il tuo voto in anticipo. Verrà conteggiato quando la votazione sarà avviata.';

  @override
  String get eisenhowerPreVote => 'Pre-vota';

  @override
  String get eisenhowerPreVoted => 'Hai pre-votato';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Avvia la sessione di votazione collettiva. I pre-voti esistenti verranno preservati.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Resetta la votazione cancellando tutti i voti';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Osservando la votazione in corso...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'In attesa che tutti i partecipanti votino';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Tutti hanno votato! Clicca per rivelare i risultati.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Mancano ancora $count voti';
  }

  @override
  String get eisenhowerVotingLocked => 'Votazione chiusa';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'I voti sono stati rivelati. Non è più possibile votare su questa attività.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online di $total partecipanti online';
  }

  @override
  String get eisenhowerVoting => 'Votazione';

  @override
  String get eisenhowerAllActivitiesVoted =>
      'Tutte le attività sono state votate!';

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
  String get sessionName => 'Nome sessione';

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
  String get voteAverageTooltip => 'Media aritmetica dei voti numerici';

  @override
  String get voteMedianTooltip => 'Valore centrale quando i voti sono ordinati';

  @override
  String get voteModeTooltip =>
      'Voto più frequente (il valore scelto più volte)';

  @override
  String get voteVotersTooltip =>
      'Numero totale di partecipanti che hanno votato';

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
  String get retroGuidance => 'Guida alle Retrospettive';

  @override
  String get retroSearchHint => 'Cerca retrospettiva...';

  @override
  String get retroNoResults => 'Nessun risultato per la ricerca';

  @override
  String get retroFilterAll => 'Tutte';

  @override
  String get retroFilterActive => 'Active';

  @override
  String get retroFilterCompleted => 'Completed';

  @override
  String get retroFilterDraft => 'Draft';

  @override
  String get retroDeleteTitle => 'Elimina Retrospettiva';

  @override
  String retroDeleteConfirm(String title) {
    return 'Sei sicuro?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospettiva eliminata con successo';

  @override
  String retroDeleteError(String error) {
    return 'Errore durante l\'eliminazione: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Elimina definitivamente';

  @override
  String get retroNewRetroTitle => 'Nuova Retrospettiva';

  @override
  String get retroLinkToSprint => 'Collega a Sprint?';

  @override
  String get retroNoProjectFound => 'Nessun progetto trovato.';

  @override
  String get retroSelectProject => 'Seleziona Progetto';

  @override
  String get retroSelectSprint => 'Seleziona Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String get retroSessionTitle => 'Titolo Sessione';

  @override
  String get retroSessionTitleHint => 'Es: Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Template';

  @override
  String get retroVotesPerUser => 'Voti per utente:';

  @override
  String get retroActionClose => 'Chiudi';

  @override
  String get retroActionCreate => 'Crea';

  @override
  String get retroStatusDraft => 'Bozza';

  @override
  String get retroStatusActive => 'In Corso';

  @override
  String get retroStatusCompleted => 'Completata';

  @override
  String get retroTemplateStartStopContinue => 'Start, Stop, Continue';

  @override
  String get retroTemplateSailboat => 'Barca a Vela';

  @override
  String get retroTemplate4Ls => '4 Ls';

  @override
  String get retroTemplateStarfish => 'Stella Marina';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Orientata all\'azione: Iniziare, Smettere, Continuare.';

  @override
  String get retroDescSailboat =>
      'Visiva: Vento (spinge), Ancore (frena), Rocce (rischi), Isola (obiettivi).';

  @override
  String get retroDesc4Ls =>
      'Liked (Piaciuto), Learned (Imparato), Lacked (Mancato), Longed For (Desiderato).';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Emotiva: Arrabbiato, Triste, Felice.';

  @override
  String get retroDescDAKI =>
      'Pragmatica: Elimina, Aggiungi, Mantieni, Migliora.';

  @override
  String get retroUsageStartStopContinue =>
      'Ideale per feedback azionabili e focus sui cambiamenti comportamentali.';

  @override
  String get retroUsageSailboat =>
      'Ideale per visualizzare il viaggio del team, obiettivi e rischi. Ottima per il pensiero creativo.';

  @override
  String get retroUsage4Ls =>
      'Riflessiva: Ideale per imparare dal passato ed evidenziare aspetti emotivi e di apprendimento.';

  @override
  String get retroUsageStarfish =>
      'Calibrazione: Ideale per scalare gli sforzi (fare di più/meno), non solo stop/start binari.';

  @override
  String get retroUsageMadSadGlad =>
      'Ideale per check-in emotivi, risolvere conflitti o dopo uno sprint stressante.';

  @override
  String get retroUsageDAKI =>
      'Decisiva: Ideale per fare pulizia. Focus su decisioni concrete di Eliminare o Aggiungere.';

  @override
  String get retroIcebreakerSentiment => 'Voto Sentiment';

  @override
  String get retroIcebreakerOneWord => 'Una Parola';

  @override
  String get retroIcebreakerWeather => 'Meteo';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Vota da 1 a 5 come ti sei sentito durante lo sprint.';

  @override
  String get retroIcebreakerOneWordDesc =>
      'Descrivi lo sprint con una sola parola.';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Scegli un\'icona meteo che rappresenta lo sprint.';

  @override
  String get retroPhaseIcebreaker => 'ICEBREAKER';

  @override
  String get retroPhaseWriting => 'SCRITTURA';

  @override
  String get retroPhaseVoting => 'VOTAZIONE';

  @override
  String get retroPhaseDiscuss => 'DISCUSSIONE';

  @override
  String get retroActionItemsLabel => 'Action Items';

  @override
  String get retroPhaseStart => 'Inizia';

  @override
  String get retroPhaseStop => 'Smetti';

  @override
  String get retroPhaseContinue => 'Continua';

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
  String errorGeneric(String error) {
    return 'Errore: $error';
  }

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
  String get profileUpgrade => 'Passa a Premium';

  @override
  String get profileUpgradePlan => 'Upgrade Piano';

  @override
  String get planFree => 'Gratuito';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Attivo';

  @override
  String get statusTrialing => 'In prova';

  @override
  String get statusPastDue => 'Pagamento scaduto';

  @override
  String get statusPaused => 'In pausa';

  @override
  String get statusCancelled => 'Cancellato';

  @override
  String get statusExpired => 'Scaduto';

  @override
  String get cycleMonthly => 'Mensile';

  @override
  String get cycleQuarterly => 'Trimestrale';

  @override
  String get cycleYearly => 'Annuale';

  @override
  String get cycleLifetime => 'Sempre';

  @override
  String get pricePerMonth => 'mese';

  @override
  String get pricePerQuarter => 'trim';

  @override
  String get pricePerYear => 'anno';

  @override
  String get priceForever => 'sempre';

  @override
  String get priceFree => 'Gratuito';

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
  String get profileDeleteAccount => 'Elimina account';

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
  String get participantAddDirect =>
      'Aggiungi Partecipante Diretto (es. voto palese)';

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
  String get participantYou => '(tu)';

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
  String get inviteCopyLink => 'Copia link';

  @override
  String get inviteRevokeAction => 'Revoca invito';

  @override
  String get inviteDeleteAction => 'Elimina invito';

  @override
  String get inviteRevokeTitle => 'Revocare invito?';

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
  String get inviteLinkCopied => 'Link copiato!';

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
  String get retroIcebreakerTwoTruths => 'Due Verità e una Bugia';

  @override
  String get retroDescTwoTruths => 'Semplice e classico.';

  @override
  String get retroIcebreakerCheckin => 'Check-in Emotivo';

  @override
  String get retroDescCheckin => 'Come si sentono tutti?';

  @override
  String get retroTableActions => 'Azioni';

  @override
  String get retroUnassigned => 'Non assegnato';

  @override
  String get retroDeleteActionItem => 'Elimina Action Item';

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
  String retroTimerMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get retroAddCardButton => 'Aggiungi Card';

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
  String get smartTodoNewTask => 'Nuovo Task';

  @override
  String get smartTodoEditTask => 'Modifica Task';

  @override
  String get smartTodoTaskTitle => 'Titolo task';

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
  String get smartTodoPriority => 'PRIORITÀ';

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
  String get smartTodoSelectTags => 'Seleziona Tags';

  @override
  String get smartTodoNoTagsAvailable => 'Nessun tag disponibile';

  @override
  String get smartTodoNewSubtask => 'Nuovo stato';

  @override
  String get smartTodoAddLinkTitle => 'Aggiungi Link';

  @override
  String get smartTodoLinkName => 'Nome';

  @override
  String get smartTodoLinkUrl => 'URL';

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
  String get smartTodoEditComment => 'Modifica';

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
  String get smartTodoFilterToday => 'Oggi';

  @override
  String get smartTodoFilterMyTasks => 'I Miei Task';

  @override
  String get smartTodoFilterOwner => 'Owner';

  @override
  String get smartTodoViewGlobalTasks => 'Vedi Task Globali';

  @override
  String get smartTodoViewLists => 'Vedi Liste';

  @override
  String get smartTodoNewListDialogTitle => 'Nuova Lista';

  @override
  String get smartTodoTitleLabel => 'Titolo *';

  @override
  String get smartTodoDescriptionLabel => 'Descrizione';

  @override
  String get smartTodoCancel => 'Annulla';

  @override
  String get smartTodoCreate => 'Crea';

  @override
  String get smartTodoSave => 'Salva';

  @override
  String get smartTodoNoListsPresent => 'Nessuna lista presente';

  @override
  String get smartTodoCreateFirstList => 'Crea la tua prima lista per iniziare';

  @override
  String smartTodoMembersCount(int count) {
    return '$count membri';
  }

  @override
  String get smartTodoRenameListTitle => 'Rinomina Lista';

  @override
  String get smartTodoNewNameLabel => 'Nuovo Nome';

  @override
  String get smartTodoDeleteListTitle => 'Elimina Lista';

  @override
  String get smartTodoDeleteListConfirm =>
      'Sei sicuro di voler eliminare questa lista e tutti i suoi task? Questa azione è irreversibile.';

  @override
  String get smartTodoDelete => 'Elimina';

  @override
  String get smartTodoEdit => 'Modifica';

  @override
  String get smartTodoSearchHint => 'Cerca liste...';

  @override
  String get smartTodoSearchTasksHint => 'Cerca...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Nessun risultato per \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'Da Fare';

  @override
  String get smartTodoColumnInProgress => 'In Corso';

  @override
  String get smartTodoColumnDone => 'Fatto';

  @override
  String get smartTodoAllPeople => 'Tutte le persone';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count persone';
  }

  @override
  String get smartTodoFilterByPerson => 'Filtra per persona';

  @override
  String get smartTodoApplyFilters => 'Applica Filtri';

  @override
  String smartTodoError(String error) {
    return 'Errore: $error';
  }

  @override
  String get profileMenuTitle => 'Profilo';

  @override
  String get profileMenuLogout => 'Esci';

  @override
  String get profileLogoutDialogTitle => 'Logout';

  @override
  String get profileLogoutDialogConfirm => 'Sei sicuro di voler uscire?';

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
  String get storyFormTitleLabel => 'Titolo *';

  @override
  String get storyFormTitleHint => 'Es: US-123: Come utente voglio...';

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
  String get storyFormDescriptionHint => 'Criteri di accettazione, note...';

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
  String get landingHeroTitle => 'Build better products\nwith Keisen';

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
      'L\'approccio Agile divide il lavoro in cicli brevi chiamati Sprint, tipicamente di 1-4 settimane. Ogni iterazione produce un incremento funzionante del prodotto.\n\nCon Keisen puoi gestire il tuo backlog, pianificare sprint e monitorare la velocity del team in tempo reale.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum è il framework Agile più diffuso. Definisce ruoli (Product Owner, Scrum Master, Team), eventi (Sprint Planning, Daily, Review, Retrospective) e artefatti (Product Backlog, Sprint Backlog).\n\nKeisen supporta tutti gli eventi Scrum con strumenti dedicati per ogni cerimonia.';

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
  String get landingCopyright => '© 2026 Keisen. Tutti i diritti riservati.';

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

  @override
  String get legalCookieTitle => 'Utilizziamo i cookie';

  @override
  String get legalCookieMessage =>
      'Utilizziamo i cookie per migliorare la tua esperienza e per fini analitici. Continuando, accetti l\'uso dei cookie.';

  @override
  String get legalCookieAccept => 'Accetta tutti';

  @override
  String get legalCookieRefuse => 'Solo necessari';

  @override
  String get legalCookiePolicy => 'Cookie Policy';

  @override
  String get legalPrivacyPolicy => 'Privacy Policy';

  @override
  String get legalTermsOfService => 'Termini di Servizio';

  @override
  String get legalGDPR => 'GDPR';

  @override
  String get legalLastUpdatedLabel => 'Ultimo aggiornamento';

  @override
  String get legalLastUpdatedDate => '18 gennaio 2026';

  @override
  String get legalAcceptTerms =>
      'Accetto i Termini di Servizio e la Privacy Policy';

  @override
  String get legalMustAcceptTerms => 'Devi accettare i termini per continuare';

  @override
  String get legalPrivacyContent =>
      '## 1. Introduzione\nBenvenuto su **Keisen** (\"noi\", \"nostro\", \"la Piattaforma\"). La tua privacy è importante per noi. Questa Informativa sulla Privacy spiega come raccogliamo, utilizziamo, divulghiamo e proteggiamo le tue informazioni quando utilizzi la nostra applicazione web.\n\n## 2. Dati che raccogliamo\nRaccogliamo due tipi di dati e informazioni:\n\n### 2.1 Informazioni fornite dall\'utente\n- **Dati Account:** Quando accedi tramite Google Sign-In o crei un account, raccogliamo il tuo nome, indirizzo email e immagine del profilo.\n- **Contenuti Utente:** Raccogliamo i dati che inserisci volontariamente nella piattaforma, inclusi task, stime, retrospettive, commenti e configurazioni dei team.\n\n### 2.2 Informazioni raccolte automaticamente\n- **Log di sistema:** Indirizzi IP, tipo di browser, pagine visitate e timestamp.\n- **Cookies:** Utilizziamo cookie tecnici essenziali per mantenere la sessione attiva.\n\n## 3. Come utilizziamo i tuoi dati\nUtilizziamo le informazioni raccolte per:\n- Fornire, gestire e mantenere i nostri Servizi.\n- Migliorare, personalizzare ed espandere la nostra Piattaforma.\n- Analizzare come utilizzi il sito web per migliorare l\'esperienza utente.\n- Inviarti email di servizio (es. inviti ai team, aggiornamenti importanti).\n\n## 4. Condivisione dei dati\nNon vendiamo i tuoi dati personali. Condividiamo le informazioni solo con:\n- **Service Provider:** Utilizziamo **Google Firebase** (Google LLC) per l\'hosting, l\'autenticazione e il database. I dati sono trattati secondo la [Privacy Policy di Google](https://policies.google.com/privacy).\n- **Obblighi Legali:** Se richiesto dalla legge o per proteggere i nostri diritti.\n\n## 5. Sicurezza dei dati\nImplementiamo misure di sicurezza tecniche e organizzative standard del settore (come la crittografia in transito) per proteggere i tuoi dati. Tuttavia, nessun metodo di trasmissione su Internet è sicuro al 100%.\n\n## 6. I tuoi diritti\nHai il diritto di:\n- Accedere ai tuoi dati personali.\n- Richiedere la correzione di dati inesatti.\n- Richiedere la cancellazione dei tuoi dati (\"Diritto all\'oblio\").\n- Opporti al trattamento dei tuoi dati.\n\nPer esercitare questi diritti, contattaci a: suppkesien@gmail.com.\n\n## 7. Modifiche a questa Policy\nPotremmo aggiornare questa Privacy Policy di volta in volta. Ti notificheremo di eventuali modifiche pubblicando la nuova Policy su questa pagina.';

  @override
  String get legalTermsContent =>
      '## 1. Accettazione dei Termini\nAccedendo o utilizzando **Keisen**, accetti di essere vincolato da questi Termini di Servizio (\"Termini\"). Se non accetti questi Termini, non devi utilizzare i nostri Servizi.\n\n## 2. Descrizione del Servizio\nKeisen è una piattaforma di collaborazione per team agili che offre strumenti come Smart Todo, Matrice di Eisenhower, Estimation Room e Gestione Processi Agili. Ci riserviamo il diritto di modificare o interrompere il servizio in qualsiasi momento.\n\n## 3. Account Utente\nSei responsabile di mantenere la riservatezza delle credenziali del tuo account e di tutte le attività che avvengono sotto il tuo account. Ci riserviamo il diritto di sospendere o cancellare account che violano questi Termini.\n\n## 4. Comportamento dell\'Utente\nAccetti di non utilizzare il Servizio per:\n- Violare leggi locali, nazionali o internazionali.\n- Caricare contenuti offensivi, diffamatori o illegali.\n- Tentare di accedere non autorizzato ai sistemi della Piattaforma.\n\n## 5. Proprietà Intellettuale\nTutti i diritti di proprietà intellettuale relativi alla Piattaforma e ai suoi contenuti originali (esclusi i contenuti forniti dagli utenti) sono di proprietà esclusiva di Leonardo Torella.\n\n## 6. Limitazione di Responsabilità\nNella misura massima consentita dalla legge, Keisen viene fornito \"così com\'è\" e \"come disponibile\". Non garantiamo che il servizio sarà ininterrotto o privo di errori. Non saremo responsabili per danni indiretti, incidentali o consequenziali derivanti dall\'uso del servizio.\n\n## 7. Legge Applicabile\nQuesti Termini sono regolati dalle leggi dello Stato Italiano.\n\n## 8. Contatti\nPer domande su questi Termini, contattaci a: suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. Cosa sono i Cookie?\nI cookie sono piccoli file di testo che vengono salvati sul tuo dispositivo quando visiti un sito web. Sono ampiamente utilizzati per far funzionare i siti web in modo più efficiente e fornire informazioni ai proprietari del sito.\n\n## 2. Come utilizziamo i Cookie\nUtilizziamo i cookie per diversi scopi:\n\n### 2.1 Cookie Tecnici (Essenziali)\nQuesti cookie sono necessari per il funzionamento del sito web e non possono essere disattivati nei nostri sistemi. Di solito vengono impostati solo in risposta alle azioni da te effettuate che costituiscono una richiesta di servizi, come l\'impostazione delle preferenze di privacy, l\'accesso (Login) o la compilazione di moduli.\n*Esempio:* Cookie di sessione Firebase Auth per mantenere l\'utente loggato.\n\n### 2.2 Cookie di Analisi\nQuesti cookie ci permettono di contare le visite e le fonti di traffico, in modo da poter misurare e migliorare le prestazioni del nostro sito. Tutte le informazioni raccolte da questi cookie sono aggregate e quindi anonime.\n\n## 3. Gestione dei Cookie\nLa maggior parte dei browser web consente di controllare la maggior parte dei cookie attraverso le impostazioni del browser. Tuttavia, se disabiliti i cookie essenziali, alcune parti del nostro Servizio potrebbero non funzionare correttamente (ad esempio, non potrai effettuare il login).\n\n## 4. Cookie di Terze Parti\nUtilizziamo servizi di terze parti come **Google Firebase** che potrebbero impostare i propri cookie. Ti invitiamo a consultare le rispettive informative sulla privacy per maggiori dettagli.';

  @override
  String get legalGdprContent =>
      '## Impegno per la Protezione dei Dati (GDPR)\nIn conformità con il Regolamento Generale sulla Protezione dei Dati (GDPR) dell\'Unione Europea, Keisen si impegna a proteggere i dati personali degli utenti e a garantire la trasparenza nel loro trattamento.\n\n## Titolare del Trattamento\nIl Titolare del Trattamento dei dati è:\n**Keisen Team**\nEmail: suppkesien@gmail.com\n\n## Base Giuridica del Trattamento\nTrattiamo i tuoi dati personali solo quando abbiamo una base giuridica per farlo. Questo include:\n- **Consenso:** Ci hai dato il permesso di trattare i tuoi dati per uno scopo specifico.\n- **Esecuzione di un contratto:** Il trattamento è necessario per fornire i Servizi che hai richiesto (es. utilizzo della piattaforma).\n- **Interesse legittimo:** Il trattamento è necessario per i nostri legittimi interessi (es. sicurezza, miglioramento del servizio), a meno che non prevalgano i tuoi diritti e libertà fondamentali.\n\n## Trasferimento dei Dati\nI tuoi dati sono conservati su server sicuri forniti da Google Cloud Platform (Google Firebase). Google aderisce agli standard di sicurezza internazionali ed è conforme al GDPR attraverso le Clausole Contrattuali Tipo (SCC).\n\n## I Tuoi Diritti GDPR\nCome utente nell\'UE, hai i seguenti diritti:\n1.  **Diritto di accesso:** Hai il diritto di richiedere copie dei tuoi dati personali.\n2.  **Diritto di rettifica:** Hai il diritto di richiedere la correzione di informazioni che ritieni inesatte.\n3.  **Diritto alla cancellazione (\"Diritto all\'oblio\"):** Hai il diritto di richiedere la cancellazione dei tuoi dati personali, a determinate condizioni.\n4.  **Diritto alla limitazione del trattamento:** Hai il diritto di richiedere la limitazione del trattamento dei tuoi dati.\n5.  **Diritto alla portabilità dei dati:** Hai il diritto di richiedere il trasferimento dei dati che abbiamo raccolto a un\'altra organizzazione o direttamente a te.\n\n## Esercizio dei Diritti\nSe desideri esercitare uno di questi diritti, ti preghiamo di contattarci a: suppkesien@gmail.com. Risponderemo alla tua richiesta entro un mese.';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileExportData => 'Esporta i miei dati';

  @override
  String get profileDeleteAccountConfirm =>
      'Sei sicuro di voler eliminare definitivamente il tuo account? Questa azione è irreversibile.';

  @override
  String get subscriptionTitle => 'Abbonamento';

  @override
  String get subscriptionTabPlans => 'Piani';

  @override
  String get subscriptionTabUsage => 'Utilizzo';

  @override
  String get subscriptionTabBilling => 'Fatturazione';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count progetti attivi';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count liste Smart Todo';
  }

  @override
  String get subscriptionCurrentPlan => 'Piano attuale';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Upgrade a $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Downgrade a $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Scegli $plan';
  }

  @override
  String get subscriptionMonthly => 'Mensile';

  @override
  String get subscriptionYearly => 'Annuale (-17%)';

  @override
  String get subscriptionLimitReached => 'Limite raggiunto';

  @override
  String get subscriptionLimitProjects =>
      'Hai raggiunto il limite massimo di progetti per il tuo piano. Passa a Premium per creare più progetti.';

  @override
  String get subscriptionLimitLists =>
      'Hai raggiunto il limite massimo di liste per il tuo piano. Passa a Premium per creare più liste.';

  @override
  String get subscriptionLimitTasks =>
      'Hai raggiunto il limite massimo di task per questo progetto. Passa a Premium per aggiungere più task.';

  @override
  String get subscriptionLimitInvites =>
      'Hai raggiunto il limite massimo di inviti per questo progetto. Passa a Premium per invitare più persone.';

  @override
  String get subscriptionLimitEstimations =>
      'Hai raggiunto il limite massimo di sessioni di stima. Passa a Premium per crearne di più.';

  @override
  String get subscriptionLimitDefault =>
      'Hai raggiunto il limite del tuo piano attuale.';

  @override
  String get subscriptionCurrentUsage => 'Utilizzo attuale';

  @override
  String get subscriptionUpgradeToPremium => 'Passa a Premium';

  @override
  String get subscriptionBenefitProjects => '30 progetti attivi';

  @override
  String get subscriptionBenefitLists => '30 liste Smart Todo';

  @override
  String get subscriptionBenefitTasks => '100 task per progetto';

  @override
  String get subscriptionBenefitNoAds => 'Nessuna pubblicità';

  @override
  String get subscriptionStartingFrom => 'A partire da €4.99/mese';

  @override
  String get subscriptionLater => 'Più tardi';

  @override
  String get subscriptionViewPlans => 'Vedi piani';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Puoi creare ancora 1 $entity';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Puoi creare ancora $count $entity';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Utilizzati: $count';
  }

  @override
  String get subscriptionUnlimited => 'Illimitati';

  @override
  String subscriptionLimit(int count) {
    return 'Limite: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Utilizzo del piano';

  @override
  String get subscriptionRefresh => 'Aggiorna';

  @override
  String get subscriptionAdsActive => 'Pubblicità attive';

  @override
  String get subscriptionRemoveAds =>
      'Passa a Premium per rimuovere le pubblicità';

  @override
  String get subscriptionNoAds => 'Nessuna pubblicità';

  @override
  String get subscriptionLoadError => 'Impossibile caricare i dati di utilizzo';

  @override
  String get subscriptionAdLabel => 'AD';

  @override
  String get subscriptionAdPlaceholder => 'Ad Placeholder';

  @override
  String get subscriptionDevEnvironment => '(Ambiente di sviluppo)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Rimuovi le pubblicità e sblocca funzionalità avanzate';

  @override
  String get subscriptionUpgradeButton => 'Upgrade';

  @override
  String subscriptionLoadingError(String error) {
    return 'Errore nel caricamento: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Completa il pagamento nella finestra aperta';

  @override
  String subscriptionError(String error) {
    return 'Errore: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Conferma downgrade';

  @override
  String get subscriptionDowngradeMessage =>
      'Sei sicuro di voler passare al piano Free?\n\nIl tuo abbonamento rimarrà attivo fino alla fine del periodo corrente, dopodiché passerai automaticamente al piano Free.\n\nNon perderai i tuoi dati, ma alcune funzionalità potrebbero essere limitate.';

  @override
  String get subscriptionCancel => 'Annulla';

  @override
  String get subscriptionConfirmDowngradeButton => 'Conferma downgrade';

  @override
  String get subscriptionCancelled =>
      'Abbonamento cancellato. Rimarrà attivo fino a fine periodo.';

  @override
  String subscriptionPortalError(String error) {
    return 'Errore apertura portale: $error';
  }

  @override
  String get subscriptionRetry => 'Riprova';

  @override
  String get subscriptionChooseRightPlan => 'Scegli il piano giusto per te';

  @override
  String get subscriptionStartFree => 'Inizia gratis, fai upgrade quando vuoi';

  @override
  String subscriptionPlan(String plan) {
    return 'Piano $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Piano Attuale: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Trial fino al $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Rinnovo: $date';
  }

  @override
  String get subscriptionManage => 'Gestisci';

  @override
  String get subscriptionLoginRequired =>
      'Effettua il login per vedere l\'utilizzo';

  @override
  String get subscriptionSuggestion => 'Suggerimento';

  @override
  String get subscriptionSuggestionText =>
      'Passa a Premium per sbloccare più progetti, rimuovere le pubblicità e aumentare i limiti. Prova gratis per 7 giorni!';

  @override
  String get subscriptionPaymentManagement => 'Gestione pagamenti';

  @override
  String get subscriptionNoActiveSubscription => 'Nessun abbonamento attivo';

  @override
  String get subscriptionUsingFreePlan => 'Stai usando il piano Free';

  @override
  String get subscriptionViewPaidPlans => 'Vedi piani a pagamento';

  @override
  String get subscriptionPaymentMethod => 'Metodo di pagamento';

  @override
  String get subscriptionEditPaymentMethod =>
      'Modifica carta o metodo di pagamento';

  @override
  String get subscriptionInvoices => 'Fatture';

  @override
  String get subscriptionViewInvoices => 'Visualizza e scarica le fatture';

  @override
  String get subscriptionCancelSubscription => 'Cancella abbonamento';

  @override
  String get subscriptionAccessUntilEnd =>
      'L\'accesso rimarrà attivo fino a fine periodo';

  @override
  String get subscriptionPaymentHistory => 'Storico pagamenti';

  @override
  String get subscriptionNoPayments => 'Nessun pagamento registrato';

  @override
  String get subscriptionCompleted => 'Completato';

  @override
  String get subscriptionDateNotAvailable => 'Data non disponibile';

  @override
  String get subscriptionFaq => 'Domande frequenti';

  @override
  String get subscriptionFaqCancel => 'Posso cancellare in qualsiasi momento?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Sì, puoi cancellare il tuo abbonamento in qualsiasi momento. L\'accesso rimarrà attivo fino alla fine del periodo pagato.';

  @override
  String get subscriptionFaqTrial => 'Come funziona il trial gratuito?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Con il trial gratuito hai accesso completo a tutte le funzionalità del piano scelto. Al termine del periodo di prova, inizierà automaticamente l\'abbonamento a pagamento.';

  @override
  String get subscriptionFaqChange => 'Posso cambiare piano?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Puoi fare upgrade o downgrade in qualsiasi momento. L\'importo verrà calcolato in modo proporzionale.';

  @override
  String get subscriptionFaqData => 'I miei dati sono al sicuro?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Assolutamente sì. Non perderai mai i tuoi dati, anche se passi a un piano inferiore. Alcune funzionalità potrebbero essere limitate, ma i dati restano sempre accessibili.';

  @override
  String get subscriptionStatusActive => 'Attivo';

  @override
  String get subscriptionStatusTrialing => 'In prova';

  @override
  String get subscriptionStatusPastDue => 'Pagamento in ritardo';

  @override
  String get subscriptionStatusCancelled => 'Cancellato';

  @override
  String get subscriptionStatusExpired => 'Scaduto';

  @override
  String get subscriptionStatusPaused => 'In pausa';

  @override
  String get subscriptionStatus => 'Stato';

  @override
  String get subscriptionStarted => 'Iniziato';

  @override
  String get subscriptionNextRenewal => 'Prossimo rinnovo';

  @override
  String get subscriptionTrialEnd => 'Fine trial';

  @override
  String get toolSectionTitle => 'Strumenti';

  @override
  String get deadlineTitle => 'Scadenze';

  @override
  String get deadlineNoUpcoming => 'Nessuna scadenza imminente';

  @override
  String get deadlineAll => 'Tutti';

  @override
  String get deadlineToday => 'Oggi';

  @override
  String get deadlineTomorrow => 'Domani';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Task';

  @override
  String get favTitle => 'Preferiti';

  @override
  String get favFilterAll => 'Tutti';

  @override
  String get favFilterTodo => 'Liste Todo';

  @override
  String get favFilterMatrix => 'Matrici';

  @override
  String get favFilterProject => 'Progetti';

  @override
  String get favFilterPoker => 'Stime';

  @override
  String get actionRemoveFromFavorites => 'Rimuovi dai preferiti';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'Nessun preferito trovato';

  @override
  String get favTypeTodo => 'Lista Todo';

  @override
  String get favTypeMatrix => 'Matrice Eisenhower';

  @override
  String get favTypeProject => 'Progetto Agile';

  @override
  String get favTypeRetro => 'Retrospective';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Strumento';

  @override
  String get deadline2Days => '2 Giorni';

  @override
  String get deadline3Days => '3 Giorni';

  @override
  String get deadline5Days => '5 Giorni';

  @override
  String get deadlineConfigTitle => 'Configura Scorciatoie';

  @override
  String get deadlineConfigDesc =>
      'Scegli gli intervalli di tempo da mostrare nell\'intestazione.';

  @override
  String get smartTodoClose => 'Chiudi';

  @override
  String get smartTodoDone => 'Fatto';

  @override
  String get smartTodoAdd => 'Aggiungi';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Login Google necessario per inviare email';

  @override
  String get exceptionUserNotAuthenticated => 'Utente non autenticato';

  @override
  String errorLoginFailed(String error) {
    return 'Errore login: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Partecipanti ($count)';
  }

  @override
  String get actionReopen => 'Riapri';

  @override
  String get retroWaitingForFacilitator =>
      'In attesa che il facilitatore avvii la sessione...';

  @override
  String get retroGeneratingSheet => 'Generazione Google Sheet in corso...';

  @override
  String get retroExportSuccess => 'Export completato!';

  @override
  String get retroExportError => 'Errore durante l\'export su Sheets.';

  @override
  String get retroReportCopied =>
      'Report copiato negli appunti! Incollalo in Excel o Note.';

  @override
  String get retroReopenTitle => 'Riapri Retrospettiva';

  @override
  String get retroReopenConfirm =>
      'Sei sicuro di voler riaprire la retrospettiva? Tornerà alla fase di Discussione.';

  @override
  String get errorAuthRequired => 'Autenticazione richiesta';

  @override
  String get errorRetroIdMissing => 'ID Retrospettiva mancante';

  @override
  String get pokerInviteAccepted =>
      'Invito accettato! Verrai reindirizzato alla sessione.';

  @override
  String get pokerInviteRefused => 'Invito rifiutato';

  @override
  String get pokerConfirmRefuseTitle => 'Rifiuta Invito';

  @override
  String get pokerConfirmRefuseContent =>
      'Sei sicuro di voler rifiutare questo invito?';

  @override
  String get pokerVerifyingInvite => 'Verifica invito in corso...';

  @override
  String get actionBackHome => 'Torna alla Home';

  @override
  String get actionSignin => 'Accedi';

  @override
  String get exceptionStoryNotFound => 'Story non trovata';

  @override
  String get exceptionNoTasksInProject => 'Nessun task trovato nel progetto';

  @override
  String get exceptionInvitePending =>
      'Esiste già un invito in attesa per questa email';

  @override
  String get exceptionAlreadyParticipant => 'L\'utente è già un partecipante';

  @override
  String get exceptionInviteInvalid => 'Invito non valido o scaduto';

  @override
  String get exceptionInviteCalculated => 'Invito scaduto';

  @override
  String get exceptionInviteWrongUser => 'Invito destinato ad un altro utente';

  @override
  String get todoImportTasks => 'Importa Task';

  @override
  String get todoExportSheets => 'Esporta su Sheets';

  @override
  String get todoDeleteColumnTitle => 'Elimina Colonna';

  @override
  String get todoDeleteColumnConfirm =>
      'Sei sicuro? I task in questa colonna andranno persi.';

  @override
  String get exceptionListNotFound => 'Lista non trovata';

  @override
  String get langItalian => 'Italiano';

  @override
  String get langEnglish => 'English';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get jsonExportLabel => 'Scarica una copia JSON dei tuoi dati';

  @override
  String errorExporting(String error) {
    return 'Errore durante l\'export: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Lista';

  @override
  String get smartTodoViewResource => 'Per Risorsa';

  @override
  String get smartTodoInviteTooltip => 'Invita';

  @override
  String get smartTodoOptionsTooltip => 'Altre Opzioni';

  @override
  String get smartTodoActionImport => 'Importa Task';

  @override
  String get smartTodoActionExportSheets => 'Esporta su Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Elimina Colonna';

  @override
  String get smartTodoDeleteColumnContent =>
      'Sei sicuro? I task in questa colonna non saranno più visibili.';

  @override
  String get smartTodoNewColumn => 'Nuova Colonna';

  @override
  String get smartTodoColumnNameHint => 'Nome Colonna';

  @override
  String get smartTodoColorLabel => 'COLORE';

  @override
  String get smartTodoMarkAsDone => 'Segna come completato';

  @override
  String get smartTodoColumnDoneDescription =>
      'I task in questa colonna saranno considerati \'Fatti\' (barrati).';

  @override
  String get smartTodoListSettingsTitle => 'Impostazioni Lista';

  @override
  String get smartTodoRenameList => 'Rinomina Lista';

  @override
  String get smartTodoManageTags => 'Gestisci Tag';

  @override
  String get smartTodoDeleteList => 'Elimina Lista';

  @override
  String get smartTodoEditPermissionError =>
      'Puoi modificare solo i task a te assegnati';

  @override
  String errorDeletingAccount(String error) {
    return 'Errore durante l\'eliminazione dell\'account: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'È necessario aver effettuato l\'accesso di recente. Per favore, esci e rientra prima di eliminare l\'account.';

  @override
  String actionGuide(String framework) {
    return 'Guida $framework';
  }

  @override
  String get actionExportSheets => 'Esporta su Google Sheets';

  @override
  String get actionAuditLog => 'Audit Log';

  @override
  String get actionInviteMember => 'Invita Membro';

  @override
  String get actionSettings => 'Impostazioni';

  @override
  String get retroSelectIcebreakerTooltip =>
      'Seleziona l\'attività per rompere il ghiaccio';

  @override
  String get retroIcebreakerLabel => 'Attività iniziale';

  @override
  String get retroTimePhasesOptional => 'Timer Fasi (Opzionale)';

  @override
  String get retroTimePhasesDesc =>
      'Imposta la durata in minuti per ogni fase:';

  @override
  String get retroIcebreakerSectionTitle => 'Icebreaker';

  @override
  String get retroBoardTitle => 'Bacheca Retrospettive';

  @override
  String get searchPlaceholder => 'Cerca ovunque...';

  @override
  String get searchResultsTitle => 'Risultati Ricerca';

  @override
  String searchNoResults(Object query) {
    return 'Nessun risultato per \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Progetto';

  @override
  String get searchResultTypeTodo => 'Lista ToDo';

  @override
  String get searchResultTypeRetro => 'Retrospettiva';

  @override
  String get searchResultTypeEisenhower => 'Matrice Eisenhower';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Torna alla Dashboard';

  @override
  String get smartTodoAddItem => 'Aggiungi voce';

  @override
  String get smartTodoAddImageUrl => 'Aggiungi Immagine (URL)';

  @override
  String get smartTodoNone => 'Nessuno';

  @override
  String get smartTodoPointsHint => 'Punti (es. 5)';

  @override
  String get smartTodoNewItem => 'Nuova voce';

  @override
  String get smartTodoDeleteComment => 'Elimina';

  @override
  String get priorityHigh => 'ALTA';

  @override
  String get priorityMedium => 'MEDIA';

  @override
  String get priorityLow => 'BASSA';

  @override
  String get exportToEstimation => 'Esporta verso Stima';

  @override
  String get exportToEstimationDesc =>
      'Crea una sessione di stima con questi task';

  @override
  String get exportToEisenhower => 'Invia a Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Crea una matrice Eisenhower con questi task';

  @override
  String get selectTasksToExport => 'Seleziona Task';

  @override
  String get selectTasksToExportDesc => 'Scegli quali task includere';

  @override
  String get noTasksSelected => 'Nessun task selezionato';

  @override
  String get selectAtLeastOne => 'Seleziona almeno un task';

  @override
  String get createEstimationSession => 'Crea Sessione di Stima';

  @override
  String tasksSelectedCount(int count) {
    return '$count task selezionati';
  }

  @override
  String get exportSuccess => 'Esportato con successo';

  @override
  String get exportFromEstimation => 'Esporta in Lista';

  @override
  String get exportFromEstimationDesc =>
      'Esporta le storie stimate in una lista Smart Todo';

  @override
  String get selectDestinationList => 'Seleziona lista di destinazione';

  @override
  String get createNewList => 'Crea nuova lista';

  @override
  String get existingList => 'Lista esistente';

  @override
  String get listName => 'Nome lista';

  @override
  String get listNameHint => 'Inserisci un nome per la nuova lista';

  @override
  String get selectList => 'Seleziona lista';

  @override
  String get selectListHint => 'Scegli una lista';

  @override
  String get noListsAvailable =>
      'Nessuna lista disponibile. Ne verrà creata una nuova.';

  @override
  String storiesSelectedCount(int count) {
    return '$count storie selezionate';
  }

  @override
  String get selectAll => 'Seleziona tutti';

  @override
  String get deselectAll => 'Deseleziona tutti';

  @override
  String get importStories => 'Importa Storie';

  @override
  String storiesImportedCount(int count) {
    return '$count storie importate';
  }

  @override
  String get noEstimatedStories => 'Nessuna storia con stime da importare';

  @override
  String get selectDestinationMatrix => 'Seleziona Matrice Destinazione';

  @override
  String get existingMatrix => 'Matrice Esistente';

  @override
  String get createNewMatrix => 'Crea Nuova Matrice';

  @override
  String get matrixName => 'Nome Matrice';

  @override
  String get matrixNameHint => 'Inserisci un nome per la nuova matrice';

  @override
  String get selectMatrix => 'Seleziona Matrice';

  @override
  String get selectMatrixHint => 'Scegli una matrice di destinazione';

  @override
  String get noMatricesAvailable =>
      'Nessuna matrice disponibile. Creane una nuova.';

  @override
  String activitiesCreated(int count) {
    return '$count attività create';
  }

  @override
  String get importFromEisenhower => 'Importa da Eisenhower';

  @override
  String get importFromEisenhowerDesc =>
      'Aggiungi i task prioritizzati a questa lista';

  @override
  String get quadrantQ1 => 'Urgente & Importante';

  @override
  String get quadrantQ2 => 'Non Urgente & Importante';

  @override
  String get quadrantQ3 => 'Urgente & Non Importante';

  @override
  String get quadrantQ4 => 'Non Urgente & Non Importante';

  @override
  String get warningQ4Tasks =>
      'I task Q4 di solito non valgono la pena. Sei sicuro?';

  @override
  String get priorityMappingInfo =>
      'Mappatura priorità: Q1=Alta, Q2=Media, Q3/Q4=Bassa';

  @override
  String get selectColumns => 'Seleziona Colonne';

  @override
  String get allTasks => 'Tutti i Task';

  @override
  String get filterByColumn => 'Filtra per colonna';

  @override
  String get exportFromEisenhower => 'Esporta da Eisenhower';

  @override
  String get exportFromEisenhowerDesc =>
      'Seleziona le attività da esportare su Smart Todo';

  @override
  String get filterByQuadrant => 'Filtra per quadrante:';

  @override
  String get allActivities => 'Tutte';

  @override
  String activitiesSelectedCount(int count) {
    return '$count attività selezionate';
  }

  @override
  String get noActivitiesSelected => 'Nessuna attività in questo filtro';

  @override
  String get unvoted => 'NON VOTATA';

  @override
  String tasksCreated(int count) {
    return '$count task creati';
  }

  @override
  String get exportToUserStories => 'Esporta in User Stories';

  @override
  String get exportToUserStoriesDesc =>
      'Crea user stories in un progetto Agile';

  @override
  String get selectDestinationProject => 'Seleziona Progetto Destinazione';

  @override
  String get existingProject => 'Progetto Esistente';

  @override
  String get createNewProject => 'Crea Nuovo Progetto';

  @override
  String get projectName => 'Nome Progetto';

  @override
  String get projectNameHint => 'Inserisci un nome per il nuovo progetto';

  @override
  String get selectProject => 'Seleziona Progetto';

  @override
  String get selectProjectHint => 'Scegli un progetto di destinazione';

  @override
  String get noProjectsAvailable =>
      'Nessun progetto disponibile. Creane uno nuovo.';

  @override
  String get userStoryFieldMappingInfo =>
      'Mappatura: Titolo → Titolo story, Descrizione → Descrizione story, Effort → Story points, Priorità → Business value';

  @override
  String storiesCreated(int count) {
    return '$count stories create';
  }

  @override
  String get configureNewProject => 'Configura Nuovo Progetto';

  @override
  String get exportToAgileSprint => 'Esporta in Sprint';

  @override
  String get exportToAgileSprintDesc =>
      'Aggiungi le stories stimate a uno sprint Agile';

  @override
  String get selectSprint => 'Seleziona Sprint';

  @override
  String get selectSprintHint => 'Scegli uno sprint di destinazione';

  @override
  String get noSprintsAvailable =>
      'Nessuno sprint disponibile. Crea prima uno sprint in pianificazione.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Mappatura: Titolo → Titolo story, Descrizione → Descrizione, Stima → Story points';

  @override
  String get exportToSprint => 'Esporta verso Sprint';

  @override
  String totalStoryPoints(int count) {
    return '$count story points totali';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count stories aggiunte a $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count stories aggiunte al progetto $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Trasforma le attività Eisenhower in User Stories';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Crea una sessione di stima dalle attività';

  @override
  String get selectedActivities => 'attività selezionate';

  @override
  String get noActivitiesToExport => 'Nessuna attività da esportare';

  @override
  String get hiddenQ4Activities => 'Nascoste';

  @override
  String get q4Activities => 'attività Q4 (Elimina)';

  @override
  String get showQ4 => 'Mostra Q4';

  @override
  String get hideQ4 => 'Nascondi Q4';

  @override
  String get showingAllActivities => 'Mostrando tutte le attività';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importanza→Business Value.';

  @override
  String get estimationExportInfo =>
      'Le attività verranno aggiunte come storie da stimare. La priorità Q non verrà trasferita.';

  @override
  String get createSession => 'Crea Sessione';

  @override
  String get estimationType => 'Tipo di stima';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count attività aggiunte a $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count attività aggiunte al progetto $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Sessione di stima creata con $count attività';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count attività esportate nello sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count attività esportate nella sessione di stima $sessionName';
  }

  @override
  String get archiveAction => 'Archivia';

  @override
  String get archiveRestoreAction => 'Ripristina';

  @override
  String get archiveShowArchived => 'Mostra archiviati';

  @override
  String get archiveHideArchived => 'Nascondi archiviati';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Archivia $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Sei sicuro di voler archiviare questo elemento? Potrà essere ripristinato in seguito.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Ripristina $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Vuoi ripristinare questo elemento dall\'archivio?';

  @override
  String get archiveSuccessMessage => 'Elemento archiviato con successo';

  @override
  String get archiveRestoreSuccessMessage =>
      'Elemento ripristinato con successo';

  @override
  String get archiveErrorMessage => 'Errore durante l\'archiviazione';

  @override
  String get archiveRestoreErrorMessage => 'Errore durante il ripristino';

  @override
  String get archiveFilterLabel => 'Archivio';

  @override
  String get archiveFilterActive => 'Attivi';

  @override
  String get archiveFilterArchived => 'Archiviati';

  @override
  String get archiveFilterAll => 'Tutti';

  @override
  String get archiveBadge => 'Archiviato';

  @override
  String get archiveEmptyMessage => 'Nessun elemento archiviato';

  @override
  String get completeAction => 'Completa';

  @override
  String get reopenAction => 'Riapri';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Completa $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Sei sicuro di voler completare questo elemento?';

  @override
  String get completeSuccessMessage => 'Elemento completato con successo';

  @override
  String get reopenSuccessMessage => 'Elemento riaperto con successo';

  @override
  String get completedBadge => 'Completato';

  @override
  String get inviteNewInvite => 'NUOVO INVITO';

  @override
  String get inviteRole => 'Ruolo:';

  @override
  String get inviteSendEmailNotification => 'Invia email di notifica';

  @override
  String get inviteSendInvite => 'Invia Invito';

  @override
  String get inviteLink => 'Link di invito:';

  @override
  String get inviteList => 'INVITI';

  @override
  String get inviteResend => 'Reinvia';

  @override
  String get inviteRevokeMessage => 'L\'invito non sarà più valido.';

  @override
  String get inviteResent => 'Invito reinviato';

  @override
  String inviteSentByEmail(String email) {
    return 'Invito inviato via email a $email';
  }

  @override
  String get inviteStatusPending => 'In attesa';

  @override
  String get inviteStatusAccepted => 'Accettato';

  @override
  String get inviteStatusDeclined => 'Rifiutato';

  @override
  String get inviteStatusExpired => 'Scaduto';

  @override
  String get inviteStatusRevoked => 'Revocato';

  @override
  String get inviteGmailAuthTitle => 'Autorizzazione Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Per inviare email di invito, è necessario ri-autenticarsi con Google.\n\nVuoi procedere?';

  @override
  String get inviteGmailAuthNo => 'No, solo link';

  @override
  String get inviteGmailAuthYes => 'Autorizza';

  @override
  String get inviteGmailNotAvailable =>
      'Autorizzazione Gmail non disponibile. Prova a fare logout e login.';

  @override
  String get inviteGmailNoPermission => 'Permesso Gmail non concesso.';

  @override
  String get inviteEnterEmail => 'Inserisci un\'email';

  @override
  String get inviteInvalidEmail => 'Email non valida';

  @override
  String get pendingInvites => 'Inviti in Sospeso';

  @override
  String get noPendingInvites => 'Nessun invito in sospeso';

  @override
  String invitedBy(String name) {
    return 'Invitato da $name';
  }

  @override
  String get inviteOpenInstance => 'Apri';

  @override
  String get inviteAcceptFirst => 'Accetta l\'invito per aprire';

  @override
  String get inviteAccept => 'Accetta';

  @override
  String get inviteDecline => 'Rifiuta';

  @override
  String get inviteAcceptedSuccess => 'Invito accettato con successo!';

  @override
  String get inviteAcceptedError => 'Errore nell\'accettare l\'invito';

  @override
  String get inviteDeclinedSuccess => 'Invito rifiutato';

  @override
  String get inviteDeclineTitle => 'Rifiutare l\'invito?';

  @override
  String get inviteDeclineMessage =>
      'Sei sicuro di voler rifiutare questo invito?';

  @override
  String expiresInHours(int hours) {
    return 'Scade in ${hours}h';
  }

  @override
  String expiresInDays(int days) {
    return 'Scade in ${days}g';
  }

  @override
  String get close => 'Chiudi';

  @override
  String get cancel => 'Annulla';

  @override
  String get raciTitle => 'Matrice RACI';

  @override
  String get raciNoActivities => 'Nessuna attività disponibile';

  @override
  String get raciAddActivity => 'Aggiungi Attività';

  @override
  String get raciAddColumn => 'Aggiungi Colonna';

  @override
  String get raciActivities => 'ATTIVITÀ';

  @override
  String get raciAssignRole => 'Assegna ruolo';

  @override
  String get raciNone => 'Nessuno';

  @override
  String get raciSaving => 'Salvataggio...';

  @override
  String get raciSaveChanges => 'Salva Modifiche';

  @override
  String get raciSavedSuccessfully => 'Modifiche salvate correttamente';

  @override
  String get raciErrorSaving => 'Errore salvataggio';

  @override
  String get raciMissingAccountable => 'Manca Accountable (A)';

  @override
  String get raciOnlyOneAccountable => 'Un solo Accountable per attività';

  @override
  String get raciDuplicateRoles => 'Ruoli duplicati';

  @override
  String get raciNoResponsible => 'Nessun Responsible (R) assegnato';

  @override
  String get raciTooManyInformed => 'Troppi Informed (I): considera di ridurre';

  @override
  String get raciColumnName => 'Nome colonna';

  @override
  String get raciColumnNameHint => 'Es.: Team Sviluppo';

  @override
  String get raciNewColumn => 'Nuova Colonna';

  @override
  String get raciRemoveColumn => 'Rimuovi colonna';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Rimuovere la colonna \"$name\"? Tutte le assegnazioni di ruolo per questa colonna verranno eliminate.';
  }

  @override
  String get votingDialogTitle => 'Vota';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Voto di $participant';
  }

  @override
  String get votingDialogUrgency => 'URGENZA';

  @override
  String get votingDialogImportance => 'IMPORTANZA';

  @override
  String get votingDialogNotUrgent => 'Non urgente';

  @override
  String get votingDialogVeryUrgent => 'Molto urgente';

  @override
  String get votingDialogNotImportant => 'Non importante';

  @override
  String get votingDialogVeryImportant => 'Molto importante';

  @override
  String get votingDialogConfirmVote => 'Conferma Voto';

  @override
  String get votingDialogQuadrant => 'Quadrante:';

  @override
  String get voteCollectionTitle => 'Raccogli Voti';

  @override
  String get voteCollectionParticipants => 'partecipanti';

  @override
  String get voteCollectionResult => 'Risultato:';

  @override
  String get voteCollectionAverage => 'Media:';

  @override
  String get voteCollectionSaveVotes => 'Salva Voti';

  @override
  String get scatterChartTitle => 'Distribuzione Attività';

  @override
  String get scatterChartNoActivities => 'Nessuna attività votata';

  @override
  String get scatterChartVoteToShow =>
      'Vota le attività per visualizzarle nel grafico';

  @override
  String get scatterChartUrgencyLabel => 'Urgenza:';

  @override
  String get scatterChartImportanceLabel => 'Importanza:';

  @override
  String get scatterChartAxisUrgency => 'URGENZA';

  @override
  String get scatterChartAxisImportance => 'IMPORTANZA';

  @override
  String get scatterChartQ1Label => 'Q1 - FAI';

  @override
  String get scatterChartQ2Label => 'Q2 - PIANIFICA';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGA';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINA';

  @override
  String get scatterChartCardTitle => 'Grafico Distribuzione';

  @override
  String get votingStatusYou => 'Tu';

  @override
  String get votingStatusReset => 'Reset';

  @override
  String get estimationDecimalTitle => 'Stima Decimale';

  @override
  String get estimationDecimalHint =>
      'Inserisci la tua stima in giorni (es: 1.5, 2.25)';

  @override
  String get estimationDecimalHintPlaceholder => 'Es: 2.5';

  @override
  String get estimationDecimalSuffixDays => 'giorni';

  @override
  String get estimationDecimalVote => 'Vota';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Voto: $value giorni';
  }

  @override
  String get estimationDecimalQuickSelect => 'Selezione rapida:';

  @override
  String get estimationDecimalEnterValue => 'Inserisci un valore';

  @override
  String get estimationDecimalInvalidValue => 'Valore non valido';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Stima a Tre Punti (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Ottimistico (O)';

  @override
  String get estimationThreePointRealistic => 'Realistico (M)';

  @override
  String get estimationThreePointPessimistic => 'Pessimistico (P)';

  @override
  String get estimationThreePointBestCase => 'Caso migliore';

  @override
  String get estimationThreePointMostLikely => 'Più probabile';

  @override
  String get estimationThreePointWorstCase => 'Caso peggiore';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Tutti i campi sono obbligatori';

  @override
  String get estimationThreePointInvalidValues => 'Valori non validi';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Ottimistico deve essere <= Realistico';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realistico deve essere <= Pessimistico';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Ottimistico deve essere <= Pessimistico';

  @override
  String get estimationThreePointGuide => 'Guida:';

  @override
  String get estimationThreePointGuideO =>
      'O: Stima nel caso migliore (tutto va bene)';

  @override
  String get estimationThreePointGuideM =>
      'M: Stima più probabile (condizioni normali)';

  @override
  String get estimationThreePointGuideP =>
      'P: Stima nel caso peggiore (imprevisti)';

  @override
  String get estimationThreePointStdDev => 'Dev. Std';

  @override
  String get estimationThreePointDaysSuffix => 'gg';

  @override
  String get storyFormNewStory => 'Nuova Story';

  @override
  String get storyFormEnterTitle => 'Inserisci un titolo';

  @override
  String get sessionSearchHint => 'Cerca sessioni...';

  @override
  String get sessionSearchFilters => 'Filtri';

  @override
  String get sessionSearchFiltersTooltip => 'Filtri';

  @override
  String get sessionSearchStatusLabel => 'Stato: ';

  @override
  String get sessionSearchStatusAll => 'Tutti';

  @override
  String get sessionSearchStatusDraft => 'Bozza';

  @override
  String get sessionSearchStatusActive => 'Attiva';

  @override
  String get sessionSearchStatusCompleted => 'Completata';

  @override
  String get sessionSearchModeLabel => 'Modalità: ';

  @override
  String get sessionSearchModeAll => 'Tutte';

  @override
  String get sessionSearchRemoveFilters => 'Rimuovi filtri';

  @override
  String get sessionSearchActiveFilters => 'Filtri attivi:';

  @override
  String get sessionSearchRemoveAllFilters => 'Rimuovi tutti';

  @override
  String participantsTitle(int count) {
    return 'Partecipanti ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Facilitatore';

  @override
  String get participantRoleVoters => 'Votanti';

  @override
  String get participantRoleObservers => 'Osservatori';

  @override
  String get votingBoardVotesRevealed => 'Voti Rivelati';

  @override
  String get votingBoardVotingInProgress => 'Votazione in Corso';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total voti';
  }

  @override
  String get estimationSelectYourEstimate => 'Seleziona la tua stima';

  @override
  String estimationVoteSelected(String value) {
    return 'Voto selezionato: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Modalità di votazione con allocazione punti.\nProssimamente...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Stima per affinità con raggruppamento.\nProssimamente...';

  @override
  String get estimationModeTitle => 'Modalità di Stima';

  @override
  String get statisticsTitle => 'Statistiche Votazione';

  @override
  String get statisticsAverage => 'Media';

  @override
  String get statisticsMedian => 'Mediana';

  @override
  String get statisticsMode => 'Moda';

  @override
  String get statisticsVoters => 'Votanti';

  @override
  String get statisticsPertStats => 'Statistiche PERT';

  @override
  String get statisticsPertAvg => 'Media PERT';

  @override
  String get statisticsStdDev => 'Dev. Std';

  @override
  String get statisticsVariance => 'Varianza';

  @override
  String get statisticsRange => 'Range:';

  @override
  String get statisticsConsensusReached => 'Consenso raggiunto!';

  @override
  String get retroGuideTooltip => 'Guida alle Retrospettive';

  @override
  String get retroSearchPlaceholder => 'Cerca retrospettiva...';

  @override
  String get retroNoSearchResults => 'Nessun risultato per la ricerca';

  @override
  String get retroNewRetro => 'Nuova Retrospettiva';

  @override
  String get retroNoProjectsFound => 'Nessun progetto trovato.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Sei sicuro di voler eliminare definitivamente la retrospettiva \"$retroName\"?\n\nQuesta azione è irreversibile e cancellerà tutti i dati associati (card, voti, action items).';
  }

  @override
  String get retroDeletePermanently => 'Elimina definitivamente';

  @override
  String get retroDeletedSuccess => 'Retrospettiva eliminata con successo';

  @override
  String errorPrefix(String error) {
    return 'Errore: $error';
  }

  @override
  String get loaderProjectIdMissing => 'ID progetto mancante';

  @override
  String get loaderProjectNotFound => 'Progetto non trovato';

  @override
  String get loaderLoadError => 'Errore caricamento';

  @override
  String get loaderError => 'Errore';

  @override
  String get loaderUnknownError => 'Errore sconosciuto';

  @override
  String get actionGoBack => 'Torna indietro';

  @override
  String get authRequired => 'Autenticazione richiesta';

  @override
  String get retroIdMissing => 'ID retrospettiva mancante';

  @override
  String get pokerInviteStatusAccepted => 'è già stato accettato';

  @override
  String get pokerInviteStatusDeclined => 'è stato rifiutato';

  @override
  String get pokerInviteStatusExpired => 'è scaduto';

  @override
  String get pokerInviteStatusRevoked => 'è stato revocato';

  @override
  String get pokerInviteStatusPending => 'è in attesa';

  @override
  String get pokerInviteYouAreInvited => 'Sei Stato Invitato!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name ti ha invitato a partecipare';
  }

  @override
  String get pokerInviteSessionLabel => 'Sessione';

  @override
  String get pokerInviteProjectLabel => 'Progetto';

  @override
  String get pokerInviteRoleLabel => 'Ruolo Assegnato';

  @override
  String get pokerInviteExpiryLabel => 'Scadenza Invito';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Tra $days giorni';
  }

  @override
  String get pokerInviteDecline => 'Rifiuta';

  @override
  String get pokerInviteAccept => 'Accetta Invito';

  @override
  String loadingMatrixError(String error) {
    return 'Errore caricamento matrice: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Errore caricamento dati: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Errore caricamento attività: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days giorni/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}h/giorno';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Immagine trovata negli appunti';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Aggiungi immagine dagli appunti';

  @override
  String get smartTodoInviteCreatedAndSent => 'Invito creato e inviato';
}
