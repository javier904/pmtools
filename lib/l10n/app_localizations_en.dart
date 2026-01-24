// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get actionConfirm => 'Confirm';

  @override
  String get actionSearch => 'Search';

  @override
  String get actionFilter => 'Filter';

  @override
  String get actionExport => 'Export';

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
  String get retroCreateNew => 'Create New';

  @override
  String get retroGuidance => 'Retrospective Guide';

  @override
  String get retroSearchHint => 'Search retrospective...';

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
  String get retroPhaseStart => 'Start';

  @override
  String get retroPhaseStop => 'Stop';

  @override
  String get retroPhaseContinue => 'Continue';

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
  String get addParticipant => 'Add participant';

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
  String get retroNoActionItems => 'No Action Items created yet.';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Ref.';

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
  String get retroNoRetrosFound => 'No retrospective found';

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
  String get smartTodoSortDate => 'Recent';

  @override
  String get smartTodoSortManual => 'Manual';

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
      'Esempio:\nComprare il latte, High, @mario\nFare report, Medium, @luigi';

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
  String get agileEstimateRequired => 'Estimate required (click to estimate)';

  @override
  String get agilePoints => 'pts';

  @override
  String agilePointsValue(int points) {
    return '$points pts';
  }

  @override
  String get agileMethodologyGuideTitle => 'Agile Methodology Guide';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Choose the methodology that best fits your project';

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
  String get kanbanWipExplanationTitle => 'WIP Limits';

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
  String get kanbanBoardTitle => 'Kanban Board';

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
      'Real-time collaborative tools: timers, anonymous voting, action items, and AI reports.';

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
  String get landingFooterChangelog => 'Changelog';

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
    return 'Piano Attuale: $plan';
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
  String get exportToEstimation => 'Export to Estimation';

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
  String get exportFromEisenhower => 'Export from Eisenhower';

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
  String get exportToUserStories => 'Export to User Stories';

  @override
  String get exportToUserStoriesDesc =>
      'Create user stories in an Agile project';

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
  String get exportToAgileSprint => 'Export to Sprint';

  @override
  String get exportToAgileSprintDesc =>
      'Add estimated stories to an Agile sprint';

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
  String get exportToSprint => 'Export to Sprint';

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
      'Transform Eisenhower activities into User Stories';

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
      'Activities will be added as stories to estimate. Q priority will not be transferred.';

  @override
  String get createSession => 'Create Session';

  @override
  String get estimationType => 'Estimation type';

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
}
