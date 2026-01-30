// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get smartTodoListOrigin => 'List origin';

  @override
  String get smartTodoSortTooltip => 'Sort Options';

  @override
  String get smartTodoSortManual => 'Manual';

  @override
  String get smartTodoSortDate => 'Recent';

  @override
  String get smartTodoActionSortPriority => 'Reorder by Priority';

  @override
  String get smartTodoActionSortDeadline => 'Reorder by Deadline';

  @override
  String get smartTodoOrderUpdated => 'Order updated manually';

  @override
  String get newRetro => 'New Retro';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Go to Home';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionCreate => 'Create';

  @override
  String get actionAdd => 'Add';

  @override
  String get actionClose => 'Close';

  @override
  String get actionRetry => 'Retry';

  @override
  String get exportAllData => 'Export All Data (Full Report)';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionSearch => 'Search';

  @override
  String get actionFilter => 'Filter';

  @override
  String get actionExport => 'Export';

  @override
  String get actionExportCsv => 'Export CSV';

  @override
  String get retroBoard => 'Board Items';

  @override
  String get actionCopy => 'Copy';

  @override
  String get actionShare => 'Share';

  @override
  String get actionDone => 'Done';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionOpen => 'Open';

  @override
  String get stateLoading => 'Loading...';

  @override
  String get stateEmpty => 'No items';

  @override
  String get stateError => 'Error';

  @override
  String get stateSuccess => 'Success';

  @override
  String get subscriptionCurrent => 'CURRENT';

  @override
  String get subscriptionRecommended => 'RECOMMENDED';

  @override
  String get subscriptionFree => 'Free';

  @override
  String get subscriptionPerMonth => '/month';

  @override
  String get subscriptionPerYear => '/year';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Save €$amount/year';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days days free trial';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Unlimited projects';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count active projects';
  }

  @override
  String get subscriptionUnlimitedLists => 'Unlimited lists';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Smart Todo lists';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Active projects';

  @override
  String get subscriptionSmartTodoListsLabel => 'Smart Todo Lists';

  @override
  String get subscriptionUnlimitedTasks => 'Unlimited tasks';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count tasks per project';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Unlimited invites';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count invites per project';
  }

  @override
  String get subscriptionWithAds => 'With ads';

  @override
  String get subscriptionWithoutAds => 'Without ads';

  @override
  String get authSignInGoogle => 'Sign in with Google';

  @override
  String get authSignOut => 'Sign out';

  @override
  String get authLogoutConfirm => 'Are you sure you want to sign out?';

  @override
  String get formNameRequired => 'Enter your name';

  @override
  String get authError => 'Authentication error';

  @override
  String get authUserNotFound => 'User not found';

  @override
  String get authWrongPassword => 'Wrong password';

  @override
  String get authEmailInUse => 'Email already in use';

  @override
  String get authWeakPassword => 'Password too weak';

  @override
  String get authInvalidEmail => 'Invalid email';

  @override
  String get appSubtitle => 'Keisen for Teams';

  @override
  String get authOr => 'or';

  @override
  String get authPassword => 'Password';

  @override
  String get authRegister => 'Register';

  @override
  String get authLogin => 'Login';

  @override
  String get authHaveAccount => 'Already have an account?';

  @override
  String get authNoAccount => 'Don\'t have an account?';

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get eisenhowerTitle => 'Eisenhower Matrix';

  @override
  String get eisenhowerYourMatrices => 'Your matrices';

  @override
  String get eisenhowerNoMatrices => 'No matrices created';

  @override
  String get eisenhowerNewMatrix => 'New Matrix';

  @override
  String get eisenhowerViewGrid => 'Grid';

  @override
  String get eisenhowerViewChart => 'Chart';

  @override
  String get eisenhowerViewList => 'List';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'URGENT';

  @override
  String get quadrantNotUrgent => 'NOT URGENT';

  @override
  String get quadrantImportant => 'IMPORTANT';

  @override
  String get quadrantNotImportant => 'NOT IMPORTANT';

  @override
  String get quadrantQ1Title => 'DO NOW';

  @override
  String get quadrantQ2Title => 'SCHEDULE';

  @override
  String get quadrantQ3Title => 'DELEGATE';

  @override
  String get quadrantQ4Title => 'ELIMINATE';

  @override
  String get quadrantQ1Subtitle => 'Urgent and Important';

  @override
  String get quadrantQ2Subtitle => 'Important, Not Urgent';

  @override
  String get quadrantQ3Subtitle => 'Urgent, Not Important';

  @override
  String get quadrantQ4Subtitle => 'Not Urgent, Not Important';

  @override
  String get eisenhowerNoActivities => 'No activities';

  @override
  String get eisenhowerNewActivity => 'New Activity';

  @override
  String get eisenhowerExportSheets => 'Export to Google Sheets';

  @override
  String get eisenhowerInviteParticipants => 'Invite Participants';

  @override
  String get eisenhowerDeleteMatrix => 'Delete Matrix';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Are you sure you want to delete this matrix?';

  @override
  String get eisenhowerActivityTitle => 'Activity title';

  @override
  String get eisenhowerActivityNotes => 'Notes';

  @override
  String get eisenhowerDueDate => 'Due date';

  @override
  String get eisenhowerPriority => 'Priority';

  @override
  String get eisenhowerAssignee => 'Assignee';

  @override
  String get eisenhowerCompleted => 'Completed';

  @override
  String get eisenhowerMoveToQuadrant => 'Move to quadrant';

  @override
  String get eisenhowerMatrixSettings => 'Matrix Settings';

  @override
  String get eisenhowerBackToList => 'List';

  @override
  String get eisenhowerPriorityList => 'Priority List';

  @override
  String get eisenhowerAllActivities => 'All activities';

  @override
  String get eisenhowerToVote => 'To vote';

  @override
  String get eisenhowerVoted => 'Voted';

  @override
  String get eisenhowerTotal => 'Total';

  @override
  String get eisenhowerEditParticipants => 'Edit participants';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count activities';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count votes';
  }

  @override
  String get eisenhowerModifyVotes => 'Modify votes';

  @override
  String get eisenhowerVote => 'Vote';

  @override
  String get eisenhowerQuadrant => 'Quadrant';

  @override
  String get eisenhowerUrgencyAvg => 'Average urgency';

  @override
  String get eisenhowerImportanceAvg => 'Average importance';

  @override
  String get eisenhowerVotesLabel => 'Votes:';

  @override
  String get eisenhowerNoVotesYet => 'No votes collected yet';

  @override
  String get eisenhowerEditMatrix => 'Edit Matrix';

  @override
  String get eisenhowerAddActivity => 'Add Activity';

  @override
  String get eisenhowerDeleteActivity => 'Delete Activity';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matrix created successfully';

  @override
  String get eisenhowerMatrixUpdated => 'Matrix updated';

  @override
  String get eisenhowerMatrixDeleted => 'Matrix deleted';

  @override
  String get eisenhowerActivityAdded => 'Activity added';

  @override
  String get eisenhowerActivityDeleted => 'Activity deleted';

  @override
  String get eisenhowerVotesSaved => 'Votes saved';

  @override
  String get eisenhowerExportCompleted => 'Export completed!';

  @override
  String get eisenhowerExportAll => 'Export All Data';

  @override
  String get eisenhowerExportCompletedDialog => 'Export Completed';

  @override
  String get eisenhowerExportDialogContent =>
      'The Google Sheets has been created.\nDo you want to open it in the browser?';

  @override
  String get eisenhowerOpen => 'Open';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Add participants to the matrix first';

  @override
  String get eisenhowerSearchLabel => 'Search:';

  @override
  String get eisenhowerSearchHint => 'Search matrices...';

  @override
  String get eisenhowerNoMatrixFound => 'No matrix found';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Create your first Eisenhower Matrix\nto organize your priorities';

  @override
  String get eisenhowerCreateMatrix => 'Create Matrix';

  @override
  String get eisenhowerClickToOpen => 'Eisenhower Matrix\nClick to open';

  @override
  String get eisenhowerTotalActivities => 'Total activities in matrix';

  @override
  String get eisenhowerVotedActivities => 'Voted activities';

  @override
  String get eisenhowerPendingVoting => 'Activities to vote';

  @override
  String get eisenhowerStartVoting => 'Start Independent Voting';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Do you want to start an independent voting session for \"$title\"?\n\nEach participant will vote without seeing others\' votes, until everyone has voted and votes are revealed.';
  }

  @override
  String get eisenhowerStart => 'Start';

  @override
  String get eisenhowerVotingStarted => 'Voting started';

  @override
  String get eisenhowerResetVoting => 'Reset Voting?';

  @override
  String get eisenhowerResetVotingDesc => 'All votes will be deleted.';

  @override
  String get eisenhowerVotingReset => 'Voting reset';

  @override
  String get eisenhowerMinVotersRequired =>
      'At least 2 voters required for independent voting';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Also all $count activities will be deleted.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Your matrices ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Enter a title';

  @override
  String get formTitleHint => 'E.g.: Q1 2025 Priorities';

  @override
  String get formDescriptionHint => 'Optional description';

  @override
  String get formParticipantHint => 'Participant name';

  @override
  String get formAddParticipantHint => 'Add at least one participant to vote';

  @override
  String get formActivityTitleHint => 'E.g.: Complete API documentation';

  @override
  String get errorCreatingMatrix => 'Error creating matrix';

  @override
  String get errorUpdatingMatrix => 'Error updating';

  @override
  String get errorDeletingMatrix => 'Error deleting';

  @override
  String get errorAddingActivity => 'Error adding activity';

  @override
  String get errorSavingVotes => 'Error saving votes';

  @override
  String get errorExport => 'Error during export';

  @override
  String get errorStartingVoting => 'Error starting voting';

  @override
  String get errorResetVoting => 'Error resetting';

  @override
  String get errorLoadingActivities => 'Error loading activities';

  @override
  String get eisenhowerWaitingForVotes => 'Waiting for votes';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total votes';
  }

  @override
  String get eisenhowerVoteSubmit => 'VOTE';

  @override
  String get eisenhowerVotedSuccess => 'You have voted';

  @override
  String get eisenhowerRevealVotes => 'REVEAL VOTES';

  @override
  String get eisenhowerQuickVote => 'Quick Vote';

  @override
  String get eisenhowerTeamVote => 'Team Vote';

  @override
  String get eisenhowerUrgency => 'URGENCY';

  @override
  String get eisenhowerImportance => 'IMPORTANCE';

  @override
  String get eisenhowerUrgencyShort => 'U:';

  @override
  String get eisenhowerImportanceShort => 'I:';

  @override
  String get eisenhowerVotingInProgress => 'VOTING IN PROGRESS';

  @override
  String get eisenhowerWaitingForOthers =>
      'Waiting for everyone to vote. The facilitator will reveal the votes.';

  @override
  String get eisenhowerReady => 'Ready';

  @override
  String get eisenhowerWaiting => 'Waiting';

  @override
  String get eisenhowerIndividualVotes => 'INDIVIDUAL VOTES';

  @override
  String get eisenhowerResult => 'RESULT';

  @override
  String get eisenhowerAverage => 'AVERAGE';

  @override
  String get eisenhowerVotesRevealed => 'Votes Revealed';

  @override
  String get eisenhowerNextActivity => 'Next Activity';

  @override
  String get eisenhowerNoVotesRecorded => 'No votes recorded';

  @override
  String get eisenhowerWaitingForStart => 'Waiting';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Early votes that will be counted when the facilitator starts voting';

  @override
  String get eisenhowerObserverWaiting =>
      'Waiting for the facilitator to start collective voting';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Cast your vote early. It will be counted when voting starts.';

  @override
  String get eisenhowerPreVote => 'Pre-vote';

  @override
  String get eisenhowerPreVoted => 'Pre-voted';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Start collective voting session. Existing pre-votes will be preserved.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Reset voting by deleting all votes';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Observing the voting session...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'Waiting for all participants to vote';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Everyone has voted! Click to reveal results.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return '$count votes still missing';
  }

  @override
  String get eisenhowerVotingLocked => 'Voting closed';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Votes have been revealed. Voting is no longer possible for this activity.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online of $total participants online';
  }

  @override
  String get eisenhowerVoting => 'Voting';

  @override
  String get eisenhowerAllActivitiesVoted => 'All activities have been voted!';

  @override
  String get estimationTitle => 'Estimation Room';

  @override
  String get estimationYourSessions => 'Your sessions';

  @override
  String get estimationNoSessions => 'No sessions created';

  @override
  String get estimationNewSession => 'New Session';

  @override
  String get estimationEditSession => 'Edit Session';

  @override
  String get estimationJoinSession => 'Join session';

  @override
  String get estimationSessionCode => 'Session code';

  @override
  String get estimationEnterCode => 'Enter code';

  @override
  String get sessionStatusDraft => 'Draft';

  @override
  String get sessionStatusActive => 'Active';

  @override
  String get sessionStatusCompleted => 'Completed';

  @override
  String get sessionName => 'Session Name';

  @override
  String get sessionNameRequired => 'Session Name *';

  @override
  String get sessionNameHint => 'E.g.: Sprint 15 - User Stories Estimation';

  @override
  String get sessionDescription => 'Description';

  @override
  String get sessionCardSet => 'Card Set';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Simplified (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Estimation Mode';

  @override
  String get sessionEstimationModeLocked =>
      'Cannot change mode after voting has started';

  @override
  String get sessionAutoReveal => 'Auto-reveal';

  @override
  String get sessionAutoRevealDesc => 'Reveal when everyone votes';

  @override
  String get sessionAllowObservers => 'Observers';

  @override
  String get sessionAllowObserversDesc => 'Allow non-voting participants';

  @override
  String get sessionConfiguration => 'Configuration';

  @override
  String get voteConsensus => 'Consensus reached!';

  @override
  String get voteResults => 'Voting Results';

  @override
  String get voteRevote => 'Revote';

  @override
  String get voteReveal => 'Reveal';

  @override
  String get voteHide => 'Hide';

  @override
  String get voteAverage => 'Average';

  @override
  String get voteMedian => 'Median';

  @override
  String get voteMode => 'Mode';

  @override
  String get voteVoters => 'Voters';

  @override
  String get voteDistribution => 'Vote distribution';

  @override
  String get voteFinalEstimate => 'Final estimate';

  @override
  String get voteSelectFinal => 'Select final estimate';

  @override
  String get voteAverageTooltip => 'Arithmetic average of numeric votes';

  @override
  String get voteMedianTooltip => 'Middle value when votes are sorted';

  @override
  String get voteModeTooltip =>
      'Most frequent vote (the value chosen most often)';

  @override
  String get voteVotersTooltip => 'Total number of participants who voted';

  @override
  String get voteWaiting => 'Waiting for votes...';

  @override
  String get voteSubmitted => 'Vote submitted';

  @override
  String get voteNotSubmitted => 'Not voted';

  @override
  String get storyToEstimate => 'Story to estimate';

  @override
  String get storyTitle => 'Story title';

  @override
  String get storyDescription => 'Story description';

  @override
  String get storyAddNew => 'Add story';

  @override
  String get storyNoStories => 'No stories to estimate';

  @override
  String get storyComplete => 'Story completed';

  @override
  String get storySkip => 'Skip story';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'T-Shirt Sizes';

  @override
  String get estimationModeDecimal => 'Decimal';

  @override
  String get estimationModeThreePoint => 'Three-Point (PERT)';

  @override
  String get estimationModeDotVoting => 'Dot Voting';

  @override
  String get estimationModeBucketSystem => 'Bucket System';

  @override
  String get estimationModeFiveFingers => 'Five Fingers';

  @override
  String get estimationVotesRevealed => 'Votes Revealed';

  @override
  String get estimationVotingInProgress => 'Voting in Progress';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total votes';
  }

  @override
  String get estimationConsensusReached => 'Consensus Reached!';

  @override
  String get estimationVotingResults => 'Voting Results';

  @override
  String get estimationRevote => 'Revote';

  @override
  String get estimationAverage => 'Average';

  @override
  String get estimationAverageTooltip => 'Arithmetic mean of numeric votes';

  @override
  String get estimationMedian => 'Median';

  @override
  String get estimationMedianTooltip => 'Middle value when votes are sorted';

  @override
  String get estimationMode => 'Mode';

  @override
  String get estimationModeTooltip => 'Most frequent vote';

  @override
  String get estimationVoters => 'Voters';

  @override
  String get estimationVotersTooltip => 'Total number of participants';

  @override
  String get estimationVoteDistribution => 'Vote Distribution';

  @override
  String get estimationSelectFinalEstimate => 'Select Final Estimate';

  @override
  String get estimationFinalEstimate => 'Final Estimate';

  @override
  String get eisenhowerChartTitle => 'Activity Distribution';

  @override
  String get quadrantLabelDo => 'Q1 - DO';

  @override
  String get quadrantLabelPlan => 'Q2 - PLAN';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGATE';

  @override
  String get quadrantLabelEliminate => 'Q4 - ELIMINATE';

  @override
  String get eisenhowerNoRatedActivities => 'No rated activities';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Vote on activities to see them on the chart';

  @override
  String get eisenhowerChartCardTitle => 'Distribution Chart';

  @override
  String get raciAddColumnTitle => 'Add RACI Column';

  @override
  String get raciColumnType => 'Type';

  @override
  String get raciTypePerson => 'Person (Participant)';

  @override
  String get raciTypeCustom => 'Custom (Team/Other)';

  @override
  String get raciSelectParticipant => 'Select participant';

  @override
  String get raciColumnName => 'Column name';

  @override
  String get raciColumnNameHint => 'E.g.: Development Team';

  @override
  String get raciDeleteColumnTitle => 'Delete Column';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Delete column \'$name\'? Assignments will be lost.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online of $total participants online';
  }

  @override
  String get estimationNewStoryTitle => 'New Story';

  @override
  String get estimationStoryTitleLabel => 'Title *';

  @override
  String get estimationStoryTitleHint => 'Ex: US-123: As a user I want...';

  @override
  String get estimationStoryDescriptionLabel => 'Description';

  @override
  String get estimationStoryDescriptionHint => 'Acceptance criteria, notes...';

  @override
  String get estimationEnterTitleAlert => 'Please enter a title';

  @override
  String get estimationParticipantsHeader => 'Participants';

  @override
  String get estimationRoleFacilitator => 'Facilitator';

  @override
  String get estimationRoleVoters => 'Voters';

  @override
  String get estimationRoleObservers => 'Observers';

  @override
  String get estimationYouSuffix => '(you)';

  @override
  String get estimationDecimalTitle => 'Decimal Estimation';

  @override
  String get estimationDecimalHint =>
      'Enter your estimate in days (e.g. 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Quick select:';

  @override
  String get estimationDaysSuffix => 'days';

  @override
  String estimationVoteValue(String value) {
    return 'Vote: $value days';
  }

  @override
  String get estimationEnterValueAlert => 'Enter a value';

  @override
  String get estimationInvalidValueAlert => 'Invalid value';

  @override
  String estimationMinAlert(double value) {
    return 'Min: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Max: $value';
  }

  @override
  String get retroTitle => 'My Retrospectives';

  @override
  String get retroNoRetros => 'No retrospectives';

  @override
  String get retroNoRetrosFound => 'No retrospective found';

  @override
  String get retroCreateNew => 'Create New';

  @override
  String get retroChooseMode => 'Choose Retrospective Mode';

  @override
  String get retroQuickForm => 'Quick Form';

  @override
  String get retroInteractiveBoard => 'Interactive Board';

  @override
  String get retroQuickModeDesc =>
      'Fill a quick form to record the highlights of the sprint.';

  @override
  String get retroInteractiveModeDesc =>
      'Start a real-time board to collaborate with the whole team.';

  @override
  String get retroNoOperationsReview => 'No Operations Review';

  @override
  String get retroOperationsReview => 'Operations Review';

  @override
  String get retroOperationsReviewDesc =>
      'Create an Operations Review to improve the workflow';

  @override
  String get retroWentWell => 'What went well?';

  @override
  String get retroToImprove => 'What to improve?';

  @override
  String get retroWentWellHint => 'Add a positive point...';

  @override
  String get retroToImproveHint => 'Add a point to improve...';

  @override
  String get retroActionItemHint => 'Add an action item...';

  @override
  String get retroSave => 'Save Retrospective';

  @override
  String get retroOpenInteractiveBoard => 'Open Interactive Board';

  @override
  String get retroSentimentTeam => 'Team Sentiment';

  @override
  String get retroExcellent => 'Excellent';

  @override
  String get retroGood => 'Good';

  @override
  String get retroNormal => 'Normal';

  @override
  String get retroNeedsImprovement => 'Needs Improvement';

  @override
  String get retroCritical => 'Critical';

  @override
  String get retroNoElements => 'No elements';

  @override
  String get retroNoActionItemsFound => 'No action items';

  @override
  String retroAssignedTo(String email) {
    return 'Assigned to: $email';
  }

  @override
  String retroVotesCount(int count) {
    return '+$count votes';
  }

  @override
  String get retroGuidance => 'Retrospective Guide';

  @override
  String retroResultLabel(String score, String label) {
    return 'Average sentiment: $score ($label)';
  }

  @override
  String get retroSearchHint => 'Search retrospective...';

  @override
  String get agileProcessTitle => 'Agile Process Manager';

  @override
  String get agileSearchProjects => 'Search projects...';

  @override
  String get agileMethodologyGuide => 'Methodology Guide';

  @override
  String get agileMethodologyGuideTitle => 'Agile Methodology Guide';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Choose the methodology that best fits your project';

  @override
  String get agileNewProject => 'New Project';

  @override
  String get agileRoles => 'ROLES';

  @override
  String get agileProcessFlow => 'PROCESS FLOW';

  @override
  String get agileArtifacts => 'ARTIFACTS';

  @override
  String get agileBestPractices => 'Best Practices';

  @override
  String get agileAntiPatterns => 'Anti-Patterns to Avoid';

  @override
  String get agileFAQ => 'Frequently Asked Questions';

  @override
  String get agileScrumShortDesc =>
      'Fixed-time sprints, Velocity, Burndown. Ideal for products with evolving requirements.';

  @override
  String get agileKanbanShortDesc =>
      'Continuous flow, WIP Limits, Lead Time. Ideal for support and continuous requests.';

  @override
  String get agileScrumbanShortDesc =>
      'Mix of Sprints and continuous flow. Ideal for teams wanting flexibility.';

  @override
  String get agileRolePODesc => 'Manages backlog and priorities';

  @override
  String get agileRoleSMDesc => 'Facilitates the process and removes obstacles';

  @override
  String get agileRoleDevTeamDesc => 'Members developing the product';

  @override
  String get agileRoleStakeholdersDesc => 'Provide feedback and requirements';

  @override
  String get agileRoleSRMDesc => 'Manages incoming requests';

  @override
  String get agileRoleSDMDesc => 'Optimizes workflow';

  @override
  String get agileRoleTeamDesc => 'Executes work respecting WIP limits';

  @override
  String get agileRoleFlowMasterDesc => 'Optimizes flow and facilitates';

  @override
  String get agileRoleTeamHybridDesc => 'Cross-functional, self-organized';

  @override
  String get scrumOverview =>
      'Scrum is an iterative and incremental Agile framework for product development management.\nIt is based on fixed-time work cycles called Sprints, typically 2-4 weeks.\n\nScrum is ideal for:\n• Teams working on products with evolving requirements\n• Projects that benefit from regular feedback\n• Organizations that want to improve predictability and transparency';

  @override
  String get scrumRolesTitle => 'Scrum Roles';

  @override
  String get scrumRolesContent =>
      'Scrum defines three key roles that collaborate for the success of the project.';

  @override
  String get scrumRolesPO =>
      'Product Owner: Represents stakeholders, manages the Product Backlog and maximizes product value';

  @override
  String get scrumRolesSM =>
      'Scrum Master: Facilitates the Scrum process, removes impediments and helps the team improve';

  @override
  String get scrumRolesDev =>
      'Development Team: Cross-functional and self-organized team that delivers the product increment';

  @override
  String get scrumEventsTitle => 'Scrum Events';

  @override
  String get scrumEventsContent =>
      'Scrum provides regular events to create regularity and minimize unplanned meetings.';

  @override
  String get scrumEventsPlanning =>
      'Sprint Planning: Planning the Sprint work (max 8h for 4-week Sprint)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum: Daily team synchronization (15 minutes)';

  @override
  String get scrumEventsRetro =>
      'Sprint Retrospective: Team reflection for continuous improvement (max 3h)';

  @override
  String get scrumEventsRetroContent =>
      'Create a retrospective to analyze the last sprint and identify areas for improvement.';

  @override
  String get scrumEventsReview =>
      'Sprint Review: Demo of completed work to stakeholders (max 4h)';

  @override
  String get scrumArtifactsTitle => 'Scrum Artifacts';

  @override
  String get scrumArtifactsContent =>
      'Artifacts represent work or value and are designed to maximize transparency.';

  @override
  String get scrumArtifactsPB =>
      'Product Backlog: Ordered list of everything that might be needed in the product';

  @override
  String get scrumArtifactsSB =>
      'Sprint Backlog: Items selected for the Sprint + plan to deliver the increment';

  @override
  String get scrumArtifactsIncrement =>
      'Increment: Sum of all items completed during the Sprint, potentially releasable';

  @override
  String get scrumStoryPointsTitle => 'Story Points and Velocity';

  @override
  String get scrumStoryPointsContent =>
      'Story Points are a relative measure of User Story complexity.\nThey don\'t measure time, but effort, complexity and uncertainty.\n\nThe Fibonacci sequence (1, 2, 3, 5, 8, 13, 21) is commonly used because:\n• It reflects increasing uncertainty for larger items\n• It makes false precision difficult\n• It facilitates discussions during estimation\n\nVelocity is the average of Story Points completed in recent sprints and serves to:\n• Predict how much work can be included in upcoming sprints\n• Identify team productivity trends\n• Not compare different teams (each team has its own scale)';

  @override
  String get scrumBP1 =>
      'Keep Sprints at fixed duration and respect the timebox';

  @override
  String get scrumBP2 =>
      'The Product Backlog must always be prioritized and refined';

  @override
  String get scrumBP3 => 'User Stories must meet INVEST criteria';

  @override
  String get scrumBP4 => 'The Definition of Done must be clear and shared';

  @override
  String get scrumBP5 => 'Don\'t modify the Sprint Goal during the Sprint';

  @override
  String get scrumBP6 => 'Celebrate successes in the Sprint Review';

  @override
  String get scrumBP7 =>
      'The Retrospective must produce concrete improvement actions';

  @override
  String get scrumBP8 => 'The team must be cross-functional and self-organized';

  @override
  String get scrumAP1 => 'Sprint without a clear Sprint Goal';

  @override
  String get scrumAP2 => 'Daily Scrum turned into a report meeting';

  @override
  String get scrumAP3 => 'Skipping the Retrospective when \"too busy\"';

  @override
  String get scrumAP4 => 'Product Owner absent or unavailable';

  @override
  String get scrumAP5 => 'Adding work during the Sprint without removing other';

  @override
  String get scrumAP6 => 'Story Points converted to hours (loses meaning)';

  @override
  String get scrumAP7 => 'Team too large (ideal 5-9 people)';

  @override
  String get scrumAP8 => 'Scrum Master who \"assigns\" tasks to the team';

  @override
  String get scrumFAQ1Q => 'How long should a Sprint last?';

  @override
  String get scrumFAQ1A =>
      'Typical duration is 2 weeks, but can vary from 1 to 4 weeks. Shorter Sprints allow more frequent feedback and quick course corrections. Longer Sprints give more time to complete complex items. The important thing is to keep the duration constant.';

  @override
  String get scrumFAQ2Q =>
      'How to handle uncompleted work at the end of Sprint?';

  @override
  String get scrumFAQ2A =>
      'Uncompleted User Stories return to the Product Backlog and are re-prioritized. Never extend the Sprint or reduce the Definition of Done. Use the Retrospective to understand why it happened and how to prevent it.';

  @override
  String get scrumFAQ3Q => 'Can I change the Sprint Backlog during the Sprint?';

  @override
  String get scrumFAQ3A =>
      'The Sprint Goal should not change, but the Sprint Backlog can evolve. The team can negotiate with the PO the replacement of items of equal value. If the Sprint Goal becomes obsolete, the PO can cancel the Sprint.';

  @override
  String get scrumFAQ4Q => 'How to calculate initial Velocity?';

  @override
  String get scrumFAQ4A =>
      'For the first 3 Sprints, make conservative estimates. After 3 Sprints you will have a reliable Velocity. Don\'t use other teams\' Velocity as reference.';

  @override
  String get kanbanOverview =>
      'Kanban is a method for managing work that emphasizes flow visualization,\nWork In Progress (WIP) limitation and continuous process improvement.\n\nKanban is ideal for:\n• Support/maintenance teams with continuous requests\n• Environments where priorities change frequently\n• When it\'s not possible to plan in fixed iterations\n• Gradual transition to Agile';

  @override
  String get kanbanPrinciplesTitle => 'Kanban Principles';

  @override
  String get kanbanPrinciplesContent =>
      'Kanban is based on principles of incremental change and respect for existing roles.';

  @override
  String get kanbanPrinciple1 =>
      'Visualize the workflow: Make all work visible';

  @override
  String get kanbanPrinciple2 => 'Limit WIP: Complete work before starting new';

  @override
  String get kanbanPrinciple3 =>
      'Manage the flow: Optimize to maximize throughput';

  @override
  String get kanbanPrinciple4 => 'Make policies explicit: Define clear rules';

  @override
  String get kanbanPrinciple5 =>
      'Implement feedback loops: Continuously improve';

  @override
  String get kanbanPrinciple6 =>
      'Improve collaboratively: Evolve through experimentation';

  @override
  String get kanbanBoardTitle => 'Kanban Board';

  @override
  String get kanbanBoardContent =>
      'The board visualizes the workflow through its phases.\nEach column represents a work state (e.g. To Do, In Progress, Done).\n\nKey board elements:\n• Columns: Workflow states\n• Card/Ticket: Work units\n• WIP Limits: Limits per column\n• Swimlanes: Horizontal groupings (optional)';

  @override
  String get kanbanWIPTitle => 'WIP Limits';

  @override
  String get kanbanWIPContent =>
      'Work In Progress (WIP) limits are the heart of Kanban.\nLimiting WIP:\n\n• Reduces context switching\n• Highlights bottlenecks\n• Speeds up throughput\n• Improves quality (fewer multitasking errors)\n• Increases predictability\n\nHow to set WIP limits:\n• Start with team members × 2 per column\n• Observe the flow and adjust\n• The \"right\" limit creates a slight tension';

  @override
  String get kanbanMetricsTitle => 'Kanban Metrics';

  @override
  String get kanbanMetricsContent =>
      'Kanban uses flow metrics to measure and improve the process.';

  @override
  String get kanbanMetric1 =>
      'Lead Time: Time from request to completion (includes waiting)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time: Time from start of work to completion';

  @override
  String get kanbanMetric3 => 'Throughput: Items completed per unit of time';

  @override
  String get kanbanMetric4 => 'WIP: Amount of work in progress at any time';

  @override
  String get kanbanMetric5 =>
      'Cumulative Flow Diagram (CFD): Visualizes work accumulation over time';

  @override
  String get kanbanCadencesTitle => 'Kanban Cadences';

  @override
  String get kanbanCadencesContent =>
      'Unlike Scrum, Kanban doesn\'t prescribe fixed events.\nHowever, regular cadences help continuous improvement:\n\n• Standup Meeting: Daily synchronization in front of the board\n• Replenishment Meeting: Backlog prioritization\n• Delivery Planning: Release planning\n• Service Delivery Review: Metrics review\n• Risk Review: Risk and impediment analysis\n• Operations Review: Process improvement';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Swimlanes are horizontal rows that group cards on the board by a common attribute.\n\nAvailable swimlane types:\n• Class of Service: Group by work priority/urgency\n• Assignee: Group by assigned team member\n• Priority: Group by MoSCoW level\n• Tag: Group by story tags\n\nSwimlanes help to:\n• Visualize workload per person\n• Manage different service classes (urgent, standard)\n• Identify bottlenecks by work type';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Policies: $columnName';
  }

  @override
  String get kanbanPoliciesContent =>
      'Kanban Practice #4: \'Make Policies Explicit\' requires defining clear rules for each column.\n\nPolicy examples:\n• \'Max 24h in this column\' - maximum time\n• \'Requires approved code review\' - exit criteria\n• \'Max 1 item per person\' - individual limit\n• \'Daily update required\' - communication\n\nPolicies:\n• Make expectations transparent to everyone\n• Reduce ambiguity and conflicts\n• Facilitate onboarding of new members\n• Allow identifying when rules are violated';

  @override
  String get kanbanBP1 => 'Visualize ALL work, including hidden work';

  @override
  String get kanbanBP2 => 'Strictly respect WIP limits';

  @override
  String get kanbanBP3 => 'Focus on completing, not starting';

  @override
  String get kanbanBP4 => 'Use metrics for decisions, not to judge people';

  @override
  String get kanbanBP5 => 'Improve one step at a time';

  @override
  String get kanbanBP6 => 'Block new work if WIP is at limit';

  @override
  String get kanbanBP7 => 'Analyze blockers and remove them quickly';

  @override
  String get kanbanBP8 => 'Use swimlanes for priorities or work types';

  @override
  String get kanbanAP1 => 'WIP limits too high (or absent)';

  @override
  String get kanbanAP2 => 'Ignoring blocks on the board';

  @override
  String get kanbanAP3 => 'Not respecting limits when \"it\'s urgent\"';

  @override
  String get kanbanAP4 => 'Columns too generic (e.g. only To Do/Done)';

  @override
  String get kanbanAP5 => 'Not tracking when items enter/exit';

  @override
  String get kanbanAP6 => 'Using Kanban only as task board without principles';

  @override
  String get kanbanAP7 => 'Never analyzing the Cumulative Flow Diagram';

  @override
  String get kanbanAP8 => 'Too many swimlanes that complicate visualization';

  @override
  String get kanbanFAQ1Q => 'How to handle urgencies in Kanban?';

  @override
  String get kanbanFAQ1A =>
      'Create an \"Expedite\" swimlane with WIP limit of 1. Expedite items skip the queue but must be rare. If everything is urgent, nothing is urgent.';

  @override
  String get kanbanFAQ2Q => 'Does Kanban work for software development?';

  @override
  String get kanbanFAQ2A =>
      'Absolutely yes. Kanban was born at Toyota but is widely used in software development. It\'s particularly suitable for maintenance teams, DevOps, and support.';

  @override
  String get kanbanFAQ3Q => 'How to set initial WIP limits?';

  @override
  String get kanbanFAQ3A =>
      'Starting formula: (team members + 1) per column. Observe for 2 weeks and gradually reduce until creating a slight tension. The optimal limit varies for each team and context.';

  @override
  String get kanbanFAQ4Q => 'How long does it take to see results with Kanban?';

  @override
  String get kanbanFAQ4A =>
      'First improvements (visibility) are immediate. Lead Time reduction is seen in 2-4 weeks. Significant process improvements require 2-3 months.';

  @override
  String get hybridOverview =>
      'Scrumban combines elements of Scrum and Kanban to create a flexible approach\nthat adapts to the team\'s context. It maintains Sprint structure with\nthe flexibility of continuous flow and WIP limits.\n\nScrumban is ideal for:\n• Teams that want to transition from Scrum to Kanban (or vice versa)\n• Projects with a mix of feature development and maintenance\n• Teams that want Sprint but with more flexibility\n• When \"pure\" Scrum is too rigid for the context';

  @override
  String get hybridFromScrumTitle => 'From Scrum: Structure';

  @override
  String get hybridFromScrumContent =>
      'Scrumban maintains some structured elements of Scrum for predictability.';

  @override
  String get hybridFromScrum1 =>
      'Sprint (optional): Fixed-time iterations for cadence';

  @override
  String get hybridFromScrum2 =>
      'Sprint Planning: Selecting work for the period';

  @override
  String get hybridFromScrum3 => 'Retrospective: Reflection and improvement';

  @override
  String get hybridFromScrum4 => 'Demo/Review: Sharing produced value';

  @override
  String get hybridFromScrum5 =>
      'Story Points: For estimates and predictions (optional)';

  @override
  String get hybridFromKanbanTitle => 'From Kanban: Flow';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban adopts Kanban flow principles for efficiency.';

  @override
  String get hybridFromKanban1 => 'WIP Limits: Limitation of work in progress';

  @override
  String get hybridFromKanban2 =>
      'Pull System: Team \"pulls\" work when it has capacity';

  @override
  String get hybridFromKanban3 => 'Visualization: Shared and transparent board';

  @override
  String get hybridFromKanban4 =>
      'Flow Metrics: Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Continuous improvement: Explicit policies and experimentation';

  @override
  String get hybridOnDemandTitle => 'On-Demand Planning';

  @override
  String get hybridOnDemandContent =>
      'In Scrumban, planning can be \"on-demand\" instead of at fixed intervals.\n\nPlanning is triggered when:\n• The \"Ready\" backlog drops below a threshold\n• New urgent requests need prioritization\n• A milestone is approaching\n\nThis reduces planning sessions when not needed\nand allows faster response to changes.';

  @override
  String get hybridWhenTitle => 'When to Use What';

  @override
  String get hybridWhenContent =>
      'Scrumban is not \"do everything\". It\'s choosing the right elements for the context.\n\nUse Scrum elements when:\n• Predictability in deliveries is needed\n• Stakeholders want regular demos\n• The team benefits from fixed rhythm\n\nUse Kanban elements when:\n• Work is unpredictable (support, bug fixing)\n• Reactivity to urgencies is needed\n• Focus is on continuous throughput';

  @override
  String get hybridBP1 => 'Start with what you know and add elements gradually';

  @override
  String get hybridBP2 => 'WIP limits are non-negotiable, even with Sprint';

  @override
  String get hybridBP3 => 'Use Sprint for cadence, not as rigid commitment';

  @override
  String get hybridBP4 =>
      'Keep the Retrospective, it\'s the engine of improvement';

  @override
  String get hybridBP5 => 'Flow metrics help more than pure Velocity';

  @override
  String get hybridBP6 => 'Experiment with one thing at a time';

  @override
  String get hybridBP7 => 'Document team policies and review them regularly';

  @override
  String get hybridBP8 =>
      'Consider swimlanes to separate features from maintenance';

  @override
  String get hybridAP1 =>
      'Taking the worst of both (Scrum rigidity + Kanban chaos)';

  @override
  String get hybridAP2 =>
      'Eliminating Retrospectives because \"we\'re flexible\"';

  @override
  String get hybridAP3 => 'WIP limits ignored because \"we have Sprints\"';

  @override
  String get hybridAP4 => 'Changing framework every Sprint';

  @override
  String get hybridAP5 => 'Having no cadence (neither Sprint nor other)';

  @override
  String get hybridAP6 => 'Confusing flexibility with absence of rules';

  @override
  String get hybridAP7 => 'Not measuring anything';

  @override
  String get hybridAP8 => 'Too much complexity for the context';

  @override
  String get hybridFAQ1Q => 'Does Scrumban have Sprint or not?';

  @override
  String get hybridFAQ1A =>
      'It depends on the team. You can have Sprint for cadence (review, planning) but allow continuous flow of work within the Sprint. Or you can eliminate Sprints and have only Kanban cadences.';

  @override
  String get hybridFAQ2Q => 'How do I measure performance in Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Use both Scrum metrics (Velocity if using Sprint and Story Points) and Kanban metrics (Lead Time, Cycle Time, Throughput). Flow metrics are often more useful for improvement.';

  @override
  String get hybridFAQ3Q => 'Where to start with Scrumban?';

  @override
  String get hybridFAQ3A =>
      'If coming from Scrum: add WIP limits and visualize the flow. If coming from Kanban: add regular cadences for review and planning. Start from what the team knows and add incrementally.';

  @override
  String get hybridFAQ4Q => 'Is Scrumban \"less Agile\" than pure Scrum?';

  @override
  String get hybridFAQ4A =>
      'No. Agile doesn\'t mean following a specific framework. Scrumban can be more Agile because it adapts to context. The important thing is to continuously inspect and adapt.';

  @override
  String get retroNoResults => 'No results found';

  @override
  String get retroFilterAll => 'All';

  @override
  String get retroFilterActive => 'Active';

  @override
  String get retroFilterCompleted => 'Completed';

  @override
  String get retroFilterDraft => 'Draft';

  @override
  String get retroDeleteTitle => 'Delete Retrospective';

  @override
  String retroDeleteConfirm(String title) {
    return 'Are you sure?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospective deleted successfully';

  @override
  String retroDeleteError(String error) {
    return 'Error during deletion: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Permanently Delete';

  @override
  String get retroNewRetroTitle => 'New Retrospective';

  @override
  String get retroLinkToSprint => 'Link to Sprint?';

  @override
  String get retroNoProjectFound => 'No project found.';

  @override
  String get retroSelectProject => 'Select Project';

  @override
  String get retroSelectSprint => 'Select Sprint';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Sprint $number';
  }

  @override
  String get retroOwner => 'Owner';

  @override
  String get retroGuest => 'Guest';

  @override
  String get retroSessionTitle => 'Session Title';

  @override
  String get retroSessionTitleHint => 'E.g.: Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Template';

  @override
  String get retroVotesPerUser => 'Votes per user:';

  @override
  String get retroActionClose => 'Close';

  @override
  String get retroActionCreate => 'Create';

  @override
  String get retroStatusDraft => 'Draft';

  @override
  String get retroStatusActive => 'In Progress';

  @override
  String get retroStatusCompleted => 'Completed';

  @override
  String get retroTemplateStartStopContinue => 'Start, Stop, Continue';

  @override
  String get retroTemplateSailboat => 'Sailboat';

  @override
  String get retroTemplate4Ls => '4 Ls';

  @override
  String get retroTemplateStarfish => 'Starfish';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Action oriented: Start doing, Stop doing, Continue doing.';

  @override
  String get retroDescSailboat =>
      'Visual: Wind (propels), Anchors (drags), Rocks (risks), Island (goals).';

  @override
  String get retroDesc4Ls => 'Liked, Learned, Lacked, Longed For.';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Emotional: Mad, Sad, Glad.';

  @override
  String get retroDescDAKI => 'Pragmatic: Drop, Add, Keep, Improve.';

  @override
  String get retroUsageStartStopContinue =>
      'Best for actionable feedback and focusing on behavioral changes.';

  @override
  String get retroUsageSailboat =>
      'Best for visualizing the team\'s journey, goals, and risks. Good for creative thinking.';

  @override
  String get retroUsage4Ls =>
      'Reflective: Best for learning from the past and highlighting emotional/learning aspects.';

  @override
  String get retroUsageStarfish =>
      'Calibration: Best for scaling efforts (doing more/less of something), not just binary stop/start.';

  @override
  String get retroUsageMadSadGlad =>
      'Best for emotional check-ins, resolving conflicts, or after a stressful sprint.';

  @override
  String get retroUsageDAKI =>
      'Decisive: Best for clean-ups. Focuses on concrete decisions to Drop (remove) or Add (innovate).';

  @override
  String get retroIcebreakerSentiment => 'Sentiment Voting';

  @override
  String get retroIcebreakerOneWord => 'One Word';

  @override
  String get retroIcebreakerWeather => 'Weather Report';

  @override
  String get retroIcebreakerSentimentDesc =>
      'Vote 1-5 on how you felt during the sprint.';

  @override
  String get retroIcebreakerOneWordDesc =>
      'Describe the sprint with just one word.';

  @override
  String get retroIcebreakerWeatherDesc =>
      'Choose a weather icon that represents the sprint.';

  @override
  String get retroPhaseIcebreaker => 'ICEBREAKER';

  @override
  String get retroPhaseWriting => 'WRITING';

  @override
  String get retroPhaseVoting => 'VOTING';

  @override
  String get retroPhaseDiscuss => 'DISCUSS';

  @override
  String get retroActionItemsLabel => 'Action Items';

  @override
  String get retroActionDragToCreate =>
      'Drag a card here to create a linked Action Item';

  @override
  String get retroNoActionItems => 'No Action Items created yet.';

  @override
  String get facilitatorGuideNextColumn => 'Next: Collect action from';

  @override
  String get collectionRationaleSSC =>
      'Stop first to remove blockers, then Start new practices, finally Continue what works.';

  @override
  String get collectionRationaleMSG =>
      'Address frustrations first, then disappointments, then celebrate successes.';

  @override
  String get collectionRationale4Ls =>
      'Fill gaps first, then plan future aspirations, maintain what works, share learnings.';

  @override
  String get collectionRationaleSailboat =>
      'Mitigate risks first, remove blockers, then leverage enablers and align to goals.';

  @override
  String get collectionRationaleStarfish =>
      'Stop bad practices, reduce others, maintain good ones, increase valuable ones, start new.';

  @override
  String get collectionRationaleDAKI =>
      'Drop to free capacity, Add new practices, Improve existing ones, Keep what works.';

  @override
  String get missingSuggestionSSCStop =>
      'Consider what practice is blocking the team that should be stopped.';

  @override
  String get missingSuggestionSSCStart =>
      'Think about what new practice could help the team improve.';

  @override
  String get missingSuggestionMSGMad =>
      'Address the team frustrations - what is causing anger?';

  @override
  String get missingSuggestionMSGSad =>
      'Resolve disappointments - what made the team sad?';

  @override
  String get missingSuggestion4LsLacked =>
      'What was missing that the team needed?';

  @override
  String get missingSuggestion4LsLonged =>
      'What does the team wish they had for the future?';

  @override
  String get missingSuggestionSailboatAnchor =>
      'What is holding the team back from reaching their goals?';

  @override
  String get missingSuggestionSailboatRock =>
      'What risks are threatening the team\'s progress?';

  @override
  String get missingSuggestionStarfishStop =>
      'What practice should the team completely stop doing?';

  @override
  String get missingSuggestionStarfishStart =>
      'What new practice should the team begin?';

  @override
  String get missingSuggestionDAKIDrop =>
      'What should the team decide to eliminate?';

  @override
  String get missingSuggestionDAKIAdd =>
      'What new decision should the team make?';

  @override
  String get missingSuggestionGeneric =>
      'Consider creating an action from this column.';

  @override
  String get facilitatorGuideAllCovered => 'All required columns covered!';

  @override
  String get facilitatorGuideMissing => 'Missing actions for';

  @override
  String get retroPhaseStart => 'Start';

  @override
  String get retroPhaseStop => 'Stop';

  @override
  String get retroPhaseContinue => 'Continue';

  @override
  String get retroColumnMad => 'Mad';

  @override
  String get retroColumnSad => 'Sad';

  @override
  String get retroColumnGlad => 'Glad';

  @override
  String get retroColumnLiked => 'Liked';

  @override
  String get retroColumnLearned => 'Learned';

  @override
  String get retroColumnLacked => 'Lacked';

  @override
  String get retroColumnLonged => 'Longed For';

  @override
  String get retroColumnWind => 'Wind';

  @override
  String get retroColumnAnchor => 'Anchors';

  @override
  String get retroColumnRock => 'Rocks';

  @override
  String get retroColumnGoal => 'Island';

  @override
  String get retroColumnKeep => 'Keep';

  @override
  String get retroColumnMore => 'More';

  @override
  String get retroColumnLess => 'Less';

  @override
  String get retroColumnDrop => 'Drop';

  @override
  String get retroColumnAdd => 'Add';

  @override
  String get retroColumnImprove => 'Improve';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get formTitle => 'Title';

  @override
  String get formDescription => 'Description';

  @override
  String get formName => 'Name';

  @override
  String get formRequired => 'Required field';

  @override
  String get formHint => 'Enter a value';

  @override
  String get formOptional => 'Optional';

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get errorLoading => 'Error loading data';

  @override
  String get errorSaving => 'Error saving';

  @override
  String get errorNetwork => 'Connection error';

  @override
  String get errorPermission => 'Permission denied';

  @override
  String get errorNotFound => 'Not found';

  @override
  String get successSaved => 'Saved successfully';

  @override
  String get successDeleted => 'Deleted successfully';

  @override
  String get successCopied => 'Copied to clipboard';

  @override
  String get filterAll => 'All';

  @override
  String get filterRemove => 'Remove filters';

  @override
  String get filterActive => 'Active';

  @override
  String get filterCompleted => 'Completed';

  @override
  String get participants => 'Participants';

  @override
  String get agileAcceptanceCriteria => 'Acceptance Criteria';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed of $total items';
  }

  @override
  String get agileEstimateRequired => 'Estimate required (click to estimate)';

  @override
  String get agileNoActiveSprint => 'No Active Sprint';

  @override
  String get agileKanbanBoardHint =>
      'The Kanban Board shows stories from the active sprint.\nTo view stories:';

  @override
  String get agileStartSprintFromTab => 'Start a sprint from the Sprint tab';

  @override
  String get agileDisableFilterHint =>
      'Or disable the filter to see all stories';

  @override
  String get agileShowAllStories => 'Show all stories';

  @override
  String get agileFilterActiveSprint => 'Active Sprint Filter: ';

  @override
  String get agileFilterActive => 'Active';

  @override
  String get agileFilterAll => 'All';

  @override
  String get agileActionInvite => 'Invite';

  @override
  String agileTeamTitle(int count) {
    return 'Team ($count)';
  }

  @override
  String get agileNoMembers => 'No members in team';

  @override
  String get agileYouBadge => 'You';

  @override
  String agileStatsPlannedCount(int count) {
    return '$count planned';
  }

  @override
  String agileStatsTotalCount(int count) {
    return '$count total';
  }

  @override
  String get agileStatsPtsPerSprint => 'pts/sprint';

  @override
  String get agileStatsWorkInProgress => 'work in progress';

  @override
  String get agileStatsItemsPerWeek => 'items/week';

  @override
  String get agileStatsCompletedTooltip =>
      'Number of sprints with \'Completed\' status.\nClick \'Complete Sprint\' to finalize an active sprint.';

  @override
  String get agileAverageVelocityTooltip =>
      'Average Story Points completed per sprint.\nCalculated from completed sprints with \'Done\' stories.\nHigher = more productive team.';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Number of User Stories with \'Done\' status.\nTo increase this value, move stories to the \'Done\' column on the Kanban Board.';

  @override
  String get agileStatsPointsTooltip =>
      'Sum of Story Points of completed stories.\n\'Planned\' includes all estimated stories in the backlog.';

  @override
  String get agileItemsCompletedTooltip =>
      'Number of Work Items with \'Done\' status.\nMove items to the \'Done\' column to complete them.';

  @override
  String get agileInProgressTooltip =>
      'Items currently in progress (WIP).\nKeep this number low to improve flow.';

  @override
  String get agileCycleTimeTooltip =>
      'Average time from start of work to completion.\nRequires items with \'Started\' and \'Completed\' dates.\nLower = more efficient team.';

  @override
  String get agileThroughputTooltip =>
      'Average items completed per week (last 4 weeks).\nIndicates team productivity over time.';

  @override
  String get agileHybridSprintTooltip => 'Completed sprints vs total.';

  @override
  String get agileHybridCompletedTooltip =>
      'Items with \'Done\' status vs total.\nMove items to \'Done\' column to complete them.';

  @override
  String get agileAddSkillsHint => 'Add skills to team members';

  @override
  String get agileSkillMatrixTitle => 'Skill Matrix';

  @override
  String get agileCriticalSkills => 'Critical Skills';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Only 1 person covers: $skills';
  }

  @override
  String get agileSkills => 'Skills';

  @override
  String get agileNoSkills => 'No skills';

  @override
  String get agileAddSkill => 'Add skill';

  @override
  String get agileNewSkill => 'New skill...';

  @override
  String get agileNewSkillDialogTitle => 'New Skill';

  @override
  String get agileNewSkillName => 'Skill name';

  @override
  String get agileNewSkillHint => 'Ex: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Skill Coverage';

  @override
  String get agileNoSkillsAvailable => 'No skills available';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'Based on $count completed items';
  }

  @override
  String get agileNoAcceptanceCriteria => 'No acceptance criteria defined';

  @override
  String get agileDescription => 'Description';

  @override
  String get agileNoDescription => 'No description';

  @override
  String get agileTags => 'Tags';

  @override
  String get agileEstimates => 'Estimates';

  @override
  String get agileFinalEstimate => 'Final Estimate';

  @override
  String agileEstimatesReceived(int count) {
    return '$count estimates received';
  }

  @override
  String get agileInformation => 'Information';

  @override
  String get agileBusinessValue => 'Business Value';

  @override
  String get agileAssignee => 'Assignee';

  @override
  String get agileNoAssignee => 'Unassigned';

  @override
  String get agileCreatedBy => 'Created by';

  @override
  String get agileCreatedAt => 'Created at';

  @override
  String get agileStartedAt => 'Started at';

  @override
  String get agileCompletedAt => 'Completed at';

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
    return '$count days remaining';
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
  String get agileBurndownIdeal => 'Ideal';

  @override
  String get agileBurndownActual => 'Actual';

  @override
  String get agileBurndownPlanned => 'Planned';

  @override
  String get agileBurndownRemaining => 'Remaining';

  @override
  String get agileBurndownNoData => 'No burndown data';

  @override
  String get agileBurndownNoDataHint =>
      'Data will appear when the sprint is active';

  @override
  String get agileVelocityTrend => 'Velocity Trend';

  @override
  String get agileVelocityNoData => 'No velocity data';

  @override
  String get agileVelocityNoDataHint =>
      'Complete at least one sprint to see the trend';

  @override
  String get agileTeamCapacity => 'Team Capacity';

  @override
  String get agileTeamCapacityScrum => 'Team Capacity (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Team Capacity (Hours)';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity => 'Suggested Capacity for Planning';

  @override
  String get agileSuggestedCapacityHint =>
      'Based on avg velocity ± std dev (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Complete at least 1 sprint to get capacity suggestions';

  @override
  String get agileScrumGuideNote =>
      'The Scrum Guide recommends planning based on historical Velocity, not hours.';

  @override
  String get agileHoursAvailable => 'Available';

  @override
  String get agileHoursAssigned => 'Assigned';

  @override
  String get agileHoursOverloaded => 'Overloaded';

  @override
  String get agileHoursTotal => 'Total Capacity';

  @override
  String get agileHoursUtilization => 'Utilization';

  @override
  String agileMetricsTitle(String framework) {
    return '$framework Metrics';
  }

  @override
  String get agileItemsCompleted => 'Items Completed';

  @override
  String get agileInProgress => 'In Progress';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Stories Distribution';

  @override
  String get agileCompletionRate => 'Completion Rate';

  @override
  String get agileAccuracy => 'Estimation Accuracy';

  @override
  String get agileEfficiency => 'Flow Efficiency';

  @override
  String get removeParticipant => 'Remove participant';

  @override
  String get noParticipants => 'No participants';

  @override
  String get participantJoined => 'joined';

  @override
  String get participantLeft => 'left';

  @override
  String get participantRole => 'Role';

  @override
  String get participantVoter => 'Voter';

  @override
  String get participantObserver => 'Observer';

  @override
  String get participantModerator => 'Moderator';

  @override
  String get confirmDelete => 'Confirm deletion';

  @override
  String get confirmDeleteMessage => 'This action cannot be undone.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String itemCount(int count) {
    return '$count items';
  }

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get copyLink => 'Copy link';

  @override
  String get shareSession => 'Share session';

  @override
  String get inviteByEmail => 'Invite by email';

  @override
  String get inviteByLink => 'Invite by link';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileDisplayName => 'Display name';

  @override
  String get profilePhotoUrl => 'Profile photo';

  @override
  String get profileEditProfile => 'Edit profile';

  @override
  String get profileReload => 'Reload';

  @override
  String get profilePersonalInfo => 'Personal Information';

  @override
  String get profileLastName => 'Last name';

  @override
  String get profileCompany => 'Company';

  @override
  String get profileJobTitle => 'Job title';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Subscription';

  @override
  String get profilePlan => 'Plan';

  @override
  String get profileBillingCycle => 'Billing cycle';

  @override
  String get profilePrice => 'Price';

  @override
  String get profileActivationDate => 'Activation date';

  @override
  String get profileTrialEnd => 'Trial period end';

  @override
  String get profileNextRenewal => 'Next renewal';

  @override
  String get profileDaysRemaining => 'Days remaining';

  @override
  String get profileUpgrade => 'Upgrade';

  @override
  String get profileUpgradePlan => 'Upgrade Plan';

  @override
  String get planFree => 'Free';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Active';

  @override
  String get statusTrialing => 'Trialing';

  @override
  String get statusPastDue => 'Past due';

  @override
  String get statusPaused => 'Paused';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusExpired => 'Expired';

  @override
  String get cycleMonthly => 'Monthly';

  @override
  String get cycleQuarterly => 'Quarterly';

  @override
  String get cycleYearly => 'Yearly';

  @override
  String get cycleLifetime => 'Lifetime';

  @override
  String get pricePerMonth => 'month';

  @override
  String get pricePerQuarter => 'quart';

  @override
  String get pricePerYear => 'year';

  @override
  String get priceForever => 'forever';

  @override
  String get priceFree => 'Free';

  @override
  String get profileGeneralSettings => 'General Settings';

  @override
  String get profileAnimations => 'Animations';

  @override
  String get profileAnimationsDesc => 'Enable UI animations';

  @override
  String get profileFeatures => 'Features';

  @override
  String get profileCalendarIntegration => 'Calendar Integration';

  @override
  String get profileCalendarIntegrationDesc => 'Sync sprints and deadlines';

  @override
  String get profileExportSheets => 'Export to Google Sheets';

  @override
  String get profileExportSheetsDesc => 'Export data to spreadsheets';

  @override
  String get profileBetaFeatures => 'Beta Features';

  @override
  String get profileBetaFeaturesDesc => 'Early access to new features';

  @override
  String get profileAdvancedMetrics => 'Advanced Metrics';

  @override
  String get profileAdvancedMetricsDesc => 'Detailed statistics and reports';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profileEmailNotifications => 'Email Notifications';

  @override
  String get profileEmailNotificationsDesc => 'Receive updates via email';

  @override
  String get profilePushNotifications => 'Push Notifications';

  @override
  String get profilePushNotificationsDesc => 'Browser notifications';

  @override
  String get profileSprintReminders => 'Sprint Reminders';

  @override
  String get profileSprintRemindersDesc => 'Alerts for sprint deadlines';

  @override
  String get profileSessionInvites => 'Session Invites';

  @override
  String get profileSessionInvitesDesc => 'Notifications for new sessions';

  @override
  String get profileWeeklySummary => 'Weekly Summary';

  @override
  String get profileWeeklySummaryDesc => 'Weekly activity report';

  @override
  String get profileDangerZone => 'Danger Zone';

  @override
  String get profileDeleteAccount => 'Delete account';

  @override
  String get profileDeleteAccountDesc =>
      'Request permanent deletion of your account and all associated data';

  @override
  String get profileDeleteAccountRequest => 'Request';

  @override
  String get profileDeleteAccountIrreversible =>
      'This action is irreversible. All your data will be permanently deleted.';

  @override
  String get profileDeleteAccountReason => 'Reason (optional)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Why do you want to delete your account?';

  @override
  String get profileRequestDeletion => 'Request Deletion';

  @override
  String get profileDeletionInProgress => 'Deletion in progress';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Requested on $date';
  }

  @override
  String get profileCancelRequest => 'Cancel request';

  @override
  String get profileDeletionRequestSent => 'Deletion request sent';

  @override
  String get profileDeletionRequestCancelled => 'Request cancelled';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileLogout => 'Sign out';

  @override
  String get profileLogoutDesc => 'Disconnect your account from this device';

  @override
  String get profileLogoutConfirm => 'Are you sure you want to sign out?';

  @override
  String get profileSubscriptionCancelled => 'Subscription cancelled';

  @override
  String get profileCancelSubscription => 'Cancel Subscription';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Are you sure you want to cancel your subscription? You will continue to use premium features until the end of the current period.';

  @override
  String get profileKeepSubscription => 'No, keep it';

  @override
  String get profileYesCancel => 'Yes, cancel';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Upgrade to $plan coming soon...';
  }

  @override
  String get profileFree => 'Free';

  @override
  String get profileMonthly => 'EUR/month';

  @override
  String get profileUser => 'User';

  @override
  String profileErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get stateSaving => 'Saving...';

  @override
  String get cardCoffee => 'Break';

  @override
  String get cardQuestion => 'Don\'t know';

  @override
  String get toolEisenhower => 'Eisenhower Matrix';

  @override
  String get toolEisenhowerDesc =>
      'Organize activities by urgency and importance. Quadrants to decide what to do now, schedule, delegate or eliminate.';

  @override
  String get toolEisenhowerDescShort => 'Prioritize by urgency and importance';

  @override
  String get toolEstimation => 'Estimation Room';

  @override
  String get toolEstimationDesc =>
      'Collaborative estimation sessions for the team. Planning Poker, T-Shirt sizing and other methods to estimate user stories.';

  @override
  String get toolEstimationDescShort => 'Collaborative estimation sessions';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Smart and collaborative lists. Import from CSV/text, invite participants and manage tasks with advanced filters.';

  @override
  String get toolSmartTodoDescShort =>
      'Smart and collaborative lists. Import from CSV, invite and manage.';

  @override
  String get toolAgileProcess => 'Agile Process Manager';

  @override
  String get toolAgileProcessDesc =>
      'Manage complete agile projects with backlog, sprint planning, kanban board, metrics and retrospectives.';

  @override
  String get toolAgileProcessDescShort =>
      'Manage agile projects with backlog, sprints, kanban and metrics.';

  @override
  String get toolRetro => 'Retrospective Board';

  @override
  String get toolRetroDesc =>
      'Collect team feedback on what went well, what to improve and actions to take.';

  @override
  String get toolRetroDescShort =>
      'Collect team feedback on what went well and what to improve.';

  @override
  String get homeUtilities => 'Utilities';

  @override
  String get homeSelectTool => 'Select a tool to get started';

  @override
  String get statusOnline => 'Online';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get featureComingSoon => 'This feature will be available soon!';

  @override
  String get featureSmartImport => 'Smart Import';

  @override
  String get featureCollaboration => 'Collaboration';

  @override
  String get featureFilters => 'Filters';

  @override
  String get feature4Quadrants => '4 Quadrants';

  @override
  String get featureDragDrop => 'Drag & Drop';

  @override
  String get featureCollaborative => 'Collaborative';

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
  String get themeLightMode => 'Light Mode';

  @override
  String get themeDarkMode => 'Dark Mode';

  @override
  String get estimationBackToSessions => 'Back to sessions';

  @override
  String get estimationSessionSettings => 'Session Settings';

  @override
  String get estimationList => 'List';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Your sessions ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'No session found';

  @override
  String get estimationCreateFirstSession =>
      'Create your first estimation session\nto estimate activities with the team';

  @override
  String get estimationStoriesTotal => 'Total stories';

  @override
  String get estimationStoriesCompleted => 'Completed stories';

  @override
  String get estimationParticipantsActive => 'Active participants';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Progress: $completed/$total stories ($percent%)';
  }

  @override
  String get estimationStart => 'Start';

  @override
  String get estimationComplete => 'Complete';

  @override
  String get estimationAllStoriesEstimated =>
      'All stories have been estimated!';

  @override
  String get estimationNoVotingInProgress => 'No voting in progress';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Completed: $completed/$total | Total estimate: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Vote: $title';
  }

  @override
  String get estimationAddStoriesToStart => 'Add stories to start';

  @override
  String get estimationInVoting => 'IN VOTING';

  @override
  String get estimationReveal => 'Reveal';

  @override
  String get estimationSkip => 'Skip';

  @override
  String get estimationStories => 'Stories';

  @override
  String get estimationAddStory => 'Add Story';

  @override
  String get estimationStartVoting => 'Start voting';

  @override
  String get estimationViewVotes => 'View votes';

  @override
  String get estimationViewDetail => 'View detail';

  @override
  String get estimationFinalEstimateLabel => 'Final estimate:';

  @override
  String estimationVotesOf(String title) {
    return 'Votes: $title';
  }

  @override
  String get estimationParticipantVotes => 'Participant votes:';

  @override
  String get estimationPointsOrDays => 'points / days';

  @override
  String get estimationEstimateRationale => 'Estimate rationale (optional)';

  @override
  String get estimationExplainRationale =>
      'Explain the rationale for the estimate...\nE.g.: High technical complexity, external dependencies...';

  @override
  String get estimationRationaleHelp =>
      'The rationale helps the team remember decisions made during estimation.';

  @override
  String get estimationConfirmFinalEstimate => 'Confirm Final Estimate';

  @override
  String get estimationEnterValidEstimate => 'Enter a valid estimate';

  @override
  String get estimationHintEstimate => 'E.g.: 5, 8, 13...';

  @override
  String get estimationStatus => 'Status';

  @override
  String get estimationOrder => 'Order';

  @override
  String get estimationVotesReceived => 'Votes received';

  @override
  String get estimationAverageVotes => 'Average votes';

  @override
  String get estimationConsensus => 'Consensus';

  @override
  String get storyStatusPending => 'Pending';

  @override
  String get storyStatusVoting => 'Voting';

  @override
  String get storyStatusRevealed => 'Votes revealed';

  @override
  String get participantManagement => 'Participant Management';

  @override
  String get participantCopySessionLink => 'Copy session link';

  @override
  String get participantInvitesTab => 'Invites';

  @override
  String get participantSessionLink => 'Session Link (share with participants)';

  @override
  String get participantAddDirect =>
      'Add Direct Participant (e.g. open voting)';

  @override
  String get participantEmailRequired => 'Email *';

  @override
  String get participantEmailHint => 'email@example.com';

  @override
  String get participantNameHint => 'Display name';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters voters, $observers observers';
  }

  @override
  String get participantYou => '(you)';

  @override
  String get participantMakeVoter => 'Make Voter';

  @override
  String get participantMakeObserver => 'Make Observer';

  @override
  String get participantRemoveTitle => 'Remove Participant';

  @override
  String participantRemoveConfirm(String name) {
    return 'Are you sure you want to remove \"$name\" from the session?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email added to session';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name removed from session';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Role updated for $email';
  }

  @override
  String get participantFacilitator => 'Facilitator';

  @override
  String get inviteSendNew => 'Send New Invite';

  @override
  String get inviteRecipientEmail => 'Recipient email *';

  @override
  String get inviteCreate => 'Create Invite';

  @override
  String get invitesSent => 'Invites Sent';

  @override
  String get inviteNoInvites => 'No invites sent';

  @override
  String inviteCreatedFor(String email) {
    return 'Invite created for $email';
  }

  @override
  String inviteSentTo(String email) {
    return 'Invite sent via email to $email';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Expires in ${days}d';
  }

  @override
  String get inviteCopyLink => 'Copy link';

  @override
  String get inviteRevokeAction => 'Revoke invite';

  @override
  String get inviteDeleteAction => 'Delete invite';

  @override
  String get inviteRevokeTitle => 'Revoke invite?';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Are you sure you want to revoke the invite for $email?';
  }

  @override
  String get inviteRevoke => 'Revoke';

  @override
  String inviteRevokedFor(String email) {
    return 'Invite revoked for $email';
  }

  @override
  String get inviteDeleteTitle => 'Delete Invite';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Are you sure you want to delete the invite for $email?\n\nThis action is irreversible.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Invite deleted for $email';
  }

  @override
  String get inviteLinkCopied => 'Link copied!';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get enterValidEmail => 'Enter a valid email address';

  @override
  String get sessionCreatedSuccess => 'Session created successfully';

  @override
  String get sessionUpdated => 'Session updated';

  @override
  String get sessionDeleted => 'Session deleted';

  @override
  String get sessionStarted => 'Session started';

  @override
  String get sessionCompletedSuccess => 'Session completed';

  @override
  String get sessionNotFound => 'Session not found';

  @override
  String get storyAdded => 'Story added';

  @override
  String get storyDeleted => 'Story deleted';

  @override
  String estimateSaved(String estimate) {
    return 'Estimate saved: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Delete Session';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Are you sure you want to delete \"$name\"?\nAlso all $count stories will be deleted.';
  }

  @override
  String get deleteStoryTitle => 'Delete Story';

  @override
  String deleteStoryConfirm(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get errorLoadingSession => 'Error loading session';

  @override
  String get errorLoadingStories => 'Error loading stories';

  @override
  String get errorCreatingSession => 'Error creating session';

  @override
  String get errorUpdatingSession => 'Error updating';

  @override
  String get errorDeletingSession => 'Error deleting';

  @override
  String get errorAddingStory => 'Error adding story';

  @override
  String get errorStartingSession => 'Error starting session';

  @override
  String get errorCompletingSession => 'Error completing session';

  @override
  String get errorSubmittingVote => 'Error submitting vote';

  @override
  String get errorRevealingVotes => 'Error revealing';

  @override
  String get errorSavingEstimate => 'Error saving estimate';

  @override
  String get errorSkipping => 'Error skipping';

  @override
  String get retroIcebreakerTitle => 'Icebreaker: Team Morale';

  @override
  String get retroIcebreakerQuestion => 'How did you feel about this sprint?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count participants voted';
  }

  @override
  String get retroEndIcebreakerStartWriting => 'End Icebreaker & Start Writing';

  @override
  String get retroMoodTerrible => 'Terrible';

  @override
  String get retroMoodBad => 'Bad';

  @override
  String get retroMoodNeutral => 'Neutral';

  @override
  String get retroMoodGood => 'Good';

  @override
  String get retroMoodExcellent => 'Excellent';

  @override
  String get actionSubmit => 'Submit';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker: One Word';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Describe this sprint with just ONE word';

  @override
  String get retroIcebreakerOneWordHint => 'Your word...';

  @override
  String get retroIcebreakerSubmitted => 'Submitted!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count words submitted';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker: Weather Report';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'What weather best represents how you feel about this sprint?';

  @override
  String get retroWeatherSunny => 'Sunny';

  @override
  String get retroWeatherPartlyCloudy => 'Partly Cloudy';

  @override
  String get retroWeatherCloudy => 'Cloudy';

  @override
  String get retroWeatherRainy => 'Rainy';

  @override
  String get retroWeatherStormy => 'Stormy';

  @override
  String get retroAgileCoach => 'Agile Coach';

  @override
  String get retroCoachSetup =>
      'Choose a template. \"Start/Stop/Continue\" is great for new teams. Make sure everyone is present.';

  @override
  String get retroCoachIcebreaker =>
      'Break the ice! Do a quick round asking \"How are you?\" or use a fun question.';

  @override
  String get retroCoachWriting =>
      'We are in INCOGNITO mode. Write cards freely, no one will see what you write until the end. Avoid bias!';

  @override
  String get retroCoachVoting =>
      'Review Time! All cards are visible. Read them and use your 3 votes to decide what to discuss.';

  @override
  String get retroCoachDiscuss =>
      'Focus on the most voted cards. Define clear Action Items: Who does what by when?';

  @override
  String get retroCoachCompleted =>
      'Great job! The retrospective is complete. Action Items have been sent to the Backlog.';

  @override
  String retroStep(int step, String title) {
    return 'Step $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Current Focus: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Template requires at least 4 columns (Sailboat style)';

  @override
  String retroAddTo(String title) {
    return 'Add to $title';
  }

  @override
  String get retroNoColumnsConfigured => 'No columns configured.';

  @override
  String get retroNewActionItem => 'New Action Item';

  @override
  String get retroEditActionItem => 'Edit Action Item';

  @override
  String get retroActionWhatToDo => 'What needs to be done?';

  @override
  String get retroActionDescriptionHint => 'Describe the concrete action...';

  @override
  String get retroActionRequired => 'Required';

  @override
  String get retroActionLinkedCard => 'Linked to Retro Card (Optional)';

  @override
  String get retroActionNone => 'None';

  @override
  String get retroActionType => 'Action Type';

  @override
  String get retroActionNoType => 'No specific type';

  @override
  String get retroActionAssignee => 'Assignee';

  @override
  String get retroActionNoAssignee => 'None';

  @override
  String get retroActionPriority => 'Priority';

  @override
  String get retroActionDueDate => 'Due Date (Deadline)';

  @override
  String get retroActionSelectDate => 'Select date...';

  @override
  String get retroActionSupportResources => 'Support Resources';

  @override
  String get retroActionResourcesHint =>
      'Tools, budget, extra people needed...';

  @override
  String get retroActionMonitoring => 'Monitoring Method';

  @override
  String get retroActionMonitoringHint =>
      'How will we verify progress? (e.g. Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Ref.';

  @override
  String get retroTableSourceColumn => 'Column';

  @override
  String get retroTableDescription => 'Description';

  @override
  String get retroTableOwner => 'Owner';

  @override
  String get retroIcebreakerTwoTruths => 'Two Truths and a Lie';

  @override
  String get retroDescTwoTruths => 'Simple and classic.';

  @override
  String get retroIcebreakerCheckin => 'Emotional Check-in';

  @override
  String get retroDescCheckin => 'How is everyone feeling?';

  @override
  String get retroTableActions => 'Actions';

  @override
  String get retroSupportResources => 'Support Resources';

  @override
  String get retroMonitoringMethod => 'Monitoring Method';

  @override
  String get retroUnassigned => 'Unassigned';

  @override
  String get retroDeleteActionItem => 'Delete Action Item';

  @override
  String get retroChooseMethodology => 'Choose Methodology';

  @override
  String get retroHidingWhileTyping => 'Hiding while typing...';

  @override
  String retroVoteLimitReached(int max) {
    return 'You have reached the limit of $max votes!';
  }

  @override
  String get retroAddCardHint => 'What are your thoughts?';

  @override
  String get retroAddCard => 'Add Card';

  @override
  String get retroTimeUp => 'Time\'s Up!';

  @override
  String get retroTimeUpMessage =>
      'The time for this phase has ended. Wrap up the discussion or extend the time.';

  @override
  String get retroTimeUpOk => 'Ok, got it';

  @override
  String get retroStopTimer => 'Stop Timer';

  @override
  String get retroStartTimer => 'Start Timer';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get retroAddCardButton => 'Add Card';

  @override
  String get retroDeleteRetro => 'Delete Retrospective';

  @override
  String get retroParticipantsLabel => 'Participants';

  @override
  String get retroNotesCreated => 'Notes created';

  @override
  String retroStatusLabel(String status) {
    return 'Status: $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Date: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'No tasks in this list';

  @override
  String get smartTodoNoTasksInColumn => 'No tasks';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total completed';
  }

  @override
  String get smartTodoCreatedDate => 'Created date';

  @override
  String get smartTodoParticipantRole => 'Participant';

  @override
  String get smartTodoUnassigned => 'Unassigned';

  @override
  String get smartTodoNewTask => 'New Task';

  @override
  String get smartTodoEditTask => 'Edit Task';

  @override
  String get smartTodoTaskTitle => 'Task title';

  @override
  String get smartTodoDescription => 'DESCRIPTION';

  @override
  String get smartTodoDescriptionHint => 'Add a detailed description...';

  @override
  String get smartTodoChecklist => 'CHECKLIST';

  @override
  String get smartTodoAddChecklistItem => 'Add item';

  @override
  String get smartTodoAttachments => 'ATTACHMENTS';

  @override
  String get smartTodoAddLink => 'Add Link';

  @override
  String get smartTodoComments => 'COMMENTS';

  @override
  String get smartTodoWriteComment => 'Write a comment...';

  @override
  String get smartTodoAddImageTooltip => 'Add Image (URL)';

  @override
  String get smartTodoStatus => 'STATUS';

  @override
  String get smartTodoPriority => 'PRIORITY';

  @override
  String get smartTodoAssignees => 'ASSIGNEES';

  @override
  String get smartTodoNoAssignee => 'Nobody';

  @override
  String get smartTodoTags => 'TAGS';

  @override
  String get smartTodoNoTags => 'No tags';

  @override
  String get smartTodoDueDate => 'DUE DATE';

  @override
  String get smartTodoSetDate => 'Set date';

  @override
  String get smartTodoEffort => 'EFFORT';

  @override
  String get smartTodoEffortHint => 'Points (e.g. 5)';

  @override
  String get smartTodoAssignTo => 'Assign to';

  @override
  String get smartTodoSelectTags => 'Select Tags';

  @override
  String get smartTodoNoTagsAvailable => 'No tags available';

  @override
  String get smartTodoNewSubtask => 'New status';

  @override
  String get smartTodoAddLinkTitle => 'Add Link';

  @override
  String get smartTodoLinkName => 'Name';

  @override
  String get smartTodoLinkUrl => 'URL';

  @override
  String get smartTodoCannotOpenLink => 'Cannot open link';

  @override
  String get smartTodoPasteImage => 'Paste Image';

  @override
  String get smartTodoPasteImageFound => 'Image from clipboard found.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Do you want to add this image from your clipboard?';

  @override
  String get smartTodoYesAdd => 'Yes, add';

  @override
  String get smartTodoAddImage => 'Add Image';

  @override
  String get smartTodoImageUrlHint =>
      'Paste the image URL (e.g. captured with CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'Image URL';

  @override
  String get smartTodoPasteFromClipboard => 'Paste from Clipboard';

  @override
  String get smartTodoEditComment => 'Edit';

  @override
  String get smartTodoSortBy => 'Sort by';

  @override
  String get smartTodoColumnSortTitle => 'Sort Column';

  @override
  String get smartTodoPendingTasks => 'Tasks to complete';

  @override
  String get smartTodoCompletedTasks => 'Completed tasks';

  @override
  String get smartTodoEnterTitle => 'Enter a title';

  @override
  String get smartTodoUser => 'User';

  @override
  String get smartTodoImportTasks => 'Import Tasks';

  @override
  String get smartTodoImportStep1 => 'Step 1: Choose Source';

  @override
  String get smartTodoImportStep2 => 'Step 2: Map Columns';

  @override
  String get smartTodoImportStep3 => 'Step 3: Review & Confirm';

  @override
  String get smartTodoImportRetry => 'Retry';

  @override
  String get smartTodoImportPasteText => 'Paste Text (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Upload File (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Paste your tasks here. Use comma as separator.';

  @override
  String get smartTodoImportPasteExample =>
      'e.g. Buy milk\nCall Mario\nFinish report';

  @override
  String get smartTodoImportSelectFile => 'Select CSV File';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'File selected: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'File read error: $error';
  }

  @override
  String get smartTodoImportNoData => 'No data found';

  @override
  String get smartTodoImportColumnMapping =>
      'We detected these columns. Map each column to the correct field.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Column $index: \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Sample value: \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return 'Found $count valid tasks. Review before importing.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Destination:';

  @override
  String get smartTodoImportBack => 'Back';

  @override
  String get smartTodoImportNext => 'Next';

  @override
  String smartTodoImportButton(int count) {
    return 'Import $count Tasks';
  }

  @override
  String get smartTodoImportEnterText => 'Enter some text or upload a file.';

  @override
  String get smartTodoImportNoValidRows => 'No valid rows found.';

  @override
  String get smartTodoImportMapTitle => 'You must map at least the \"Title\".';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Parsing Error: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return 'Imported $count tasks!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Import Error: $error';
  }

  @override
  String get smartTodoImportHelpTitle => 'How to import tasks?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Simple list (one task per line)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Paste a simple list with one task title per line. Each line becomes a task.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Buy milk\nCall Mario\nFinish report';

  @override
  String get smartTodoImportHelpCsvTitle => 'CSV format (with columns)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Use comma-separated values with a header row. The first row defines the columns.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nBuy milk,high,mario@email.com\nCall Mario,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Available fields:';

  @override
  String get smartTodoImportHelpFieldTitle => 'Task title (required)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Task description';

  @override
  String get smartTodoImportHelpFieldPriority => 'high, medium, low';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Column name (e.g. To Do, In Progress)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'User email';

  @override
  String get smartTodoImportHelpFieldEffort => 'Hours (number)';

  @override
  String get smartTodoImportHelpFieldTags => 'Tags (#tag or comma-separated)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Available columns for STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(empty column)';

  @override
  String get smartTodoImportFieldIgnore => '-- Ignore --';

  @override
  String get smartTodoImportFieldTitle => 'Title';

  @override
  String get smartTodoImportFieldDescription => 'Description';

  @override
  String get smartTodoImportFieldPriority => 'Priority';

  @override
  String get smartTodoImportFieldStatus => 'Status (Column)';

  @override
  String get smartTodoImportFieldAssignee => 'Assignee';

  @override
  String get smartTodoImportFieldEffort => 'Effort';

  @override
  String get smartTodoImportFieldTags => 'Tags';

  @override
  String get smartTodoDeleteTaskTitle => 'Delete Task';

  @override
  String get smartTodoDeleteTaskContent =>
      'Are you sure you want to delete this task? This action cannot be undone.';

  @override
  String get smartTodoDeleteNoPermission =>
      'You don\'t have permission to delete this task';

  @override
  String get smartTodoSheetsExportTitle => 'Google Sheets Export';

  @override
  String get smartTodoSheetsExportExists =>
      'A Google Sheets document already exists for this list.';

  @override
  String get smartTodoSheetsOpen => 'Open';

  @override
  String get smartTodoSheetsUpdate => 'Update';

  @override
  String get smartTodoSheetsUpdating => 'Updating Google Sheets...';

  @override
  String get smartTodoSheetsCreating => 'Creating Google Sheets...';

  @override
  String get smartTodoSheetsUpdated => 'Google Sheets updated!';

  @override
  String get smartTodoSheetsCreated => 'Google Sheets created!';

  @override
  String get smartTodoSheetsError => 'Error during export (see log)';

  @override
  String get error => 'Error';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Audit Log - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'User';

  @override
  String get smartTodoAuditFilterType => 'Type';

  @override
  String get smartTodoAuditFilterAction => 'Action';

  @override
  String get smartTodoAuditFilterTag => 'Tag';

  @override
  String get smartTodoAuditFilterSearch => 'Search';

  @override
  String get smartTodoAuditFilterAll => 'All';

  @override
  String get smartTodoAuditFilterAllFemale => 'All';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium required for extended history';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'Last $days days';
  }

  @override
  String get smartTodoAuditClearFilters => 'Clear Filters';

  @override
  String get smartTodoAuditViewTimeline => 'Timeline View';

  @override
  String get smartTodoAuditViewColumns => 'Columns View';

  @override
  String get smartTodoAuditNoActivity => 'No activity recorded';

  @override
  String get smartTodoAuditNoResults => 'No results for selected filters';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count activities';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'No activity';

  @override
  String get smartTodoAuditLoadMore => 'Load more 50...';

  @override
  String get smartTodoAuditEmptyValue => '(empty)';

  @override
  String get smartTodoAuditEntityList => 'List';

  @override
  String get smartTodoAuditEntityTask => 'Task';

  @override
  String get smartTodoAuditEntityInvite => 'Invite';

  @override
  String get smartTodoAuditEntityParticipant => 'Participant';

  @override
  String get smartTodoAuditEntityColumn => 'Column';

  @override
  String get smartTodoAuditEntityTag => 'Tag';

  @override
  String get smartTodoAuditActionCreate => 'Created';

  @override
  String get smartTodoAuditActionUpdate => 'Updated';

  @override
  String get smartTodoAuditActionDelete => 'Deleted';

  @override
  String get smartTodoAuditActionArchive => 'Archived';

  @override
  String get smartTodoAuditActionRestore => 'Restored';

  @override
  String get smartTodoAuditActionMove => 'Moved';

  @override
  String get smartTodoAuditActionAssign => 'Assigned';

  @override
  String get smartTodoAuditActionInvite => 'Invited';

  @override
  String get smartTodoAuditActionJoin => 'Joined';

  @override
  String get smartTodoAuditActionRevoke => 'Revoked';

  @override
  String get smartTodoAuditActionReorder => 'Reordered';

  @override
  String get smartTodoAuditActionBatchCreate => 'Import';

  @override
  String get smartTodoAuditTimeNow => 'Now';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get smartTodoCfdTitle => 'CFD Analytics';

  @override
  String get smartTodoCfdTooltip => 'CFD Analytics';

  @override
  String get smartTodoCfdDateRange => 'Date Range:';

  @override
  String get smartTodoCfd7Days => '7 days';

  @override
  String get smartTodoCfd14Days => '14 days';

  @override
  String get smartTodoCfd30Days => '30 days';

  @override
  String get smartTodoCfd90Days => '90 days';

  @override
  String get smartTodoCfdError => 'Error loading analytics';

  @override
  String get smartTodoCfdRetry => 'Refresh';

  @override
  String get smartTodoCfdNoData => 'No data available';

  @override
  String get smartTodoCfdNoDataHint => 'Task movements will be tracked here';

  @override
  String get smartTodoCfdKeyMetrics => 'Key Metrics';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip =>
      'Time from task creation to completion';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Time from work start to completion';

  @override
  String get smartTodoCfdThroughput => 'Throughput';

  @override
  String get smartTodoCfdThroughputTooltip => 'Tasks completed per week';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Work in progress';

  @override
  String get smartTodoCfdLimit => 'Limit';

  @override
  String get smartTodoCfdCompleted => 'completed';

  @override
  String get smartTodoCfdFlowAnalysis => 'Flow Analysis';

  @override
  String get smartTodoCfdArrived => 'Arrived';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog shrinking';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog growing';

  @override
  String get smartTodoCfdBottlenecks => 'Bottleneck Detection';

  @override
  String get smartTodoCfdNoBottlenecks => 'No bottlenecks detected';

  @override
  String get smartTodoCfdTasks => 'tasks';

  @override
  String get smartTodoCfdAvgAge => 'Avg age';

  @override
  String get smartTodoCfdAgingWip => 'Aging Work in Progress';

  @override
  String get smartTodoCfdTask => 'Task';

  @override
  String get smartTodoCfdColumn => 'Column';

  @override
  String get smartTodoCfdAge => 'Age';

  @override
  String get smartTodoCfdDays => 'days';

  @override
  String get smartTodoCfdHowCalculated => 'How is it calculated?';

  @override
  String get smartTodoCfdMedian => 'Median';

  @override
  String get smartTodoCfdP85 => 'P85';

  @override
  String get smartTodoCfdP95 => 'P95';

  @override
  String get smartTodoCfdMin => 'Min';

  @override
  String get smartTodoCfdMax => 'Max';

  @override
  String get smartTodoCfdSample => 'Sample';

  @override
  String get smartTodoCfdVsPrevious => 'vs previous period';

  @override
  String get smartTodoCfdArrivalRate => 'Arrival Rate';

  @override
  String get smartTodoCfdCompletionRate => 'Completion Rate';

  @override
  String get smartTodoCfdNetFlow => 'Net Flow';

  @override
  String get smartTodoCfdPerDay => '/day';

  @override
  String get smartTodoCfdPerWeek => '/week';

  @override
  String get smartTodoCfdSeverity => 'Severity';

  @override
  String get smartTodoCfdAssignee => 'Assignee';

  @override
  String get smartTodoCfdUnassigned => 'Unassigned';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Lead Time measures the total time from when a task is created until it is completed.\n\n**Formula:**\nLead Time = Completion Date - Creation Date\n\n**Metrics:**\n- **Average**: Mean of all lead times\n- **Median**: Middle value (less sensitive to outliers)\n- **P85**: 85% of tasks complete within this time\n- **P95**: 95% of tasks complete within this time\n\n**Why it matters:**\nLead Time represents what the customer experiences - the total wait time. Use P85 when giving delivery estimates to clients.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Cycle Time measures the time from when work actually starts (task leaves \'To Do\') until completion.\n\n**Formula:**\nCycle Time = Completion Date - First Work Start Date\n\n**Difference from Lead Time:**\n- **Lead Time** = Customer perspective (includes waiting)\n- **Cycle Time** = Team perspective (active work only)\n\n**How \'Work Start\' is detected:**\nThe first time a task moves out of the \'To Do\' column is recorded as the work start date.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Throughput measures how many tasks are completed per unit of time.\n\n**Formulas:**\n- Daily Average = Completed Tasks / Days in Period\n- Weekly Average = Daily Average × 7\n\n**How to use it:**\nForecast delivery dates:\nRemaining Tasks / Weekly Throughput = Weeks to Complete\n\n**Example:**\n30 tasks remaining, throughput of 10/week = ~3 weeks';

  @override
  String get smartTodoCfdWipExplanation =>
      'WIP (Work In Progress) counts tasks currently being worked on - not in \'To Do\' and not in \'Done\'.\n\n**Formula:**\nWIP = Total Tasks - Tasks in To Do - Tasks in Done\n\n**Little\'s Law:**\nLead Time = WIP / Throughput\n\nReducing WIP directly reduces Lead Time!\n\n**Suggested WIP Limit:**\nTeam Size × 2 (Kanban best practice)\n\n**Status:**\n- Healthy: WIP ≤ Limit\n- Warning: WIP > Limit × 1.25\n- Critical: WIP > Limit × 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'Flow Analysis compares the rate of new tasks arriving vs tasks being completed.\n\n**Formulas:**\n- Arrival Rate = New Tasks Created / Days\n- Completion Rate = Tasks Completed / Days\n- Net Flow = Completed - Arrived\n\n**Status interpretation:**\n- **Draining** (Completion > Arrival): WIP decreasing - good!\n- **Balanced** (within ±10%): Stable flow\n- **Filling** (Arrival > Completion): WIP increasing - action needed';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Bottleneck Detection identifies columns where tasks accumulate or stay too long.\n\n**Algorithm:**\nSeverity = (Count Score + Age Score) / 2\n\nWhere:\n- Count Score = Tasks in Column / 10\n- Age Score = Average Age / 7 days\n\n**Flagged when:**\n- 2+ tasks in column, OR\n- Average age > 2 days\n\n**Severity levels:**\n- Low (< 0.3): Monitor\n- Medium (0.3-0.6): Investigate\n- High (> 0.6): Take action';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP shows tasks currently in progress, sorted by how long they\'ve been worked on.\n\n**Formula:**\nAge = Current Time - Work Start Date (in days)\n\n**Status by age:**\n- Fresh (< 3 days): Normal\n- Warning (3-7 days): May need attention\n- Critical (> 7 days): Likely blocked - investigate!\n\nOld tasks often indicate blockers, unclear requirements, or scope creep.';

  @override
  String get smartTodoCfdTeamBalance => 'Team Balance';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Team Balance shows task distribution across team members.\n\n**Balance Score:**\nCalculated using coefficient of variation (CV).\nScore = 1 / (1 + CV)\n\n**Status:**\n- Balanced (≥80%): Work evenly distributed\n- Uneven (50-80%): Some imbalance\n- Imbalanced (<50%): Significant disparity\n\n**Columns:**\n- To Do: Tasks waiting to start\n- WIP: Tasks in progress\n- Done: Completed tasks';

  @override
  String get smartTodoCfdBalanced => 'Balanced';

  @override
  String get smartTodoCfdUneven => 'Uneven';

  @override
  String get smartTodoCfdImbalanced => 'Imbalanced';

  @override
  String get smartTodoCfdMember => 'Member';

  @override
  String get smartTodoCfdTotal => 'Total';

  @override
  String get smartTodoCfdToDo => 'To Do';

  @override
  String get smartTodoCfdInProgress => 'In Progress';

  @override
  String get smartTodoCfdDone => 'Done';

  @override
  String get smartTodoNewTaskDefault => 'New Task';

  @override
  String get smartTodoRename => 'Rename';

  @override
  String get smartTodoAddActivity => 'Add an activity';

  @override
  String get smartTodoAddColumn => 'Add Column';

  @override
  String get smartTodoParticipantManagement => 'Participant Management';

  @override
  String get smartTodoParticipantsTab => 'Participants';

  @override
  String get smartTodoInvitesTab => 'Invitations';

  @override
  String get smartTodoAddParticipant => 'Add Participant';

  @override
  String smartTodoMembers(int count) {
    return 'Members ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'No pending invitations';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Role: $role';
  }

  @override
  String get smartTodoExpired => 'EXPIRED';

  @override
  String smartTodoSentBy(String name) {
    return 'Sent by $name';
  }

  @override
  String get smartTodoResendEmail => 'Resend Email';

  @override
  String get smartTodoRevoke => 'Revoke';

  @override
  String get smartTodoSendingEmail => 'Sending email...';

  @override
  String get smartTodoEmailResent => 'Email resent!';

  @override
  String get smartTodoEmailSendError => 'Error sending email.';

  @override
  String get smartTodoInvalidSession => 'Invalid session to send email.';

  @override
  String get smartTodoEmail => 'Email';

  @override
  String get smartTodoRole => 'Role';

  @override
  String get smartTodoInviteCreated =>
      'Invitation created and sent successfully!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Invitation created, but email not sent (check Google login/permissions).';

  @override
  String get smartTodoUserAlreadyInvited => 'User already invited.';

  @override
  String get smartTodoInviteCollaborator => 'Invite Collaborator';

  @override
  String get smartTodoEditorRole => 'Editor (Can edit)';

  @override
  String get smartTodoViewerRole => 'Viewer (View only)';

  @override
  String get smartTodoSendEmailNotification => 'Send email notification';

  @override
  String get smartTodoSend => 'Send';

  @override
  String get smartTodoInvalidEmail => 'Invalid email';

  @override
  String get smartTodoUserNotAuthenticated =>
      'User not authenticated or email missing';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Google login required to send emails';

  @override
  String smartTodoInviteSent(String email) {
    return 'Invitation sent to $email';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'User already invited or invitation pending.';

  @override
  String get smartTodoFilterToday => 'Today';

  @override
  String get smartTodoFilterMyTasks => 'My Tasks';

  @override
  String get smartTodoFilterOwner => 'Owner';

  @override
  String get smartTodoViewGlobalTasks => 'View Global Tasks';

  @override
  String get smartTodoViewLists => 'View Lists';

  @override
  String get smartTodoNewListDialogTitle => 'New List';

  @override
  String get smartTodoTitleLabel => 'Title *';

  @override
  String get smartTodoDescriptionLabel => 'Description';

  @override
  String get smartTodoCancel => 'Cancel';

  @override
  String get smartTodoCreate => 'Create';

  @override
  String get smartTodoSave => 'Save';

  @override
  String get smartTodoNoListsPresent => 'No lists available';

  @override
  String get smartTodoCreateFirstList =>
      'Create your first list to get started';

  @override
  String smartTodoMembersCount(int count) {
    return '$count members';
  }

  @override
  String get smartTodoRenameListTitle => 'Rename List';

  @override
  String get smartTodoNewNameLabel => 'New Name';

  @override
  String get smartTodoDeleteListTitle => 'Delete List';

  @override
  String get smartTodoDeleteListConfirm =>
      'Are you sure you want to delete this list and all its tasks? This action is irreversible.';

  @override
  String get smartTodoDelete => 'Delete';

  @override
  String get smartTodoEdit => 'Edit';

  @override
  String get smartTodoSearchHint => 'Search lists...';

  @override
  String get smartTodoSearchTasksHint => 'Search...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'To Do';

  @override
  String get smartTodoColumnInProgress => 'In Progress';

  @override
  String get smartTodoColumnDone => 'Done';

  @override
  String get smartTodoAllPeople => 'All people';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count people';
  }

  @override
  String get smartTodoFilterByPerson => 'Filter by Person';

  @override
  String get smartTodoApplyFilters => 'Apply Filters';

  @override
  String get smartTodoAllTags => 'All tags';

  @override
  String smartTodoTagsCount(int count) {
    return '$count tags';
  }

  @override
  String get smartTodoFilterByTag => 'Filter by Tag';

  @override
  String get smartTodoTagAlreadyExists => 'Tag already exists';

  @override
  String smartTodoError(String error) {
    return 'Error: $error';
  }

  @override
  String get profileMenuTitle => 'Profile';

  @override
  String get profileMenuLogout => 'Logout';

  @override
  String get profileLogoutDialogTitle => 'Logout';

  @override
  String get profileLogoutDialogConfirm => 'Are you sure you want to logout?';

  @override
  String get agileAddToSprint => 'Add to Sprint';

  @override
  String get agileEstimate => 'ESTIMATE';

  @override
  String get agileEstimated => 'Estimated';

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
  String get backlogArchiveCompleted => 'Completed Archive';

  @override
  String get backlogStories => 'stories';

  @override
  String get backlogEstimated => 'estimated';

  @override
  String get backlogShowActive => 'Show active Backlog';

  @override
  String backlogShowArchive(int count) {
    return 'Show Archive ($count completed)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Archive ($count)';
  }

  @override
  String get backlogFilters => 'Filters';

  @override
  String get backlogNewStory => 'New Story';

  @override
  String get backlogSearchHint => 'Search by title, description or ID...';

  @override
  String get backlogStatusFilter => 'Status: ';

  @override
  String get backlogPriorityFilter => 'Priority: ';

  @override
  String get backlogTagFilter => 'Tag: ';

  @override
  String get backlogAllStatuses => 'All';

  @override
  String get backlogAllPriorities => 'All';

  @override
  String get backlogRemoveFilters => 'Remove filters';

  @override
  String get backlogNoStoryFound => 'No story found';

  @override
  String get backlogEmpty => 'Empty backlog';

  @override
  String get backlogAddFirstStory => 'Add the first User Story';

  @override
  String get kanbanWipExceeded =>
      'WIP Limit exceeded! Complete some items before starting new ones.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'Configure WIP';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current of $max max';
  }

  @override
  String get kanbanNoWipLimit => 'No WIP limit';

  @override
  String kanbanItems(int count) {
    return '$count items';
  }

  @override
  String get kanbanEmpty => 'Empty';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'WIP Limit: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Set the maximum number of items that can be in this column at the same time.';

  @override
  String get kanbanWipLimitLabel => 'WIP Limit';

  @override
  String get kanbanWipLimitHint => 'Leave empty for no limit';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Suggestion: start with $count and adjust based on the team.';
  }

  @override
  String get kanbanRemoveLimit => 'Remove Limit';

  @override
  String get kanbanWipExceededTitle => 'WIP Limit Exceeded';

  @override
  String get kanbanWipExceededMessage => 'Moving ';

  @override
  String get kanbanWipExceededIn => ' to ';

  @override
  String get kanbanWipExceededWillExceed => ' will exceed the WIP limit.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Column: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Current: $current | Limit: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'After move: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Suggestion: complete or move other items before starting new ones to maintain an optimal workflow.';

  @override
  String get kanbanMoveAnyway => 'Move Anyway';

  @override
  String get kanbanWipExplanationTitle => 'What are WIP Limits?';

  @override
  String get kanbanWipWhat => 'What are WIP Limits?';

  @override
  String get kanbanWipWhatDesc =>
      'WIP (Work In Progress) Limits are limits on the number of items that can be in a column at the same time.';

  @override
  String get kanbanWipWhy => 'Why use them?';

  @override
  String get kanbanWipBenefit1 => '- Reduce multitasking and increase focus';

  @override
  String get kanbanWipBenefit2 => '- Highlight bottlenecks';

  @override
  String get kanbanWipBenefit3 => '- Improve workflow';

  @override
  String get kanbanWipBenefit4 => '- Speed up item completion';

  @override
  String get kanbanWipWhatToDo => 'What to do if a limit is exceeded?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Complete or move existing items before starting new ones\n2. Help colleagues unblock items in review\n3. Analyze why the limit was exceeded';

  @override
  String get kanbanUnderstood => 'Got it';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'New Sprint';

  @override
  String get sprintNoSprints => 'No sprints';

  @override
  String get sprintCreateFirst => 'Create the first sprint to start';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Start Sprint';

  @override
  String get sprintComplete => 'Complete Sprint';

  @override
  String sprintDays(int days) {
    return '${days}d';
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
  String get sprintPointsCompleted => 'completed';

  @override
  String get sprintVelocity => 'velocity';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}d remaining';
  }

  @override
  String get sprintStartButton => 'Start';

  @override
  String get sprintCompleteActiveFirst =>
      'Complete the active sprint before starting another';

  @override
  String get sprintEditTitle => 'Edit Sprint';

  @override
  String get sprintNewTitle => 'New Sprint';

  @override
  String get sprintNameLabel => 'Sprint Name';

  @override
  String get sprintNameHint => 'e.g. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Enter a name';

  @override
  String get sprintGoalLabel => 'Sprint Goal';

  @override
  String get sprintGoalHint => 'Sprint objective';

  @override
  String get sprintStartDateLabel => 'Start Date';

  @override
  String get sprintEndDateLabel => 'End Date';

  @override
  String sprintDuration(int days) {
    return 'Duration: $days days';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Average velocity: $velocity pts/sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Team: $count members';
  }

  @override
  String get sprintPlanningTitle => 'Sprint Planning';

  @override
  String get sprintPlanningSubtitle =>
      'Select the stories to complete in this sprint';

  @override
  String get sprintPlanningSelected => 'Selected';

  @override
  String get sprintPlanningSuggested => 'Suggested';

  @override
  String get sprintPlanningCapacity => 'Capacity';

  @override
  String get sprintPlanningBasedOnVelocity => 'based on average velocity';

  @override
  String sprintPlanningDays(int days) {
    return '$days days';
  }

  @override
  String get sprintPlanningExceeded => 'Warning: exceeded suggested velocity';

  @override
  String get sprintPlanningNoStories => 'No stories available in the backlog';

  @override
  String get sprintPlanningNotEstimated => 'Not estimated';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Confirm ($count stories)';
  }

  @override
  String get storyFormEditTitle => 'Edit Story';

  @override
  String get storyFormNewTitle => 'New User Story';

  @override
  String get storyFormDetailsTab => 'Details';

  @override
  String get storyFormAcceptanceTab => 'Acceptance Criteria';

  @override
  String get storyFormOtherTab => 'Other';

  @override
  String get storyFormTitleLabel => 'Title *';

  @override
  String get storyFormTitleHint => 'E.g. US-123: As a user I want...';

  @override
  String get storyFormTitleRequired => 'Enter a title';

  @override
  String get storyFormUseTemplate => 'Use User Story template';

  @override
  String get storyFormTemplateSubtitle => 'As a... I want... So that...';

  @override
  String get storyFormAsA => 'As a...';

  @override
  String get storyFormAsAHint => 'user, admin, customer...';

  @override
  String get storyFormIWant => 'I want...';

  @override
  String get storyFormIWantHint => 'to be able to do something...';

  @override
  String get storyFormIWantRequired => 'Enter what the user wants';

  @override
  String get storyFormSoThat => 'So that...';

  @override
  String get storyFormSoThatHint => 'get a benefit...';

  @override
  String get storyFormDescriptionLabel => 'Description';

  @override
  String get storyFormDescriptionHint => 'Acceptance criteria, notes...';

  @override
  String get storyFormDescriptionRequired => 'Enter a description';

  @override
  String get storyFormPreview => 'Preview:';

  @override
  String get storyFormEmptyDescription => '(empty description)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Acceptance Criteria';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Define when the story can be considered complete';

  @override
  String get storyFormAddCriterionHint => 'Add acceptance criterion...';

  @override
  String get storyFormNoCriteria => 'No criteria defined';

  @override
  String get storyFormSuggestions => 'Suggestions:';

  @override
  String get storyFormSuggestion1 => 'Data is saved correctly';

  @override
  String get storyFormSuggestion2 => 'User receives confirmation';

  @override
  String get storyFormSuggestion3 => 'Form shows validation errors';

  @override
  String get storyFormSuggestion4 => 'Feature is accessible from mobile';

  @override
  String get storyFormPriorityLabel => 'Priority (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Business Value';

  @override
  String get storyFormBusinessValueHigh => 'High business value';

  @override
  String get storyFormBusinessValueMedium => 'Medium value';

  @override
  String get storyFormBusinessValueLow => 'Low business value';

  @override
  String get storyFormStoryPointsLabel => 'Estimated in Story Points';

  @override
  String get storyFormStoryPointsTooltip =>
      'Story Points represent the relative complexity of the work.\nUse the Fibonacci sequence: 1 (simple) -> 21 (very complex).';

  @override
  String get storyFormNoPoints => 'None';

  @override
  String get storyFormPointsSimple => 'Quick and simple task';

  @override
  String get storyFormPointsMedium => 'Medium complexity task';

  @override
  String get storyFormPointsComplex => 'Complex task, requires analysis';

  @override
  String get storyFormPointsVeryComplex =>
      'Very complex, consider splitting the story';

  @override
  String get storyFormTagsLabel => 'Tags';

  @override
  String get storyFormAddTagHint => 'Add tag...';

  @override
  String get storyFormExistingTags => 'Existing tags:';

  @override
  String get storyFormAssigneeLabel => 'Assign to';

  @override
  String get storyFormAssigneeHint => 'Select a team member';

  @override
  String get storyFormNotAssigned => 'Not assigned';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points points';
  }

  @override
  String get storyDetailDescriptionTitle => 'Description';

  @override
  String get storyDetailNoDescription => 'No description';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Acceptance Criteria ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'No criteria defined';

  @override
  String get storyDetailEstimationTitle => 'Estimate';

  @override
  String get storyDetailFinalEstimate => 'Final estimate: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count estimates received';
  }

  @override
  String get storyDetailInfoTitle => 'Information';

  @override
  String get storyDetailBusinessValue => 'Business Value';

  @override
  String get storyDetailAssignedTo => 'Assigned to';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Created on';

  @override
  String get storyDetailStartedAt => 'Started on';

  @override
  String get storyDetailCompletedAt => 'Completed on';

  @override
  String get landingBadge => 'Agile Team Tools';

  @override
  String get landingHeroTitle => 'Build better products\nwith Keisen';

  @override
  String get landingHeroSubtitle =>
      'Prioritize, estimate, and manage your projects with collaborative tools. All in one place, for free.';

  @override
  String get landingStartFree => 'Start for Free';

  @override
  String get landingEverythingNeed => 'Everything you need';

  @override
  String get landingModernTools => 'Tools designed for modern teams';

  @override
  String get landingSmartTodoBadge => 'Productivity';

  @override
  String get landingSmartTodoTitle => 'Smart Todo List';

  @override
  String get landingSmartTodoSubtitle =>
      'Intelligent and collaborative task management for modern teams';

  @override
  String get landingSmartTodoCollaborativeTitle => 'Collaborative Task Lists';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo transforms daily activity management into a fluid and collaborative process. Create lists, assign tasks to team members, and monitor progress in real-time.\n\nIdeal for distributed teams needing continuous synchronization on activities to complete.';

  @override
  String get landingSmartTodoImportTitle => 'Flexible Import';

  @override
  String get landingSmartTodoImportDesc =>
      'Import your activities from external sources in a few clicks. Support for CSV files, copy/paste from Excel, or free text. The system automatically recognizes data structure.\n\nEasily migrate from other tools without losing information or manually re-entering every task.';

  @override
  String get landingSmartTodoShareTitle => 'Sharing and Invites';

  @override
  String get landingSmartTodoShareDesc =>
      'Invite colleagues and collaborators to your lists via email. Each participant can view, comment, and update the status of assigned tasks.\n\nPerfect for managing cross-functional projects with external stakeholders or cross-functional teams.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Smart Todo Features';

  @override
  String get landingEisenhowerBadge => 'Prioritization';

  @override
  String get landingEisenhowerSubtitle =>
      'The decision-making method used by leaders to manage time';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Urgent vs Important';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'The Eisenhower Matrix, devised by the 34th US President Dwight D. Eisenhower, divides activities into four quadrants based on two criteria: urgency and importance.\n\nThis decision framework helps distinguish what requires immediate attention from what contributes to long-term goals.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Better Decisions';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'By constantly applying the matrix, you develop a results-oriented mindset. You learn to say \"no\" to distractions and focus on what generates real value.\n\nOur digital tool makes this process immediate: drag activities into the correct quadrant and get a clear view of your priorities.';

  @override
  String get landingEisenhowerBenefitsTitle => 'Why use the Eisenhower Matrix?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Studies show that 80% of daily activities fall into quadrants 3 and 4 (not important). The matrix helps you identify them and free up time for what truly matters.';

  @override
  String get landingEisenhowerQuadrants =>
      'Quadrant 1: Urgent + Important → Do Now\nQuadrant 2: Not Urgent + Important → Schedule\nQuadrant 3: Urgent + Not Important → Delegate\nQuadrant 4: Not Urgent + Not Important → Eliminate';

  @override
  String get landingAgileBadge => 'Methodologies';

  @override
  String get landingAgileTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSubtitle =>
      'Implement best practices for iterative software development';

  @override
  String get landingAgileIterativeTitle =>
      'Iterative and Incremental Development';

  @override
  String get landingAgileIterativeDesc =>
      'The Agile approach divides work into short cycles called Sprints, typically 1-4 weeks. Each iteration produces a working product increment.\n\nWith Keisen you can manage your backlog, plan sprints and monitor team velocity in real time.';

  @override
  String get landingAgileScrumTitle => 'Scrum Framework';

  @override
  String get landingAgileScrumDesc =>
      'Scrum is the most popular Agile framework. It defines roles (Product Owner, Scrum Master, Team), events (Sprint Planning, Daily, Review, Retrospective) and artifacts (Product Backlog, Sprint Backlog).\n\nKeisen supports all Scrum events with dedicated tools for each ceremony.';

  @override
  String get landingAgileKanbanTitle => 'Kanban Board';

  @override
  String get landingAgileKanbanDesc =>
      'The Kanban method visualizes workflow through columns representing process states. It limits Work In Progress (WIP) to maximize throughput.\n\nOur Kanban board supports column customization, WIP limits, and flow metrics.';

  @override
  String get landingEstimationBadge => 'Estimation';

  @override
  String get landingEstimationTitle => 'Collaborative Estimation Techniques';

  @override
  String get landingEstimationSubtitle =>
      'Choose the best method for your team for accurate estimates';

  @override
  String get landingEstimationFeaturesTitle => 'Estimation Room Features';

  @override
  String get landingRetroBadge => 'Retrospective';

  @override
  String get landingRetroTitle => 'Interactive Retrospectives';

  @override
  String get landingRetroSubtitle =>
      'Real-time collaborative tools: timers, anonymous voting, action items.';

  @override
  String get landingRetroActionTitle => 'Action Items Tracking';

  @override
  String get landingRetroActionDesc =>
      'Each retrospective generates trackable action items with owners, deadlines, and status. Monitor follow-up over time.';

  @override
  String get landingWorkflowBadge => 'Workflow';

  @override
  String get landingWorkflowTitle => 'How it works';

  @override
  String get landingWorkflowSubtitle => 'Start in 3 simple steps';

  @override
  String get landingStep1Title => 'Create a project';

  @override
  String get landingStep1Desc =>
      'Create your Agile project and invite the team. Configure sprints, backlogs, and boards.';

  @override
  String get landingStep2Title => 'Collaborate';

  @override
  String get landingStep2Desc =>
      'Estimate user stories together, organize sprints, and track progress in real-time.';

  @override
  String get landingStep3Title => 'Improve';

  @override
  String get landingStep3Desc =>
      'Analyze metrics, conduct retrospectives, and continuously improve the process.';

  @override
  String get landingCtaTitle => 'Ready to start?';

  @override
  String get landingCtaDesc =>
      'Sign up for free and start collaborating with your team.';

  @override
  String get landingFooterBrandDesc =>
      'Collaborative tools for agile teams.\nPlan, estimate, and improve together.';

  @override
  String get landingFooterProduct => 'Product';

  @override
  String get landingFooterResources => 'Resources';

  @override
  String get landingFooterCompany => 'Company';

  @override
  String get landingFooterLegal => 'Legal';

  @override
  String get landingCopyright => '© 2026 Keisen. All rights reserved.';

  @override
  String get featureSmartImportDesc =>
      'Quick task creation with description\nTeam member assignment\nConfigurable priority and deadline\nCompletion notifications';

  @override
  String get featureImportDesc =>
      'Import from CSV file\nCopy/paste from Excel\nSmart text parsing\nAutomatic field mapping';

  @override
  String get featureShareDesc =>
      'Email invitations\nConfigurable permissions\nTask comments\nChange history';

  @override
  String get featureSmartTaskCreation => 'Quick task creation';

  @override
  String get featureTeamAssignment => 'Team assignment';

  @override
  String get featurePriorityDeadline => 'Priority and Deadlines';

  @override
  String get featureCompletionNotifications => 'Completion notifications';

  @override
  String get featureCsvImport => 'CSV Import';

  @override
  String get featureExcelPaste => 'Copy/Paste Excel';

  @override
  String get featureSmartParsing => 'Smart Parsing';

  @override
  String get featureAutoMapping => 'Automatic Mapping';

  @override
  String get featureEmailInvites => 'Email Invites';

  @override
  String get featurePermissions => 'Configurable Permissions';

  @override
  String get featureTaskComments => 'Task Comments';

  @override
  String get featureHistory => 'Change History';

  @override
  String get featureAdvancedFilters => 'Advanced Filters';

  @override
  String get featureFullTextSearch => 'Full-text Search';

  @override
  String get featureSorting => 'Sorting';

  @override
  String get featureTagsCategories => 'Tags & Categories';

  @override
  String get featureArchiving => 'Archiving';

  @override
  String get featureSort => 'Sorting';

  @override
  String get featureDataExport => 'Data Export';

  @override
  String get landingIntroFeatures =>
      'Sprint Planning with team capacity\nPrioritized backlog with drag & drop\nVelocity tracking and burndown chart\nDaily standup facilitated';

  @override
  String get landingAgileScrumFeatures =>
      'Product Backlog with story points\nSprint Backlog with task breakdown\nRetrospective board integrated\nAutomatic Scrum metrics';

  @override
  String get landingAgileKanbanFeatures =>
      'Customizable columns\nWIP limits per column\nIntuitive drag & drop\nLead time and cycle time';

  @override
  String get landingEstimationPokerDesc =>
      'The classic method: each member chooses a card (1, 2, 3, 5, 8...). Estimates are revealed simultaneously to avoid bias.';

  @override
  String get landingEstimationTShirtTitle => 'T-Shirt Size';

  @override
  String get landingEstimationTShirtSubtitle => 'Relative sizes';

  @override
  String get landingEstimationTShirtDesc =>
      'Quick estimate using sizes: XS, S, M, L, XL, XXL. Ideal for initial backlog grooming or when an approximate estimate is needed.';

  @override
  String get landingEstimationPertTitle => 'Three-Point (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Optimistic / Likely / Pessimistic';

  @override
  String get landingEstimationPertDesc =>
      'Statistical technique: each member provides 3 estimates (O, M, P). The PERT formula calculates the weighted estimate: (O + 4M + P) / 6.';

  @override
  String get landingEstimationBucketTitle => 'Bucket System';

  @override
  String get landingEstimationBucketSubtitle => 'Quick categorization';

  @override
  String get landingEstimationBucketDesc =>
      'User stories are assigned to predefined buckets. Great for estimating large quantities of items quickly in refinement sessions.';

  @override
  String get landingEstimationChipHiddenVote => 'Hidden vote';

  @override
  String get landingEstimationChipTimer => 'Configurable timer';

  @override
  String get landingEstimationChipStats => 'Real-time statistics';

  @override
  String get landingEstimationChipParticipants => 'Up to 20 participants';

  @override
  String get landingEstimationChipHistory => 'Estimate history';

  @override
  String get landingEstimationChipExport => 'Export results';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'The classic format: what to start doing, what to stop doing, what to keep doing.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Emotional retrospective: what made us angry, sad or happy.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For - complete sprint analysis.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Visual metaphor: wind (helpers), anchor (obstacles), rocks (risks), island (goals).';

  @override
  String get landingRetroTemplateWentWellTitle => 'Went Well / To Improve';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Simple and direct format: what went well and what to improve.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - concrete decisions for the next sprint.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Action Items Tracking';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Each retrospective generates trackable action items with owner, deadline and status. Monitor follow-up over time.';

  @override
  String get landingAgileSectionBadge => 'Methodologies';

  @override
  String get landingAgileSectionTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSectionSubtitle =>
      'Implement the best practices of iterative software development';

  @override
  String get landingSmartTodoCollabTitle => 'Collaborative Task Lists';

  @override
  String get landingSmartTodoCollabDesc =>
      'Smart Todo transforms daily activity management into a smooth and collaborative process. Create lists, assign tasks to team members and monitor progress in real-time.\n\nIdeal for distributed teams that need continuous synchronization on activities to complete.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Quick task creation with description\nTeam member assignment\nConfigurable priority and deadline\nCompletion notifications';

  @override
  String get landingSmartTodoImportFeatures =>
      'Import from CSV file\nCopy/paste from Excel\nSmart text parsing\nAutomatic field mapping';

  @override
  String get landingSmartTodoSharingTitle => 'Sharing and Invitations';

  @override
  String get landingSmartTodoSharingDesc =>
      'Invite colleagues and collaborators to your lists via email. Each participant can view, comment and update the status of assigned tasks.\n\nPerfect for managing cross-functional projects with external stakeholders or cross-functional teams.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Email invitations\nConfigurable permissions\nTask comments\nChange history';

  @override
  String get landingSmartTodoChipFilters => 'Advanced filters';

  @override
  String get landingSmartTodoChipSearch => 'Full-text search';

  @override
  String get landingSmartTodoChipSort => 'Sorting';

  @override
  String get landingSmartTodoChipTags => 'Tags and categories';

  @override
  String get landingSmartTodoChipArchive => 'Archiving';

  @override
  String get landingSmartTodoChipExport => 'Data export';

  @override
  String get landingEisenhowerTitle => 'Eisenhower Matrix';

  @override
  String get landingEisenhowerUrgentTitle => 'Urgent vs Important';

  @override
  String get landingEisenhowerUrgentDesc =>
      'The Eisenhower Matrix, devised by the 34th President of the United States Dwight D. Eisenhower, divides activities into four quadrants based on two criteria: urgency and importance.\n\nThis decision-making framework helps distinguish what requires immediate attention from what contributes to long-term goals.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Quadrant 1: Urgent + Important → Do now\nQuadrant 2: Not urgent + Important → Schedule\nQuadrant 3: Urgent + Not important → Delegate\nQuadrant 4: Not urgent + Not important → Eliminate';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Intuitive drag & drop\nReal-time team collaboration\nDistribution statistics\nExport for reporting';

  @override
  String get landingEisenhowerUrgentLabel => 'URGENT';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NOT URGENT';

  @override
  String get landingEisenhowerImportantLabel => 'IMPORTANT';

  @override
  String get landingEisenhowerNotImportantLabel => 'NOT IMPORTANT';

  @override
  String get landingEisenhowerDoLabel => 'DO';

  @override
  String get landingEisenhowerDoDesc => 'Crises, deadlines, emergencies';

  @override
  String get landingEisenhowerPlanLabel => 'PLAN';

  @override
  String get landingEisenhowerPlanDesc => 'Strategy, growth, relationships';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGATE';

  @override
  String get landingEisenhowerDelegateDesc => 'Interruptions, meetings, emails';

  @override
  String get landingEisenhowerEliminateLabel => 'ELIMINATE';

  @override
  String get landingEisenhowerEliminateDesc =>
      'Distractions, social, time wasters';

  @override
  String get landingFooterFeatures => 'Features';

  @override
  String get landingFooterPricing => 'Pricing';

  @override
  String get landingFooterChangelog => 'Release Notes';

  @override
  String get landingFooterRoadmap => 'Roadmap';

  @override
  String get landingFooterDocs => 'Documentation';

  @override
  String get landingFooterAgileGuides => 'Agile Guides';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Community';

  @override
  String get landingFooterAbout => 'About Us';

  @override
  String get landingFooterContact => 'Contact';

  @override
  String get landingFooterJobs => 'Careers';

  @override
  String get landingFooterPress => 'Press Kit';

  @override
  String get landingFooterPrivacy => 'Privacy Policy';

  @override
  String get landingFooterTerms => 'Terms of Service';

  @override
  String get landingFooterCookies => 'Cookie Policy';

  @override
  String get landingFooterGdpr => 'GDPR';

  @override
  String get legalCookieTitle => 'We use cookies';

  @override
  String get legalCookieMessage =>
      'We use cookies to improve your experience and for analytical purposes. By continuing, you accept the use of cookies.';

  @override
  String get legalCookieAccept => 'Accept all';

  @override
  String get legalCookieRefuse => 'Necessary only';

  @override
  String get legalCookiePolicy => 'Cookie Policy';

  @override
  String get legalPrivacyPolicy => 'Privacy Policy';

  @override
  String get legalTermsOfService => 'Terms of Service';

  @override
  String get legalGDPR => 'GDPR';

  @override
  String get legalLastUpdatedLabel => 'Last updated';

  @override
  String get legalLastUpdatedDate => 'January 18, 2026';

  @override
  String get legalAcceptTerms =>
      'I accept the Terms of Service and Privacy Policy';

  @override
  String get legalMustAcceptTerms => 'You must accept the terms to continue';

  @override
  String get legalPrivacyContent =>
      '## 1. Introduction\nWelcome to **Keisen** (\"we\", \"our\", \"the Platform\"). Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use our web application.\n\n## 2. Information We Collect\nWe collect two types of data and information:\n\n### 2.1 User-Provided Information\n- **Account Data:** When you sign in via Google Sign-In or create an account, we collect your name, email address, and profile picture.\n- **User Content:** We collect data you voluntarily enter into the platform, including tasks, estimates, retrospectives, comments, and team configurations.\n\n### 2.2 Automatically Collected Information\n- **System Logs:** IP addresses, browser type, pages visited, and timestamps.\n- **Cookies:** We use essential technical cookies to keep your session active.\n\n## 3. How We Use Your Information\nWe use the collected information to:\n- Provide, operate, and maintain our Services.\n- Improve, personalize, and expand our Platform.\n- Analyze how you use the website to improve the user experience.\n- Send you service emails (e.g., team invitations, important updates).\n\n## 4. Information Sharing\nWe do not sell your personal data. We share information only with:\n- **Service Providers:** We use **Google Firebase** (Google LLC) for hosting, authentication, and database services. Data is processed according to [Google\'s Privacy Policy](https://policies.google.com/privacy).\n- **Legal Obligations:** If required by law or to protect our rights.\n\n## 5. Data Security\nWe implement industry-standard technical and organizational security measures (such as encryption in transit) to protect your data. However, no method of transmission over the Internet is 100% secure.\n\n## 6. Your Rights\nYou have the right to:\n- Access your personal data.\n- Request the correction of inaccurate data.\n- Request the deletion of your data (\"Right to be forgotten\").\n- Object to the processing of your data.\n\nTo exercise these rights, contact us at: suppkesien@gmail.com.\n\n## 7. Changes to This Policy\nWe may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Policy on this page.';

  @override
  String get legalTermsContent =>
      '## 1. Acceptance of Terms\nBy accessing or using **Keisen**, you agree to be bound by these Terms of Service (\"Terms\"). If you do not agree to these Terms, you must not use our Services.\n\n## 2. Description of Service\nKeisen is a collaboration platform for agile teams offering tools like Smart Todo, Eisenhower Matrix, Estimation Room, and Agile Process Management. We reserve the right to modify or discontinue the service at any time.\n\n## 3. User Accounts\nYou are responsible for maintaining the confidentiality of your account credentials and all activities that occur under your account. We reserve the right to suspend or delete accounts that violate these Terms.\n\n## 4. User Conduct\nYou agree not to use the Service to:\n- Violate local, national, or international laws.\n- Upload offensive, defamatory, or illegal content.\n- Attempt unauthorized access to the Platform\'s systems.\n\n## 5. Intellectual Property\nAll intellectual property rights related to the Platform and its original content (excluding user-provided content) are the exclusive property of Leonardo Torella.\n\n## 6. Limitation of Liability\nTo the maximum extent permitted by law, Keisen is provided \"as is\" and \"as available\". We do not guarantee that the service will be uninterrupted or error-free. We will not be liable for indirect, incidental, or consequential damages arising from the use of the service.\n\n## 7. Governing Law\nThese Terms are governed by the laws of the Italian State.\n\n## 8. Contacts\nFor questions about these Terms, contact us at: suppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. What are Cookies?\nCookies are small text files that are saved on your device when you visit a website. They are widely used to make websites work more efficiently and provide information to site owners.\n\n## 2. How We Use Cookies\nWe use cookies for several purposes:\n\n### 2.1 Technical Cookies (Essential)\nThese cookies are necessary for the website to function and cannot be turned off in our systems. They are usually set only in response to actions you take that constitute a request for services, such as setting your privacy preferences, logging in, or filling out forms.\n*Example:* Firebase Auth session cookies to keep the user logged in.\n\n### 2.2 Analytical Cookies\nThese cookies allow us to count visits and traffic sources so we can measure and improve our site\'s performance. All information collected by these cookies is aggregated and therefore anonymous.\n\n## 3. Cookie Management\nMost web browsers allow you to control most cookies through the browser settings. However, if you disable essential cookies, some parts of our Service may not work correctly (e.g., you won\'t be able to log in).\n\n## 4. Third-Party Cookies\nWe use third-party services like **Google Firebase** that may set their own cookies. We encourage you to consult their respective privacy policies for more details.';

  @override
  String get legalGdprContent =>
      '## Commitment to Data Protection (GDPR)\nIn accordance with the European Union General Data Protection Regulation (GDPR), Keisen is committed to protecting users\' personal data and ensuring transparency in its processing.\n\n## Data Controller\nThe Data Controller is:\n**Keisen Team**\nEmail: suppkesien@gmail.com\n\n## Legal Basis for Processing\nWe process your personal data only when we have a legal basis to do so. This includes:\n- **Consent:** You have given us permission to process your data for a specific purpose.\n- **Performance of a contract:** Processing is necessary to provide the Services you have requested (e.g., use of the platform).\n- **Legitimate interest:** Processing is necessary for our legitimate interests (e.g., security, service improvement), unless your fundamental rights and freedoms override those interests.\n\n## Data Transfer\nYour data is stored on secure servers provided by Google Cloud Platform (Google Firebase). Google adheres to international security standards and complies with GDPR through Standard Contractual Clauses (SCC).\n\n## Your GDPR Rights\nAs a user in the EU, you have the following rights:\n1.  **Right to access:** You have the right to request copies of your personal data.\n2.  **Right to rectification:** You have the right to request the correction of information you believe is inaccurate.\n3.  **Right to erasure (\"Right to be forgotten\"):** You have the right to request the deletion of your personal data, under certain conditions.\n4.  **Right to restrict processing:** You have the right to request the restriction of processing your data.\n5.  **Right to data portability:** You have the right to request the transfer of the data we have collected to another organization or directly to you.\n\n## Exercise of Rights\nIf you wish to exercise any of these rights, please contact us at: suppkesien@gmail.com. We will respond to your request within one month.';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileExportData => 'Export my data';

  @override
  String get profileDeleteAccountConfirm =>
      'Are you sure you want to permanently delete your account? This action is irreversible.';

  @override
  String get subscriptionTitle => 'Subscription';

  @override
  String get subscriptionTabPlans => 'Plans';

  @override
  String get subscriptionTabUsage => 'Usage';

  @override
  String get subscriptionTabBilling => 'Billing';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count active projects';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count Smart Todo lists';
  }

  @override
  String get subscriptionCurrentPlan => 'Current plan';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Upgrade to $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Downgrade to $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Choose $plan';
  }

  @override
  String get subscriptionMonthly => 'Monthly';

  @override
  String get subscriptionYearly => 'Yearly (-17%)';

  @override
  String get subscriptionLimitReached => 'Limit reached';

  @override
  String get subscriptionLimitProjects =>
      'You have reached the maximum number of projects for your plan. Upgrade to Premium to create more projects.';

  @override
  String get subscriptionLimitLists =>
      'You have reached the maximum number of lists for your plan. Upgrade to Premium to create more lists.';

  @override
  String get subscriptionLimitTasks =>
      'You have reached the maximum number of tasks for this project. Upgrade to Premium to add more tasks.';

  @override
  String get subscriptionLimitInvites =>
      'You have reached the maximum number of invites for this project. Upgrade to Premium to invite more people.';

  @override
  String get subscriptionLimitEstimations =>
      'You have reached the maximum number of estimation sessions. Upgrade to Premium to create more.';

  @override
  String get subscriptionLimitRetrospectives =>
      'You have reached the maximum number of retrospectives. Upgrade to Premium to create more.';

  @override
  String get subscriptionLimitAgileProjects =>
      'You have reached the maximum number of agile projects. Upgrade to Premium to create more.';

  @override
  String get subscriptionLimitDefault =>
      'You have reached the limit of your current plan.';

  @override
  String get subscriptionCurrentUsage => 'Current usage';

  @override
  String get subscriptionUpgradeToPremium => 'Upgrade to Premium';

  @override
  String get subscriptionBenefitProjects => '30 active projects';

  @override
  String get subscriptionBenefitLists => '30 Smart Todo lists';

  @override
  String get subscriptionBenefitTasks => '100 tasks per project';

  @override
  String get subscriptionBenefitNoAds => 'No ads';

  @override
  String get subscriptionStartingFrom => 'Starting from €4.99/month';

  @override
  String get subscriptionLater => 'Later';

  @override
  String get subscriptionViewPlans => 'View plans';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'You can create 1 more $entity';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'You can create $count more $entity';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Used: $count';
  }

  @override
  String get subscriptionUnlimited => 'Unlimited';

  @override
  String subscriptionLimit(int count) {
    return 'Limit: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Plan usage';

  @override
  String get subscriptionRefresh => 'Refresh';

  @override
  String get subscriptionAdsActive => 'Ads active';

  @override
  String get subscriptionRemoveAds => 'Upgrade to Premium to remove ads';

  @override
  String get subscriptionNoAds => 'No ads';

  @override
  String get subscriptionLoadError => 'Unable to load usage data';

  @override
  String get subscriptionAdLabel => 'AD';

  @override
  String get subscriptionAdPlaceholder => 'Ad Placeholder';

  @override
  String get subscriptionDevEnvironment => '(Development environment)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Remove ads and unlock advanced features';

  @override
  String get subscriptionUpgradeButton => 'Upgrade';

  @override
  String subscriptionLoadingError(String error) {
    return 'Loading error: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Complete the payment in the opened window';

  @override
  String subscriptionError(String error) {
    return 'Error: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Confirm downgrade';

  @override
  String get subscriptionDowngradeMessage =>
      'Are you sure you want to switch to the Free plan?\n\nYour subscription will remain active until the end of the current period, after which you will automatically switch to the Free plan.\n\nYou will not lose your data, but some features may be limited.';

  @override
  String get subscriptionCancel => 'Cancel';

  @override
  String get subscriptionConfirmDowngradeButton => 'Confirm downgrade';

  @override
  String get subscriptionCancelled =>
      'Subscription cancelled. It will remain active until the end of the period.';

  @override
  String subscriptionPortalError(String error) {
    return 'Portal opening error: $error';
  }

  @override
  String get subscriptionRetry => 'Retry';

  @override
  String get subscriptionChooseRightPlan => 'Choose the right plan for you';

  @override
  String get subscriptionStartFree => 'Start free, upgrade when you want';

  @override
  String subscriptionPlan(String plan) {
    return 'Plan $plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Current Plan: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Trial until $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Renewal: $date';
  }

  @override
  String get subscriptionManage => 'Manage';

  @override
  String get subscriptionLoginRequired => 'Please login to view usage';

  @override
  String get subscriptionSuggestion => 'Suggestion';

  @override
  String get subscriptionSuggestionText =>
      'Upgrade to Premium to unlock more projects, remove ads and increase limits. Try free for 7 days!';

  @override
  String get subscriptionPaymentManagement => 'Payment management';

  @override
  String get subscriptionNoActiveSubscription => 'No active subscription';

  @override
  String get subscriptionUsingFreePlan => 'You are using the Free plan';

  @override
  String get subscriptionViewPaidPlans => 'View paid plans';

  @override
  String get subscriptionPaymentMethod => 'Payment method';

  @override
  String get subscriptionEditPaymentMethod => 'Edit card or payment method';

  @override
  String get subscriptionInvoices => 'Invoices';

  @override
  String get subscriptionViewInvoices => 'View and download invoices';

  @override
  String get subscriptionCancelSubscription => 'Cancel subscription';

  @override
  String get subscriptionAccessUntilEnd =>
      'Access will remain active until the end of the period';

  @override
  String get subscriptionPaymentHistory => 'Payment history';

  @override
  String get subscriptionNoPayments => 'No payments recorded';

  @override
  String get subscriptionCompleted => 'Completed';

  @override
  String get subscriptionDateNotAvailable => 'Date not available';

  @override
  String get subscriptionFaq => 'Frequently asked questions';

  @override
  String get subscriptionFaqCancel => 'Can I cancel at any time?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Yes, you can cancel your subscription at any time. Access will remain active until the end of the paid period.';

  @override
  String get subscriptionFaqTrial => 'How does the free trial work?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'With the free trial you have full access to all features of the chosen plan. At the end of the trial period, the paid subscription will start automatically.';

  @override
  String get subscriptionFaqChange => 'Can I change plans?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'You can upgrade or downgrade at any time. The amount will be calculated proportionally.';

  @override
  String get subscriptionFaqData => 'Is my data safe?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Absolutely yes. You will never lose your data, even if you switch to a lower plan. Some features may be limited, but the data remains always accessible.';

  @override
  String get subscriptionStatusActive => 'Active';

  @override
  String get subscriptionStatusTrialing => 'Trialing';

  @override
  String get subscriptionStatusPastDue => 'Past due';

  @override
  String get subscriptionStatusCancelled => 'Cancelled';

  @override
  String get subscriptionStatusExpired => 'Expired';

  @override
  String get subscriptionStatusPaused => 'Paused';

  @override
  String get subscriptionStatus => 'Status';

  @override
  String get subscriptionStarted => 'Started';

  @override
  String get subscriptionNextRenewal => 'Next renewal';

  @override
  String get subscriptionTrialEnd => 'Trial end';

  @override
  String get toolSectionTitle => 'Tools';

  @override
  String get deadlineTitle => 'Deadlines';

  @override
  String get deadlineNoUpcoming => 'No upcoming deadlines';

  @override
  String get deadlineAll => 'All';

  @override
  String get deadlineToday => 'Today';

  @override
  String get deadlineTomorrow => 'Tomorrow';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Task';

  @override
  String get favTitle => 'Favorites';

  @override
  String get favFilterAll => 'All';

  @override
  String get favFilterTodo => 'Todo Lists';

  @override
  String get favFilterMatrix => 'Matrices';

  @override
  String get favFilterProject => 'Projects';

  @override
  String get favFilterPoker => 'Estimation';

  @override
  String get actionRemoveFromFavorites => 'Remove from favorites';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'No favorites found';

  @override
  String get favTypeTodo => 'Todo List';

  @override
  String get favTypeMatrix => 'Eisenhower Matrix';

  @override
  String get favTypeProject => 'Agile Project';

  @override
  String get favTypeRetro => 'Retrospective';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Tool';

  @override
  String get deadline2Days => '2 Days';

  @override
  String get deadline3Days => '3 Days';

  @override
  String get deadline5Days => '5 Days';

  @override
  String get deadlineConfigTitle => 'Configure Shortcuts';

  @override
  String get deadlineConfigDesc =>
      'Choose the timeframes to display in the header.';

  @override
  String get smartTodoClose => 'Close';

  @override
  String get smartTodoDone => 'Done';

  @override
  String get smartTodoAdd => 'Add';

  @override
  String get smartTodoEmailLabel => 'Email';

  @override
  String get exceptionLoginGoogleRequired =>
      'Google login required to send emails';

  @override
  String get exceptionUserNotAuthenticated => 'User not authenticated';

  @override
  String errorLoginFailed(String error) {
    return 'Login error: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Participants ($count)';
  }

  @override
  String get actionReopen => 'Reopen';

  @override
  String get retroWaitingForFacilitator =>
      'Waiting for facilitator to start the session...';

  @override
  String get retroGeneratingSheet => 'Generating Google Sheet...';

  @override
  String get retroExportSuccess => 'Export completed!';

  @override
  String get retroExportSuccessMessage =>
      'Your retrospective has been exported to Google Sheets.';

  @override
  String get retroExportError => 'Error exporting to Sheets.';

  @override
  String get retroReportCopied =>
      'Report copied to clipboard! Paste in Excel or Notes.';

  @override
  String get retroReopenTitle => 'Reopen Retrospective';

  @override
  String get retroReopenConfirm =>
      'Are you sure you want to reopen the retrospective? It will go back to Discussion phase.';

  @override
  String get errorAuthRequired => 'Authentication required';

  @override
  String get errorRetroIdMissing => 'Retrospective ID missing';

  @override
  String get pokerInviteAccepted => 'Invite accepted! Redirecting to session.';

  @override
  String get pokerInviteRefused => 'Invite refused';

  @override
  String get pokerConfirmRefuseTitle => 'Refuse Invite';

  @override
  String get pokerConfirmRefuseContent =>
      'Are you sure you want to refuse this invite?';

  @override
  String get pokerVerifyingInvite => 'Verifying invite...';

  @override
  String get actionBackHome => 'Back to Home';

  @override
  String get actionSignin => 'Sign In';

  @override
  String get exceptionStoryNotFound => 'Story not found';

  @override
  String get exceptionNoTasksInProject => 'No tasks found in project';

  @override
  String get exceptionInvitePending => 'Invite already pending for this email';

  @override
  String get exceptionAlreadyParticipant => 'User is already a participant';

  @override
  String get exceptionInviteInvalid => 'Invite not valid or expired';

  @override
  String get exceptionInviteCalculated => 'Invite expired';

  @override
  String get exceptionInviteWrongUser => 'Invite intended for another user';

  @override
  String get todoImportTasks => 'Import Tasks';

  @override
  String get todoExportSheets => 'Export to Sheets';

  @override
  String get todoDeleteColumnTitle => 'Delete Column';

  @override
  String get todoDeleteColumnConfirm =>
      'Are you sure? Tasks in this column will be lost.';

  @override
  String get exceptionListNotFound => 'List not found';

  @override
  String get langItalian => 'Italiano';

  @override
  String get langEnglish => 'English';

  @override
  String get langFrench => 'Français';

  @override
  String get langSpanish => 'Español';

  @override
  String get jsonExportLabel => 'Download JSON copy of your data';

  @override
  String errorExporting(String error) {
    return 'Error exporting: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'List';

  @override
  String get smartTodoViewResource => 'By Resource';

  @override
  String get smartTodoInviteTooltip => 'Invite';

  @override
  String get smartTodoOptionsTooltip => 'More Options';

  @override
  String get smartTodoActionImport => 'Import Tasks';

  @override
  String get smartTodoActionExportSheets => 'Export to Sheets';

  @override
  String get smartTodoDeleteColumnTitle => 'Delete Column';

  @override
  String get smartTodoDeleteColumnContent =>
      'Are you sure? Tasks in this column will no longer be visible.';

  @override
  String get smartTodoNewColumn => 'New Column';

  @override
  String get smartTodoColumnNameHint => 'Column Name';

  @override
  String get smartTodoColorLabel => 'COLOR';

  @override
  String get smartTodoMarkAsDone => 'Mark as done';

  @override
  String get smartTodoColumnDoneDescription =>
      'Tasks in this column will be considered \'Done\' (strikethrough).';

  @override
  String get smartTodoListSettingsTitle => 'List Settings';

  @override
  String get smartTodoRenameList => 'Rename List';

  @override
  String get smartTodoManageTags => 'Manage Tags';

  @override
  String get smartTodoDeleteList => 'Delete List';

  @override
  String get smartTodoEditPermissionError =>
      'You can only edit tasks assigned to you';

  @override
  String errorDeletingAccount(String error) {
    return 'Error deleting account: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Recent login required. Please log out and log in again before deleting your account.';

  @override
  String actionGuide(String framework) {
    return 'Guide $framework';
  }

  @override
  String get actionExportSheets => 'Export to Google Sheets';

  @override
  String get actionAuditLog => 'Audit Log';

  @override
  String get actionInviteMember => 'Invite Member';

  @override
  String get actionSettings => 'Settings';

  @override
  String get retroSelectIcebreakerTooltip => 'Select the icebreaker activity';

  @override
  String get retroIcebreakerLabel => 'Initial Activity';

  @override
  String get retroTimePhasesOptional => 'Phase Timers (Optional)';

  @override
  String get retroTimePhasesDesc => 'Set duration in minutes for each phase:';

  @override
  String get retroIcebreakerSectionTitle => 'Icebreaker';

  @override
  String get retroBoardTitle => 'Retrospective Board';

  @override
  String get searchPlaceholder => 'Search everything...';

  @override
  String get searchResultsTitle => 'Search Results';

  @override
  String searchNoResults(Object query) {
    return 'No results found for \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Project';

  @override
  String get searchResultTypeTodo => 'ToDo List';

  @override
  String get searchResultTypeRetro => 'Retrospective';

  @override
  String get searchResultTypeEisenhower => 'Eisenhower Matrix';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Back to Dashboard';

  @override
  String get smartTodoAddItem => 'Add item';

  @override
  String get smartTodoAddImageUrl => 'Add Image (URL)';

  @override
  String get smartTodoNone => 'None';

  @override
  String get smartTodoPointsHint => 'Points (e.g. 5)';

  @override
  String get smartTodoNewItem => 'New item';

  @override
  String get smartTodoDeleteComment => 'Delete';

  @override
  String get priorityHigh => 'HIGH';

  @override
  String get priorityMedium => 'MEDIUM';

  @override
  String get priorityLow => 'LOW';

  @override
  String get exportToEstimation => 'Send to Estimation';

  @override
  String get exportToEstimationDesc =>
      'Create an estimation session with these tasks';

  @override
  String get exportToEisenhower => 'Send to Eisenhower';

  @override
  String get exportToEisenhowerDesc =>
      'Create an Eisenhower matrix with these tasks';

  @override
  String get selectTasksToExport => 'Select Tasks';

  @override
  String get selectTasksToExportDesc => 'Choose which tasks to include';

  @override
  String get noTasksSelected => 'No tasks selected';

  @override
  String get selectAtLeastOne => 'Select at least one task';

  @override
  String get createEstimationSession => 'Create Estimation Session';

  @override
  String tasksSelectedCount(int count) {
    return '$count task(s) selected';
  }

  @override
  String get exportSuccess => 'Exported successfully';

  @override
  String get exportFromEstimation => 'Export to List';

  @override
  String get exportFromEstimationDesc =>
      'Export estimated stories to a Smart Todo list';

  @override
  String get selectDestinationList => 'Select destination list';

  @override
  String get createNewList => 'Create new list';

  @override
  String get existingList => 'Existing list';

  @override
  String get listName => 'List name';

  @override
  String get listNameHint => 'Enter a name for the new list';

  @override
  String get selectList => 'Select list';

  @override
  String get selectListHint => 'Select a list';

  @override
  String get noListsAvailable =>
      'No lists available. A new one will be created.';

  @override
  String storiesSelectedCount(int count) {
    return '$count story/stories selected';
  }

  @override
  String get selectAll => 'Select all';

  @override
  String get deselectAll => 'Deselect all';

  @override
  String get importStories => 'Import Stories';

  @override
  String storiesImportedCount(int count) {
    return '$count story/stories imported';
  }

  @override
  String get noEstimatedStories => 'No stories with estimates to import';

  @override
  String get selectDestinationMatrix => 'Select Destination Matrix';

  @override
  String get existingMatrix => 'Existing Matrix';

  @override
  String get createNewMatrix => 'Create New Matrix';

  @override
  String get matrixName => 'Matrix Name';

  @override
  String get matrixNameHint => 'Enter a name for the new matrix';

  @override
  String get selectMatrix => 'Select Matrix';

  @override
  String get selectMatrixHint => 'Choose a destination matrix';

  @override
  String get noMatricesAvailable => 'No matrices available. Create a new one.';

  @override
  String activitiesCreated(int count) {
    return '$count activities created';
  }

  @override
  String get importFromEisenhower => 'Import from Eisenhower';

  @override
  String get importFromEisenhowerDesc => 'Add prioritized tasks to this list';

  @override
  String get quadrantQ1 => 'Urgent & Important';

  @override
  String get quadrantQ2 => 'Not Urgent & Important';

  @override
  String get quadrantQ3 => 'Urgent & Not Important';

  @override
  String get quadrantQ4 => 'Not Urgent & Not Important';

  @override
  String get warningQ4Tasks =>
      'Q4 tasks are typically not worth doing. Are you sure?';

  @override
  String get priorityMappingInfo =>
      'Priority mapping: Q1=High, Q2=Medium, Q3/Q4=Low';

  @override
  String get selectColumns => 'Select Columns';

  @override
  String get allTasks => 'All Tasks';

  @override
  String get filterByColumn => 'Filter by column';

  @override
  String get exportFromEisenhower => 'Send to Todo list';

  @override
  String get exportFromEisenhowerDesc =>
      'Select activities to export to Smart Todo';

  @override
  String get filterByQuadrant => 'Filter by quadrant:';

  @override
  String get allActivities => 'All';

  @override
  String activitiesSelectedCount(int count) {
    return '$count activities selected';
  }

  @override
  String get noActivitiesSelected => 'No activities in this filter';

  @override
  String get unvoted => 'UNVOTED';

  @override
  String tasksCreated(int count) {
    return '$count tasks created';
  }

  @override
  String get exportToUserStories => 'Send to Agile project';

  @override
  String get exportToUserStoriesDesc => 'Send user stories to an Agile project';

  @override
  String get selectDestinationProject => 'Select Destination Project';

  @override
  String get existingProject => 'Existing project';

  @override
  String get createNewProject => 'Create new project';

  @override
  String get projectName => 'Project Name';

  @override
  String get projectNameHint => 'Enter a name for the new project';

  @override
  String get selectProject => 'Select project';

  @override
  String get selectProjectHint => 'Choose a destination project';

  @override
  String get noProjectsAvailable => 'No projects available. Create a new one.';

  @override
  String get userStoryFieldMappingInfo =>
      'Mapping: Title → Story title, Description → Story description, Effort → Story points, Priority → Business value';

  @override
  String storiesCreated(int count) {
    return '$count stories created';
  }

  @override
  String get configureNewProject => 'Configure new project';

  @override
  String get exportToAgileSprint => 'Send to Sprint';

  @override
  String get actionSend => 'Send';

  @override
  String get exportToAgileSprintDesc =>
      'Add estimated stories to an Agile project';

  @override
  String get selectSprint => 'Select sprint';

  @override
  String get selectSprintHint => 'Choose a destination sprint';

  @override
  String get noSprintsAvailable =>
      'No sprints available. Create a sprint in planning state first.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Mapping: Title → Story title, Description → Description, Estimate → Story points';

  @override
  String get exportToSprint => 'Export to Agile Project';

  @override
  String totalStoryPoints(int count) {
    return '$count total story points';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count stories added to $sprintName';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count stories added to project $projectName';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Transform Eisenhower activities into User Stories in Agile Project';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Create an estimation session from activities';

  @override
  String get selectedActivities => 'activities selected';

  @override
  String get noActivitiesToExport => 'No activities to export';

  @override
  String get hiddenQ4Activities => 'Hidden';

  @override
  String get q4Activities => 'Q4 activities (Delete)';

  @override
  String get showQ4 => 'Show Q4';

  @override
  String get hideQ4 => 'Hide Q4';

  @override
  String get showingAllActivities => 'Showing all activities';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importance→Business Value.';

  @override
  String get estimationExportInfo =>
      'Activities will be added as stories to estimate. Q4 activities will not be transferred.';

  @override
  String get createSession => 'Create Session';

  @override
  String get estimationType => 'Estimation type';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count activities added to $sprintName';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count activities added to project $projectName';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Estimation session created with $count activities';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count activities exported to sprint $sprintName';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count activities exported to estimation session $sessionName';
  }

  @override
  String get archiveAction => 'Archive';

  @override
  String get archiveRestoreAction => 'Restore';

  @override
  String get archiveShowArchived => 'Show archived';

  @override
  String get archiveHideArchived => 'Hide archived';

  @override
  String archiveConfirmTitle(String itemType) {
    return 'Archive $itemType';
  }

  @override
  String get archiveConfirmMessage =>
      'Are you sure you want to archive this item? It can be restored later.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return 'Restore $itemType';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Do you want to restore this item from the archive?';

  @override
  String get archiveSuccessMessage => 'Item archived successfully';

  @override
  String get archiveRestoreSuccessMessage => 'Item restored successfully';

  @override
  String get archiveErrorMessage => 'Error during archiving';

  @override
  String get archiveRestoreErrorMessage => 'Error during restoration';

  @override
  String get archiveFilterLabel => 'Archive';

  @override
  String get archiveFilterActive => 'Active';

  @override
  String get archiveFilterArchived => 'Archived';

  @override
  String get archiveFilterAll => 'All';

  @override
  String get archiveBadge => 'Archived';

  @override
  String get archiveEmptyMessage => 'No archived items';

  @override
  String get completeAction => 'Complete';

  @override
  String get reopenAction => 'Reopen';

  @override
  String completeConfirmTitle(String itemType) {
    return 'Complete $itemType';
  }

  @override
  String get completeConfirmMessage =>
      'Are you sure you want to complete this item?';

  @override
  String get completeSuccessMessage => 'Item completed successfully';

  @override
  String get reopenSuccessMessage => 'Item reopened successfully';

  @override
  String get completedBadge => 'Completed';

  @override
  String get inviteNewInvite => 'NEW INVITE';

  @override
  String get inviteRole => 'Role:';

  @override
  String get inviteSendEmailNotification => 'Send email notification';

  @override
  String get inviteSendInvite => 'Send Invite';

  @override
  String get inviteLink => 'Invite link:';

  @override
  String get inviteList => 'INVITES';

  @override
  String get inviteResend => 'Resend';

  @override
  String get inviteRevokeMessage => 'The invite will no longer be valid.';

  @override
  String get inviteResent => 'Invite resent';

  @override
  String inviteSentByEmail(String email) {
    return 'Invite sent by email to $email';
  }

  @override
  String get inviteStatusPending => 'Pending';

  @override
  String get inviteStatusAccepted => 'Accepted';

  @override
  String get inviteStatusDeclined => 'Declined';

  @override
  String get inviteStatusExpired => 'Expired';

  @override
  String get inviteStatusRevoked => 'Revoked';

  @override
  String get inviteGmailAuthTitle => 'Gmail Authorization';

  @override
  String get inviteGmailAuthMessage =>
      'To send invite emails, you need to re-authenticate with Google.\n\nDo you want to proceed?';

  @override
  String get inviteGmailAuthNo => 'No, link only';

  @override
  String get inviteGmailAuthYes => 'Authorize';

  @override
  String get inviteGmailNotAvailable =>
      'Gmail authorization not available. Try logging out and back in.';

  @override
  String get inviteGmailNoPermission => 'Gmail permission not granted.';

  @override
  String get inviteEnterEmail => 'Enter an email';

  @override
  String get inviteInvalidEmail => 'Invalid email';

  @override
  String get pendingInvites => 'Pending Invites';

  @override
  String get noPendingInvites => 'No pending invites';

  @override
  String invitedBy(String name) {
    return 'Invited by $name';
  }

  @override
  String get inviteOpenInstance => 'Open';

  @override
  String get inviteAcceptFirst => 'Accept the invite to open';

  @override
  String get inviteAccept => 'Accept';

  @override
  String get inviteDecline => 'Decline';

  @override
  String get inviteAcceptedSuccess => 'Invite accepted successfully!';

  @override
  String get inviteAcceptedError => 'Failed to accept invite';

  @override
  String get inviteDeclinedSuccess => 'Invite declined';

  @override
  String get inviteDeclinedError => 'Failed to decline invite';

  @override
  String get inviteDeclineTitle => 'Decline invite?';

  @override
  String get inviteDeclineMessage =>
      'Are you sure you want to decline this invite?';

  @override
  String expiresInHours(int hours) {
    return 'Expires in ${hours}h';
  }

  @override
  String expiresInDays(int days) {
    return 'Expires in ${days}d';
  }

  @override
  String get close => 'Close';

  @override
  String get cancel => 'Cancel';

  @override
  String get raciTitle => 'RACI Matrix';

  @override
  String get raciNoActivities => 'No activities available';

  @override
  String get raciAddActivity => 'Add Activity';

  @override
  String get raciAddColumn => 'Add Column';

  @override
  String get raciActivities => 'ACTIVITIES';

  @override
  String get raciAssignRole => 'Assign role';

  @override
  String get raciNone => 'None';

  @override
  String get raciSaving => 'Saving...';

  @override
  String get raciSaveChanges => 'Save Changes';

  @override
  String get raciSavedSuccessfully => 'Changes saved successfully';

  @override
  String get raciErrorSaving => 'Error saving';

  @override
  String get raciMissingAccountable => 'Missing Accountable (A)';

  @override
  String get raciOnlyOneAccountable => 'Only one Accountable per activity';

  @override
  String get raciDuplicateRoles => 'Duplicate roles';

  @override
  String get raciNoResponsible => 'No Responsible (R) assigned';

  @override
  String get raciTooManyInformed => 'Too many Informed (I): consider reducing';

  @override
  String get raciNewColumn => 'New Column';

  @override
  String get raciRemoveColumn => 'Remove column';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Remove column \"$name\"? All role assignments for this column will be deleted.';
  }

  @override
  String get votingDialogTitle => 'Vote';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Vote of $participant';
  }

  @override
  String get votingDialogUrgency => 'URGENCY';

  @override
  String get votingDialogImportance => 'IMPORTANCE';

  @override
  String get votingDialogNotUrgent => 'Not urgent';

  @override
  String get votingDialogVeryUrgent => 'Very urgent';

  @override
  String get votingDialogNotImportant => 'Not important';

  @override
  String get votingDialogVeryImportant => 'Very important';

  @override
  String get votingDialogConfirmVote => 'Confirm Vote';

  @override
  String get votingDialogQuadrant => 'Quadrant:';

  @override
  String get voteCollectionTitle => 'Collect Votes';

  @override
  String get voteCollectionParticipants => 'participants';

  @override
  String get voteCollectionResult => 'Result:';

  @override
  String get voteCollectionAverage => 'Average:';

  @override
  String get voteCollectionSaveVotes => 'Save Votes';

  @override
  String get scatterChartTitle => 'Activity Distribution';

  @override
  String get scatterChartNoActivities => 'No voted activities';

  @override
  String get scatterChartVoteToShow =>
      'Vote activities to view them in the chart';

  @override
  String get scatterChartUrgencyLabel => 'Urgency:';

  @override
  String get scatterChartImportanceLabel => 'Importance:';

  @override
  String get scatterChartAxisUrgency => 'URGENCY';

  @override
  String get scatterChartAxisImportance => 'IMPORTANCE';

  @override
  String get scatterChartQ1Label => 'Q1 - DO';

  @override
  String get scatterChartQ2Label => 'Q2 - SCHEDULE';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGATE';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINATE';

  @override
  String get scatterChartCardTitle => 'Distribution Chart';

  @override
  String get votingStatusYou => 'You';

  @override
  String get votingStatusReset => 'Reset';

  @override
  String get estimationDecimalHintPlaceholder => 'E.g. 2.5';

  @override
  String get estimationDecimalSuffixDays => 'days';

  @override
  String get estimationDecimalVote => 'Vote';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Vote: $value days';
  }

  @override
  String get estimationDecimalQuickSelect => 'Quick select:';

  @override
  String get estimationDecimalEnterValue => 'Enter a value';

  @override
  String get estimationDecimalInvalidValue => 'Invalid value';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Three-Point Estimation (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Optimistic (O)';

  @override
  String get estimationThreePointRealistic => 'Realistic (M)';

  @override
  String get estimationThreePointPessimistic => 'Pessimistic (P)';

  @override
  String get estimationThreePointBestCase => 'Best case';

  @override
  String get estimationThreePointMostLikely => 'Most likely';

  @override
  String get estimationThreePointWorstCase => 'Worst case';

  @override
  String get estimationThreePointAllFieldsRequired => 'All fields are required';

  @override
  String get estimationThreePointInvalidValues => 'Invalid values';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Optimistic must be <= Realistic';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realistic must be <= Pessimistic';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Optimistic must be <= Pessimistic';

  @override
  String get estimationThreePointGuide => 'Guide:';

  @override
  String get estimationThreePointGuideO =>
      'O: Best case estimate (everything goes well)';

  @override
  String get estimationThreePointGuideM =>
      'M: Most likely estimate (normal conditions)';

  @override
  String get estimationThreePointGuideP =>
      'P: Worst case estimate (unexpected issues)';

  @override
  String get estimationThreePointStdDev => 'Std Dev';

  @override
  String get estimationThreePointDaysSuffix => 'd';

  @override
  String get storyFormNewStory => 'New Story';

  @override
  String get storyFormEnterTitle => 'Enter a title';

  @override
  String get sessionSearchHint => 'Search sessions...';

  @override
  String get sessionSearchFilters => 'Filters';

  @override
  String get sessionSearchFiltersTooltip => 'Filters';

  @override
  String get sessionSearchStatusLabel => 'Status: ';

  @override
  String get sessionSearchStatusAll => 'All';

  @override
  String get sessionSearchStatusDraft => 'Draft';

  @override
  String get sessionSearchStatusActive => 'Active';

  @override
  String get sessionSearchStatusCompleted => 'Completed';

  @override
  String get sessionSearchModeLabel => 'Mode: ';

  @override
  String get sessionSearchModeAll => 'All';

  @override
  String get sessionSearchRemoveFilters => 'Remove filters';

  @override
  String get sessionSearchActiveFilters => 'Active filters:';

  @override
  String get sessionSearchRemoveAllFilters => 'Remove all';

  @override
  String participantsTitle(int count) {
    return 'Participants ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Facilitator';

  @override
  String get participantRoleVoters => 'Voters';

  @override
  String get participantRoleObservers => 'Observers';

  @override
  String get votingBoardVotesRevealed => 'Votes Revealed';

  @override
  String get votingBoardVotingInProgress => 'Voting in Progress';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total votes';
  }

  @override
  String get estimationSelectYourEstimate => 'Select your estimate';

  @override
  String estimationVoteSelected(String value) {
    return 'Vote selected: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Voting mode with point allocation.\nComing soon...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Affinity estimation with grouping.\nComing soon...';

  @override
  String get estimationModeTitle => 'Estimation Mode';

  @override
  String get statisticsTitle => 'Voting Statistics';

  @override
  String get statisticsAverage => 'Average';

  @override
  String get statisticsMedian => 'Median';

  @override
  String get statisticsMode => 'Mode';

  @override
  String get statisticsVoters => 'Voters';

  @override
  String get statisticsPertStats => 'PERT Statistics';

  @override
  String get statisticsPertAvg => 'PERT Avg';

  @override
  String get statisticsStdDev => 'Std Dev';

  @override
  String get statisticsVariance => 'Variance';

  @override
  String get statisticsRange => 'Range:';

  @override
  String get statisticsConsensusReached => 'Consensus reached!';

  @override
  String get retroGuideTooltip => 'Guide to Retrospectives';

  @override
  String get retroSearchPlaceholder => 'Search retrospective...';

  @override
  String get retroNoSearchResults => 'No results for the search';

  @override
  String get retroNewRetro => 'New Retrospective';

  @override
  String get retroNoProjectsFound => 'No projects found.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Are you sure you want to permanently delete the retrospective \"$retroName\"?\n\nThis action is irreversible and will delete all associated data (cards, votes, action items).';
  }

  @override
  String get retroDeletePermanently => 'Delete permanently';

  @override
  String get retroDeletedSuccess => 'Retrospective deleted successfully';

  @override
  String errorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get loaderProjectIdMissing => 'Project ID missing';

  @override
  String get loaderProjectNotFound => 'Project not found';

  @override
  String get loaderLoadError => 'Loading error';

  @override
  String get loaderError => 'Error';

  @override
  String get loaderUnknownError => 'Unknown error';

  @override
  String get actionGoBack => 'Go Back';

  @override
  String get authRequired => 'Authentication required';

  @override
  String get retroIdMissing => 'Retrospective ID missing';

  @override
  String get pokerInviteStatusAccepted => 'was already accepted';

  @override
  String get pokerInviteStatusDeclined => 'was declined';

  @override
  String get pokerInviteStatusExpired => 'has expired';

  @override
  String get pokerInviteStatusRevoked => 'was revoked';

  @override
  String get pokerInviteStatusPending => 'is pending';

  @override
  String get pokerInviteYouAreInvited => 'You Are Invited!';

  @override
  String pokerInviteInvitedBy(String name) {
    return '$name invited you to participate';
  }

  @override
  String get pokerInviteSessionLabel => 'Session';

  @override
  String get pokerInviteProjectLabel => 'Project';

  @override
  String get pokerInviteRoleLabel => 'Assigned Role';

  @override
  String get pokerInviteExpiryLabel => 'Invite Expiry';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'In $days days';
  }

  @override
  String get pokerInviteDecline => 'Decline';

  @override
  String get pokerInviteAccept => 'Accept Invite';

  @override
  String loadingMatrixError(String error) {
    return 'Error loading matrix: $error';
  }

  @override
  String loadingDataError(String error) {
    return 'Error loading data: $error';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Error loading activities: $error';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days days/sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '${hours}h/day';
  }

  @override
  String get smartTodoImageFromClipboardFound => 'Image found in clipboard';

  @override
  String get smartTodoAddImageFromClipboard => 'Add image from clipboard';

  @override
  String get smartTodoInviteCreatedAndSent => 'Invite created and sent';

  @override
  String get retroColumnDropDesc =>
      'What brings no value and should be eliminated?';

  @override
  String get retroColumnAddDesc => 'What new practices should we introduce?';

  @override
  String get retroColumnKeepDesc => 'What is working well and should continue?';

  @override
  String get retroColumnImproveDesc => 'What can we do better?';

  @override
  String get retroColumnStart => 'Start';

  @override
  String get retroColumnStartDesc =>
      'What new activities or processes should we start to improve?';

  @override
  String get retroColumnStop => 'Stop';

  @override
  String get retroColumnStopDesc =>
      'What isn\'t bringing value and should we stop doing?';

  @override
  String get retroColumnContinue => 'Continue';

  @override
  String get retroColumnContinueDesc =>
      'What is working well and we should keep doing?';

  @override
  String get retroColumnLongedFor => 'Longed For';

  @override
  String get retroColumnLikedDesc => 'What did you like about this sprint?';

  @override
  String get retroColumnLearnedDesc => 'What did you learn?';

  @override
  String get retroColumnLackedDesc => 'What was missing in this sprint?';

  @override
  String get retroColumnLongedForDesc =>
      'What would you like to have in the near future?';

  @override
  String get retroColumnMadDesc => 'What made you angry or frustrated?';

  @override
  String get retroColumnSadDesc => 'What disappointed you or made you sad?';

  @override
  String get retroColumnGladDesc => 'What made you happy or satisfied?';

  @override
  String get retroColumnWindDesc =>
      'What pushed us forward? Strengths and support.';

  @override
  String get retroColumnAnchorDesc =>
      'What slowed us down? Obstacles and blockers.';

  @override
  String get retroColumnRockDesc =>
      'What future risks do we see on the horizon?';

  @override
  String get retroColumnGoalDesc => 'What is our ideal destination?';

  @override
  String get retroColumnMoreDesc => 'What should we do more of?';

  @override
  String get retroColumnLessDesc => 'What should we do less of?';

  @override
  String get actionTypeMaintain => 'Maintain';

  @override
  String get actionTypeStop => 'Stop';

  @override
  String get actionTypeBegin => 'Begin';

  @override
  String get actionTypeIncrease => 'Increase';

  @override
  String get actionTypeDecrease => 'Decrease';

  @override
  String get actionTypePrevent => 'Prevent';

  @override
  String get actionTypeCelebrate => 'Celebrate';

  @override
  String get actionTypeReplicate => 'Replicate';

  @override
  String get actionTypeShare => 'Share';

  @override
  String get actionTypeProvide => 'Provide';

  @override
  String get actionTypePlan => 'Plan';

  @override
  String get actionTypeLeverage => 'Leverage';

  @override
  String get actionTypeRemove => 'Remove';

  @override
  String get actionTypeMitigate => 'Mitigate';

  @override
  String get actionTypeAlign => 'Align';

  @override
  String get actionTypeEliminate => 'Eliminate';

  @override
  String get actionTypeImplement => 'Implement';

  @override
  String get actionTypeEnhance => 'Enhance';

  @override
  String get coachTipSSCWriting =>
      'Focus on concrete, observable behaviors. Each item should be something the team can act on directly. Avoid vague statements.';

  @override
  String get coachTipSSCVoting =>
      'Vote based on impact and feasibility. High-voted items will become your sprint commitments.';

  @override
  String get coachTipSSCDiscuss =>
      'For each top-voted item, define WHO will do WHAT by WHEN. Turn insights into specific next actions.';

  @override
  String get coachTipMSGWriting =>
      'Create a safe space for emotions. All feelings are valid. Focus on the situation, not the person. Use \'I feel...\' statements.';

  @override
  String get coachTipMSGVoting =>
      'Vote to identify shared experiences. Patterns in emotions reveal team dynamics that need attention.';

  @override
  String get coachTipMSGDiscuss =>
      'Acknowledge emotions before problem-solving. Ask \'What would help?\' rather than jumping to solutions. Listen actively.';

  @override
  String get coachTip4LsWriting =>
      'Reflect on learnings, not just events. Think about what insights you\'ll carry forward. Each L represents a different perspective.';

  @override
  String get coachTip4LsVoting =>
      'Prioritize learnings that could improve future sprints. Focus on transferable knowledge.';

  @override
  String get coachTip4LsDiscuss =>
      'Turn learnings into documentation or process changes. Ask \'How can we share this knowledge with others?\'';

  @override
  String get coachTipSailboatWriting =>
      'Use the metaphor: Wind pushes us forward (enablers), Anchors slow us (blockers), Rocks are future risks, Island is our goal.';

  @override
  String get coachTipSailboatVoting =>
      'Prioritize based on risk impact and enabler potential. Balance addressing blockers with leveraging strengths.';

  @override
  String get coachTipSailboatDiscuss =>
      'Create a risk register for rocks. Define mitigation strategies. Leverage winds to overcome anchors.';

  @override
  String get coachTipDAKIWriting =>
      'Be decisive: Drop what wastes time, Add what\'s missing, Keep what works, Improve what could be better.';

  @override
  String get coachTipDAKIVoting =>
      'Vote pragmatically. Focus on changes that will have immediate, measurable impact.';

  @override
  String get coachTipDAKIDiscuss =>
      'Make clear decisions as a team. For each item, commit to a specific action or explicitly decide not to act.';

  @override
  String get coachTipStarfishWriting =>
      'Use gradations: Keep (maintain), More (increase), Less (decrease), Stop (eliminate), Start (begin). This allows nuanced feedback.';

  @override
  String get coachTipStarfishVoting =>
      'Consider the effort vs impact. \'More\' and \'Less\' items may be easier to implement than \'Start\' and \'Stop\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Define specific metrics for \'more\' and \'less\'. How much more? How will we measure? Set clear calibration targets.';

  @override
  String get discussPromptSSCStart =>
      'What new practice should we begin? Think about gaps in our process that a new habit could fill.';

  @override
  String get discussPromptSSCStop =>
      'What wastes our time or energy? Consider activities that don\'t deliver value proportional to their cost.';

  @override
  String get discussPromptSSCContinue =>
      'What\'s working well? Recognize and reinforce effective practices.';

  @override
  String get discussPromptMSGMad =>
      'What frustrated you? Remember, we\'re discussing situations, not blaming individuals.';

  @override
  String get discussPromptMSGSad =>
      'What disappointed you? What expectations weren\'t met?';

  @override
  String get discussPromptMSGGlad =>
      'What made you happy? What moments brought you satisfaction this sprint?';

  @override
  String get discussPrompt4LsLiked =>
      'What did you enjoy? What made work pleasant?';

  @override
  String get discussPrompt4LsLearned =>
      'What new skill, insight, or knowledge did you gain?';

  @override
  String get discussPrompt4LsLacked =>
      'What was missing? What resources, support, or clarity would have helped?';

  @override
  String get discussPrompt4LsLonged =>
      'What do you wish for? What would make future sprints better?';

  @override
  String get discussPromptSailboatWind =>
      'What pushed us forward? What are our strengths and external support?';

  @override
  String get discussPromptSailboatAnchor =>
      'What slowed us down? What internal or external obstacles held us back?';

  @override
  String get discussPromptSailboatRock =>
      'What risks do we see ahead? What could derail us if not addressed?';

  @override
  String get discussPromptSailboatGoal =>
      'What is our destination? Are we aligned on where we\'re heading?';

  @override
  String get discussPromptDAKIDrop =>
      'What should we eliminate? What brings no value?';

  @override
  String get discussPromptDAKIAdd =>
      'What should we introduce? What\'s missing from our toolkit?';

  @override
  String get discussPromptDAKIKeep =>
      'What must we preserve? What\'s essential to our success?';

  @override
  String get discussPromptDAKIImprove =>
      'What could be better? Where can we level up?';

  @override
  String get discussPromptStarfishKeep =>
      'What should we maintain exactly as is?';

  @override
  String get discussPromptStarfishMore =>
      'What should we increase? Do more of?';

  @override
  String get discussPromptStarfishLess => 'What should we reduce? Do less of?';

  @override
  String get discussPromptStarfishStop =>
      'What should we completely eliminate?';

  @override
  String get discussPromptStarfishStart => 'What new thing should we begin?';

  @override
  String get discussPromptGeneric =>
      'What insights emerged from this column? What patterns do you see?';

  @override
  String get smartPromptSSCStartQuestion =>
      'What specific new practice will you begin, and how will you measure its adoption?';

  @override
  String get smartPromptSSCStartExample =>
      'e.g., \'Start daily 15-min standup at 9:30 AM, track attendance for 2 weeks\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'We will start [specific practice] by [date], measured by [metric]';

  @override
  String get smartPromptSSCStopQuestion =>
      'What will you stop doing, and what will you do instead?';

  @override
  String get smartPromptSSCStopExample =>
      'e.g., \'Stop sending status updates via email, use Slack #updates channel instead\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'We will stop [practice] and instead [alternative]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'What practice will you continue, and how will you ensure it doesn\'t fade?';

  @override
  String get smartPromptSSCContinueExample =>
      'e.g., \'Continue code reviews within 4 hours, add to Definition of Done\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'We will continue [practice], reinforced by [mechanism]';

  @override
  String get smartPromptMSGMadQuestion =>
      'What action would address this frustration and who will lead it?';

  @override
  String get smartPromptMSGMadExample =>
      'e.g., \'Schedule meeting with PM to clarify requirements process - Maria by Friday\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Action to address frustration], owner: [name], by: [date]';

  @override
  String get smartPromptMSGSadQuestion =>
      'What change would prevent this disappointment from recurring?';

  @override
  String get smartPromptMSGSadExample =>
      'e.g., \'Create communication checklist for stakeholder updates - review weekly\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Preventive action], tracked via [method]';

  @override
  String get smartPromptMSGGladQuestion =>
      'How can we replicate or amplify what made us glad?';

  @override
  String get smartPromptMSGGladExample =>
      'e.g., \'Document pairing session format and share with other teams by EOW\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Action to replicate/amplify], share with [audience]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'How can we ensure this positive experience continues?';

  @override
  String get smartPrompt4LsLikedExample =>
      'e.g., \'Make mob programming session a weekly recurring event on calendar\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Action to preserve positive experience]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'How will you document and share this learning?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'e.g., \'Write wiki article on new testing approach, present in tech talk next month\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Document in [location], share via [method] by [date]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'What specific resources or support will you request and from whom?';

  @override
  String get smartPrompt4LsLackedExample =>
      'e.g., \'Request CI/CD training budget from manager - submit by next planning\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      'Request [resource] from [person/team], deadline: [date]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'What concrete first step will move you toward this wish?';

  @override
  String get smartPrompt4LsLongedExample =>
      'e.g., \'Draft proposal for 20% time for side projects - share with team lead Monday\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'First step toward [wish]: [action] by [date]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'How will you leverage this enabler to accelerate progress?';

  @override
  String get smartPromptSailboatWindExample =>
      'e.g., \'Use strong QA expertise to mentor juniors - schedule first session this week\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      'Leverage [enabler] by [specific action]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'What specific action will remove or reduce this blocker?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'e.g., \'Escalate infrastructure issue to CTO - prepare brief by Wednesday\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      'Remove [blocker] by [action], escalate to [person] if needed';

  @override
  String get smartPromptSailboatRockQuestion =>
      'What mitigation strategy will you implement for this risk?';

  @override
  String get smartPromptSailboatRockExample =>
      'e.g., \'Add fallback plan for vendor dependency - document alternatives by sprint end\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      'Mitigate [risk] by [strategy], trigger: [condition]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'What milestone will confirm progress toward this goal?';

  @override
  String get smartPromptSailboatGoalExample =>
      'e.g., \'Demo MVP to stakeholders by Feb 15, gather feedback via survey\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Milestone toward [goal]: [deliverable] by [date]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'What will you eliminate and how will you ensure it doesn\'t return?';

  @override
  String get smartPromptDAKIDropExample =>
      'e.g., \'Remove manual deployment steps - automate by end of sprint\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      'Eliminate [practice], prevent return by [mechanism]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'What new practice will you introduce and how will you validate it works?';

  @override
  String get smartPromptDAKIAddExample =>
      'e.g., \'Add feature flag system - trial on 2 features, review results in 2 weeks\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      'Add [practice], validate success via [metric]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'How will you protect this practice from being deprioritized?';

  @override
  String get smartPromptDAKIKeepExample =>
      'e.g., \'Keep code review standards - add to team charter, audit monthly\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      'Protect [practice] by [mechanism]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'What specific enhancement will you make and how will you measure improvement?';

  @override
  String get smartPromptDAKIImproveExample =>
      'e.g., \'Improve test coverage from 60% to 80% - focus on payment module first\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      'Improve [practice] from [current] to [target] by [date]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'What practice will you maintain and who owns ensuring consistency?';

  @override
  String get smartPromptStarfishKeepExample =>
      'e.g., \'Keep Friday demos - Tom ensures room booked, agenda shared by Thursday\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      'Keep [practice], owner: [name]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'What will you increase and by how much?';

  @override
  String get smartPromptStarfishMoreExample =>
      'e.g., \'Increase pair programming from 2h to 6h per week per developer\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      'Increase [practice] from [current level] to [target level]';

  @override
  String get smartPromptStarfishLessQuestion =>
      'What will you reduce and by how much?';

  @override
  String get smartPromptStarfishLessExample =>
      'e.g., \'Reduce meetings from 10h to 6h per week - cancel recurring review\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      'Reduce [practice] from [current level] to [target level]';

  @override
  String get smartPromptStarfishStopQuestion =>
      'What will you completely stop and what replaces it (if anything)?';

  @override
  String get smartPromptStarfishStopExample =>
      'e.g., \'Stop detailed time tracking on tasks - trust-based estimates instead\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      'Stop [practice], replace with [alternative] or nothing';

  @override
  String get smartPromptStarfishStartQuestion =>
      'What new practice will you start and when is the first occurrence?';

  @override
  String get smartPromptStarfishStartExample =>
      'e.g., \'Start tech debt Tuesday - first session next week, 2h protected time\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      'Start [practice], first occurrence: [date/time]';

  @override
  String get smartPromptGenericQuestion =>
      'What specific action will address this item?';

  @override
  String get smartPromptGenericExample =>
      'e.g., \'Define specific action with owner, deadline, and success criteria\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Action], owner: [name], by: [date]';

  @override
  String get methodologyFocusAction =>
      'Action-oriented: focuses on concrete behavioral changes';

  @override
  String get methodologyFocusEmotion =>
      'Emotion-focused: explores team feelings to build psychological safety';

  @override
  String get methodologyFocusLearning =>
      'Learning-reflective: emphasizes knowledge capture and sharing';

  @override
  String get methodologyFocusRisk =>
      'Risk & Goal: balances enablers, blockers, risks, and objectives';

  @override
  String get methodologyFocusCalibration =>
      'Calibration: uses gradations (more/less) for nuanced adjustment';

  @override
  String get methodologyFocusDecision =>
      'Decisional: drives clear team decisions on practices';

  @override
  String get exportSheetOverview => 'Overview';

  @override
  String get exportSheetActionItems => 'Action Items';

  @override
  String get exportSheetBoardItems => 'Board Items';

  @override
  String get exportSheetTeamHealth => 'Team Health';

  @override
  String get exportSheetLessonsLearned => 'Lessons Learned';

  @override
  String get exportSheetRiskRegister => 'Risk Register';

  @override
  String get exportSheetCalibrationMatrix => 'Calibration Matrix';

  @override
  String get exportSheetDecisionLog => 'Decision Log';

  @override
  String get exportHeaderRetrospectiveReport => 'RETROSPECTIVE REPORT';

  @override
  String get exportHeaderTitle => 'Title:';

  @override
  String get exportHeaderDate => 'Date:';

  @override
  String get exportHeaderTemplate => 'Template:';

  @override
  String get exportHeaderMethodology => 'Methodology Focus:';

  @override
  String get exportHeaderSentiments => 'Sentiments (Avg):';

  @override
  String get exportHeaderParticipants => 'PARTICIPANTS';

  @override
  String get exportHeaderSummary => 'SUMMARY';

  @override
  String get exportHeaderTotalItems => 'Total Items:';

  @override
  String get exportHeaderActionItems => 'Action Items:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Suggested Follow-up:';

  @override
  String get exportTeamHealthTitle => 'TEAM HEALTH ANALYSIS';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Emotional Distribution';

  @override
  String get exportTeamHealthMadCount => 'Mad items:';

  @override
  String get exportTeamHealthSadCount => 'Sad items:';

  @override
  String get exportTeamHealthGladCount => 'Glad items:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRATIONS (Mad)';

  @override
  String get exportTeamHealthSadItems => 'DISAPPOINTMENTS (Sad)';

  @override
  String get exportTeamHealthGladItems => 'CELEBRATIONS (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Team Health Recommendation:';

  @override
  String get exportTeamHealthHighFrustration =>
      'High frustration level detected. Consider facilitating a focused problem-solving session.';

  @override
  String get exportTeamHealthBalanced =>
      'Balanced emotional state. Team shows healthy reflection capabilities.';

  @override
  String get exportTeamHealthPositive =>
      'Positive team morale. Leverage this energy for challenging improvements.';

  @override
  String get exportLessonsLearnedTitle => 'LESSONS LEARNED REGISTER';

  @override
  String get exportLessonsLearnedWhatWorked => 'WHAT WORKED (Liked)';

  @override
  String get exportLessonsLearnedNewSkills => 'NEW SKILLS & INSIGHTS (Learned)';

  @override
  String get exportLessonsLearnedGaps => 'GAPS & MISSING ELEMENTS (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'FUTURE ASPIRATIONS (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Knowledge Sharing Actions';

  @override
  String get exportLessonsLearnedDocumentationNeeded => 'Documentation Needed:';

  @override
  String get exportLessonsLearnedTrainingNeeded => 'Training/Sharing Needed:';

  @override
  String get exportRiskRegisterTitle => 'RISK & ENABLER REGISTER';

  @override
  String get exportRiskRegisterEnablers => 'ENABLERS (Wind)';

  @override
  String get exportRiskRegisterBlockers => 'BLOCKERS (Anchor)';

  @override
  String get exportRiskRegisterRisks => 'RISKS (Rocks)';

  @override
  String get exportRiskRegisterGoals => 'GOALS (Island)';

  @override
  String get exportRiskRegisterRiskItem => 'Risk';

  @override
  String get exportRiskRegisterImpact => 'Potential Impact';

  @override
  String get exportRiskRegisterMitigation => 'Mitigation Action';

  @override
  String get exportRiskRegisterStatus => 'Status';

  @override
  String get exportRiskRegisterGoalAlignment => 'Goal Alignment Check:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Review if current actions align with stated goals.';

  @override
  String get exportCalibrationTitle => 'CALIBRATION MATRIX';

  @override
  String get exportCalibrationKeepDoing => 'KEEP DOING';

  @override
  String get exportCalibrationDoMore => 'DO MORE';

  @override
  String get exportCalibrationDoLess => 'DO LESS';

  @override
  String get exportCalibrationStopDoing => 'STOP DOING';

  @override
  String get exportCalibrationStartDoing => 'START DOING';

  @override
  String get exportCalibrationPractice => 'Practice';

  @override
  String get exportCalibrationCurrentState => 'Current State';

  @override
  String get exportCalibrationTargetState => 'Target State';

  @override
  String get exportCalibrationAdjustment => 'Adjustment';

  @override
  String get exportCalibrationNote =>
      'Calibration focuses on fine-tuning existing practices rather than wholesale changes.';

  @override
  String get exportDecisionLogTitle => 'DECISION LOG';

  @override
  String get exportDecisionLogDrop => 'DECISIONS TO DROP';

  @override
  String get exportDecisionLogAdd => 'DECISIONS TO ADD';

  @override
  String get exportDecisionLogKeep => 'DECISIONS TO KEEP';

  @override
  String get exportDecisionLogImprove => 'DECISIONS TO IMPROVE';

  @override
  String get exportDecisionLogDecision => 'Decision';

  @override
  String get exportDecisionLogRationale => 'Rationale';

  @override
  String get exportDecisionLogOwner => 'Owner';

  @override
  String get exportDecisionLogDeadline => 'Deadline';

  @override
  String get exportDecisionLogPrioritizationNote =>
      'Prioritization Recommendation:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Focus on DROP decisions first to free capacity, then ADD new practices.';

  @override
  String get exportNoItems => 'No items recorded';

  @override
  String get exportNoActionItems => 'No action items';

  @override
  String get exportNotApplicable => 'N/A';

  @override
  String get facilitatorGuideTitle => 'Action Collection Guide';

  @override
  String get facilitatorGuideCoverage => 'Coverage';

  @override
  String get facilitatorGuideComplete => 'Complete';

  @override
  String get facilitatorGuideIncomplete => 'Incomplete';

  @override
  String get facilitatorGuideSuggestedOrder => 'Suggested Order:';

  @override
  String get facilitatorGuideMissingRequired => 'Missing required actions';

  @override
  String get facilitatorGuideColumnHasAction => 'Has action';

  @override
  String get facilitatorGuideColumnNoAction => 'No action yet';

  @override
  String get facilitatorGuideRequired => 'Required';

  @override
  String get facilitatorGuideOptional => 'Optional';

  @override
  String get agileEdit => 'Edit';

  @override
  String get agileSettings => 'Settings';

  @override
  String get agileDelete => 'Delete';

  @override
  String get agileDeleteProjectTitle => 'Delete Project';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Are you sure you want to delete \"$projectName\"?';
  }

  @override
  String get agileDeleteProjectWarning =>
      'This action will permanently delete:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count user stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count sprints';
  }

  @override
  String get agileDeleteProjectData => 'All project data';

  @override
  String get agileProjectSettingsTitle => 'Project Settings';

  @override
  String get agileKeyRoles => 'Key Roles';

  @override
  String get agileKeyRolesSubtitle => 'Assign main roles for the Scrum Team';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Manages backlog and defines product priorities';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Facilitates Scrum process and removes obstacles';

  @override
  String get agileRoleDevTeam => 'Development Team';

  @override
  String get agileNoDevTeamMembers => 'No members in team. Click + to add.';

  @override
  String get agileRolesInfo =>
      'Roles will be shown with dedicated icons in project list. You can add more participants from Project Team.';

  @override
  String agileAssignedTo(String name) {
    return 'Assigned to $name';
  }

  @override
  String get agileUnassigned => 'Unassigned';

  @override
  String get agileAssignableLater => 'Assignable after creation';

  @override
  String get agileAddToTeam => 'Add to Team';

  @override
  String get agileAllMembersAssigned =>
      'All participants are already assigned to a role.';

  @override
  String get agileClose => 'Close';

  @override
  String get agileProjectNameLabel => 'Project Name *';

  @override
  String get agileProjectNameHint => 'E.g: Fashion PMO v2';

  @override
  String get agileEnterProjectName => 'Enter project name';

  @override
  String get agileProjectDescLabel => 'Description';

  @override
  String get agileProjectDescHint => 'Optional project description';

  @override
  String get agileFrameworkLabel => 'Agile Framework';

  @override
  String get agileDiscoverDifferences => 'Discover differences';

  @override
  String get agileSprintConfig => 'Sprint Configuration';

  @override
  String get agileSprintDuration => 'Sprint Duration (days)';

  @override
  String get agileHoursPerDay => 'Hours/Day';

  @override
  String get agileCreateProjectTitle => 'New Agile Project';

  @override
  String get agileEditProjectTitle => 'Edit Project';

  @override
  String get agileSelectParticipant => 'Select participant';

  @override
  String get agileAssignRolesHint =>
      'Assign key team roles.\nYou can also modify them in project settings.';

  @override
  String get agileArchiveAction => 'Archive';

  @override
  String get agileRestoreAction => 'Restore';

  @override
  String get agileSetupTitle => 'Project Setup';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed of $total steps completed';
  }

  @override
  String get agileSetupCompleteTitle => 'Setup Complete!';

  @override
  String get agileSetupCompleteMessage => 'Your project is ready to start.';

  @override
  String get agileChecklistAddMembers => 'Add team members';

  @override
  String get agileChecklistAddMembersDesc =>
      'Invite team members to collaborate';

  @override
  String get agileChecklistInvite => 'Invite';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Create first $itemType';
  }

  @override
  String get agileChecklistAddItems => 'Add at least 3 items to backlog';

  @override
  String get agileChecklistAdd => 'Add';

  @override
  String get agileChecklistWipLimits => 'Configure WIP limits';

  @override
  String get agileChecklistWipLimitsDesc => 'Set limits for each Kanban column';

  @override
  String get agileChecklistConfigure => 'Configure';

  @override
  String agileChecklistEstimate(String itemType) {
    return 'Estimate $itemType';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Assign Story Points for better planning';

  @override
  String get agileChecklistCreateSprint => 'Create first Sprint';

  @override
  String get agileChecklistSprintDesc => 'Select stories and start working';

  @override
  String get agileChecklistCreateSprintAction => 'Create Sprint';

  @override
  String get agileChecklistStartWork => 'Start working';

  @override
  String get agileChecklistStartWorkDesc => 'Move an item to in progress';

  @override
  String get agileTipStartSprintTitle => 'Ready for a Sprint?';

  @override
  String get agileTipStartSprintMessage =>
      'You have enough stories in backlog. Consider planning the first Sprint.';

  @override
  String get agileTipWipTitle => 'Configure WIP Limits';

  @override
  String get agileTipWipMessage =>
      'WIP limits are key in Kanban. Limit work in progress to improve flow.';

  @override
  String get agileTipHybridTitle => 'Configure your Scrumban';

  @override
  String get agileTipHybridMessage =>
      'You can use Sprints for cadence or WIP limits for continuous flow. Experiment!';

  @override
  String get agileTipDiscover => 'Discover';

  @override
  String get agileTipClose => 'Close';

  @override
  String get agileNextStepInviteTitle => 'Invite Team';

  @override
  String get agileNextStepInviteDesc =>
      'Add members to collaborate on the project.';

  @override
  String get agileNextStepBacklogTitle => 'Create Backlog';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Add the first $itemType to backlog.';
  }

  @override
  String get agileNextStepSprintTitle => 'Plan a Sprint';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'You have $count items ready. Create the first Sprint!';
  }

  @override
  String get agileNextStepWipTitle => 'Configure WIP Limits';

  @override
  String get agileNextStepWipDesc => 'Limit work in progress to improve flow.';

  @override
  String get agileNextStepWorkTitle => 'Start Working';

  @override
  String get agileNextStepWorkDesc =>
      'Move an item to \"In Progress\" to start.';

  @override
  String get agileNextStepGoToKanban => 'Go to Kanban';

  @override
  String get agileActionNewStory => 'New Story';

  @override
  String get agileBacklogTitle => 'Product Backlog';

  @override
  String get agileBacklogArchiveTitle => 'Completed Archive';

  @override
  String get agileBacklogToggleActive => 'Show active Backlog';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Show Archive ($count completed)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Archive ($count)';
  }

  @override
  String get agileBacklogSearchHint => 'Search by title, description or ID...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count stories';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points pts';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count estimated';
  }

  @override
  String get agileFiltersStatus => 'Status:';

  @override
  String get agileFiltersPriority => 'Priority:';

  @override
  String get agileFiltersTags => 'Tags:';

  @override
  String get agileFiltersAll => 'All';

  @override
  String get agileFiltersClear => 'Clear filters';

  @override
  String get agileEmptyBacklogMatch => 'No stories found';

  @override
  String get agileEmptyBacklog => 'Empty Backlog';

  @override
  String get agileEmptyBacklogHint => 'Add the first User Story';

  @override
  String get agileEstTitle => 'Estimate Story';

  @override
  String get agileEstMethod => 'Estimation Method';

  @override
  String get agileEstSelectValue => 'Select a value';

  @override
  String get agileEstSubmit => 'Confirm Estimate';

  @override
  String get agileEstCancel => 'Cancel';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc => 'Select story complexity in story points';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc => 'Select relative size of the story';

  @override
  String get agileEstThreePointTitle => 'Three-Point Estimation (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Enter three values to calculate PERT estimate';

  @override
  String get agileEstBucketTitle => 'Bucket System';

  @override
  String get agileEstBucketDesc => 'Place the story in the appropriate bucket';

  @override
  String get agileEstBucketHint =>
      'Larger buckets indicate more complex stories';

  @override
  String get agileEstReference => 'Reference:';

  @override
  String get agileEstRefXS => 'XS = Few hours';

  @override
  String get agileEstRefS => 'S = ~1 day';

  @override
  String get agileEstRefM => 'M = ~2-3 days';

  @override
  String get agileEstRefL => 'L = ~1 week';

  @override
  String get agileEstRefXL => 'XL = ~2 weeks';

  @override
  String get agileEstRefXXL => 'XXL = Too big, split it';

  @override
  String get agileEstOptimistic => 'Optimistic (O)';

  @override
  String get agileEstOptimisticHint => 'Best case';

  @override
  String get agileEstMostLikely => 'Most Likely (M)';

  @override
  String get agileEstMostLikelyHint => 'Most likely';

  @override
  String get agileEstPessimistic => 'Pessimistic (P)';

  @override
  String get agileEstPessimisticHint => 'Worst case';

  @override
  String get agileEstPointsSuffix => 'pts';

  @override
  String get agileEstFormula => 'PERT Formula: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Estimate: $value points';
  }

  @override
  String get agileEstErrorThreePoint => 'Enter all three values';

  @override
  String get agileEstErrorSelect => 'Select a value';

  @override
  String agileEstExisting(int count) {
    return 'Existing estimates ($count)';
  }

  @override
  String get agileEstYou => 'You';

  @override
  String get scrumPermBacklogTitle => 'Backlog Permissions';

  @override
  String get scrumPermBacklogDesc =>
      'Only the Product Owner can create, edit, delete and prioritize stories';

  @override
  String get scrumPermSprintTitle => 'Sprint Permissions';

  @override
  String get scrumPermSprintDesc =>
      'Only the Scrum Master can create, start and complete sprints';

  @override
  String get scrumPermEstimateTitle => 'Estimation Permissions';

  @override
  String get scrumPermEstimateDesc =>
      'Only the Development Team can estimate stories';

  @override
  String get scrumPermKanbanTitle => 'Kanban Permissions';

  @override
  String get scrumPermKanbanDesc =>
      'Development Team can move their own stories, PO and SM can move any story';

  @override
  String get scrumPermTeamTitle => 'Team Permissions';

  @override
  String get scrumPermTeamDesc =>
      'PO and SM can invite members, only PO can change roles';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Only the Product Owner can create new stories';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Only the Product Owner can edit stories';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Only the Product Owner can delete stories';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Only the Product Owner can reorder the backlog';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Only the Scrum Master can create new sprints';

  @override
  String get scrumPermDeniedSprintStart =>
      'Only the Scrum Master can start sprints';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Only the Scrum Master can complete sprints';

  @override
  String get scrumPermDeniedEstimate =>
      'Only the Development Team can estimate stories';

  @override
  String get scrumPermDeniedInvite => 'Only PO and SM can invite new members';

  @override
  String get scrumPermDeniedRoleChange =>
      'Only the Product Owner can change team roles';

  @override
  String get scrumPermDeniedWipConfig =>
      'Only the Scrum Master can configure WIP limits';

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
  String get scrumMatrixTitle => 'Scrum Permissions Matrix';

  @override
  String get scrumMatrixSubtitle =>
      'Who can do what according to Scrum Guide 2020';

  @override
  String get scrumMatrixLegend => 'Legend';

  @override
  String get scrumMatrixLegendFull => 'Manages';

  @override
  String get scrumMatrixLegendPartial => 'Partial';

  @override
  String get scrumMatrixLegendView => 'View only';

  @override
  String get scrumMatrixLegendNone => 'None';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'ESTIMATION';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'TEAM';

  @override
  String get scrumMatrixCategoryRetro => 'RETROSPECTIVE';

  @override
  String get scrumMatrixActionCreateStory => 'Create Story';

  @override
  String get scrumMatrixActionEditStory => 'Edit Story';

  @override
  String get scrumMatrixActionDeleteStory => 'Delete Story';

  @override
  String get scrumMatrixActionPrioritize => 'Prioritize Backlog';

  @override
  String get scrumMatrixActionAddAcceptance => 'Define Acceptance Criteria';

  @override
  String get scrumMatrixActionCreateSprint => 'Create Sprint';

  @override
  String get scrumMatrixActionStartSprint => 'Start Sprint';

  @override
  String get scrumMatrixActionCompleteSprint => 'Complete Sprint';

  @override
  String get scrumMatrixActionConfigWip => 'Configure WIP Limits';

  @override
  String get scrumMatrixActionEstimate => 'Estimate Story Points';

  @override
  String get scrumMatrixActionFinalEstimate => 'Set Final Estimate';

  @override
  String get scrumMatrixActionMoveOwn => 'Move own Stories';

  @override
  String get scrumMatrixActionMoveAny => 'Move any Story';

  @override
  String get scrumMatrixActionSelfAssign => 'Self-assign';

  @override
  String get scrumMatrixActionAssignOthers => 'Assign others';

  @override
  String get scrumMatrixActionChangeStatus => 'Change Story status';

  @override
  String get scrumMatrixActionInvite => 'Invite members';

  @override
  String get scrumMatrixActionRemove => 'Remove members';

  @override
  String get scrumMatrixActionChangeRole => 'Change roles';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Facilitate Retrospective';

  @override
  String get scrumMatrixActionParticipateRetro =>
      'Participate in Retrospective';

  @override
  String get scrumMatrixActionAddRetroItem => 'Add Retro item';

  @override
  String get scrumMatrixActionVoteRetro => 'Vote on items';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Invite to Team';

  @override
  String get agileInviteNew => 'NEW INVITE';

  @override
  String get agileInviteEmailLabel => 'Email';

  @override
  String get agileInviteEmailHint => 'name@example.com';

  @override
  String get agileInviteEnterEmail => 'Enter an email';

  @override
  String get agileInviteInvalidEmail => 'Invalid email';

  @override
  String get agileInviteProjectRole => 'Project Role';

  @override
  String get agileInviteTeamRole => 'Team Role';

  @override
  String get agileInviteSendEmail => 'Send notification email';

  @override
  String get agileInviteSendBtn => 'Send Invite';

  @override
  String get agileInviteLink => 'Invite link:';

  @override
  String get agileInviteLinkCopied => 'Link copied!';

  @override
  String get agileInviteListTitle => 'INVITES';

  @override
  String get agileInviteClose => 'Close';

  @override
  String get agileInviteGmailAuthTitle => 'Gmail Authorization';

  @override
  String get agileInviteGmailAuthContent =>
      'To send invite emails, you need to re-authenticate with Google.\n\nDo you want to proceed?';

  @override
  String get agileInviteGmailAuthNo => 'No, link only';

  @override
  String get agileInviteGmailAuthYes => 'Authorize';

  @override
  String agileInviteSentEmail(String email) {
    return 'Invite sent via email to $email';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Invite created for $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Revoke invite?';

  @override
  String get agileInviteRevokeContent => 'The invite will no longer be valid.';

  @override
  String get agileInviteRevokeBtn => 'Revoke';

  @override
  String get agileInviteResend => 'Resend';

  @override
  String get agileInviteResent => 'Invite resent';

  @override
  String get agileInviteStatusPending => 'Pending';

  @override
  String get agileInviteStatusAccepted => 'Accepted';

  @override
  String get agileInviteStatusDeclined => 'Declined';

  @override
  String get agileInviteStatusExpired => 'Expired';

  @override
  String get agileInviteStatusRevoked => 'Revoked';

  @override
  String get agileRoleMember => 'Member';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Viewer';

  @override
  String get agileRoleOwner => 'Owner';

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
    return 'Confirm ($count stories)';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Explicit policies define the rules for this column (Kanban Practice #4)';

  @override
  String get kanbanPoliciesEmpty => 'No policies defined';

  @override
  String get kanbanPoliciesAdd => 'Add policy';

  @override
  String get kanbanPoliciesHint => 'E.g.: Max 24h in this column';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Active policies: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Review of completed work with stakeholders';

  @override
  String get sprintReviewConductBy => 'Conducted by';

  @override
  String get sprintReviewDate => 'Review Date';

  @override
  String get sprintReviewAttendees => 'Attendees';

  @override
  String get sprintReviewSelectAttendees => 'Select attendees';

  @override
  String get sprintReviewDemoNotes => 'Demo Notes';

  @override
  String get sprintReviewDemoNotesHint => 'Describe the features demonstrated';

  @override
  String get sprintReviewFeedback => 'Feedback Received';

  @override
  String get sprintReviewFeedbackHint => 'Feedback from stakeholders';

  @override
  String get sprintReviewBacklogUpdates => 'Backlog Updates';

  @override
  String get sprintReviewBacklogUpdatesHint => 'Backlog changes discussed';

  @override
  String get sprintReviewNextFocus => 'Next Sprint Focus';

  @override
  String get sprintReviewNextFocusHint => 'Priorities for the next sprint';

  @override
  String get sprintReviewMarketNotes => 'Market/Budget Notes';

  @override
  String get sprintReviewMarketNotesHint =>
      'Market conditions, timeline, budget';

  @override
  String get sprintReviewStoriesCompleted => 'Stories Completed';

  @override
  String get sprintReviewStoriesNotCompleted => 'Stories Not Completed';

  @override
  String get sprintReviewPointsCompleted => 'Points Completed';

  @override
  String get sprintReviewSave => 'Save Review';

  @override
  String get sprintReviewWarning => 'Warning: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'The Sprint Review has not been conducted yet. According to the Scrum Guide 2020, the Sprint Review is a mandatory event before completing the sprint.';

  @override
  String get sprintReviewCompleteAnyway => 'Complete anyway';

  @override
  String get sprintReviewDoReview => 'Conduct Review';

  @override
  String get sprintReviewCompleted => 'Sprint Review completed';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Group cards by attribute';

  @override
  String get swimlaneTypeNone => 'None';

  @override
  String get swimlaneTypeNoneDesc => 'Standard view without grouping';

  @override
  String get swimlaneTypeClassOfService => 'Class of Service';

  @override
  String get swimlaneTypeClassOfServiceDesc => 'Group by priority/urgency';

  @override
  String get swimlaneTypeAssignee => 'Assignee';

  @override
  String get swimlaneTypeAssigneeDesc => 'Group by team member';

  @override
  String get swimlaneTypePriority => 'Priority';

  @override
  String get swimlaneTypePriorityDesc => 'Group by priority level';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Group by story tag';

  @override
  String get swimlaneUnassigned => 'Unassigned';

  @override
  String get swimlaneNoTag => 'No Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Measures the amount of story points completed per sprint. Helps forecast team capacity.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Total time from story creation to completion. Includes backlog wait time.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Time from start of work to completion. Measures development process efficiency.';

  @override
  String get agileMetricsThroughputDesc =>
      'Number of items completed per time unit. Indicates team productivity.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualizes stories distribution by status. Helps identify bottlenecks.';

  @override
  String get agilePredictability => 'Predictability';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% of items are completed in ≤$days days';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Items completed per week (last $weeks weeks)';
  }

  @override
  String get agileNoDataVelocity => 'No velocity data';

  @override
  String get agileNoDataLeadTime => 'No lead time data';

  @override
  String get agileNoDataCycleTime => 'No cycle time data';

  @override
  String get agileNoDataThroughput => 'No throughput data';

  @override
  String get agileNoDataAccuracy => 'No accuracy data';

  @override
  String get agileStartFinishOneItem =>
      'Complete at least one item to calculate';

  @override
  String get timeDays => 'days';

  @override
  String get auditLogTitle => 'Audit Log';

  @override
  String auditLogEventCount(int count) {
    return '$count events';
  }

  @override
  String get actionRefresh => 'Refresh';

  @override
  String get auditLogFilterEntityType => 'Type';

  @override
  String get auditLogFilterAction => 'Action';

  @override
  String get auditLogFilterFromDate => 'From';

  @override
  String get actionDetails => 'Details';

  @override
  String get auditLogDetailsTitle => 'Change Details';

  @override
  String get auditLogPreviousValue => 'Previous value:';

  @override
  String get auditLogNewValue => 'New value:';

  @override
  String get auditLogNoEvents => 'No events recorded';

  @override
  String get auditLogNoEventsDesc => 'Project activities will be recorded here';

  @override
  String get recentActivityTitle => 'Recent Activity';

  @override
  String get actionViewAll => 'View all';

  @override
  String get recentActivityNone => 'No recent activity';

  @override
  String get burndownChartTitle => 'Burndown Chart';

  @override
  String get agileIdeal => 'Ideal';

  @override
  String get agileActual => 'Actual';

  @override
  String get agileRemaining => 'Remaining';

  @override
  String get agileBurndownNoDataDesc =>
      'Data will appear when the sprint is active';

  @override
  String get agileCompleteActiveFirst =>
      'Complete the active sprint before starting another one';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'No tags';

  @override
  String get kanbanWipExceededBanner =>
      'WIP Limit exceeded! Complete some items before starting new ones.';

  @override
  String get kanbanConfigWip => 'Configure WIP';

  @override
  String get kanbanPoliciesDesc =>
      'Explicit policies help the team understand the rules for this column.';

  @override
  String get kanbanNewPolicyHint => 'New policy...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count of $limit max';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'WIP (Work In Progress) Limits are limits on the number of items that can be in a column at the same time.';

  @override
  String get kanbanUnderstand => 'I understand';

  @override
  String get agileHours => 'Hours';

  @override
  String get agileStoriesPerSprint => 'Stories / Sprint';

  @override
  String get agileSprints => 'Sprints';

  @override
  String get agileTeamComposition => 'Team Composition';

  @override
  String get agileHoursNote =>
      'Hours are an internal reference. For Scrum planning, use the Story Points view.';

  @override
  String get agileNoTeamMembers => 'No team members';

  @override
  String get agileGmailAuthError =>
      'Gmail authorization not available. Try logging out and in again.';

  @override
  String get agileGmailPermissionDenied => 'Gmail permission denied.';

  @override
  String get agileResend => 'Resend';

  @override
  String get agileRevoke => 'Revoke';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filters';

  @override
  String get agilePlanned => 'Planned';

  @override
  String get archiveDeleteSuccess => 'Successfully archived/deleted';

  @override
  String get agileNoItems => 'No items to show';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed of $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Items Completed';

  @override
  String get agileDaysRemainingSuffix => 'days remaining';

  @override
  String get agileItems => 'items';

  @override
  String get agilePerWeekSuffix => '/week';

  @override
  String get average => 'Average';

  @override
  String agileItemsCount(int count) {
    return '$count items';
  }

  @override
  String get agileDaysLeft => 'Days Left';

  @override
  String get all => 'All';

  @override
  String get kanbanGuidePoliciesTitle => 'Explicit Policies';

  @override
  String get agileDaysLabel => 'Days';

  @override
  String get agileStatRemaining => 'remaining';

  @override
  String get agileStatsCompletedLabel => 'Completed';

  @override
  String get agileStatsPlannedLabel => 'Planned';

  @override
  String get agileProgressLabel => 'Progress';

  @override
  String get agileDurationLabel => 'Duration';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Stories';

  @override
  String get agileSprintSummary => 'Sprint Summary';

  @override
  String get agileStoriesTotal => 'Total Stories';

  @override
  String get agileStoriesCompleted => 'Completed Stories';

  @override
  String get agilePointsCompletedLabel => 'Points Completed';

  @override
  String get agileStoriesIncomplete => 'Incomplete Stories';

  @override
  String get agileIncompleteReturnToBacklog => '(will return to backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Conduct Sprint Review';

  @override
  String get agileCompleteSprintAction => 'Complete Sprint';

  @override
  String get agileMissingReview => 'Sprint Review missing';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review completed';

  @override
  String get agileReviewNotesLabel => 'Review Notes';

  @override
  String get agileReviewFeedbackLabel => 'Stakeholder Feedback';

  @override
  String get agileReviewNextFocus => 'Next Sprint Focus';

  @override
  String get agileBacklogUpdatesLabel => 'Backlog Updates';

  @override
  String get agileSaveReview => 'Save Review';

  @override
  String get agileConductedBy => 'Conducted by';

  @override
  String get agileReviewDate => 'Review Date';

  @override
  String get agileReviewOutcome => 'Review Outcome';

  @override
  String get agileStoriesRejected => 'Rejected Stories';

  @override
  String get agileRejectedWarning =>
      'Incomplete or rejected stories will automatically return to the Backlog.';

  @override
  String get agileReviewDemoHint => 'What was shown during the demo?';

  @override
  String get agileReviewFeedbackHint => 'Feedback received from stakeholders';

  @override
  String get agileReviewBacklogHint => 'New backlog update...';

  @override
  String get agileReviewNextFocusHint => 'What should the team focus on?';

  @override
  String get agileReviewScrumGuide =>
      'The Scrum Guide 2020 recommends performing a Sprint Review before closing the sprint to inspect the work done with stakeholders.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Are you sure you want to complete \"$name\"?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint completed! Velocity: $velocity pts/week';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review saved';

  @override
  String get agileEstimationAccuracy => 'Estimation Accuracy';

  @override
  String get agileCompleteOneSprintFirst => 'Complete at least one sprint';

  @override
  String get agileNoDataAccuracyFix => 'No accuracy data';

  @override
  String get agileScrumGuideRecommends =>
      'The Scrum Guide recommends planning based on historical Velocity, not hours.';

  @override
  String get agileNoSkillsDefined => 'No skills defined';

  @override
  String get agileAddSkillsToMembers => 'Add skills to team members';

  @override
  String get retroNoSprintWarningTitle => 'No Sprint Completed';

  @override
  String get retroNoSprintWarningMessage =>
      'To create a Scrum retrospective, you need to complete at least one sprint first. Retrospectives are linked to sprints to track improvements between iterations.';

  @override
  String get agileGoToSprints => 'Go to Sprints';

  @override
  String get agileSprintReviewHistory => 'Sprint Review History';

  @override
  String get agileNoSprintReviews => 'No Sprint Reviews';

  @override
  String get agileNoSprintReviewsHint =>
      'Complete a sprint and conduct a Sprint Review to see it here';

  @override
  String get agileAttendees => 'Attendees';

  @override
  String get agileStoryEvaluations => 'Story Evaluations';

  @override
  String get agileDecisions => 'Decisions';

  @override
  String get agileDemoNotes => 'Demo Notes';

  @override
  String get agileFeedback => 'Feedback';

  @override
  String get agileStoryApproved => 'Approved';

  @override
  String get agileStoryNeedsRefinement => 'Needs Refinement';

  @override
  String get agileStoryRejected => 'Rejected';

  @override
  String get agileAddAttendee => 'Add Attendee';

  @override
  String get agileAddDecision => 'Add Decision';

  @override
  String get agileEvaluateStories => 'Evaluate Stories';

  @override
  String get agileSelectRole => 'Select Role';

  @override
  String get agileStatsNotCompleted => 'Not Completed';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Team Members';

  @override
  String get eisenhowerImportCsv => 'Import CSV';

  @override
  String get eisenhowerImportPreview => 'Activity Preview';

  @override
  String get eisenhowerImportSelectFile => 'Select a CSV file to import';

  @override
  String get eisenhowerImportFormatHint =>
      'Expected format: Activity, Description, Quadrant, Urgency, Importance';

  @override
  String get eisenhowerImportClickToSelect => 'Click to select file';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Supported formats: .csv (UTF-8 or Latin-1)';

  @override
  String get eisenhowerImportNoActivities => 'No activities found in file';

  @override
  String get eisenhowerImportMarkRevealed => 'Mark as already voted';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Activities will appear directly in the calculated quadrant';

  @override
  String eisenhowerImportSuccess(int count) {
    return 'Imported $count activities';
  }

  @override
  String get actionSelectAll => 'Select All';

  @override
  String get actionDeselectAll => 'Deselect All';

  @override
  String get actionImport => 'Import';

  @override
  String get eisenhowerImportShowInstructions => 'Show/hide instructions';

  @override
  String get eisenhowerImportInstructionsTitle => 'Required CSV Format';

  @override
  String get eisenhowerImportInstructionsBody =>
      'The CSV file must contain at least the \'Activity\' or \'Title\' column. Optional columns: Description, Urgency (1-10), Importance (1-10). The first row must be the header.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Activity,Description,Urgency,Importance\n\"Activity name\",\"Optional description\",8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Change file';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return '$count rows skipped due to errors';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...and $count more rows';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return 'Found $valid valid activities out of $total rows';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Row $row: empty title';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Row $row: invalid format';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      '\'Activity\' or \'Title\' column not found in header';

  @override
  String get eisenhowerImportErrorEmptyFile => 'The file is empty';

  @override
  String get eisenhowerImportErrorNoHeader => 'Header not found in first row';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Row $row';
  }

  @override
  String get eisenhowerImportErrorReadFile => 'Unable to read file';

  @override
  String get agileSprintHealthTitle => 'Sprint Health';

  @override
  String get agileSprintHealthNoSprint => 'No active sprint';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Start a sprint to see health metrics';

  @override
  String get agileSprintHealthGoal => 'Sprint Goal';

  @override
  String get agileSprintHealthOnTrack => 'On Track';

  @override
  String get agileSprintHealthAtRisk => 'At Risk';

  @override
  String get agileSprintHealthOffTrack => 'Off Track';

  @override
  String get agileSprintHealthTime => 'Time';

  @override
  String get agileSprintHealthWork => 'Work';

  @override
  String get agileSprintHealthDaysLeft => 'days left';

  @override
  String get agileSprintHealthSpRemaining => 'SP remaining';

  @override
  String get agileSprintHealthStoriesDone => 'Stories Done';

  @override
  String get agileSprintHealthCommitment => 'Commitment';

  @override
  String get agileSprintHealthDailyVelocity => 'Daily Velocity';

  @override
  String get agileSprintHealthPrediction => 'Prediction';

  @override
  String get agileSprintHealthOnTime => 'On time';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Stories Breakdown';

  @override
  String get agileSprintBurndownTitle => 'Sprint Burndown';

  @override
  String get agileSprintBurndownNoData => 'No burndown data';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Assign stories to the sprint to see the burndown';

  @override
  String get agileWorkloadTitle => 'Team Workload';

  @override
  String get agileWorkloadBalanced => 'Balanced';

  @override
  String get agileWorkloadUnbalanced => 'Unbalanced';

  @override
  String get agileWorkloadTotalStories => 'Total Stories';

  @override
  String get agileWorkloadAssigned => 'Assigned';

  @override
  String get agileWorkloadAvgSp => 'Avg SP/Person';

  @override
  String get agileWorkloadStories => 'stories';

  @override
  String get agileWorkloadInProgress => 'in progress';

  @override
  String get agileWorkloadUnassigned => 'Unassigned';

  @override
  String get agileWorkloadUnassignedWarning => 'stories without assignee';

  @override
  String get agileWorkloadNoStories => 'No stories to analyze';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Create stories and assign them to team members';

  @override
  String get agileWorkloadOverloaded => 'Overloaded';

  @override
  String get agileCommitmentTrendTitle => 'Commitment Reliability Trend';

  @override
  String get agileCommitmentTrendNoData => 'No data available';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Complete at least one sprint to view the trend';

  @override
  String get agileCommitmentTrendPlanned => 'Planned';

  @override
  String get agileCommitmentTrendCompleted => 'Completed';

  @override
  String get agileCommitmentTrendAvg => 'Average';

  @override
  String get agileFlowEfficiencyTitle => 'Flow Efficiency & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'No data available';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Add stories to view flow analysis';

  @override
  String get agileFlowEfficiency => 'Flow Efficiency';

  @override
  String get agileFlowCycleTime => 'Cycle Time';

  @override
  String get agileFlowLeadTime => 'Lead Time';

  @override
  String get agileFlowDays => 'days';

  @override
  String get agileFlowWipByStatus => 'WIP by Status';

  @override
  String get agileFlowAvg => 'avg';

  @override
  String get agileBlockedItemsTitle => 'Blocked Items';

  @override
  String get agileBlockedItemsNone => 'No blocked items';

  @override
  String get agileBlockedItemsNoneDesc => 'All dependencies are satisfied';

  @override
  String agileBlockedItemsCount(Object count) {
    return '$count blocked';
  }

  @override
  String get agileBlockedItemsSp => 'SP blocked';

  @override
  String get agileBlockedItemsBlockedBy => 'Blocked by';

  @override
  String get agileBlockedItemsDependency => 'dependency';

  @override
  String get agileBlockedItemsDependencies => 'dependencies';

  @override
  String get agileSprintScopeTitle => 'Sprint Scope';

  @override
  String get agileSprintScopeNoSprint => 'No active sprint';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Start a sprint to monitor scope changes';

  @override
  String get agileSprintScopeOriginal => 'Original';

  @override
  String get agileSprintScopeCurrent => 'Current';

  @override
  String get agileSprintScopeDelta => 'Delta';

  @override
  String get agileSprintScopeCreep => 'Scope Creep';

  @override
  String get agileSprintScopeReduction => 'Scope Reduction';

  @override
  String get agileSprintScopeStable => 'Stable';

  @override
  String get agileSprintScopeSp => 'SP';

  @override
  String get landingIntegrationBadge => 'Integration';

  @override
  String get landingIntegrationTitle => 'A connected ecosystem';

  @override
  String get landingIntegrationSubtitle =>
      'Your tools work together. Go from idea to delivery without interruptions.';

  @override
  String get landingIntegrationFlowTitle =>
      'From list to delivery, in a single flow';

  @override
  String get landingIntegrationStep1 => 'Collect';

  @override
  String get landingIntegrationStep1Desc => 'Smart Todo';

  @override
  String get landingIntegrationStep2 => 'Prioritize';

  @override
  String get landingIntegrationStep2Desc => 'Eisenhower';

  @override
  String get landingIntegrationStep3 => 'Estimate';

  @override
  String get landingIntegrationStep3Desc => 'Estimation Room';

  @override
  String get landingIntegrationStep4 => 'Execute';

  @override
  String get landingIntegrationStep4Desc => 'Agile Process';

  @override
  String get landingIntegrationStep5 => 'Improve';

  @override
  String get landingIntegrationStep5Desc => 'Retrospectives';

  @override
  String get landingIntegrationExport0Title =>
      'Smart Todo → Eisenhower / Estimate / Sprint';

  @override
  String get landingIntegrationExport0Desc =>
      'Turn your tasks into prioritized activities, estimation stories, or sprint backlog items.';

  @override
  String get landingIntegrationExport1Title =>
      'Eisenhower → Todo / Estimate / Sprint';

  @override
  String get landingIntegrationExport1Desc =>
      'Export prioritized activities into tasks, estimation stories, or sprint user stories.';

  @override
  String get landingIntegrationExport2Title =>
      'Estimation Room → Todo / Sprint';

  @override
  String get landingIntegrationExport2Desc =>
      'After estimation, push stories with agreed points into your lists or sprint backlog.';

  @override
  String get landingIntegrationExport3Title => 'Agile Process → Retrospectives';

  @override
  String get landingIntegrationExport3Desc =>
      'Link retrospectives to sprints with metrics available during the discussion phase.';

  @override
  String get landingIntegrationDashboardTitle => 'Unified Dashboard';

  @override
  String get landingIntegrationDashboardDesc =>
      'Favorites, deadlines, and pending invites from every tool in one place.';
}
