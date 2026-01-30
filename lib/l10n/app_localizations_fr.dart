// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Liste d\'appartenance';

  @override
  String get smartTodoSortTooltip => 'Options de Tri';

  @override
  String get smartTodoSortManual => 'Manuel';

  @override
  String get smartTodoSortDate => 'Récents';

  @override
  String get smartTodoActionSortPriority => 'Trier par Priorité';

  @override
  String get smartTodoActionSortDeadline => 'Trier par Échéance';

  @override
  String get smartTodoOrderUpdated => 'Ordre mis à jour manuellement';

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
  String get eisenhowerWaitingForVotes => 'En attente de votes';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total votes';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTER';

  @override
  String get eisenhowerVotedSuccess => 'Vous avez voté';

  @override
  String get eisenhowerRevealVotes => 'RÉVÉLER LES VOTES';

  @override
  String get eisenhowerQuickVote => 'Vote Rapide';

  @override
  String get eisenhowerTeamVote => 'Vote Équipe';

  @override
  String get eisenhowerUrgency => 'URGENCE';

  @override
  String get eisenhowerImportance => 'IMPORTANCE';

  @override
  String get eisenhowerUrgencyShort => 'U :';

  @override
  String get eisenhowerImportanceShort => 'I :';

  @override
  String get eisenhowerVotingInProgress => 'VOTE EN COURS';

  @override
  String get eisenhowerWaitingForOthers =>
      'En attente que tous votent. Le facilitateur révélera les votes.';

  @override
  String get eisenhowerReady => 'Prêt';

  @override
  String get eisenhowerWaiting => 'En attente';

  @override
  String get eisenhowerIndividualVotes => 'VOTES INDIVIDUELS';

  @override
  String get eisenhowerResult => 'RÉSULTAT';

  @override
  String get eisenhowerAverage => 'MOYENNE';

  @override
  String get eisenhowerVotesRevealed => 'Votes Révélés';

  @override
  String get eisenhowerNextActivity => 'Activité Suivante';

  @override
  String get eisenhowerNoVotesRecorded => 'Aucun vote enregistré';

  @override
  String get eisenhowerWaitingForStart => 'En attente';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Votes anticipés qui seront comptabilisés lorsque le facilitateur lance le vote';

  @override
  String get eisenhowerObserverWaiting =>
      'En attente que le facilitateur lance le vote collectif';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Exprimez votre vote à l\'avance. Il sera comptabilisé lorsque le vote sera lancé.';

  @override
  String get eisenhowerPreVote => 'Pré-voter';

  @override
  String get eisenhowerPreVoted => 'Vous avez pré-voté';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Lancer la session de vote collectif. Les pré-votes existants seront conservés.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Réinitialiser le vote en supprimant tous les votes';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Observation du vote en cours...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'En attente que tous les participants votent';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Tout le monde a voté ! Cliquez pour révéler les résultats.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Il manque encore $count votes';
  }

  @override
  String get eisenhowerVotingLocked => 'Vote fermé';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Les votes ont été révélés. Il n\'est plus possible de voter sur cette activité.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online sur $total participants en ligne';
  }

  @override
  String get eisenhowerVoting => 'Vote';

  @override
  String get eisenhowerAllActivitiesVoted =>
      'Toutes les activités ont été votées !';

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
  String get retroNoRetrosFound => 'Aucune rétrospective trouvée';

  @override
  String get retroCreateNew => 'Créer nouvelle';

  @override
  String get retroChooseMode => 'Scegli Modalità Retrospettiva';

  @override
  String get retroQuickForm => 'Form Rapido';

  @override
  String get retroInteractiveBoard => 'Board Interattiva';

  @override
  String get retroQuickModeDesc =>
      'Compila un form veloce per registrare i punti salienti dello sprint.';

  @override
  String get retroInteractiveModeDesc =>
      'Avvia una board in tempo reale per collaborare con tutto il team.';

  @override
  String get retroNoOperationsReview => 'Nessuna Operations Review';

  @override
  String get retroOperationsReview => 'Operations Review';

  @override
  String get retroOperationsReviewDesc =>
      'Crea una Operations Review per migliorare il flusso di lavoro';

  @override
  String get retroWentWell => 'Cosa è andato bene?';

  @override
  String get retroToImprove => 'Cosa migliorare?';

  @override
  String get retroWentWellHint => 'Aggiungi un punto positivo...';

  @override
  String get retroToImproveHint => 'Aggiungi un punto da migliorare...';

  @override
  String get retroActionItemHint => 'Aggiungi un action item...';

  @override
  String get retroSave => 'Salva Retrospettiva';

  @override
  String get retroOpenInteractiveBoard => 'Apri Board Interattiva';

  @override
  String get retroSentimentTeam => 'Sentiment del Team';

  @override
  String get retroExcellent => 'Eccellente';

  @override
  String get retroGood => 'Buono';

  @override
  String get retroNormal => 'Nella norma';

  @override
  String get retroNeedsImprovement => 'Da migliorare';

  @override
  String get retroCritical => 'Critico';

  @override
  String get retroNoElements => 'Nessun elemento';

  @override
  String get retroNoActionItemsFound => 'Nessun action item';

  @override
  String retroAssignedTo(String email) {
    return 'Assegnato a: $email';
  }

  @override
  String retroVotesCount(int count) {
    return '+$count voti';
  }

  @override
  String get retroGuidance => 'Guide des Rétrospectives';

  @override
  String retroResultLabel(String score, String label) {
    return 'Sentiment medio: $score ($label)';
  }

  @override
  String get retroSearchHint => 'Rechercher une rétrospective...';

  @override
  String get agileProcessTitle => 'Agile Process Manager';

  @override
  String get agileSearchProjects => 'Rechercher des projets...';

  @override
  String get agileMethodologyGuide => 'Guide des Méthodologies';

  @override
  String get agileMethodologyGuideTitle => 'Guide des méthodologies Agile';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Choisissez la méthodologie qui convient le mieux à votre projet';

  @override
  String get agileNewProject => 'Nouveau Projet';

  @override
  String get agileRoles => 'RÔLES';

  @override
  String get agileProcessFlow => 'FLUX DU PROCESSUS';

  @override
  String get agileArtifacts => 'ARTEFACTS';

  @override
  String get agileBestPractices => 'Bonnes Pratiques';

  @override
  String get agileAntiPatterns => 'Anti-Patterns à Éviter';

  @override
  String get agileFAQ => 'Questions Fréquentes';

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
  String get agileRolePODesc => 'Gère le backlog et les priorités';

  @override
  String get agileRoleSMDesc =>
      'Facilite le processus et supprime les obstacles';

  @override
  String get agileRoleDevTeamDesc => 'Membres développant le produit';

  @override
  String get agileRoleStakeholdersDesc =>
      'Fournissent du feedback et des exigences';

  @override
  String get agileRoleSRMDesc => 'Gère les demandes entrantes';

  @override
  String get agileRoleSDMDesc => 'Optimise le flux de travail';

  @override
  String get agileRoleTeamDesc =>
      'Exécute le travail en respectant les limites WIP';

  @override
  String get agileRoleFlowMasterDesc => 'Optimise le flux et facilite';

  @override
  String get agileRoleTeamHybridDesc => 'Pluridisciplinaire, auto-organisé';

  @override
  String get scrumOverview =>
      'Scrum est un framework Agile itératif et incrémental pour la gestion du développement de produits.\nIl repose sur des cycles de travail à durée fixe appelés Sprints, généralement de 2 à 4 semaines.\n\nScrum est idéal pour :\n• Les équipes travaillant sur des produits avec des exigences évolutives\n• Les projets bénéficiant d\'un feedback régulier\n• Les organisations souhaitant améliorer la prévisibilité et la transparence';

  @override
  String get scrumRolesTitle => 'Les Rôles Scrum';

  @override
  String get scrumRolesContent =>
      'Scrum définit trois rôles clés qui collaborent pour le succès du projet.';

  @override
  String get scrumRolesPO =>
      'Product Owner : Représente les parties prenantes, gère le Product Backlog et maximise la valeur du produit';

  @override
  String get scrumRolesSM =>
      'Scrum Master : Facilite le processus Scrum, supprime les obstacles et aide l\'équipe à s\'améliorer';

  @override
  String get scrumRolesDev =>
      'Development Team : Équipe pluridisciplinaire et auto-organisée qui livre l\'incrément de produit';

  @override
  String get scrumEventsTitle => 'Les Événements Scrum';

  @override
  String get scrumEventsContent =>
      'Scrum prévoit des événements réguliers pour créer de la régularité et minimiser les réunions non planifiées.';

  @override
  String get scrumEventsPlanning =>
      'Sprint Planning : Planification du travail du Sprint (max 8h pour un Sprint de 4 semaines)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum : Synchronisation quotidienne de l\'équipe (15 minutes)';

  @override
  String get scrumEventsRetro =>
      'Sprint Retrospective : Réflexion de l\'équipe pour l\'amélioration continue (max 3h)';

  @override
  String get scrumEventsRetroContent =>
      'Crea una retrospettiva per analizzare l\'ultimo sprint e identificare aree di miglioramento.';

  @override
  String get scrumEventsReview =>
      'Sprint Review : Démo du travail terminé aux parties prenantes (max 4h)';

  @override
  String get scrumArtifactsTitle => 'Les Artefacts Scrum';

  @override
  String get scrumArtifactsContent =>
      'Les artefacts représentent le travail ou la valeur et sont conçus pour maximiser la transparence.';

  @override
  String get scrumArtifactsPB =>
      'Product Backlog : Liste ordonnée de tout ce qui pourrait être nécessaire dans le produit';

  @override
  String get scrumArtifactsSB =>
      'Sprint Backlog : Items sélectionnés pour le Sprint + plan pour livrer l\'incrément';

  @override
  String get scrumArtifactsIncrement =>
      'Incrément : Somme de tous les items terminés pendant le Sprint, potentiellement livrable';

  @override
  String get scrumStoryPointsTitle => 'Story Points et Vélocité';

  @override
  String get scrumStoryPointsContent =>
      'Les Story Points sont une mesure relative de la complexité des User Stories.\nIls ne mesurent pas le temps, mais l\'effort, la complexité et l\'incertitude.\n\nLa séquence de Fibonacci (1, 2, 3, 5, 8, 13, 21) est couramment utilisée car :\n• Elle reflète l\'incertitude croissante pour les items plus grands\n• Elle rend la fausse précision difficile\n• Elle facilite les discussions pendant l\'estimation\n\nLa Vélocité est la moyenne des Story Points terminés dans les sprints récents et sert à :\n• Prédire combien de travail peut être inclus dans les prochains sprints\n• Identifier les tendances de productivité de l\'équipe\n• Ne pas comparer des équipes différentes (chaque équipe a sa propre échelle)';

  @override
  String get scrumBP1 =>
      'Gardez les Sprints à durée fixe et respectez le timebox';

  @override
  String get scrumBP2 =>
      'Le Product Backlog doit toujours être priorisé et affiné';

  @override
  String get scrumBP3 =>
      'Les User Stories doivent respecter les critères INVEST';

  @override
  String get scrumBP4 => 'La Definition of Done doit être claire et partagée';

  @override
  String get scrumBP5 => 'Ne modifiez pas le Sprint Goal pendant le Sprint';

  @override
  String get scrumBP6 => 'Célébrez les succès lors de la Sprint Review';

  @override
  String get scrumBP7 =>
      'La Rétrospective doit produire des actions concrètes d\'amélioration';

  @override
  String get scrumBP8 =>
      'L\'équipe doit être pluridisciplinaire et auto-organisée';

  @override
  String get scrumAP1 => 'Sprint sans Sprint Goal clair';

  @override
  String get scrumAP2 => 'Daily Scrum transformé en réunion de reporting';

  @override
  String get scrumAP3 => 'Sauter la Rétrospective quand on est \"trop occupé\"';

  @override
  String get scrumAP4 => 'Product Owner absent ou indisponible';

  @override
  String get scrumAP5 => 'Ajouter du travail pendant le Sprint sans en retirer';

  @override
  String get scrumAP6 => 'Story Points convertis en heures (perd son sens)';

  @override
  String get scrumAP7 => 'Équipe trop grande (idéal 5-9 personnes)';

  @override
  String get scrumAP8 => 'Scrum Master qui \"assigne\" des tâches à l\'équipe';

  @override
  String get scrumFAQ1Q => 'Quelle doit être la durée d\'un Sprint ?';

  @override
  String get scrumFAQ1A =>
      'La durée typique est de 2 semaines, mais peut varier de 1 à 4 semaines. Des Sprints plus courts permettent un feedback plus fréquent et des corrections de cap rapides. Des Sprints plus longs donnent plus de temps pour terminer les items complexes. L\'important est de maintenir la durée constante.';

  @override
  String get scrumFAQ2Q =>
      'Comment gérer le travail non terminé en fin de Sprint ?';

  @override
  String get scrumFAQ2A =>
      'Les User Stories non terminées retournent dans le Product Backlog et sont repriorisées. Ne jamais prolonger le Sprint ou réduire la Definition of Done. Utilisez la Rétrospective pour comprendre pourquoi c\'est arrivé et comment l\'éviter.';

  @override
  String get scrumFAQ3Q =>
      'Puis-je modifier le Sprint Backlog pendant le Sprint ?';

  @override
  String get scrumFAQ3A =>
      'Le Sprint Goal ne devrait pas changer, mais le Sprint Backlog peut évoluer. L\'équipe peut négocier avec le PO le remplacement d\'items de valeur égale. Si le Sprint Goal devient obsolète, le PO peut annuler le Sprint.';

  @override
  String get scrumFAQ4Q => 'Comment calculer la Vélocité initiale ?';

  @override
  String get scrumFAQ4A =>
      'Pour les 3 premiers Sprints, faites des estimations conservatrices. Après 3 Sprints, vous aurez une Vélocité fiable. N\'utilisez pas la Vélocité d\'autres équipes comme référence.';

  @override
  String get kanbanOverview =>
      'Kanban est une méthode de gestion du travail qui met l\'accent sur la visualisation du flux,\nla limitation du Work In Progress (WIP) et l\'amélioration continue du processus.\n\nKanban est idéal pour :\n• Les équipes de support/maintenance avec des demandes continues\n• Les environnements où les priorités changent fréquemment\n• Quand il n\'est pas possible de planifier en itérations fixes\n• Une transition graduelle vers l\'Agile';

  @override
  String get kanbanPrinciplesTitle => 'Les Principes Kanban';

  @override
  String get kanbanPrinciplesContent =>
      'Kanban repose sur des principes de changement incrémental et de respect des rôles existants.';

  @override
  String get kanbanPrinciple1 =>
      'Visualisez le flux de travail : Rendez tout le travail visible';

  @override
  String get kanbanPrinciple2 =>
      'Limitez le WIP : Terminez le travail avant d\'en commencer un nouveau';

  @override
  String get kanbanPrinciple3 =>
      'Gérez le flux : Optimisez pour maximiser le throughput';

  @override
  String get kanbanPrinciple4 =>
      'Rendez les politiques explicites : Définissez des règles claires';

  @override
  String get kanbanPrinciple5 =>
      'Implémentez des boucles de feedback : Améliorez continuellement';

  @override
  String get kanbanPrinciple6 =>
      'Améliorez collaborativement : Évoluez en expérimentant';

  @override
  String get kanbanBoardTitle => 'Tableau Kanban';

  @override
  String get kanbanBoardContent =>
      'Le tableau visualise le flux de travail à travers ses phases.\nChaque colonne représente un état du travail (ex. À faire, En cours, Terminé).\n\nÉléments clés du tableau :\n• Colonnes : États du workflow\n• Carte/Ticket : Unités de travail\n• Limites WIP : Limites par colonne\n• Swimlanes : Groupements horizontaux (optionnel)';

  @override
  String get kanbanWIPTitle => 'Limites WIP';

  @override
  String get kanbanWIPContent =>
      'Les limites de Work In Progress (WIP) sont le cœur de Kanban.\nLimiter le WIP :\n\n• Réduit le changement de contexte\n• Met en évidence les goulots d\'étranglement\n• Accélère le throughput\n• Améliore la qualité (moins d\'erreurs de multitâche)\n• Augmente la prévisibilité\n\nComment définir les limites WIP :\n• Commencez avec membres de l\'équipe × 2 par colonne\n• Observez le flux et ajustez\n• La limite \"correcte\" crée une légère tension';

  @override
  String get kanbanMetricsTitle => 'Métriques Kanban';

  @override
  String get kanbanMetricsContent =>
      'Kanban utilise des métriques de flux pour mesurer et améliorer le processus.';

  @override
  String get kanbanMetric1 =>
      'Lead Time : Temps de la demande à la finalisation (inclut l\'attente)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time : Temps du début du travail à la finalisation';

  @override
  String get kanbanMetric3 => 'Throughput : Items terminés par unité de temps';

  @override
  String get kanbanMetric4 =>
      'WIP : Quantité de travail en cours à tout moment';

  @override
  String get kanbanMetric5 =>
      'Cumulative Flow Diagram (CFD) : Visualise l\'accumulation du travail dans le temps';

  @override
  String get kanbanCadencesTitle => 'Cadences Kanban';

  @override
  String get kanbanCadencesContent =>
      'Contrairement à Scrum, Kanban ne prescrit pas d\'événements fixes.\nCependant, des cadences régulières aident à l\'amélioration continue :\n\n• Standup Meeting : Synchronisation quotidienne devant le tableau\n• Replenishment Meeting : Priorisation du backlog\n• Delivery Planning : Planification des releases\n• Service Delivery Review : Revue des métriques\n• Risk Review : Analyse des risques et obstacles\n• Operations Review : Amélioration du processus';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Les swimlanes sont des lignes horizontales qui regroupent les cartes sur le tableau par un attribut commun.\n\nTypes de swimlane disponibles :\n• Classe de Service : Regrouper par priorité/urgence\n• Assigné : Regrouper par membre de l\'équipe\n• Priorité : Regrouper par niveau MoSCoW\n• Tag : Regrouper par étiquettes des stories\n\nLes swimlanes aident à :\n• Visualiser la charge de travail par personne\n• Gérer différentes classes de service (urgent, standard)\n• Identifier les goulots d\'étranglement par type de travail';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Politiques de Colonne';
  }

  @override
  String get kanbanPoliciesContent =>
      'Pratique Kanban #4 : \'Rendre les politiques explicites\' nécessite de définir des règles claires pour chaque colonne.\n\nExemples de politiques :\n• \'Max 24h dans cette colonne\' - temps maximum\n• \'Nécessite une code review approuvée\' - critères de sortie\n• \'Max 1 item par personne\' - limite individuelle\n• \'Mise à jour quotidienne obligatoire\' - communication\n\nLes politiques :\n• Rendent les attentes transparentes pour tous\n• Réduisent l\'ambiguïté et les conflits\n• Facilitent l\'intégration de nouveaux membres\n• Permettent d\'identifier quand les règles sont violées';

  @override
  String get kanbanBP1 =>
      'Visualisez TOUT le travail, y compris le travail caché';

  @override
  String get kanbanBP2 => 'Respectez rigoureusement les limites WIP';

  @override
  String get kanbanBP3 => 'Concentrez-vous sur terminer, pas sur commencer';

  @override
  String get kanbanBP4 =>
      'Utilisez les métriques pour décider, pas pour juger les personnes';

  @override
  String get kanbanBP5 => 'Améliorez un pas à la fois';

  @override
  String get kanbanBP6 =>
      'Bloquez le nouveau travail si le WIP est à la limite';

  @override
  String get kanbanBP7 => 'Analysez les blocages et supprimez-les rapidement';

  @override
  String get kanbanBP8 =>
      'Utilisez des swimlanes pour les priorités ou types de travail';

  @override
  String get kanbanAP1 => 'Limites WIP trop élevées (ou absentes)';

  @override
  String get kanbanAP2 => 'Ignorer les blocages sur le tableau';

  @override
  String get kanbanAP3 =>
      'Ne pas respecter les limites quand \"c\'est urgent\"';

  @override
  String get kanbanAP4 =>
      'Colonnes trop génériques (ex. seulement À faire/Terminé)';

  @override
  String get kanbanAP5 => 'Ne pas tracer quand les items entrent/sortent';

  @override
  String get kanbanAP6 =>
      'Utiliser Kanban uniquement comme tableau de tâches sans principes';

  @override
  String get kanbanAP7 => 'Ne jamais analyser le Cumulative Flow Diagram';

  @override
  String get kanbanAP8 => 'Trop de swimlanes qui compliquent la visualisation';

  @override
  String get kanbanFAQ1Q => 'Comment gérer les urgences en Kanban ?';

  @override
  String get kanbanFAQ1A =>
      'Créez un swimlane \"Expedite\" avec limite WIP de 1. Les items expedite sautent la file mais doivent être rares. Si tout est urgent, rien n\'est urgent.';

  @override
  String get kanbanFAQ2Q =>
      'Kanban fonctionne-t-il pour le développement logiciel ?';

  @override
  String get kanbanFAQ2A =>
      'Absolument oui. Kanban est né chez Toyota mais est largement utilisé dans le développement logiciel. Il est particulièrement adapté aux équipes de maintenance, DevOps et support.';

  @override
  String get kanbanFAQ3Q => 'Comment définir les limites WIP initiales ?';

  @override
  String get kanbanFAQ3A =>
      'Formule de départ : (membres de l\'équipe + 1) par colonne. Observez pendant 2 semaines et réduisez graduellement jusqu\'à créer une légère tension. La limite optimale varie pour chaque équipe et contexte.';

  @override
  String get kanbanFAQ4Q =>
      'Combien de temps faut-il pour voir des résultats avec Kanban ?';

  @override
  String get kanbanFAQ4A =>
      'Les premières améliorations (visibilité) sont immédiates. La réduction du Lead Time se voit en 2-4 semaines. Des améliorations significatives du processus nécessitent 2-3 mois.';

  @override
  String get hybridOverview =>
      'Scrumban combine des éléments de Scrum et Kanban pour créer une approche flexible\nqui s\'adapte au contexte de l\'équipe. Il maintient la structure de Sprint avec\nla flexibilité du flux continu et les limites WIP.\n\nScrumban est idéal pour :\n• Les équipes souhaitant passer de Scrum à Kanban (ou vice versa)\n• Les projets avec un mix de développement de fonctionnalités et de maintenance\n• Les équipes voulant des Sprints mais avec plus de flexibilité\n• Quand Scrum \"pur\" est trop rigide pour le contexte';

  @override
  String get hybridFromScrumTitle => 'De Scrum : Structure';

  @override
  String get hybridFromScrumContent =>
      'Scrumban maintient certains éléments structurés de Scrum pour la prévisibilité.';

  @override
  String get hybridFromScrum1 =>
      'Sprint (optionnel) : Itérations à durée fixe pour la cadence';

  @override
  String get hybridFromScrum2 =>
      'Sprint Planning : Sélection du travail pour la période';

  @override
  String get hybridFromScrum3 => 'Rétrospective : Réflexion et amélioration';

  @override
  String get hybridFromScrum4 => 'Démo/Review : Partage de la valeur produite';

  @override
  String get hybridFromScrum5 =>
      'Story Points : Pour les estimations et prédictions (optionnel)';

  @override
  String get hybridFromKanbanTitle => 'De Kanban : Flux';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban adopte les principes de flux Kanban pour l\'efficacité.';

  @override
  String get hybridFromKanban1 =>
      'Limites WIP : Limitation du travail en cours';

  @override
  String get hybridFromKanban2 =>
      'Système Pull : L\'équipe \"tire\" le travail quand elle a de la capacité';

  @override
  String get hybridFromKanban3 =>
      'Visualisation : Tableau partagé et transparent';

  @override
  String get hybridFromKanban4 =>
      'Métriques de flux : Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Amélioration continue : Politiques explicites et expérimentation';

  @override
  String get hybridOnDemandTitle => 'Planning à la Demande';

  @override
  String get hybridOnDemandContent =>
      'En Scrumban, le planning peut être \"à la demande\" au lieu d\'être à intervalles fixes.\n\nLe planning se déclenche quand :\n• Le backlog \"Ready\" descend sous un seuil\n• De nouvelles demandes urgentes doivent être priorisées\n• Un jalon approche\n\nCela réduit les sessions de planning quand elles ne sont pas nécessaires\net permet de réagir plus vite aux changements.';

  @override
  String get hybridWhenTitle => 'Quand Utiliser Quoi';

  @override
  String get hybridWhenContent =>
      'Scrumban n\'est pas \"tout faire\". C\'est choisir les bons éléments pour le contexte.\n\nUtilisez des éléments Scrum quand :\n• La prévisibilité des livraisons est nécessaire\n• Les parties prenantes veulent des démos régulières\n• L\'équipe bénéficie d\'un rythme fixe\n\nUtilisez des éléments Kanban quand :\n• Le travail est imprévisible (support, bug fixing)\n• La réactivité aux urgences est nécessaire\n• L\'accent est mis sur le throughput continu';

  @override
  String get hybridBP1 =>
      'Commencez avec ce que vous connaissez et ajoutez des éléments graduellement';

  @override
  String get hybridBP2 =>
      'Les limites WIP sont non négociables, même avec des Sprints';

  @override
  String get hybridBP3 =>
      'Utilisez les Sprints pour la cadence, pas comme engagement rigide';

  @override
  String get hybridBP4 =>
      'Gardez la Rétrospective, c\'est le moteur de l\'amélioration';

  @override
  String get hybridBP5 =>
      'Les métriques de flux aident plus que la Vélocité pure';

  @override
  String get hybridBP6 => 'Expérimentez une chose à la fois';

  @override
  String get hybridBP7 =>
      'Documentez les politiques de l\'équipe et révisez-les régulièrement';

  @override
  String get hybridBP8 =>
      'Envisagez des swimlanes pour séparer features et maintenance';

  @override
  String get hybridAP1 =>
      'Prendre le pire des deux (rigidité Scrum + chaos Kanban)';

  @override
  String get hybridAP2 =>
      'Éliminer les Rétrospectives parce que \"nous sommes flexibles\"';

  @override
  String get hybridAP3 =>
      'Limites WIP ignorées parce que \"nous avons des Sprints\"';

  @override
  String get hybridAP4 => 'Changer de framework à chaque Sprint';

  @override
  String get hybridAP5 => 'N\'avoir aucune cadence (ni Sprint ni autre)';

  @override
  String get hybridAP6 => 'Confondre flexibilité avec absence de règles';

  @override
  String get hybridAP7 => 'Ne rien mesurer';

  @override
  String get hybridAP8 => 'Trop de complexité pour le contexte';

  @override
  String get hybridFAQ1Q => 'Scrumban a-t-il des Sprints ou non ?';

  @override
  String get hybridFAQ1A =>
      'Cela dépend de l\'équipe. Vous pouvez avoir des Sprints pour la cadence (review, planning) mais permettre un flux continu de travail dans le Sprint. Ou vous pouvez éliminer les Sprints et avoir uniquement des cadences Kanban.';

  @override
  String get hybridFAQ2Q => 'Comment mesurer la performance en Scrumban ?';

  @override
  String get hybridFAQ2A =>
      'Utilisez à la fois les métriques Scrum (Vélocité si vous utilisez Sprint et Story Points) et les métriques Kanban (Lead Time, Cycle Time, Throughput). Les métriques de flux sont souvent plus utiles pour l\'amélioration.';

  @override
  String get hybridFAQ3Q => 'Par où commencer avec Scrumban ?';

  @override
  String get hybridFAQ3A =>
      'Si vous venez de Scrum : ajoutez des limites WIP et visualisez le flux. Si vous venez de Kanban : ajoutez des cadences régulières pour review et planning. Partez de ce que l\'équipe connaît et ajoutez de manière incrémentale.';

  @override
  String get hybridFAQ4Q => 'Scrumban est-il \"moins Agile\" que Scrum pur ?';

  @override
  String get hybridFAQ4A =>
      'Non. Agile ne signifie pas suivre un framework spécifique. Scrumban peut être plus Agile car il s\'adapte au contexte. L\'important est d\'inspecter et d\'adapter continuellement.';

  @override
  String get retroNoResults => 'Aucun résultat pour la recherche';

  @override
  String get retroFilterAll => 'Toutes';

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
  String get retroDeleteSuccess => 'Rétrospective supprimée avec succès';

  @override
  String retroDeleteError(String error) {
    return 'Erreur lors de la suppression : $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Supprimer définitivement';

  @override
  String get retroNewRetroTitle => 'Nouvelle Rétrospective';

  @override
  String get retroLinkToSprint => 'Lier au Sprint ?';

  @override
  String get retroNoProjectFound => 'Aucun projet trouvé.';

  @override
  String get retroSelectProject => 'Sélectionner le Projet';

  @override
  String get retroSelectSprint => 'Sélectionner le Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Sprint $number';
  }

  @override
  String get retroOwner => 'Proprietario';

  @override
  String get retroGuest => 'Ospite';

  @override
  String get retroSessionTitle => 'Titre de la Session';

  @override
  String get retroSessionTitleHint => 'Ex : Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Modèle';

  @override
  String get retroVotesPerUser => 'Votes par utilisateur :';

  @override
  String get retroActionClose => 'Fermer';

  @override
  String get retroActionCreate => 'Créer';

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
      'Glissez une carte ici pour créer un Action Item associé';

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
  String get facilitatorGuideMissing => 'Actions manquantes pour';

  @override
  String get retroPhaseStart => 'Commencer';

  @override
  String get retroPhaseStop => 'Arrêter';

  @override
  String get retroPhaseContinue => 'Continuer';

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
  String get retroColumnLonged => 'Souhaité';

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
  String get agileAcceptanceCriteria => 'Critères d\'Acceptation';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed sur $total éléments';
  }

  @override
  String get agileEstimateRequired =>
      'Estimation requise (cliquez pour estimer)';

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
  String get agileNoAcceptanceCriteria => 'Aucun critère d\'acceptation défini';

  @override
  String get agileDescription => 'Description';

  @override
  String get agileNoDescription => 'Aucune description';

  @override
  String get agileTags => 'Tags';

  @override
  String get agileEstimates => 'Estimations';

  @override
  String get agileFinalEstimate => 'Estimation Finale';

  @override
  String agileEstimatesReceived(int count) {
    return '$count estimations reçues';
  }

  @override
  String get agileInformation => 'Informations';

  @override
  String get agileBusinessValue => 'Business Value';

  @override
  String get agileAssignee => 'Assigné à';

  @override
  String get agileNoAssignee => 'Non assigné';

  @override
  String get agileCreatedBy => 'Créé par';

  @override
  String get agileCreatedAt => 'Créé le';

  @override
  String get agileStartedAt => 'Commencé le';

  @override
  String get agileCompletedAt => 'Terminé le';

  @override
  String get agileSprintTitle => 'Sprint';

  @override
  String get agileNewSprint => 'New Sprint';

  @override
  String get agileNoSprints => 'No sprints';

  @override
  String get agileCreateFirstSprint => 'Create the first sprint to start';

  @override
  String get agileSprintStatusPlanning => 'Planning';

  @override
  String get agileSprintStatusActive => 'Active';

  @override
  String get agileSprintStatusReview => 'Review';

  @override
  String get agileSprintStatusCompleted => 'Completed';

  @override
  String get agileStartSprint => 'Start Sprint';

  @override
  String get agileCompleteSprint => 'Complete Sprint';

  @override
  String get agileDeleteSprint => 'Delete';

  @override
  String get agileSprintName => 'Sprint Name';

  @override
  String get agileSprintGoal => 'Sprint Goal';

  @override
  String get agileSprintGoalHint => 'Objective of the sprint';

  @override
  String get agileStartDate => 'Start Date';

  @override
  String get agileEndDate => 'End Date';

  @override
  String get agileStatsStories => 'stories';

  @override
  String get agileStatsPoints => 'pts';

  @override
  String get agileStatsCompleted => 'completed';

  @override
  String get agileStatsVelocity => 'velocity';

  @override
  String agileDaysRemainingCount(String count) {
    return '$count jours restants';
  }

  @override
  String get agileAverageVelocity => 'Avg Velocity';

  @override
  String agileTeamMembersCount(String count) {
    return 'Team: $count members';
  }

  @override
  String get agileActionCancel => 'Cancel';

  @override
  String get agileActionSave => 'Save';

  @override
  String get agileActionCreate => 'Create';

  @override
  String get agileSprintPlanningTitle => 'Sprint Planning';

  @override
  String get agileSprintPlanningSubtitle =>
      'Select stories to complete in this sprint';

  @override
  String get agileBurndownChart => 'Burndown Chart';

  @override
  String get agileBurndownIdeal => 'Idéal';

  @override
  String get agileBurndownActual => 'Réel';

  @override
  String get agileBurndownPlanned => 'Planifiés';

  @override
  String get agileBurndownRemaining => 'Restants';

  @override
  String get agileBurndownNoData => 'Aucune donnée burndown';

  @override
  String get agileBurndownNoDataHint =>
      'Les données apparaîtront lorsque le sprint sera actif';

  @override
  String get agileVelocityTrend => 'Tendance Velocity';

  @override
  String get agileVelocityNoData => 'Aucune donnée velocity';

  @override
  String get agileVelocityNoDataHint =>
      'Complétez au moins un sprint pour voir la tendance';

  @override
  String get agileTeamCapacity => 'Capacité de l\'Équipe';

  @override
  String get agileTeamCapacityScrum => 'Capacité de l\'Équipe (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Capacité de l\'Équipe (Heures)';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity =>
      'Capacité Suggérée pour le Sprint Planning';

  @override
  String get agileSuggestedCapacityHint =>
      'Basé sur la velocity moyenne ± écart type (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Complétez au moins 1 sprint pour obtenir des suggestions de capacité';

  @override
  String get agileScrumGuideNote =>
      'Le Scrum Guide recommande de baser la planification sur la Velocity historique, et non sur les heures.';

  @override
  String get agileHoursAvailable => 'Disponible';

  @override
  String get agileHoursAssigned => 'Assigné';

  @override
  String get agileHoursOverloaded => 'Surchargé';

  @override
  String get agileHoursTotal => 'Capacité Totale';

  @override
  String get agileHoursUtilization => 'Utilisation';

  @override
  String agileMetricsTitle(String framework) {
    return 'Métriques $framework';
  }

  @override
  String get agileItemsCompleted => 'Items Complétés';

  @override
  String get agileInProgress => 'En Cours';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Distribution des Stories';

  @override
  String get agileCompletionRate => 'Taux de Complétion';

  @override
  String get agileAccuracy => 'Précision des Estimations';

  @override
  String get agileEfficiency => 'Flow Efficiency';

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
  String get planFree => 'Gratuit';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Actif';

  @override
  String get statusTrialing => 'En essai';

  @override
  String get statusPastDue => 'Paiement en retard';

  @override
  String get statusPaused => 'En pause';

  @override
  String get statusCancelled => 'Annulé';

  @override
  String get statusExpired => 'Expiré';

  @override
  String get cycleMonthly => 'Mensuel';

  @override
  String get cycleQuarterly => 'Trimestriel';

  @override
  String get cycleYearly => 'Annuel';

  @override
  String get cycleLifetime => 'À vie';

  @override
  String get pricePerMonth => 'mois';

  @override
  String get pricePerQuarter => 'trim';

  @override
  String get pricePerYear => 'an';

  @override
  String get priceForever => 'à vie';

  @override
  String get priceFree => 'Gratuit';

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
  String get actionSubmit => 'Envoyer';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker : Un Mot';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Décrivez ce sprint en UN seul mot';

  @override
  String get retroIcebreakerOneWordHint => 'Votre mot...';

  @override
  String get retroIcebreakerSubmitted => 'Envoyé !';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count mots envoyés';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker : Météo';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Quelle météo représente le mieux comment vous vous sentez par rapport à ce sprint ?';

  @override
  String get retroWeatherSunny => 'Ensoleillé';

  @override
  String get retroWeatherPartlyCloudy => 'Partiellement nuageux';

  @override
  String get retroWeatherCloudy => 'Nuageux';

  @override
  String get retroWeatherRainy => 'Pluvieux';

  @override
  String get retroWeatherStormy => 'Orageux';

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
  String get retroIcebreakerTwoTruths => 'Deux Vérités et un Mensonge';

  @override
  String get retroDescTwoTruths => 'Simple et classique.';

  @override
  String get retroIcebreakerCheckin => 'Check-in Émotionnel';

  @override
  String get retroDescCheckin => 'Comment se sentent tous les membres ?';

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
  String get retroAddCardButton => 'Ajouter une Carte';

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
      'Votre rétrospective a été exportée sur Google Sheets.';

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
  String get smartTodoAddItem => 'Ajouter un élément';

  @override
  String get smartTodoAddImageUrl => 'Ajouter une Image (URL)';

  @override
  String get smartTodoNone => 'Aucun';

  @override
  String get smartTodoPointsHint => 'Points (ex. 5)';

  @override
  String get smartTodoNewItem => 'Nouvel élément';

  @override
  String get smartTodoDeleteComment => 'Supprimer';

  @override
  String get priorityHigh => 'HAUTE';

  @override
  String get priorityMedium => 'MOYENNE';

  @override
  String get priorityLow => 'BASSE';

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
    return '$count activités ajoutées à $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count activités ajoutées au projet $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Session d\'estimation créée avec $count activités';
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
  String get archiveShowArchived => 'Afficher Archivés';

  @override
  String get archiveHideArchived => 'Masquer Archivés';

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
  String get archiveSuccessMessage => 'Projet archivé';

  @override
  String get archiveRestoreSuccessMessage => 'Projet restauré';

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
  String get archiveBadge => 'ARCHIVÉ';

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

  @override
  String get agileEdit => 'Modifier';

  @override
  String get agileSettings => 'Paramètres';

  @override
  String get agileDelete => 'Supprimer';

  @override
  String get agileDeleteProjectTitle => 'Supprimer Projet';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$projectName\" ?';
  }

  @override
  String get agileDeleteProjectWarning =>
      'Cette action supprimera définitivement :';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count user stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count sprints';
  }

  @override
  String get agileDeleteProjectData => 'Toutes les données du projet';

  @override
  String get agileProjectSettingsTitle => 'Paramètres du Projet';

  @override
  String get agileKeyRoles => 'Rôles Clés';

  @override
  String get agileKeyRolesSubtitle =>
      'Attribuer les rôles principaux de l\'équipe Scrum';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Gère le backlog et définit les priorités';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Facilite le processus Scrum et élimine les obstacles';

  @override
  String get agileRoleDevTeam => 'Équipe de Développement';

  @override
  String get agileNoDevTeamMembers => 'Aucun membre. Cliquez + pour ajouter.';

  @override
  String get agileRolesInfo =>
      'Les rôles seront affichés avec des icônes dans la liste. Vous pouvez ajouter d\'autres participants depuis l\'équipe.';

  @override
  String agileAssignedTo(String name) {
    return 'Assigné à $name';
  }

  @override
  String get agileUnassigned => 'Unassigned';

  @override
  String get agileAssignableLater => 'Assignable après création';

  @override
  String get agileAddToTeam => 'Ajouter à l\'Équipe';

  @override
  String get agileAllMembersAssigned =>
      'Tous les participants ont déjà un rôle.';

  @override
  String get agileClose => 'Fermer';

  @override
  String get agileProjectNameLabel => 'Nom du Projet *';

  @override
  String get agileProjectNameHint => 'Ex : Fashion PMO v2';

  @override
  String get agileEnterProjectName => 'Entrer le nom du projet';

  @override
  String get agileProjectDescLabel => 'Description';

  @override
  String get agileProjectDescHint => 'Description optionnelle';

  @override
  String get agileFrameworkLabel => 'Framework Agile';

  @override
  String get agileDiscoverDifferences => 'Découvrir les différences';

  @override
  String get agileSprintConfig => 'Configuration du Sprint';

  @override
  String get agileSprintDuration => 'Durée Sprint (jours)';

  @override
  String get agileHoursPerDay => 'Heures/Jour';

  @override
  String get agileCreateProjectTitle => 'Nouveau Projet Agile';

  @override
  String get agileEditProjectTitle => 'Modifier Projet';

  @override
  String get agileSelectParticipant => 'Sélectionner participant';

  @override
  String get agileAssignRolesHint =>
      'Assigner rôles clés. Modifiable dans les paramètres.';

  @override
  String get agileArchiveAction => 'Archiver';

  @override
  String get agileRestoreAction => 'Restaurer';

  @override
  String get agileSetupTitle => 'Configuration du Projet';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed sur $total étapes terminées';
  }

  @override
  String get agileSetupCompleteTitle => 'Configuration Terminée !';

  @override
  String get agileSetupCompleteMessage => 'Votre projet est prêt à démarrer.';

  @override
  String get agileChecklistAddMembers => 'Ajouter des membres';

  @override
  String get agileChecklistAddMembersDesc => 'Invitez des membres à collaborer';

  @override
  String get agileChecklistInvite => 'Inviter';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Créer premières $itemType';
  }

  @override
  String get agileChecklistAddItems => 'Ajouter au moins 3 items au backlog';

  @override
  String get agileChecklistAdd => 'Ajouter';

  @override
  String get agileChecklistWipLimits => 'Configurer limites WIP';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Définir limites pour chaque colonne Kanban';

  @override
  String get agileChecklistConfigure => 'Configurer';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Estimer $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Assigner Story Points pour mieux planifier';

  @override
  String get agileChecklistCreateSprint => 'Créer premier Sprint';

  @override
  String get agileChecklistSprintDesc =>
      'Sélectionner histoires et commencer à travailler';

  @override
  String get agileChecklistCreateSprintAction => 'Créer Sprint';

  @override
  String get agileChecklistStartWork => 'Commencer à travailler';

  @override
  String get agileChecklistStartWorkDesc => 'Déplacer un item vers en cours';

  @override
  String get agileTipStartSprintTitle => 'Prêt pour un Sprint ?';

  @override
  String get agileTipStartSprintMessage =>
      'Vous avez assez d\'histoires. Pensez à planifier le premier Sprint.';

  @override
  String get agileTipWipTitle => 'Configurer Limites WIP';

  @override
  String get agileTipWipMessage =>
      'Les limites WIP sont clés en Kanban. Limitez le travail en cours pour améliorer le flux.';

  @override
  String get agileTipHybridTitle => 'Configurez votre Scrumban';

  @override
  String get agileTipHybridMessage =>
      'Utilisez Sprints pour la cadence ou WIP pour le flux. Expérimentez !';

  @override
  String get agileTipDiscover => 'Découvrir';

  @override
  String get agileTipClose => 'Fermer';

  @override
  String get agileNextStepInviteTitle => 'Inviter Équipe';

  @override
  String get agileNextStepInviteDesc => 'Ajouter membres pour collaborer.';

  @override
  String get agileNextStepBacklogTitle => 'Créer Backlog';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Ajouter premières $itemType au backlog.';
  }

  @override
  String get agileNextStepSprintTitle => 'Planifier un Sprint';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'Vous avez $count items prêts. Créez le Sprint !';
  }

  @override
  String get agileNextStepWipTitle => 'Configurer Limites WIP';

  @override
  String get agileNextStepWipDesc =>
      'Limitez le travail en cours pour améliorer le flux.';

  @override
  String get agileNextStepWorkTitle => 'Commencer à travailler';

  @override
  String get agileNextStepWorkDesc =>
      'Déplacez un item vers \"En Cours\" pour commencer.';

  @override
  String get agileNextStepGoToKanban => 'Aller au Kanban';

  @override
  String get agileActionNewStory => 'Nouvelle Histoire';

  @override
  String get agileBacklogTitle => 'Backlog Produit';

  @override
  String get agileBacklogArchiveTitle => 'Archive Terminée';

  @override
  String get agileBacklogToggleActive => 'Voir Backlog actif';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Voir Archive ($count)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Archive ($count)';
  }

  @override
  String get agileBacklogSearchHint =>
      'Rechercher par titre, description ou ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count histoires';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points pts';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count estimées';
  }

  @override
  String get agileFiltersStatus => 'État :';

  @override
  String get agileFiltersPriority => 'Priorité :';

  @override
  String get agileFiltersTags => 'Tags :';

  @override
  String get agileFiltersAll => 'Tous';

  @override
  String get agileFiltersClear => 'Effacer filtres';

  @override
  String get agileEmptyBacklogMatch => 'Aucune histoire trouvée';

  @override
  String get agileEmptyBacklog => 'Backlog vide';

  @override
  String get agileEmptyBacklogHint => 'Ajoutez la première User Story';

  @override
  String get agileEstTitle => 'Estimer l\'Histoire';

  @override
  String get agileEstMethod => 'Méthode d\'estimation';

  @override
  String get agileEstSelectValue => 'Sélectionnez une valeur';

  @override
  String get agileEstSubmit => 'Confirmer Estimation';

  @override
  String get agileEstCancel => 'Annuler';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc => 'Sélectionnez la complexité en story points';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc =>
      'Sélectionnez la taille relative de l\'histoire';

  @override
  String get agileEstThreePointTitle => 'Estimation Trois Points (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Entrez trois valeurs pour calculer PERT';

  @override
  String get agileEstBucketTitle => 'Système de Seaux (Bucket)';

  @override
  String get agileEstBucketDesc => 'Placez l\'histoire dans le seau approprié';

  @override
  String get agileEstBucketHint =>
      'Les seaux plus grands indiquent une plus grande complexité';

  @override
  String get agileEstReference => 'Référence :';

  @override
  String get agileEstRefXS => 'XS = Quelques heures';

  @override
  String get agileEstRefS => 'S = ~1 jour';

  @override
  String get agileEstRefM => 'M = ~2-3 jours';

  @override
  String get agileEstRefL => 'L = ~1 semaine';

  @override
  String get agileEstRefXL => 'XL = ~2 semaines';

  @override
  String get agileEstRefXXL => 'XXL = Trop grand, diviser';

  @override
  String get agileEstOptimistic => 'Optimiste (O)';

  @override
  String get agileEstOptimisticHint => 'Meilleur cas';

  @override
  String get agileEstMostLikely => 'Plus Probable (M)';

  @override
  String get agileEstMostLikelyHint => 'Cas probable';

  @override
  String get agileEstPessimistic => 'Pessimiste (P)';

  @override
  String get agileEstPessimisticHint => 'Pire cas';

  @override
  String get agileEstPointsSuffix => 'pts';

  @override
  String get agileEstFormula => 'Formule PERT : (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Estimation : $value points';
  }

  @override
  String get agileEstErrorThreePoint => 'Entrez les trois valeurs';

  @override
  String get agileEstErrorSelect => 'Sélectionnez une valeur';

  @override
  String agileEstExisting(int count) {
    return 'Estimations existantes ($count)';
  }

  @override
  String get agileEstYou => 'Vous';

  @override
  String get scrumPermBacklogTitle => 'Permissions du Backlog';

  @override
  String get scrumPermBacklogDesc =>
      'Seul le Product Owner peut créer, modifier, supprimer et prioriser les stories';

  @override
  String get scrumPermSprintTitle => 'Permissions du Sprint';

  @override
  String get scrumPermSprintDesc =>
      'Seul le Scrum Master peut créer, démarrer et terminer les sprints';

  @override
  String get scrumPermEstimateTitle => 'Permissions d\'Estimation';

  @override
  String get scrumPermEstimateDesc =>
      'Seule l\'Équipe de Développement peut estimer les stories';

  @override
  String get scrumPermKanbanTitle => 'Permissions Kanban';

  @override
  String get scrumPermKanbanDesc =>
      'L\'Équipe de Développement peut déplacer ses propres stories, PO et SM peuvent déplacer n\'importe quelle story';

  @override
  String get scrumPermTeamTitle => 'Permissions de l\'Équipe';

  @override
  String get scrumPermTeamDesc =>
      'PO et SM peuvent inviter des membres, seul le PO peut modifier les rôles';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Seul le Product Owner peut créer de nouvelles stories';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Seul le Product Owner peut modifier les stories';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Seul le Product Owner peut supprimer les stories';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Seul le Product Owner peut réorganiser le backlog';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Seul le Scrum Master peut créer de nouveaux sprints';

  @override
  String get scrumPermDeniedSprintStart =>
      'Seul le Scrum Master peut démarrer les sprints';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Seul le Scrum Master peut terminer les sprints';

  @override
  String get scrumPermDeniedEstimate =>
      'Seule l\'Équipe de Développement peut estimer les stories';

  @override
  String get scrumPermDeniedInvite =>
      'Seuls PO et SM peuvent inviter de nouveaux membres';

  @override
  String get scrumPermDeniedRoleChange =>
      'Seul le Product Owner peut modifier les rôles de l\'équipe';

  @override
  String get scrumPermDeniedWipConfig =>
      'Seul le Scrum Master peut configurer les limites WIP';

  @override
  String get scrumRoleProductOwner => 'Product Owner';

  @override
  String get scrumRoleScrumMaster => 'Scrum Master';

  @override
  String get scrumRoleDeveloper => 'Développeur';

  @override
  String get scrumRoleDesigner => 'Designer';

  @override
  String get scrumRoleQA => 'QA';

  @override
  String get scrumRoleStakeholder => 'Partie Prenante';

  @override
  String get scrumMatrixTitle => 'Matrice des Permissions Scrum';

  @override
  String get scrumMatrixSubtitle =>
      'Qui peut faire quoi selon le Guide Scrum 2020';

  @override
  String get scrumMatrixLegend => 'Légende';

  @override
  String get scrumMatrixLegendFull => 'Gère';

  @override
  String get scrumMatrixLegendPartial => 'Partiel';

  @override
  String get scrumMatrixLegendView => 'Voir seul';

  @override
  String get scrumMatrixLegendNone => 'Aucun';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'ESTIMATION';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'ÉQUIPE';

  @override
  String get scrumMatrixCategoryRetro => 'RÉTROSPECTIVE';

  @override
  String get scrumMatrixActionCreateStory => 'Créer Story';

  @override
  String get scrumMatrixActionEditStory => 'Modifier Story';

  @override
  String get scrumMatrixActionDeleteStory => 'Supprimer Story';

  @override
  String get scrumMatrixActionPrioritize => 'Prioriser Backlog';

  @override
  String get scrumMatrixActionAddAcceptance =>
      'Définir Critères d\'Acceptation';

  @override
  String get scrumMatrixActionCreateSprint => 'Créer Sprint';

  @override
  String get scrumMatrixActionStartSprint => 'Démarrer Sprint';

  @override
  String get scrumMatrixActionCompleteSprint => 'Terminer Sprint';

  @override
  String get scrumMatrixActionConfigWip => 'Configurer Limites WIP';

  @override
  String get scrumMatrixActionEstimate => 'Estimer Story Points';

  @override
  String get scrumMatrixActionFinalEstimate => 'Définir Estimation Finale';

  @override
  String get scrumMatrixActionMoveOwn => 'Déplacer ses propres Stories';

  @override
  String get scrumMatrixActionMoveAny => 'Déplacer n\'importe quelle Story';

  @override
  String get scrumMatrixActionSelfAssign => 'S\'auto-assigner';

  @override
  String get scrumMatrixActionAssignOthers => 'Assigner d\'autres';

  @override
  String get scrumMatrixActionChangeStatus => 'Changer statut Story';

  @override
  String get scrumMatrixActionInvite => 'Inviter membres';

  @override
  String get scrumMatrixActionRemove => 'Supprimer membres';

  @override
  String get scrumMatrixActionChangeRole => 'Changer rôles';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Faciliter Rétrospective';

  @override
  String get scrumMatrixActionParticipateRetro => 'Participer à Rétrospective';

  @override
  String get scrumMatrixActionAddRetroItem => 'Ajouter item Rétro';

  @override
  String get scrumMatrixActionVoteRetro => 'Voter items';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Inviter à l\'équipe';

  @override
  String get agileInviteNew => 'NOUVELLE INVITATION';

  @override
  String get agileInviteEmailLabel => 'E-mail';

  @override
  String get agileInviteEmailHint => 'nom@exemple.com';

  @override
  String get agileInviteEnterEmail => 'Entrez un e-mail';

  @override
  String get agileInviteInvalidEmail => 'E-mail invalide';

  @override
  String get agileInviteProjectRole => 'Rôle dans le projet';

  @override
  String get agileInviteTeamRole => 'Rôle dans l\'équipe';

  @override
  String get agileInviteSendEmail => 'Envoyer un e-mail de notification';

  @override
  String get agileInviteSendBtn => 'Envoyer l\'invitation';

  @override
  String get agileInviteLink => 'Lien d\'invitation :';

  @override
  String get agileInviteLinkCopied => 'Lien copié !';

  @override
  String get agileInviteListTitle => 'INVITATIONS';

  @override
  String get agileInviteClose => 'Fermer';

  @override
  String get agileInviteGmailAuthTitle => 'Autorisation Gmail';

  @override
  String get agileInviteGmailAuthContent =>
      'Pour envoyer des e-mails d\'invitation, vous devez vous réauthentifier avec Google.\n\nVoulez-vous continuer ?';

  @override
  String get agileInviteGmailAuthNo => 'Non, lien seulement';

  @override
  String get agileInviteGmailAuthYes => 'Autoriser';

  @override
  String agileInviteSentEmail(String email) {
    return 'Invitation envoyée par e-mail à $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Invitation créée pour $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Révoquer l\'invitation ?';

  @override
  String get agileInviteRevokeContent => 'L\'invitation ne sera plus valide.';

  @override
  String get agileInviteRevokeBtn => 'Révoquer';

  @override
  String get agileInviteResend => 'Renvoyer';

  @override
  String get agileInviteResent => 'Invitation renvoyée';

  @override
  String get agileInviteStatusPending => 'En attente';

  @override
  String get agileInviteStatusAccepted => 'Accepté';

  @override
  String get agileInviteStatusDeclined => 'Refusé';

  @override
  String get agileInviteStatusExpired => 'Expiré';

  @override
  String get agileInviteStatusRevoked => 'Révoqué';

  @override
  String get agileRoleMember => 'Membre';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Observateur';

  @override
  String get agileRoleOwner => 'Propriétaire';

  @override
  String get agileEditStory => 'Edit Story';

  @override
  String get agileNewStory => 'New User Story';

  @override
  String get agileDetailsTab => 'Details';

  @override
  String get agileAcceptanceCriteriaTab => 'Acceptance Criteria';

  @override
  String get agileOtherTab => 'Other';

  @override
  String get agileTitleLabel => 'Title';

  @override
  String get agileTitleHint => 'Short description of the feature';

  @override
  String get agileUseStoryTemplate => 'Use User Story template';

  @override
  String get agileStoryTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get agileAsA => 'As a...';

  @override
  String get agileAsAHint => 'user, admin, customer...';

  @override
  String get agileIWant => 'I want...';

  @override
  String get agileIWantHint => 'to be able to do something...';

  @override
  String get agileSoThat => 'So that...';

  @override
  String get agileSoThatHint => 'I get a benefit...';

  @override
  String get agileDescriptionLabel => 'Description';

  @override
  String get agileDescriptionHint => 'Free description of the story';

  @override
  String get agilePreview => 'Preview:';

  @override
  String get agileEmptyDescription => '(empty description)';

  @override
  String get agileDefineComplete =>
      'Define when the story can be considered complete';

  @override
  String get agileAddCriterionHint => 'Add acceptance criterion...';

  @override
  String get agileNoCriteria => 'No criteria defined';

  @override
  String get agileSuggestions => 'Suggestions:';

  @override
  String get agilePriorityMoscow => 'Priority (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Low business value';

  @override
  String get agileBusinessValueMedium => 'Medium value';

  @override
  String get agileBusinessValueHigh => 'High business value';

  @override
  String get agileEstimatedStoryPoints => 'Estimated in Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Story Points represent relative complexity.\nUse Fibonacci sequence: 1 (simple) -> 21 (very complex).';

  @override
  String get agileNoPoints => 'None';

  @override
  String get agileAddTagHint => 'Add tag...';

  @override
  String get agileExistingTags => 'Existing tags:';

  @override
  String get agileAssignTo => 'Assign to';

  @override
  String get agileSelectMemberHint => 'Select a team member';

  @override
  String get agilePointsComplexityVeryLow => 'Quick and simple task';

  @override
  String get agilePointsComplexityLow => 'Medium complexity task';

  @override
  String get agilePointsComplexityMedium => 'Complex task, requires analysis';

  @override
  String get agilePointsComplexityHigh => 'Very complex, consider splitting';

  @override
  String agileDurationDays(Object days) {
    return 'Duration: $days days';
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
  String get agileSelectedPoints => 'Selected';

  @override
  String get agileSuggestedPoints => 'Suggested';

  @override
  String agileDaysRemaining(Object days) {
    return '$days days remaining';
  }

  @override
  String get agileSelectAtLeastOne => 'Select at least 1 story';

  @override
  String agileConfirmStories(String count) {
    return 'Confirmer ($count stories)';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Les politiques explicites définissent les règles pour cette colonne (Pratique Kanban #4)';

  @override
  String get kanbanPoliciesEmpty => 'Aucune politique définie';

  @override
  String get kanbanPoliciesAdd => 'Ajouter une politique';

  @override
  String get kanbanPoliciesHint => 'Ex: Max 24h dans cette colonne';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Politiques actives: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Revue du travail accompli avec les parties prenantes';

  @override
  String get sprintReviewConductBy => 'Animé par';

  @override
  String get sprintReviewDate => 'Date de la Review';

  @override
  String get sprintReviewAttendees => 'Participants';

  @override
  String get sprintReviewSelectAttendees => 'Sélectionner les participants';

  @override
  String get sprintReviewDemoNotes => 'Notes de Démo';

  @override
  String get sprintReviewDemoNotesHint =>
      'Décrivez les fonctionnalités démontrées';

  @override
  String get sprintReviewFeedback => 'Retours Reçus';

  @override
  String get sprintReviewFeedbackHint => 'Retours des parties prenantes';

  @override
  String get sprintReviewBacklogUpdates => 'Mises à Jour du Backlog';

  @override
  String get sprintReviewBacklogUpdatesHint =>
      'Modifications du backlog discutées';

  @override
  String get sprintReviewNextFocus => 'Focus Prochain Sprint';

  @override
  String get sprintReviewNextFocusHint => 'Priorités pour le prochain sprint';

  @override
  String get sprintReviewMarketNotes => 'Notes Marché/Budget';

  @override
  String get sprintReviewMarketNotesHint =>
      'Conditions du marché, planning, budget';

  @override
  String get sprintReviewStoriesCompleted => 'Stories Terminées';

  @override
  String get sprintReviewStoriesNotCompleted => 'Stories Non Terminées';

  @override
  String get sprintReviewPointsCompleted => 'Points Complétés';

  @override
  String get sprintReviewSave => 'Enregistrer la Review';

  @override
  String get sprintReviewWarning => 'Attention: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'La Sprint Review n\'a pas encore été effectuée. Selon le Scrum Guide 2020, la Sprint Review est un événement obligatoire avant de terminer le sprint.';

  @override
  String get sprintReviewCompleteAnyway => 'Terminer quand même';

  @override
  String get sprintReviewDoReview => 'Effectuer la Review';

  @override
  String get sprintReviewCompleted => 'Sprint Review terminée';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Regrouper les cartes par attribut';

  @override
  String get swimlaneTypeNone => 'Aucune';

  @override
  String get swimlaneTypeNoneDesc => 'Vue standard sans regroupement';

  @override
  String get swimlaneTypeClassOfService => 'Classe de Service';

  @override
  String get swimlaneTypeClassOfServiceDesc => 'Regrouper par priorité/urgence';

  @override
  String get swimlaneTypeAssignee => 'Assigné';

  @override
  String get swimlaneTypeAssigneeDesc => 'Regrouper par membre de l\'équipe';

  @override
  String get swimlaneTypePriority => 'Priorité';

  @override
  String get swimlaneTypePriorityDesc => 'Regrouper par niveau de priorité';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Regrouper par tag de la story';

  @override
  String get swimlaneUnassigned => 'Non Assigné';

  @override
  String get swimlaneNoTag => 'Sans Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Mesure la quantité de story points complétés par sprint. Aide à prévoir la capacité de l\'équipe.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Temps total de la création à la complétion. Inclut le temps d\'attente dans le backlog.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Temps du début du travail à la complétion. Mesure l\'efficacité du développement.';

  @override
  String get agileMetricsThroughputDesc =>
      'Nombre d\'items complétés par unité de temps. Indique la productivité.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualise la distribution par statut. Aide à identifier les goulots d\'étranglement.';

  @override
  String get agilePredictability => 'Prévisibilité';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% des items sont complétés en ≤$days jours';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Items complétés/semaine (dernières $weeks sem.)';
  }

  @override
  String get agileNoDataVelocity => 'Aucune donnée velocity';

  @override
  String get agileNoDataLeadTime => 'Aucune donnée lead time';

  @override
  String get agileNoDataCycleTime => 'Aucune donnée cycle time';

  @override
  String get agileNoDataThroughput => 'Aucune donnée throughput';

  @override
  String get agileNoDataAccuracy => 'Aucune donnée de précision';

  @override
  String get agileStartFinishOneItem =>
      'Complétez au moins un item pour calculer';

  @override
  String get timeDays => 'jours';

  @override
  String get auditLogTitle => 'Journal d\'Audit';

  @override
  String auditLogEventCount(int count) {
    return '$count événements';
  }

  @override
  String get actionRefresh => 'Actualiser';

  @override
  String get auditLogFilterEntityType => 'Type';

  @override
  String get auditLogFilterAction => 'Action';

  @override
  String get auditLogFilterFromDate => 'Depuis';

  @override
  String get actionDetails => 'Détails';

  @override
  String get auditLogDetailsTitle => 'Détails de la Modification';

  @override
  String get auditLogPreviousValue => 'Valeur précédente :';

  @override
  String get auditLogNewValue => 'Nouvelle valeur :';

  @override
  String get auditLogNoEvents => 'Aucun événement enregistré';

  @override
  String get auditLogNoEventsDesc =>
      'Les activités du projet seront enregistrées ici';

  @override
  String get recentActivityTitle => 'Activité Récente';

  @override
  String get actionViewAll => 'Voir tout';

  @override
  String get recentActivityNone => 'Aucune activité récente';

  @override
  String get burndownChartTitle => 'Burndown Chart';

  @override
  String get agileIdeal => 'Idéal';

  @override
  String get agileActual => 'Réel';

  @override
  String get agileRemaining => 'Restants';

  @override
  String get agileBurndownNoDataDesc =>
      'Les données apparaîtront lorsque le sprint sera actif';

  @override
  String get agileCompleteActiveFirst =>
      'Complétez le sprint actif avant d\'en démarrer un autre';

  @override
  String get kanbanSwimlanes => 'Swimlanes :';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'Sans tag';

  @override
  String get kanbanWipExceededBanner =>
      'Limite WIP dépassée ! Terminez certains items avant d\'en commencer de nouveaux.';

  @override
  String get kanbanConfigWip => 'Configurer WIP';

  @override
  String get kanbanPoliciesDesc =>
      'Les politiques explicites aident l\'équipe à comprendre les règles de cette colonne.';

  @override
  String get kanbanNewPolicyHint => 'Nouvelle politique...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP : $count sur $limit max';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'Les limites WIP (Work In Progress) sont des limites sur le nombre d\'items pouvant se trouver dans une colonne en même temps.';

  @override
  String get kanbanUnderstand => 'J\'ai compris';

  @override
  String get agileHours => 'Heures';

  @override
  String get agileStoriesPerSprint => 'Stories / Sprint';

  @override
  String get agileSprints => 'Sprints';

  @override
  String get agileTeamComposition => 'Composition de l\'Équipe';

  @override
  String get agileHoursNote =>
      'Les heures sont une référence interne. Pour la planification Scrum, utilisez la vue Story Points.';

  @override
  String get agileNoTeamMembers => 'Aucun membre dans l\'équipe';

  @override
  String get agileGmailAuthError =>
      'Autorisation Gmail non disponible. Essayez de vous déconnecter et reconnecter.';

  @override
  String get agileGmailPermissionDenied => 'Permission Gmail non accordée.';

  @override
  String get agileResend => 'Renvoyer';

  @override
  String get agileRevoke => 'Révoquer';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filtres';

  @override
  String get agilePlanned => 'Planifié';

  @override
  String get archiveDeleteSuccess => 'Archivé/supprimé avec succès';

  @override
  String get agileNoItems => 'Aucun élément à afficher';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed sur $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Éléments Complétés';

  @override
  String get agileDaysRemainingSuffix => 'jours restants';

  @override
  String get agileItems => 'items';

  @override
  String get agilePerWeekSuffix => '/sett';

  @override
  String get average => 'Moyenne';

  @override
  String agileItemsCount(int count) {
    return '$count éléments';
  }

  @override
  String get agileDaysLeft => 'Jours Restants';

  @override
  String get all => 'Tous';

  @override
  String get kanbanGuidePoliciesTitle => 'Politiques Explicites';

  @override
  String get agileDaysLabel => 'Jours';

  @override
  String get agileStatRemaining => 'restants';

  @override
  String get agileStatsCompletedLabel => 'Complétés';

  @override
  String get agileStatsPlannedLabel => 'Planifiés';

  @override
  String get agileProgressLabel => 'Progression';

  @override
  String get agileDurationLabel => 'Durée';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Stories';

  @override
  String get agileSprintSummary => 'Résumé du Sprint';

  @override
  String get agileStoriesTotal => 'Stories totales';

  @override
  String get agileStoriesCompleted => 'Stories complétées';

  @override
  String get agilePointsCompletedLabel => 'Story Points complétés';

  @override
  String get agileStoriesIncomplete => 'Stories incomplètes';

  @override
  String get agileIncompleteReturnToBacklog => '(retourneront dans le backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Effectuer la Sprint Review';

  @override
  String get agileCompleteSprintAction => 'Clôturer le Sprint';

  @override
  String get agileMissingReview => 'Sprint Review pas encore effectuée';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review terminée';

  @override
  String get agileReviewNotesLabel => 'Notes de Review';

  @override
  String get agileReviewFeedbackLabel => 'Feedback des Stakeholders';

  @override
  String get agileReviewNextFocus => 'Focus du Prochain Sprint';

  @override
  String get agileBacklogUpdatesLabel => 'Modifications du Backlog';

  @override
  String get agileSaveReview => 'Enregistrer la Review';

  @override
  String get agileConductedBy => 'Conduite par';

  @override
  String get agileReviewDate => 'Date de Review';

  @override
  String get agileReviewOutcome => 'Résultat de la Review';

  @override
  String get agileStoriesRejected => 'Stories non acceptées';

  @override
  String get agileRejectedWarning =>
      'Les stories non complétées ou non acceptées retourneront automatiquement dans le Backlog.';

  @override
  String get agileReviewDemoHint => 'Qu\'a été présenté pendant la démo ?';

  @override
  String get agileReviewFeedbackHint => 'Feedback reçu des stakeholders';

  @override
  String get agileReviewBacklogHint => 'Nouvelle modification du backlog...';

  @override
  String get agileReviewNextFocusHint =>
      'Sur quoi l\'équipe devrait-elle se concentrer ?';

  @override
  String get agileReviewScrumGuide =>
      'Le Scrum Guide 2020 recommande d\'effectuer la Sprint Review avant de clôturer le sprint pour inspecter le travail réalisé avec les stakeholders.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Êtes-vous sûr de vouloir terminer \"$name\" ?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint terminé ! Velocity : $velocity pts/semaine';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review enregistrée';

  @override
  String get agileEstimationAccuracy => 'Précision des Estimations';

  @override
  String get agileCompleteOneSprintFirst => 'Complétez au moins un sprint';

  @override
  String get agileNoDataAccuracyFix => 'Aucune donnée de précision';

  @override
  String get agileScrumGuideRecommends =>
      'Le Scrum Guide recommande la planification basée sur la Velocity historique, et non sur les heures.';

  @override
  String get agileNoSkillsDefined => 'Aucune compétence définie';

  @override
  String get agileAddSkillsToMembers =>
      'Ajoutez des compétences aux membres de l\'équipe';

  @override
  String get retroNoSprintWarningTitle => 'Aucun Sprint Terminé';

  @override
  String get retroNoSprintWarningMessage =>
      'Pour créer une rétrospective Scrum, vous devez d\'abord terminer au moins un sprint. Les rétrospectives sont liées aux sprints pour suivre les améliorations d\'une itération à l\'autre.';

  @override
  String get agileGoToSprints => 'Aller aux Sprints';

  @override
  String get agileSprintReviewHistory => 'Historique des Sprint Reviews';

  @override
  String get agileNoSprintReviews => 'Aucune Sprint Review';

  @override
  String get agileNoSprintReviewsHint =>
      'Complétez un sprint et effectuez une Sprint Review pour la voir ici';

  @override
  String get agileAttendees => 'Participants';

  @override
  String get agileStoryEvaluations => 'Évaluation des Stories';

  @override
  String get agileDecisions => 'Décisions';

  @override
  String get agileDemoNotes => 'Notes de Démo';

  @override
  String get agileFeedback => 'Feedback';

  @override
  String get agileStoryApproved => 'Approuvée';

  @override
  String get agileStoryNeedsRefinement => 'À Affiner';

  @override
  String get agileStoryRejected => 'Rejetée';

  @override
  String get agileAddAttendee => 'Ajouter un Participant';

  @override
  String get agileAddDecision => 'Ajouter une Décision';

  @override
  String get agileEvaluateStories => 'Évaluer les Stories';

  @override
  String get agileSelectRole => 'Sélectionner un Rôle';

  @override
  String get agileStatsNotCompleted => 'Non Complétées';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Membres de l\'Équipe';

  @override
  String get eisenhowerImportCsv => 'Importer CSV';

  @override
  String get eisenhowerImportPreview => 'Aperçu des activités';

  @override
  String get eisenhowerImportSelectFile =>
      'Sélectionnez un fichier CSV à importer';

  @override
  String get eisenhowerImportFormatHint =>
      'Format attendu : Activité, Description, Quadrant, Urgence, Importance';

  @override
  String get eisenhowerImportClickToSelect =>
      'Cliquez pour sélectionner un fichier';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Formats supportés : .csv (UTF-8 ou Latin-1)';

  @override
  String get eisenhowerImportNoActivities =>
      'Aucune activité trouvée dans le fichier';

  @override
  String get eisenhowerImportMarkRevealed => 'Marquer comme déjà votées';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Les activités apparaîtront directement dans le quadrant calculé';

  @override
  String eisenhowerImportSuccess(int count) {
    return '$count activités importées';
  }

  @override
  String get actionSelectAll => 'Tout sélectionner';

  @override
  String get actionDeselectAll => 'Tout désélectionner';

  @override
  String get actionImport => 'Importer';

  @override
  String get eisenhowerImportShowInstructions =>
      'Afficher/masquer les instructions';

  @override
  String get eisenhowerImportInstructionsTitle => 'Format CSV Requis';

  @override
  String get eisenhowerImportInstructionsBody =>
      'Le fichier CSV doit contenir au moins la colonne \'Activité\' ou \'Title\'. Colonnes optionnelles : Description, Urgence (1-10), Importance (1-10). La première ligne doit être l\'en-tête.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Activité,Description,Urgence,Importance\n\"Nom activité\",\"Description optionnelle\",8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Changer de fichier';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return '$count lignes ignorées à cause d\'erreurs';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...et $count autres lignes';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return '$valid activités valides trouvées sur $total lignes';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Ligne $row : titre vide';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Ligne $row : format invalide';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      'Colonne \'Activité\' ou \'Title\' non trouvée dans l\'en-tête';

  @override
  String get eisenhowerImportErrorEmptyFile => 'Le fichier est vide';

  @override
  String get eisenhowerImportErrorNoHeader =>
      'En-tête non trouvé dans la première ligne';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Ligne $row';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Impossible de lire le fichier';

  @override
  String get agileSprintHealthTitle => 'Santé du Sprint';

  @override
  String get agileSprintHealthNoSprint => 'Aucun sprint actif';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Démarrez un sprint pour voir les métriques de santé';

  @override
  String get agileSprintHealthGoal => 'Objectif du Sprint';

  @override
  String get agileSprintHealthOnTrack => 'En Bonne Voie';

  @override
  String get agileSprintHealthAtRisk => 'À Risque';

  @override
  String get agileSprintHealthOffTrack => 'En Retard';

  @override
  String get agileSprintHealthTime => 'Temps';

  @override
  String get agileSprintHealthWork => 'Travail';

  @override
  String get agileSprintHealthDaysLeft => 'jours restants';

  @override
  String get agileSprintHealthSpRemaining => 'SP restants';

  @override
  String get agileSprintHealthStoriesDone => 'Stories Terminées';

  @override
  String get agileSprintHealthCommitment => 'Fiabilité';

  @override
  String get agileSprintHealthDailyVelocity => 'Vélocité Quotidienne';

  @override
  String get agileSprintHealthPrediction => 'Prévision';

  @override
  String get agileSprintHealthOnTime => 'À temps';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Répartition des Stories';

  @override
  String get agileSprintBurndownTitle => 'Sprint Burndown';

  @override
  String get agileSprintBurndownNoData => 'Aucune donnée de burndown';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Assignez des stories au sprint pour voir le burndown';

  @override
  String get agileWorkloadTitle => 'Charge de l\'Équipe';

  @override
  String get agileWorkloadBalanced => 'Équilibré';

  @override
  String get agileWorkloadUnbalanced => 'Déséquilibré';

  @override
  String get agileWorkloadTotalStories => 'Stories Totales';

  @override
  String get agileWorkloadAssigned => 'Assignées';

  @override
  String get agileWorkloadAvgSp => 'SP Moy./Personne';

  @override
  String get agileWorkloadStories => 'stories';

  @override
  String get agileWorkloadInProgress => 'en cours';

  @override
  String get agileWorkloadUnassigned => 'Non assignées';

  @override
  String get agileWorkloadUnassignedWarning => 'stories sans assigné';

  @override
  String get agileWorkloadNoStories => 'Aucune story à analyser';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Créez des stories et assignez-les aux membres de l\'équipe';

  @override
  String get agileWorkloadOverloaded => 'Surchargé';

  @override
  String get agileCommitmentTrendTitle => 'Tendance Fiabilité Engagement';

  @override
  String get agileCommitmentTrendNoData => 'Aucune donnée disponible';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Complétez au moins un sprint pour voir la tendance';

  @override
  String get agileCommitmentTrendPlanned => 'Planifiés';

  @override
  String get agileCommitmentTrendCompleted => 'Complétés';

  @override
  String get agileCommitmentTrendAvg => 'Moyenne';

  @override
  String get agileFlowEfficiencyTitle => 'Efficacité du Flux & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'Aucune donnée disponible';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Ajoutez des stories pour voir l\'analyse du flux';

  @override
  String get agileFlowEfficiency => 'Efficacité du Flux';

  @override
  String get agileFlowCycleTime => 'Temps de Cycle';

  @override
  String get agileFlowLeadTime => 'Délai Total';

  @override
  String get agileFlowDays => 'jours';

  @override
  String get agileFlowWipByStatus => 'WIP par Statut';

  @override
  String get agileFlowAvg => 'moy';

  @override
  String get agileBlockedItemsTitle => 'Éléments Bloqués';

  @override
  String get agileBlockedItemsNone => 'Aucun élément bloqué';

  @override
  String get agileBlockedItemsNoneDesc =>
      'Toutes les dépendances sont satisfaites';

  @override
  String agileBlockedItemsCount(Object count) {
    return '$count bloqués';
  }

  @override
  String get agileBlockedItemsSp => 'SP bloqués';

  @override
  String get agileBlockedItemsBlockedBy => 'Bloqué par';

  @override
  String get agileBlockedItemsDependency => 'dépendance';

  @override
  String get agileBlockedItemsDependencies => 'dépendances';

  @override
  String get agileSprintScopeTitle => 'Scope du Sprint';

  @override
  String get agileSprintScopeNoSprint => 'Aucun sprint actif';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Démarrez un sprint pour surveiller les changements de scope';

  @override
  String get agileSprintScopeOriginal => 'Original';

  @override
  String get agileSprintScopeCurrent => 'Actuel';

  @override
  String get agileSprintScopeDelta => 'Delta';

  @override
  String get agileSprintScopeCreep => 'Dérive du Scope';

  @override
  String get agileSprintScopeReduction => 'Réduction du Scope';

  @override
  String get agileSprintScopeStable => 'Stable';

  @override
  String get agileSprintScopeSp => 'SP';
}
