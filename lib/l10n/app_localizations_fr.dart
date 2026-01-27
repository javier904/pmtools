// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Lista di appartenenza';

  @override
  String get newRetro => 'Nouvelle Retro';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Aller à l\'accueil';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionDelete => 'Supprimer';

  @override
  String get actionEdit => 'Modifier';

  @override
  String get actionCreate => 'Créer';

  @override
  String get actionAdd => 'Ajouter';

  @override
  String get actionClose => 'Fermer';

  @override
  String get actionRetry => 'Réessayer';

  @override
  String get actionConfirm => 'Confirmer';

  @override
  String get actionSearch => 'Rechercher';

  @override
  String get actionFilter => 'Filtrer';

  @override
  String get actionExport => 'Exporter';

  @override
  String get actionCopy => 'Copier';

  @override
  String get actionShare => 'Partager';

  @override
  String get actionDone => 'Terminé';

  @override
  String get actionReset => 'Réinitialiser';

  @override
  String get actionOpen => 'Ouvrir';

  @override
  String get stateLoading => 'Chargement...';

  @override
  String get stateEmpty => 'Aucun élément';

  @override
  String get stateError => 'Erreur';

  @override
  String get stateSuccess => 'Succès';

  @override
  String get subscriptionCurrent => 'ACTUEL';

  @override
  String get subscriptionRecommended => 'RECOMMANDÉ';

  @override
  String get subscriptionFree => 'Gratuit';

  @override
  String get subscriptionPerMonth => '/mois';

  @override
  String get subscriptionPerYear => '/an';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Économisez $amount avec l\'abonnement annuel';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days jours d\'essai gratuit';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Projets illimités';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count projets actifs';
  }

  @override
  String get subscriptionUnlimitedLists => 'Listes illimitées';

  @override
  String subscriptionSmartTodoLists(int count) {
    return '$count listes Smart Todo';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Projets actifs';

  @override
  String get subscriptionSmartTodoListsLabel => 'Listes Smart Todo';

  @override
  String get subscriptionUnlimitedTasks => 'Tâches illimitées';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count tâches par projet';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Invitations illimitées';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count invitations par projet';
  }

  @override
  String get subscriptionWithAds => 'Avec publicités';

  @override
  String get subscriptionWithoutAds => 'Sans publicités';

  @override
  String get authSignInGoogle => 'Se connecter avec Google';

  @override
  String get authSignOut => 'Se déconnecter';

  @override
  String get authLogoutConfirm => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get formNameRequired => 'Entrez votre nom';

  @override
  String get authError => 'Erreur d\'authentification';

  @override
  String get authUserNotFound => 'Utilisateur non trouvé';

  @override
  String get authWrongPassword => 'Mot de passe incorrect';

  @override
  String get authEmailInUse => 'Email déjà utilisé';

  @override
  String get authWeakPassword => 'Mot de passe trop faible';

  @override
  String get authInvalidEmail => 'Email invalide';

  @override
  String get appSubtitle => 'Outils Agile pour les équipes';

  @override
  String get authOr => 'ou';

  @override
  String get authPassword => 'Mot de passe';

  @override
  String get authRegister => 'S\'inscrire';

  @override
  String get authLogin => 'Connexion';

  @override
  String get authHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get authNoAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get navHome => 'Accueil';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get eisenhowerTitle => 'Matrice Eisenhower';

  @override
  String get eisenhowerYourMatrices => 'Vos matrices';

  @override
  String get eisenhowerNoMatrices => 'Aucune matrice créée';

  @override
  String get eisenhowerNewMatrix => 'Nouvelle matrice';

  @override
  String get eisenhowerViewGrid => 'Grille';

  @override
  String get eisenhowerViewChart => 'Graphique';

  @override
  String get eisenhowerViewList => 'Liste';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'URGENT';

  @override
  String get quadrantNotUrgent => 'NON URGENT';

  @override
  String get quadrantImportant => 'IMPORTANT';

  @override
  String get quadrantNotImportant => 'NON IMPORTANT';

  @override
  String get quadrantQ1Title => 'FAIRE MAINTENANT';

  @override
  String get quadrantQ2Title => 'PLANIFIER';

  @override
  String get quadrantQ3Title => 'DÉLÉGUER';

  @override
  String get quadrantQ4Title => 'ÉLIMINER';

  @override
  String get quadrantQ1Subtitle => 'Urgent et Important';

  @override
  String get quadrantQ2Subtitle => 'Important, Non Urgent';

  @override
  String get quadrantQ3Subtitle => 'Urgent, Non Important';

  @override
  String get quadrantQ4Subtitle => 'Non Urgent, Non Important';

  @override
  String get eisenhowerNoActivities => 'Aucune activité';

  @override
  String get eisenhowerNewActivity => 'Nouvelle activité';

  @override
  String get eisenhowerExportSheets => 'Exporter vers Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Inviter des participants';

  @override
  String get eisenhowerDeleteMatrix => 'Supprimer la matrice';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette matrice ?';

  @override
  String get eisenhowerActivityTitle => 'Titre de l\'activité';

  @override
  String get eisenhowerActivityNotes => 'Notes';

  @override
  String get eisenhowerDueDate => 'Date d\'échéance';

  @override
  String get eisenhowerPriority => 'Priorité';

  @override
  String get eisenhowerAssignee => 'Responsable';

  @override
  String get eisenhowerCompleted => 'Terminé';

  @override
  String get eisenhowerMoveToQuadrant => 'Déplacer vers le quadrant';

  @override
  String get eisenhowerMatrixSettings => 'Paramètres de la matrice';

  @override
  String get eisenhowerBackToList => 'Liste';

  @override
  String get eisenhowerPriorityList => 'Liste des priorités';

  @override
  String get eisenhowerAllActivities => 'Toutes les activités';

  @override
  String get eisenhowerToVote => 'À voter';

  @override
  String get eisenhowerVoted => 'Voté';

  @override
  String get eisenhowerTotal => 'Total';

  @override
  String get eisenhowerEditParticipants => 'Modifier les participants';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count activités';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count votes';
  }

  @override
  String get eisenhowerModifyVotes => 'Modifier les votes';

  @override
  String get eisenhowerVote => 'Voter';

  @override
  String get eisenhowerQuadrant => 'Quadrant';

  @override
  String get eisenhowerUrgencyAvg => 'Urgence moyenne';

  @override
  String get eisenhowerImportanceAvg => 'Importance moyenne';

  @override
  String get eisenhowerVotesLabel => 'Votes :';

  @override
  String get eisenhowerNoVotesYet => 'Aucun vote collecté pour l\'instant';

  @override
  String get eisenhowerEditMatrix => 'Modifier la matrice';

  @override
  String get eisenhowerAddActivity => 'Ajouter une activité';

  @override
  String get eisenhowerDeleteActivity => 'Supprimer l\'activité';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Êtes-vous sûr de vouloir supprimer \"$title\" ?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matrice créée avec succès';

  @override
  String get eisenhowerMatrixUpdated => 'Matrice mise à jour';

  @override
  String get eisenhowerMatrixDeleted => 'Matrice supprimée';

  @override
  String get eisenhowerActivityAdded => 'Activité ajoutée';

  @override
  String get eisenhowerActivityDeleted => 'Activité supprimée';

  @override
  String get eisenhowerVotesSaved => 'Votes enregistrés';

  @override
  String get eisenhowerExportCompleted => 'Export terminé !';

  @override
  String get eisenhowerExportCompletedDialog => 'Export terminé';

  @override
  String get eisenhowerExportDialogContent =>
      'Le fichier Google Sheets a été créé.\nVoulez-vous l\'ouvrir dans le navigateur ?';

  @override
  String get eisenhowerOpen => 'Ouvrir';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Ajoutez d\'abord des participants à la matrice';

  @override
  String get eisenhowerSearchLabel => 'Rechercher :';

  @override
  String get eisenhowerSearchHint => 'Rechercher des matrices...';

  @override
  String get eisenhowerNoMatrixFound => 'Aucune matrice trouvée';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Créez votre première Matrice Eisenhower\npour organiser vos priorités';

  @override
  String get eisenhowerCreateMatrix => 'Créer une matrice';

  @override
  String get eisenhowerClickToOpen => 'Matrice Eisenhower\nCliquez pour ouvrir';

  @override
  String get eisenhowerTotalActivities => 'Total des activités dans la matrice';

  @override
  String get eisenhowerVotedActivities => 'Activités votées';

  @override
  String get eisenhowerPendingVoting => 'Activités à voter';

  @override
  String get eisenhowerStartVoting => 'Démarrer le vote indépendant';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Voulez-vous démarrer une session de vote indépendant pour \"$title\" ?\n\nChaque participant votera sans voir les votes des autres, jusqu\'à ce que tout le monde ait voté et que les votes soient révélés.';
  }

  @override
  String get eisenhowerStart => 'Démarrer';

  @override
  String get eisenhowerVotingStarted => 'Vote démarré';

  @override
  String get eisenhowerResetVoting => 'Réinitialiser le vote ?';

  @override
  String get eisenhowerResetVotingDesc => 'Tous les votes seront supprimés.';

  @override
  String get eisenhowerVotingReset => 'Vote réinitialisé';

  @override
  String get eisenhowerMinVotersRequired =>
      'Au moins 2 votants requis pour le vote indépendant';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Toutes les $count activités seront également supprimées.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Vos matrices ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Entrez un titre';

  @override
  String get formTitleHint => 'Ex : Priorités Q1 2025';

  @override
  String get formDescriptionHint => 'Description optionnelle';

  @override
  String get formParticipantHint => 'Nom du participant';

  @override
  String get formAddParticipantHint =>
      'Ajoutez au moins un participant pour voter';

  @override
  String get formActivityTitleHint => 'Ex : Compléter la documentation API';

  @override
  String get errorCreatingMatrix => 'Erreur lors de la création de la matrice';

  @override
  String get errorUpdatingMatrix => 'Erreur lors de la mise à jour';

  @override
  String get errorDeletingMatrix => 'Erreur lors de la suppression';

  @override
  String get errorAddingActivity => 'Erreur lors de l\'ajout de l\'activité';

  @override
  String get errorSavingVotes => 'Erreur lors de l\'enregistrement des votes';

  @override
  String get errorExport => 'Erreur lors de l\'export';

  @override
  String get errorStartingVoting => 'Erreur lors du démarrage du vote';

  @override
  String get errorResetVoting => 'Erreur lors de la réinitialisation';

  @override
  String get errorLoadingActivities =>
      'Erreur lors du chargement des activités';

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
  String get eisenhowerUrgency => 'URGENCE';

  @override
  String get eisenhowerImportance => 'IMPORTANCE';

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
  String get estimationTitle => 'Salle d\'Estimation';

  @override
  String get estimationYourSessions => 'Vos sessions';

  @override
  String get estimationNoSessions => 'Aucune session créée';

  @override
  String get estimationNewSession => 'Nouvelle session';

  @override
  String get estimationEditSession => 'Modifier la session';

  @override
  String get estimationJoinSession => 'Rejoindre la session';

  @override
  String get estimationSessionCode => 'Code de session';

  @override
  String get estimationEnterCode => 'Entrez le code';

  @override
  String get sessionStatusDraft => 'Brouillon';

  @override
  String get sessionStatusActive => 'Active';

  @override
  String get sessionStatusCompleted => 'Terminée';

  @override
  String get sessionName => 'Nom de la session';

  @override
  String get sessionNameRequired => 'Nom de la session *';

  @override
  String get sessionNameHint => 'Ex : Sprint 15 - Estimation des User Stories';

  @override
  String get sessionDescription => 'Description';

  @override
  String get sessionCardSet => 'Jeu de cartes';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Simplifié (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Mode d\'estimation';

  @override
  String get sessionEstimationModeLocked =>
      'Impossible de changer le mode après le début du vote';

  @override
  String get sessionAutoReveal => 'Révélation automatique';

  @override
  String get sessionAutoRevealDesc => 'Révéler quand tout le monde a voté';

  @override
  String get sessionAllowObservers => 'Observateurs';

  @override
  String get sessionAllowObserversDesc =>
      'Autoriser les participants non-votants';

  @override
  String get sessionConfiguration => 'Configuration';

  @override
  String get voteConsensus => 'Consensus atteint !';

  @override
  String get voteResults => 'Résultats du vote';

  @override
  String get voteRevote => 'Revoter';

  @override
  String get voteReveal => 'Révéler';

  @override
  String get voteHide => 'Masquer';

  @override
  String get voteAverage => 'Moyenne';

  @override
  String get voteMedian => 'Médiane';

  @override
  String get voteMode => 'Mode';

  @override
  String get voteVoters => 'Votants';

  @override
  String get voteDistribution => 'Distribution des votes';

  @override
  String get voteFinalEstimate => 'Estimation finale';

  @override
  String get voteSelectFinal => 'Sélectionner l\'estimation finale';

  @override
  String get voteAverageTooltip => 'Moyenne arithmétique des votes numériques';

  @override
  String get voteMedianTooltip =>
      'Valeur centrale lorsque les votes sont triés';

  @override
  String get voteModeTooltip =>
      'Vote le plus fréquent (la valeur choisie le plus souvent)';

  @override
  String get voteVotersTooltip => 'Nombre total de participants ayant voté';

  @override
  String get voteWaiting => 'En attente des votes...';

  @override
  String get voteSubmitted => 'Vote soumis';

  @override
  String get voteNotSubmitted => 'N\'a pas voté';

  @override
  String get storyToEstimate => 'Story à estimer';

  @override
  String get storyTitle => 'Titre de la story';

  @override
  String get storyDescription => 'Description de la story';

  @override
  String get storyAddNew => 'Ajouter une story';

  @override
  String get storyNoStories => 'Aucune story à estimer';

  @override
  String get storyComplete => 'Story terminée';

  @override
  String get storySkip => 'Passer la story';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'Tailles T-Shirt';

  @override
  String get estimationModeDecimal => 'Décimal';

  @override
  String get estimationModeThreePoint => 'Trois points (PERT)';

  @override
  String get estimationModeDotVoting => 'Vote par points';

  @override
  String get estimationModeBucketSystem => 'Système de seaux';

  @override
  String get estimationModeFiveFingers => 'Cinq doigts';

  @override
  String get estimationVotesRevealed => 'Votes Révélés';

  @override
  String get estimationVotingInProgress => 'Vote en Cours';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total votes';
  }

  @override
  String get estimationConsensusReached => 'Consensus atteint !';

  @override
  String get estimationVotingResults => 'Résultats du Vote';

  @override
  String get estimationRevote => 'Revoter';

  @override
  String get estimationAverage => 'Moyenne';

  @override
  String get estimationAverageTooltip =>
      'Moyenne arithmétique des votes numériques';

  @override
  String get estimationMedian => 'Médiane';

  @override
  String get estimationMedianTooltip =>
      'Valeur centrale lorsque les votes sont triés';

  @override
  String get estimationMode => 'Mode';

  @override
  String get estimationModeTooltip => 'Vote le plus fréquent';

  @override
  String get estimationVoters => 'Votants';

  @override
  String get estimationVotersTooltip => 'Nombre total de participants';

  @override
  String get estimationVoteDistribution => 'Distribution des Votes';

  @override
  String get estimationSelectFinalEstimate =>
      'Sélectionner l\'Estimation Finale';

  @override
  String get estimationFinalEstimate => 'Estimation Finale';

  @override
  String get eisenhowerChartTitle => 'Distribution des Activités';

  @override
  String get quadrantLabelDo => 'Q1 - FAIRE';

  @override
  String get quadrantLabelPlan => 'Q2 - PLANIFIER';

  @override
  String get quadrantLabelDelegate => 'Q3 - DÉLÉGUER';

  @override
  String get quadrantLabelEliminate => 'Q4 - ÉLIMINER';

  @override
  String get eisenhowerNoRatedActivities => 'Aucune activité votée';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Votez pour voir les activités sur le graphique';

  @override
  String get eisenhowerChartCardTitle => 'Graphique de Distribution';

  @override
  String get raciAddColumnTitle => 'Ajouter Colonne RACI';

  @override
  String get raciColumnType => 'Type';

  @override
  String get raciTypePerson => 'Personne (Participant)';

  @override
  String get raciTypeCustom => 'Personnalisé (Équipe/Autre)';

  @override
  String get raciSelectParticipant => 'Sélectionner un participant';

  @override
  String get raciColumnName => 'Nom de la colonne';

  @override
  String get raciColumnNameHint => 'Ex. : Équipe développement';

  @override
  String get raciDeleteColumnTitle => 'Supprimer la Colonne';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Supprimer la colonne \'$name\' ? Les assignations seront perdues.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online sur $total participants en ligne';
  }

  @override
  String get estimationNewStoryTitle => 'Nouvelle Story';

  @override
  String get estimationStoryTitleLabel => 'Titre *';

  @override
  String get estimationStoryTitleHint =>
      'Ex: US-123: En tant qu\'utilisateur je veux...';

  @override
  String get estimationStoryDescriptionLabel => 'Description';

  @override
  String get estimationStoryDescriptionHint =>
      'Critères d\'acceptation, notes...';

  @override
  String get estimationEnterTitleAlert => 'Entrez un titre';

  @override
  String get estimationParticipantsHeader => 'Participants';

  @override
  String get estimationRoleFacilitator => 'Facilitateur';

  @override
  String get estimationRoleVoters => 'Votants';

  @override
  String get estimationRoleObservers => 'Observateurs';

  @override
  String get estimationYouSuffix => '(vous)';

  @override
  String get estimationDecimalTitle => 'Estimation décimale';

  @override
  String get estimationDecimalHint =>
      'Entrez votre estimation en jours (ex: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Sélection rapide:';

  @override
  String get estimationDaysSuffix => 'jours';

  @override
  String estimationVoteValue(String value) {
    return 'Vote: $value jours';
  }

  @override
  String get estimationEnterValueAlert => 'Entrez une valeur';

  @override
  String get estimationInvalidValueAlert => 'Valeur invalide';

  @override
  String estimationMinAlert(double value) {
    return 'Min: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Max: $value';
  }

  @override
  String get retroTitle => 'Mes rétrospectives';

  @override
  String get retroNoRetros => 'Aucune rétrospective';

  @override
  String get retroCreateNew => 'Créer nouvelle';

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
  String get agileMethodologyGuideTitle => 'Guide des méthodologies Agile';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Choisissez la méthodologie qui convient le mieux à votre projet';

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
      'Sprints à durée fixe, Vélocité, Burndown. Idéal pour les produits avec des exigences évolutives.';

  @override
  String get agileKanbanShortDesc =>
      'Flux continu, Limites WIP, Lead Time. Idéal pour le support et les demandes continues.';

  @override
  String get agileScrumbanShortDesc =>
      'Mix de Sprints et flux continu. Idéal pour les équipes souhaitant de la flexibilité.';

  @override
  String get agileRolePODesc => 'Gestisce il backlog e le priorità';

  @override
  String get agileRoleSMDesc => 'Facilita il processo e rimuove ostacoli';

  @override
  String get agileRoleDevTeamDesc => 'Realizza gli incrementi di prodotto';

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
  String get retroDeleteTitle => 'Supprimer la Rétrospective';

  @override
  String retroDeleteConfirm(String title) {
    return 'Êtes-vous sûr ?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospettiva eliminata con successo';

  @override
  String retroDeleteError(String error) {
    return 'Erreur lors de la suppression : $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Elimina definitivamente';

  @override
  String get retroNewRetroTitle => 'Nuova Retrospettiva';

  @override
  String get retroLinkToSprint => 'Lier au Sprint ?';

  @override
  String get retroNoProjectFound => 'Nessun progetto trovato.';

  @override
  String get retroSelectProject => 'Sélectionner le Projet';

  @override
  String get retroSelectSprint => 'Sélectionner le Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String get retroSessionTitle => 'Titre de la Session';

  @override
  String get retroSessionTitleHint => 'Ex : Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Modèle';

  @override
  String get retroVotesPerUser => 'Votes par utilisateur :';

  @override
  String get retroActionClose => 'Chiudi';

  @override
  String get retroActionCreate => 'Crea';

  @override
  String get retroStatusDraft => 'Brouillon';

  @override
  String get retroStatusActive => 'En cours';

  @override
  String get retroStatusCompleted => 'Terminée';

  @override
  String get retroTemplateStartStopContinue => 'Start, Stop, Continue';

  @override
  String get retroTemplateSailboat => 'Voilier';

  @override
  String get retroTemplate4Ls => '4 Ls';

  @override
  String get retroTemplateStarfish => 'Étoile de mer';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Orienté action : Commencer, Arrêter, Continuer.';

  @override
  String get retroDescSailboat =>
      'Visuel : Vent (pousse), Ancres (freine), Rochers (risques), Île (objectifs).';

  @override
  String get retroDesc4Ls =>
      'Liked (Aimé), Learned (Appris), Lacked (Manqué), Longed For (Désiré).';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Émotionnel : Fâché, Triste, Content.';

  @override
  String get retroDescDAKI =>
      'Pragmatique : Abandonner, Ajouter, Garder, Améliorer.';

  @override
  String get retroUsageStartStopContinue =>
      'Idéal pour des retours exploitables et des changements comportementaux.';

  @override
  String get retroUsageSailboat =>
      'Idéal pour visualiser le parcours de l\'équipe, objectifs et risques. Bon pour la créativité.';

  @override
  String get retroUsage4Ls =>
      'Réfléchi : Idéal pour apprendre du passé et souligner les aspects émotionnels.';

  @override
  String get retroUsageStarfish =>
      'Calibration : Idéal pour ajuster les efforts (faire plus/moins).';

  @override
  String get retroUsageMadSadGlad =>
      'Idéal pour les bilans émotionnels, résoudre les conflits ou après un sprint stressant.';

  @override
  String get retroUsageDAKI =>
      'Décisif : Idéal pour le nettoyage. Focus sur les décisions concrètes.';

  @override
  String get retroIcebreakerSentiment => 'Vote de Sentiment';

  @override
  String get retroIcebreakerOneWord => 'Un Mot';

  @override
  String get retroIcebreakerWeather => 'Météo';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Votez de 1 à 5 comment vous vous êtes senti pendant le sprint.';

  @override
  String get retroIcebreakerOneWordDesc => 'Décrivez le sprint en un seul mot.';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Choisissez une icône météo qui représente le sprint.';

  @override
  String get retroPhaseIcebreaker => 'BRISE-GLACE';

  @override
  String get retroPhaseWriting => 'ÉCRITURE';

  @override
  String get retroPhaseVoting => 'VOTE';

  @override
  String get retroPhaseDiscuss => 'DISCUSSION';

  @override
  String get retroActionItemsLabel => 'Action Items';

  @override
  String get retroActionDragToCreate =>
      'Trascina qui una card per creare un Action Item collegato';

  @override
  String get retroNoActionItems =>
      'Aucun élément d\'action créé pour l\'instant.';

  @override
  String get facilitatorGuideNextColumn => 'Suivant: Collecter action de';

  @override
  String get collectionRationaleSSC =>
      'D\'abord Stop pour supprimer les bloqueurs, puis Start nouvelles pratiques, enfin Continue ce qui fonctionne.';

  @override
  String get collectionRationaleMSG =>
      'D\'abord adresser les frustrations, puis les déceptions, puis célébrer les succès.';

  @override
  String get collectionRationale4Ls =>
      'D\'abord combler les lacunes, puis planifier aspirations futures, maintenir ce qui fonctionne, partager apprentissages.';

  @override
  String get collectionRationaleSailboat =>
      'D\'abord atténuer les risques, supprimer bloqueurs, puis exploiter facilitateurs et s\'aligner aux objectifs.';

  @override
  String get collectionRationaleStarfish =>
      'Arrêter mauvaises pratiques, en réduire d\'autres, maintenir les bonnes, augmenter les précieuses, en démarrer de nouvelles.';

  @override
  String get collectionRationaleDAKI =>
      'Drop pour libérer capacité, Add nouvelles pratiques, Improve existantes, Keep ce qui fonctionne.';

  @override
  String get missingSuggestionSSCStop =>
      'Considérez quelle pratique bloque l\'équipe et devrait être arrêtée.';

  @override
  String get missingSuggestionSSCStart =>
      'Pensez à quelle nouvelle pratique pourrait aider l\'équipe à s\'améliorer.';

  @override
  String get missingSuggestionMSGMad =>
      'Adressez les frustrations de l\'équipe - qu\'est-ce qui cause la colère?';

  @override
  String get missingSuggestionMSGSad =>
      'Résolvez les déceptions - qu\'est-ce qui a rendu l\'équipe triste?';

  @override
  String get missingSuggestion4LsLacked =>
      'Qu\'est-ce qui manquait dont l\'équipe avait besoin?';

  @override
  String get missingSuggestion4LsLonged =>
      'Qu\'est-ce que l\'équipe souhaite pour l\'avenir?';

  @override
  String get missingSuggestionSailboatAnchor =>
      'Qu\'est-ce qui retient l\'équipe d\'atteindre ses objectifs?';

  @override
  String get missingSuggestionSailboatRock =>
      'Quels risques menacent le progrès de l\'équipe?';

  @override
  String get missingSuggestionStarfishStop =>
      'Quelle pratique l\'équipe devrait-elle complètement arrêter?';

  @override
  String get missingSuggestionStarfishStart =>
      'Quelle nouvelle pratique l\'équipe devrait-elle commencer?';

  @override
  String get missingSuggestionDAKIDrop =>
      'Que devrait l\'équipe décider d\'éliminer?';

  @override
  String get missingSuggestionDAKIAdd =>
      'Quelle nouvelle décision l\'équipe devrait-elle prendre?';

  @override
  String get missingSuggestionGeneric =>
      'Envisagez de créer une action depuis cette colonne.';

  @override
  String get facilitatorGuideAllCovered =>
      'Toutes les colonnes requises couvertes!';

  @override
  String get facilitatorGuideMissing => 'Mancano azioni per';

  @override
  String get retroPhaseStart => 'Inizia';

  @override
  String get retroPhaseStop => 'Smetti';

  @override
  String get retroPhaseContinue => 'Continua';

  @override
  String get retroColumnMad => 'En colère';

  @override
  String get retroColumnSad => 'Triste';

  @override
  String get retroColumnGlad => 'Content';

  @override
  String get retroColumnLiked => 'Aimé';

  @override
  String get retroColumnLearned => 'Appris';

  @override
  String get retroColumnLacked => 'Manqué';

  @override
  String get retroColumnLonged => 'Desiderato';

  @override
  String get retroColumnWind => 'Vent';

  @override
  String get retroColumnAnchor => 'Ancres';

  @override
  String get retroColumnRock => 'Rochers';

  @override
  String get retroColumnGoal => 'Île';

  @override
  String get retroColumnKeep => 'Garder';

  @override
  String get retroColumnMore => 'Plus';

  @override
  String get retroColumnLess => 'Moins';

  @override
  String get retroColumnDrop => 'Supprimer';

  @override
  String get retroColumnAdd => 'Ajouter';

  @override
  String get retroColumnImprove => 'Améliorer';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get formTitle => 'Titre';

  @override
  String get formDescription => 'Description';

  @override
  String get formName => 'Nom';

  @override
  String get formRequired => 'Champ obligatoire';

  @override
  String get formHint => 'Entrez une valeur';

  @override
  String get formOptional => 'Optionnel';

  @override
  String errorGeneric(String error) {
    return 'Erreur : $error';
  }

  @override
  String get errorLoading => 'Erreur lors du chargement des données';

  @override
  String get errorSaving => 'Erreur lors de l\'enregistrement';

  @override
  String get errorNetwork => 'Erreur de connexion';

  @override
  String get errorPermission => 'Permission refusée';

  @override
  String get errorNotFound => 'Non trouvé';

  @override
  String get successSaved => 'Enregistré avec succès';

  @override
  String get successDeleted => 'Supprimé avec succès';

  @override
  String get successCopied => 'Copié dans le presse-papiers';

  @override
  String get filterAll => 'Tous';

  @override
  String get filterRemove => 'Supprimer les filtres';

  @override
  String get filterActive => 'Actif';

  @override
  String get filterCompleted => 'Terminé';

  @override
  String get participants => 'Participants';

  @override
  String get addParticipant => 'Ajouter un participant';

  @override
  String get removeParticipant => 'Retirer le participant';

  @override
  String get noParticipants => 'Aucun participant';

  @override
  String get participantJoined => 'a rejoint';

  @override
  String get participantLeft => 'a quitté';

  @override
  String get participantRole => 'Rôle';

  @override
  String get participantVoter => 'Votant';

  @override
  String get participantObserver => 'Observateur';

  @override
  String get participantModerator => 'Modérateur';

  @override
  String get confirmDelete => 'Confirmer la suppression';

  @override
  String get confirmDeleteMessage => 'Cette action ne peut pas être annulée.';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get tomorrow => 'Demain';

  @override
  String daysAgo(int count) {
    return 'Il y a $count jours';
  }

  @override
  String hoursAgo(int count) {
    return 'Il y a $count heures';
  }

  @override
  String minutesAgo(int count) {
    return 'Il y a $count minutes';
  }

  @override
  String itemCount(int count) {
    return '$count éléments';
  }

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String greeting(String name) {
    return 'Bonjour, $name !';
  }

  @override
  String get copyLink => 'Copier le lien';

  @override
  String get shareSession => 'Partager la session';

  @override
  String get inviteByEmail => 'Inviter par email';

  @override
  String get inviteByLink => 'Inviter par lien';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileDisplayName => 'Nom d\'affichage';

  @override
  String get profilePhotoUrl => 'Photo de profil';

  @override
  String get profileEditProfile => 'Modifier le profil';

  @override
  String get profileReload => 'Recharger';

  @override
  String get profilePersonalInfo => 'Informations personnelles';

  @override
  String get profileLastName => 'Nom de famille';

  @override
  String get profileCompany => 'Entreprise';

  @override
  String get profileJobTitle => 'Poste';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Abonnement';

  @override
  String get profilePlan => 'Plan';

  @override
  String get profileBillingCycle => 'Cycle de facturation';

  @override
  String get profilePrice => 'Prix';

  @override
  String get profileActivationDate => 'Date d\'activation';

  @override
  String get profileTrialEnd => 'Fin de la période d\'essai';

  @override
  String get profileNextRenewal => 'Prochain renouvellement';

  @override
  String get profileDaysRemaining => 'Jours restants';

  @override
  String get profileUpgrade => 'Mettre à niveau';

  @override
  String get profileUpgradePlan => 'Mettre à niveau le plan';

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
  String get profileGeneralSettings => 'Paramètres généraux';

  @override
  String get profileAnimations => 'Animations';

  @override
  String get profileAnimationsDesc => 'Activer les animations de l\'interface';

  @override
  String get profileFeatures => 'Fonctionnalités';

  @override
  String get profileCalendarIntegration => 'Intégration calendrier';

  @override
  String get profileCalendarIntegrationDesc =>
      'Synchroniser les sprints et les échéances';

  @override
  String get profileExportSheets => 'Exporter vers Google Sheets';

  @override
  String get profileExportSheetsDesc =>
      'Exporter les données vers des feuilles de calcul';

  @override
  String get profileBetaFeatures => 'Fonctionnalités bêta';

  @override
  String get profileBetaFeaturesDesc =>
      'Accès anticipé aux nouvelles fonctionnalités';

  @override
  String get profileAdvancedMetrics => 'Métriques avancées';

  @override
  String get profileAdvancedMetricsDesc => 'Statistiques et rapports détaillés';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileEmailNotifications => 'Notifications par email';

  @override
  String get profileEmailNotificationsDesc =>
      'Recevoir des mises à jour par email';

  @override
  String get profilePushNotifications => 'Notifications push';

  @override
  String get profilePushNotificationsDesc => 'Notifications dans le navigateur';

  @override
  String get profileSprintReminders => 'Rappels de sprint';

  @override
  String get profileSprintRemindersDesc =>
      'Alertes pour les échéances de sprint';

  @override
  String get profileSessionInvites => 'Invitations aux sessions';

  @override
  String get profileSessionInvitesDesc =>
      'Notifications pour les nouvelles sessions';

  @override
  String get profileWeeklySummary => 'Résumé hebdomadaire';

  @override
  String get profileWeeklySummaryDesc => 'Rapport d\'activité hebdomadaire';

  @override
  String get profileDangerZone => 'Zone de danger';

  @override
  String get profileDeleteAccount => 'Supprimer le compte';

  @override
  String get profileDeleteAccountDesc =>
      'Demander la suppression permanente de votre compte et de toutes les données associées';

  @override
  String get profileDeleteAccountRequest => 'Demander';

  @override
  String get profileDeleteAccountIrreversible =>
      'Cette action est irréversible. Toutes vos données seront définitivement supprimées.';

  @override
  String get profileDeleteAccountReason => 'Raison (optionnel)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Pourquoi voulez-vous supprimer votre compte ?';

  @override
  String get profileRequestDeletion => 'Demander la suppression';

  @override
  String get profileDeletionInProgress => 'Suppression en cours';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Demandé le $date';
  }

  @override
  String get profileCancelRequest => 'Annuler la demande';

  @override
  String get profileDeletionRequestSent => 'Demande de suppression envoyée';

  @override
  String get profileDeletionRequestCancelled => 'Demande annulée';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get profileLogout => 'Se déconnecter';

  @override
  String get profileLogoutDesc => 'Déconnecter votre compte de cet appareil';

  @override
  String get profileLogoutConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get profileSubscriptionCancelled => 'Abonnement annulé';

  @override
  String get profileCancelSubscription => 'Annuler l\'abonnement';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Êtes-vous sûr de vouloir annuler votre abonnement ? Vous continuerez à utiliser les fonctionnalités premium jusqu\'à la fin de la période en cours.';

  @override
  String get profileKeepSubscription => 'Non, le garder';

  @override
  String get profileYesCancel => 'Oui, annuler';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Mise à niveau vers $plan bientôt disponible...';
  }

  @override
  String get profileFree => 'Gratuit';

  @override
  String get profileMonthly => 'EUR/mois';

  @override
  String get profileUser => 'Utilisateur';

  @override
  String profileErrorPrefix(String error) {
    return 'Erreur : $error';
  }

  @override
  String get stateSaving => 'Enregistrement...';

  @override
  String get cardCoffee => 'Pause';

  @override
  String get cardQuestion => 'Je ne sais pas';

  @override
  String get toolEisenhower => 'Matrice Eisenhower';

  @override
  String get toolEisenhowerDesc =>
      'Organisez les activités par urgence et importance. Des quadrants pour décider quoi faire maintenant, planifier, déléguer ou éliminer.';

  @override
  String get toolEisenhowerDescShort => 'Priorisez par urgence et importance';

  @override
  String get toolEstimation => 'Salle d\'Estimation';

  @override
  String get toolEstimationDesc =>
      'Sessions d\'estimation collaboratives pour l\'équipe. Planning Poker, tailles T-Shirt et autres méthodes pour estimer les user stories.';

  @override
  String get toolEstimationDescShort => 'Sessions d\'estimation collaboratives';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Listes intelligentes et collaboratives. Importez depuis CSV/texte, invitez des participants et gérez les tâches avec des filtres avancés.';

  @override
  String get toolSmartTodoDescShort =>
      'Listes intelligentes et collaboratives. Importez depuis CSV, invitez et gérez.';

  @override
  String get toolAgileProcess => 'Gestionnaire de processus Agile';

  @override
  String get toolAgileProcessDesc =>
      'Gérez des projets agiles complets avec backlog, planification de sprint, tableau kanban, métriques et rétrospectives.';

  @override
  String get toolAgileProcessDescShort =>
      'Gérez les projets agiles avec backlog, sprints, kanban et métriques.';

  @override
  String get toolRetro => 'Tableau de rétrospective';

  @override
  String get toolRetroDesc =>
      'Recueillez les retours de l\'équipe sur ce qui a bien fonctionné, ce qu\'il faut améliorer et les actions à entreprendre.';

  @override
  String get toolRetroDescShort =>
      'Recueillez les retours de l\'équipe sur ce qui a bien fonctionné et ce qu\'il faut améliorer.';

  @override
  String get homeUtilities => 'Utilitaires';

  @override
  String get homeSelectTool => 'Sélectionnez un outil pour commencer';

  @override
  String get statusOnline => 'En ligne';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get featureComingSoon =>
      'Cette fonctionnalité sera bientôt disponible !';

  @override
  String get featureSmartImport => 'Import intelligent';

  @override
  String get featureCollaboration => 'Collaboration';

  @override
  String get featureFilters => 'Filtres';

  @override
  String get feature4Quadrants => '4 Quadrants';

  @override
  String get featureDragDrop => 'Glisser-déposer';

  @override
  String get featureCollaborative => 'Collaboratif';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'Taille T-Shirt';

  @override
  String get featureRealtime => 'Temps réel';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Hybride';

  @override
  String get featureWentWell => 'Ce qui a bien marché';

  @override
  String get featureToImprove => 'À améliorer';

  @override
  String get featureActions => 'Actions';

  @override
  String get themeLightMode => 'Mode clair';

  @override
  String get themeDarkMode => 'Mode sombre';

  @override
  String get estimationBackToSessions => 'Retour aux sessions';

  @override
  String get estimationSessionSettings => 'Paramètres de session';

  @override
  String get estimationList => 'Liste';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Vos sessions ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'Aucune session trouvée';

  @override
  String get estimationCreateFirstSession =>
      'Créez votre première session d\'estimation\npour estimer des activités avec l\'équipe';

  @override
  String get estimationStoriesTotal => 'Total des stories';

  @override
  String get estimationStoriesCompleted => 'Stories terminées';

  @override
  String get estimationParticipantsActive => 'Participants actifs';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Progression : $completed/$total stories ($percent%)';
  }

  @override
  String get estimationStart => 'Démarrer';

  @override
  String get estimationComplete => 'Terminer';

  @override
  String get estimationAllStoriesEstimated =>
      'Toutes les stories ont été estimées !';

  @override
  String get estimationNoVotingInProgress => 'Aucun vote en cours';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Terminé : $completed/$total | Estimation totale : $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Vote : $title';
  }

  @override
  String get estimationAddStoriesToStart =>
      'Ajoutez des stories pour commencer';

  @override
  String get estimationInVoting => 'EN COURS DE VOTE';

  @override
  String get estimationReveal => 'Révéler';

  @override
  String get estimationSkip => 'Passer';

  @override
  String get estimationStories => 'Stories';

  @override
  String get estimationAddStory => 'Ajouter une story';

  @override
  String get estimationStartVoting => 'Démarrer le vote';

  @override
  String get estimationViewVotes => 'Voir les votes';

  @override
  String get estimationViewDetail => 'Voir le détail';

  @override
  String get estimationFinalEstimateLabel => 'Estimation finale :';

  @override
  String estimationVotesOf(String title) {
    return 'Votes : $title';
  }

  @override
  String get estimationParticipantVotes => 'Votes des participants :';

  @override
  String get estimationPointsOrDays => 'points / jours';

  @override
  String get estimationEstimateRationale =>
      'Justification de l\'estimation (optionnel)';

  @override
  String get estimationExplainRationale =>
      'Expliquez la justification de l\'estimation...\nEx : Complexité technique élevée, dépendances externes...';

  @override
  String get estimationRationaleHelp =>
      'La justification aide l\'équipe à se souvenir des décisions prises lors de l\'estimation.';

  @override
  String get estimationConfirmFinalEstimate => 'Confirmer l\'estimation finale';

  @override
  String get estimationEnterValidEstimate => 'Entrez une estimation valide';

  @override
  String get estimationHintEstimate => 'Ex : 5, 8, 13...';

  @override
  String get estimationStatus => 'Statut';

  @override
  String get estimationOrder => 'Ordre';

  @override
  String get estimationVotesReceived => 'Votes reçus';

  @override
  String get estimationAverageVotes => 'Moyenne des votes';

  @override
  String get estimationConsensus => 'Consensus';

  @override
  String get storyStatusPending => 'En attente';

  @override
  String get storyStatusVoting => 'Vote en cours';

  @override
  String get storyStatusRevealed => 'Votes révélés';

  @override
  String get participantManagement => 'Gestion des participants';

  @override
  String get participantCopySessionLink => 'Copier le lien de session';

  @override
  String get participantInvitesTab => 'Invitations';

  @override
  String get participantSessionLink =>
      'Lien de session (partager avec les participants)';

  @override
  String get participantAddDirect => 'Ajouter un participant directement';

  @override
  String get participantEmailRequired => 'Email *';

  @override
  String get participantEmailHint => 'email@exemple.com';

  @override
  String get participantNameHint => 'Nom d\'affichage';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters votants, $observers observateurs';
  }

  @override
  String get participantYou => '(vous)';

  @override
  String get participantMakeVoter => 'Rendre votant';

  @override
  String get participantMakeObserver => 'Rendre observateur';

  @override
  String get participantRemoveTitle => 'Retirer le participant';

  @override
  String participantRemoveConfirm(String name) {
    return 'Êtes-vous sûr de vouloir retirer \"$name\" de la session ?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email ajouté à la session';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name retiré de la session';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Rôle mis à jour pour $email';
  }

  @override
  String get participantFacilitator => 'Facilitateur';

  @override
  String get inviteSendNew => 'Envoyer une nouvelle invitation';

  @override
  String get inviteRecipientEmail => 'Email du destinataire *';

  @override
  String get inviteCreate => 'Créer l\'invitation';

  @override
  String get invitesSent => 'Invitations envoyées';

  @override
  String get inviteNoInvites => 'Aucune invitation envoyée';

  @override
  String inviteCreatedFor(String email) {
    return 'Invitation créée pour $email';
  }

  @override
  String inviteSentTo(String email) {
    return 'Invitation envoyée par email à $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Expire dans ${days}j';
  }

  @override
  String get inviteCopyLink => 'Copier le lien';

  @override
  String get inviteRevokeAction => 'Révoquer l\'invitation';

  @override
  String get inviteDeleteAction => 'Supprimer l\'invitation';

  @override
  String get inviteRevokeTitle => 'Révoquer l\'invitation ?';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Êtes-vous sûr de vouloir révoquer l\'invitation pour $email ?';
  }

  @override
  String get inviteRevoke => 'Révoquer';

  @override
  String inviteRevokedFor(String email) {
    return 'Invitation révoquée pour $email';
  }

  @override
  String get inviteDeleteTitle => 'Supprimer l\'invitation';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Êtes-vous sûr de vouloir supprimer l\'invitation pour $email ?\n\nCette action est irréversible.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Invitation supprimée pour $email';
  }

  @override
  String get inviteLinkCopied => 'Lien copié !';

  @override
  String get linkCopied => 'Lien copié dans le presse-papiers';

  @override
  String get enterValidEmail => 'Entrez une adresse email valide';

  @override
  String get sessionCreatedSuccess => 'Session créée avec succès';

  @override
  String get sessionUpdated => 'Session mise à jour';

  @override
  String get sessionDeleted => 'Session supprimée';

  @override
  String get sessionStarted => 'Session démarrée';

  @override
  String get sessionCompletedSuccess => 'Session terminée';

  @override
  String get sessionNotFound => 'Session non trouvée';

  @override
  String get storyAdded => 'Story ajoutée';

  @override
  String get storyDeleted => 'Story supprimée';

  @override
  String estimateSaved(String estimate) {
    return 'Estimation enregistrée : $estimate';
  }

  @override
  String get deleteSessionTitle => 'Supprimer la session';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Êtes-vous sûr de vouloir supprimer \"$name\" ?\nToutes les $count stories seront également supprimées.';
  }

  @override
  String get deleteStoryTitle => 'Supprimer la story';

  @override
  String deleteStoryConfirm(String title) {
    return 'Êtes-vous sûr de vouloir supprimer \"$title\" ?';
  }

  @override
  String get errorLoadingSession => 'Erreur lors du chargement de la session';

  @override
  String get errorLoadingStories => 'Erreur lors du chargement des stories';

  @override
  String get errorCreatingSession => 'Erreur lors de la création de la session';

  @override
  String get errorUpdatingSession => 'Erreur lors de la mise à jour';

  @override
  String get errorDeletingSession => 'Erreur lors de la suppression';

  @override
  String get errorAddingStory => 'Erreur lors de l\'ajout de la story';

  @override
  String get errorStartingSession => 'Erreur lors du démarrage de la session';

  @override
  String get errorCompletingSession =>
      'Erreur lors de la finalisation de la session';

  @override
  String get errorSubmittingVote => 'Erreur lors de la soumission du vote';

  @override
  String get errorRevealingVotes => 'Erreur lors de la révélation';

  @override
  String get errorSavingEstimate =>
      'Erreur lors de l\'enregistrement de l\'estimation';

  @override
  String get errorSkipping => 'Erreur lors du passage';

  @override
  String get retroIcebreakerTitle => 'Brise-glace : Moral de l\'équipe';

  @override
  String get retroIcebreakerQuestion =>
      'Comment vous êtes-vous senti pendant ce sprint ?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count participants ont voté';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Terminer le brise-glace et commencer l\'écriture';

  @override
  String get retroMoodTerrible => 'Terrible';

  @override
  String get retroMoodBad => 'Mauvais';

  @override
  String get retroMoodNeutral => 'Neutre';

  @override
  String get retroMoodGood => 'Bon';

  @override
  String get retroMoodExcellent => 'Excellent';

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
  String get retroAgileCoach => 'Coach Agile';

  @override
  String get retroCoachSetup =>
      'Choisissez un modèle. \"Start/Stop/Continue\" est idéal pour les nouvelles équipes. Assurez-vous que tout le monde est présent.';

  @override
  String get retroCoachIcebreaker =>
      'Brisez la glace ! Faites un tour rapide en demandant \"Comment allez-vous ?\" ou utilisez une question amusante.';

  @override
  String get retroCoachWriting =>
      'Nous sommes en mode INCOGNITO. Écrivez des cartes librement, personne ne verra ce que vous écrivez jusqu\'à la fin. Évitez les biais !';

  @override
  String get retroCoachVoting =>
      'C\'est le moment de la révision ! Toutes les cartes sont visibles. Lisez-les et utilisez vos 3 votes pour décider de quoi discuter.';

  @override
  String get retroCoachDiscuss =>
      'Concentrez-vous sur les cartes les plus votées. Définissez des éléments d\'action clairs : Qui fait quoi et quand ?';

  @override
  String get retroCoachCompleted =>
      'Excellent travail ! La rétrospective est terminée. Les éléments d\'action ont été envoyés au Backlog.';

  @override
  String retroStep(int step, String title) {
    return 'Étape $step : $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Focus actuel : $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Le modèle nécessite au moins 4 colonnes (style Voilier)';

  @override
  String retroAddTo(String title) {
    return 'Ajouter à $title';
  }

  @override
  String get retroNoColumnsConfigured => 'Aucune colonne configurée.';

  @override
  String get retroNewActionItem => 'Nouvel élément d\'action';

  @override
  String get retroEditActionItem => 'Modifier l\'élément d\'action';

  @override
  String get retroActionWhatToDo => 'Que faut-il faire ?';

  @override
  String get retroActionDescriptionHint => 'Décrivez l\'action concrète...';

  @override
  String get retroActionRequired => 'Obligatoire';

  @override
  String get retroActionLinkedCard => 'Liée à la carte Rétro (Optionnel)';

  @override
  String get retroActionNone => 'Aucun';

  @override
  String get retroActionType => 'Type d\'action';

  @override
  String get retroActionNoType => 'Aucun type spécifique';

  @override
  String get retroActionAssignee => 'Responsable';

  @override
  String get retroActionNoAssignee => 'Aucun';

  @override
  String get retroActionPriority => 'Priorité';

  @override
  String get retroActionDueDate => 'Date d\'échéance (Deadline)';

  @override
  String get retroActionSelectDate => 'Sélectionner la date...';

  @override
  String get retroActionSupportResources => 'Ressources de support';

  @override
  String get retroActionResourcesHint =>
      'Outils, budget, personnes supplémentaires nécessaires...';

  @override
  String get retroActionMonitoring => 'Méthode de suivi';

  @override
  String get retroActionMonitoringHint =>
      'Comment allons-nous vérifier la progression ? (ex : Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Réf.';

  @override
  String get retroTableSourceColumn => 'Colonne';

  @override
  String get retroTableDescription => 'Description';

  @override
  String get retroTableOwner => 'Propriétaire';

  @override
  String get retroIcebreakerTwoTruths => 'Due Verità e una Bugia';

  @override
  String get retroDescTwoTruths => 'Semplice e classico.';

  @override
  String get retroIcebreakerCheckin => 'Check-in Emotivo';

  @override
  String get retroDescCheckin => 'Come si sentono tutti?';

  @override
  String get retroTableActions => 'Actions';

  @override
  String get retroSupportResources => 'Ressources de support';

  @override
  String get retroMonitoringMethod => 'Méthode de suivi';

  @override
  String get retroUnassigned => 'Non assigné';

  @override
  String get retroDeleteActionItem => 'Supprimer l\'élément d\'action';

  @override
  String get retroChooseMethodology => 'Choisir la méthodologie';

  @override
  String get retroHidingWhileTyping => 'Masquage pendant la saisie...';

  @override
  String retroVoteLimitReached(int max) {
    return 'Vous avez atteint la limite de $max votes !';
  }

  @override
  String get retroAddCardHint => 'Quelles sont vos réflexions ?';

  @override
  String get retroAddCard => 'Ajouter une carte';

  @override
  String get retroTimeUp => 'Temps écoulé !';

  @override
  String get retroTimeUpMessage =>
      'Le temps pour cette phase est terminé. Finissez la discussion ou prolongez le temps.';

  @override
  String get retroTimeUpOk => 'Ok, compris';

  @override
  String get retroStopTimer => 'Arrêter le chrono';

  @override
  String get retroStartTimer => 'Démarrer le chrono';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get retroAddCardButton => 'Aggiungi Card';

  @override
  String get retroNoRetrosFound => 'Aucune rétrospective trouvée';

  @override
  String get retroDeleteRetro => 'Supprimer la rétrospective';

  @override
  String get retroParticipantsLabel => 'Participants';

  @override
  String get retroNotesCreated => 'Notes créées';

  @override
  String retroStatusLabel(String status) {
    return 'Statut : $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Date : $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'Aucune tâche dans cette liste';

  @override
  String get smartTodoNoTasksInColumn => 'Aucune tâche';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total terminées';
  }

  @override
  String get smartTodoCreatedDate => 'Date de création';

  @override
  String get smartTodoParticipantRole => 'Participant';

  @override
  String get smartTodoUnassigned => 'Non assigné';

  @override
  String get smartTodoNewTask => 'Nouvelle tâche';

  @override
  String get smartTodoEditTask => 'Modifier';

  @override
  String get smartTodoTaskTitle => 'Titre de la tâche';

  @override
  String get smartTodoDescription => 'DESCRIPTION';

  @override
  String get smartTodoDescriptionHint => 'Ajouter une description détaillée...';

  @override
  String get smartTodoChecklist => 'CHECKLIST';

  @override
  String get smartTodoAddChecklistItem => 'Ajouter un élément';

  @override
  String get smartTodoAttachments => 'PIÈCES JOINTES';

  @override
  String get smartTodoAddLink => 'Ajouter un lien';

  @override
  String get smartTodoComments => 'COMMENTAIRES';

  @override
  String get smartTodoWriteComment => 'Écrire un commentaire...';

  @override
  String get smartTodoAddImageTooltip => 'Ajouter une image (URL)';

  @override
  String get smartTodoStatus => 'STATUT';

  @override
  String get smartTodoPriority => 'PRIORITÉ';

  @override
  String get smartTodoAssignees => 'RESPONSABLES';

  @override
  String get smartTodoNoAssignee => 'Personne';

  @override
  String get smartTodoTags => 'TAGS';

  @override
  String get smartTodoNoTags => 'Aucun tag';

  @override
  String get smartTodoDueDate => 'DATE D\'ÉCHÉANCE';

  @override
  String get smartTodoSetDate => 'Définir la date';

  @override
  String get smartTodoEffort => 'EFFORT';

  @override
  String get smartTodoEffortHint => 'Points (ex. 5)';

  @override
  String get smartTodoAssignTo => 'Assigner à';

  @override
  String get smartTodoSelectTags => 'Sélectionner les tags';

  @override
  String get smartTodoNoTagsAvailable =>
      'Aucun tag disponible. Créez-en un dans les paramètres.';

  @override
  String get smartTodoNewSubtask => 'Nouveau statut';

  @override
  String get smartTodoAddLinkTitle => 'Ajouter un lien';

  @override
  String get smartTodoLinkName => 'Nom';

  @override
  String get smartTodoLinkUrl => 'URL (https://...)';

  @override
  String get smartTodoCannotOpenLink => 'Impossible d\'ouvrir le lien';

  @override
  String get smartTodoPasteImage => 'Coller l\'image';

  @override
  String get smartTodoPasteImageFound =>
      'Image trouvée dans le presse-papiers.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Voulez-vous ajouter cette image de votre presse-papiers ?';

  @override
  String get smartTodoYesAdd => 'Oui, ajouter';

  @override
  String get smartTodoAddImage => 'Ajouter une image';

  @override
  String get smartTodoImageUrlHint =>
      'Collez l\'URL de l\'image (ex. capturée avec CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'URL de l\'image';

  @override
  String get smartTodoPasteFromClipboard => 'Coller depuis le presse-papiers';

  @override
  String get smartTodoEditComment => 'Modifier le commentaire';

  @override
  String get smartTodoSortBy => 'Trier par';

  @override
  String get smartTodoSortDate => 'Récents';

  @override
  String get smartTodoSortManual => 'Manuel';

  @override
  String get smartTodoColumnSortTitle => 'Trier la colonne';

  @override
  String get smartTodoPendingTasks => 'Tâches à compléter';

  @override
  String get smartTodoCompletedTasks => 'Tâches complétées';

  @override
  String get smartTodoEnterTitle => 'Entrez un titre';

  @override
  String get smartTodoUser => 'Utilisateur';

  @override
  String get smartTodoImportTasks => 'Importer des tâches';

  @override
  String get smartTodoImportStep1 => 'Étape 1 : Choisir la source';

  @override
  String get smartTodoImportStep2 => 'Étape 2 : Mapper les colonnes';

  @override
  String get smartTodoImportStep3 => 'Étape 3 : Vérifier et confirmer';

  @override
  String get smartTodoImportRetry => 'Réessayer';

  @override
  String get smartTodoImportPasteText => 'Coller du texte (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Télécharger un fichier (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Collez vos tâches ici. Utilisez la virgule comme séparateur.';

  @override
  String get smartTodoImportPasteExample =>
      'ex. Acheter du lait\nAppeler Marie\nFinir le rapport';

  @override
  String get smartTodoImportSelectFile => 'Sélectionner un fichier CSV';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'Fichier sélectionné : $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Erreur de lecture du fichier : $error';
  }

  @override
  String get smartTodoImportNoData => 'Aucune donnée trouvée';

  @override
  String get smartTodoImportColumnMapping =>
      'Nous avons détecté ces colonnes. Mappez chaque colonne au champ correct.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Colonne $index : \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Exemple de valeur : \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return '$count tâches valides trouvées. Vérifiez avant d\'importer.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Destination :';

  @override
  String get smartTodoImportBack => 'Retour';

  @override
  String get smartTodoImportNext => 'Suivant';

  @override
  String smartTodoImportButton(int count) {
    return 'Importer $count tâches';
  }

  @override
  String get smartTodoImportEnterText =>
      'Entrez du texte ou téléchargez un fichier.';

  @override
  String get smartTodoImportNoValidRows => 'Aucune ligne valide trouvée.';

  @override
  String get smartTodoImportMapTitle =>
      'Vous devez mapper au moins le \"Titre\".';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Erreur d\'analyse : $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return '$count tâches importées !';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Erreur d\'import : $error';
  }

  @override
  String get smartTodoImportHelpTitle => 'Comment importer des tâches ?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Liste simple (une tâche par ligne)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Collez une liste simple avec un titre par ligne. Chaque ligne devient une tâche.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Acheter du lait\nAppeler Mario\nFinir le rapport';

  @override
  String get smartTodoImportHelpCsvTitle => 'Format CSV (avec colonnes)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Utilisez des valeurs séparées par des virgules avec une ligne d\'en-tête. La première ligne définit les colonnes.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nAcheter lait,high,mario@email.com\nAppeler Mario,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Champs disponibles :';

  @override
  String get smartTodoImportHelpFieldTitle => 'Titre de la tâche (obligatoire)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Description de la tâche';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'high, medium, low (ou haute, moyenne, basse)';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Nom de la colonne (ex: À faire, En cours)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Email de l\'utilisateur';

  @override
  String get smartTodoImportHelpFieldEffort => 'Heures (nombre)';

  @override
  String get smartTodoImportHelpFieldTags =>
      'Tags (#tag ou séparés par virgule)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Colonnes disponibles pour STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(colonne vide)';

  @override
  String get smartTodoImportFieldIgnore => '-- Ignorer --';

  @override
  String get smartTodoImportFieldTitle => 'Titre';

  @override
  String get smartTodoImportFieldDescription => 'Description';

  @override
  String get smartTodoImportFieldPriority => 'Priorité';

  @override
  String get smartTodoImportFieldStatus => 'Statut (Colonne)';

  @override
  String get smartTodoImportFieldAssignee => 'Assigné';

  @override
  String get smartTodoImportFieldEffort => 'Effort';

  @override
  String get smartTodoImportFieldTags => 'Tags';

  @override
  String get smartTodoDeleteTaskTitle => 'Supprimer la tâche';

  @override
  String get smartTodoDeleteTaskContent =>
      'Êtes-vous sûr de vouloir supprimer cette tâche ? Cette action ne peut pas être annulée.';

  @override
  String get smartTodoDeleteNoPermission =>
      'Vous n\'avez pas la permission de supprimer cette tâche';

  @override
  String get smartTodoSheetsExportTitle => 'Export Google Sheets';

  @override
  String get smartTodoSheetsExportExists =>
      'Un document Google Sheets existe déjà pour cette liste.';

  @override
  String get smartTodoSheetsOpen => 'Ouvrir';

  @override
  String get smartTodoSheetsUpdate => 'Mettre à jour';

  @override
  String get smartTodoSheetsUpdating => 'Mise à jour de Google Sheets...';

  @override
  String get smartTodoSheetsCreating => 'Création de Google Sheets...';

  @override
  String get smartTodoSheetsUpdated => 'Google Sheets mis à jour !';

  @override
  String get smartTodoSheetsCreated => 'Google Sheets créé !';

  @override
  String get smartTodoSheetsError => 'Erreur lors de l\'export (voir log)';

  @override
  String get error => 'Erreur';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Journal d\'audit - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Utilisateur';

  @override
  String get smartTodoAuditFilterType => 'Type';

  @override
  String get smartTodoAuditFilterAction => 'Action';

  @override
  String get smartTodoAuditFilterTag => 'Tag';

  @override
  String get smartTodoAuditFilterSearch => 'Rechercher';

  @override
  String get smartTodoAuditFilterAll => 'Tous';

  @override
  String get smartTodoAuditFilterAllFemale => 'Toutes';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium requis pour l\'historique étendu';

  @override
  String smartTodoAuditLastDays(int days) {
    return '$days derniers jours';
  }

  @override
  String get smartTodoAuditClearFilters => 'Effacer les filtres';

  @override
  String get smartTodoAuditViewTimeline => 'Vue chronologique';

  @override
  String get smartTodoAuditViewColumns => 'Vue colonnes';

  @override
  String get smartTodoAuditNoActivity => 'Aucune activité enregistrée';

  @override
  String get smartTodoAuditNoResults =>
      'Aucun résultat pour les filtres sélectionnés';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count activités';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Aucune activité';

  @override
  String get smartTodoAuditLoadMore => 'Charger 50 de plus...';

  @override
  String get smartTodoAuditEmptyValue => '(vide)';

  @override
  String get smartTodoAuditEntityList => 'Liste';

  @override
  String get smartTodoAuditEntityTask => 'Tâche';

  @override
  String get smartTodoAuditEntityInvite => 'Invitation';

  @override
  String get smartTodoAuditEntityParticipant => 'Participant';

  @override
  String get smartTodoAuditEntityColumn => 'Colonne';

  @override
  String get smartTodoAuditEntityTag => 'Étiquette';

  @override
  String get smartTodoAuditActionCreate => 'Créé';

  @override
  String get smartTodoAuditActionUpdate => 'Modifié';

  @override
  String get smartTodoAuditActionDelete => 'Supprimé';

  @override
  String get smartTodoAuditActionArchive => 'Archivé';

  @override
  String get smartTodoAuditActionRestore => 'Restauré';

  @override
  String get smartTodoAuditActionMove => 'Déplacé';

  @override
  String get smartTodoAuditActionAssign => 'Assigné';

  @override
  String get smartTodoAuditActionInvite => 'Invité';

  @override
  String get smartTodoAuditActionJoin => 'Rejoint';

  @override
  String get smartTodoAuditActionRevoke => 'Révoqué';

  @override
  String get smartTodoAuditActionReorder => 'Réordonné';

  @override
  String get smartTodoAuditActionBatchCreate => 'Import';

  @override
  String get smartTodoAuditTimeNow => 'Maintenant';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return 'Il y a $count min';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return 'Il y a $count heures';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return 'Il y a $count jours';
  }

  @override
  String get smartTodoCfdTitle => 'CFD Analytics';

  @override
  String get smartTodoCfdTooltip => 'CFD Analytics';

  @override
  String get smartTodoCfdDateRange => 'Periode:';

  @override
  String get smartTodoCfd7Days => '7 jours';

  @override
  String get smartTodoCfd14Days => '14 jours';

  @override
  String get smartTodoCfd30Days => '30 jours';

  @override
  String get smartTodoCfd90Days => '90 jours';

  @override
  String get smartTodoCfdError => 'Erreur de chargement';

  @override
  String get smartTodoCfdRetry => 'Actualiser';

  @override
  String get smartTodoCfdNoData => 'Aucune donnee disponible';

  @override
  String get smartTodoCfdNoDataHint =>
      'Les mouvements des taches seront suivis ici';

  @override
  String get smartTodoCfdKeyMetrics => 'Metriques Cles';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip => 'Temps de creation a l\'achevement';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Temps du debut de travail a l\'achevement';

  @override
  String get smartTodoCfdThroughput => 'Debit';

  @override
  String get smartTodoCfdThroughputTooltip => 'Taches terminees par semaine';

  @override
  String get smartTodoCfdWip => 'TEC';

  @override
  String get smartTodoCfdWipTooltip => 'Travail en cours';

  @override
  String get smartTodoCfdLimit => 'Limite';

  @override
  String get smartTodoCfdCompleted => 'termines';

  @override
  String get smartTodoCfdFlowAnalysis => 'Analyse du Flux';

  @override
  String get smartTodoCfdArrived => 'Arrives';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog en diminution';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog en augmentation';

  @override
  String get smartTodoCfdBottlenecks => 'Detection des Goulots';

  @override
  String get smartTodoCfdNoBottlenecks => 'Aucun goulot detecte';

  @override
  String get smartTodoCfdTasks => 'taches';

  @override
  String get smartTodoCfdAvgAge => 'Age moy';

  @override
  String get smartTodoCfdAgingWip => 'Travaux en Cours Vieillissants';

  @override
  String get smartTodoCfdTask => 'Tache';

  @override
  String get smartTodoCfdColumn => 'Colonne';

  @override
  String get smartTodoCfdAge => 'Age';

  @override
  String get smartTodoCfdDays => 'jours';

  @override
  String get smartTodoCfdHowCalculated => 'Comment est-il calcule?';

  @override
  String get smartTodoCfdMedian => 'Mediane';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Min';

  @override
  String get smartTodoCfdMax => 'Max';

  @override
  String get smartTodoCfdSample => 'Echantillon';

  @override
  String get smartTodoCfdVsPrevious => 'vs periode precedente';

  @override
  String get smartTodoCfdArrivalRate => 'Taux d\'arrivee';

  @override
  String get smartTodoCfdCompletionRate => 'Taux d\'achevement';

  @override
  String get smartTodoCfdNetFlow => 'Flux Net';

  @override
  String get smartTodoCfdPerDay => '/jour';

  @override
  String get smartTodoCfdPerWeek => '/semaine';

  @override
  String get smartTodoCfdSeverity => 'Severite';

  @override
  String get smartTodoCfdAssignee => 'Assignataire';

  @override
  String get smartTodoCfdUnassigned => 'Non assigne';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Le Lead Time mesure le temps total de la creation d\'une tache jusqu\'a son achevement.\n\n**Formule:**\nLead Time = Date d\'achevement - Date de creation\n\n**Metriques:**\n- **Moyenne**: Moyenne de tous les lead times\n- **Mediane**: Valeur centrale (moins sensible aux valeurs aberrantes)\n- **P85**: 85% des taches sont terminees dans ce delai\n- **P95**: 95% des taches sont terminees dans ce delai\n\n**Pourquoi c\'est important:**\nLe Lead Time represente l\'experience client - le temps d\'attente total. Utilisez P85 pour les estimations de livraison aux clients.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Le Cycle Time mesure le temps depuis le debut reel du travail (la tache quitte \'A faire\') jusqu\'a l\'achevement.\n\n**Formule:**\nCycle Time = Date d\'achevement - Date de debut du travail\n\n**Difference avec Lead Time:**\n- **Lead Time** = Perspective client (inclut l\'attente)\n- **Cycle Time** = Perspective equipe (travail actif uniquement)\n\n**Comment \'Debut du travail\' est detecte:**\nLa premiere fois qu\'une tache quitte la colonne \'A faire\' est enregistree comme date de debut du travail.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Le Throughput mesure combien de taches sont terminees par unite de temps.\n\n**Formules:**\n- Moyenne quotidienne = Taches terminees / Jours dans la periode\n- Moyenne hebdomadaire = Moyenne quotidienne x 7\n\n**Comment l\'utiliser:**\nPrevoir les dates de livraison:\nTaches restantes / Throughput hebdomadaire = Semaines pour terminer\n\n**Exemple:**\n30 taches restantes, throughput de 10/semaine = ~3 semaines';

  @override
  String get smartTodoCfdWipExplanation =>
      'Le WIP (Work In Progress) compte les taches actuellement en cours - pas dans \'A faire\' et pas dans \'Termine\'.\n\n**Formule:**\nWIP = Total Taches - Taches A faire - Taches Terminees\n\n**Loi de Little:**\nLead Time = WIP / Throughput\n\nReduire le WIP reduit directement le Lead Time!\n\n**Limite WIP suggeree:**\nTaille de l\'equipe x 2 (meilleure pratique Kanban)\n\n**Statut:**\n- Sain: WIP <= Limite\n- Attention: WIP > Limite x 1.25\n- Critique: WIP > Limite x 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'L\'Analyse de Flux compare le taux d\'arrivee des nouvelles taches vs les taches terminees.\n\n**Formules:**\n- Taux d\'arrivee = Nouvelles taches creees / Jours\n- Taux d\'achevement = Taches terminees / Jours\n- Flux Net = Terminees - Arrivees\n\n**Interpretation du statut:**\n- **Vidange** (Achevement > Arrivee): WIP en diminution - bien!\n- **Equilibre** (dans +/-10%): Flux stable\n- **Remplissage** (Arrivee > Achevement): WIP en augmentation - action necessaire';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'La Detection des Goulots d\'etranglement identifie les colonnes ou les taches s\'accumulent ou restent trop longtemps.\n\n**Algorithme:**\nSeverite = (Score Comptage + Score Age) / 2\n\nOu:\n- Score Comptage = Taches dans la colonne / 10\n- Score Age = Age moyen / 7 jours\n\n**Signale quand:**\n- 2+ taches dans la colonne, OU\n- Age moyen > 2 jours\n\n**Niveaux de severite:**\n- Faible (< 0.3): Surveiller\n- Moyen (0.3-0.6): Enqueter\n- Eleve (> 0.6): Agir';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP montre les taches actuellement en cours, triees par duree de travail.\n\n**Formule:**\nAge = Heure actuelle - Date de debut du travail (en jours)\n\n**Statut par age:**\n- Frais (< 3 jours): Normal\n- Attention (3-7 jours): Peut necessiter attention\n- Critique (> 7 jours): Probablement bloque - enqueter!\n\nLes vieilles taches indiquent souvent des blocages, des exigences peu claires ou une derive du scope.';

  @override
  String get smartTodoCfdTeamBalance => 'Equilibre de l\'Equipe';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'L\'Equilibre de l\'Equipe montre la distribution des taches entre les membres.\n\n**Score d\'Equilibre:**\nCalcule avec le coefficient de variation (CV).\nScore = 1 / (1 + CV)\n\n**Statut:**\n- Equilibre (≥80%): Travail distribue equitablement\n- Inegal (50-80%): Quelque desequilibre\n- Desequilibre (<50%): Disparite significative\n\n**Colonnes:**\n- A Faire: Taches en attente\n- WIP: Taches en cours\n- Fait: Taches terminees';

  @override
  String get smartTodoCfdBalanced => 'Equilibre';

  @override
  String get smartTodoCfdUneven => 'Inegal';

  @override
  String get smartTodoCfdImbalanced => 'Desequilibre';

  @override
  String get smartTodoCfdMember => 'Membre';

  @override
  String get smartTodoCfdTotal => 'Total';

  @override
  String get smartTodoCfdToDo => 'A Faire';

  @override
  String get smartTodoCfdInProgress => 'En Cours';

  @override
  String get smartTodoCfdDone => 'Fait';

  @override
  String get smartTodoNewTaskDefault => 'Nouvelle tâche';

  @override
  String get smartTodoRename => 'Renommer';

  @override
  String get smartTodoAddActivity => 'Ajouter une activité';

  @override
  String get smartTodoAddColumn => 'Ajouter une colonne';

  @override
  String get smartTodoParticipantManagement => 'Gestion des participants';

  @override
  String get smartTodoParticipantsTab => 'Participants';

  @override
  String get smartTodoInvitesTab => 'Invitations';

  @override
  String get smartTodoAddParticipant => 'Ajouter un participant';

  @override
  String smartTodoMembers(int count) {
    return 'Membres ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'Aucune invitation en attente';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Rôle : $role';
  }

  @override
  String get smartTodoExpired => 'EXPIRÉ';

  @override
  String smartTodoSentBy(String name) {
    return 'Envoyé par $name';
  }

  @override
  String get smartTodoResendEmail => 'Renvoyer l\'email';

  @override
  String get smartTodoRevoke => 'Révoquer';

  @override
  String get smartTodoSendingEmail => 'Envoi de l\'email...';

  @override
  String get smartTodoEmailResent => 'Email renvoyé !';

  @override
  String get smartTodoEmailSendError => 'Erreur lors de l\'envoi de l\'email.';

  @override
  String get smartTodoInvalidSession =>
      'Session invalide pour envoyer l\'email.';

  @override
  String get smartTodoEmail => 'Email';

  @override
  String get smartTodoRole => 'Rôle';

  @override
  String get smartTodoInviteCreated =>
      'Invitation créée et envoyée avec succès !';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Invitation créée, mais email non envoyé (vérifiez la connexion Google/permissions).';

  @override
  String get smartTodoUserAlreadyInvited => 'Utilisateur déjà invité.';

  @override
  String get smartTodoInviteCollaborator => 'Inviter un collaborateur';

  @override
  String get smartTodoEditorRole => 'Éditeur (peut modifier)';

  @override
  String get smartTodoViewerRole => 'Lecteur (lecture seule)';

  @override
  String get smartTodoSendEmailNotification =>
      'Envoyer une notification par email';

  @override
  String get smartTodoSend => 'Envoyer';

  @override
  String get smartTodoInvalidEmail => 'Email invalide';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Utilisateur non authentifié ou email manquant';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Connexion Google requise pour envoyer des emails';

  @override
  String smartTodoInviteSent(String email) {
    return 'Invitation envoyée à $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Utilisateur déjà invité ou invitation en attente.';

  @override
  String get smartTodoFilterToday => 'Aujourd\'hui';

  @override
  String get smartTodoFilterMyTasks => 'Mes Tâches';

  @override
  String get smartTodoFilterOwner => 'Propriétaire';

  @override
  String get smartTodoViewGlobalTasks => 'Voir Tâches Globales';

  @override
  String get smartTodoViewLists => 'Voir Listes';

  @override
  String get smartTodoNewListDialogTitle => 'Nouvelle Liste';

  @override
  String get smartTodoTitleLabel => 'Titre *';

  @override
  String get smartTodoDescriptionLabel => 'Description';

  @override
  String get smartTodoCancel => 'Annuler';

  @override
  String get smartTodoCreate => 'Créer';

  @override
  String get smartTodoSave => 'Enregistrer';

  @override
  String get smartTodoNoListsPresent => 'Aucune liste disponible';

  @override
  String get smartTodoCreateFirstList =>
      'Créez votre première liste pour commencer';

  @override
  String smartTodoMembersCount(int count) {
    return '$count membres';
  }

  @override
  String get smartTodoRenameListTitle => 'Renommer la Liste';

  @override
  String get smartTodoNewNameLabel => 'Nouveau nom';

  @override
  String get smartTodoDeleteListTitle => 'Supprimer la Liste';

  @override
  String get smartTodoDeleteListConfirm =>
      'Êtes-vous sûr de vouloir supprimer cette liste et toutes ses tâches ? Cette action est irréversible.';

  @override
  String get smartTodoDelete => 'Supprimer';

  @override
  String get smartTodoEdit => 'Modifier';

  @override
  String get smartTodoSearchHint => 'Rechercher des listes...';

  @override
  String get smartTodoSearchTasksHint => 'Rechercher...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Aucun résultat pour \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'À Faire';

  @override
  String get smartTodoColumnInProgress => 'En Cours';

  @override
  String get smartTodoColumnDone => 'Terminé';

  @override
  String get smartTodoAllPeople => 'Toutes les personnes';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count personnes';
  }

  @override
  String get smartTodoFilterByPerson => 'Filtrer par personne';

  @override
  String get smartTodoApplyFilters => 'Appliquer les Filtres';

  @override
  String get smartTodoAllTags => 'Tous les tags';

  @override
  String smartTodoTagsCount(int count) {
    return '$count tags';
  }

  @override
  String get smartTodoFilterByTag => 'Filtrer par tag';

  @override
  String get smartTodoTagAlreadyExists => 'Tag déjà existant';

  @override
  String smartTodoError(String error) {
    return 'Erreur : $error';
  }

  @override
  String get profileMenuTitle => 'Profil';

  @override
  String get profileMenuLogout => 'Déconnexion';

  @override
  String get profileLogoutDialogTitle => 'Déconnexion';

  @override
  String get profileLogoutDialogConfirm =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get agileAddToSprint => 'Ajouter au Sprint';

  @override
  String get agileEstimate => 'ESTIMER';

  @override
  String get agileEstimated => 'Estimé';

  @override
  String get agileEstimateRequired =>
      'Estimation requise (cliquez pour estimer)';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileGuide => 'Guide';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Archive des terminés';

  @override
  String get backlogStories => 'stories';

  @override
  String get backlogEstimated => 'estimées';

  @override
  String get backlogShowActive => 'Afficher le Backlog actif';

  @override
  String backlogShowArchive(int count) {
    return 'Afficher l\'archive ($count terminées)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Archive ($count)';
  }

  @override
  String get backlogFilters => 'Filtres';

  @override
  String get backlogNewStory => 'Nouvelle Story';

  @override
  String get backlogSearchHint => 'Rechercher par titre, description ou ID...';

  @override
  String get backlogStatusFilter => 'Statut : ';

  @override
  String get backlogPriorityFilter => 'Priorité : ';

  @override
  String get backlogTagFilter => 'Tag : ';

  @override
  String get backlogAllStatuses => 'Tous';

  @override
  String get backlogAllPriorities => 'Toutes';

  @override
  String get backlogRemoveFilters => 'Supprimer les filtres';

  @override
  String get backlogNoStoryFound => 'Aucune story trouvée';

  @override
  String get backlogEmpty => 'Backlog vide';

  @override
  String get backlogAddFirstStory => 'Ajouter la première User Story';

  @override
  String get kanbanWipExceeded =>
      'Limite WIP dépassée ! Terminez quelques éléments avant d\'en commencer de nouveaux.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'Configurer WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP : $current sur $max max';
  }

  @override
  String get kanbanNoWipLimit => 'Pas de limite WIP';

  @override
  String kanbanItems(int count) {
    return '$count éléments';
  }

  @override
  String get kanbanEmpty => 'Vide';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'Limite WIP : $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Définissez le nombre maximum d\'éléments pouvant être dans cette colonne en même temps.';

  @override
  String get kanbanWipLimitLabel => 'Limite WIP';

  @override
  String get kanbanWipLimitHint => 'Laisser vide pour aucune limite';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Suggestion : commencez par $count et ajustez selon l\'équipe.';
  }

  @override
  String get kanbanRemoveLimit => 'Supprimer la limite';

  @override
  String get kanbanWipExceededTitle => 'Limite WIP dépassée';

  @override
  String get kanbanWipExceededMessage => 'Déplacer ';

  @override
  String get kanbanWipExceededIn => ' vers ';

  @override
  String get kanbanWipExceededWillExceed => ' dépassera la limite WIP.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Colonne : $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Actuel : $current | Limite : $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Après déplacement : $count';
  }

  @override
  String get kanbanSuggestion =>
      'Suggestion : terminez ou déplacez d\'autres éléments avant d\'en commencer de nouveaux pour maintenir un flux de travail optimal.';

  @override
  String get kanbanMoveAnyway => 'Déplacer quand même';

  @override
  String get kanbanWipExplanationTitle => 'Limites WIP';

  @override
  String get kanbanWipWhat => 'Que sont les limites WIP ?';

  @override
  String get kanbanWipWhatDesc =>
      'Les limites WIP (Work In Progress) sont des limites sur le nombre d\'éléments pouvant être dans une colonne en même temps.';

  @override
  String get kanbanWipWhy => 'Pourquoi les utiliser ?';

  @override
  String get kanbanWipBenefit1 =>
      '- Réduire le multitâche et augmenter la concentration';

  @override
  String get kanbanWipBenefit2 =>
      '- Mettre en évidence les goulots d\'étranglement';

  @override
  String get kanbanWipBenefit3 => '- Améliorer le flux de travail';

  @override
  String get kanbanWipBenefit4 => '- Accélérer la complétion des éléments';

  @override
  String get kanbanWipWhatToDo => 'Que faire si une limite est dépassée ?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Terminez ou déplacez les éléments existants avant d\'en commencer de nouveaux\n2. Aidez les collègues à débloquer les éléments en revue\n3. Analysez pourquoi la limite a été dépassée';

  @override
  String get kanbanUnderstood => 'Compris';

  @override
  String get kanbanBoardTitle => 'Tableau Kanban';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Nouveau Sprint';

  @override
  String get sprintNoSprints => 'Aucun sprint';

  @override
  String get sprintCreateFirst => 'Créez le premier sprint pour commencer';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Démarrer le Sprint';

  @override
  String get sprintComplete => 'Terminer le Sprint';

  @override
  String sprintDays(int days) {
    return '${days}j';
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
  String get sprintPointsCompleted => 'terminés';

  @override
  String get sprintVelocity => 'vélocité';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}j restants';
  }

  @override
  String get sprintStartButton => 'Démarrer';

  @override
  String get sprintCompleteActiveFirst =>
      'Terminez le sprint actif avant d\'en démarrer un autre';

  @override
  String get sprintEditTitle => 'Modifier le Sprint';

  @override
  String get sprintNewTitle => 'Nouveau Sprint';

  @override
  String get sprintNameLabel => 'Nom du Sprint';

  @override
  String get sprintNameHint => 'ex. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Entrez un nom';

  @override
  String get sprintGoalLabel => 'Objectif du Sprint';

  @override
  String get sprintGoalHint => 'Objectif du sprint';

  @override
  String get sprintStartDateLabel => 'Date de début';

  @override
  String get sprintEndDateLabel => 'Date de fin';

  @override
  String sprintDuration(int days) {
    return 'Durée : $days jours';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Vélocité moyenne : $velocity pts/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Équipe : $count membres';
  }

  @override
  String get sprintPlanningTitle => 'Planification de Sprint';

  @override
  String get sprintPlanningSubtitle =>
      'Sélectionnez les stories à terminer dans ce sprint';

  @override
  String get sprintPlanningSelected => 'Sélectionnées';

  @override
  String get sprintPlanningSuggested => 'Suggérées';

  @override
  String get sprintPlanningCapacity => 'Capacité';

  @override
  String get sprintPlanningBasedOnVelocity => 'basé sur la vélocité moyenne';

  @override
  String sprintPlanningDays(int days) {
    return '$days jours';
  }

  @override
  String get sprintPlanningExceeded => 'Attention : vélocité suggérée dépassée';

  @override
  String get sprintPlanningNoStories =>
      'Aucune story disponible dans le backlog';

  @override
  String get sprintPlanningNotEstimated => 'Non estimée';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Confirmer ($count stories)';
  }

  @override
  String get storyFormEditTitle => 'Modifier la Story';

  @override
  String get storyFormNewTitle => 'Nouvelle User Story';

  @override
  String get storyFormDetailsTab => 'Détails';

  @override
  String get storyFormAcceptanceTab => 'Critères d\'acceptation';

  @override
  String get storyFormOtherTab => 'Autre';

  @override
  String get storyFormTitleLabel => 'Titre *';

  @override
  String get storyFormTitleHint =>
      'Ex: US-123: En tant qu\'utilisateur je veux...';

  @override
  String get storyFormTitleRequired => 'Entrez un titre';

  @override
  String get storyFormUseTemplate => 'Utiliser le modèle User Story';

  @override
  String get storyFormTemplateSubtitle =>
      'En tant que... Je veux... Afin de...';

  @override
  String get storyFormAsA => 'En tant que...';

  @override
  String get storyFormAsAHint => 'utilisateur, admin, client...';

  @override
  String get storyFormIWant => 'Je veux...';

  @override
  String get storyFormIWantHint => 'pouvoir faire quelque chose...';

  @override
  String get storyFormIWantRequired => 'Entrez ce que l\'utilisateur veut';

  @override
  String get storyFormSoThat => 'Afin de...';

  @override
  String get storyFormSoThatHint => 'obtenir un avantage...';

  @override
  String get storyFormDescriptionLabel => 'Description';

  @override
  String get storyFormDescriptionHint => 'Critères d\'acceptation, notes...';

  @override
  String get storyFormDescriptionRequired => 'Entrez une description';

  @override
  String get storyFormPreview => 'Aperçu :';

  @override
  String get storyFormEmptyDescription => '(description vide)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Critères d\'acceptation';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Définissez quand la story peut être considérée comme terminée';

  @override
  String get storyFormAddCriterionHint =>
      'Ajouter un critère d\'acceptation...';

  @override
  String get storyFormNoCriteria => 'Aucun critère défini';

  @override
  String get storyFormSuggestions => 'Suggestions :';

  @override
  String get storyFormSuggestion1 =>
      'Les données sont sauvegardées correctement';

  @override
  String get storyFormSuggestion2 => 'L\'utilisateur reçoit une confirmation';

  @override
  String get storyFormSuggestion3 =>
      'Le formulaire affiche les erreurs de validation';

  @override
  String get storyFormSuggestion4 =>
      'La fonctionnalité est accessible depuis mobile';

  @override
  String get storyFormPriorityLabel => 'Priorité (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Valeur métier';

  @override
  String get storyFormBusinessValueHigh => 'Haute valeur métier';

  @override
  String get storyFormBusinessValueMedium => 'Valeur moyenne';

  @override
  String get storyFormBusinessValueLow => 'Faible valeur métier';

  @override
  String get storyFormStoryPointsLabel => 'Estimée en Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Les Story Points représentent la complexité relative du travail.\nUtilisez la séquence de Fibonacci : 1 (simple) -> 21 (très complexe).';

  @override
  String get storyFormNoPoints => 'Aucun';

  @override
  String get storyFormPointsSimple => 'Tâche rapide et simple';

  @override
  String get storyFormPointsMedium => 'Tâche de complexité moyenne';

  @override
  String get storyFormPointsComplex => 'Tâche complexe, nécessite une analyse';

  @override
  String get storyFormPointsVeryComplex =>
      'Très complexe, envisagez de découper la story';

  @override
  String get storyFormTagsLabel => 'Tags';

  @override
  String get storyFormAddTagHint => 'Ajouter un tag...';

  @override
  String get storyFormExistingTags => 'Tags existants :';

  @override
  String get storyFormAssigneeLabel => 'Assigner à';

  @override
  String get storyFormAssigneeHint => 'Sélectionner un membre de l\'équipe';

  @override
  String get storyFormNotAssigned => 'Non assigné';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points points';
  }

  @override
  String get storyDetailDescriptionTitle => 'Description';

  @override
  String get storyDetailNoDescription => 'Pas de description';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Critères d\'acceptation ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Aucun critère défini';

  @override
  String get storyDetailEstimationTitle => 'Estimation';

  @override
  String get storyDetailFinalEstimate => 'Estimation finale : ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count estimations reçues';
  }

  @override
  String get storyDetailInfoTitle => 'Informations';

  @override
  String get storyDetailBusinessValue => 'Valeur métier';

  @override
  String get storyDetailAssignedTo => 'Assignée à';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Créée le';

  @override
  String get storyDetailStartedAt => 'Démarrée le';

  @override
  String get storyDetailCompletedAt => 'Terminée le';

  @override
  String get landingBadge => 'Outils pour équipes Agile';

  @override
  String get landingHeroTitle => 'Créez de meilleurs produits\navec Keisen';

  @override
  String get landingHeroSubtitle =>
      'Priorisez, estimez et gérez vos projets avec des outils collaboratifs. Tout en un seul endroit, gratuitement.';

  @override
  String get landingStartFree => 'Commencer gratuitement';

  @override
  String get landingEverythingNeed => 'Tout ce dont vous avez besoin';

  @override
  String get landingModernTools =>
      'Des outils conçus pour les équipes modernes';

  @override
  String get landingSmartTodoBadge => 'Productivité';

  @override
  String get landingSmartTodoTitle => 'Liste Smart Todo';

  @override
  String get landingSmartTodoSubtitle =>
      'Gestion de tâches intelligente et collaborative pour les équipes modernes';

  @override
  String get landingSmartTodoCollaborativeTitle =>
      'Listes de tâches collaboratives';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo transforme la gestion des activités quotidiennes en un processus fluide et collaboratif. Créez des listes, assignez des tâches aux membres de l\'équipe et suivez la progression en temps réel.\n\nIdéal pour les équipes distribuées nécessitant une synchronisation continue sur les activités à compléter.';

  @override
  String get landingSmartTodoImportTitle => 'Import flexible';

  @override
  String get landingSmartTodoImportDesc =>
      'Importez vos activités depuis des sources externes en quelques clics. Support des fichiers CSV, copier/coller depuis Excel ou texte libre. Le système reconnaît automatiquement la structure des données.\n\nMigrez facilement depuis d\'autres outils sans perdre d\'informations ni ressaisir manuellement chaque tâche.';

  @override
  String get landingSmartTodoShareTitle => 'Partage et invitations';

  @override
  String get landingSmartTodoShareDesc =>
      'Invitez collègues et collaborateurs à vos listes par email. Chaque participant peut voir, commenter et mettre à jour le statut des tâches assignées.\n\nParfait pour gérer des projets transverses avec des parties prenantes externes ou des équipes pluridisciplinaires.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Fonctionnalités Smart Todo';

  @override
  String get landingEisenhowerBadge => 'Priorisation';

  @override
  String get landingEisenhowerSubtitle =>
      'La méthode de prise de décision utilisée par les leaders pour gérer le temps';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Urgent vs Important';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'La Matrice Eisenhower, conçue par le 34e président américain Dwight D. Eisenhower, divise les activités en quatre quadrants basés sur deux critères : urgence et importance.\n\nCe cadre de décision aide à distinguer ce qui nécessite une attention immédiate de ce qui contribue aux objectifs à long terme.';

  @override
  String get landingEisenhowerDecisionsTitle => 'De meilleures décisions';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'En appliquant constamment la matrice, vous développez un état d\'esprit orienté résultats. Vous apprenez à dire \"non\" aux distractions et à vous concentrer sur ce qui génère une vraie valeur.\n\nNotre outil numérique rend ce processus immédiat : faites glisser les activités dans le bon quadrant et obtenez une vue claire de vos priorités.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Pourquoi utiliser la Matrice Eisenhower ?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Des études montrent que 80% des activités quotidiennes tombent dans les quadrants 3 et 4 (non importants). La matrice aide à les identifier et à libérer du temps pour ce qui compte vraiment.';

  @override
  String get landingEisenhowerQuadrants =>
      'Quadrant 1 : Urgent + Important → Faire maintenant\nQuadrant 2 : Non Urgent + Important → Planifier\nQuadrant 3 : Urgent + Non Important → Déléguer\nQuadrant 4 : Non Urgent + Non Important → Éliminer';

  @override
  String get landingAgileBadge => 'Méthodologies';

  @override
  String get landingAgileTitle => 'Framework Agile & Scrum';

  @override
  String get landingAgileSubtitle =>
      'Implémentez les meilleures pratiques pour le développement logiciel itératif';

  @override
  String get landingAgileIterativeTitle =>
      'Développement itératif et incrémental';

  @override
  String get landingAgileIterativeDesc =>
      'L\'approche Agile divise le travail en cycles courts appelés Sprints, généralement de 1 à 4 semaines. Chaque itération produit un incrément de produit fonctionnel.\n\nAvec Keisen, vous pouvez gérer votre backlog, planifier les sprints et surveiller la vélocité de l\'équipe en temps réel.';

  @override
  String get landingAgileScrumTitle => 'Framework Scrum';

  @override
  String get landingAgileScrumDesc =>
      'Scrum est le framework Agile le plus répandu. Il définit des rôles (Product Owner, Scrum Master, Équipe), des événements (Sprint Planning, Daily, Review, Rétrospective) et des artefacts (Product Backlog, Sprint Backlog).\n\nKeisen supporte tous les événements Scrum avec des outils dédiés pour chaque cérémonie.';

  @override
  String get landingAgileKanbanTitle => 'Tableau Kanban';

  @override
  String get landingAgileKanbanDesc =>
      'La méthode Kanban visualise le flux de travail à travers des colonnes représentant les états du processus. Elle limite le Travail En Cours (WIP) pour maximiser le débit.\n\nNotre tableau Kanban supporte la personnalisation des colonnes, les limites WIP et les métriques de flux.';

  @override
  String get landingEstimationBadge => 'Estimation';

  @override
  String get landingEstimationTitle =>
      'Techniques d\'estimation collaboratives';

  @override
  String get landingEstimationSubtitle =>
      'Choisissez la meilleure méthode pour votre équipe pour des estimations précises';

  @override
  String get landingEstimationFeaturesTitle =>
      'Fonctionnalités de la Salle d\'Estimation';

  @override
  String get landingRetroBadge => 'Rétrospective';

  @override
  String get landingRetroTitle => 'Rétrospectives interactives';

  @override
  String get landingRetroSubtitle =>
      'Outils collaboratifs en temps réel : chronomètres, votes anonymes, éléments d\'action et rapports IA.';

  @override
  String get landingRetroActionTitle => 'Suivi des éléments d\'action';

  @override
  String get landingRetroActionDesc =>
      'Chaque rétrospective génère des éléments d\'action traçables avec propriétaires, échéances et statuts. Surveillez le suivi dans le temps.';

  @override
  String get landingWorkflowBadge => 'Flux de travail';

  @override
  String get landingWorkflowTitle => 'Comment ça marche';

  @override
  String get landingWorkflowSubtitle => 'Commencez en 3 étapes simples';

  @override
  String get landingStep1Title => 'Créer un projet';

  @override
  String get landingStep1Desc =>
      'Créez votre projet Agile et invitez l\'équipe. Configurez les sprints, backlogs et tableaux.';

  @override
  String get landingStep2Title => 'Collaborer';

  @override
  String get landingStep2Desc =>
      'Estimez les user stories ensemble, organisez les sprints et suivez la progression en temps réel.';

  @override
  String get landingStep3Title => 'Améliorer';

  @override
  String get landingStep3Desc =>
      'Analysez les métriques, menez des rétrospectives et améliorez continuellement le processus.';

  @override
  String get landingCtaTitle => 'Prêt à commencer ?';

  @override
  String get landingCtaDesc =>
      'Inscrivez-vous gratuitement et commencez à collaborer avec votre équipe.';

  @override
  String get landingFooterBrandDesc =>
      'Outils collaboratifs pour les équipes agiles.\nPlanifiez, estimez et améliorez ensemble.';

  @override
  String get landingFooterProduct => 'Produit';

  @override
  String get landingFooterResources => 'Ressources';

  @override
  String get landingFooterCompany => 'Entreprise';

  @override
  String get landingFooterLegal => 'Légal';

  @override
  String get landingCopyright => '© 2026 Keisen. Tous droits réservés.';

  @override
  String get featureSmartImportDesc =>
      'Création rapide de tâches avec description\nAssignation aux membres de l\'équipe\nPriorité et échéances configurables\nNotifications de complétion';

  @override
  String get featureImportDesc =>
      'Import depuis fichier CSV\nCopier/coller depuis Excel\nAnalyse intelligente du texte\nMapping automatique des champs';

  @override
  String get featureShareDesc =>
      'Invitations par email\nPermissions configurables\nCommentaires sur les tâches\nHistorique des modifications';

  @override
  String get featureSmartTaskCreation => 'Création rapide de tâches';

  @override
  String get featureTeamAssignment => 'Assignation à l\'équipe';

  @override
  String get featurePriorityDeadline => 'Priorité et échéances';

  @override
  String get featureCompletionNotifications => 'Notifications de complétion';

  @override
  String get featureCsvImport => 'Import CSV';

  @override
  String get featureExcelPaste => 'Copier/Coller Excel';

  @override
  String get featureSmartParsing => 'Analyse intelligente du texte';

  @override
  String get featureAutoMapping => 'Mapping automatique des champs';

  @override
  String get featureEmailInvites => 'Invitations par email';

  @override
  String get featurePermissions => 'Permissions configurables';

  @override
  String get featureTaskComments => 'Commentaires sur les tâches';

  @override
  String get featureHistory => 'Historique des modifications';

  @override
  String get featureAdvancedFilters => 'Filtres avancés';

  @override
  String get featureFullTextSearch => 'Recherche plein texte';

  @override
  String get featureSorting => 'Tri';

  @override
  String get featureTagsCategories => 'Tags & Catégories';

  @override
  String get featureArchiving => 'Archivage';

  @override
  String get featureSort => 'Tri';

  @override
  String get featureDataExport => 'Export des données';

  @override
  String get landingIntroFeatures =>
      'Planification de sprint avec capacité d\'équipe\nBacklog priorisé avec glisser-déposer\nSuivi de vélocité et burndown chart\nDaily standup facilité';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog avec story points\nSprint Backlog avec découpage des tâches\nTableau de rétrospective intégré\nMétriques Scrum automatiques';

  @override
  String get landingAgileKanbanFeatures =>
      'Colonnes personnalisables\nLimites WIP par colonne\nGlisser-déposer intuitif\nLead time et cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'La méthode classique : chaque membre choisit une carte (1, 2, 3, 5, 8...). Les estimations sont révélées simultanément pour éviter les biais.';

  @override
  String get landingEstimationTShirtTitle => 'Taille T-Shirt';

  @override
  String get landingEstimationTShirtSubtitle => 'Dimensionnement relatif';

  @override
  String get landingEstimationTShirtDesc =>
      'Estimation rapide utilisant des tailles : XS, S, M, L, XL, XXL. Idéal pour le grooming initial du backlog ou quand des estimations approximatives sont nécessaires.';

  @override
  String get landingEstimationPertTitle => 'Trois points (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Optimiste / Probable / Pessimiste';

  @override
  String get landingEstimationPertDesc =>
      'Technique statistique : chaque membre fournit 3 estimations (O, M, P). La formule PERT calcule la moyenne pondérée : (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Système de seaux';

  @override
  String get landingEstimationBucketSubtitle => 'Catégorisation rapide';

  @override
  String get landingEstimationBucketDesc =>
      'Les user stories sont assignées à des \"seaux\" prédéfinis. Excellent pour estimer rapidement de grandes quantités d\'éléments lors des sessions de refinement.';

  @override
  String get landingEstimationChipHiddenVote => 'Vote caché';

  @override
  String get landingEstimationChipTimer => 'Chronomètre configurable';

  @override
  String get landingEstimationChipStats => 'Stats en temps réel';

  @override
  String get landingEstimationChipParticipants => 'Jusqu\'à 20 participants';

  @override
  String get landingEstimationChipHistory => 'Historique des estimations';

  @override
  String get landingEstimationChipExport => 'Export des résultats';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'Le format classique : quoi commencer à faire, quoi arrêter de faire, quoi continuer à faire.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Rétrospective émotionnelle : ce qui nous a mis en colère, rendus tristes ou contents.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - analyse complète du sprint.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Voilier';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Métaphore visuelle : vent (aides), ancre (obstacles), rochers (risques), île (objectifs).';

  @override
  String get landingRetroTemplateWentWellTitle =>
      'Ce qui a bien marché / À améliorer';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Format simple et direct : ce qui a bien marché et ce qu\'il faut améliorer.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - décisions concrètes pour le prochain sprint.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Suivi des éléments d\'action';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Chaque rétrospective génère des éléments d\'action traçables avec propriétaire, échéance et statut. Surveillez le suivi dans le temps.';

  @override
  String get landingAgileSectionBadge => 'Méthodologies';

  @override
  String get landingAgileSectionTitle => 'Framework Agile & Scrum';

  @override
  String get landingAgileSectionSubtitle =>
      'Implémentez les meilleures pratiques du développement logiciel itératif';

  @override
  String get landingSmartTodoCollabTitle => 'Listes de tâches collaboratives';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo transforme la gestion quotidienne des tâches en un processus fluide et collaboratif. Créez des listes, assignez des tâches aux membres de l\'équipe et suivez la progression en temps réel.\n\nIdéal pour les équipes distribuées nécessitant une synchronisation continue sur les tâches à accomplir.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Création rapide de tâches avec description\nAssignation aux membres de l\'équipe\nPriorités et échéances configurables\nNotifications de complétion';

  @override
  String get landingSmartTodoImportFeatures =>
      'Import depuis fichier CSV\nCopier/coller depuis Excel\nAnalyse intelligente du texte\nMapping automatique des champs';

  @override
  String get landingSmartTodoSharingTitle => 'Partage et invitations';

  @override
  String get landingSmartTodoSharingDesc =>
      'Invitez collègues et collaborateurs à vos listes par email. Chaque participant peut voir, commenter et mettre à jour le statut des tâches assignées.\n\nParfait pour gérer des projets transverses avec des parties prenantes externes ou des équipes.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Invitations par email\nPermissions configurables\nCommentaires sur les tâches\nHistorique des modifications';

  @override
  String get landingSmartTodoChipFilters => 'Filtres avancés';

  @override
  String get landingSmartTodoChipSearch => 'Recherche plein texte';

  @override
  String get landingSmartTodoChipSort => 'Tri';

  @override
  String get landingSmartTodoChipTags => 'Tags et catégories';

  @override
  String get landingSmartTodoChipArchive => 'Archivage';

  @override
  String get landingSmartTodoChipExport => 'Export des données';

  @override
  String get landingEisenhowerTitle => 'Matrice Eisenhower';

  @override
  String get landingEisenhowerUrgentTitle => 'Urgent vs Important';

  @override
  String get landingEisenhowerUrgentDesc =>
      'La Matrice Eisenhower, conçue par le 34e président des États-Unis Dwight D. Eisenhower, divise les activités en quatre quadrants basés sur deux critères : urgence et importance.\n\nCe cadre de décision aide à distinguer ce qui nécessite une attention immédiate de ce qui contribue aux objectifs à long terme.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Quadrant 1 : Urgent + Important → Faire d\'abord\nQuadrant 2 : Non urgent + Important → Planifier\nQuadrant 3 : Urgent + Non important → Déléguer\nQuadrant 4 : Non urgent + Non important → Ne pas faire';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Glisser-déposer intuitif\nCollaboration d\'équipe en temps réel\nStatistiques de distribution\nExport pour rapports';

  @override
  String get landingEisenhowerUrgentLabel => 'URGENT';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NON URGENT';

  @override
  String get landingEisenhowerImportantLabel => 'IMPORTANT';

  @override
  String get landingEisenhowerNotImportantLabel => 'NON IMPORTANT';

  @override
  String get landingEisenhowerDoLabel => 'FAIRE';

  @override
  String get landingEisenhowerDoDesc => 'Crises, échéances, urgences';

  @override
  String get landingEisenhowerPlanLabel => 'PLANIFIER';

  @override
  String get landingEisenhowerPlanDesc => 'Stratégie, croissance, relations';

  @override
  String get landingEisenhowerDelegateLabel => 'DÉLÉGUER';

  @override
  String get landingEisenhowerDelegateDesc => 'Interruptions, réunions, emails';

  @override
  String get landingEisenhowerEliminateLabel => 'ÉLIMINER';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Distractions, réseaux sociaux, pertes de temps';

  @override
  String get landingFooterFeatures => 'Fonctionnalités';

  @override
  String get landingFooterPricing => 'Tarifs';

  @override
  String get landingFooterChangelog => 'Journal des modifications';

  @override
  String get landingFooterRoadmap => 'Feuille de route';

  @override
  String get landingFooterDocs => 'Documentation';

  @override
  String get landingFooterAgileGuides => 'Guides Agile';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Communauté';

  @override
  String get landingFooterAbout => 'À propos';

  @override
  String get landingFooterContact => 'Contact';

  @override
  String get landingFooterJobs => 'Carrières';

  @override
  String get landingFooterPress => 'Kit presse';

  @override
  String get landingFooterPrivacy => 'Politique de confidentialité';

  @override
  String get landingFooterTerms => 'Conditions d\'utilisation';

  @override
  String get landingFooterCookies => 'Politique des cookies';

  @override
  String get landingFooterGdpr => 'RGPD';

  @override
  String get legalCookieTitle => 'Nous utilisons des cookies';

  @override
  String get legalCookieMessage =>
      'Nous utilisons des cookies pour améliorer votre expérience et à des fins analytiques. En continuant, vous acceptez l\'utilisation des cookies.';

  @override
  String get legalCookieAccept => 'Tout accepter';

  @override
  String get legalCookieRefuse => 'Nécessaires uniquement';

  @override
  String get legalCookiePolicy => 'Politique des cookies';

  @override
  String get legalPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get legalTermsOfService => 'Conditions d\'utilisation';

  @override
  String get legalGDPR => 'RGPD';

  @override
  String get legalLastUpdatedLabel => 'Dernière mise à jour';

  @override
  String get legalLastUpdatedDate => '18 janvier 2026';

  @override
  String get legalAcceptTerms =>
      'J\'accepte les Conditions d\'utilisation et la Politique de confidentialité';

  @override
  String get legalMustAcceptTerms =>
      'Vous devez accepter les conditions pour continuer';

  @override
  String get legalPrivacyContent =>
      '## 1. Introduction\nBienvenue sur **Keisen** (\"nous\", \"notre\", \"la Plateforme\"). Votre vie privée est importante pour nous. Cette Politique de confidentialité explique comment nous collectons, utilisons, divulguons et protégeons vos informations lorsque vous utilisez notre application web.\n\n## 2. Informations que nous collectons\nNous collectons deux types de données et d\'informations :\n\n### 2.1 Informations fournies par l\'utilisateur\n- **Données de compte :** Lorsque vous vous connectez via Google Sign-In ou créez un compte, nous collectons votre nom, votre adresse e-mail et votre photo de profil.\n- **Contenu utilisateur :** Nous collectons les données que vous saisissez volontairement sur la plateforme, y compris les tâches, les estimations, les rétrospectives, les commentaires et les configurations d\'équipe.\n\n### 2.2 Informations collectées automatiquement\n- **Journaux système :** Adresses IP, type de navigateur, pages visitées et horodatages.\n- **Cookies :** Nous utilisons des cookies techniques essentiels pour maintenir votre session active.\n\n## 3. Comment nous utilisons vos informations\nNous utilisons les informations collectées pour :\n- Fournir, exploiter et maintenir nos Services.\n- Améliorer, personnaliser et étendre notre Plateforme.\n- Analyser comment vous utilisez le site web pour améliorer l\'expérience utilisateur.\n- Vous envoyer des e-mails de service (par ex., invitations d\'équipe, mises à jour importantes).\n\n## 4. Partage d\'informations\nNous ne vendons pas vos données personnelles. Nous partageons les informations uniquement avec :\n- **Prestataires de services :** Nous utilisons **Google Firebase** (Google LLC) pour l\'hébergement, l\'authentification et les services de base de données. Les données sont traitées conformément à la [Politique de confidentialité de Google](https://policies.google.com/privacy).\n- **Obligations légales :** Si la loi l\'exige ou pour protéger nos droits.\n\n## 5. Sécurité des données\nNous mettons en œuvre des mesures de sécurité techniques et organisationnelles conformes aux normes de l\'industrie (telles que le chiffrement en transit) pour protéger vos données. Cependant, aucune méthode de transmission sur Internet n\'est sûre à 100 %.\n\n## 6. Vos droits\nVous avez le droit de :\n- Accéder à vos données personnelles.\n- Demander la correction de données inexactes.\n- Demander la suppression de vos données (\"Droit à l\'oubli\").\n- Vous opposer au traitement de vos données.\n\nPour exercer ces droits, contactez-nous à : suppkesien@gmail.com.\n\n## 7. Modifications de cette Politique\nNous pouvons mettre à jour cette Politique de confidentialité de temps à autre. Nous vous informerons de tout changement en publiant la nouvelle Politique sur cette page.';

  @override
  String get legalTermsContent =>
      '## 1. Acceptation des conditions\nEn accédant ou en utilisant **Keisen**, vous acceptez d\'être lié par ces Conditions d\'utilisation (\"Conditions\"). Si vous n\'acceptez pas ces Conditions, vous ne devez pas utiliser nos Services.\n\n## 2. Description du service\nKeisen est une plateforme de collaboration pour les équipes agiles proposant des outils tels que Smart Todo, la Matrice d\'Eisenhower, l\'Estimation Room et la gestion des processus agiles. Nous nous réservons le droit de modifier ou d\'interrompre le service à tout moment.\n\n## 3. Comptes utilisateurs\nVous êtes responsable du maintien de la confidentialité de vos identifiants de compte et de toutes les activités qui se produisent sous votre compte. Nous nous réservons le droit de suspendre ou de supprimer les comptes qui violent ces Conditions.\n\n## 4. Conduite de l\'utilisateur\nVous acceptez de ne pas utiliser le Service pour :\n- Violer les lois locales, nationales ou internationales.\n- Télécharger du contenu offensant, diffamatoire ou illégal.\n- Tenter d\'accéder sans autorisation aux systèmes de la Plateforme.\n\n## 5. Propriété intellectuelle\nTous les droits de propriété intellectuelle liés à la Plateforme et à son contenu original (à l\'exclusion du contenu fourni par l\'utilisateur) sont la propriété exclusive de Leonardo Torella.\n\n## 6. Limitation de responsabilité\nDans la mesure maximale permise par la loi, Keisen est fourni \"en l\'état\" et \"selon disponibilité\". Nous ne garantissons pas que le service sera ininterrompu ou sans erreur. Nous ne serons pas responsables des dommages indirects, accessoires ou consécutifs résultant de l\'utilisation du service.\n\n## 7. Loi applicable\nCes Conditions sont régies par les lois de l\'État italien.\n\n## 8. Contacts\nPour toute question concernant ces Conditions, contactez-nous à : suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. Que sont les cookies ?\nLes cookies sont de petits fichiers texte enregistrés sur votre appareil lorsque vous visitez un site web. Ils sont largement utilisés pour faire fonctionner les sites web plus efficacement et fournir des informations aux propriétaires du site.\n\n## 2. Comment nous utilisons les cookies\nNous utilisons des cookies à plusieurs fins :\n\n### 2.1 Cookies techniques (essentiels)\nCes cookies sont nécessaires au fonctionnement du site web et ne peuvent pas être désactivés dans nos systèmes. Ils ne sont généralement définis qu\'en réponse à des actions que vous effectuez et qui constituent une demande de services, telles que le paramétrage de vos préférences de confidentialité, la connexion ou le remplissage de formulaires.\n*Exemple :* Cookies de session Firebase Auth pour maintenir l\'utilisateur connecté.\n\n### 2.2 Cookies analytiques\nCes cookies nous permettent de compter les visites et les sources de trafic afin de mesurer et d\'améliorer les performances de notre site. Toutes les informations collectées par ces cookies sont agrégées et donc anonymes.\n\n## 3. Gestion des cookies\nLa plupart des navigateurs web vous permettent de contrôler la plupart des cookies via les paramètres du navigateur. Cependant, si vous désactivez les cookies essentiels, certaines parties de notre Service pourraient ne pas fonctionner correctement (par exemple, vous ne pourrez pas vous connecter).\n\n## 4. Cookies tiers\nNous utilisons des services tiers comme **Google Firebase** qui peuvent définir leurs propres cookies. Nous vous encourageons à consulter leurs politiques de confidentialité respectives pour plus de détails.';

  @override
  String get legalGdprContent =>
      '## Engagement pour la protection des données (RGPD)\nConformément au Règlement général sur la protection des données (RGPD) de l\'Union européenne, Keisen s\'engage à protéger les données personnelles des utilisateurs et à garantir la transparence de leur traitement.\n\n## Responsable du traitement\nLe responsable du traitement est :\n**Keisen Team**\nE-mail : suppkesien@gmail.com\n\n## Base légale du traitement\nNous ne traitons vos données personnelles que lorsque nous avons une base légale pour le faire. Cela inclut :\n- **Consentement :** Vous nous avez donné la permission de traiter vos données dans un but spécifique.\n- **Exécution d\'un contrat :** Le traitement est nécessaire pour fournir les Services que vous avez demandés (par ex., utilisation de la plateforme).\n- **Intérêt légitime :** Le traitement est nécessaire à nos intérêts légitimes (par ex., sécurité, amélioration du service), à moins que vos droits et libertés fondamentaux ne prévalent sur ces intérêts.\n\n## Transfert de données\nVos données sont stockées sur des serveurs sécurisés fournis par Google Cloud Platform (Google Firebase). Google adhère aux normes de sécurité internationales et se conforme au RGPD via des clauses contractuelles types (CCT).\n\n## Vos droits RGPD\nEn tant qu\'utilisateur dans l\'UE, vous avez les droits suivants :\n1.  **Droit d\'accès :** Vous avez le droit de demander des copies de vos données personnelles.\n2.  **Droit de rectification :** Vous avez le droit de demander la correction d\'informations que vous jugez inexactes.\n3.  **Droit à l\'effacement (\"Droit à l\'oubli\") :** Vous avez le droit de demander la suppression de vos données personnelles, sous certaines conditions.\n4.  **Droit à la limitation du traitement :** Vous avez le droit de demander la limitation du traitement de vos données.\n5.  **Droit à la portabilité des données :** Vous avez le droit de demander le transfert des données que nous avons collectées à une autre organisation ou directement à vous.\n\n## Exercice des droits\nSi vous souhaitez exercer l\'un de ces droits, veuillez nous contacter à : suppkesien@gmail.com. Nous répondrons à votre demande dans un délai d\'un mois.';

  @override
  String get profilePrivacy => 'Confidentialité';

  @override
  String get profileExportData => 'Exporter mes données';

  @override
  String get profileDeleteAccountConfirm =>
      'Êtes-vous sûr de vouloir supprimer définitivement votre compte ? Cette action est irréversible.';

  @override
  String get subscriptionTitle => 'Abonnement';

  @override
  String get subscriptionTabPlans => 'Plans';

  @override
  String get subscriptionTabUsage => 'Utilisation';

  @override
  String get subscriptionTabBilling => 'Facturation';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count projets actifs';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count listes Smart Todo';
  }

  @override
  String get subscriptionCurrentPlan => 'Plan actuel';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Passer à $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Rétrograder vers $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Choisir $plan';
  }

  @override
  String get subscriptionMonthly => 'Mensuel';

  @override
  String get subscriptionYearly => 'Annuel (-17%)';

  @override
  String get subscriptionLimitReached => 'Limite atteinte';

  @override
  String get subscriptionLimitProjects =>
      'Vous avez atteint le nombre maximum de projets pour votre plan. Passez à Premium pour créer plus de projets.';

  @override
  String get subscriptionLimitLists =>
      'Vous avez atteint le nombre maximum de listes pour votre plan. Passez à Premium pour créer plus de listes.';

  @override
  String get subscriptionLimitTasks =>
      'Vous avez atteint le nombre maximum de tâches pour ce projet. Passez à Premium pour ajouter plus de tâches.';

  @override
  String get subscriptionLimitInvites =>
      'Vous avez atteint le nombre maximum d\'invitations pour ce projet. Passez à Premium pour inviter plus de personnes.';

  @override
  String get subscriptionLimitEstimations =>
      'Vous avez atteint le nombre maximum de sessions d\'estimation. Passez à Premium pour en créer plus.';

  @override
  String get subscriptionLimitRetrospectives =>
      'Vous avez atteint le nombre maximum de rétrospectives. Passez à Premium pour en créer plus.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Vous avez atteint le nombre maximum de projets Agile. Passez à Premium pour en créer plus.';

  @override
  String get subscriptionLimitDefault =>
      'Vous avez atteint la limite de votre plan actuel.';

  @override
  String get subscriptionCurrentUsage => 'Utilisation actuelle';

  @override
  String get subscriptionUpgradeToPremium => 'Passer à Premium';

  @override
  String get subscriptionBenefitProjects => '30 projets actifs';

  @override
  String get subscriptionBenefitLists => '30 listes Smart Todo';

  @override
  String get subscriptionBenefitTasks => '100 tâches par projet';

  @override
  String get subscriptionBenefitNoAds => 'Sans publicités';

  @override
  String get subscriptionStartingFrom => 'À partir de 4,99 €/mois';

  @override
  String get subscriptionLater => 'Plus tard';

  @override
  String get subscriptionViewPlans => 'Voir les plans';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Vous pouvez créer 1 $entity supplémentaire';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Vous pouvez créer $count $entity supplémentaires';
  }

  @override
  String get subscriptionUpgrade => 'AMÉLIORER';

  @override
  String subscriptionUsed(int count) {
    return 'Utilisé : $count';
  }

  @override
  String get subscriptionUnlimited => 'Illimité';

  @override
  String subscriptionLimit(int count) {
    return 'Limite : $count';
  }

  @override
  String get subscriptionPlanUsage => 'Utilisation du plan';

  @override
  String get subscriptionRefresh => 'Actualiser';

  @override
  String get subscriptionAdsActive => 'Publicités actives';

  @override
  String get subscriptionRemoveAds =>
      'Passez à Premium pour supprimer les publicités';

  @override
  String get subscriptionNoAds => 'Sans publicités';

  @override
  String get subscriptionLoadError =>
      'Impossible de charger les données d\'utilisation';

  @override
  String get subscriptionAdLabel => 'PUB';

  @override
  String get subscriptionAdPlaceholder => 'Espace publicitaire';

  @override
  String get subscriptionDevEnvironment => '(Environnement de développement)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Supprimez les publicités et débloquez les fonctionnalités avancées';

  @override
  String get subscriptionUpgradeButton => 'Améliorer';

  @override
  String subscriptionLoadingError(String error) {
    return 'Erreur de chargement : $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Complétez le paiement dans la fenêtre ouverte';

  @override
  String subscriptionError(String error) {
    return 'Erreur : $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Confirmer la rétrogradation';

  @override
  String get subscriptionDowngradeMessage =>
      'Êtes-vous sûr de vouloir passer au plan Gratuit ?\n\nVotre abonnement restera actif jusqu\'à la fin de la période en cours, après quoi vous passerez automatiquement au plan Gratuit.\n\nVous ne perdrez pas vos données, mais certaines fonctionnalités peuvent être limitées.';

  @override
  String get subscriptionCancel => 'Annuler';

  @override
  String get subscriptionConfirmDowngradeButton =>
      'Confirmer la rétrogradation';

  @override
  String get subscriptionCancelled =>
      'Abonnement annulé. Il restera actif jusqu\'à la fin de la période.';

  @override
  String subscriptionPortalError(String error) {
    return 'Erreur d\'ouverture du portail : $error';
  }

  @override
  String get subscriptionRetry => 'Réessayer';

  @override
  String get subscriptionChooseRightPlan =>
      'Choisissez le plan qui vous convient';

  @override
  String get subscriptionStartFree =>
      'Commencez gratuitement, améliorez quand vous voulez';

  @override
  String subscriptionPlan(String plan) {
    return 'Plan $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Plan actuel : $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Essai jusqu\'au $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Renouvellement : $date';
  }

  @override
  String get subscriptionManage => 'Gérer';

  @override
  String get subscriptionLoginRequired =>
      'Veuillez vous connecter pour voir l\'utilisation';

  @override
  String get subscriptionSuggestion => 'Suggestion';

  @override
  String get subscriptionSuggestionText =>
      'Passez à Premium pour débloquer plus de projets, supprimer les publicités et augmenter les limites. Essayez gratuitement pendant 7 jours !';

  @override
  String get subscriptionPaymentManagement => 'Gestion des paiements';

  @override
  String get subscriptionNoActiveSubscription => 'Aucun abonnement actif';

  @override
  String get subscriptionUsingFreePlan => 'Vous utilisez le plan Gratuit';

  @override
  String get subscriptionViewPaidPlans => 'Voir les plans payants';

  @override
  String get subscriptionPaymentMethod => 'Méthode de paiement';

  @override
  String get subscriptionEditPaymentMethod =>
      'Modifier la carte ou la méthode de paiement';

  @override
  String get subscriptionInvoices => 'Factures';

  @override
  String get subscriptionViewInvoices => 'Voir et télécharger les factures';

  @override
  String get subscriptionCancelSubscription => 'Annuler l\'abonnement';

  @override
  String get subscriptionAccessUntilEnd =>
      'L\'accès restera actif jusqu\'à la fin de la période';

  @override
  String get subscriptionPaymentHistory => 'Historique des paiements';

  @override
  String get subscriptionNoPayments => 'Aucun paiement enregistré';

  @override
  String get subscriptionCompleted => 'Terminé';

  @override
  String get subscriptionDateNotAvailable => 'Date non disponible';

  @override
  String get subscriptionFaq => 'Questions fréquentes';

  @override
  String get subscriptionFaqCancel => 'Puis-je annuler à tout moment ?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Oui, vous pouvez annuler votre abonnement à tout moment. L\'accès restera actif jusqu\'à la fin de la période payée.';

  @override
  String get subscriptionFaqTrial => 'Comment fonctionne l\'essai gratuit ?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Avec l\'essai gratuit, vous avez un accès complet à toutes les fonctionnalités du plan choisi. À la fin de la période d\'essai, l\'abonnement payant démarrera automatiquement.';

  @override
  String get subscriptionFaqChange => 'Puis-je changer de plan ?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Vous pouvez améliorer ou rétrograder à tout moment. Le montant sera calculé au prorata.';

  @override
  String get subscriptionFaqData => 'Mes données sont-elles en sécurité ?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Absolument oui. Vous ne perdrez jamais vos données, même si vous passez à un plan inférieur. Certaines fonctionnalités peuvent être limitées, mais les données restent toujours accessibles.';

  @override
  String get subscriptionStatusActive => 'Actif';

  @override
  String get subscriptionStatusTrialing => 'Période d\'essai';

  @override
  String get subscriptionStatusPastDue => 'Paiement en retard';

  @override
  String get subscriptionStatusCancelled => 'Annulé';

  @override
  String get subscriptionStatusExpired => 'Expiré';

  @override
  String get subscriptionStatusPaused => 'En pause';

  @override
  String get subscriptionStatus => 'Statut';

  @override
  String get subscriptionStarted => 'Démarré';

  @override
  String get subscriptionNextRenewal => 'Prochain renouvellement';

  @override
  String get subscriptionTrialEnd => 'Fin de l\'essai';

  @override
  String get toolSectionTitle => 'Outils';

  @override
  String get deadlineTitle => 'Échéances';

  @override
  String get deadlineNoUpcoming => 'Aucune échéance à venir';

  @override
  String get deadlineAll => 'Tous';

  @override
  String get deadlineToday => 'Aujourd\'hui';

  @override
  String get deadlineTomorrow => 'Demain';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Tâche';

  @override
  String get favTitle => 'Favoris';

  @override
  String get favFilterAll => 'Tous';

  @override
  String get favFilterTodo => 'Listes Todo';

  @override
  String get favFilterMatrix => 'Matrices';

  @override
  String get favFilterProject => 'Projets';

  @override
  String get favFilterPoker => 'Estimation';

  @override
  String get actionRemoveFromFavorites => 'Retirer des favoris';

  @override
  String get favFilterRetro => 'Rétro';

  @override
  String get favNoFavorites => 'Aucun favori trouvé';

  @override
  String get favTypeTodo => 'Liste Todo';

  @override
  String get favTypeMatrix => 'Matrice Eisenhower';

  @override
  String get favTypeProject => 'Projet Agile';

  @override
  String get favTypeRetro => 'Rétrospective';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Outil';

  @override
  String get deadline2Days => '2 jours';

  @override
  String get deadline3Days => '3 jours';

  @override
  String get deadline5Days => '5 jours';

  @override
  String get deadlineConfigTitle => 'Configurer les raccourcis';

  @override
  String get deadlineConfigDesc =>
      'Choisissez les périodes à afficher dans l\'en-tête.';

  @override
  String get smartTodoClose => 'Fermer';

  @override
  String get smartTodoDone => 'Terminé';

  @override
  String get smartTodoAdd => 'Ajouter';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Connexion Google requise pour envoyer des e-mails';

  @override
  String get exceptionUserNotAuthenticated => 'Utilisateur non authentifié';

  @override
  String errorLoginFailed(String error) {
    return 'Erreur de connexion : $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Participants ($count)';
  }

  @override
  String get actionReopen => 'Rouvrir';

  @override
  String get retroWaitingForFacilitator =>
      'En attente du facilitateur pour démarrer la session...';

  @override
  String get retroGeneratingSheet => 'Génération de la feuille Google...';

  @override
  String get retroExportSuccess => 'Exportation terminée !';

  @override
  String get retroExportSuccessMessage =>
      'La tua retrospettiva è stata esportata su Google Sheets.';

  @override
  String get retroExportError => 'Erreur lors de l\'exportation vers Sheets.';

  @override
  String get retroReportCopied =>
      'Rapport copié dans le presse-papiers ! Collez-le dans Excel ou Notes.';

  @override
  String get retroReopenTitle => 'Rouvrir la Rétrospective';

  @override
  String get retroReopenConfirm =>
      'Êtes-vous sûr de vouloir rouvrir la rétrospective ? Elle retournera à la phase de Discussion.';

  @override
  String get errorAuthRequired => 'Authentification requise';

  @override
  String get errorRetroIdMissing => 'ID de rétrospective manquant';

  @override
  String get pokerInviteAccepted =>
      'Invitation acceptée ! Redirection vers la session.';

  @override
  String get pokerInviteRefused => 'Invitation refusée';

  @override
  String get pokerConfirmRefuseTitle => 'Refuser l\'Invitation';

  @override
  String get pokerConfirmRefuseContent =>
      'Êtes-vous sûr de vouloir refuser cette invitation ?';

  @override
  String get pokerVerifyingInvite => 'Vérification de l\'invitation...';

  @override
  String get actionBackHome => 'Retour à l\'Accueil';

  @override
  String get actionSignin => 'Se Connecter';

  @override
  String get exceptionStoryNotFound => 'Histoire introuvable';

  @override
  String get exceptionNoTasksInProject => 'Aucune tâche trouvée dans le projet';

  @override
  String get exceptionInvitePending =>
      'Une invitation est déjà en attente pour cet e-mail';

  @override
  String get exceptionAlreadyParticipant =>
      'L\'utilisateur est déjà un participant';

  @override
  String get exceptionInviteInvalid => 'Invitation invalide ou expirée';

  @override
  String get exceptionInviteCalculated => 'Invitation expirée';

  @override
  String get exceptionInviteWrongUser =>
      'Invitation destinée à un autre utilisateur';

  @override
  String get todoImportTasks => 'Importer des Tâches';

  @override
  String get todoExportSheets => 'Exporter vers Sheets';

  @override
  String get todoDeleteColumnTitle => 'Supprimer la Colonne';

  @override
  String get todoDeleteColumnConfirm =>
      'Êtes-vous sûr ? Les tâches de cette colonne seront perdues.';

  @override
  String get exceptionListNotFound => 'Liste introuvable';

  @override
  String get langItalian => 'Italiano';

  @override
  String get langEnglish => 'English';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get jsonExportLabel => 'Télécharger une copie JSON de vos données';

  @override
  String errorExporting(String error) {
    return 'Erreur lors de l\'exportation : $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Liste';

  @override
  String get smartTodoViewResource => 'Par Ressource';

  @override
  String get smartTodoInviteTooltip => 'Inviter';

  @override
  String get smartTodoOptionsTooltip => 'Plus d\'options';

  @override
  String get smartTodoActionImport => 'Importer des tâches';

  @override
  String get smartTodoActionExportSheets => 'Exporter vers Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Supprimer la colonne';

  @override
  String get smartTodoDeleteColumnContent =>
      'Êtes-vous sûr ? Les tâches de cette colonne ne seront plus visibles.';

  @override
  String get smartTodoNewColumn => 'Nouvelle colonne';

  @override
  String get smartTodoColumnNameHint => 'Nom de la colonne';

  @override
  String get smartTodoColorLabel => 'COULEUR';

  @override
  String get smartTodoMarkAsDone => 'Marquer comme fait';

  @override
  String get smartTodoColumnDoneDescription =>
      'Les tâches de cette colonne seront considérées comme \'Faites\' (barrées).';

  @override
  String get smartTodoListSettingsTitle => 'Paramètres de la liste';

  @override
  String get smartTodoRenameList => 'Renommer la liste';

  @override
  String get smartTodoManageTags => 'Gérer les étiquettes';

  @override
  String get smartTodoDeleteList => 'Supprimer la liste';

  @override
  String get smartTodoEditPermissionError =>
      'Vous ne pouvez modifier que les tâches qui vous sont assignées';

  @override
  String errorDeletingAccount(String error) {
    return 'Erreur lors de la suppression du compte : $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Connexion récente requise. Veuillez vous déconnecter et vous reconnecter avant de supprimer votre compte.';

  @override
  String actionGuide(String framework) {
    return 'Guide $framework';
  }

  @override
  String get actionExportSheets => 'Exporter vers Google Sheets';

  @override
  String get actionAuditLog => 'Journal d\'audit';

  @override
  String get actionInviteMember => 'Inviter un membre';

  @override
  String get actionSettings => 'Paramètres';

  @override
  String get retroSelectIcebreakerTooltip =>
      'Sélectionnez l\'activité brise-glace';

  @override
  String get retroIcebreakerLabel => 'Activité initiale';

  @override
  String get retroTimePhasesOptional => 'Minuteurs de Phase (Optionnel)';

  @override
  String get retroTimePhasesDesc =>
      'Définir la durée en minutes pour chaque phase :';

  @override
  String get retroIcebreakerSectionTitle => 'Brise-glace';

  @override
  String get retroBoardTitle => 'Tableau Rétrospectives';

  @override
  String get searchPlaceholder => 'Rechercher partout...';

  @override
  String get searchResultsTitle => 'Résultats de Recherche';

  @override
  String searchNoResults(Object query) {
    return 'Aucun résultat pour \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Projet';

  @override
  String get searchResultTypeTodo => 'Liste ToDo';

  @override
  String get searchResultTypeRetro => 'Rétrospective';

  @override
  String get searchResultTypeEisenhower => 'Matrice Eisenhower';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Retour au Tableau de bord';

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
  String get exportToEstimation => 'Exporter vers l\'estimation';

  @override
  String get exportToEstimationDesc =>
      'Créer une session d\'estimation avec ces tâches';

  @override
  String get exportToEisenhower => 'Envoyer à Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Créer une matrice Eisenhower avec ces tâches';

  @override
  String get selectTasksToExport => 'Sélectionner les Tâches';

  @override
  String get selectTasksToExportDesc => 'Choisir les tâches à inclure';

  @override
  String get noTasksSelected => 'Aucune tâche sélectionnée';

  @override
  String get selectAtLeastOne => 'Sélectionnez au moins une tâche';

  @override
  String get createEstimationSession => 'Créer Session d\'Estimation';

  @override
  String tasksSelectedCount(int count) {
    return '$count tâche(s) sélectionnée(s)';
  }

  @override
  String get exportSuccess => 'Exporté avec succès';

  @override
  String get exportFromEstimation => 'Exporter vers Liste';

  @override
  String get exportFromEstimationDesc =>
      'Exporter les histoires estimées vers une liste Smart Todo';

  @override
  String get selectDestinationList => 'Sélectionner la liste de destination';

  @override
  String get createNewList => 'Créer une nouvelle liste';

  @override
  String get existingList => 'Liste existante';

  @override
  String get listName => 'Nom de la liste';

  @override
  String get listNameHint => 'Entrez un nom pour la nouvelle liste';

  @override
  String get selectList => 'Sélectionner une liste';

  @override
  String get selectListHint => 'Choisissez une liste';

  @override
  String get noListsAvailable =>
      'Aucune liste disponible. Une nouvelle sera créée.';

  @override
  String storiesSelectedCount(int count) {
    return '$count histoire(s) sélectionnée(s)';
  }

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get deselectAll => 'Tout désélectionner';

  @override
  String get importStories => 'Importer Histoires';

  @override
  String storiesImportedCount(int count) {
    return '$count histoire(s) importée(s)';
  }

  @override
  String get noEstimatedStories =>
      'Aucune histoire avec estimations à importer';

  @override
  String get selectDestinationMatrix => 'Sélectionner Matrice Destination';

  @override
  String get existingMatrix => 'Matrice Existante';

  @override
  String get createNewMatrix => 'Créer Nouvelle Matrice';

  @override
  String get matrixName => 'Nom de la Matrice';

  @override
  String get matrixNameHint => 'Entrez un nom pour la nouvelle matrice';

  @override
  String get selectMatrix => 'Sélectionner Matrice';

  @override
  String get selectMatrixHint => 'Choisissez une matrice de destination';

  @override
  String get noMatricesAvailable =>
      'Aucune matrice disponible. Créez-en une nouvelle.';

  @override
  String activitiesCreated(int count) {
    return '$count activités créées';
  }

  @override
  String get importFromEisenhower => 'Importer depuis Eisenhower';

  @override
  String get importFromEisenhowerDesc =>
      'Ajouter les tâches priorisées à cette liste';

  @override
  String get quadrantQ1 => 'Urgent et Important';

  @override
  String get quadrantQ2 => 'Non Urgent et Important';

  @override
  String get quadrantQ3 => 'Urgent et Non Important';

  @override
  String get quadrantQ4 => 'Non Urgent et Non Important';

  @override
  String get warningQ4Tasks =>
      'Les tâches Q4 ne valent généralement pas la peine. Êtes-vous sûr ?';

  @override
  String get priorityMappingInfo =>
      'Mapping priorité : Q1=Haute, Q2=Moyenne, Q3/Q4=Basse';

  @override
  String get selectColumns => 'Sélectionner Colonnes';

  @override
  String get allTasks => 'Toutes les Tâches';

  @override
  String get filterByColumn => 'Filtrer par colonne';

  @override
  String get exportFromEisenhower => 'Exporter depuis Eisenhower';

  @override
  String get exportFromEisenhowerDesc =>
      'Sélectionnez les activités à exporter vers Smart Todo';

  @override
  String get filterByQuadrant => 'Filtrer par quadrant :';

  @override
  String get allActivities => 'Toutes';

  @override
  String activitiesSelectedCount(int count) {
    return '$count activités sélectionnées';
  }

  @override
  String get noActivitiesSelected => 'Aucune activité dans ce filtre';

  @override
  String get unvoted => 'NON VOTÉ';

  @override
  String tasksCreated(int count) {
    return '$count tâches créées';
  }

  @override
  String get exportToUserStories => 'Exporter vers User Stories';

  @override
  String get exportToUserStoriesDesc =>
      'Créer des user stories dans un projet Agile';

  @override
  String get selectDestinationProject => 'Sélectionner Projet Destination';

  @override
  String get existingProject => 'Projet existant';

  @override
  String get createNewProject => 'Créer un nouveau projet';

  @override
  String get projectName => 'Nom du Projet';

  @override
  String get projectNameHint => 'Entrez un nom pour le nouveau projet';

  @override
  String get selectProject => 'Sélectionner un projet';

  @override
  String get selectProjectHint => 'Choisissez un projet de destination';

  @override
  String get noProjectsAvailable =>
      'Aucun projet disponible. Créez-en un nouveau.';

  @override
  String get userStoryFieldMappingInfo =>
      'Mapping : Titre → Titre story, Description → Description story, Effort → Story points, Priorité → Business value';

  @override
  String storiesCreated(int count) {
    return '$count stories créées';
  }

  @override
  String get configureNewProject => 'Configurer un nouveau projet';

  @override
  String get exportToAgileSprint => 'Exporter vers Sprint';

  @override
  String get exportToAgileSprintDesc =>
      'Ajouter les stories estimées à un sprint Agile';

  @override
  String get selectSprint => 'Sélectionner un sprint';

  @override
  String get selectSprintHint => 'Choisissez un sprint de destination';

  @override
  String get noSprintsAvailable =>
      'Aucun sprint disponible. Créez d\'abord un sprint en planification.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Mapping : Titre → Titre story, Description → Description, Estimation → Story points';

  @override
  String get exportToSprint => 'Exporter vers le sprint';

  @override
  String totalStoryPoints(int count) {
    return '$count story points au total';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count stories ajoutées à $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count stories ajoutées au projet $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Transformez les activités Eisenhower en User Stories';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Créer une session d\'estimation à partir des activités';

  @override
  String get selectedActivities => 'activités sélectionnées';

  @override
  String get noActivitiesToExport => 'Aucune activité à exporter';

  @override
  String get hiddenQ4Activities => 'Masquées';

  @override
  String get q4Activities => 'activités Q4 (Supprimer)';

  @override
  String get showQ4 => 'Afficher Q4';

  @override
  String get hideQ4 => 'Masquer Q4';

  @override
  String get showingAllActivities => 'Affichage de toutes les activités';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importance→Business Value.';

  @override
  String get estimationExportInfo =>
      'Les activités seront ajoutées comme stories à estimer. La priorité Q ne sera pas transférée.';

  @override
  String get createSession => 'Créer Session';

  @override
  String get estimationType => 'Type d\'estimation';

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
    return '$count activités exportées vers le sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count activités exportées vers la session d\'estimation $sessionName';
  }

  @override
  String get archiveAction => 'Archiver';

  @override
  String get archiveRestoreAction => 'Restaurer';

  @override
  String get archiveShowArchived => 'Afficher les archivés';

  @override
  String get archiveHideArchived => 'Masquer les archivés';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Archiver $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Êtes-vous sûr de vouloir archiver cet élément ? Il pourra être restauré ultérieurement.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Restaurer $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Voulez-vous restaurer cet élément des archives ?';

  @override
  String get archiveSuccessMessage => 'Élément archivé avec succès';

  @override
  String get archiveRestoreSuccessMessage => 'Élément restauré avec succès';

  @override
  String get archiveErrorMessage => 'Erreur lors de l\'archivage';

  @override
  String get archiveRestoreErrorMessage => 'Erreur lors de la restauration';

  @override
  String get archiveFilterLabel => 'Archives';

  @override
  String get archiveFilterActive => 'Actifs';

  @override
  String get archiveFilterArchived => 'Archivés';

  @override
  String get archiveFilterAll => 'Tous';

  @override
  String get archiveBadge => 'Archivé';

  @override
  String get archiveEmptyMessage => 'Aucun élément archivé';

  @override
  String get completeAction => 'Terminer';

  @override
  String get reopenAction => 'Rouvrir';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Terminer $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Êtes-vous sûr de vouloir terminer cet élément ?';

  @override
  String get completeSuccessMessage => 'Élément terminé avec succès';

  @override
  String get reopenSuccessMessage => 'Élément rouvert avec succès';

  @override
  String get completedBadge => 'Terminé';

  @override
  String get inviteNewInvite => 'NOUVELLE INVITATION';

  @override
  String get inviteRole => 'Rôle :';

  @override
  String get inviteSendEmailNotification =>
      'Envoyer une notification par email';

  @override
  String get inviteSendInvite => 'Envoyer l\'invitation';

  @override
  String get inviteLink => 'Lien d\'invitation :';

  @override
  String get inviteList => 'INVITATIONS';

  @override
  String get inviteResend => 'Renvoyer';

  @override
  String get inviteRevokeMessage => 'L\'invitation ne sera plus valide.';

  @override
  String get inviteResent => 'Invitation renvoyée';

  @override
  String inviteSentByEmail(String email) {
    return 'Invitation envoyée par email à $email';
  }

  @override
  String get inviteStatusPending => 'En attente';

  @override
  String get inviteStatusAccepted => 'Acceptée';

  @override
  String get inviteStatusDeclined => 'Refusée';

  @override
  String get inviteStatusExpired => 'Expirée';

  @override
  String get inviteStatusRevoked => 'Révoquée';

  @override
  String get inviteGmailAuthTitle => 'Autorisation Gmail';

  @override
  String get inviteGmailAuthMessage =>
      'Pour envoyer des emails d\'invitation, vous devez vous ré-authentifier avec Google.\n\nVoulez-vous continuer ?';

  @override
  String get inviteGmailAuthNo => 'Non, juste le lien';

  @override
  String get inviteGmailAuthYes => 'Autoriser';

  @override
  String get inviteGmailNotAvailable =>
      'Autorisation Gmail non disponible. Essayez de vous déconnecter et de vous reconnecter.';

  @override
  String get inviteGmailNoPermission => 'Permission Gmail non accordée.';

  @override
  String get inviteEnterEmail => 'Entrez un email';

  @override
  String get inviteInvalidEmail => 'Email invalide';

  @override
  String get pendingInvites => 'Invitations en attente';

  @override
  String get noPendingInvites => 'Aucune invitation en attente';

  @override
  String invitedBy(String name) {
    return 'Invité par $name';
  }

  @override
  String get inviteOpenInstance => 'Ouvrir';

  @override
  String get inviteAcceptFirst => 'Acceptez l\'invitation pour ouvrir';

  @override
  String get inviteAccept => 'Accepter';

  @override
  String get inviteDecline => 'Refuser';

  @override
  String get inviteAcceptedSuccess => 'Invitation acceptée avec succès !';

  @override
  String get inviteAcceptedError => 'Échec de l\'acceptation de l\'invitation';

  @override
  String get inviteDeclinedSuccess => 'Invitation refusée';

  @override
  String get inviteDeclinedError => 'Échec du refus de l\'invitation';

  @override
  String get inviteDeclineTitle => 'Refuser l\'invitation ?';

  @override
  String get inviteDeclineMessage =>
      'Êtes-vous sûr de vouloir refuser cette invitation ?';

  @override
  String expiresInHours(int hours) {
    return 'Expire dans ${hours}h';
  }

  @override
  String expiresInDays(int days) {
    return 'Expire dans ${days}j';
  }

  @override
  String get close => 'Fermer';

  @override
  String get cancel => 'Annuler';

  @override
  String get raciTitle => 'Matrice RACI';

  @override
  String get raciNoActivities => 'Aucune activité disponible';

  @override
  String get raciAddActivity => 'Ajouter une activité';

  @override
  String get raciAddColumn => 'Ajouter une colonne';

  @override
  String get raciActivities => 'ACTIVITÉS';

  @override
  String get raciAssignRole => 'Attribuer un rôle';

  @override
  String get raciNone => 'Aucun';

  @override
  String get raciSaving => 'Enregistrement...';

  @override
  String get raciSaveChanges => 'Enregistrer les modifications';

  @override
  String get raciSavedSuccessfully => 'Modifications enregistrées avec succès';

  @override
  String get raciErrorSaving => 'Erreur d\'enregistrement';

  @override
  String get raciMissingAccountable => 'Accountable (A) manquant';

  @override
  String get raciOnlyOneAccountable => 'Un seul Accountable par activité';

  @override
  String get raciDuplicateRoles => 'Rôles dupliqués';

  @override
  String get raciNoResponsible => 'Aucun Responsible (R) attribué';

  @override
  String get raciTooManyInformed =>
      'Trop d\'Informed (I) : envisagez de réduire';

  @override
  String get raciNewColumn => 'Nouvelle colonne';

  @override
  String get raciRemoveColumn => 'Supprimer la colonne';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Supprimer la colonne \"$name\" ? Toutes les attributions de rôles pour cette colonne seront supprimées.';
  }

  @override
  String get votingDialogTitle => 'Voter';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Vote de $participant';
  }

  @override
  String get votingDialogUrgency => 'URGENCE';

  @override
  String get votingDialogImportance => 'IMPORTANCE';

  @override
  String get votingDialogNotUrgent => 'Pas urgent';

  @override
  String get votingDialogVeryUrgent => 'Très urgent';

  @override
  String get votingDialogNotImportant => 'Pas important';

  @override
  String get votingDialogVeryImportant => 'Très important';

  @override
  String get votingDialogConfirmVote => 'Confirmer le vote';

  @override
  String get votingDialogQuadrant => 'Quadrant :';

  @override
  String get voteCollectionTitle => 'Collecter les votes';

  @override
  String get voteCollectionParticipants => 'participants';

  @override
  String get voteCollectionResult => 'Résultat :';

  @override
  String get voteCollectionAverage => 'Moyenne :';

  @override
  String get voteCollectionSaveVotes => 'Enregistrer les votes';

  @override
  String get scatterChartTitle => 'Distribution des activités';

  @override
  String get scatterChartNoActivities => 'Aucune activité votée';

  @override
  String get scatterChartVoteToShow =>
      'Votez les activités pour les afficher dans le graphique';

  @override
  String get scatterChartUrgencyLabel => 'Urgence :';

  @override
  String get scatterChartImportanceLabel => 'Importance :';

  @override
  String get scatterChartAxisUrgency => 'URGENCE';

  @override
  String get scatterChartAxisImportance => 'IMPORTANCE';

  @override
  String get scatterChartQ1Label => 'Q1 - FAIRE';

  @override
  String get scatterChartQ2Label => 'Q2 - PLANIFIER';

  @override
  String get scatterChartQ3Label => 'Q3 - DÉLÉGUER';

  @override
  String get scatterChartQ4Label => 'Q4 - ÉLIMINER';

  @override
  String get scatterChartCardTitle => 'Graphique de distribution';

  @override
  String get votingStatusYou => 'Vous';

  @override
  String get votingStatusReset => 'Réinitialiser';

  @override
  String get estimationDecimalHintPlaceholder => 'Ex: 2.5';

  @override
  String get estimationDecimalSuffixDays => 'jours';

  @override
  String get estimationDecimalVote => 'Voter';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Vote: $value jours';
  }

  @override
  String get estimationDecimalQuickSelect => 'Sélection rapide :';

  @override
  String get estimationDecimalEnterValue => 'Entrez une valeur';

  @override
  String get estimationDecimalInvalidValue => 'Valeur invalide';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Estimation à trois points (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Optimiste (O)';

  @override
  String get estimationThreePointRealistic => 'Réaliste (M)';

  @override
  String get estimationThreePointPessimistic => 'Pessimiste (P)';

  @override
  String get estimationThreePointBestCase => 'Meilleur cas';

  @override
  String get estimationThreePointMostLikely => 'Plus probable';

  @override
  String get estimationThreePointWorstCase => 'Pire cas';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Tous les champs sont obligatoires';

  @override
  String get estimationThreePointInvalidValues => 'Valeurs invalides';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Optimiste doit être <= Réaliste';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Réaliste doit être <= Pessimiste';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Optimiste doit être <= Pessimiste';

  @override
  String get estimationThreePointGuide => 'Guide :';

  @override
  String get estimationThreePointGuideO =>
      'O : Estimation du meilleur cas (tout va bien)';

  @override
  String get estimationThreePointGuideM =>
      'M : Estimation la plus probable (conditions normales)';

  @override
  String get estimationThreePointGuideP =>
      'P : Estimation du pire cas (imprévus)';

  @override
  String get estimationThreePointStdDev => 'Écart type';

  @override
  String get estimationThreePointDaysSuffix => 'j';

  @override
  String get storyFormNewStory => 'Nouvelle Story';

  @override
  String get storyFormEnterTitle => 'Entrez un titre';

  @override
  String get sessionSearchHint => 'Rechercher des sessions...';

  @override
  String get sessionSearchFilters => 'Filtres';

  @override
  String get sessionSearchFiltersTooltip => 'Filtres';

  @override
  String get sessionSearchStatusLabel => 'Statut : ';

  @override
  String get sessionSearchStatusAll => 'Tous';

  @override
  String get sessionSearchStatusDraft => 'Brouillon';

  @override
  String get sessionSearchStatusActive => 'Active';

  @override
  String get sessionSearchStatusCompleted => 'Terminée';

  @override
  String get sessionSearchModeLabel => 'Mode : ';

  @override
  String get sessionSearchModeAll => 'Tous';

  @override
  String get sessionSearchRemoveFilters => 'Supprimer les filtres';

  @override
  String get sessionSearchActiveFilters => 'Filtres actifs :';

  @override
  String get sessionSearchRemoveAllFilters => 'Tout supprimer';

  @override
  String participantsTitle(int count) {
    return 'Participants ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Facilitateur';

  @override
  String get participantRoleVoters => 'Votants';

  @override
  String get participantRoleObservers => 'Observateurs';

  @override
  String get votingBoardVotesRevealed => 'Votes révélés';

  @override
  String get votingBoardVotingInProgress => 'Vote en cours';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total votes';
  }

  @override
  String get estimationSelectYourEstimate => 'Sélectionnez votre estimation';

  @override
  String estimationVoteSelected(String value) {
    return 'Vote sélectionné : $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Mode de vote avec allocation de points.\nBientôt disponible...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Estimation par affinité avec regroupement.\nBientôt disponible...';

  @override
  String get estimationModeTitle => 'Mode d\'estimation';

  @override
  String get statisticsTitle => 'Statistiques de vote';

  @override
  String get statisticsAverage => 'Moyenne';

  @override
  String get statisticsMedian => 'Médiane';

  @override
  String get statisticsMode => 'Mode';

  @override
  String get statisticsVoters => 'Votants';

  @override
  String get statisticsPertStats => 'Statistiques PERT';

  @override
  String get statisticsPertAvg => 'Moy. PERT';

  @override
  String get statisticsStdDev => 'Écart type';

  @override
  String get statisticsVariance => 'Variance';

  @override
  String get statisticsRange => 'Plage :';

  @override
  String get statisticsConsensusReached => 'Consensus atteint !';

  @override
  String get retroGuideTooltip => 'Guide des Rétrospectives';

  @override
  String get retroSearchPlaceholder => 'Rechercher rétrospective...';

  @override
  String get retroNoSearchResults => 'Aucun résultat pour la recherche';

  @override
  String get retroNewRetro => 'Nouvelle Rétrospective';

  @override
  String get retroNoProjectsFound => 'Aucun projet trouvé.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Êtes-vous sûr de vouloir supprimer définitivement la rétrospective \"$retroName\" ?\n\nCette action est irréversible et supprimera toutes les données associées (cartes, votes, action items).';
  }

  @override
  String get retroDeletePermanently => 'Supprimer définitivement';

  @override
  String get retroDeletedSuccess => 'Rétrospective supprimée avec succès';

  @override
  String errorPrefix(String error) {
    return 'Erreur : $error';
  }

  @override
  String get loaderProjectIdMissing => 'ID du projet manquant';

  @override
  String get loaderProjectNotFound => 'Projet non trouvé';

  @override
  String get loaderLoadError => 'Erreur de chargement';

  @override
  String get loaderError => 'Erreur';

  @override
  String get loaderUnknownError => 'Erreur inconnue';

  @override
  String get actionGoBack => 'Retour';

  @override
  String get authRequired => 'Authentification requise';

  @override
  String get retroIdMissing => 'ID de rétrospective manquant';

  @override
  String get pokerInviteStatusAccepted => 'a déjà été acceptée';

  @override
  String get pokerInviteStatusDeclined => 'a été refusée';

  @override
  String get pokerInviteStatusExpired => 'a expiré';

  @override
  String get pokerInviteStatusRevoked => 'a été révoquée';

  @override
  String get pokerInviteStatusPending => 'est en attente';

  @override
  String get pokerInviteYouAreInvited => 'Vous Êtes Invité !';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name vous a invité à participer';
  }

  @override
  String get pokerInviteSessionLabel => 'Session';

  @override
  String get pokerInviteProjectLabel => 'Projet';

  @override
  String get pokerInviteRoleLabel => 'Rôle Assigné';

  @override
  String get pokerInviteExpiryLabel => 'Expiration de l\'Invitation';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Dans $days jours';
  }

  @override
  String get pokerInviteDecline => 'Refuser';

  @override
  String get pokerInviteAccept => 'Accepter l\'Invitation';

  @override
  String loadingMatrixError(String error) {
    return 'Erreur de chargement de la matrice : $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Erreur de chargement des données : $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Erreur de chargement des activités : $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days jours/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}h/jour';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Image trouvée dans le presse-papiers';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Ajouter une image depuis le presse-papiers';

  @override
  String get smartTodoInviteCreatedAndSent => 'Invitation créée et envoyée';

  @override
  String get retroColumnDropDesc =>
      'Qu\'est-ce qui n\'apporte pas de valeur et devrait être éliminé?';

  @override
  String get retroColumnAddDesc =>
      'Quelles nouvelles pratiques devrions-nous introduire?';

  @override
  String get retroColumnKeepDesc =>
      'Qu\'est-ce qui fonctionne bien et devrait continuer?';

  @override
  String get retroColumnImproveDesc => 'Que pouvons-nous faire mieux?';

  @override
  String get retroColumnStart => 'Commencer';

  @override
  String get retroColumnStartDesc =>
      'Quelles nouvelles activités ou processus devrions-nous commencer?';

  @override
  String get retroColumnStop => 'Arrêter';

  @override
  String get retroColumnStopDesc =>
      'Qu\'est-ce qui n\'apporte pas de valeur et que nous devrions arrêter?';

  @override
  String get retroColumnContinue => 'Continuer';

  @override
  String get retroColumnContinueDesc =>
      'Qu\'est-ce qui fonctionne bien et que nous devons continuer?';

  @override
  String get retroColumnLongedFor => 'Désiré';

  @override
  String get retroColumnLikedDesc =>
      'Qu\'est-ce que vous avez aimé dans ce sprint?';

  @override
  String get retroColumnLearnedDesc => 'Qu\'avez-vous appris de nouveau?';

  @override
  String get retroColumnLackedDesc => 'Qu\'est-ce qui a manqué dans ce sprint?';

  @override
  String get retroColumnLongedForDesc =>
      'Que souhaiteriez-vous avoir à l\'avenir?';

  @override
  String get retroColumnMadDesc =>
      'Qu\'est-ce qui vous a mis en colère ou frustré?';

  @override
  String get retroColumnSadDesc => 'Qu\'est-ce qui vous a déçu ou attristé?';

  @override
  String get retroColumnGladDesc =>
      'Qu\'est-ce qui vous a rendu heureux ou satisfait?';

  @override
  String get retroColumnWindDesc =>
      'Qu\'est-ce qui nous a fait avancer? Forces et soutien.';

  @override
  String get retroColumnAnchorDesc =>
      'Qu\'est-ce qui nous a ralenti? Obstacles et blocages.';

  @override
  String get retroColumnRockDesc =>
      'Quels risques futurs voyons-nous à l\'horizon?';

  @override
  String get retroColumnGoalDesc => 'Quelle est notre destination idéale?';

  @override
  String get retroColumnMoreDesc => 'Que devrions-nous faire plus?';

  @override
  String get retroColumnLessDesc => 'Que devrions-nous faire moins?';

  @override
  String get actionTypeMaintain => 'Maintenir';

  @override
  String get actionTypeStop => 'Arrêter';

  @override
  String get actionTypeBegin => 'Commencer';

  @override
  String get actionTypeIncrease => 'Augmenter';

  @override
  String get actionTypeDecrease => 'Diminuer';

  @override
  String get actionTypePrevent => 'Prévenir';

  @override
  String get actionTypeCelebrate => 'Célébrer';

  @override
  String get actionTypeReplicate => 'Répliquer';

  @override
  String get actionTypeShare => 'Partager';

  @override
  String get actionTypeProvide => 'Fournir';

  @override
  String get actionTypePlan => 'Planifier';

  @override
  String get actionTypeLeverage => 'Exploiter';

  @override
  String get actionTypeRemove => 'Supprimer';

  @override
  String get actionTypeMitigate => 'Atténuer';

  @override
  String get actionTypeAlign => 'Aligner';

  @override
  String get actionTypeEliminate => 'Éliminer';

  @override
  String get actionTypeImplement => 'Implémenter';

  @override
  String get actionTypeEnhance => 'Améliorer';

  @override
  String get coachTipSSCWriting =>
      'Concentrez-vous sur des comportements concrets et observables. Chaque élément doit être quelque chose sur lequel l\'équipe peut agir directement. Évitez les déclarations vagues.';

  @override
  String get coachTipSSCVoting =>
      'Votez en fonction de l\'impact et de la faisabilité. Les éléments les plus votés deviendront vos engagements de sprint.';

  @override
  String get coachTipSSCDiscuss =>
      'Pour chaque élément le plus voté, définissez QUI fera QUOI et QUAND. Transformez les insights en actions spécifiques.';

  @override
  String get coachTipMSGWriting =>
      'Créez un espace sûr pour les émotions. Tous les sentiments sont valides. Concentrez-vous sur la situation, pas sur la personne. Utilisez des déclarations \'Je ressens...\'.';

  @override
  String get coachTipMSGVoting =>
      'Votez pour identifier les expériences partagées. Les patterns émotionnels révèlent des dynamiques d\'équipe qui nécessitent attention.';

  @override
  String get coachTipMSGDiscuss =>
      'Reconnaissez les émotions avant de résoudre les problèmes. Demandez \'Qu\'est-ce qui aiderait?\' plutôt que de sauter aux solutions. Écoutez activement.';

  @override
  String get coachTip4LsWriting =>
      'Réfléchissez aux apprentissages, pas seulement aux événements. Pensez aux insights que vous emporterez. Chaque L représente une perspective différente.';

  @override
  String get coachTip4LsVoting =>
      'Priorisez les apprentissages qui pourraient améliorer les futurs sprints. Concentrez-vous sur les connaissances transférables.';

  @override
  String get coachTip4LsDiscuss =>
      'Transformez les apprentissages en documentation ou changements de processus. Demandez \'Comment partager ces connaissances avec les autres?\'';

  @override
  String get coachTipSailboatWriting =>
      'Utilisez la métaphore: le Vent nous pousse (facilitateurs), les Ancres nous ralentissent (bloqueurs), les Rochers sont les risques futurs, l\'Île est notre objectif.';

  @override
  String get coachTipSailboatVoting =>
      'Priorisez selon l\'impact du risque et le potentiel des facilitateurs. Équilibrez entre résoudre les bloqueurs et exploiter les forces.';

  @override
  String get coachTipSailboatDiscuss =>
      'Créez un registre des risques pour les rochers. Définissez des stratégies d\'atténuation. Exploitez les vents pour surmonter les ancres.';

  @override
  String get coachTipDAKIWriting =>
      'Soyez décisif: Supprimez ce qui gaspille du temps, Ajoutez ce qui manque, Gardez ce qui fonctionne, Améliorez ce qui pourrait être mieux.';

  @override
  String get coachTipDAKIVoting =>
      'Votez pragmatiquement. Concentrez-vous sur les changements qui auront un impact immédiat et mesurable.';

  @override
  String get coachTipDAKIDiscuss =>
      'Prenez des décisions claires en équipe. Pour chaque élément, engagez-vous sur une action spécifique ou décidez explicitement de ne pas agir.';

  @override
  String get coachTipStarfishWriting =>
      'Utilisez les gradations: Garder (maintenir), Plus (augmenter), Moins (diminuer), Stop (éliminer), Start (commencer). Cela permet un feedback nuancé.';

  @override
  String get coachTipStarfishVoting =>
      'Considérez l\'effort vs l\'impact. Les éléments \'Plus\' et \'Moins\' peuvent être plus faciles à implémenter que \'Start\' et \'Stop\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Définissez des métriques spécifiques pour \'plus\' et \'moins\'. Combien de plus? Comment mesurer? Fixez des objectifs de calibration clairs.';

  @override
  String get discussPromptSSCStart =>
      'Quelle nouvelle pratique devrions-nous commencer? Pensez aux lacunes dans notre processus qu\'une nouvelle habitude pourrait combler.';

  @override
  String get discussPromptSSCStop =>
      'Qu\'est-ce qui gaspille notre temps ou énergie? Considérez les activités qui n\'apportent pas de valeur proportionnelle à leur coût.';

  @override
  String get discussPromptSSCContinue =>
      'Qu\'est-ce qui fonctionne bien? Reconnaissez et renforcez les pratiques efficaces.';

  @override
  String get discussPromptMSGMad =>
      'Qu\'est-ce qui vous a frustré? Rappelez-vous, nous discutons de situations, pas d\'individus.';

  @override
  String get discussPromptMSGSad =>
      'Qu\'est-ce qui vous a déçu? Quelles attentes n\'ont pas été satisfaites?';

  @override
  String get discussPromptMSGGlad =>
      'Qu\'est-ce qui vous a rendu heureux? Quels moments vous ont apporté satisfaction ce sprint?';

  @override
  String get discussPrompt4LsLiked =>
      'Qu\'avez-vous apprécié? Qu\'est-ce qui a rendu le travail agréable?';

  @override
  String get discussPrompt4LsLearned =>
      'Quelle nouvelle compétence, insight ou connaissance avez-vous acquis?';

  @override
  String get discussPrompt4LsLacked =>
      'Qu\'est-ce qui a manqué? Quelles ressources, support ou clarté auraient aidé?';

  @override
  String get discussPrompt4LsLonged =>
      'Que souhaitez-vous? Qu\'est-ce qui rendrait les futurs sprints meilleurs?';

  @override
  String get discussPromptSailboatWind =>
      'Qu\'est-ce qui nous a poussés en avant? Quelles sont nos forces et support externe?';

  @override
  String get discussPromptSailboatAnchor =>
      'Qu\'est-ce qui nous a ralentis? Quels obstacles internes ou externes nous ont freinés?';

  @override
  String get discussPromptSailboatRock =>
      'Quels risques voyons-nous à l\'horizon? Qu\'est-ce qui pourrait nous faire dérailler si non traité?';

  @override
  String get discussPromptSailboatGoal =>
      'Quelle est notre destination? Sommes-nous alignés sur notre direction?';

  @override
  String get discussPromptDAKIDrop =>
      'Que devrions-nous éliminer? Qu\'est-ce qui n\'apporte pas de valeur?';

  @override
  String get discussPromptDAKIAdd =>
      'Que devrions-nous introduire? Qu\'est-ce qui manque à notre boîte à outils?';

  @override
  String get discussPromptDAKIKeep =>
      'Que devons-nous préserver? Qu\'est-ce qui est essentiel à notre succès?';

  @override
  String get discussPromptDAKIImprove =>
      'Qu\'est-ce qui pourrait être mieux? Où pouvons-nous nous améliorer?';

  @override
  String get discussPromptStarfishKeep =>
      'Que devrions-nous maintenir exactement tel quel?';

  @override
  String get discussPromptStarfishMore =>
      'Que devrions-nous augmenter? Faire plus?';

  @override
  String get discussPromptStarfishLess =>
      'Que devrions-nous réduire? Faire moins?';

  @override
  String get discussPromptStarfishStop =>
      'Que devrions-nous éliminer complètement?';

  @override
  String get discussPromptStarfishStart =>
      'Quelle nouvelle chose devrions-nous commencer?';

  @override
  String get discussPromptGeneric =>
      'Quels insights ont émergé de cette colonne? Quels patterns voyez-vous?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Quelle nouvelle pratique spécifique allez-vous commencer, et comment mesurerez-vous son adoption?';

  @override
  String get smartPromptSSCStartExample =>
      'ex., \'Commencer standup quotidien de 15 min à 9h30, suivre la présence pendant 2 semaines\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Nous commencerons [pratique spécifique] d\'ici [date], mesurée par [métrique]';

  @override
  String get smartPromptSSCStopQuestion =>
      'Qu\'allez-vous arrêter de faire, et que ferez-vous à la place?';

  @override
  String get smartPromptSSCStopExample =>
      'ex., \'Arrêter d\'envoyer des mises à jour par email, utiliser le canal Slack #updates à la place\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Nous arrêterons [pratique] et à la place [alternative]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Quelle pratique continuerez-vous, et comment vous assurerez-vous qu\'elle ne disparaît pas?';

  @override
  String get smartPromptSSCContinueExample =>
      'ex., \'Continuer les revues de code en moins de 4 heures, ajouter à la Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Nous continuerons [pratique], renforcée par [mécanisme]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Quelle action aborderait cette frustration et qui la dirigera?';

  @override
  String get smartPromptMSGMadExample =>
      'ex., \'Planifier réunion avec PM pour clarifier le processus des exigences - Maria d\'ici vendredi\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Action pour traiter la frustration], responsable: [nom], d\'ici: [date]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Quel changement empêcherait cette déception de se reproduire?';

  @override
  String get smartPromptMSGSadExample =>
      'ex., \'Créer checklist de communication pour les mises à jour stakeholders - revue hebdomadaire\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Action préventive], suivie via [méthode]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Comment pouvons-nous répliquer ou amplifier ce qui nous a rendus heureux?';

  @override
  String get smartPromptMSGGladExample =>
      'ex., \'Documenter le format de session de pairing et partager avec d\'autres équipes d\'ici fin de semaine\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Action pour répliquer/amplifier], partager avec [audience]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Comment pouvons-nous assurer que cette expérience positive continue?';

  @override
  String get smartPrompt4LsLikedExample =>
      'ex., \'Faire de la session de mob programming un événement hebdomadaire récurrent\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Action pour préserver l\'expérience positive]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Comment documenterez-vous et partagerez-vous cet apprentissage?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'ex., \'Écrire article wiki sur la nouvelle approche de test, présenter en tech talk le mois prochain\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Documenter dans [emplacement], partager via [méthode] d\'ici [date]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Quelles ressources ou support spécifiques demanderez-vous et à qui?';

  @override
  String get smartPrompt4LsLackedExample =>
      'ex., \'Demander budget formation CI/CD au manager - soumettre avant prochain planning\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Demander [ressource] à [personne/équipe], deadline: [date]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Quelle première étape concrète vous rapprochera de ce souhait?';

  @override
  String get smartPrompt4LsLongedExample =>
      'ex., \'Rédiger proposition pour 20% du temps pour projets perso - partager avec team lead lundi\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Première étape vers [souhait]: [action] d\'ici [date]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Comment exploiterez-vous ce facilitateur pour accélérer les progrès?';

  @override
  String get smartPromptSailboatWindExample =>
      'ex., \'Utiliser forte expertise QA pour mentorer les juniors - planifier première session cette semaine\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Exploiter [facilitateur] par [action spécifique]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Quelle action spécifique supprimera ou réduira ce bloqueur?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'ex., \'Escalader problème infrastructure au CTO - préparer brief d\'ici mercredi\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Supprimer [bloqueur] par [action], escalader à [personne] si nécessaire';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Quelle stratégie d\'atténuation implémenterez-vous pour ce risque?';

  @override
  String get smartPromptSailboatRockExample =>
      'ex., \'Ajouter plan de secours pour dépendance fournisseur - documenter alternatives d\'ici fin de sprint\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Atténuer [risque] par [stratégie], déclencheur: [condition]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Quelle milestone confirmera les progrès vers cet objectif?';

  @override
  String get smartPromptSailboatGoalExample =>
      'ex., \'Démo MVP aux stakeholders d\'ici 15 fév, collecter feedback via sondage\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Milestone vers [objectif]: [livrable] d\'ici [date]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'Qu\'éliminerez-vous et comment vous assurerez-vous que ça ne revient pas?';

  @override
  String get smartPromptDAKIDropExample =>
      'ex., \'Supprimer étapes de déploiement manuelles - automatiser d\'ici fin de sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Éliminer [pratique], empêcher retour par [mécanisme]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Quelle nouvelle pratique introduirez-vous et comment validerez-vous qu\'elle fonctionne?';

  @override
  String get smartPromptDAKIAddExample =>
      'ex., \'Ajouter système de feature flags - tester sur 2 features, revoir résultats en 2 semaines\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Ajouter [pratique], valider succès via [métrique]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Comment protégerez-vous cette pratique contre la dépriorisation?';

  @override
  String get smartPromptDAKIKeepExample =>
      'ex., \'Garder standards code review - ajouter à la charte d\'équipe, audit mensuel\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Protéger [pratique] par [mécanisme]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Quelle amélioration spécifique ferez-vous et comment mesurerez-vous l\'amélioration?';

  @override
  String get smartPromptDAKIImproveExample =>
      'ex., \'Améliorer couverture tests de 60% à 80% - focus sur module paiement d\'abord\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Améliorer [pratique] de [actuel] à [cible] d\'ici [date]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Quelle pratique maintiendrez-vous et qui est responsable d\'assurer la cohérence?';

  @override
  String get smartPromptStarfishKeepExample =>
      'ex., \'Garder démos du vendredi - Tom s\'assure que la salle est réservée, agenda partagé d\'ici jeudi\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Garder [pratique], responsable: [nom]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'Qu\'augmenterez-vous et de combien?';

  @override
  String get smartPromptStarfishMoreExample =>
      'ex., \'Augmenter pair programming de 2h à 6h par semaine par développeur\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Augmenter [pratique] de [niveau actuel] à [niveau cible]';

  @override
  String get smartPromptStarfishLessQuestion =>
      'Que réduirez-vous et de combien?';

  @override
  String get smartPromptStarfishLessExample =>
      'ex., \'Réduire réunions de 10h à 6h par semaine - annuler revue récurrente\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Réduire [pratique] de [niveau actuel] à [niveau cible]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'Qu\'arrêterez-vous complètement et qu\'est-ce qui le remplace (le cas échéant)?';

  @override
  String get smartPromptStarfishStopExample =>
      'ex., \'Arrêter suivi de temps détaillé sur les tâches - estimations basées sur la confiance à la place\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Arrêter [pratique], remplacer par [alternative] ou rien';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Quelle nouvelle pratique commencerez-vous et quand sera la première occurrence?';

  @override
  String get smartPromptStarfishStartExample =>
      'ex., \'Commencer tech debt Tuesday - première session semaine prochaine, 2h de temps protégé\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Commencer [pratique], première occurrence: [date/heure]';

  @override
  String get smartPromptGenericQuestion =>
      'Quelle action spécifique traitera cet élément?';

  @override
  String get smartPromptGenericExample =>
      'ex., \'Définir action spécifique avec responsable, deadline, et critères de succès\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Action], responsable: [nom], d\'ici: [date]';

  @override
  String get methodologyFocusAction =>
      'Orienté action: se concentre sur des changements comportementaux concrets';

  @override
  String get methodologyFocusEmotion =>
      'Focalisé émotions: explore les sentiments de l\'équipe pour construire la sécurité psychologique';

  @override
  String get methodologyFocusLearning =>
      'Réflexif apprentissage: met l\'accent sur la capture et le partage des connaissances';

  @override
  String get methodologyFocusRisk =>
      'Risque & Objectif: équilibre facilitateurs, bloqueurs, risques et objectifs';

  @override
  String get methodologyFocusCalibration =>
      'Calibration: utilise des gradations (plus/moins) pour des ajustements nuancés';

  @override
  String get methodologyFocusDecision =>
      'Décisionnel: guide les décisions claires de l\'équipe sur les pratiques';

  @override
  String get exportSheetOverview => 'Aperçu';

  @override
  String get exportSheetActionItems => 'Actions';

  @override
  String get exportSheetBoardItems => 'Éléments du Board';

  @override
  String get exportSheetTeamHealth => 'Santé de l\'Équipe';

  @override
  String get exportSheetLessonsLearned => 'Leçons Apprises';

  @override
  String get exportSheetRiskRegister => 'Registre des Risques';

  @override
  String get exportSheetCalibrationMatrix => 'Matrice de Calibration';

  @override
  String get exportSheetDecisionLog => 'Journal des Décisions';

  @override
  String get exportHeaderRetrospectiveReport => 'RAPPORT RÉTROSPECTIVE';

  @override
  String get exportHeaderTitle => 'Titre:';

  @override
  String get exportHeaderDate => 'Date:';

  @override
  String get exportHeaderTemplate => 'Template:';

  @override
  String get exportHeaderMethodology => 'Focus Méthodologique:';

  @override
  String get exportHeaderSentiments => 'Sentiments (Moy.):';

  @override
  String get exportHeaderParticipants => 'PARTICIPANTS';

  @override
  String get exportHeaderSummary => 'RÉSUMÉ';

  @override
  String get exportHeaderTotalItems => 'Total Éléments:';

  @override
  String get exportHeaderActionItems => 'Actions:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Suivi Suggéré:';

  @override
  String get exportTeamHealthTitle => 'ANALYSE SANTÉ DE L\'ÉQUIPE';

  @override
  String get exportTeamHealthEmotionalDistribution =>
      'Distribution Émotionnelle';

  @override
  String get exportTeamHealthMadCount => 'Éléments Mad:';

  @override
  String get exportTeamHealthSadCount => 'Éléments Sad:';

  @override
  String get exportTeamHealthGladCount => 'Éléments Glad:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRATIONS (Mad)';

  @override
  String get exportTeamHealthSadItems => 'DÉCEPTIONS (Sad)';

  @override
  String get exportTeamHealthGladItems => 'CÉLÉBRATIONS (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Recommandation Santé Équipe:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Niveau de frustration élevé détecté. Envisagez de faciliter une session focalisée sur la résolution de problèmes.';

  @override
  String get exportTeamHealthBalanced =>
      'État émotionnel équilibré. L\'équipe montre des capacités de réflexion saines.';

  @override
  String get exportTeamHealthPositive =>
      'Moral de l\'équipe positif. Utilisez cette énergie pour des améliorations ambitieuses.';

  @override
  String get exportLessonsLearnedTitle => 'REGISTRE DES LEÇONS APPRISES';

  @override
  String get exportLessonsLearnedWhatWorked => 'CE QUI A FONCTIONNÉ (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'NOUVELLES COMPÉTENCES ET INSIGHTS (Learned)';

  @override
  String get exportLessonsLearnedGaps =>
      'LACUNES ET ÉLÉMENTS MANQUANTS (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ASPIRATIONS FUTURES (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Actions de Partage des Connaissances';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Documentation Nécessaire:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Formation/Partage Nécessaire:';

  @override
  String get exportRiskRegisterTitle => 'REGISTRE RISQUES ET FACILITATEURS';

  @override
  String get exportRiskRegisterEnablers => 'FACILITATEURS (Vent)';

  @override
  String get exportRiskRegisterBlockers => 'BLOQUEURS (Ancre)';

  @override
  String get exportRiskRegisterRisks => 'RISQUES (Rochers)';

  @override
  String get exportRiskRegisterGoals => 'OBJECTIFS (Île)';

  @override
  String get exportRiskRegisterRiskItem => 'Risque';

  @override
  String get exportRiskRegisterImpact => 'Impact Potentiel';

  @override
  String get exportRiskRegisterMitigation => 'Action de Mitigation';

  @override
  String get exportRiskRegisterStatus => 'Statut';

  @override
  String get exportRiskRegisterGoalAlignment =>
      'Vérification Alignement Objectifs:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Vérifier si les actions actuelles sont alignées avec les objectifs déclarés.';

  @override
  String get exportCalibrationTitle => 'MATRICE DE CALIBRATION';

  @override
  String get exportCalibrationKeepDoing => 'CONTINUER À FAIRE';

  @override
  String get exportCalibrationDoMore => 'FAIRE PLUS';

  @override
  String get exportCalibrationDoLess => 'FAIRE MOINS';

  @override
  String get exportCalibrationStopDoing => 'ARRÊTER DE FAIRE';

  @override
  String get exportCalibrationStartDoing => 'COMMENCER À FAIRE';

  @override
  String get exportCalibrationPractice => 'Pratique';

  @override
  String get exportCalibrationCurrentState => 'État Actuel';

  @override
  String get exportCalibrationTargetState => 'État Cible';

  @override
  String get exportCalibrationAdjustment => 'Ajustement';

  @override
  String get exportCalibrationNote =>
      'La calibration se concentre sur l\'affinage des pratiques existantes plutôt que sur des changements radicaux.';

  @override
  String get exportDecisionLogTitle => 'JOURNAL DES DÉCISIONS';

  @override
  String get exportDecisionLogDrop => 'DÉCISIONS À ABANDONNER';

  @override
  String get exportDecisionLogAdd => 'DÉCISIONS À AJOUTER';

  @override
  String get exportDecisionLogKeep => 'DÉCISIONS À CONSERVER';

  @override
  String get exportDecisionLogImprove => 'DÉCISIONS À AMÉLIORER';

  @override
  String get exportDecisionLogDecision => 'Décision';

  @override
  String get exportDecisionLogRationale => 'Justification';

  @override
  String get exportDecisionLogOwner => 'Responsable';

  @override
  String get exportDecisionLogDeadline => 'Échéance';

  @override
  String get exportDecisionLogPrioritizationNote => 'Recommandation Priorité:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Se concentrer d\'abord sur les décisions DROP pour libérer de la capacité, puis ajouter de nouvelles pratiques.';

  @override
  String get exportNoItems => 'Aucun élément enregistré';

  @override
  String get exportNoActionItems => 'Aucune action';

  @override
  String get exportNotApplicable => 'N/A';

  @override
  String get facilitatorGuideTitle => 'Guide de Collecte d\'Actions';

  @override
  String get facilitatorGuideCoverage => 'Couverture';

  @override
  String get facilitatorGuideComplete => 'Complète';

  @override
  String get facilitatorGuideIncomplete => 'Incomplète';

  @override
  String get facilitatorGuideSuggestedOrder => 'Ordre Suggéré:';

  @override
  String get facilitatorGuideMissingRequired => 'Actions requises manquantes';

  @override
  String get facilitatorGuideColumnHasAction => 'A une action';

  @override
  String get facilitatorGuideColumnNoAction => 'Pas d\'action';

  @override
  String get facilitatorGuideRequired => 'Requis';

  @override
  String get facilitatorGuideOptional => 'Optionnel';
}
