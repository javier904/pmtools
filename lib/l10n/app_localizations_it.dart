// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Lista di appartenenza';

  @override
  String get smartTodoSortTooltip => 'Opzioni Ordinamento';

  @override
  String get smartTodoSortManual => 'Manuale';

  @override
  String get smartTodoSortDate => 'Recenti';

  @override
  String get smartTodoActionSortPriority => 'Riordina per Priorità';

  @override
  String get smartTodoActionSortDeadline => 'Riordina per Scadenza';

  @override
  String get smartTodoOrderUpdated => 'Ordine aggiornato manualmente';

  @override
  String get newRetro => 'Nuova Retro';

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
  String get eisenhowerVotedActivities => 'Attivita votate';

  @override
  String get eisenhowerPendingVoting => 'Attivita da votare';

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
  String get eisenhowerUrgency => 'URGENZA';

  @override
  String get eisenhowerImportance => 'IMPORTANZA';

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
  String get sessionEstimationModeLocked =>
      'Non è possibile cambiare modalità dopo l\'avvio della votazione';

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
  String get estimationModeTshirt => 'Taglie T-Shirt';

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
  String get estimationVotesRevealed => 'Voti Rivelati';

  @override
  String get estimationVotingInProgress => 'Votazione in Corso';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total voti';
  }

  @override
  String get estimationConsensusReached => 'Consenso raggiunto!';

  @override
  String get estimationVotingResults => 'Risultati Votazione';

  @override
  String get estimationRevote => 'Rivota';

  @override
  String get estimationAverage => 'Media';

  @override
  String get estimationAverageTooltip => 'Media aritmetica dei voti numerici';

  @override
  String get estimationMedian => 'Mediana';

  @override
  String get estimationMedianTooltip =>
      'Valore centrale quando i voti sono ordinati';

  @override
  String get estimationMode => 'Moda';

  @override
  String get estimationModeTooltip =>
      'Voto più frequente (il valore scelto più volte)';

  @override
  String get estimationVoters => 'Votanti';

  @override
  String get estimationVotersTooltip =>
      'Numero totale di partecipanti che hanno votato';

  @override
  String get estimationVoteDistribution => 'Distribuzione voti';

  @override
  String get estimationSelectFinalEstimate => 'Seleziona stima finale';

  @override
  String get estimationFinalEstimate => 'Stima finale';

  @override
  String get eisenhowerChartTitle => 'Distribuzione Attività';

  @override
  String get quadrantLabelDo => 'Q1 - FAI';

  @override
  String get quadrantLabelPlan => 'Q2 - PIANIFICA';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGA';

  @override
  String get quadrantLabelEliminate => 'Q4 - ELIMINA';

  @override
  String get eisenhowerNoRatedActivities => 'Nessuna attività votata';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Vota le attività per visualizzarle nel grafico';

  @override
  String get eisenhowerChartCardTitle => 'Grafico Distribuzione';

  @override
  String get raciAddColumnTitle => 'Aggiungi Colonna RACI';

  @override
  String get raciColumnType => 'Tipo';

  @override
  String get raciTypePerson => 'Persona (Partecipante)';

  @override
  String get raciTypeCustom => 'Personalizzato (Team/Altro)';

  @override
  String get raciSelectParticipant => 'Seleziona partecipante';

  @override
  String get raciColumnName => 'Nome colonna';

  @override
  String get raciColumnNameHint => 'Es.: Team Sviluppo';

  @override
  String get raciDeleteColumnTitle => 'Elimina Colonna';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Vuoi eliminare la colonna \'$name\'? Le assegnazioni relative verranno perse.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online di $total partecipanti online';
  }

  @override
  String get estimationNewStoryTitle => 'Nuova Story';

  @override
  String get estimationStoryTitleLabel => 'Titolo *';

  @override
  String get estimationStoryTitleHint => 'Es: US-123: Come utente voglio...';

  @override
  String get estimationStoryDescriptionLabel => 'Descrizione';

  @override
  String get estimationStoryDescriptionHint =>
      'Criteri di accettazione, note...';

  @override
  String get estimationEnterTitleAlert => 'Inserisci un titolo';

  @override
  String get estimationParticipantsHeader => 'Partecipanti';

  @override
  String get estimationRoleFacilitator => 'Facilitatore';

  @override
  String get estimationRoleVoters => 'Votanti';

  @override
  String get estimationRoleObservers => 'Osservatori';

  @override
  String get estimationYouSuffix => '(tu)';

  @override
  String get estimationDecimalTitle => 'Stima Decimale';

  @override
  String get estimationDecimalHint =>
      'Inserisci la tua stima in giorni (es: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Selezione rapida:';

  @override
  String get estimationDaysSuffix => 'giorni';

  @override
  String estimationVoteValue(String value) {
    return 'Voto: $value giorni';
  }

  @override
  String get estimationEnterValueAlert => 'Inserisci un valore';

  @override
  String get estimationInvalidValueAlert => 'Valore non valido';

  @override
  String estimationMinAlert(double value) {
    return 'Min: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Max: $value';
  }

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
  String get agileProcessTitle => 'Agile Process Manager';

  @override
  String get agileSearchProjects => 'Cerca progetti...';

  @override
  String get agileMethodologyGuide => 'Guida Metodologie';

  @override
  String get agileMethodologyGuideTitle => 'Guida alle Metodologie Agile';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Scegli la metodologia piu adatta al tuo progetto';

  @override
  String get agileNewProject => 'Nuovo Progetto';

  @override
  String get agileRoles => 'RUOLI';

  @override
  String get agileProcessFlow => 'FLUSSO DEL PROCESSO';

  @override
  String get agileArtifacts => 'ARTEFATTI';

  @override
  String get agileBestPractices => 'Best Practices';

  @override
  String get agileAntiPatterns => 'Anti-Pattern da Evitare';

  @override
  String get agileFAQ => 'Domande Frequenti';

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
  String get agileRolePODesc => 'Gestisce il backlog e le priorità';

  @override
  String get agileRoleSMDesc => 'Facilita il processo e rimuove ostacoli';

  @override
  String get agileRoleDevTeamDesc => 'I membri che sviluppano il prodotto';

  @override
  String get agileRoleStakeholdersDesc => 'Forniscono feedback e requisiti';

  @override
  String get agileRoleSRMDesc => 'Gestisce le richieste in ingresso';

  @override
  String get agileRoleSDMDesc => 'Ottimizza il flusso di lavoro';

  @override
  String get agileRoleTeamDesc => 'Esegue il lavoro rispettando i WIP';

  @override
  String get agileRoleFlowMasterDesc => 'Ottimizza il flusso e facilita';

  @override
  String get agileRoleTeamHybridDesc => 'Cross-funzionale, autoorganizzato';

  @override
  String get scrumOverview =>
      'Scrum è un framework Agile iterativo e incrementale per la gestione dello sviluppo prodotto.\nSi basa su cicli di lavoro a tempo fisso chiamati Sprint, tipicamente di 2-4 settimane.\n\nScrum è ideale per:\n• Team che lavorano su prodotti con requisiti che evolvono\n• Progetti che beneficiano di feedback regolare\n• Organizzazioni che vogliono migliorare prevedibilità e trasparenza';

  @override
  String get scrumRolesTitle => 'I Ruoli Scrum';

  @override
  String get scrumRolesContent =>
      'Scrum definisce tre ruoli chiave che collaborano per il successo del progetto.';

  @override
  String get scrumRolesPO =>
      'Product Owner: Rappresenta gli stakeholder, gestisce il Product Backlog e massimizza il valore del prodotto';

  @override
  String get scrumRolesSM =>
      'Scrum Master: Facilita il processo Scrum, rimuove impedimenti e aiuta il team a migliorare';

  @override
  String get scrumRolesDev =>
      'Development Team: Team cross-funzionale e auto-organizzato che consegna l\'incremento di prodotto';

  @override
  String get scrumEventsTitle => 'Gli Eventi Scrum';

  @override
  String get scrumEventsContent =>
      'Scrum prevede eventi regolari per creare regolarità e minimizzare riunioni non pianificate.';

  @override
  String get scrumEventsPlanning =>
      'Sprint Planning: Pianificazione del lavoro dello Sprint (max 8h per Sprint di 4 settimane)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum: Sincronizzazione giornaliera del team (15 minuti)';

  @override
  String get scrumEventsReview =>
      'Sprint Review: Demo del lavoro completato agli stakeholder (max 4h)';

  @override
  String get scrumEventsRetro =>
      'Sprint Retrospective: Riflessione del team per miglioramento continuo (max 3h)';

  @override
  String get scrumArtifactsTitle => 'Gli Artefatti Scrum';

  @override
  String get scrumArtifactsContent =>
      'Gli artefatti rappresentano lavoro o valore e sono progettati per massimizzare la trasparenza.';

  @override
  String get scrumArtifactsPB =>
      'Product Backlog: Lista ordinata di tutto ciò che potrebbe servire nel prodotto';

  @override
  String get scrumArtifactsSB =>
      'Sprint Backlog: Items selezionati per lo Sprint + piano per consegnare l\'incremento';

  @override
  String get scrumArtifactsIncrement =>
      'Incremento: Somma di tutti gli items completati durante lo Sprint, potenzialmente rilasciabile';

  @override
  String get scrumStoryPointsTitle => 'Story Points e Velocity';

  @override
  String get scrumStoryPointsContent =>
      'Gli Story Points sono un\'unità di misura relativa della complessità delle User Stories.\nNon misurano il tempo, ma lo sforzo, la complessità e l\'incertezza.\n\nLa sequenza di Fibonacci (1, 2, 3, 5, 8, 13, 21) è comunemente usata perché:\n• Riflette l\'incertezza crescente per items più grandi\n• Rende difficile la falsa precisione\n• Facilita le discussioni durante la stima\n\nLa Velocity è la media degli Story Points completati negli ultimi sprint e serve per:\n• Prevedere quanto lavoro può essere incluso nei prossimi sprint\n• Identificare trend di produttività del team\n• Non confrontare team diversi (ogni team ha la propria scala)';

  @override
  String get scrumBP1 =>
      'Mantieni gli Sprint a durata fissa e rispetta il timebox';

  @override
  String get scrumBP2 =>
      'Il Product Backlog deve essere sempre prioritizzato e raffinato';

  @override
  String get scrumBP3 => 'Le User Stories devono rispettare i criteri INVEST';

  @override
  String get scrumBP4 => 'La Definition of Done deve essere chiara e condivisa';

  @override
  String get scrumBP5 => 'Non modificare lo Sprint Goal durante lo Sprint';

  @override
  String get scrumBP6 => 'Celebra i successi nella Sprint Review';

  @override
  String get scrumBP7 =>
      'La Retrospettiva deve produrre azioni concrete di miglioramento';

  @override
  String get scrumBP8 =>
      'Il team deve essere cross-funzionale e auto-organizzato';

  @override
  String get scrumAP1 => 'Sprint senza Sprint Goal chiaro';

  @override
  String get scrumAP2 => 'Daily Scrum trasformato in report meeting';

  @override
  String get scrumAP3 =>
      'Saltare la Retrospettiva quando si è \"troppo occupati\"';

  @override
  String get scrumAP4 => 'Product Owner assente o non disponibile';

  @override
  String get scrumAP5 =>
      'Aggiungere lavoro durante lo Sprint senza rimuovere altro';

  @override
  String get scrumAP6 => 'Story Points convertiti in ore (perde il senso)';

  @override
  String get scrumAP7 => 'Team troppo grande (ideale 5-9 persone)';

  @override
  String get scrumAP8 => 'Scrum Master che \"assegna\" compiti al team';

  @override
  String get scrumFAQ1Q => 'Quanto deve durare uno Sprint?';

  @override
  String get scrumFAQ1A =>
      'La durata tipica è 2 settimane, ma può variare da 1 a 4 settimane. Sprint più brevi permettono feedback più frequenti e correzioni di rotta rapide. Sprint più lunghi danno più tempo per completare items complessi. L\'importante è mantenere la durata costante.';

  @override
  String get scrumFAQ2Q => 'Come gestire lavoro non completato a fine Sprint?';

  @override
  String get scrumFAQ2A =>
      'Le User Stories non completate tornano nel Product Backlog e vengono ri-prioritizzate. Mai estendere lo Sprint o ridurre la Definition of Done. Usare la Retrospettiva per capire perché è successo e come prevenirlo.';

  @override
  String get scrumFAQ3Q =>
      'Posso cambiare lo Sprint Backlog durante lo Sprint?';

  @override
  String get scrumFAQ3A =>
      'Lo Sprint Goal non dovrebbe cambiare, ma lo Sprint Backlog può evolversi. Il team può negoziare con il PO la sostituzione di items di pari valore. Se lo Sprint Goal diventa obsoleto, il PO può cancellare lo Sprint.';

  @override
  String get scrumFAQ4Q => 'Come calcolare la Velocity iniziale?';

  @override
  String get scrumFAQ4A =>
      'Per i primi 3 Sprint, fai stime conservative. Dopo 3 Sprint avrai una Velocity affidabile. Non usare la Velocity di altri team come riferimento.';

  @override
  String get kanbanOverview =>
      'Kanban è un metodo per gestire il lavoro che enfatizza la visualizzazione del flusso,\nla limitazione del Work In Progress (WIP) e il miglioramento continuo del processo.\n\nKanban è ideale per:\n• Team di supporto/manutenzione con richieste continue\n• Ambienti dove le priorità cambiano frequentemente\n• Quando non è possibile pianificare in iterazioni fisse\n• Transizione graduale verso l\'Agile';

  @override
  String get kanbanPrinciplesTitle => 'I Principi Kanban';

  @override
  String get kanbanPrinciplesContent =>
      'Kanban si basa su principi di cambiamento incrementale e rispetto per i ruoli esistenti.';

  @override
  String get kanbanPrinciple1 =>
      'Visualizza il flusso di lavoro: Rendi visibile tutto il lavoro';

  @override
  String get kanbanPrinciple2 =>
      'Limita il WIP: Completa il lavoro prima di iniziarne di nuovo';

  @override
  String get kanbanPrinciple3 =>
      'Gestisci il flusso: Ottimizza per massimizzare il throughput';

  @override
  String get kanbanPrinciple4 =>
      'Rendi esplicite le policy: Definisci regole chiare';

  @override
  String get kanbanPrinciple5 =>
      'Implementa feedback loops: Migliora continuamente';

  @override
  String get kanbanPrinciple6 =>
      'Migliora collaborativamente: Evolvi sperimentando';

  @override
  String get kanbanBoardTitle => 'Kanban Board';

  @override
  String get kanbanBoardContent =>
      'La board visualizza il flusso di lavoro attraverso le sue fasi.\nOgni colonna rappresenta uno stato del lavoro (es. To Do, In Progress, Done).\n\nElementi chiave della board:\n• Colonne: Stati del workflow\n• Card/Ticket: Unità di lavoro\n• WIP Limits: Limiti per colonna\n• Swimlanes: Raggruppamenti orizzontali (opzionale)';

  @override
  String get kanbanWIPTitle => 'WIP Limits';

  @override
  String get kanbanWIPContent =>
      'I limiti di Work In Progress (WIP) sono il cuore di Kanban.\nLimitare il WIP:\n\n• Riduce il context switching\n• Evidenzia i colli di bottiglia\n• Accelera il throughput\n• Migliora la qualità (meno errori da multitasking)\n• Aumenta la prevedibilità\n\nCome impostare i WIP limits:\n• Inizia con numero membri team × 2 per colonna\n• Osserva il flusso e aggiusta\n• Il limite \"giusto\" crea una leggera tensione';

  @override
  String get kanbanMetricsTitle => 'Metriche Kanban';

  @override
  String get kanbanMetricsContent =>
      'Kanban utilizza metriche di flusso per misurare e migliorare il processo.';

  @override
  String get kanbanMetric1 =>
      'Lead Time: Tempo dalla richiesta al completamento (include attesa)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time: Tempo dall\'inizio lavoro al completamento';

  @override
  String get kanbanMetric3 => 'Throughput: Items completati per unità di tempo';

  @override
  String get kanbanMetric4 =>
      'WIP: Quantità di lavoro in corso in ogni momento';

  @override
  String get kanbanMetric5 =>
      'Cumulative Flow Diagram (CFD): Visualizza l\'accumulo di lavoro nel tempo';

  @override
  String get kanbanCadencesTitle => 'Cadenze Kanban';

  @override
  String get kanbanCadencesContent =>
      'A differenza di Scrum, Kanban non prescrive eventi fissi.\nTuttavia, cadenze regolari aiutano il miglioramento continuo:\n\n• Standup Meeting: Sincronizzazione quotidiana davanti alla board\n• Replenishment Meeting: Prioritizzazione del backlog\n• Delivery Planning: Pianificazione delle release\n• Service Delivery Review: Review delle metriche\n• Risk Review: Analisi dei rischi e impedimenti\n• Operations Review: Miglioramento del processo';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Le swimlanes sono righe orizzontali che raggruppano le card sulla board per un attributo comune.\n\nTipi di swimlane disponibili:\n• Classe di Servizio: Raggruppa per priorità/urgenza del lavoro\n• Assegnatario: Raggruppa per membro del team assegnato\n• Priorità: Raggruppa per livello MoSCoW\n• Tag: Raggruppa per etichette delle storie\n\nLe swimlanes aiutano a:\n• Visualizzare il carico di lavoro per persona\n• Gestire diverse classi di servizio (urgente, standard)\n• Identificare colli di bottiglia per tipo di lavoro';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Policy: $columnName';
  }

  @override
  String get kanbanPoliciesContent =>
      'La pratica #4 di Kanban: \'Make Policies Explicit\' richiede di definire regole chiare per ogni colonna.\n\nEsempi di policy:\n• \'Max 24h in questa colonna\' - tempo massimo\n• \'Richiede code review approvata\' - criteri di uscita\n• \'Max 1 item per persona\' - limite individuale\n• \'Daily update obbligatorio\' - comunicazione\n\nLe policy:\n• Rendono le aspettative trasparenti a tutti\n• Riducono ambiguità e conflitti\n• Facilitano l\'onboarding di nuovi membri\n• Permettono di identificare quando le regole vengono violate';

  @override
  String get kanbanBP1 =>
      'Visualizza TUTTO il lavoro, incluso il lavoro nascosto';

  @override
  String get kanbanBP2 => 'Rispetta rigorosamente i WIP limits';

  @override
  String get kanbanBP3 => 'Focalizzati sul completare, non sull\'iniziare';

  @override
  String get kanbanBP4 =>
      'Usa le metriche per decisioni, non per giudicare le persone';

  @override
  String get kanbanBP5 => 'Migliora un passo alla volta';

  @override
  String get kanbanBP6 => 'Blocca il nuovo lavoro se il WIP è al limite';

  @override
  String get kanbanBP7 => 'Analizza i blocchi e rimuovili rapidamente';

  @override
  String get kanbanBP8 => 'Usa swimlanes per priorità o tipologie di lavoro';

  @override
  String get kanbanAP1 => 'WIP limits troppo alti (o assenti)';

  @override
  String get kanbanAP2 => 'Ignorare i blocchi sulla board';

  @override
  String get kanbanAP3 => 'Non rispettare i limiti quando \"è urgente\"';

  @override
  String get kanbanAP4 => 'Columns troppo generiche (es. solo To Do/Done)';

  @override
  String get kanbanAP5 => 'Non tracciare quando gli items entrano/escono';

  @override
  String get kanbanAP6 => 'Usare Kanban solo come task board senza principi';

  @override
  String get kanbanAP7 => 'Non analizzare mai il Cumulative Flow Diagram';

  @override
  String get kanbanAP8 => 'Troppi swimlanes che complicano la visualizzazione';

  @override
  String get kanbanFAQ1Q => 'Come gestire le urgenze in Kanban?';

  @override
  String get kanbanFAQ1A =>
      'Crea una swimlane \"Expedite\" con WIP limit di 1. Gli items expedite saltano la coda ma devono essere rari. Se tutto è urgente, niente è urgente.';

  @override
  String get kanbanFAQ2Q => 'Kanban funziona per lo sviluppo software?';

  @override
  String get kanbanFAQ2A =>
      'Assolutamente sì. Kanban è nato in Toyota ma è ampiamente usato nello sviluppo software. È particolarmente adatto per team di manutenzione, DevOps, e support.';

  @override
  String get kanbanFAQ3Q => 'Come impostare i WIP limits iniziali?';

  @override
  String get kanbanFAQ3A =>
      'Formula di partenza: (membri del team + 1) per colonna. Osserva per 2 settimane e riduci gradualmente fino a creare una leggera tensione. Il limite ottimale varia per ogni team e contesto.';

  @override
  String get kanbanFAQ4Q =>
      'Quanto tempo serve per vedere risultati con Kanban?';

  @override
  String get kanbanFAQ4A =>
      'I primi miglioramenti (visibilità) sono immediati. Riduzione del Lead Time si vede in 2-4 settimane. Miglioramenti significativi del processo richiedono 2-3 mesi.';

  @override
  String get hybridOverview =>
      'Scrumban combina elementi di Scrum e Kanban per creare un approccio flessibile\nche si adatta al contesto del team. Mantiene la struttura degli Sprint con\nla flessibilità del flusso continuo e i WIP limits.\n\nScrumban è ideale per:\n• Team che vogliono transire da Scrum a Kanban (o viceversa)\n• Progetti con mix di feature development e manutenzione\n• Team che vogliono Sprint ma con più flessibilità\n• Quando Scrum \"puro\" è troppo rigido per il contesto';

  @override
  String get hybridFromScrumTitle => 'Da Scrum: Struttura';

  @override
  String get hybridFromScrumContent =>
      'Scrumban mantiene alcuni elementi strutturati di Scrum per prevedibilità.';

  @override
  String get hybridFromScrum1 =>
      'Sprint (opzionale): Iterazioni a tempo fisso per cadenza';

  @override
  String get hybridFromScrum2 =>
      'Sprint Planning: Selezione del lavoro per il periodo';

  @override
  String get hybridFromScrum3 => 'Retrospettiva: Riflessione e miglioramento';

  @override
  String get hybridFromScrum4 =>
      'Demo/Review: Condivisione del valore prodotto';

  @override
  String get hybridFromScrum5 =>
      'Story Points: Per stime e previsioni (opzionale)';

  @override
  String get hybridFromKanbanTitle => 'Da Kanban: Flusso';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban adotta i principi di flusso Kanban per efficienza.';

  @override
  String get hybridFromKanban1 => 'WIP Limits: Limitazione del lavoro in corso';

  @override
  String get hybridFromKanban2 =>
      'Pull System: Il team \"tira\" lavoro quando ha capacità';

  @override
  String get hybridFromKanban3 =>
      'Visualizzazione: Board condivisa e trasparente';

  @override
  String get hybridFromKanban4 =>
      'Metriche di flusso: Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Miglioramento continuo: Policy esplicite e sperimentazione';

  @override
  String get hybridOnDemandTitle => 'Planning su Richiesta';

  @override
  String get hybridOnDemandContent =>
      'In Scrumban, il planning può essere \"on-demand\" invece che a intervalli fissi.\n\nIl planning si attiva quando:\n• Il backlog \"Ready\" scende sotto una soglia\n• Serve prioritizzare nuove richieste urgenti\n• Un milestone si avvicina\n\nQuesto riduce le sessioni di planning quando non necessarie\ne permette di reagire più velocemente ai cambiamenti.';

  @override
  String get hybridWhenTitle => 'Quando Usare Cosa';

  @override
  String get hybridWhenContent =>
      'Scrumban non è \"fare tutto\". È scegliere gli elementi giusti per il contesto.\n\nUsa elementi Scrum quando:\n• Serve prevedibilità nelle consegne\n• Gli stakeholder vogliono demo regolari\n• Il team beneficia di ritmo fisso\n\nUsa elementi Kanban quando:\n• Il lavoro è imprevedibile (support, bug fixing)\n• Serve reattività alle urgenze\n• Il focus è sul throughput continuo';

  @override
  String get hybridBP1 =>
      'Inizia con ciò che conosci e aggiungi elementi gradualmente';

  @override
  String get hybridBP2 => 'I WIP limits sono non negoziabili, anche con Sprint';

  @override
  String get hybridBP3 => 'Usa Sprint per cadenza, non come commitment rigido';

  @override
  String get hybridBP4 =>
      'Mantieni la Retrospettiva, è il motore del miglioramento';

  @override
  String get hybridBP5 =>
      'Le metriche di flusso aiutano più della Velocity pura';

  @override
  String get hybridBP6 => 'Sperimenta con una cosa alla volta';

  @override
  String get hybridBP7 =>
      'Documenta le policy del team e rivedile regolarmente';

  @override
  String get hybridBP8 =>
      'Considera swimlanes per separare feature da manutenzione';

  @override
  String get hybridAP1 =>
      'Prendere il peggio di entrambi (rigidità Scrum + caos Kanban)';

  @override
  String get hybridAP2 =>
      'Eliminare le Retrospettive perché \"siamo flessibili\"';

  @override
  String get hybridAP3 => 'WIP limits ignorati perché \"abbiamo gli Sprint\"';

  @override
  String get hybridAP4 => 'Cambiare framework ad ogni Sprint';

  @override
  String get hybridAP5 => 'Non avere nessuna cadenza (né Sprint né altro)';

  @override
  String get hybridAP6 => 'Confondere flessibilità con assenza di regole';

  @override
  String get hybridAP7 => 'Non misurare niente';

  @override
  String get hybridAP8 => 'Troppa complessità per il contesto';

  @override
  String get hybridFAQ1Q => 'Scrumban ha Sprint o no?';

  @override
  String get hybridFAQ1A =>
      'Dipende dal team. Puoi avere Sprint per cadenza (review, planning) ma permettere flusso continuo di lavoro dentro lo Sprint. Oppure puoi eliminare gli Sprint e avere solo cadenze Kanban.';

  @override
  String get hybridFAQ2Q => 'Come misuro la performance in Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Usa sia metriche Scrum (Velocity se usi Sprint e Story Points) che metriche Kanban (Lead Time, Cycle Time, Throughput). Le metriche di flusso sono spesso più utili per il miglioramento.';

  @override
  String get hybridFAQ3Q => 'Da dove partire con Scrumban?';

  @override
  String get hybridFAQ3A =>
      'Se vieni da Scrum: aggiungi WIP limits e visualizza il flusso. Se vieni da Kanban: aggiungi cadenze regolari per review e planning. Parti da ciò che il team conosce e aggiungi incrementalmente.';

  @override
  String get hybridFAQ4Q => 'Scrumban è \"meno Agile\" di Scrum puro?';

  @override
  String get hybridFAQ4A =>
      'No. Agile non significa seguire un framework specifico. Scrumban può essere più Agile perché si adatta al contesto. L\'importante è ispezionare e adattare continuamente.';

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
  String get retroActionDragToCreate =>
      'Trascina qui una card per creare un Action Item collegato';

  @override
  String get retroNoActionItems => 'Nessun Action Item ancora creato.';

  @override
  String get facilitatorGuideNextColumn => 'Prossimo: Raccogli azione da';

  @override
  String get collectionRationaleSSC =>
      'Prima Stop per rimuovere bloccanti, poi Start nuove pratiche, infine Continue ciò che funziona.';

  @override
  String get collectionRationaleMSG =>
      'Prima affrontare le frustrazioni, poi le delusioni, poi celebrare i successi.';

  @override
  String get collectionRationale4Ls =>
      'Prima colmare le lacune, poi pianificare aspirazioni future, mantenere ciò che funziona, condividere apprendimenti.';

  @override
  String get collectionRationaleSailboat =>
      'Prima mitigare i rischi, rimuovere bloccanti, poi sfruttare gli abilitatori e allinearsi agli obiettivi.';

  @override
  String get collectionRationaleStarfish =>
      'Fermare pratiche negative, ridurne altre, mantenere quelle buone, aumentare quelle di valore, iniziarne di nuove.';

  @override
  String get collectionRationaleDAKI =>
      'Drop per liberare capacità, Add nuove pratiche, Improve quelle esistenti, Keep ciò che funziona.';

  @override
  String get missingSuggestionSSCStop =>
      'Considera quale pratica sta bloccando il team e dovrebbe essere fermata.';

  @override
  String get missingSuggestionSSCStart =>
      'Pensa a quale nuova pratica potrebbe aiutare il team a migliorare.';

  @override
  String get missingSuggestionMSGMad =>
      'Affronta le frustrazioni del team - cosa sta causando rabbia?';

  @override
  String get missingSuggestionMSGSad =>
      'Risolvi le delusioni - cosa ha reso triste il team?';

  @override
  String get missingSuggestion4LsLacked =>
      'Cosa mancava di cui il team aveva bisogno?';

  @override
  String get missingSuggestion4LsLonged =>
      'Cosa desidera il team per il futuro?';

  @override
  String get missingSuggestionSailboatAnchor =>
      'Cosa sta trattenendo il team dal raggiungere gli obiettivi?';

  @override
  String get missingSuggestionSailboatRock =>
      'Quali rischi minacciano il progresso del team?';

  @override
  String get missingSuggestionStarfishStop =>
      'Quale pratica il team dovrebbe completamente smettere di fare?';

  @override
  String get missingSuggestionStarfishStart =>
      'Quale nuova pratica il team dovrebbe iniziare?';

  @override
  String get missingSuggestionDAKIDrop =>
      'Cosa dovrebbe il team decidere di eliminare?';

  @override
  String get missingSuggestionDAKIAdd =>
      'Quale nuova decisione dovrebbe prendere il team?';

  @override
  String get missingSuggestionGeneric =>
      'Considera di creare un\'azione da questa colonna.';

  @override
  String get facilitatorGuideAllCovered =>
      'Tutte le colonne richieste coperte!';

  @override
  String get facilitatorGuideMissing => 'Mancano azioni per';

  @override
  String get retroPhaseStart => 'Inizia';

  @override
  String get retroPhaseStop => 'Smetti';

  @override
  String get retroPhaseContinue => 'Continua';

  @override
  String get retroColumnMad => 'Arrabbiato';

  @override
  String get retroColumnSad => 'Triste';

  @override
  String get retroColumnGlad => 'Felice';

  @override
  String get retroColumnLiked => 'Piaciuto';

  @override
  String get retroColumnLearned => 'Imparato';

  @override
  String get retroColumnLacked => 'Mancato';

  @override
  String get retroColumnLonged => 'Desiderato';

  @override
  String get retroColumnWind => 'Vento';

  @override
  String get retroColumnAnchor => 'Ancore';

  @override
  String get retroColumnRock => 'Scogli';

  @override
  String get retroColumnGoal => 'Isola';

  @override
  String get retroColumnKeep => 'Mantieni';

  @override
  String get retroColumnMore => 'Di Più';

  @override
  String get retroColumnLess => 'Di Meno';

  @override
  String get retroColumnDrop => 'Elimina';

  @override
  String get retroColumnAdd => 'Aggiungi';

  @override
  String get retroColumnImprove => 'Migliora';

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
  String get agileAcceptanceCriteria => 'Criteri di Accettazione';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed di $total elementi';
  }

  @override
  String get agileEstimateRequired => 'Stima richiesta (click per stimare)';

  @override
  String get agileNoActiveSprint => 'Nessuno Sprint Attivo';

  @override
  String get agileKanbanBoardHint =>
      'La Kanban Board mostra le stories dello sprint attivo.\nPer visualizzare le stories:';

  @override
  String get agileStartSprintFromTab => 'Avvia uno sprint dalla tab Sprint';

  @override
  String get agileDisableFilterHint =>
      'Oppure disattiva il filtro per vedere tutte le stories';

  @override
  String get agileShowAllStories => 'Mostra tutte le stories';

  @override
  String get agileFilterActiveSprint => 'Filtro Sprint Attivo: ';

  @override
  String get agileFilterActive => 'Attivo';

  @override
  String get agileFilterAll => 'Tutto';

  @override
  String get agileActionInvite => 'Invita';

  @override
  String agileTeamTitle(int count) {
    return 'Team ($count)';
  }

  @override
  String get agileNoMembers => 'Nessun membro nel team';

  @override
  String get agileYouBadge => 'Tu';

  @override
  String agileStatsPlannedCount(int count) {
    return '$count pianificati';
  }

  @override
  String agileStatsTotalCount(int count) {
    return '$count totali';
  }

  @override
  String get agileStatsPtsPerSprint => 'pts/sprint';

  @override
  String get agileStatsWorkInProgress => 'work in progress';

  @override
  String get agileStatsItemsPerWeek => 'items/settimana';

  @override
  String get agileStatsCompletedTooltip =>
      'Numero di sprint con status \'Completato\'.\nClicca \'Completa Sprint\' per finalizzare uno sprint attivo.';

  @override
  String get agileAverageVelocityTooltip =>
      'Media degli Story Points completati per sprint.\nCalcolata dagli sprint completati che hanno stories in stato \'Done\'.\nPiù alta = team più produttivo.';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Numero di User Stories con status \'Done\'.\nPer incrementare questo valore, sposta le stories nella colonna \'Done\' della Kanban Board.';

  @override
  String get agileStatsPointsTooltip =>
      'Somma degli Story Points delle stories completate.\n\'Pianificati\' include tutte le stories stimate nel backlog.';

  @override
  String get agileItemsCompletedTooltip =>
      'Numero di Work Items con status \'Done\'.\nSposta gli items nella colonna \'Done\' per completarli.';

  @override
  String get agileInProgressTooltip =>
      'Items attualmente in lavorazione (WIP).\nTieni questo numero basso per migliorare il flusso.';

  @override
  String get agileCycleTimeTooltip =>
      'Tempo medio dall\'inizio lavoro al completamento.\nRichiede items con date \'Iniziato\' e \'Completato\' valorizzate.\nPiù basso = team più efficiente.';

  @override
  String get agileThroughputTooltip =>
      'Media items completati per settimana (ultime 4 settimane).\nIndica la produttività del team nel tempo.';

  @override
  String get agileHybridSprintTooltip =>
      'Sprint completati rispetto al totale.';

  @override
  String get agileHybridCompletedTooltip =>
      'Items con status \'Done\' rispetto al totale.\nSposta items nella colonna \'Done\' per completarli.';

  @override
  String get agileAddSkillsHint => 'Aggiungi competenze ai membri del team';

  @override
  String get agileSkillMatrixTitle => 'Matrice Competenze';

  @override
  String get agileCriticalSkills => 'Competenze critiche';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Solo 1 persona copre: $skills';
  }

  @override
  String get agileSkills => 'Competenze';

  @override
  String get agileNoSkills => 'Nessuna competenza';

  @override
  String get agileAddSkill => 'Aggiungi competenza';

  @override
  String get agileNewSkill => 'Nuova competenza...';

  @override
  String get agileNewSkillDialogTitle => 'Nuova Competenza';

  @override
  String get agileNewSkillName => 'Nome competenza';

  @override
  String get agileNewSkillHint => 'Es: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Copertura Competenze';

  @override
  String get agileNoSkillsAvailable => 'Nessuna skill disponibile';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'Basato su $count items completati';
  }

  @override
  String get agileNoAcceptanceCriteria =>
      'Nessun criterio di accettazione definito';

  @override
  String get agileDescription => 'Descrizione';

  @override
  String get agileNoDescription => 'Nessuna descrizione';

  @override
  String get agileTags => 'Tags';

  @override
  String get agileEstimates => 'Stime';

  @override
  String get agileFinalEstimate => 'Stima Finale';

  @override
  String agileEstimatesReceived(int count) {
    return '$count stime ricevute';
  }

  @override
  String get agileInformation => 'Informazioni';

  @override
  String get agileBusinessValue => 'Business Value';

  @override
  String get agileAssignee => 'Assegnatario';

  @override
  String get agileNoAssignee => 'Non assegnato';

  @override
  String get agileCreatedBy => 'Creato da';

  @override
  String get agileCreatedAt => 'Creato il';

  @override
  String get agileStartedAt => 'Iniziato il';

  @override
  String get agileCompletedAt => 'Completato il';

  @override
  String get agileSprintTitle => 'Sprint';

  @override
  String get agileNewSprint => 'Nuovo Sprint';

  @override
  String get agileNoSprints => 'Nessuno sprint';

  @override
  String get agileCreateFirstSprint => 'Crea il primo sprint per iniziare';

  @override
  String get agileSprintStatusPlanning => 'Planning';

  @override
  String get agileSprintStatusActive => 'Attivo';

  @override
  String get agileSprintStatusReview => 'Review';

  @override
  String get agileSprintStatusCompleted => 'Completato';

  @override
  String get agileStartSprint => 'Avvia Sprint';

  @override
  String get agileCompleteSprint => 'Completa Sprint';

  @override
  String get agileDeleteSprint => 'Elimina';

  @override
  String get agileSprintName => 'Nome Sprint';

  @override
  String get agileSprintGoal => 'Sprint Goal';

  @override
  String get agileSprintGoalHint => 'Obiettivo dello sprint';

  @override
  String get agileStartDate => 'Data Inizio';

  @override
  String get agileEndDate => 'Data Fine';

  @override
  String get agileStatsStories => 'storie';

  @override
  String get agileStatsPoints => 'pti';

  @override
  String get agileStatsCompleted => 'completati';

  @override
  String get agileStatsVelocity => 'velocity';

  @override
  String agileDaysRemainingCount(String count) {
    return '$count giorni rimanenti';
  }

  @override
  String get agileAverageVelocity => 'Velocity media';

  @override
  String agileTeamMembersCount(String count) {
    return 'Team: $count membri';
  }

  @override
  String get agileActionCancel => 'Annulla';

  @override
  String get agileActionSave => 'Salva';

  @override
  String get agileActionCreate => 'Crea';

  @override
  String get agileSprintPlanningTitle => 'Sprint Planning';

  @override
  String get agileSprintPlanningSubtitle =>
      'Seleziona le storie da completare in questo sprint';

  @override
  String get agileBurndownChart => 'Burndown Chart';

  @override
  String get agileBurndownIdeal => 'Ideale';

  @override
  String get agileBurndownActual => 'Reale';

  @override
  String get agileBurndownPlanned => 'Pianificati';

  @override
  String get agileBurndownRemaining => 'Rimanenti';

  @override
  String get agileBurndownNoData => 'Nessun dato burndown';

  @override
  String get agileBurndownNoDataHint =>
      'I dati appariranno quando lo sprint sarà attivo';

  @override
  String get agileVelocityTrend => 'Trend Velocity';

  @override
  String get agileVelocityNoData => 'Nessun dato velocity';

  @override
  String get agileVelocityNoDataHint =>
      'Completa almeno uno sprint per vedere il trend';

  @override
  String get agileTeamCapacity => 'Capacità Team';

  @override
  String get agileTeamCapacityScrum => 'Capacità Team (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Capacità Team (Ore)';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity => 'Capacità Suggerita per Sprint Planning';

  @override
  String get agileSuggestedCapacityHint =>
      'Basato su velocity media ± deviazione standard (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Completa almeno 1 sprint per avere suggerimenti sulla capacità';

  @override
  String get agileScrumGuideNote =>
      'La Scrum Guide raccomanda di basare la pianificazione sulla Velocity storica, non sulle ore.';

  @override
  String get agileHoursAvailable => 'Disponibile';

  @override
  String get agileHoursAssigned => 'Assegnato';

  @override
  String get agileHoursOverloaded => 'Sovraccarico';

  @override
  String get agileHoursTotal => 'Capacità Totale';

  @override
  String get agileHoursUtilization => 'Utilizzazione';

  @override
  String agileMetricsTitle(String framework) {
    return 'Metriche $framework';
  }

  @override
  String get agileItemsCompleted => 'Item Completati';

  @override
  String get agileInProgress => 'In Lavorazione';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Distribuzione Stories';

  @override
  String get agileCompletionRate => 'Completion Rate';

  @override
  String get agileAccuracy => 'Accuratezza Stime';

  @override
  String get agileEfficiency => 'Flow Efficiency';

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
  String inviteSentTo(String email) {
    return 'Invito inviato via email a $email';
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
  String get actionSubmit => 'Invia';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker: Una Parola';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Descrivi questo sprint con UNA sola parola';

  @override
  String get retroIcebreakerOneWordHint => 'La tua parola...';

  @override
  String get retroIcebreakerSubmitted => 'Inviato!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count parole inviate';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker: Meteo';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Quale meteo rappresenta meglio come ti senti riguardo a questo sprint?';

  @override
  String get retroWeatherSunny => 'Soleggiato';

  @override
  String get retroWeatherPartlyCloudy => 'Parz. nuvoloso';

  @override
  String get retroWeatherCloudy => 'Nuvoloso';

  @override
  String get retroWeatherRainy => 'Piovoso';

  @override
  String get retroWeatherStormy => 'Tempestoso';

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
  String get retroActionType => 'Tipo Azione';

  @override
  String get retroActionNoType => 'Nessun tipo specifico';

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
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Rif.';

  @override
  String get retroTableSourceColumn => 'Colonna';

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
  String get retroSupportResources => 'Risorse di Supporto';

  @override
  String get retroMonitoringMethod => 'Metodo di Monitoraggio';

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
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total completate';
  }

  @override
  String get smartTodoCreatedDate => 'Data creazione';

  @override
  String get smartTodoParticipantRole => 'Partecipante';

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
  String get smartTodoSortBy => 'Ordinamento';

  @override
  String get smartTodoColumnSortTitle => 'Ordina Colonna';

  @override
  String get smartTodoPendingTasks => 'Attivita da completare';

  @override
  String get smartTodoCompletedTasks => 'Attivita completate';

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
      'es. Comprare il latte\nChiamare Mario\nFinire il report';

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
  String get smartTodoImportDestinationColumn => 'Destinazione:';

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
  String get smartTodoImportHelpTitle => 'Come importare le attività?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Lista semplice (un\'attività per riga)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Incolla una lista semplice con un titolo per riga. Ogni riga diventa un\'attività.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Comprare il latte\nChiamare Mario\nFinire il report';

  @override
  String get smartTodoImportHelpCsvTitle => 'Formato CSV (con colonne)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Usa valori separati da virgola con una riga di intestazione. La prima riga definisce le colonne.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nComprare latte,high,mario@email.com\nChiamare Mario,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Campi disponibili:';

  @override
  String get smartTodoImportHelpFieldTitle => 'Titolo attività (obbligatorio)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Descrizione attività';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'high, medium, low (oppure alta, media, bassa)';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Nome colonna (es. Da fare, In corso)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Email utente';

  @override
  String get smartTodoImportHelpFieldEffort => 'Ore (numero)';

  @override
  String get smartTodoImportHelpFieldTags => 'Tag (#tag o separati da virgola)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Colonne disponibili per STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(colonna vuota)';

  @override
  String get smartTodoImportFieldIgnore => '-- Ignora --';

  @override
  String get smartTodoImportFieldTitle => 'Titolo';

  @override
  String get smartTodoImportFieldDescription => 'Descrizione';

  @override
  String get smartTodoImportFieldPriority => 'Priorità';

  @override
  String get smartTodoImportFieldStatus => 'Stato (Colonna)';

  @override
  String get smartTodoImportFieldAssignee => 'Assegnatario';

  @override
  String get smartTodoImportFieldEffort => 'Effort';

  @override
  String get smartTodoImportFieldTags => 'Tag';

  @override
  String get smartTodoDeleteTaskTitle => 'Elimina Attività';

  @override
  String get smartTodoDeleteTaskContent =>
      'Sei sicuro di voler eliminare questa attività? Questa azione non può essere annullata.';

  @override
  String get smartTodoDeleteNoPermission =>
      'Non hai i permessi per eliminare questa attività';

  @override
  String get smartTodoSheetsExportTitle => 'Export Google Sheets';

  @override
  String get smartTodoSheetsExportExists =>
      'Esiste già un documento Google Sheets per questa lista.';

  @override
  String get smartTodoSheetsOpen => 'Apri';

  @override
  String get smartTodoSheetsUpdate => 'Aggiorna';

  @override
  String get smartTodoSheetsUpdating =>
      'Aggiornamento Google Sheets in corso...';

  @override
  String get smartTodoSheetsCreating => 'Creazione Google Sheets in corso...';

  @override
  String get smartTodoSheetsUpdated => 'Google Sheets aggiornato!';

  @override
  String get smartTodoSheetsCreated => 'Google Sheets creato!';

  @override
  String get smartTodoSheetsError => 'Errore durante l\'export (vedi log)';

  @override
  String get error => 'Errore';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Audit Log - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Utente';

  @override
  String get smartTodoAuditFilterType => 'Tipo';

  @override
  String get smartTodoAuditFilterAction => 'Azione';

  @override
  String get smartTodoAuditFilterTag => 'Tag';

  @override
  String get smartTodoAuditFilterSearch => 'Cerca';

  @override
  String get smartTodoAuditFilterAll => 'Tutti';

  @override
  String get smartTodoAuditFilterAllFemale => 'Tutte';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium richiesto per storico esteso';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'Ultimi $days giorni';
  }

  @override
  String get smartTodoAuditClearFilters => 'Pulisci Filtri';

  @override
  String get smartTodoAuditViewTimeline => 'Vista Timeline';

  @override
  String get smartTodoAuditViewColumns => 'Vista Colonne';

  @override
  String get smartTodoAuditNoActivity => 'Nessuna attività registrata';

  @override
  String get smartTodoAuditNoResults =>
      'Nessun risultato per i filtri selezionati';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count attività';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Nessuna attività';

  @override
  String get smartTodoAuditLoadMore => 'Carica altri 50...';

  @override
  String get smartTodoAuditEmptyValue => '(vuoto)';

  @override
  String get smartTodoAuditEntityList => 'Lista';

  @override
  String get smartTodoAuditEntityTask => 'Task';

  @override
  String get smartTodoAuditEntityInvite => 'Invito';

  @override
  String get smartTodoAuditEntityParticipant => 'Partecipante';

  @override
  String get smartTodoAuditEntityColumn => 'Colonna';

  @override
  String get smartTodoAuditEntityTag => 'Tag';

  @override
  String get smartTodoAuditActionCreate => 'Creato';

  @override
  String get smartTodoAuditActionUpdate => 'Modificato';

  @override
  String get smartTodoAuditActionDelete => 'Eliminato';

  @override
  String get smartTodoAuditActionArchive => 'Archiviato';

  @override
  String get smartTodoAuditActionRestore => 'Ripristinato';

  @override
  String get smartTodoAuditActionMove => 'Spostato';

  @override
  String get smartTodoAuditActionAssign => 'Assegnato';

  @override
  String get smartTodoAuditActionInvite => 'Invitato';

  @override
  String get smartTodoAuditActionJoin => 'Entrato';

  @override
  String get smartTodoAuditActionRevoke => 'Revocato';

  @override
  String get smartTodoAuditActionReorder => 'Riordinato';

  @override
  String get smartTodoAuditActionBatchCreate => 'Import';

  @override
  String get smartTodoAuditTimeNow => 'Adesso';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return '$count min fa';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return '$count ore fa';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return '$count giorni fa';
  }

  @override
  String get smartTodoCfdTitle => 'CFD Analytics';

  @override
  String get smartTodoCfdTooltip => 'CFD Analytics';

  @override
  String get smartTodoCfdDateRange => 'Periodo:';

  @override
  String get smartTodoCfd7Days => '7 giorni';

  @override
  String get smartTodoCfd14Days => '14 giorni';

  @override
  String get smartTodoCfd30Days => '30 giorni';

  @override
  String get smartTodoCfd90Days => '90 giorni';

  @override
  String get smartTodoCfdError => 'Errore nel caricamento';

  @override
  String get smartTodoCfdRetry => 'Aggiorna';

  @override
  String get smartTodoCfdNoData => 'Nessun dato disponibile';

  @override
  String get smartTodoCfdNoDataHint =>
      'I movimenti dei task saranno tracciati qui';

  @override
  String get smartTodoCfdKeyMetrics => 'Metriche Chiave';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Tempo dalla creazione al completamento';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Tempo dall\'inizio lavoro al completamento';

  @override
  String get smartTodoCfdThroughput => 'Throughput';

  @override
  String get smartTodoCfdThroughputTooltip => 'Task completati a settimana';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Lavoro in corso';

  @override
  String get smartTodoCfdLimit => 'Limite';

  @override
  String get smartTodoCfdCompleted => 'completati';

  @override
  String get smartTodoCfdFlowAnalysis => 'Analisi Flusso';

  @override
  String get smartTodoCfdArrived => 'Arrivati';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog in diminuzione';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog in aumento';

  @override
  String get smartTodoCfdBottlenecks => 'Rilevamento Colli di Bottiglia';

  @override
  String get smartTodoCfdNoBottlenecks => 'Nessun collo di bottiglia';

  @override
  String get smartTodoCfdTasks => 'task';

  @override
  String get smartTodoCfdAvgAge => 'Eta media';

  @override
  String get smartTodoCfdAgingWip => 'Lavori in Corso Invecchiati';

  @override
  String get smartTodoCfdTask => 'Task';

  @override
  String get smartTodoCfdColumn => 'Colonna';

  @override
  String get smartTodoCfdAge => 'Eta';

  @override
  String get smartTodoCfdDays => 'giorni';

  @override
  String get smartTodoCfdHowCalculated => 'Come viene calcolato?';

  @override
  String get smartTodoCfdMedian => 'Mediana';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Min';

  @override
  String get smartTodoCfdMax => 'Max';

  @override
  String get smartTodoCfdSample => 'Campione';

  @override
  String get smartTodoCfdVsPrevious => 'vs periodo precedente';

  @override
  String get smartTodoCfdArrivalRate => 'Tasso Arrivo';

  @override
  String get smartTodoCfdCompletionRate => 'Tasso Completamento';

  @override
  String get smartTodoCfdNetFlow => 'Flusso Netto';

  @override
  String get smartTodoCfdPerDay => '/giorno';

  @override
  String get smartTodoCfdPerWeek => '/settimana';

  @override
  String get smartTodoCfdSeverity => 'Severita';

  @override
  String get smartTodoCfdAssignee => 'Assegnatario';

  @override
  String get smartTodoCfdUnassigned => 'Non assegnato';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Il Lead Time misura il tempo totale dalla creazione di un task al suo completamento.\n\n**Formula:**\nLead Time = Data Completamento - Data Creazione\n\n**Metriche:**\n- **Media**: Media di tutti i lead time\n- **Mediana**: Valore centrale (meno sensibile agli outlier)\n- **P85**: L\'85% dei task viene completato entro questo tempo\n- **P95**: Il 95% dei task viene completato entro questo tempo\n\n**Perche e importante:**\nIl Lead Time rappresenta l\'esperienza del cliente - il tempo totale di attesa. Usa il P85 per dare stime di consegna ai clienti.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Il Cycle Time misura il tempo da quando il lavoro inizia effettivamente (il task esce da \'Da Fare\') fino al completamento.\n\n**Formula:**\nCycle Time = Data Completamento - Data Inizio Lavoro\n\n**Differenza dal Lead Time:**\n- **Lead Time** = Prospettiva cliente (include attesa)\n- **Cycle Time** = Prospettiva team (solo lavoro attivo)\n\n**Come viene rilevato \'Inizio Lavoro\':**\nLa prima volta che un task esce dalla colonna \'Da Fare\' viene registrata come data di inizio lavoro.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Il Throughput misura quanti task vengono completati per unita di tempo.\n\n**Formule:**\n- Media Giornaliera = Task Completati / Giorni nel Periodo\n- Media Settimanale = Media Giornaliera x 7\n\n**Come usarlo:**\nPrevisione date di consegna:\nTask Rimanenti / Throughput Settimanale = Settimane per Completare\n\n**Esempio:**\n30 task rimanenti, throughput di 10/settimana = ~3 settimane';

  @override
  String get smartTodoCfdWipExplanation =>
      'Il WIP (Work In Progress) conta i task attualmente in lavorazione - non in \'Da Fare\' e non in \'Fatto\'.\n\n**Formula:**\nWIP = Task Totali - Task in Da Fare - Task in Fatto\n\n**Legge di Little:**\nLead Time = WIP / Throughput\n\nRidurre il WIP riduce direttamente il Lead Time!\n\n**Limite WIP Suggerito:**\nDimensione Team x 2 (best practice Kanban)\n\n**Stato:**\n- Sano: WIP <= Limite\n- Attenzione: WIP > Limite x 1.25\n- Critico: WIP > Limite x 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'L\'Analisi del Flusso confronta il tasso di arrivo nuovi task vs task completati.\n\n**Formule:**\n- Tasso Arrivo = Nuovi Task Creati / Giorni\n- Tasso Completamento = Task Completati / Giorni\n- Flusso Netto = Completati - Arrivati\n\n**Interpretazione stato:**\n- **In Svuotamento** (Completamento > Arrivo): WIP in diminuzione - bene!\n- **Bilanciato** (entro +/-10%): Flusso stabile\n- **In Riempimento** (Arrivo > Completamento): WIP in aumento - azione necessaria';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Il Rilevamento Colli di Bottiglia identifica le colonne dove i task si accumulano o rimangono troppo a lungo.\n\n**Algoritmo:**\nSeverita = (Score Conteggio + Score Eta) / 2\n\nDove:\n- Score Conteggio = Task nella Colonna / 10\n- Score Eta = Eta Media / 7 giorni\n\n**Segnalato quando:**\n- 2+ task nella colonna, OPPURE\n- Eta media > 2 giorni\n\n**Livelli di severita:**\n- Basso (< 0.3): Monitorare\n- Medio (0.3-0.6): Investigare\n- Alto (> 0.6): Intervenire';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP mostra i task attualmente in lavorazione, ordinati per quanto tempo sono stati lavorati.\n\n**Formula:**\nEta = Ora Attuale - Data Inizio Lavoro (in giorni)\n\n**Stato per eta:**\n- Fresco (< 3 giorni): Normale\n- Attenzione (3-7 giorni): Potrebbe richiedere attenzione\n- Critico (> 7 giorni): Probabilmente bloccato - investigare!\n\nI task vecchi spesso indicano blocchi, requisiti poco chiari o scope creep.';

  @override
  String get smartTodoCfdTeamBalance => 'Bilanciamento Team';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Il Bilanciamento Team mostra la distribuzione dei task tra i membri.\n\n**Punteggio Bilanciamento:**\nCalcolato usando il coefficiente di variazione (CV).\nPunteggio = 1 / (1 + CV)\n\n**Stato:**\n- Bilanciato (≥80%): Lavoro distribuito equamente\n- Disomogeneo (50-80%): Qualche squilibrio\n- Sbilanciato (<50%): Disparita significativa\n\n**Colonne:**\n- Da Fare: Task in attesa\n- WIP: Task in lavorazione\n- Fatto: Task completati';

  @override
  String get smartTodoCfdBalanced => 'Bilanciato';

  @override
  String get smartTodoCfdUneven => 'Disomogeneo';

  @override
  String get smartTodoCfdImbalanced => 'Sbilanciato';

  @override
  String get smartTodoCfdMember => 'Membro';

  @override
  String get smartTodoCfdTotal => 'Totale';

  @override
  String get smartTodoCfdToDo => 'Da Fare';

  @override
  String get smartTodoCfdInProgress => 'In Corso';

  @override
  String get smartTodoCfdDone => 'Fatto';

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
  String get smartTodoAllTags => 'Tutti i tag';

  @override
  String smartTodoTagsCount(int count) {
    return '$count tag';
  }

  @override
  String get smartTodoFilterByTag => 'Filtra per tag';

  @override
  String get smartTodoTagAlreadyExists => 'Tag già esistente';

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
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

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
  String get kanbanWipExplanationTitle => 'Cosa sono i WIP Limits?';

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
  String get subscriptionLimitRetrospectives =>
      'Hai raggiunto il limite massimo di retrospettive. Passa a Premium per crearne di più.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Hai raggiunto il limite massimo di progetti Agile. Passa a Premium per crearne di più.';

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
  String get retroExportSuccessMessage =>
      'La tua retrospettiva è stata esportata su Google Sheets.';

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
  String get archiveShowArchived => 'Mostra Archiviati';

  @override
  String get archiveHideArchived => 'Nascondi Archiviati';

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
  String get archiveSuccessMessage => 'Progetto archiviato';

  @override
  String get archiveRestoreSuccessMessage => 'Progetto ripristinato';

  @override
  String get archiveErrorMessage => 'Errore archiviazione progetto';

  @override
  String get archiveRestoreErrorMessage => 'Errore ripristino progetto';

  @override
  String get archiveFilterLabel => 'Archivio';

  @override
  String get archiveFilterActive => 'Attivi';

  @override
  String get archiveFilterArchived => 'Archiviati';

  @override
  String get archiveFilterAll => 'Tutti';

  @override
  String get archiveBadge => 'ARCHIVIO';

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
  String get inviteDeclinedError => 'Errore nel rifiutare l\'invito';

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

  @override
  String get retroColumnDropDesc =>
      'Cosa non porta valore e dovrebbe essere eliminato?';

  @override
  String get retroColumnAddDesc => 'Quali nuove pratiche dovremmo introdurre?';

  @override
  String get retroColumnKeepDesc =>
      'Cosa sta funzionando bene e dovrebbe continuare?';

  @override
  String get retroColumnImproveDesc => 'Cosa possiamo fare meglio?';

  @override
  String get retroColumnStart => 'Inizia';

  @override
  String get retroColumnStartDesc =>
      'Quali nuove attività o processi dovremmo iniziare per migliorare?';

  @override
  String get retroColumnStop => 'Ferma';

  @override
  String get retroColumnStopDesc =>
      'Cosa non sta portando valore e dovremmo smettere di fare?';

  @override
  String get retroColumnContinue => 'Continua';

  @override
  String get retroColumnContinueDesc =>
      'Cosa sta funzionando bene e dobbiamo continuare a fare?';

  @override
  String get retroColumnLongedFor => 'Desiderato';

  @override
  String get retroColumnLikedDesc => 'Cosa ti è piaciuto di questo sprint?';

  @override
  String get retroColumnLearnedDesc => 'Cosa hai imparato di nuovo?';

  @override
  String get retroColumnLackedDesc => 'Cosa è mancato in questo sprint?';

  @override
  String get retroColumnLongedForDesc =>
      'Cosa desidereresti avere nel prossimo futuro?';

  @override
  String get retroColumnMadDesc => 'Cosa ti ha fatto arrabbiare o frustrare?';

  @override
  String get retroColumnSadDesc => 'Cosa ti ha deluso o reso triste?';

  @override
  String get retroColumnGladDesc => 'Cosa ti ha reso felice o soddisfatto?';

  @override
  String get retroColumnWindDesc =>
      'Cosa ci ha spinto avanti? Punti di forza e supporto.';

  @override
  String get retroColumnAnchorDesc =>
      'Cosa ci ha rallentato? Ostacoli e blocchi.';

  @override
  String get retroColumnRockDesc =>
      'Quali rischi futuri vediamo all\'orizzonte?';

  @override
  String get retroColumnGoalDesc => 'Qual è la nostra destinazione ideale?';

  @override
  String get retroColumnMoreDesc => 'Cosa dovremmo fare di più?';

  @override
  String get retroColumnLessDesc => 'Cosa dovremmo fare di meno?';

  @override
  String get actionTypeMaintain => 'Mantenere';

  @override
  String get actionTypeStop => 'Fermare';

  @override
  String get actionTypeBegin => 'Iniziare';

  @override
  String get actionTypeIncrease => 'Aumentare';

  @override
  String get actionTypeDecrease => 'Diminuire';

  @override
  String get actionTypePrevent => 'Prevenire';

  @override
  String get actionTypeCelebrate => 'Celebrare';

  @override
  String get actionTypeReplicate => 'Replicare';

  @override
  String get actionTypeShare => 'Condividere';

  @override
  String get actionTypeProvide => 'Fornire';

  @override
  String get actionTypePlan => 'Pianificare';

  @override
  String get actionTypeLeverage => 'Sfruttare';

  @override
  String get actionTypeRemove => 'Rimuovere';

  @override
  String get actionTypeMitigate => 'Mitigare';

  @override
  String get actionTypeAlign => 'Allineare';

  @override
  String get actionTypeEliminate => 'Eliminare';

  @override
  String get actionTypeImplement => 'Implementare';

  @override
  String get actionTypeEnhance => 'Migliorare';

  @override
  String get coachTipSSCWriting =>
      'Concentrati su comportamenti concreti e osservabili. Ogni elemento deve essere qualcosa su cui il team può agire direttamente. Evita affermazioni vaghe.';

  @override
  String get coachTipSSCVoting =>
      'Vota in base all\'impatto e alla fattibilità. Gli elementi più votati diventeranno gli impegni del prossimo sprint.';

  @override
  String get coachTipSSCDiscuss =>
      'Per ogni elemento più votato, definisci CHI farà COSA entro QUANDO. Trasforma le intuizioni in azioni specifiche.';

  @override
  String get coachTipMSGWriting =>
      'Crea uno spazio sicuro per le emozioni. Tutti i sentimenti sono validi. Concentrati sulla situazione, non sulla persona. Usa affermazioni tipo \'Mi sento...\'.';

  @override
  String get coachTipMSGVoting =>
      'Vota per identificare esperienze condivise. I pattern nelle emozioni rivelano dinamiche di team che richiedono attenzione.';

  @override
  String get coachTipMSGDiscuss =>
      'Riconosci le emozioni prima di risolvere i problemi. Chiedi \'Cosa aiuterebbe?\' invece di saltare alle soluzioni. Ascolta attivamente.';

  @override
  String get coachTip4LsWriting =>
      'Rifletti sugli apprendimenti, non solo sugli eventi. Pensa a quali intuizioni porterai avanti. Ogni L rappresenta una prospettiva diversa.';

  @override
  String get coachTip4LsVoting =>
      'Prioritizza gli apprendimenti che potrebbero migliorare gli sprint futuri. Concentrati sulla conoscenza trasferibile.';

  @override
  String get coachTip4LsDiscuss =>
      'Trasforma gli apprendimenti in documentazione o modifiche ai processi. Chiedi \'Come possiamo condividere questa conoscenza con altri?\'';

  @override
  String get coachTipSailboatWriting =>
      'Usa la metafora: il Vento ci spinge avanti (abilitatori), le Ancore ci rallentano (bloccanti), gli Scogli sono rischi futuri, l\'Isola è il nostro obiettivo.';

  @override
  String get coachTipSailboatVoting =>
      'Prioritizza in base all\'impatto del rischio e al potenziale degli abilitatori. Bilancia l\'affrontare i bloccanti con lo sfruttare i punti di forza.';

  @override
  String get coachTipSailboatDiscuss =>
      'Crea un registro rischi per gli scogli. Definisci strategie di mitigazione. Sfrutta i venti per superare le ancore.';

  @override
  String get coachTipDAKIWriting =>
      'Sii decisivo: Elimina ciò che spreca tempo, Aggiungi ciò che manca, Mantieni ciò che funziona, Migliora ciò che potrebbe essere meglio.';

  @override
  String get coachTipDAKIVoting =>
      'Vota pragmaticamente. Concentrati sui cambiamenti che avranno un impatto immediato e misurabile.';

  @override
  String get coachTipDAKIDiscuss =>
      'Prendi decisioni chiare come team. Per ogni elemento, impegnati in un\'azione specifica o decidi esplicitamente di non agire.';

  @override
  String get coachTipStarfishWriting =>
      'Usa le gradazioni: Mantieni (come è), Di Più (aumenta), Di Meno (diminuisci), Stop (elimina), Start (inizia). Questo permette feedback sfumati.';

  @override
  String get coachTipStarfishVoting =>
      'Considera lo sforzo vs l\'impatto. Gli elementi \'Di Più\' e \'Di Meno\' potrebbero essere più facili da implementare di \'Start\' e \'Stop\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Definisci metriche specifiche per \'di più\' e \'di meno\'. Quanto di più? Come misureremo? Stabilisci obiettivi di calibrazione chiari.';

  @override
  String get discussPromptSSCStart =>
      'Quale nuova pratica dovremmo iniziare? Pensa alle lacune nel nostro processo che una nuova abitudine potrebbe colmare.';

  @override
  String get discussPromptSSCStop =>
      'Cosa spreca il nostro tempo o energia? Considera le attività che non portano valore proporzionato al loro costo.';

  @override
  String get discussPromptSSCContinue =>
      'Cosa sta funzionando bene? Riconosci e rafforza le pratiche efficaci.';

  @override
  String get discussPromptMSGMad =>
      'Cosa ti ha frustrato? Ricorda, stiamo discutendo situazioni, non incolpando individui.';

  @override
  String get discussPromptMSGSad =>
      'Cosa ti ha deluso? Quali aspettative non sono state soddisfatte?';

  @override
  String get discussPromptMSGGlad =>
      'Cosa ti ha reso felice? Quali momenti ti hanno dato soddisfazione questo sprint?';

  @override
  String get discussPrompt4LsLiked =>
      'Cosa ti è piaciuto? Cosa ha reso il lavoro piacevole?';

  @override
  String get discussPrompt4LsLearned =>
      'Quale nuova competenza, intuizione o conoscenza hai acquisito?';

  @override
  String get discussPrompt4LsLacked =>
      'Cosa è mancato? Quali risorse, supporto o chiarezza avrebbero aiutato?';

  @override
  String get discussPrompt4LsLonged =>
      'Cosa desideri? Cosa renderebbe migliori gli sprint futuri?';

  @override
  String get discussPromptSailboatWind =>
      'Cosa ci ha spinto avanti? Quali sono i nostri punti di forza e supporto esterno?';

  @override
  String get discussPromptSailboatAnchor =>
      'Cosa ci ha rallentato? Quali ostacoli interni o esterni ci hanno frenato?';

  @override
  String get discussPromptSailboatRock =>
      'Quali rischi vediamo all\'orizzonte? Cosa potrebbe deragliarci se non affrontato?';

  @override
  String get discussPromptSailboatGoal =>
      'Qual è la nostra destinazione? Siamo allineati su dove stiamo andando?';

  @override
  String get discussPromptDAKIDrop =>
      'Cosa dovremmo eliminare? Cosa non porta valore?';

  @override
  String get discussPromptDAKIAdd =>
      'Cosa dovremmo introdurre? Cosa manca dal nostro toolkit?';

  @override
  String get discussPromptDAKIKeep =>
      'Cosa dobbiamo preservare? Cosa è essenziale per il nostro successo?';

  @override
  String get discussPromptDAKIImprove =>
      'Cosa potrebbe essere migliore? Dove possiamo migliorare?';

  @override
  String get discussPromptStarfishKeep =>
      'Cosa dovremmo mantenere esattamente così com\'è?';

  @override
  String get discussPromptStarfishMore =>
      'Cosa dovremmo aumentare? Fare di più?';

  @override
  String get discussPromptStarfishLess =>
      'Cosa dovremmo ridurre? Fare di meno?';

  @override
  String get discussPromptStarfishStop =>
      'Cosa dovremmo eliminare completamente?';

  @override
  String get discussPromptStarfishStart =>
      'Quale nuova cosa dovremmo iniziare?';

  @override
  String get discussPromptGeneric =>
      'Quali intuizioni sono emerse da questa colonna? Quali pattern vedi?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Quale specifica nuova pratica inizierai, e come misurerai la sua adozione?';

  @override
  String get smartPromptSSCStartExample =>
      'es., \'Iniziare standup giornaliero di 15 min alle 9:30, tracciare presenze per 2 settimane\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Inizieremo [pratica specifica] entro [data], misurata da [metrica]';

  @override
  String get smartPromptSSCStopQuestion =>
      'Cosa smetterai di fare, e cosa farai invece?';

  @override
  String get smartPromptSSCStopExample =>
      'es., \'Smettere di inviare aggiornamenti status via email, usare il canale Slack #updates invece\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Smetteremo di fare [pratica] e invece [alternativa]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Quale pratica continuerai, e come ti assicurerai che non svanisca?';

  @override
  String get smartPromptSSCContinueExample =>
      'es., \'Continuare code review entro 4 ore, aggiungere alla Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Continueremo [pratica], rafforzata da [meccanismo]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Quale azione affronterebbe questa frustrazione e chi la guiderà?';

  @override
  String get smartPromptMSGMadExample =>
      'es., \'Programmare meeting con PM per chiarire processo requisiti - Maria entro venerdì\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Azione per affrontare frustrazione], owner: [nome], entro: [data]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Quale cambiamento impedirebbe a questa delusione di ripetersi?';

  @override
  String get smartPromptMSGSadExample =>
      'es., \'Creare checklist comunicazione per aggiornamenti stakeholder - revisione settimanale\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Azione preventiva], tracciata via [metodo]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Come possiamo replicare o amplificare ciò che ci ha resi felici?';

  @override
  String get smartPromptMSGGladExample =>
      'es., \'Documentare formato sessione pairing e condividere con altri team entro fine settimana\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Azione per replicare/amplificare], condividere con [audience]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Come possiamo assicurare che questa esperienza positiva continui?';

  @override
  String get smartPrompt4LsLikedExample =>
      'es., \'Rendere la sessione mob programming un evento ricorrente settimanale sul calendario\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Azione per preservare esperienza positiva]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Come documenterai e condividerai questo apprendimento?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'es., \'Scrivere articolo wiki sul nuovo approccio testing, presentare in tech talk il mese prossimo\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Documentare in [posizione], condividere via [metodo] entro [data]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Quali specifiche risorse o supporto richiederai e a chi?';

  @override
  String get smartPrompt4LsLackedExample =>
      'es., \'Richiedere budget formazione CI/CD al manager - inviare entro prossimo planning\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Richiedere [risorsa] da [persona/team], deadline: [data]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Quale primo passo concreto ti avvicinerà a questo desiderio?';

  @override
  String get smartPrompt4LsLongedExample =>
      'es., \'Bozza proposta per 20% tempo per progetti side - condividere con team lead lunedì\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Primo passo verso [desiderio]: [azione] entro [data]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Come sfrutterai questo abilitatore per accelerare il progresso?';

  @override
  String get smartPromptSailboatWindExample =>
      'es., \'Usare forte competenza QA per fare mentoring ai junior - programmare prima sessione questa settimana\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Sfruttare [abilitatore] con [azione specifica]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Quale azione specifica rimuoverà o ridurrà questo bloccante?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'es., \'Escalare problema infrastruttura al CTO - preparare brief entro mercoledì\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Rimuovere [bloccante] con [azione], escalare a [persona] se necessario';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Quale strategia di mitigazione implementerai per questo rischio?';

  @override
  String get smartPromptSailboatRockExample =>
      'es., \'Aggiungere piano fallback per dipendenza vendor - documentare alternative entro fine sprint\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Mitigare [rischio] con [strategia], trigger: [condizione]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Quale milestone confermerà il progresso verso questo obiettivo?';

  @override
  String get smartPromptSailboatGoalExample =>
      'es., \'Demo MVP agli stakeholder entro 15 Feb, raccogliere feedback via survey\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Milestone verso [obiettivo]: [deliverable] entro [data]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'Cosa eliminerai e come ti assicurerai che non ritorni?';

  @override
  String get smartPromptDAKIDropExample =>
      'es., \'Rimuovere step deployment manuali - automatizzare entro fine sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Eliminare [pratica], prevenire ritorno con [meccanismo]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Quale nuova pratica introdurrai e come validerai che funziona?';

  @override
  String get smartPromptDAKIAddExample =>
      'es., \'Aggiungere sistema feature flag - provare su 2 feature, rivedere risultati in 2 settimane\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Aggiungere [pratica], validare successo via [metrica]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Come proteggerai questa pratica dall\'essere deprioritizzata?';

  @override
  String get smartPromptDAKIKeepExample =>
      'es., \'Mantenere standard code review - aggiungere a team charter, audit mensile\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Proteggere [pratica] con [meccanismo]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Quale specifico miglioramento farai e come misurerai il miglioramento?';

  @override
  String get smartPromptDAKIImproveExample =>
      'es., \'Migliorare copertura test dal 60% al 80% - focus su modulo pagamenti prima\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Migliorare [pratica] da [attuale] a [target] entro [data]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Quale pratica manterrai e chi è owner per garantire coerenza?';

  @override
  String get smartPromptStarfishKeepExample =>
      'es., \'Mantenere demo del venerdì - Tom si assicura sala prenotata, agenda condivisa entro giovedì\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Mantenere [pratica], owner: [nome]';

  @override
  String get smartPromptStarfishMoreQuestion => 'Cosa aumenterai e di quanto?';

  @override
  String get smartPromptStarfishMoreExample =>
      'es., \'Aumentare pair programming da 2h a 6h a settimana per sviluppatore\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Aumentare [pratica] da [livello attuale] a [livello target]';

  @override
  String get smartPromptStarfishLessQuestion => 'Cosa ridurrai e di quanto?';

  @override
  String get smartPromptStarfishLessExample =>
      'es., \'Ridurre meeting da 10h a 6h a settimana - cancellare review ricorrente\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Ridurre [pratica] da [livello attuale] a [livello target]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'Cosa smetterai completamente di fare e cosa lo sostituisce (se qualcosa)?';

  @override
  String get smartPromptStarfishStopExample =>
      'es., \'Smettere tracking tempo dettagliato sui task - stime basate su fiducia invece\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Smettere [pratica], sostituire con [alternativa] o niente';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Quale nuova pratica inizierai e quando sarà la prima occorrenza?';

  @override
  String get smartPromptStarfishStartExample =>
      'es., \'Iniziare tech debt Tuesday - prima sessione prossima settimana, 2h tempo protetto\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Iniziare [pratica], prima occorrenza: [data/ora]';

  @override
  String get smartPromptGenericQuestion =>
      'Quale azione specifica affronterà questo elemento?';

  @override
  String get smartPromptGenericExample =>
      'es., \'Definire azione specifica con owner, deadline, e criteri di successo\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Azione], owner: [nome], entro: [data]';

  @override
  String get methodologyFocusAction =>
      'Orientato all\'azione: si concentra su cambiamenti comportamentali concreti';

  @override
  String get methodologyFocusEmotion =>
      'Focalizzato sulle emozioni: esplora i sentimenti del team per costruire sicurezza psicologica';

  @override
  String get methodologyFocusLearning =>
      'Riflessivo sull\'apprendimento: enfatizza la cattura e condivisione della conoscenza';

  @override
  String get methodologyFocusRisk =>
      'Rischio e Obiettivo: bilancia abilitatori, bloccanti, rischi e obiettivi';

  @override
  String get methodologyFocusCalibration =>
      'Calibrazione: usa gradazioni (più/meno) per aggiustamenti sfumati';

  @override
  String get methodologyFocusDecision =>
      'Decisionale: guida decisioni chiare del team sulle pratiche';

  @override
  String get exportSheetOverview => 'Panoramica';

  @override
  String get exportSheetActionItems => 'Azioni';

  @override
  String get exportSheetBoardItems => 'Elementi Board';

  @override
  String get exportSheetTeamHealth => 'Salute del Team';

  @override
  String get exportSheetLessonsLearned => 'Lezioni Apprese';

  @override
  String get exportSheetRiskRegister => 'Registro Rischi';

  @override
  String get exportSheetCalibrationMatrix => 'Matrice Calibrazione';

  @override
  String get exportSheetDecisionLog => 'Registro Decisioni';

  @override
  String get exportHeaderRetrospectiveReport => 'REPORT RETROSPETTIVA';

  @override
  String get exportHeaderTitle => 'Titolo:';

  @override
  String get exportHeaderDate => 'Data:';

  @override
  String get exportHeaderTemplate => 'Template:';

  @override
  String get exportHeaderMethodology => 'Focus Metodologico:';

  @override
  String get exportHeaderSentiments => 'Sentimenti (Media):';

  @override
  String get exportHeaderParticipants => 'PARTECIPANTI';

  @override
  String get exportHeaderSummary => 'RIEPILOGO';

  @override
  String get exportHeaderTotalItems => 'Elementi Totali:';

  @override
  String get exportHeaderActionItems => 'Azioni:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Follow-up Suggerito:';

  @override
  String get exportTeamHealthTitle => 'ANALISI SALUTE DEL TEAM';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Distribuzione Emotiva';

  @override
  String get exportTeamHealthMadCount => 'Elementi Mad:';

  @override
  String get exportTeamHealthSadCount => 'Elementi Sad:';

  @override
  String get exportTeamHealthGladCount => 'Elementi Glad:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRAZIONI (Mad)';

  @override
  String get exportTeamHealthSadItems => 'DELUSIONI (Sad)';

  @override
  String get exportTeamHealthGladItems => 'CELEBRAZIONI (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Raccomandazione Salute Team:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Alto livello di frustrazione rilevato. Considera di facilitare una sessione focalizzata sulla risoluzione dei problemi.';

  @override
  String get exportTeamHealthBalanced =>
      'Stato emotivo equilibrato. Il team mostra sane capacità di riflessione.';

  @override
  String get exportTeamHealthPositive =>
      'Morale del team positivo. Sfrutta questa energia per miglioramenti sfidanti.';

  @override
  String get exportLessonsLearnedTitle => 'REGISTRO LEZIONI APPRESE';

  @override
  String get exportLessonsLearnedWhatWorked => 'COSA HA FUNZIONATO (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'NUOVE COMPETENZE E INTUIZIONI (Learned)';

  @override
  String get exportLessonsLearnedGaps => 'LACUNE E ELEMENTI MANCANTI (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ASPIRAZIONI FUTURE (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Azioni di Condivisione Conoscenza';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Documentazione Necessaria:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Formazione/Condivisione Necessaria:';

  @override
  String get exportRiskRegisterTitle => 'REGISTRO RISCHI E ABILITATORI';

  @override
  String get exportRiskRegisterEnablers => 'ABILITATORI (Vento)';

  @override
  String get exportRiskRegisterBlockers => 'BLOCCANTI (Ancora)';

  @override
  String get exportRiskRegisterRisks => 'RISCHI (Scogli)';

  @override
  String get exportRiskRegisterGoals => 'OBIETTIVI (Isola)';

  @override
  String get exportRiskRegisterRiskItem => 'Rischio';

  @override
  String get exportRiskRegisterImpact => 'Impatto Potenziale';

  @override
  String get exportRiskRegisterMitigation => 'Azione di Mitigazione';

  @override
  String get exportRiskRegisterStatus => 'Stato';

  @override
  String get exportRiskRegisterGoalAlignment =>
      'Verifica Allineamento Obiettivi:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Verificare se le azioni correnti sono allineate con gli obiettivi dichiarati.';

  @override
  String get exportCalibrationTitle => 'MATRICE DI CALIBRAZIONE';

  @override
  String get exportCalibrationKeepDoing => 'CONTINUARE A FARE';

  @override
  String get exportCalibrationDoMore => 'FARE DI PIÙ';

  @override
  String get exportCalibrationDoLess => 'FARE DI MENO';

  @override
  String get exportCalibrationStopDoing => 'SMETTERE DI FARE';

  @override
  String get exportCalibrationStartDoing => 'INIZIARE A FARE';

  @override
  String get exportCalibrationPractice => 'Pratica';

  @override
  String get exportCalibrationCurrentState => 'Stato Attuale';

  @override
  String get exportCalibrationTargetState => 'Stato Obiettivo';

  @override
  String get exportCalibrationAdjustment => 'Aggiustamento';

  @override
  String get exportCalibrationNote =>
      'La calibrazione si concentra sulla messa a punto delle pratiche esistenti piuttosto che su cambiamenti radicali.';

  @override
  String get exportDecisionLogTitle => 'REGISTRO DECISIONI';

  @override
  String get exportDecisionLogDrop => 'DECISIONI DA ABBANDONARE';

  @override
  String get exportDecisionLogAdd => 'DECISIONI DA AGGIUNGERE';

  @override
  String get exportDecisionLogKeep => 'DECISIONI DA MANTENERE';

  @override
  String get exportDecisionLogImprove => 'DECISIONI DA MIGLIORARE';

  @override
  String get exportDecisionLogDecision => 'Decisione';

  @override
  String get exportDecisionLogRationale => 'Motivazione';

  @override
  String get exportDecisionLogOwner => 'Responsabile';

  @override
  String get exportDecisionLogDeadline => 'Scadenza';

  @override
  String get exportDecisionLogPrioritizationNote => 'Raccomandazione Priorità:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Concentrarsi prima sulle decisioni DROP per liberare capacità, poi aggiungere nuove pratiche.';

  @override
  String get exportNoItems => 'Nessun elemento registrato';

  @override
  String get exportNoActionItems => 'Nessuna azione';

  @override
  String get exportNotApplicable => 'N/D';

  @override
  String get facilitatorGuideTitle => 'Guida Raccolta Azioni';

  @override
  String get facilitatorGuideCoverage => 'Copertura';

  @override
  String get facilitatorGuideComplete => 'Completa';

  @override
  String get facilitatorGuideIncomplete => 'Incompleta';

  @override
  String get facilitatorGuideSuggestedOrder => 'Ordine Suggerito:';

  @override
  String get facilitatorGuideMissingRequired => 'Azioni richieste mancanti';

  @override
  String get facilitatorGuideColumnHasAction => 'Ha azione';

  @override
  String get facilitatorGuideColumnNoAction => 'Nessuna azione';

  @override
  String get facilitatorGuideRequired => 'Richiesto';

  @override
  String get facilitatorGuideOptional => 'Opzionale';

  @override
  String get agileEdit => 'Modifica';

  @override
  String get agileSettings => 'Impostazioni';

  @override
  String get agileDelete => 'Elimina';

  @override
  String get agileDeleteProjectTitle => 'Elimina Progetto';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Sei sicuro di voler eliminare \"$projectName\"?';
  }

  @override
  String get agileDeleteProjectWarning =>
      'Questa azione eliminerà permanentemente:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count user stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count sprint';
  }

  @override
  String get agileDeleteProjectData => 'Tutti i dati del progetto';

  @override
  String get agileProjectSettingsTitle => 'Impostazioni Progetto';

  @override
  String get agileKeyRoles => 'Ruoli Chiave';

  @override
  String get agileKeyRolesSubtitle =>
      'Assegna i ruoli principali del team Scrum';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Gestisce il backlog e definisce le priorità del prodotto';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Facilita il processo Scrum e rimuove gli ostacoli';

  @override
  String get agileRoleDevTeam => 'Development Team';

  @override
  String get agileNoDevTeamMembers =>
      'Nessun membro nel team. Clicca + per aggiungere.';

  @override
  String get agileRolesInfo =>
      'I ruoli verranno mostrati con icone dedicate nella lista progetti. Puoi aggiungere altri partecipanti dal Team del progetto.';

  @override
  String agileAssignedTo(String name) {
    return 'Assegnato a $name';
  }

  @override
  String get agileUnassigned => 'Non assegnato';

  @override
  String get agileAssignableLater => 'Assegnabile dopo la creazione';

  @override
  String get agileAddToTeam => 'Aggiungi al Team';

  @override
  String get agileAllMembersAssigned =>
      'Tutti i partecipanti sono già assegnati a un ruolo.';

  @override
  String get agileClose => 'Chiudi';

  @override
  String get agileProjectNameLabel => 'Nome Progetto *';

  @override
  String get agileProjectNameHint => 'Es: Fashion PMO v2';

  @override
  String get agileEnterProjectName => 'Inserisci il nome del progetto';

  @override
  String get agileProjectDescLabel => 'Descrizione';

  @override
  String get agileProjectDescHint => 'Descrizione opzionale del progetto';

  @override
  String get agileFrameworkLabel => 'Framework Agile';

  @override
  String get agileDiscoverDifferences => 'Scopri le differenze';

  @override
  String get agileSprintConfig => 'Configurazione Sprint';

  @override
  String get agileSprintDuration => 'Durata Sprint (giorni)';

  @override
  String get agileHoursPerDay => 'Ore/Giorno';

  @override
  String get agileCreateProjectTitle => 'Nuovo Progetto Agile';

  @override
  String get agileEditProjectTitle => 'Modifica Progetto';

  @override
  String get agileSelectParticipant => 'Seleziona partecipante';

  @override
  String get agileAssignRolesHint =>
      'Assegna i ruoli principali.\nPotrai modificarli anche dalle impostazioni.';

  @override
  String get agileArchiveAction => 'Archivia';

  @override
  String get agileRestoreAction => 'Ripristina';

  @override
  String get agileSetupTitle => 'Setup del Progetto';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed di $total passi completati';
  }

  @override
  String get agileSetupCompleteTitle => 'Setup Completato!';

  @override
  String get agileSetupCompleteMessage =>
      'Il tuo progetto è pronto per iniziare.';

  @override
  String get agileChecklistAddMembers => 'Aggiungi membri al team';

  @override
  String get agileChecklistAddMembersDesc =>
      'Invita i membri del team a collaborare';

  @override
  String get agileChecklistInvite => 'Invita';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Crea le prime $itemType';
  }

  @override
  String get agileChecklistAddItems => 'Aggiungi almeno 3 item al backlog';

  @override
  String get agileChecklistAdd => 'Aggiungi';

  @override
  String get agileChecklistWipLimits => 'Configura i WIP limits';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Imposta limiti per ogni colonna Kanban';

  @override
  String get agileChecklistConfigure => 'Configura';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Stima le $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Assegna Story Points per pianificare meglio';

  @override
  String get agileChecklistCreateSprint => 'Crea il primo Sprint';

  @override
  String get agileChecklistSprintDesc =>
      'Seleziona le storie e inizia a lavorare';

  @override
  String get agileChecklistCreateSprintAction => 'Crea Sprint';

  @override
  String get agileChecklistStartWork => 'Inizia a lavorare';

  @override
  String get agileChecklistStartWorkDesc => 'Sposta un item in lavorazione';

  @override
  String get agileTipStartSprintTitle => 'Pronto per uno Sprint?';

  @override
  String get agileTipStartSprintMessage =>
      'Hai abbastanza stories nel backlog. Considera di pianificare il primo Sprint.';

  @override
  String get agileTipWipTitle => 'Configura i WIP Limits';

  @override
  String get agileTipWipMessage =>
      'I WIP limits sono fondamentali in Kanban. Limita il lavoro in corso per migliorare il flusso.';

  @override
  String get agileTipHybridTitle => 'Configura il tuo Scrumban';

  @override
  String get agileTipHybridMessage =>
      'Puoi usare Sprint per cadenza o WIP limits per flusso continuo. Sperimenta!';

  @override
  String get agileTipDiscover => 'Scopri';

  @override
  String get agileTipClose => 'Chiudi';

  @override
  String get agileNextStepInviteTitle => 'Invita il Team';

  @override
  String get agileNextStepInviteDesc =>
      'Aggiungi membri per collaborare al progetto.';

  @override
  String get agileNextStepBacklogTitle => 'Crea il Backlog';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Aggiungi le prime $itemType al backlog.';
  }

  @override
  String get agileNextStepSprintTitle => 'Pianifica uno Sprint';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'Hai $count items pronti. Crea il primo Sprint!';
  }

  @override
  String get agileNextStepWipTitle => 'Configura WIP Limits';

  @override
  String get agileNextStepWipDesc =>
      'Limita il lavoro in corso per migliorare il flusso.';

  @override
  String get agileNextStepWorkTitle => 'Inizia a Lavorare';

  @override
  String get agileNextStepWorkDesc =>
      'Sposta un item \"In Progress\" per iniziare.';

  @override
  String get agileNextStepGoToKanban => 'Vai al Kanban';

  @override
  String get agileActionNewStory => 'Nuova Story';

  @override
  String get agileBacklogTitle => 'Product Backlog';

  @override
  String get agileBacklogArchiveTitle => 'Archivio Completate';

  @override
  String get agileBacklogToggleActive => 'Mostra Backlog attivo';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Mostra Archivio ($count completate)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Archivio ($count)';
  }

  @override
  String get agileBacklogSearchHint => 'Cerca per titolo, descrizione o ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count storie';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points pt';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count stimate';
  }

  @override
  String get agileFiltersStatus => 'Stato:';

  @override
  String get agileFiltersPriority => 'Priorità:';

  @override
  String get agileFiltersTags => 'Tag:';

  @override
  String get agileFiltersAll => 'Tutti';

  @override
  String get agileFiltersClear => 'Rimuovi filtri';

  @override
  String get agileEmptyBacklogMatch => 'Nessuna story trovata';

  @override
  String get agileEmptyBacklog => 'Backlog vuoto';

  @override
  String get agileEmptyBacklogHint => 'Aggiungi la prima User Story';

  @override
  String get agileEstTitle => 'Stima Story';

  @override
  String get agileEstMethod => 'Metodo di stima';

  @override
  String get agileEstSelectValue => 'Seleziona un valore';

  @override
  String get agileEstSubmit => 'Conferma Stima';

  @override
  String get agileEstCancel => 'Annulla';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc =>
      'Seleziona la complessità della story in story points';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc =>
      'Seleziona la dimensione relativa della story';

  @override
  String get agileEstThreePointTitle => 'Stima a Tre Punti (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Inserisci tre valori per calcolare la stima PERT';

  @override
  String get agileEstBucketTitle => 'Bucket System';

  @override
  String get agileEstBucketDesc => 'Posiziona la story nel bucket appropriato';

  @override
  String get agileEstBucketHint =>
      'I bucket più grandi indicano story più complesse';

  @override
  String get agileEstReference => 'Riferimento:';

  @override
  String get agileEstRefXS => 'XS = Poche ore';

  @override
  String get agileEstRefS => 'S = ~1 giorno';

  @override
  String get agileEstRefM => 'M = ~2-3 giorni';

  @override
  String get agileEstRefL => 'L = ~1 settimana';

  @override
  String get agileEstRefXL => 'XL = ~2 settimane';

  @override
  String get agileEstRefXXL => 'XXL = Troppo grande, dividere';

  @override
  String get agileEstOptimistic => 'Ottimistica (O)';

  @override
  String get agileEstOptimisticHint => 'Caso migliore';

  @override
  String get agileEstMostLikely => 'Più Probabile (M)';

  @override
  String get agileEstMostLikelyHint => 'Caso probabile';

  @override
  String get agileEstPessimistic => 'Pessimistica (P)';

  @override
  String get agileEstPessimisticHint => 'Caso peggiore';

  @override
  String get agileEstPointsSuffix => 'pt';

  @override
  String get agileEstFormula => 'Formula PERT: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Stima: $value punti';
  }

  @override
  String get agileEstErrorThreePoint => 'Inserisci tutti e tre i valori';

  @override
  String get agileEstErrorSelect => 'Seleziona un valore';

  @override
  String agileEstExisting(int count) {
    return 'Stime esistenti ($count)';
  }

  @override
  String get agileEstYou => 'Tu';

  @override
  String get scrumPermBacklogTitle => 'Permessi Backlog';

  @override
  String get scrumPermBacklogDesc =>
      'Solo il Product Owner può creare, modificare, eliminare e prioritizzare le stories';

  @override
  String get scrumPermSprintTitle => 'Permessi Sprint';

  @override
  String get scrumPermSprintDesc =>
      'Solo lo Scrum Master può creare, avviare e completare gli sprint';

  @override
  String get scrumPermEstimateTitle => 'Permessi Stima';

  @override
  String get scrumPermEstimateDesc =>
      'Solo il Development Team può stimare le stories';

  @override
  String get scrumPermKanbanTitle => 'Permessi Kanban';

  @override
  String get scrumPermKanbanDesc =>
      'Il Development Team può spostare le proprie stories, PO e SM possono spostare qualsiasi story';

  @override
  String get scrumPermTeamTitle => 'Permessi Team';

  @override
  String get scrumPermTeamDesc =>
      'PO e SM possono invitare membri, solo il PO può modificare i ruoli';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Solo il Product Owner può creare nuove stories';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Solo il Product Owner può modificare le stories';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Solo il Product Owner può eliminare le stories';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Solo il Product Owner può riordinare il backlog';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Solo lo Scrum Master può creare nuovi sprint';

  @override
  String get scrumPermDeniedSprintStart =>
      'Solo lo Scrum Master può avviare gli sprint';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Solo lo Scrum Master può completare gli sprint';

  @override
  String get scrumPermDeniedEstimate =>
      'Solo il Development Team può stimare le stories';

  @override
  String get scrumPermDeniedInvite =>
      'Solo PO e SM possono invitare nuovi membri';

  @override
  String get scrumPermDeniedRoleChange =>
      'Solo il Product Owner può modificare i ruoli del team';

  @override
  String get scrumPermDeniedWipConfig =>
      'Solo lo Scrum Master può configurare i limiti WIP';

  @override
  String get scrumRoleProductOwner => 'Product Owner';

  @override
  String get scrumRoleScrumMaster => 'Scrum Master';

  @override
  String get scrumRoleDeveloper => 'Developer';

  @override
  String get scrumRoleDesigner => 'Designer';

  @override
  String get scrumRoleQA => 'QA';

  @override
  String get scrumRoleStakeholder => 'Stakeholder';

  @override
  String get scrumMatrixTitle => 'Matrice Permessi Scrum';

  @override
  String get scrumMatrixSubtitle =>
      'Chi può fare cosa secondo la Scrum Guide 2020';

  @override
  String get scrumMatrixLegend => 'Legenda';

  @override
  String get scrumMatrixLegendFull => 'Gestisce';

  @override
  String get scrumMatrixLegendPartial => 'Parziale';

  @override
  String get scrumMatrixLegendView => 'Visualizza';

  @override
  String get scrumMatrixLegendNone => 'Nessuno';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'STIMA';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'TEAM';

  @override
  String get scrumMatrixCategoryRetro => 'RETROSPETTIVA';

  @override
  String get scrumMatrixActionCreateStory => 'Creare Story';

  @override
  String get scrumMatrixActionEditStory => 'Modificare Story';

  @override
  String get scrumMatrixActionDeleteStory => 'Eliminare Story';

  @override
  String get scrumMatrixActionPrioritize => 'Prioritizzare Backlog';

  @override
  String get scrumMatrixActionAddAcceptance => 'Definire Criteri Accettazione';

  @override
  String get scrumMatrixActionCreateSprint => 'Creare Sprint';

  @override
  String get scrumMatrixActionStartSprint => 'Avviare Sprint';

  @override
  String get scrumMatrixActionCompleteSprint => 'Completare Sprint';

  @override
  String get scrumMatrixActionConfigWip => 'Configurare Limiti WIP';

  @override
  String get scrumMatrixActionEstimate => 'Stimare Story Points';

  @override
  String get scrumMatrixActionFinalEstimate => 'Definire Stima Finale';

  @override
  String get scrumMatrixActionMoveOwn => 'Spostare proprie Story';

  @override
  String get scrumMatrixActionMoveAny => 'Spostare qualsiasi Story';

  @override
  String get scrumMatrixActionSelfAssign => 'Auto-assegnarsi';

  @override
  String get scrumMatrixActionAssignOthers => 'Assegnare altri';

  @override
  String get scrumMatrixActionChangeStatus => 'Cambiare stato Story';

  @override
  String get scrumMatrixActionInvite => 'Invitare membri';

  @override
  String get scrumMatrixActionRemove => 'Rimuovere membri';

  @override
  String get scrumMatrixActionChangeRole => 'Cambiare ruoli';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Facilitare Retrospettiva';

  @override
  String get scrumMatrixActionParticipateRetro => 'Partecipare Retrospettiva';

  @override
  String get scrumMatrixActionAddRetroItem => 'Aggiungere item Retro';

  @override
  String get scrumMatrixActionVoteRetro => 'Votare item';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Invita al Team';

  @override
  String get agileInviteNew => 'NUOVO INVITO';

  @override
  String get agileInviteEmailLabel => 'Email';

  @override
  String get agileInviteEmailHint => 'nome@esempio.com';

  @override
  String get agileInviteEnterEmail => 'Inserisci un\'email';

  @override
  String get agileInviteInvalidEmail => 'Email non valida';

  @override
  String get agileInviteProjectRole => 'Ruolo nel Progetto';

  @override
  String get agileInviteTeamRole => 'Ruolo nel Team';

  @override
  String get agileInviteSendEmail => 'Invia email di notifica';

  @override
  String get agileInviteSendBtn => 'Invia Invito';

  @override
  String get agileInviteLink => 'Link di invito:';

  @override
  String get agileInviteLinkCopied => 'Link copiato!';

  @override
  String get agileInviteListTitle => 'INVITI';

  @override
  String get agileInviteClose => 'Chiudi';

  @override
  String get agileInviteGmailAuthTitle => 'Autorizzazione Gmail';

  @override
  String get agileInviteGmailAuthContent =>
      'Per inviare email di invito, è necessario ri-autenticarsi con Google.\n\nVuoi procedere?';

  @override
  String get agileInviteGmailAuthNo => 'No, solo link';

  @override
  String get agileInviteGmailAuthYes => 'Autorizza';

  @override
  String agileInviteSentEmail(String email) {
    return 'Invito inviato via email a $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Invito creato per $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Revocare invito?';

  @override
  String get agileInviteRevokeContent => 'L\'invito non sarà più valido.';

  @override
  String get agileInviteRevokeBtn => 'Revoca';

  @override
  String get agileInviteResend => 'Reinvia';

  @override
  String get agileInviteResent => 'Invito reinviato';

  @override
  String get agileInviteStatusPending => 'In attesa';

  @override
  String get agileInviteStatusAccepted => 'Accettato';

  @override
  String get agileInviteStatusDeclined => 'Rifiutato';

  @override
  String get agileInviteStatusExpired => 'Scaduto';

  @override
  String get agileInviteStatusRevoked => 'Revocato';

  @override
  String get agileRoleMember => 'Membro';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Osservatore';

  @override
  String get agileRoleOwner => 'Proprietario';

  @override
  String get agileEditStory => 'Modifica Story';

  @override
  String get agileNewStory => 'Nuova User Story';

  @override
  String get agileDetailsTab => 'Dettagli';

  @override
  String get agileAcceptanceCriteriaTab => 'Acceptance Criteria';

  @override
  String get agileOtherTab => 'Altro';

  @override
  String get agileTitleLabel => 'Titolo';

  @override
  String get agileTitleHint => 'Breve descrizione della funzionalità';

  @override
  String get agileUseStoryTemplate => 'Usa template User Story';

  @override
  String get agileStoryTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get agileAsA => 'As a...';

  @override
  String get agileAsAHint => 'utente, admin, cliente...';

  @override
  String get agileIWant => 'I want...';

  @override
  String get agileIWantHint => 'poter fare qualcosa...';

  @override
  String get agileSoThat => 'So that...';

  @override
  String get agileSoThatHint => 'ottenere un beneficio...';

  @override
  String get agileDescriptionLabel => 'Descrizione';

  @override
  String get agileDescriptionHint => 'Descrizione libera della story';

  @override
  String get agilePreview => 'Anteprima:';

  @override
  String get agileEmptyDescription => '(descrizione vuota)';

  @override
  String get agileDefineComplete =>
      'Definisci quando la story può considerarsi completata';

  @override
  String get agileAddCriterionHint => 'Aggiungi criterio di accettazione...';

  @override
  String get agileNoCriteria => 'Nessun criterio definito';

  @override
  String get agileSuggestions => 'Suggerimenti:';

  @override
  String get agilePriorityMoscow => 'Priorità (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Basso valore di business';

  @override
  String get agileBusinessValueMedium => 'Valore medio';

  @override
  String get agileBusinessValueHigh => 'Alto valore di business';

  @override
  String get agileEstimatedStoryPoints => 'Stimata in Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Gli Story Points rappresentano la complessità relativa del lavoro.\nUsa la sequenza di Fibonacci: 1 (semplice) -> 21 (molto complessa).';

  @override
  String get agileNoPoints => 'Nessuna';

  @override
  String get agileAddTagHint => 'Aggiungi tag...';

  @override
  String get agileExistingTags => 'Tag esistenti:';

  @override
  String get agileAssignTo => 'Assegna a';

  @override
  String get agileSelectMemberHint => 'Seleziona un membro del team';

  @override
  String get agilePointsComplexityVeryLow => 'Compito rapido e semplice';

  @override
  String get agilePointsComplexityLow => 'Compito di media complessità';

  @override
  String get agilePointsComplexityMedium =>
      'Compito complesso, richiede analisi';

  @override
  String get agilePointsComplexityHigh =>
      'Molto complesso, considera di spezzare la story';

  @override
  String agileDurationDays(Object days) {
    return 'Durata: $days giorni';
  }

  @override
  String get agilePriorityMust => 'Must Have';

  @override
  String get agilePriorityShould => 'Should Have';

  @override
  String get agilePriorityCould => 'Could Have';

  @override
  String get agilePriorityWont => 'Won\'t Have';

  @override
  String get agileSelectedPoints => 'Punti Selezionati';

  @override
  String get agileSuggestedPoints => 'Punti Suggeriti';

  @override
  String agileDaysRemaining(Object days) {
    return '${days}g rimanenti';
  }

  @override
  String get agileSelectAtLeastOne => 'Seleziona almeno una storia';

  @override
  String agileConfirmStories(String count) {
    return 'Conferma $count storie';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Le policy esplicite definiscono le regole per questa colonna (Kanban Practice #4)';

  @override
  String get kanbanPoliciesEmpty => 'Nessuna policy definita';

  @override
  String get kanbanPoliciesAdd => 'Aggiungi policy';

  @override
  String get kanbanPoliciesHint => 'Es: Max 24h in questa colonna';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Policy attive: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Revisione del lavoro completato con gli stakeholder';

  @override
  String get sprintReviewConductBy => 'Condotto da';

  @override
  String get sprintReviewDate => 'Data Review';

  @override
  String get sprintReviewAttendees => 'Partecipanti';

  @override
  String get sprintReviewSelectAttendees => 'Seleziona partecipanti';

  @override
  String get sprintReviewDemoNotes => 'Note Demo';

  @override
  String get sprintReviewDemoNotesHint => 'Descrivi le funzionalità dimostrate';

  @override
  String get sprintReviewFeedback => 'Feedback Ricevuto';

  @override
  String get sprintReviewFeedbackHint => 'Feedback dagli stakeholder';

  @override
  String get sprintReviewBacklogUpdates => 'Aggiornamenti Backlog';

  @override
  String get sprintReviewBacklogUpdatesHint => 'Modifiche al backlog discusse';

  @override
  String get sprintReviewNextFocus => 'Focus Prossimo Sprint';

  @override
  String get sprintReviewNextFocusHint => 'Priorità per il prossimo sprint';

  @override
  String get sprintReviewMarketNotes => 'Note Mercato/Budget';

  @override
  String get sprintReviewMarketNotesHint =>
      'Condizioni di mercato, timeline, budget';

  @override
  String get sprintReviewStoriesCompleted => 'Storie Completate';

  @override
  String get sprintReviewStoriesNotCompleted => 'Storie Non Completate';

  @override
  String get sprintReviewPointsCompleted => 'Punti Completati';

  @override
  String get sprintReviewSave => 'Salva Review';

  @override
  String get sprintReviewWarning => 'Attenzione: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'La Sprint Review non è ancora stata effettuata. Secondo lo Scrum Guide 2020, la Sprint Review è un evento obbligatorio prima di completare lo sprint.';

  @override
  String get sprintReviewCompleteAnyway => 'Completa comunque';

  @override
  String get sprintReviewDoReview => 'Effettua Review';

  @override
  String get sprintReviewCompleted => 'Sprint Review completata';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Raggruppa le card per attributo';

  @override
  String get swimlaneTypeNone => 'Nessuna';

  @override
  String get swimlaneTypeNoneDesc => 'Vista standard senza raggruppamento';

  @override
  String get swimlaneTypeClassOfService => 'Classe di Servizio';

  @override
  String get swimlaneTypeClassOfServiceDesc => 'Raggruppa per priorità/urgenza';

  @override
  String get swimlaneTypeAssignee => 'Assegnatario';

  @override
  String get swimlaneTypeAssigneeDesc => 'Raggruppa per membro del team';

  @override
  String get swimlaneTypePriority => 'Priorità';

  @override
  String get swimlaneTypePriorityDesc => 'Raggruppa per livello di priorità';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Raggruppa per tag della storia';

  @override
  String get swimlaneUnassigned => 'Non Assegnato';

  @override
  String get swimlaneNoTag => 'Senza Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Misura la quantità di story points completati per sprint. Aiuta a prevedere la capacità del team.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Tempo totale dalla creazione al completamento. Include il tempo di attesa nel backlog.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Tempo dall\'inizio lavoro al completamento. Misura l\'efficienza dello sviluppo.';

  @override
  String get agileMetricsThroughputDesc =>
      'Numero di item completati per unità di tempo. Indica la produttività.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualizza la distribuzione per stato. Aiuta a identificare colli di bottiglia.';

  @override
  String get agilePredictability => 'Prevedibilità';

  @override
  String agilePredictabilityDesc(int days) {
    return 'L\'85% degli item viene completato in ≤$days giorni';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Item completati/settimana (ultime $weeks sett.)';
  }

  @override
  String get agileNoDataVelocity => 'Nessun dato velocity';

  @override
  String get agileNoDataLeadTime => 'Nessun dato lead time';

  @override
  String get agileNoDataCycleTime => 'Nessun dato cycle time';

  @override
  String get agileNoDataThroughput => 'Nessun dato throughput';

  @override
  String get agileNoDataAccuracy => 'Nessun dato accuracy';

  @override
  String get agileStartFinishOneItem => 'Completa almeno un item per calcolare';

  @override
  String get timeDays => 'giorni';

  @override
  String get auditLogTitle => 'Audit Log';

  @override
  String auditLogEventCount(int count) {
    return '$count eventi';
  }

  @override
  String get actionRefresh => 'Aggiorna';

  @override
  String get auditLogFilterEntityType => 'Tipo';

  @override
  String get auditLogFilterAction => 'Azione';

  @override
  String get auditLogFilterFromDate => 'Da';

  @override
  String get actionDetails => 'Dettagli';

  @override
  String get auditLogDetailsTitle => 'Dettagli Modifica';

  @override
  String get auditLogPreviousValue => 'Valore precedente:';

  @override
  String get auditLogNewValue => 'Nuovo valore:';

  @override
  String get auditLogNoEvents => 'Nessun evento registrato';

  @override
  String get auditLogNoEventsDesc =>
      'Le attività sul progetto verranno registrate qui';

  @override
  String get recentActivityTitle => 'Attività Recente';

  @override
  String get actionViewAll => 'Vedi tutto';

  @override
  String get recentActivityNone => 'Nessuna attività recente';

  @override
  String get burndownChartTitle => 'Burndown Chart';

  @override
  String get agileIdeal => 'Ideale';

  @override
  String get agileActual => 'Reale';

  @override
  String get agileRemaining => 'Rimanenti';

  @override
  String get agileBurndownNoDataDesc =>
      'I dati appariranno quando lo sprint sarà attivo';

  @override
  String get agileCompleteActiveFirst =>
      'Completa lo sprint attivo prima di avviarne un altro';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'Senza tag';

  @override
  String get kanbanWipExceededBanner =>
      'WIP Limit superato! Completa alcuni item prima di iniziarne di nuovi.';

  @override
  String get kanbanConfigWip => 'Configura WIP';

  @override
  String get kanbanPoliciesDesc =>
      'Le policy esplicite aiutano il team a capire le regole di questa colonna.';

  @override
  String get kanbanNewPolicyHint => 'Nuova policy...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count di $limit max';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'WIP (Work In Progress) Limits sono limiti sul numero di item che possono essere in una colonna contemporaneamente.';

  @override
  String get kanbanUnderstand => 'Ho capito';

  @override
  String get agileHours => 'Ore';

  @override
  String get agileStoriesPerSprint => 'Stories / Sprint';

  @override
  String get agileSprints => 'Sprint';

  @override
  String get agileTeamComposition => 'Composizione Team';

  @override
  String get agileHoursNote =>
      'Le ore sono un riferimento interno. Per la pianificazione Scrum, usa la vista Story Points.';

  @override
  String get agileNoTeamMembers => 'Nessun membro nel team';

  @override
  String get agileGmailAuthError =>
      'Autorizzazione Gmail non disponibile. Prova a fare logout e login.';

  @override
  String get agileGmailPermissionDenied => 'Permesso Gmail non concesso.';

  @override
  String get agileResend => 'Reinvia';

  @override
  String get agileRevoke => 'Revoca';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filtri';

  @override
  String get agilePlanned => 'Pianificato';

  @override
  String get archiveDeleteSuccess => 'Archiviato/eliminato con successo';

  @override
  String get agileNoItems => 'Nessun elemento da mostrare';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed di $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Elementi Completati';

  @override
  String get agileDaysRemainingSuffix => 'giorni rimanenti';

  @override
  String get agileItems => 'items';

  @override
  String get agilePerWeekSuffix => '/sett';

  @override
  String get average => 'Media';

  @override
  String agileItemsCount(int count) {
    return '$count elementi';
  }

  @override
  String get agileDaysLeft => 'Giorni Rimanenti';

  @override
  String get all => 'Tutti';

  @override
  String get kanbanGuidePoliciesTitle => 'Policy Esplicite';

  @override
  String get agileDaysLabel => 'Giorni';

  @override
  String get agileStatRemaining => 'rimasti';

  @override
  String get agileStatsCompletedLabel => 'Completati';

  @override
  String get agileStatsPlannedLabel => 'Pianificati';

  @override
  String get agileProgressLabel => 'Progresso';

  @override
  String get agileDurationLabel => 'Durata';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Storie';

  @override
  String get agileSprintSummary => 'Riepilogo Sprint';

  @override
  String get agileStoriesTotal => 'Storie totali';

  @override
  String get agileStoriesCompleted => 'Storie completate';

  @override
  String get agilePointsCompletedLabel => 'Story Points completati';

  @override
  String get agileStoriesIncomplete => 'Storie incomplete';

  @override
  String get agileIncompleteReturnToBacklog => '(torneranno nel backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Conduci Sprint Review';

  @override
  String get agileCompleteSprintAction => 'Chiudi Sprint';

  @override
  String get agileMissingReview => 'Sprint Review non ancora effettuata';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review completata';

  @override
  String get agileReviewNotesLabel => 'Note Review';

  @override
  String get agileReviewFeedbackLabel => 'Feedback Stakeholder';

  @override
  String get agileReviewNextFocus => 'Focus Prossimo Sprint';

  @override
  String get agileBacklogUpdatesLabel => 'Modifiche Backlog';

  @override
  String get agileSaveReview => 'Salva Review';

  @override
  String get agileConductedBy => 'Condotta da';

  @override
  String get agileReviewDate => 'Data Review';

  @override
  String get agileReviewOutcome => 'Esito Review';

  @override
  String get agileStoriesRejected => 'Storie non accettate';

  @override
  String get agileRejectedWarning =>
      'Le storie non completate o non accettate torneranno automaticamente nel Backlog.';

  @override
  String get agileReviewDemoHint => 'Cosa è stato mostrato durante la demo?';

  @override
  String get agileReviewFeedbackHint => 'Feedback ricevuto dagli stakeholder';

  @override
  String get agileReviewBacklogHint => 'Nuova modifica al backlog...';

  @override
  String get agileReviewNextFocusHint =>
      'Su cosa dovrebbe concentrarsi il team?';

  @override
  String get agileReviewScrumGuide =>
      'Lo Scrum Guide 2020 raccomanda di fare la Sprint Review prima di chiudere lo sprint per ispezionare il lavoro svolto con gli stakeholder.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Sei sicuro di voler completare \"$name\"?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint completato! Velocity: $velocity pts/settimana';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review salvata';

  @override
  String get agileEstimationAccuracy => 'Accuratezza Stime';

  @override
  String get agileCompleteOneSprintFirst => 'Completa almeno uno sprint';

  @override
  String get agileNoDataAccuracyFix => 'Nessun dato di accuratezza';

  @override
  String get agileScrumGuideRecommends =>
      'La Scrum Guide raccomanda la pianificazione basata sulla Velocity storica, non sulle ore.';

  @override
  String get agileNoSkillsDefined => 'Nessuna competenza definita';

  @override
  String get agileAddSkillsToMembers =>
      'Aggiungi competenze ai membri del team';

  @override
  String get retroNoSprintWarningTitle => 'Nessuno Sprint Completato';

  @override
  String get retroNoSprintWarningMessage =>
      'Per creare una retrospettiva Scrum, devi prima completare almeno uno sprint. Le retrospettive sono collegate agli sprint per tracciare miglioramenti tra un\'iterazione e l\'altra.';

  @override
  String get agileGoToSprints => 'Vai agli Sprint';

  @override
  String get agileSprintReviewHistory => 'Cronologia Sprint Review';

  @override
  String get agileNoSprintReviews => 'Nessuna Sprint Review';

  @override
  String get agileNoSprintReviewsHint =>
      'Completa uno sprint e conduci una Sprint Review per vederla qui';

  @override
  String get agileAttendees => 'Partecipanti';

  @override
  String get agileStoryEvaluations => 'Valutazione Storie';

  @override
  String get agileDecisions => 'Decisioni';

  @override
  String get agileDemoNotes => 'Note Demo';

  @override
  String get agileFeedback => 'Feedback';

  @override
  String get agileStoryApproved => 'Approvata';

  @override
  String get agileStoryNeedsRefinement => 'Da Rifinire';

  @override
  String get agileStoryRejected => 'Rifiutata';

  @override
  String get agileAddAttendee => 'Aggiungi Partecipante';

  @override
  String get agileAddDecision => 'Aggiungi Decisione';

  @override
  String get agileEvaluateStories => 'Valuta Storie';

  @override
  String get agileSelectRole => 'Seleziona Ruolo';

  @override
  String get agileStatsNotCompleted => 'Non Completate';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Membri del Team';

  @override
  String get eisenhowerImportCsv => 'Importa CSV';

  @override
  String get eisenhowerImportPreview => 'Anteprima Attività';

  @override
  String get eisenhowerImportSelectFile => 'Seleziona un file CSV da importare';

  @override
  String get eisenhowerImportFormatHint =>
      'Formato atteso: Attività, Descrizione, Quadrante, Urgenza, Importanza';

  @override
  String get eisenhowerImportClickToSelect => 'Clicca per selezionare file';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Formati supportati: .csv (UTF-8 o Latin-1)';

  @override
  String get eisenhowerImportNoActivities =>
      'Nessuna attività trovata nel file';

  @override
  String get eisenhowerImportMarkRevealed => 'Segna come già votate';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Le attività appariranno direttamente nel quadrante calcolato';

  @override
  String eisenhowerImportSuccess(int count) {
    return 'Importate $count attività';
  }

  @override
  String get actionSelectAll => 'Seleziona Tutti';

  @override
  String get actionDeselectAll => 'Deseleziona Tutti';

  @override
  String get actionImport => 'Importa';

  @override
  String get eisenhowerImportShowInstructions => 'Mostra/nascondi istruzioni';

  @override
  String get eisenhowerImportInstructionsTitle => 'Formato CSV Richiesto';

  @override
  String get eisenhowerImportInstructionsBody =>
      'Il file CSV deve contenere almeno la colonna \'Attività\' o \'Title\'. Colonne opzionali: Descrizione, Urgenza (1-10), Importanza (1-10). La prima riga deve essere l\'intestazione.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Attività,Descrizione,Urgenza,Importanza\n\"Nome attività\",\"Descrizione opzionale\",8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Cambia file';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return '$count righe saltate per errori';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...e altre $count righe';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return 'Trovate $valid attività valide su $total righe';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Riga $row: titolo vuoto';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Riga $row: formato non valido';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      'Colonna \'Attività\' o \'Title\' non trovata nell\'intestazione';

  @override
  String get eisenhowerImportErrorEmptyFile => 'Il file è vuoto';

  @override
  String get eisenhowerImportErrorNoHeader =>
      'Intestazione non trovata nella prima riga';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Riga $row';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Impossibile leggere il file';

  @override
  String get agileSprintHealthTitle => 'Sprint Health';

  @override
  String get agileSprintHealthNoSprint => 'Nessuno sprint attivo';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Avvia uno sprint per vedere le metriche di salute';

  @override
  String get agileSprintHealthGoal => 'Sprint Goal';

  @override
  String get agileSprintHealthOnTrack => 'In Linea';

  @override
  String get agileSprintHealthAtRisk => 'A Rischio';

  @override
  String get agileSprintHealthOffTrack => 'In Ritardo';

  @override
  String get agileSprintHealthTime => 'Tempo';

  @override
  String get agileSprintHealthWork => 'Lavoro';

  @override
  String get agileSprintHealthDaysLeft => 'giorni rimasti';

  @override
  String get agileSprintHealthSpRemaining => 'SP rimasti';

  @override
  String get agileSprintHealthStoriesDone => 'Stories Fatte';

  @override
  String get agileSprintHealthCommitment => 'Affidabilità';

  @override
  String get agileSprintHealthDailyVelocity => 'Vel. Giornaliera';

  @override
  String get agileSprintHealthPrediction => 'Previsione';

  @override
  String get agileSprintHealthOnTime => 'In tempo';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Distribuzione Stories';

  @override
  String get agileSprintBurndownTitle => 'Sprint Burndown';

  @override
  String get agileSprintBurndownNoData => 'Nessun dato burndown';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Assegna stories allo sprint per vedere il burndown';

  @override
  String get agileWorkloadTitle => 'Carico del Team';

  @override
  String get agileWorkloadBalanced => 'Bilanciato';

  @override
  String get agileWorkloadUnbalanced => 'Sbilanciato';

  @override
  String get agileWorkloadTotalStories => 'Stories Totali';

  @override
  String get agileWorkloadAssigned => 'Assegnate';

  @override
  String get agileWorkloadAvgSp => 'SP Medi/Persona';

  @override
  String get agileWorkloadStories => 'stories';

  @override
  String get agileWorkloadInProgress => 'in corso';

  @override
  String get agileWorkloadUnassigned => 'Non assegnate';

  @override
  String get agileWorkloadUnassignedWarning => 'stories senza assegnatario';

  @override
  String get agileWorkloadNoStories => 'Nessuna story da analizzare';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Crea stories e assegnale ai membri del team';

  @override
  String get agileWorkloadOverloaded => 'Sovraccaricato';
}
