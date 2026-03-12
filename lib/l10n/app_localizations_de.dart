// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get smartTodoListOrigin => 'Zugehörigkeitsliste';

  @override
  String get smartTodoSortTooltip => 'Sortieroptionen';

  @override
  String get smartTodoSortManual => 'Manuell';

  @override
  String get smartTodoSortDate => 'Aktuell';

  @override
  String get smartTodoActionSortPriority => 'Nach Priorität sortieren';

  @override
  String get smartTodoActionSortDeadline => 'Nach Deadline sortieren';

  @override
  String get smartTodoOrderUpdated => 'Reihenfolge manuell aktualisiert';

  @override
  String get newRetro => 'Neue Retro';

  @override
  String get appTitle => 'Keisen';

  @override
  String get goToHome => 'Home';

  @override
  String get actionSave => 'Speichern';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionDelete => 'Löschen';

  @override
  String get actionEdit => 'Bearbeiten';

  @override
  String get actionCreate => 'Erstellen';

  @override
  String get actionAdd => 'Hinzufügen';

  @override
  String get actionClose => 'Schließen';

  @override
  String get agileSprint => 'Sprint';

  @override
  String get agileStatus => 'Status';

  @override
  String get agilePermissionErrorBacklog =>
      'Berechtigung verweigert: Nur PO/SM können in das Backlog verschieben';

  @override
  String get actionHide => 'Karten ausblenden';

  @override
  String get actionRetry => 'Wiederholen';

  @override
  String get exportAllData => 'Alle Daten exportieren (Vollständiger Bericht)';

  @override
  String get actionConfirm => 'Bestätigen';

  @override
  String get actionSearch => 'Suchen';

  @override
  String get actionFilter => 'Filtern';

  @override
  String get actionExport => 'Exportieren';

  @override
  String get actionExportCsv => 'CSV exportieren';

  @override
  String get actionExportPdf => 'PDF-Bericht exportieren';

  @override
  String get retroBoard => 'Board-Elemente';

  @override
  String get actionCopy => 'Kopieren';

  @override
  String get actionShare => 'Teilen';

  @override
  String get actionDone => 'Fertig';

  @override
  String get actionReset => 'Zurücksetzen';

  @override
  String get actionOpen => 'Öffnen';

  @override
  String get stateLoading => 'Laden...';

  @override
  String get stateEmpty => 'Keine Elemente';

  @override
  String get stateError => 'Fehler';

  @override
  String get stateSuccess => 'Erfolg';

  @override
  String get subscriptionCurrent => 'AKTUELL';

  @override
  String get subscriptionRecommended => 'EMPFEHLENSWERT';

  @override
  String get subscriptionFree => 'Gratis';

  @override
  String get subscriptionPerMonth => '/Monat';

  @override
  String get subscriptionPerYear => '/Jahr';

  @override
  String subscriptionSaveYearly(String amount) {
    return 'Sparen Sie €$amount/Jahr';
  }

  @override
  String subscriptionTrialDays(int days) {
    return '$days Tage kostenlos testen';
  }

  @override
  String get subscriptionUnlimitedProjects => 'Unbegrenzte Projekte';

  @override
  String subscriptionProjectsActive(int count) {
    return '$count aktive Projekte';
  }

  @override
  String get subscriptionUnlimitedLists => 'Unbegrenzte Listen';

  @override
  String subscriptionSmartTodoLists(int count) {
    return 'Smart Todo Listen';
  }

  @override
  String get subscriptionActiveProjectsLabel => 'Aktive Projekte';

  @override
  String get subscriptionSmartTodoListsLabel => 'Smart Todo Listen';

  @override
  String get subscriptionUnlimitedTasks => 'Unbegrenzte Tasks';

  @override
  String subscriptionTasksPerProject(int count) {
    return '$count Tasks pro Projekt';
  }

  @override
  String get subscriptionUnlimitedInvites => 'Unbegrenzte Einladungen';

  @override
  String subscriptionInvitesPerProject(int count) {
    return '$count Einladungen pro Projekt';
  }

  @override
  String get subscriptionWithAds => 'Mit Werbung';

  @override
  String get subscriptionWithoutAds => 'Ohne Werbung';

  @override
  String get authSignInGoogle => 'Mit Google anmelden';

  @override
  String get authSignOut => 'Abmelden';

  @override
  String get authLogoutConfirm => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get formNameRequired => 'Bitte geben Sie Ihren Namen ein';

  @override
  String get authError => 'Authentifizierungsfehler';

  @override
  String get authUserNotFound => 'Benutzer nicht gefunden';

  @override
  String get authWrongPassword => 'Falsches Passwort';

  @override
  String get authEmailInUse => 'E-Mail wird bereits verwendet';

  @override
  String get authWeakPassword => 'Passwort ist zu schwach';

  @override
  String get authInvalidEmail => 'Ungültige E-Mail';

  @override
  String get appSubtitle => 'Keisen für Teams';

  @override
  String get authOr => 'oder';

  @override
  String get authPassword => 'Passwort';

  @override
  String get authRegister => 'Registrieren';

  @override
  String get authLogin => 'Anmelden';

  @override
  String get authHaveAccount => 'Haben Sie bereits ein Konto?';

  @override
  String get authNoAccount => 'Haben Sie noch kein Konto?';

  @override
  String get authForgotPassword => 'Passwort vergessen?';

  @override
  String get authResetPasswordSent =>
      'E-Mail zum Zurücksetzen gesendet. Bitte prüfen Sie Ihren Posteingang.';

  @override
  String get authVerifyEmail => 'E-Mail verifizieren';

  @override
  String authVerifyEmailDesc(String email) {
    return 'Wir haben eine Bestätigungs-E-Mail an $email gesendet. Klicken Sie auf den Link, um Ihr Konto zu aktivieren.';
  }

  @override
  String get authResendVerification => 'Bestätigungs-E-Mail erneut senden';

  @override
  String get authVerificationSent => 'Bestätigungs-E-Mail gesendet!';

  @override
  String get authEmailVerified => 'E-Mail verifiziert!';

  @override
  String get authIVerified => 'Ich habe meine E-Mail verifiziert';

  @override
  String get authWaitingVerification => 'Warten auf Verifizierung...';

  @override
  String get authChangePassword => 'Passwort ändern';

  @override
  String get authCurrentPassword => 'Aktuelles Passwort';

  @override
  String get authNewPassword => 'Neues Passwort';

  @override
  String get authConfirmNewPassword => 'Neues Passwort bestätigen';

  @override
  String get authPasswordChanged => 'Passwort erfolgreich geändert';

  @override
  String get authPasswordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get authPasswordTooShort => 'Mindestens 6 Zeichen';

  @override
  String get authReauthRequired => 'Identität bestätigen';

  @override
  String get authReauthDesc =>
      'Zur Sicherheit bestätigen Sie bitte Ihre Identität, um fortzufahren.';

  @override
  String get authSignInWithEmail => 'Mit E-Mail anmelden';

  @override
  String get authWrongCurrentPassword =>
      'Das aktuelle Passwort ist nicht korrekt';

  @override
  String get profileSecurity => 'Sicherheit';

  @override
  String authCooldownWait(int seconds) {
    return 'Warten Sie ${seconds}s vor dem erneuten Senden';
  }

  @override
  String get feedbackReportBug => 'Einen Fehler melden';

  @override
  String get feedbackRequestFeature => 'Eine Funktion anfordern';

  @override
  String get feedbackHistory => 'Feedback-Verlauf';

  @override
  String get feedbackTypeBug => 'Fehlerbericht';

  @override
  String get feedbackTypeFeature => 'Funktionsanfrage';

  @override
  String get feedbackSubject => 'Betreff';

  @override
  String get feedbackSubjectHint => 'Beschreiben Sie kurz das Problem...';

  @override
  String get feedbackDescription => 'Beschreibung';

  @override
  String get feedbackDescriptionHint => 'Geben Sie hier weitere Details an...';

  @override
  String get feedbackConsent =>
      'Ich autorisiere die Verarbeitung meiner Daten zur Nachverfolgung und Aufzeichnung dieser Anfrage gemäß der Datenschutzrichtlinie.';

  @override
  String get feedbackSubmit => 'Anfrage senden';

  @override
  String get feedbackSuccess => 'Anfrage erfolgreich gesendet!';

  @override
  String get feedbackError => 'Fehler beim Senden der Anfrage';

  @override
  String get feedbackStatusNew => 'Neu';

  @override
  String get feedbackStatusInProgress => 'In Bearbeitung';

  @override
  String get feedbackStatusResolved => 'Gelöst';

  @override
  String get feedbackStatusClosed => 'Geschlossen';

  @override
  String get feedbackNoRequests => 'Keine Anfragen gefunden';

  @override
  String get feedbackAdminTitle => 'Feedback-Verwaltung';

  @override
  String get navHome => 'Home';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get eisenhowerTitle => 'Eisenhower-Matrix';

  @override
  String get eisenhowerYourMatrices => 'Ihre Matrizen';

  @override
  String get eisenhowerNoMatrices => 'Keine Matrix erstellt';

  @override
  String get eisenhowerNewMatrix => 'Neue Matrix';

  @override
  String get eisenhowerViewGrid => 'Gitter';

  @override
  String get eisenhowerViewChart => 'Grafik';

  @override
  String get eisenhowerViewList => 'Liste';

  @override
  String get eisenhowerViewRaci => 'RACI';

  @override
  String get quadrantUrgent => 'DRINGEND';

  @override
  String get quadrantNotUrgent => 'NICHT DRINGEND';

  @override
  String get quadrantImportant => 'WICHTIG';

  @override
  String get quadrantNotImportant => 'NICHT WICHTIG';

  @override
  String get quadrantQ1Title => 'SOFORT ERLEDIGEN';

  @override
  String get quadrantQ2Title => 'PLANEN';

  @override
  String get quadrantQ3Title => 'DELEGIEREN';

  @override
  String get quadrantQ4Title => 'ELIMINIEREN';

  @override
  String get quadrantQ1Subtitle => 'Dringend und Wichtig';

  @override
  String get quadrantQ2Subtitle => 'Wichtig, nicht dringend';

  @override
  String get quadrantQ3Subtitle => 'Dringend, nicht wichtig';

  @override
  String get quadrantQ4Subtitle => 'Nicht dringend, nicht wichtig';

  @override
  String get eisenhowerNoActivities => 'Keine Aktivitäten';

  @override
  String get eisenhowerNewActivity => 'Neue Aktivität';

  @override
  String get eisenhowerExportSheets => 'Nach Google Sheets exportieren';

  @override
  String get eisenhowerInviteParticipants => 'Teilnehmer einladen';

  @override
  String get eisenhowerDeleteMatrix => 'Matrix löschen';

  @override
  String get eisenhowerDeleteMatrixConfirm =>
      'Sind Sie sicher, dass Sie diese Matrix löschen möchten?';

  @override
  String get eisenhowerActivityTitle => 'Sachtitel';

  @override
  String get eisenhowerActivityNotes => 'Notizen';

  @override
  String get eisenhowerDueDate => 'Fälligkeitsdatum';

  @override
  String get eisenhowerPriority => 'Priorität';

  @override
  String get eisenhowerAssignee => 'Zuständiger';

  @override
  String get eisenhowerCompleted => 'Abgeschlossen';

  @override
  String get eisenhowerMoveToQuadrant => 'In Quadranten verschieben';

  @override
  String get eisenhowerMatrixSettings => 'Matrix-Einstellungen';

  @override
  String get eisenhowerBackToList => 'Liste';

  @override
  String get eisenhowerPriorityList => 'Prioritätenliste';

  @override
  String get eisenhowerAllActivities => 'Alle Aktivitäten';

  @override
  String get eisenhowerToVote => 'Abzustimmen';

  @override
  String get eisenhowerVoted => 'Abgestimmt';

  @override
  String get eisenhowerTotal => 'Gesamt';

  @override
  String get eisenhowerEditParticipants => 'Teilnehmer bearbeiten';

  @override
  String eisenhowerActivityCountLabel(int count) {
    return '$count Aktivitäten';
  }

  @override
  String eisenhowerVoteCountLabel(int count) {
    return '$count Stimmen';
  }

  @override
  String get eisenhowerModifyVotes => 'Stimmen bearbeiten';

  @override
  String get eisenhowerVote => 'Voten';

  @override
  String get eisenhowerQuadrant => 'Quadrant';

  @override
  String get eisenhowerUrgencyAvg => 'Durchschnittliche Dringlichkeit';

  @override
  String get eisenhowerImportanceAvg => 'Durchschnittliche Wichtigkeit';

  @override
  String get eisenhowerVotesLabel => 'Stimmen:';

  @override
  String get eisenhowerNoVotesYet => 'Noch keine Stimmen gesammelt';

  @override
  String get eisenhowerEditMatrix => 'Matrix bearbeiten';

  @override
  String get eisenhowerAddActivity => 'Aktivität hinzufügen';

  @override
  String get eisenhowerDeleteActivity => 'Aktivität löschen';

  @override
  String eisenhowerDeleteActivityConfirm(String title) {
    return 'Sind Sie sicher, dass Sie \"$title\" löschen möchten?';
  }

  @override
  String get eisenhowerMatrixCreated => 'Matrix erfolgreich erstellt';

  @override
  String get eisenhowerMatrixUpdated => 'Matrix aktualisiert';

  @override
  String get eisenhowerMatrixDeleted => 'Matrix gelöscht';

  @override
  String get eisenhowerActivityAdded => 'Aktivität hinzugefügt';

  @override
  String get eisenhowerActivityDeleted => 'Aktivität gelöscht';

  @override
  String get eisenhowerVotesSaved => 'Stimmen gespeichert';

  @override
  String get eisenhowerExportCompleted => 'Export abgeschlossen!';

  @override
  String get eisenhowerExportAll => 'Alle Daten exportieren';

  @override
  String get eisenhowerExportCompletedDialog => 'Export abgeschlossen';

  @override
  String get eisenhowerExportDialogContent =>
      'Die Google Sheets Datei wurde erstellt.\nMöchten Sie sie im Browser öffnen?';

  @override
  String get eisenhowerOpen => 'Öffnen';

  @override
  String get eisenhowerAddParticipantsFirst =>
      'Fügen Sie zuerst Teilnehmer zur Matrix hinzu';

  @override
  String get eisenhowerSearchLabel => 'Suchen:';

  @override
  String get eisenhowerSearchHint => 'Matrizen suchen...';

  @override
  String get eisenhowerNoMatrixFound => 'Keine Matrix gefunden';

  @override
  String get eisenhowerCreateFirstMatrix =>
      'Erstellen Sie Ihre erste Eisenhower-Matrix,\num Ihre Prioritäten zu organisieren';

  @override
  String get eisenhowerCreateMatrix => 'Matrix erstellen';

  @override
  String get eisenhowerClickToOpen => 'Eisenhower-Matrix\nZum Öffnen klicken';

  @override
  String get eisenhowerTotalActivities => 'Gesamte Aktivitäten in der Matrix';

  @override
  String get eisenhowerVotedActivities => 'Abgestimmte Aktivitäten';

  @override
  String get eisenhowerPendingVoting => 'Noch abzustimmende Aktivitäten';

  @override
  String get eisenhowerStartVoting => 'Unabhängige Abstimmung starten';

  @override
  String eisenhowerStartVotingDesc(String title) {
    return 'Möchten Sie eine unabhängige Abstimmungssitzung für \"$title\" starten?\n\nJeder Teilnehmer stimmt ab, ohne die Stimmen der anderen zu sehen, bis alle abgestimmt haben und die Ergebnisse veröffentlicht werden.';
  }

  @override
  String get eisenhowerStart => 'Starten';

  @override
  String get eisenhowerVotingStarted => 'Abstimmung gestartet';

  @override
  String get eisenhowerResetVoting => 'Abstimmung zurücksetzen?';

  @override
  String get eisenhowerResetVotingDesc => 'Alle Stimmen werden gelöscht.';

  @override
  String get eisenhowerVotingReset => 'Abstimmung zurückgesetzt';

  @override
  String get eisenhowerMinVotersRequired =>
      'Mindestens 2 Wähler für unabhängige Abstimmung erforderlich';

  @override
  String eisenhowerDeleteMatrixWithActivities(int count) {
    return 'Alle $count Aktivitäten werden ebenfalls gelöscht.';
  }

  @override
  String eisenhowerYourMatricesCount(int filtered, int total) {
    return 'Ihre Matrizen ($filtered/$total)';
  }

  @override
  String get formTitleRequired => 'Bitte Titel eingeben';

  @override
  String get formTitleHint => 'Z.B.: Prioritäten Q1 2025';

  @override
  String get formDescriptionHint => 'Optionale Beschreibung';

  @override
  String get formParticipantHint => 'Name des Teilnehmers';

  @override
  String get formAddParticipantHint =>
      'Fügen Sie mindestens einen Teilnehmer hinzu, um abstimmen zu können';

  @override
  String get formActivityTitleHint =>
      'Z.B.: API-Dokumentation vervollständigen';

  @override
  String get errorCreatingMatrix => 'Fehler beim Erstellen der Matrix';

  @override
  String get errorUpdatingMatrix => 'Fehler beim Aktualisieren';

  @override
  String get errorDeletingMatrix => 'Fehler beim Löschen';

  @override
  String get errorAddingActivity => 'Fehler beim Hinzufügen der Aktivität';

  @override
  String get errorSavingVotes => 'Fehler beim Speichern der Stimmen';

  @override
  String get errorExport => 'Fehler beim Export';

  @override
  String get errorStartingVoting => 'Fehler beim Starten der Abstimmung';

  @override
  String get errorResetVoting => 'Fehler beim Zurücksetzen';

  @override
  String get errorLoadingActivities => 'Fehler beim Laden der Aktivitäten';

  @override
  String get eisenhowerWaitingForVotes => 'Warten auf Stimmen';

  @override
  String eisenhowerVotedParticipants(int ready, int total) {
    return '$ready/$total Stimmen';
  }

  @override
  String get eisenhowerVoteSubmit => 'ABSTIMMEN';

  @override
  String get eisenhowerVotedSuccess => 'Sie haben abgestimmt';

  @override
  String get eisenhowerRevealVotes => 'STIMMEN VERÖFFENTLICHEN';

  @override
  String get eisenhowerQuickVote => 'Schnelle Abstimmung';

  @override
  String get eisenhowerTeamVote => 'Team-Abstimmung';

  @override
  String get eisenhowerUrgency => 'DRINGLICHKEIT';

  @override
  String get eisenhowerImportance => 'WICHTIGKEIT';

  @override
  String get eisenhowerUrgencyShort => 'D:';

  @override
  String get eisenhowerImportanceShort => 'W:';

  @override
  String get eisenhowerVoting => 'Abstimmung';

  @override
  String get eisenhowerVotingInProgress => 'ABSTIMMUNG LÄUFT';

  @override
  String get eisenhowerWaitingForOthers =>
      'Warten, bis alle abgestimmt haben. Der Moderator wird die Stimmen veröffentlichen.';

  @override
  String get eisenhowerReady => 'Bereit';

  @override
  String get eisenhowerWaiting => 'Warten';

  @override
  String get eisenhowerIndividualVotes => 'INDIVIDUELLE STIMMEN';

  @override
  String get eisenhowerResult => 'ERGEBNIS';

  @override
  String get eisenhowerAverage => 'DURCHSCHNITT';

  @override
  String get eisenhowerVotesRevealed => 'Stimmen veröffentlicht';

  @override
  String get eisenhowerNextActivity => 'Nächste Aktivität';

  @override
  String get eisenhowerNoVotesRecorded => 'Keine Stimmen aufgezeichnet';

  @override
  String get eisenhowerWaitingForStart => 'Warten';

  @override
  String get eisenhowerPreVotesTooltip =>
      'Vorab-Stimmen, die gezählt werden, wenn der Moderator die Abstimmung startet';

  @override
  String get eisenhowerObserverWaiting =>
      'Warten darauf, dass der Moderator die kollektive Abstimmung startet';

  @override
  String get eisenhowerPreVoteTooltip =>
      'Geben Sie Ihre Stimme im Voraus ab. Sie wird gezählt, wenn die Abstimmung gestartet wird.';

  @override
  String get eisenhowerPreVote => 'Vorab-Voten';

  @override
  String get eisenhowerPreVoted => 'Sie haben vorab abgestimmt';

  @override
  String get eisenhowerStartVotingTooltip =>
      'Starten Sie die kollektive Abstimmungssitzung. Bestehende Vorab-Stimmen bleiben erhalten.';

  @override
  String get eisenhowerResetVotingTooltip =>
      'Setzen Sie die Abstimmung zurück und löschen Sie alle Stimmen';

  @override
  String get eisenhowerObserverWaitingVotes =>
      'Laufende Abstimmung beobachten...';

  @override
  String get eisenhowerWaitingForAllVotes =>
      'Warten darauf, dass alle Teilnehmer abstimmen';

  @override
  String get eisenhowerRevealTooltipReady =>
      'Alle haben abgestimmt! Klicken Sie, um die Ergebnisse zu veröffentlichen.';

  @override
  String eisenhowerRevealTooltipNotReady(int count) {
    return 'Noch $count Stimmen fehlen';
  }

  @override
  String get eisenhowerVotingLocked => 'Abstimmung geschlossen';

  @override
  String get eisenhowerVotingLockedTooltip =>
      'Die Stimmen wurden veröffentlicht. Es ist nicht mehr possibile, für diese Aktivität abzustimmen.';

  @override
  String eisenhowerOnlineParticipants(int online, int total) {
    return '$online von $total Teilnehmern online';
  }

  @override
  String get eisenhowerAllActivitiesVoted =>
      'Alle Aktivitäten wurden abgestimmt!';

  @override
  String get eisenhowerAlreadyVotedError =>
      'Diese Aktivität wurde bereits abgestimmt. Der Moderator muss die Abstimmung erneut öffnen, um sie zu bearbeiten.';

  @override
  String eisenhowerYourVote(Object urgency, Object importance) {
    return 'Ihre Stimme: D=$urgency, W=$importance';
  }

  @override
  String eisenhowerVoterName(Object name) {
    return 'Stimme von $name';
  }

  @override
  String get eisenhowerUrgencyLow => 'Nicht dringend';

  @override
  String get eisenhowerUrgencyHigh => 'Sehr dringend';

  @override
  String get eisenhowerImportanceLow => 'Nicht importante';

  @override
  String get eisenhowerImportanceHigh => 'Sehr wichtig';

  @override
  String eisenhowerQuadrantLabel(Object name) {
    return 'Quadrant: $name';
  }

  @override
  String get eisenhowerQ1Name => 'Q1 - SOFORT ERLEDIGEN';

  @override
  String get eisenhowerQ1Desc => 'Dringend + Wichtig';

  @override
  String get eisenhowerQ2Name => 'Q2 - PLANEN';

  @override
  String get eisenhowerQ2Desc => 'Nicht dringend + Wichtig';

  @override
  String get eisenhowerQ3Name => 'Q3 - DELEGIEREN';

  @override
  String get eisenhowerQ3Desc => 'Dringend + Nicht wichtig';

  @override
  String get eisenhowerQ4Name => 'Q4 - ELIMINIEREN';

  @override
  String get eisenhowerQ4Desc => 'Nicht dringend + Nicht wichtig';

  @override
  String eisenhowerPreVotes(Object count) {
    return '$count Vorab-Stimmen';
  }

  @override
  String get eisenhowerVotesVisibleAfterReveal =>
      'Stimmen werden sichtbar, wenn der Moderator \"Stimmen veröffentlichen\" klickt';

  @override
  String eisenhowerNextActivityError(Object error) {
    return 'Fehler beim Starten der nächsten Abstimmung: $error';
  }

  @override
  String get eisenhowerReopenVotes => 'Abstimmungen erneut öffnen';

  @override
  String get eisenhowerReopenVotesTooltip =>
      'Starten Sie die formale Abstimmung basierend auf den aktuellen Schätzungen neu';

  @override
  String get eisenhowerReopenVotesConfirm => 'Alle Abstimmungen erneut öffnen?';

  @override
  String get eisenhowerReopenVotesDesc =>
      'Dieser Vorgang startet eine neue formale Abstimmungsrunde für alle Aktivitäten, wobei die aktuellen Schätzungen als Ausgangspunkt dienen. Möchten Sie fortfahren?';

  @override
  String get estimationTitle => 'Estimation Room';

  @override
  String get estimationYourSessions => 'Ihre Sitzungen';

  @override
  String get estimationNoSessions => 'Keine Sitzungen erstellt';

  @override
  String get estimationNewSession => 'Neue Sitzung';

  @override
  String get estimationEditSession => 'Sitzung bearbeiten';

  @override
  String get estimationJoinSession => 'Sitzung beitreten';

  @override
  String get estimationSessionCode => 'Sitzungscode';

  @override
  String get estimationEnterCode => 'Code eingeben';

  @override
  String get sessionStatusDraft => 'Entwurf';

  @override
  String get sessionStatusActive => 'Aktiv';

  @override
  String get sessionStatusCompleted => 'Abgeschlossen';

  @override
  String get sessionName => 'Sitzungsname';

  @override
  String get sessionNameRequired => 'Sitzungsname *';

  @override
  String get sessionNameHint => 'Z.B.: Sprint 15 - User Stories Schätzung';

  @override
  String get sessionDescription => 'Beschreibung';

  @override
  String get sessionCardSet => 'Kartenset';

  @override
  String get cardSetFibonacci =>
      'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)';

  @override
  String get cardSetSimplified => 'Vereinfacht (1, 2, 3, 5, 8, 13, ?, ?)';

  @override
  String get sessionEstimationMode => 'Schätzmodus';

  @override
  String get sessionEstimationModeLocked =>
      'Der Modus kann nach dem Start der Abstimmung nicht mehr geändert werden';

  @override
  String get sessionAutoReveal => 'Auto-veröffentlichen';

  @override
  String get sessionAutoRevealDesc =>
      'Veröffentlichen, wenn alle abgestimmt haben';

  @override
  String get sessionAllowObservers => 'Beobachter';

  @override
  String get sessionAllowObserversDesc =>
      'Nicht-stimmberechtigte Teilnehmer erlauben';

  @override
  String get sessionConfiguration => 'Konfiguration';

  @override
  String get voteConsensus => 'Konsens erreicht!';

  @override
  String get voteResults => 'Abstimmungsergebnisse';

  @override
  String get voteRevote => 'Erneut abstimmen';

  @override
  String get voteReveal => 'Anzeigen';

  @override
  String get voteHide => 'Verbergen';

  @override
  String get voteAverage => 'Durchschnitt';

  @override
  String get voteMedian => 'Median';

  @override
  String get voteMode => 'Modalwert';

  @override
  String get voteVoters => 'Wähler';

  @override
  String get voteDistribution => 'Stimmenverteilung';

  @override
  String get voteFinalEstimate => 'Endgültige Schätzung';

  @override
  String get voteSelectFinal => 'Endgültige Schätzung wählen';

  @override
  String get voteAverageTooltip =>
      'Arithmetisches Mittel der numerischen Stimmen';

  @override
  String get voteMedianTooltip => 'Zentralwert bei sortierten Stimmen';

  @override
  String get voteModeTooltip =>
      'Häufigster Wert (der am öftesen gewählte Wert)';

  @override
  String get voteVotersTooltip =>
      'Gesamtzahl der Teilnehmer, die abgestimmt haben';

  @override
  String get voteWaiting => 'Warten auf Stimmen...';

  @override
  String get voteSubmitted => 'Stimme abgegeben';

  @override
  String get voteNotSubmitted => 'Hat nicht abgestimmt';

  @override
  String get storyToEstimate => 'Zu schätzende Story';

  @override
  String get storyTitle => 'Story-Titel';

  @override
  String get storyDescription => 'Story-Beschreibung';

  @override
  String get storyAddNew => 'Story hinzufügen';

  @override
  String get storyNoStories => 'Keine Stories zum Schätzen';

  @override
  String get retrospectivesVoted => 'Abgestimmt';

  @override
  String get storyComplete => 'Story abgeschlossen';

  @override
  String get storySkip => 'Story überspringen';

  @override
  String get estimationModeFibonacci => 'Fibonacci';

  @override
  String get estimationModeTshirt => 'T-Shirt Größen';

  @override
  String get estimationModeDecimal => 'Dezimal';

  @override
  String get estimationModeThreePoint => 'Drei-Punkt (PERT)';

  @override
  String get estimationModeDotVoting => 'Dot Voting';

  @override
  String get estimationModeBucketSystem => 'Eimer-System';

  @override
  String get estimationModeFiveFingers => 'Fünf Finger';

  @override
  String get estimationVotesRevealed => 'Stimmen veröffentlicht';

  @override
  String get estimationVotingInProgress => 'Abstimmung läuft';

  @override
  String estimationVotesCountFormatted(int count, int total) {
    return '$count/$total Stimmen';
  }

  @override
  String get estimationConsensusReached => 'Konsens erreicht!';

  @override
  String get estimationVotingResults => 'Abstimmungsergebnisse';

  @override
  String get estimationRevote => 'Erneut abstimmen';

  @override
  String get estimationAverage => 'Durchschnitt';

  @override
  String get estimationAverageTooltip =>
      'Arithmetisches Mittel der numerischen Stimmen';

  @override
  String get estimationMedian => 'Median';

  @override
  String get estimationMedianTooltip => 'Zentralwert bei sortierten Stimmen';

  @override
  String get estimationMode => 'Modalwert';

  @override
  String get estimationModeTooltip =>
      'Häufigster Wert (der am öftesten gewählte Wert)';

  @override
  String get estimationVoters => 'Wähler';

  @override
  String get estimationVotersTooltip =>
      'Gesamtzahl der Teilnehmer, die abgestimmt haben';

  @override
  String get estimationVoteDistribution => 'Stimmenverteilung';

  @override
  String get estimationSelectFinalEstimate => 'Endgültige Schätzung wählen';

  @override
  String get estimationFinalEstimate => 'Endgültige Schätzung';

  @override
  String get eisenhowerChartTitle => 'Aktivitätsverteilung';

  @override
  String get quadrantLabelDo => 'Q1 - ERLEDIGEN';

  @override
  String get quadrantLabelPlan => 'Q2 - PLANEN';

  @override
  String get quadrantLabelDelegate => 'Q3 - DELEGIEREN';

  @override
  String get quadrantLabelEliminate => 'Q4 - ELIMINIEREN';

  @override
  String get eisenhowerNoRatedActivities => 'Keine Aktivitäten abgestimmt';

  @override
  String get eisenhowerVoteToSeeChart =>
      'Stimmen Sie über Aktivitäten ab, um sie in der Grafik zu sehen';

  @override
  String get eisenhowerChartCardTitle => 'Verteilungsgrafik';

  @override
  String get eisenhowerPdfLegend => 'Aktivitäten-Legende';

  @override
  String get eisenhowerPdfRaciTitle => 'RACI-Verantwortlichkeitsmatrix';

  @override
  String get marketingPdfFeatureTitle => 'Professionelle PDF-Berichte';

  @override
  String get marketingPdfFeatureDesc =>
      'Erstellen Sie druckfertige Berichte mit Quadranten-Raster, Streudiagramm und RACI-Matrizen für Ihre Teambesprechungen.';

  @override
  String get raciAddColumnTitle => 'RACI-Spalte hinzufügen';

  @override
  String get raciColumnType => 'Typ';

  @override
  String get raciTypePerson => 'Person (Teilnehmer)';

  @override
  String get raciTypeCustom => 'Benutzerdefiniert (Team/Andere)';

  @override
  String get raciSelectParticipant => 'Teilnehmer wählen';

  @override
  String get raciColumnName => 'Spaltenname';

  @override
  String get raciColumnNameHint => 'Z.B.: Entwicklungsteam';

  @override
  String get raciDeleteColumnTitle => 'Spalte löschen';

  @override
  String raciDeleteColumnConfirm(String name) {
    return 'Möchten Sie die Spalte \'$name\' löschen? Die entsprechenden Zuweisungen gehen verloren.';
  }

  @override
  String estimationOnlineParticipants(int online, int total) {
    return '$online von $total Teilnehmern online';
  }

  @override
  String get estimationNewStoryTitle => 'Neue Story';

  @override
  String get estimationStoryTitleLabel => 'Titel *';

  @override
  String get estimationStoryTitleHint =>
      'Z.B.: US-123: Als Benutzer möchte ich...';

  @override
  String get estimationStoryDescriptionLabel => 'Beschreibung';

  @override
  String get estimationStoryDescriptionHint => 'Abnahmekriterien, Notizen...';

  @override
  String get estimationEnterTitleAlert => 'Bitte Titel eingeben';

  @override
  String get estimationParticipantsHeader => 'Teilnehmer';

  @override
  String get estimationRoleFacilitator => 'Moderator';

  @override
  String get estimationRoleVoters => 'Wähler';

  @override
  String get estimationRoleObservers => 'Beobachter';

  @override
  String get estimationYouSuffix => '(Du)';

  @override
  String get estimationDecimalTitle => 'Dezimale Schätzung';

  @override
  String get estimationDecimalHint =>
      'Geben Sie Ihre Schätzung in Tagen ein (z.B.: 1.5, 2.25)';

  @override
  String get estimationQuickSelect => 'Schnellauswahl:';

  @override
  String get estimationDaysSuffix => 'Tage';

  @override
  String estimationVoteValue(String value) {
    return 'Stimme: $value Tage';
  }

  @override
  String get estimationEnterValueAlert => 'Bitte Wert eingeben';

  @override
  String get estimationInvalidValueAlert => 'Ungültiger Wert';

  @override
  String estimationMinAlert(double value) {
    return 'Min: $value';
  }

  @override
  String estimationMaxAlert(double value) {
    return 'Max: $value';
  }

  @override
  String get retroTitle => 'Meine Retrospektiven';

  @override
  String get retroNoRetros => 'Keine Retrospektive';

  @override
  String get retroNoRetrosFound => 'Keine Retrospektive gefunden';

  @override
  String get retroCreateNew => 'Neu erstellen';

  @override
  String get retroContinueAction => 'Fortfahren';

  @override
  String get retroCurrentPhase => 'Phase';

  @override
  String get retroNoCompletedRetros => 'Keine Retrospektive abgeschlossen';

  @override
  String get retroStandalone => 'Standalone';

  @override
  String get retroCompletedOn => 'Abgeschlossen am';

  @override
  String get retroSummaryDetails => 'Details';

  @override
  String get retroSummaryCompleted => 'Abgeschlossen';

  @override
  String get retroSummaryFacilitator => 'Moderator';

  @override
  String get retroSummaryNotAvailable => 'k.A.';

  @override
  String get retroSummarySprint => 'Sprint';

  @override
  String get retroSummaryFeedback => 'Feedback';

  @override
  String get retroSummaryNoCards => 'Keine Karten';

  @override
  String get retroChooseMode => 'Retro-Modus wählen';

  @override
  String get retroQuickForm => 'Schnellformular';

  @override
  String get retroInteractiveBoard => 'Interaktives Board';

  @override
  String get retroQuickModeDesc =>
      'Füllen Sie ein schnelles Formular aus, um die Highlights des Sprints festzuhalten.';

  @override
  String get retroInteractiveModeDesc =>
      'Starten Sie ein Board in Echtzeit, um mit dem gesamten Team zusammenzuarbeiten.';

  @override
  String get retroNoOperationsReview => 'Keine Operations Review';

  @override
  String get retroOperationsReview => 'Operations Review';

  @override
  String get retroOperationsReviewDesc =>
      'Erstellen Sie eine Operations Review, um den Arbeitsfluss zu verbessern';

  @override
  String get retroWentWell => 'Was lief gut?';

  @override
  String get retroToImprove => 'Was kann verbessert werden?';

  @override
  String get retroWentWellHint => 'Einen positiven Punkt hinzufügen...';

  @override
  String get retroToImproveHint => 'Einen Verbesserungspunkt hinzufügen...';

  @override
  String get retroActionItemHint => 'Ein Action Item hinzufügen...';

  @override
  String get retroSave => 'Retrospektive speichern';

  @override
  String get agileEstimate => 'SCHÄTZUNG';

  @override
  String get agileAssign => 'Zuweisen';

  @override
  String get agileCardMenuTooltip => 'Optionen (Priorität, Schätzung, etc.)';

  @override
  String get kanbanPolicyHelpTitle => 'Spalten-Policies (Regeln)';

  @override
  String get kanbanPolicyHelpIntro =>
      'Policies sind explizite Regeln, die definieren, wann eine Karte in eine Spalte eintreten oder diese verlassen kann. Sie gewährleisten Qualität und Fluss. Aktivieren Sie diese über das \'Einstellungen\'-Symbol im Spaltenkopf.';

  @override
  String get kanbanPolicyRule1Title => '1. Erfordert Abnahmekriterien';

  @override
  String get kanbanPolicyRule1Desc =>
      'Die Karte muss mindestens ein definiertes Abnahmekriterium haben, um fortzufahren. Hilfreich, um sicherzustellen, dass die Anforderungen vor der Entwicklung klar sind.';

  @override
  String get kanbanPolicyRule2Title => '2. Schätzung abgeschlossen';

  @override
  String get kanbanPolicyRule2Desc =>
      'Die Karte muss eine Schätzung in Story Points (oder einer anderen Methode) > 0 haben. Grundlegend für die Planung und Velocity.';

  @override
  String get kanbanPolicyRule3Title => '3. Max. 2 Tage in der Spalte';

  @override
  String get kanbanPolicyRule3Desc =>
      'Signalisiert, wenn eine Karte länger als 48 Stunden im gleichen Status verbleibt. Hilft, Engpässe oder blockierte Tasks zu identifizieren.';

  @override
  String get kanbanPolicyRule4Title => '4. Alle Kriterien erfüllt';

  @override
  String get kanbanPolicyRule4Desc =>
      'Blockiert den Übergang zu \'Done\', wenn nicht alle Abnahmekriterien abgehakt sind. Gewährleistet die Definition of Done.';

  @override
  String get retroOpenInteractiveBoard => 'Interaktives Board öffnen';

  @override
  String get retroSentimentTeam => 'Team-Sentiment';

  @override
  String get retroExcellent => 'Exzellent';

  @override
  String get retroGood => 'Gut';

  @override
  String get retroNormal => 'Normal';

  @override
  String get retroNeedsImprovement => 'Verbesserungswürdig';

  @override
  String get retroCritical => 'Kritisch';

  @override
  String get retroNoElements => 'Keine Elemente';

  @override
  String get retroNoActionItemsFound => 'Keine Action Items';

  @override
  String retroAssignedTo(String email) {
    return 'Zugewiesen an: $email';
  }

  @override
  String retroVotesCount(int count) {
    return '+$count Stimmen';
  }

  @override
  String get retroGuidance => 'Leitfaden für Retrospektiven';

  @override
  String retroResultLabel(String score, String label) {
    return 'Durchschnittliches Sentiment: $score ($label)';
  }

  @override
  String get retroSearchHint => 'Retrospektive suchen...';

  @override
  String get agileProgressManual => 'Manuell';

  @override
  String get agileProgress => 'Fortschritt';

  @override
  String get agileProgressAuto => 'Automatisch';

  @override
  String agileProgressTooltipManual(int percent) {
    return 'Manuell auf $percent% gesetzt';
  }

  @override
  String agileProgressTooltipCriteria(int completed, int total) {
    return '$completed/$total Kriterien abgeschlossen';
  }

  @override
  String agileProgressTooltipStatus(String status) {
    return 'Basierend auf dem Status geschätzt: $status';
  }

  @override
  String get agileProcessTitle => 'Agile Process Manager';

  @override
  String get agileSearchProjects => 'Projekte suchen...';

  @override
  String get agileMethodologyGuide => 'Methoden-Leitfaden';

  @override
  String get agileMethodologyGuideTitle => 'Leitfaden für Agile Methoden';

  @override
  String get agileMethodologyGuideSubtitle =>
      'Wählen Sie die am besten geeignete Methode für Ihr Projekt';

  @override
  String get agileNewProject => 'Neues Projekt';

  @override
  String get agileRoles => 'ROLLEN';

  @override
  String get agileProcessFlow => 'PROZESSFLOW';

  @override
  String get agileArtifacts => 'ARTEFAKTE';

  @override
  String get agileBestPractices => 'Best Practices';

  @override
  String get agileAntiPatterns => 'Zu vermeidende Anti-Pattern';

  @override
  String get agileFAQ => 'Häufig gestellte Fragen';

  @override
  String get agileScrumShortDesc =>
      'Sprints mit fester Zeitdauer, Velocity, Burndown. Ideal für Produkte mit sich entwickelnden Anforderungen.';

  @override
  String get agileKanbanShortDesc =>
      'Kontinuierlicher Fluss, WIP-Limits, Lead Time. Ideal für Support und kontinuierliche Anfragen.';

  @override
  String get agileScrumbanShortDesc =>
      'Mischung aus Sprints und kontinuierlichem Fluss. Ideal für Teams, die Flexibilität wünschen.';

  @override
  String get agileRolePODesc => 'Verwaltet das Backlog und die Prioritäten';

  @override
  String get agileRoleSMDesc =>
      'Moderiert den Prozess und entfernt Hindernisse';

  @override
  String get agileRoleDevTeamDesc => 'Mitglieder, die das Produkt entwickeln';

  @override
  String get agileRoleStakeholdersDesc => 'Geben Feedback und Anforderungen';

  @override
  String get agileRoleSRMDesc =>
      'Verwaltet eingehende Anfragen und moderiert die Priorisierung (ersetzt den Product Owner)';

  @override
  String get agileRoleSDMDesc =>
      'Verwaltet den Arbeitsfluss und unterstützt die Lieferung (ersetzt den Scrum Master)';

  @override
  String get agileRoleTeamDesc =>
      'Führt die Arbeit unter Einhaltung der WIP-Limits aus';

  @override
  String get agileRoleFlowMasterDesc => 'Optimiert den Fluss und moderiert';

  @override
  String get agileRoleTeamHybridDesc => 'Cross-funktional, selbstorganisiert';

  @override
  String get scrumOverview =>
      'Scrum ist ein iteratives und inkrementelles Agile-Framework für das Produktentwicklungsprojektmanagement.\nEs basiert auf festen Arbeitszyklen, sogenannten Sprints, die typischerweise 2–4 Wochen dauern.\n\nScrum ist ideal für:\n• Teams, die an Produkten mit sich entwickelnden Anforderungen arbeiten\n• Projekte, die von regelmäßigem Feedback profitieren\n• Organisationen, die Vorhersehbarkeit und Transparenz verbessern möchten';

  @override
  String get scrumRolesTitle => 'Die Scrum-Rollen';

  @override
  String get scrumRolesContent =>
      'Scrum definiert drei Schlüsselrollen, die für den Erfolg des Projekts zusammenarbeiten.';

  @override
  String get scrumRolesPO =>
      'Product Owner: Vertritt die Stakeholder, verwaltet das Product Backlog und maximiert den Wert des Produkts';

  @override
  String get scrumRolesSM =>
      'Scrum Master: Unterstützt den Scrum-Prozess, beseitigt Hindernisse und hilft dem Team bei der Verbesserung';

  @override
  String get scrumRolesDev =>
      'Development Team: Ein cross-funktionales und selbstorganisiertes Team, das das Produkt-Inkrement liefert';

  @override
  String get scrumEventsTitle => 'Die Scrum-Events';

  @override
  String get scrumEventsContent =>
      'Scrum sieht regelmäßige Ereignisse vor, um Beständigkeit zu schaffen und ungeplante Meetings zu minimieren.';

  @override
  String get scrumEventsPlanning =>
      'Sprint Planning: Planung der Arbeit im Sprint (max. 8 Std. für einen 4-Wochen-Sprint)';

  @override
  String get scrumEventsDaily =>
      'Daily Scrum: Tägliche Synchronisierung des Teams (15 Minuten)';

  @override
  String get scrumEventsRetro => 'Retrospective';

  @override
  String get scrumEventsRetroContent =>
      'Erstellen Sie eine Retrospektive, um den letzten Sprint zu analysieren und Verbesserungsbereiche zu identifizieren.';

  @override
  String get scrumEventsReview =>
      'Sprint Review: Demo der fertigen Arbeit an die Stakeholder (max. 4 Std.)';

  @override
  String get scrumArtifactsTitle => 'Die Scrum-Artefakte';

  @override
  String get scrumArtifactsContent =>
      'Artefakte repräsentieren Arbeit oder Wert und sind darauf ausgelegt, Transparenz zu maximieren.';

  @override
  String get scrumArtifactsPB =>
      'Product Backlog: Geordnete Liste von allem, was im Produkt benötigt werden könnte';

  @override
  String get scrumArtifactsSB =>
      'Sprint Backlog: Für den Sprint ausgewählte Items + Plan zur Lieferung des Inkrements';

  @override
  String get scrumArtifactsIncrement =>
      'Inkrement: Summe aller während des Sprints fertiggestellten Items, potenziell auslieferbar';

  @override
  String get scrumStoryPointsTitle => 'Story Points und Velocity';

  @override
  String get scrumStoryPointsContent =>
      'Story Points sind eine relative Maßeinheit für die Komplexität von User Stories.\nSie messen nicht die Zeit, sondern den Aufwand, die Komplexität und die Unsicherheit.\n\nDie Fibonacci-Folge (1, 2, 3, 5, 8, 13, 21) wird häufig verwendet, weil:\n• Sie die zunehmende Unsicherheit bei größeren Items widerspiegelt\n• Sie falsche Präzision erschwert\n• Sie Diskussionen während der Schätzung erleichtert\n\nDie Velocity ist der Durchschnitt der in den letzten Sprints abgeschlossenen Story Points und dient dazu:\n• Vorherzusagen, wie viel Arbeit in die nächsten Sprints aufgenommen werden kann\n• Produktivitätstrends des Teams zu identifizieren\n• Teams nicht untereinander zu vergleichen (jedes Team hat seine eigene Skala)';

  @override
  String get scrumBP1 =>
      'Halten Sie die Sprints auf einer festen Dauer und respektieren Sie das Timebox';

  @override
  String get scrumBP2 =>
      'Das Product Backlog muss immer prioritisiert und verfeinert (refined) werden';

  @override
  String get scrumBP3 => 'User Stories müssen die INVEST-Kriterien erfüllen';

  @override
  String get scrumBP4 =>
      'Die Definition of Done muss klar und gemeinsam geteilt sein';

  @override
  String get scrumBP5 => 'Ändern Sie das Sprint Goal während des Sprints nicht';

  @override
  String get scrumBP6 => 'Feiern Sie Erfolge im Sprint Review';

  @override
  String get scrumBP7 =>
      'Die Retrospektive muss konkrete Verbesserungsmaßnahmen hervorbringen';

  @override
  String get scrumBP8 =>
      'Das Team muss cross-funktional und selbstorganisiert sein';

  @override
  String get scrumBP9 =>
      'Nutzen Sie die geführte Abschlussphase, um das Sprint Review vor dem Finale abzuschließen';

  @override
  String get scrumBP10 =>
      'Erstellen Sie nicht mehrere Sprints gleichzeitig in der Planung: Schließen oder löschen Sie den bestehenden, bevor Sie einen neuen erstellen';

  @override
  String get scrumAP1 => 'Sprint ohne klares Sprint Goal';

  @override
  String get scrumAP2 => 'Daily Scrum zum Statusbericht-Meeting umfunktioniert';

  @override
  String get scrumAP3 =>
      'Retrospektive auslassen, wenn man \"zu beschäftigt\" ist';

  @override
  String get scrumAP4 => 'Product Owner abwesend oder nicht verfügbar';

  @override
  String get scrumAP5 =>
      'Arbeit während des Sprints hinzufügen, ohne anderes zu entfernen';

  @override
  String get scrumAP6 =>
      'Story Points in Stunden umrechnen (verliert den Sinn)';

  @override
  String get scrumAP7 => 'Team zu groß (ideal 5–9 Personen)';

  @override
  String get scrumAP8 => 'Scrum Master, der dem Team Aufgaben \"zuweist\"';

  @override
  String get scrumAP9 =>
      'Sprint beenden ohne Sprint Review und ohne Entscheidung über unvollständige Stories';

  @override
  String get scrumSprintClosingTitle => 'Geführter Sprint-Abschluss';

  @override
  String get scrumSprintClosingContent =>
      'Der Sprint-Abschlussprozess folgt einem 2-Phasen-Modell gemäß Scrum Guide 2020:\n\n1. **Sprint Review**: Qualitative Phase. Stakeholder inspizieren das Inkrement. Jede Story wird als \'Genehmigt\' (als Done markiert) oder \'Verfeinerungsbedürftig\' (zurück ins Backlog für zukünftige Bearbeitung) bewertet. Hinweis: Stories, die während der Review-Phase ins Backlog verschoben werden (z.B. nach \'To Do\'), sind nicht in der Review enthalten – sie stehen für das nächste Sprint Planning zur Verfügung.\n\n2. **Sprint-Finalisierung**: Administrative Phase. Das Team entscheidet über den Verbleib unvollständiger Arbeit: Rückkehr ins Backlog (für zukünftige Planung), Verschieben nach Ready (wenn sofort bearbeitbar) oder Verschieben zum Refinement (wenn Analyse erforderlich).';

  @override
  String get scrumFAQ1Q => 'Wie lange sollte ein Sprint dauern?';

  @override
  String get scrumFAQ1A =>
      'Die typische Dauer beträgt 2 Wochen, kann aber zwischen 1 und 4 Wochen variieren. Kürzere Sprints ermöglichen häufigeres Feedback und schnellere Kurskorrekturen. Längere Sprints bieten mehr Zeit für komplexe Aufgaben. Wichtig ist, die Dauer konstant zu halten.';

  @override
  String get scrumFAQ2Q =>
      'Wie geht man mit unvollständiger Arbeit am Sprint-Ende um?';

  @override
  String get scrumFAQ2A =>
      'Unvollständige User Stories kehren in das Product Backlog zurück und werden neu prioritisiert. Verlängern Sie niemals den Sprint oder reduzieren Sie die Definition of Done. Nutzen Sie die Retrospektive, um zu verstehen, warum dies passiert ist und wie es verhindert werden kann.';

  @override
  String get scrumFAQ3Q =>
      'Kann ich das Sprint Backlog während des Sprints ändern?';

  @override
  String get scrumFAQ3A =>
      'Das Sprint Goal sollte sich nicht ändern, aber das Sprint Backlog kann sich weiterentwickeln. Das Team kann mit dem PO über den Austausch von gleichwertigen Items verhandeln. Wenn das Sprint Goal hinfällig wird, kann der PO den Sprint abbrechen.';

  @override
  String get scrumFAQ4Q => 'Wie berechnet man die anfängliche Velocity?';

  @override
  String get scrumFAQ4A =>
      'Treffen Sie für die ersten 3 Sprints konservative Schätzungen. Nach 3 Sprints haben Sie eine verlässliche Velocity. Nutzen Sie die Velocity anderer Teams nicht als Referenz.';

  @override
  String get kanbanOverview =>
      'Kanban ist eine Methode zur Verwaltung von Arbeit, die die Visualisierung des Flusses,\ndie Begrenzung des Work In Progress (WIP) und die kontinuierliche Verbesserung des Prozesses betont.\n\nKanban ist ideal für:\n• Support-/Wartungsteams mit kontinuierlichen Anfragen\n• Umgebungen mit häufig wechselnden Prioritäten\n• Wenn eine Planung in festen Iterationen nicht möglich ist\n• Schrittweiser Übergang zu Agile';

  @override
  String get kanbanPrinciplesTitle => 'Die Kanban-Prinzipien';

  @override
  String get kanbanPrinciplesContent =>
      'Kanban basiert auf Prinzipien des inkrementellen Wandels und des Respekts vor bestehenden Rollen.';

  @override
  String get kanbanPrinciple1 =>
      'Visualisieren Sie den Workflow: Machen Sie die gesamte Arbeit sichtbar';

  @override
  String get agileItems => 'Items';

  @override
  String get agileItemsShort => 'Elemente';

  @override
  String get agileWorkloadAvgItems => 'Durchschnittl. Elemente/Person';

  @override
  String get agileKanbanCapacityNote =>
      'Die Kapazität wird auf wöchentlicher Basis (5 Arbeitstage) berechnet.';

  @override
  String get agilePriority => 'Priorität';

  @override
  String get agileRoleSRM => 'Service Request Manager';

  @override
  String get agileRoleSDM => 'Service Delivery Manager';

  @override
  String get agileRoleTeamMember => 'Teammitglied';

  @override
  String get agileFrameworkLocked =>
      'Framework-Wechsel für Projekte mit bestehenden Aktivitäten nicht möglich';

  @override
  String get agileComingSoon => 'Demnächst verfügbar';

  @override
  String get kanbanPrinciple2 =>
      'WIP begrenzen: Arbeit abschließen, bevor neue begonnen wird';

  @override
  String get kanbanPrinciple3 =>
      'Fluss verwalten: Für maximalen Durchsatz optimieren';

  @override
  String get kanbanPrinciple4 =>
      'Policies explizit machen: Klare Regeln definieren';

  @override
  String get kanbanPrinciple5 =>
      'Feedback-Schleifen implementieren: Kontinuierlich verbessern';

  @override
  String get kanbanPrinciple6 =>
      'Kollaborativ verbessern: Durch Experimentieren weiterentwickeln';

  @override
  String get kanbanBoardTitle => 'Kanban Board';

  @override
  String get kanbanBoardContent =>
      'Das Board visualisiert den Arbeitsfluss durch seine Phasen.\nJede Spalte repräsentiert einen Arbeitsstatus (z.B. To Do, In Progress, Done).\n\nSchlüsselelemente des Boards:\n• Spalten: Workflow-Status\n• Karten/Tickets: Arbeitseinheiten\n• WIP-Limits: Grenzen pro Spalte\n• Swimlanes: Horizontale Gruppierungen (optional)';

  @override
  String get kanbanWIPTitle => 'WIP-Limits';

  @override
  String get kanbanWIPContent =>
      'Limits für Work In Progress (WIP) sind das Herzstück von Kanban.\nBegrenzung des WIP:\n\n• Reduziert Context Switching\n• Macht Engpässe sichtbar\n• Beschleunigt den Durchsatz\n• Verbessert die Qualität (weniger Fehler durch Multitasking)\n• Erhöht die Vorhersehbarkeit\n\nSo setzen Sie WIP-Limits:\n• Beginnen Sie mit (Anzahl Teammitglieder × 2) pro Spalte\n• Beobachten Sie den Fluss und passen Sie an\n• Das \"richtige\" Limit erzeugt eine leichte Spannung';

  @override
  String get kanbanMetricsTitle => 'Kanban-Metriken';

  @override
  String get kanbanMetricsContent =>
      'Kanban verwendet Flussmetriken, um den Prozess zu messen und zu verbessern.';

  @override
  String get kanbanMetric1 =>
      'Lead Time: Zeit von der Anfrage bis zum Abschluss (inkl. Wartezeit)';

  @override
  String get kanbanMetric2 =>
      'Cycle Time: Zeit vom Arbeitsbeginn bis zum Abschluss';

  @override
  String get kanbanMetric3 =>
      'Throughput: Abgeschlossene Items pro Zeiteinheit';

  @override
  String get kanbanMetric4 =>
      'WIP: Menge der laufenden Arbeit zu jedem Zeitpunkt';

  @override
  String get kanbanMetric5 =>
      'Cumulative Flow Diagram (CFD): Visualisiert die Arbeitsanhäufung über die Zeit';

  @override
  String get kanbanCadencesTitle => 'Kanban-Taktungen';

  @override
  String get kanbanCadencesContent =>
      'Anders als Scrum schreibt Kanban keine festen Events vor.\nRegelmäßige Taktungen unterstützen jedoch die kontinuierliche Verbesserung:\n\n• Standup Meeting: Tägliche Synchronisierung vor dem Board\n• Replenishment Meeting: Backlog-Priorisierung\n• Delivery Planning: Release-Planung\n• Service Delivery Review: Metriken-Review\n• Risk Review: Risiko- und Hindernis-Analyse\n• Operations Review: Prozessverbesserung';

  @override
  String get kanbanSwimlanesTitle => 'Swimlanes';

  @override
  String get kanbanSwimlanesContent =>
      'Swimlanes sind horizontale Zeilen, die Karten auf dem Board nach einem gemeinsamen Attribut gruppieren.\n\nVerfügbare Swimlane-Typen:\n• Serviceklasse: Gruppiert nach Priorität/Dringlichkeit der Arbeit\n• Zuständiger: Gruppiert nach zugewiesenem Teammitglied\n• Priorität: Gruppiert nach MoSCoW-Level\n• Tag: Gruppiert nach Story-Tags\n\nSwimlanes helfen dabei:\n• Die Arbeitslast pro Person zu visualisieren\n• Verschiedene Serviceklassen zu verwalten (dringend, Standard)\n• Engpässe für bestimmte Arbeitsarten zu identifizieren';

  @override
  String kanbanPoliciesTitle(String columnName) {
    return 'Policy: $columnName';
  }

  @override
  String get kanbanPoliciesContent =>
      'Die 4. Kanban-Praxis: \'Make Policies Explicit\' erfordert klare Regeln für jede Spalte.\n\nBeispiele für Policies:\n• \'Max. 24h in dieser Spalte\' – Zeitlimit\n• \'Erfordert genehmigte Code-Review\' – Ausgangskriterien\n• \'Max. 1 Item pro Person\' – individuelles Limit\n• \'Tägliches Update obligatorisch\' – Kommunikation\n\nPolicies:\n• Machen Erwartungen für alle transparent\n• Reduzieren Unklarheiten und Konflikte\n• Erleichtern das Onboarding neuer Mitglieder\n• Ermöglichen zu erkennen, wann Regeln verletzt werden';

  @override
  String get kanbanBP1 =>
      'Visualisieren Sie die GESAMTE Arbeit, auch die versteckte';

  @override
  String get kanbanBP2 => 'Respektieren Sie die WIP-Limits strikt';

  @override
  String get kanbanBP3 => 'Fokus auf Abschließen, nicht auf Beginnen';

  @override
  String get kanbanBP4 =>
      'Nutzen Sie Metriken für Entscheidungen, nicht zur Verurteilung von Personen';

  @override
  String get kanbanBP5 => 'Verbessern Sie Schritt für Schritt';

  @override
  String get kanbanBP6 =>
      'Blockieren Sie neue Arbeit, wenn das WIP-Limit erreicht ist';

  @override
  String velocityTooltipAverage(int count) {
    return 'Basierend auf allen $count abgeschlossenen Sprints';
  }

  @override
  String get kanbanBP7 => 'Blöcke analysieren und schnell entfernen';

  @override
  String get kanbanBP8 => 'Swimlanes für Prioritäten oder Arbeitsarten nutzen';

  @override
  String get kanbanAP1 => 'WIP-Limits zu hoch (oder nicht vorhanden)';

  @override
  String get kanbanAP2 => 'Blöcke auf dem Board ignorieren';

  @override
  String get kanbanAP3 => 'Limits missachten, wenn es \"dringend\" ist';

  @override
  String get kanbanAP4 => 'Spalten zu generisch (z.B. nur To Do/Done)';

  @override
  String get kanbanAP5 =>
      'Eintritts-/Austrittszeiten der Items nicht verfolgen';

  @override
  String get kanbanAP6 => 'Kanban nur als Taskboard ohne Prinzipien nutzen';

  @override
  String get kanbanAP7 => 'Cumulative Flow Diagram nie analysieren';

  @override
  String get kanbanAP8 => 'Zu viele Swimlanes, die die Ansicht komplizieren';

  @override
  String get kanbanFAQ1Q => 'Wie geht man mit Urgenzen in Kanban um?';

  @override
  String get kanbanFAQ1A =>
      'Erstellen Sie eine \"Expedite\"-Swimlane mit einem WIP-Limit von 1. Expedite-Items überspringen die Warteschlange, sollten aber selten sein. Wenn alles dringend ist, ist nichts dringend.';

  @override
  String get kanbanFAQ2Q => 'Funktioniert Kanban für die Softwareentwicklung?';

  @override
  String get kanbanFAQ2A =>
      'Absolut ja. Kanban entstand bei Toyota, wird aber weltweit in der Softwareentwicklung eingesetzt. Es ist besonders geeignet für Wartungsteams, DevOps und Support.';

  @override
  String get kanbanFAQ3Q => 'Wie setze ich die anfänglichen WIP-Limits?';

  @override
  String get kanbanFAQ3A =>
      'Startformel: (Teammitglieder + 1) pro Spalte. Beobachten Sie für 2 Wochen und reduzieren Sie allmählich, bis eine leichte Spannung entsteht. Das optimale Limit variiert für jedes Team und jeden Kontext.';

  @override
  String get kanbanFAQ4Q =>
      'Wie lange dauert es, bis man Ergebnisse mit Kanban sieht?';

  @override
  String get kanbanFAQ4A =>
      'Die ersten Verbesserungen (Sichtbarkeit) sind sofort da. Eine Reduzierung der Lead Time sieht man in 2-4 Wochen. Signifikante Prozessverbesserungen erfordern 2-3 Monate.';

  @override
  String get hybridOverview =>
      'Scrumban kombiniert Elemente von Scrum und Kanban, um einen flexiblen Ansatz zu schaffen, der sich dem Kontext des Teams anpasst. Es behält die Struktur der Sprints mit der Flexibilität des kontinuierlichen Flusses und WIP-Limits bei.\n\nScrumban ist ideal für:\n• Teams, die von Scrum zu Kanban (oder umgekehrt) wechseln möchten\n• Projekte mit einem Mix aus Feature-Entwicklung und Wartung\n• Teams, die Sprints wollen, aber mehr Flexibilität benötigen\n• Wenn \"reines\" Scrum zu starr für den Kontext ist';

  @override
  String get hybridFromScrumTitle => 'Von Scrum: Struktur';

  @override
  String get hybridFromScrumContent =>
      'Scrumban behält einige strukturierte Elemente von Scrum für Vorhersehbarkeit bei.';

  @override
  String get hybridFromScrum1 =>
      'Sprint (optional): Iterationen mit fester Zeit für Taktung';

  @override
  String get hybridFromScrum2 =>
      'Sprint Planning: Auswahl der Arbeit für den Zeitraum';

  @override
  String get hybridFromScrum3 => 'Retrospektive: Reflexion und Verbesserung';

  @override
  String get hybridFromScrum4 => 'Demo/Review: Teilen des produzierten Wertes';

  @override
  String get hybridFromScrum5 =>
      'Story Points: Für Schätzungen und Prognosen (optional)';

  @override
  String get hybridFromKanbanTitle => 'Von Kanban: Fluss';

  @override
  String get hybridFromKanbanContent =>
      'Scrumban übernimmt Fluss-Prinzipien von Kanban für Effizienz.';

  @override
  String get hybridFromKanban1 => 'WIP-Limits: Begrenzung der laufenden Arbeit';

  @override
  String get hybridFromKanban2 =>
      'Pull-System: Das Team \"zieht\" Arbeit, wenn es Kapazität hat';

  @override
  String get hybridFromKanban3 =>
      'Visualisierung: Gemeinsames und transparentes Board';

  @override
  String get hybridFromKanban4 =>
      'Flussmetriken: Lead Time, Cycle Time, Throughput';

  @override
  String get hybridFromKanban5 =>
      'Kontinuierliche Verbesserung: Explizite Policies und Experimentieren';

  @override
  String get hybridOnDemandTitle => 'Planning auf Anfrage';

  @override
  String get hybridOnDemandContent =>
      'In Scrumban kann die Planung \"on-demand\" statt in festen Intervallen erfolgen.\n\nDie Planung wird aktiviert, wenn:\n• Das \"Ready\"-Backlog unter einen Schwellenwert fällt\n• Neue dringende Anfragen prioritisiert werden müssen\n• Ein Meilenstein näher rückt\n\nDies reduziert unnötige Planungssitzungen und ermöglicht schnellere Reaktionen auf Änderungen.';

  @override
  String get hybridWhenTitle => 'Wann was nutzen';

  @override
  String get hybridWhenContent =>
      'Scrumban bedeutet nicht, \"alles zu machen\". Es bedeutet, die richtigen Elemente für den Kontext zu wählen.\n\nNutzen Sie Scrum-Elemente, wenn:\n• Vorhersehbarkeit bei den Lieferungen benötigt wird\n• Stakeholder regelmäßige Demos wünschen\n• Das Team von einem festen Rhythmus profitiert\n\nNutzen Sie Kanban-Elemente, wenn:\n• Die Arbeit unvorhersehbar ist (Support, Bugfixing)\n• Reaktionsfähigkeit auf Urgenzen nötig ist\n• Der Fokus auf kontinuierlichem Durchsatz liegt';

  @override
  String get hybridBP1 =>
      'Starten Sie mit dem, was Sie kennen, und fügen Sie Elemente schrittweise hinzu';

  @override
  String get hybridBP2 =>
      'Die WIP-Limits sind nicht verhandelbar, auch mit Sprints';

  @override
  String get hybridBP3 =>
      'Nutzen Sie Sprints für Taktung, nicht als starres Commitment';

  @override
  String get hybridBP4 =>
      'Behalten Sie die Retrospektive bei, sie ist der Motor der Verbesserung';

  @override
  String get hybridBP5 => 'Flussmetriken helfen mehr als reine Velocity';

  @override
  String get hybridBP6 => 'Experimentieren Sie mit einer Sache gleichzeitig';

  @override
  String get hybridBP7 =>
      'Dokumentieren Sie die Team-Policies und überprüfen Sie diese regelmäßig';

  @override
  String get hybridBP8 =>
      'Erwägen Sie Swimlanes, um Features von Wartung zu trennen';

  @override
  String get hybridAP1 =>
      'Das Schlechteste von beidem nehmen (Scrum-Starrheit + Kanban-Chaos)';

  @override
  String get hybridAP2 => 'Retrospektiven streichen, weil man \"flexibel\" ist';

  @override
  String get hybridAP3 => 'WIP-Limits ignorieren, weil man \"Sprints hat\"';

  @override
  String get hybridAP4 => 'Framework bei jedem Sprint wechseln';

  @override
  String get hybridAP5 =>
      'Überhaupt keine Taktung haben (keine Sprints, nichts)';

  @override
  String get hybridAP6 => 'Flexibilität mit Regellosigkeit verwechseln';

  @override
  String get hybridAP7 => 'Nichts messen';

  @override
  String get hybridAP8 => 'Zu viel Komplexität für den Kontext';

  @override
  String get hybridFAQ1Q => 'Hat Scrumban Sprints oder nicht?';

  @override
  String get hybridFAQ1A =>
      'Das hängt vom Team ab. Sie können Sprints für Taktungen haben (Review, Planning), aber kontinuierlichen Arbeitsfluss innerhalb des Sprints erlauben. Oder Sie streichen die Sprints und haben nur Kanban-Taktungen.';

  @override
  String get hybridFAQ2Q => 'Wie messe ich die Performance in Scrumban?';

  @override
  String get hybridFAQ2A =>
      'Nutzen Sie sowohl Scrum-Metriken (Velocity, wenn Sie Sprints und Story Points nutzen) als auch Kanban-Metriken (Lead Time, Cycle Time, Throughput). Flussmetriken sind oft nützlicher für Verbesserungen.';

  @override
  String get hybridFAQ3Q => 'Wo fange ich mit Scrumban an?';

  @override
  String get hybridFAQ3A =>
      'Wenn Sie von Scrum kommen: Fügen Sie WIP-Limits hinzu und visualisieren Sie den Fluss. Wenn Sie von Kanban kommen: Fügen Sie regelmäßige Taktungen für Review und Planning hinzu. Starten Sie mit dem, was das Team kennt.';

  @override
  String get hybridFAQ4Q => 'Ist Scrumban \"weniger Agile\" als reines Scrum?';

  @override
  String get hybridFAQ4A =>
      'Nein. Agile bedeutet nicht, einem spezifischen Framework zu folgen. Scrumban kann agiler sein, weil es sich dem Kontext anpasst. Wichtig ist, kontinuierlich zu prüfen und anzupassen.';

  @override
  String get retroNoResults => 'Keine Ergebnisse für die Suche';

  @override
  String get agileNoAssignee => 'Nicht zugewiesen';

  @override
  String get retroFilterAll => 'Alle';

  @override
  String get retroFilterActive => 'Aktiv';

  @override
  String get retroFilterCompleted => 'Abgeschlossen';

  @override
  String get retroFilterDraft => 'Entwurf';

  @override
  String get retroDeleteTitle => 'Retrospektive löschen';

  @override
  String retroDeleteConfirm(String title) {
    return 'Sind Sie sicher?';
  }

  @override
  String get retroDeleteSuccess => 'Retrospektive erfolgreich gelöscht';

  @override
  String retroDeleteError(String error) {
    return 'Fehler beim Löschen: $error';
  }

  @override
  String get retroDeleteConfirmAction => 'Endgültig löschen';

  @override
  String get retroNewRetroTitle => 'Neue Retrospektive';

  @override
  String get retroLinkToSprint => 'Mit Sprint verlinken?';

  @override
  String get retroNoProjectFound => 'Kein Projekt gefunden.';

  @override
  String get retroSelectProject => 'Projekt wählen';

  @override
  String get retroSelectSprint => 'Sprint wählen';

  @override
  String retroSprintLabel(int number, String name) {
    return 'Sprint $number: $name';
  }

  @override
  String retroSprintOnlyLabel(int number) {
    return 'Sprint $number';
  }

  @override
  String get retroOwner => 'Besitzer';

  @override
  String get retroGuest => 'Gast';

  @override
  String get retroSessionTitle => 'Sitzungstitel';

  @override
  String get retroSessionTitleHint => 'Z.B.: Weekly Sync, Project Review...';

  @override
  String get retroTemplateLabel => 'Template';

  @override
  String get retroVotesPerUser => 'Stimmen pro Benutzer:';

  @override
  String get retroActionClose => 'Schließen';

  @override
  String get retroActionCreate => 'Erstellen';

  @override
  String get retroStatusDraft => 'Entwurf';

  @override
  String get retroStatusActive => 'In Arbeit';

  @override
  String get agileBurndownInfoTitle => 'Wie man das Burndown Chart liest';

  @override
  String get agileBurndownInfoIdeal =>
      'Die **Ideale** Linie (gestrichelt) zeigt den Ziel-Fortschritt bei gleichmäßiger Erledigung.';

  @override
  String get agileBurndownInfoActual =>
      'Die **Effektive** Linie (durchgezogen) zeigt die verbleibende Arbeit an. Abgeschlossene Stories senken diese Linie.';

  @override
  String get agileBurndownInfoGoal =>
      'Ihr Ziel ist es, die effektive Linie unter der idealen Linie zu halten, um rechtzeitig fertig zu werden.';

  @override
  String get guideToolsTitle => 'Tools & Integrationen';

  @override
  String get guideJiraContent =>
      'Integration mit Jira für synchrones Arbeiten.\n\nFeatures:\n• **Import**: Jira-Stories erscheinen hier.\n• **Link**: Klick auf ID öffnet Jira.\n• **Sync**: Bidirektionale Status-Updates.';

  @override
  String get guideWorkflowTitle => 'Workflow & Qualität';

  @override
  String get guideAcceptanceCriteriaContent =>
      'Um Qualität zu gewährleisten, muss jede Story klare Abnahmekriterien haben.\n\n• **Schnell hinzufügen**: Kriterien direkt im Story-Detail hinzufügen.\n• **Prüfung**: Kriterien abhaken, sobald sie erfüllt sind.\n• **Definition of Done**: Eine Story ist erst \'Done\', wenn alle Kriterien erfüllt sind.';

  @override
  String get scrumWorkflowStatusContent =>
      'In Scrum folgt der Lebenszyklus einer Story diesen Zuständen:\n\n**Product Backlog** (nur im Backlog-Tab sichtbar):\n1. **Backlog**: Wo Ideen geboren werden. Die Story wurde noch nicht analysiert.\n2. **Refinement**: Die Story wird analysiert/detailliert. Eine kollaborative Aktivität des gesamten Teams (Arbeit an der Definition of Ready).\n3. **Ready**: Die Story erfüllt die DoR und kann beim Sprint Planning gewählt werden. Nur der PO kann eine Story als Ready markieren.\n\n**Sprint Board** (während des Sprints auf dem Board sichtbar):\n4. **Zu erledigen**: \'Ready\' Stories, die dem Sprint hinzugefügt wurden.\n5. **In Arbeit**: Aktive Arbeit des Teams.\n6. **In Revision**: Revision/Code Review.\n7. **Erledigt**: Story abgeschlossen und verifiziert.';

  @override
  String get kanbanWorkflowStatusContent =>
      'In Kanban ist der Fluss kontinuierlich:\n\n1. **Refinement**: Spezielle Spalte zur Analyse eingehender Anfragen.\n2. **Ready**: Warteschlangen für fertige Arbeit (Pull-System).\n3. **Active Board**: Stories fließen durch die Arbeitsspalten.\n4. **WIP-Limits**: Jede Spalte hat ein Limit zur Vermeidung von Engpässen.';

  @override
  String get hybridWorkflowStatusContent =>
      'Scrumban nutzt einen hybriden Ansatz:\n\n• Sprints für Planung nutzen, aber täglichen Fluss wie Kanban verwalten.\n• \'Ready\' Stories können gezogen (Pull) werden, wenn Kapazität da ist, unabhängig vom Sprint Planning, falls das Team dies bevorzugt.';

  @override
  String get contextualHelpButton => 'Hilfe';

  @override
  String get contextualHelpTips => 'Tipps';

  @override
  String get contextualHelpBacklogTitle => 'Product Backlog';

  @override
  String get contextualHelpBacklogDesc =>
      'Das Backlog ist die prioritisierte Liste aller Arbeiten. Stories oben sind am wichtigsten.';

  @override
  String get contextualHelpBacklogTip1 =>
      'Halten Sie das Backlog nach Prioritäten sortiert';

  @override
  String get contextualHelpBacklogTip2 =>
      'Arbeiten Sie mit dem Team im Refinement an den Details';

  @override
  String get contextualHelpBacklogTip3 =>
      'Eine Story ist \'Ready\', wenn sie die Definition of Ready erfüllt';

  @override
  String get contextualHelpSprintTitle => 'Sprint';

  @override
  String get contextualHelpSprintDesc =>
      'Der Sprint ist ein Zeitraum (1-4 Wochen), in dem das Team an den gewählten Stories arbeitet.';

  @override
  String get contextualHelpSprintTip1 =>
      'Ändern Sie den Scope während des Sprints nicht';

  @override
  String get contextualHelpSprintTip2 =>
      'Monitorieren Sie das Burndown für den Fortschritt';

  @override
  String get contextualHelpSprintTip3 =>
      'Nutzen Sie Daily Standups zur Abstimmung';

  @override
  String get contextualHelpSprintTip4 =>
      'Am Ende den \'Geführten Sprint-Abschluss\' für Review und Story-Verbleib nutzen';

  @override
  String get contextualHelpKanbanTitle => 'Kanban Board';

  @override
  String get contextualHelpKanbanDescFlow =>
      'Das Kanban Board visualisiert den Arbeitsfluss. Items bewegen sich von links nach rechts durch die Spalten.';

  @override
  String get contextualHelpKanbanDescScrum =>
      'In Scrum zeigt das Board den Status der Stories des aktuellen Sprints.';

  @override
  String get contextualHelpKanbanTip1 =>
      'WIP-Limits respektieren, um Engpässe zu vermeiden';

  @override
  String get contextualHelpKanbanTip2 =>
      'Neue Arbeit nur ziehen (Pull), wenn Kapazität da ist';

  @override
  String get contextualHelpKanbanTip3 =>
      'Alter der Items monitorieren, um Blocker zu identifizieren';

  @override
  String get contextualHelpKanbanTipScrum1 =>
      'Karten von links nach rechts bewegen';

  @override
  String get contextualHelpKanbanTipScrum2 =>
      'Eine Story abschließen, bevor eine neue begonnen wird';

  @override
  String get contextualHelpTeamTitle => 'Team';

  @override
  String get contextualHelpTeamDesc =>
      'Mentre verwalten Sie Teammitglieder, Rollen und Kompetenzen.';

  @override
  String get contextualHelpTeamTip1 =>
      'Klare Rollen für jedes Mitglied zuweisen';

  @override
  String get contextualHelpTeamTip2 =>
      'Arbeitslast zwischen Mitgliedern ausbalancieren';

  @override
  String get contextualHelpMetricsTitle => 'Metriken';

  @override
  String get contextualHelpMetricsDescScrum =>
      'Velocity, Burndown und Schätzgenauigkeit monitorieren.';

  @override
  String get contextualHelpMetricsDescKanban =>
      'Lead Time, Cycle Time und Throughput monitorieren.';

  @override
  String get contextualHelpMetricsDescHybrid =>
      'Scrum- und Kanban-Metriken kombinieren.';

  @override
  String get contextualHelpMetricsTipScrum1 =>
      'Durchschnitts-Velocity für Zukunftsplanung nutzen';

  @override
  String get contextualHelpMetricsTipScrum2 =>
      'Schätzungen analysieren, um Präzision zu verbessern';

  @override
  String get contextualHelpMetricsTipKanban1 =>
      'Lead Time reduzieren für schnellere Wertlieferung';

  @override
  String get contextualHelpMetricsTipKanban2 =>
      'Wöchentlichen Durchsatz für Vorhersehbarkeit prüfen';

  @override
  String get contextualHelpMetricsTipKanban3 =>
      'Alter der Items für Blocker-Identifikation nutzen';

  @override
  String get contextualHelpMetricsTipHybrid1 =>
      'Velocity und Flow-Metriken ausbalancieren';

  @override
  String get contextualHelpMetricsTipHybrid2 =>
      'Metriken an die eigene Arbeitsweise anpassen';

  @override
  String get contextualHelpRetroTitle => 'Retrospektive';

  @override
  String get contextualHelpRetroDescScrum =>
      'Die Retrospektive ist ein Motor für kontinuierliche Verbesserung durch 4 Bereiche.';

  @override
  String get contextualHelpRetroDescKanban =>
      'In Kanban (Operations Review) Fokus auf Flussanalyse und Engpässe.';

  @override
  String get contextualHelpRetroTabActiveTitle => 'Tab Aktiv: Kern-Sitzung';

  @override
  String get contextualHelpRetroTabActive =>
      'Brainsstorms verwalten. In \'Writing\' sind Karten verdeckt (Anchoring Bias vermeiden). \'Carry Forward\' nutzen für ungelöste Punkte.';

  @override
  String get contextualHelpRetroTabHistoryTitle => 'Tab Historie: Trends';

  @override
  String get contextualHelpRetroTabHistory =>
      'Abgeschlossene Sitzungen via Trends analysieren. Sentiment vs. Abschlussrate prüfen.';

  @override
  String get contextualHelpRetroTabActionItemsTitle => 'Action Items Tracker';

  @override
  String get contextualHelpRetroTabActionItems =>
      'Strategische Ausführung. SMART-Kriterien nutzen. Filter für überfällige Items nutzen.';

  @override
  String get contextualHelpRetroTabLessonsLearnedTitle =>
      'Lessons Learned Register';

  @override
  String get contextualHelpRetroTabLessonsLearned =>
      'Repository für institutionelles Wissen (strategisch). Import aus anderen Projekten möglich.';

  @override
  String get contextualHelpRetroIntegrationTitle => 'Der Verbesserungszyklus';

  @override
  String get contextualHelpRetroIntegration =>
      'Board-Karten werden zu Action Items destilliert, die in die Historie fließen und als Lessons Learned formalisiert werden.';

  @override
  String get contextualHelpRetroModeQuickTitle =>
      'Quick Form vs Interaktives Board';

  @override
  String get contextualHelpRetroModeQuick =>
      'Quick Form für schnelle Highlights durch eine Person. Füllt Historie direkt ohne Echtzeit-Zusammenarbeit.';

  @override
  String get contextualHelpRetroModeInteractiveTitle => 'Interaktive Sitzung';

  @override
  String get contextualHelpRetroModeInteractive =>
      'Icebreaker, Brainstorming, Gruppierung, Votierung. Alle Stimmen werden gehört, Bias wird reduziert.';

  @override
  String get contextualHelpRetroTip1 =>
      'Klaren Besitzer und Deadline für jedes Action Item zuweisen';

  @override
  String get contextualHelpRetroTip2 =>
      'Stärken im Lessons Learned Register feiern';

  @override
  String get contextualHelpRetroTip3 =>
      'Quick Form zur Digitalisierung physischer Workshops nutzen';

  @override
  String get retroStatusCompleted => 'Abgeschlossen';

  @override
  String get profileIntegrations => 'Integrationen';

  @override
  String get profileJiraIntegration => 'Jira-Integrierung';

  @override
  String get profileJiraIntegrationDesc =>
      'Verbinden, um Stories zu importieren';

  @override
  String get jiraDomain => 'Jira Domain';

  @override
  String get jiraEmail => 'Atlassian Email';

  @override
  String get jiraApiToken => 'API Token';

  @override
  String get jiraConnect => 'Verbinden';

  @override
  String get jiraDisconnect => 'Trennen';

  @override
  String get jiraSettingsSaved => 'Einstellungen gespeichert';

  @override
  String get jiraSettingsCleared => 'Einstellungen gelöscht';

  @override
  String get retroTemplateStartStopContinue => 'Start, Stop, Continue';

  @override
  String get retroTemplateSailboat => 'Segelboot';

  @override
  String get retroTemplate4Ls => '4 Ls';

  @override
  String get retroTemplateStarfish => 'Seestern';

  @override
  String get retroTemplateMadSadGlad => 'Mad Sad Glad';

  @override
  String get retroTemplateDAKI => 'DAKI (Drop Add Keep Improve)';

  @override
  String get retroDescStartStopContinue =>
      'Aktionsorientiert: Starten, Aufhören, Weitermachen.';

  @override
  String get retroDescSailboat => 'Visuell: Wind, Anker, Felsen, Insel.';

  @override
  String get retroDesc4Ls => 'Liked, Learned, Lacked, Longed For.';

  @override
  String get retroDescStarfish => 'Keep, Stop, Start, More, Less.';

  @override
  String get retroDescMadSadGlad => 'Emotional: Wütend, Traurig, Glücklich.';

  @override
  String get retroDescDAKI =>
      'Pragmatisch: Streichen, Hinzufügen, Behalten, Verbessern.';

  @override
  String get retroUsageStartStopContinue =>
      'Ideal für aktionierbares Feedback.';

  @override
  String get retroUsageSailboat =>
      'Ideal für Ziele und Risiken (kreatives Denken).';

  @override
  String get retroUsage4Ls => 'Reflektierend: Aus der Vergangenheit lernen.';

  @override
  String get retroUsageStarfish =>
      'Kalibrierung: Aufwand skalieren (mehr/weniger).';

  @override
  String get retroUsageMadSadGlad =>
      'Emotionaler Check-in, nach stressigen Sprints.';

  @override
  String get retroUsageDAKI =>
      'Entscheidungsfreudig: Fokus auf Streichen/Hinzufügen.';

  @override
  String get retroTemplateCustom => 'Personalizzato';

  @override
  String get retroDescCustom =>
      'Definisci le tue colonne in base alle esigenze del team.';

  @override
  String get retroUsageCustom =>
      'Ideale quando i template standard non si adattano alle esigenze specifiche del team.';

  @override
  String get collectionRationaleCustom =>
      'Rivedi ogni colonna personalizzata e crea azioni in base alle priorità del team.';

  @override
  String get retroCustomAddColumn => 'Aggiungi Colonna';

  @override
  String get retroCustomRemoveColumn => 'Rimuovi';

  @override
  String get retroCustomColumnTitle => 'Titolo Colonna';

  @override
  String get retroCustomColumnDesc => 'Descrizione (opzionale)';

  @override
  String get retroCustomMinColumns => 'Sono necessarie almeno 2 colonne';

  @override
  String get retroCustomMaxColumns => 'Massimo 8 colonne consentite';

  @override
  String get retroCustomConfigureColumns => 'Configura Colonne';

  @override
  String get retroIcebreakerSentiment => 'Stimmungs-Votum';

  @override
  String get retroIcebreakerOneWord => 'Ein Wort';

  @override
  String get retroIcebreakerWeather => 'Wetter';

  @override
  String get retroIcebreakerSentimentDesc =>
      '1-5 Votum zur Stimmung im Sprint.';

  @override
  String get retroIcebreakerOneWordDesc => 'Sprint mit einem Wort beschreiben.';

  @override
  String get retroIcebreakerWeatherDesc => 'Wetter-Icon für den Sprint wählen.';

  @override
  String get retroPhaseIcebreaker => 'ICEBREAKER';

  @override
  String get retroPhaseWriting => 'SCHREIBEN';

  @override
  String get retroPhaseVoting => 'ABSTIMMUNG';

  @override
  String get retroPhaseDiscuss => 'DISKUSSION';

  @override
  String get retroActionItemsLabel => 'Action Items';

  @override
  String get retroActionDragToCreate => 'Karte hierher ziehen für Action Item';

  @override
  String get retroNoActionItems => 'Noch keine Action Items erstellt.';

  @override
  String get facilitatorGuideNextColumn => 'Nächste Aktion aus';

  @override
  String get collectionRationaleSSC => 'Erst Stop, dann Start, dann Continue.';

  @override
  String get collectionRationaleMSG =>
      'Erst Frustrationen, dann Enttäuschungen, dann Erfolge.';

  @override
  String get collectionRationale4Ls =>
      'Erst Lücken, dann Aspirationen, dann Gelerntes.';

  @override
  String get collectionRationaleSailboat =>
      'Erst Risiken, dann Blocker, dann Ziele.';

  @override
  String get collectionRationaleStarfish => 'Stop, Less, Keep, More, Start.';

  @override
  String get collectionRationaleDAKI => 'Drop, Add, Improve, Keep.';

  @override
  String get missingSuggestionSSCStop => 'Blockierende Praktiken stoppen.';

  @override
  String get missingSuggestionSSCStart => 'Neue hilfreiche Praktiken starten.';

  @override
  String get missingSuggestionMSGMad => 'Frustrationen angehen.';

  @override
  String get missingSuggestionMSGSad => 'Enttäuschungen lösen.';

  @override
  String get missingSuggestion4LsLacked => 'Was hat dem Team gefehlt?';

  @override
  String get missingSuggestion4LsLonged => 'Was wünscht sich das Team?';

  @override
  String get missingSuggestionSailboatAnchor => 'Was hält das Team zurück?';

  @override
  String get missingSuggestionSailboatRock => 'Risiken identifizieren.';

  @override
  String get missingSuggestionStarfishStop => 'Ganz aufhören mit...';

  @override
  String get missingSuggestionStarfishStart => 'Damit anfangen...';

  @override
  String get missingSuggestionDAKIDrop => 'Was weglassen?';

  @override
  String get missingSuggestionDAKIAdd => 'Neue Entscheidungen treffen.';

  @override
  String get missingSuggestionGeneric => 'Aktion aus dieser Spalte erstellen.';

  @override
  String get facilitatorGuideAllCovered => 'Alle Spalten abgedeckt!';

  @override
  String get facilitatorGuideMissing => 'Aktionen fehlen für';

  @override
  String get retroPhaseStart => 'Starten';

  @override
  String get retroPhaseStop => 'Stoppen';

  @override
  String get retroPhaseContinue => 'Weiter';

  @override
  String get retroColumnMad => 'Wütend';

  @override
  String get retroColumnSad => 'Traurig';

  @override
  String get retroColumnGlad => 'Glücklich';

  @override
  String get retroColumnLiked => 'Mochte';

  @override
  String get retroColumnLearned => 'Gelernt';

  @override
  String get retroColumnLacked => 'Gefehlt';

  @override
  String get retroColumnLonged => 'Gewünscht';

  @override
  String get retroColumnWind => 'Wind';

  @override
  String get retroColumnAnchor => 'Anker';

  @override
  String get retroColumnRock => 'Felsen';

  @override
  String get retroColumnGoal => 'Ziel';

  @override
  String get retroColumnKeep => 'Behalten';

  @override
  String get retroColumnMore => 'Mehr';

  @override
  String get retroColumnLess => 'Weniger';

  @override
  String get retroColumnDrop => 'Weglassen';

  @override
  String get retroColumnAdd => 'Neu';

  @override
  String get retroColumnImprove => 'Besser';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get formTitle => 'Titel';

  @override
  String get formDescription => 'Beschreibung';

  @override
  String get formName => 'Name';

  @override
  String get formRequired => 'Pflichtfeld';

  @override
  String get formHint => 'Wert eingeben';

  @override
  String get formOptional => 'Optional';

  @override
  String errorGeneric(String error) {
    return 'Fehler: $error';
  }

  @override
  String get errorLoading => 'Fehler beim Laden';

  @override
  String get errorSaving => 'Fehler beim Speichern';

  @override
  String get errorNetwork => 'Verbindungsfehler';

  @override
  String get errorPermission => 'Keine Berechtigung';

  @override
  String get errorNotFound => 'Nicht gefunden';

  @override
  String get successSaved => 'Erfolgreich gespeichert';

  @override
  String get successDeleted => 'Erfolgreich gelöscht';

  @override
  String get successCopied => 'In Zwischenablage kopiert';

  @override
  String get filterAll => 'Alle';

  @override
  String get filterRemove => 'Filter entfernen';

  @override
  String get filterActive => 'Aktiv';

  @override
  String get filterCompleted => 'Erledigt';

  @override
  String get participants => 'Teilnehmer';

  @override
  String get agileAcceptanceCriteria => 'Abnahmekriterien';

  @override
  String agileAcceptanceCriteriaCount(int completed, int total) {
    return '$completed von $total';
  }

  @override
  String get agileEstimateRequired => 'Schätzung nötig (klicken)';

  @override
  String get agileNoActiveSprint => 'Kein aktiver Sprint';

  @override
  String get agileKanbanBoardHint => 'Board zeigt Stories des aktiven Sprints.';

  @override
  String get agileStartSprintFromTab => 'Sprint aus Sprint-Tab starten';

  @override
  String get agileDisableFilterHint => 'Filter deaktivieren für alle Stories';

  @override
  String get agileShowAllStories => 'Alle Stories zeigen';

  @override
  String get agileFilterActiveSprint => 'Filter Aktiver Sprint: ';

  @override
  String get agileFilterActive => 'Aktiv';

  @override
  String get agileFilterAll => 'Alle';

  @override
  String get agileActionInvite => 'Einladen';

  @override
  String agileTeamTitle(int count) {
    return 'Team ($count)';
  }

  @override
  String get agileNoMembers => 'Keine Mitglieder im Team';

  @override
  String get agileYouBadge => 'Du';

  @override
  String agileStatsPlannedCount(int count) {
    return '$count geplant';
  }

  @override
  String agileStatsTotalCount(int count) {
    return '$count gesamt';
  }

  @override
  String get agileStatsPtsPerSprint => 'Pkt/Sprint';

  @override
  String get agileStatsWorkInProgress => 'In Arbeit';

  @override
  String get agileStatsItemsPerWeek => 'Items/Woche';

  @override
  String get agileStatsCompletedTooltip =>
      'Anzahl der Sprints mit Status \'Abgeschlossen\'.\nKlicken Sie auf \'Sprint abschließen\', um einen aktiven Sprint zu beenden.';

  @override
  String get agileAverageVelocityTooltip =>
      'Durchschnitt der abgeschlossenen Story Points pro Sprint.\nBerechnet aus abgeschlossenen Sprints mit Stories im Status \'Done\'.\nHöher = produktiveres Team.';

  @override
  String get agileStatsStoriesCompletedTooltip =>
      'Anzahl der User Stories mit Status \'Done\'.\nUm diesen Wert zu erhöhen, verschieben Sie Stories in die Spalte \'Done\' auf dem Kanban Board.';

  @override
  String get agileStatsPointsTooltip =>
      'Summe der Story Points abgeschlossener Stories.\n\'Geplant\' umfasst alle geschätzten Stories im Backlog.';

  @override
  String get agileItemsCompletedTooltip =>
      'Anzahl der Work Items im Status \'Done\'.\nVerschieben Sie Items in die Spalte \'Done\', um sie abzuschließen.';

  @override
  String get agileInProgressTooltip =>
      'Aktuell in Arbeit befindliche Items (WIP).\nHalten Sie diese Zahl niedrig, um den Fluss zu verbessern.';

  @override
  String get agileCycleTimeTooltip =>
      'Durchschnittliche Zeit in aktiven Zuständen (z.B. In Progress, Review).\nSchließt Wartezeit im Backlog oder Ready aus.';

  @override
  String get agileThroughputTooltip =>
      'Durchschnitt abgeschlossener Items pro Woche (letzte 4 Wochen).\nZeigt die Produktivität des Teams im Zeitverlauf.';

  @override
  String get agileHybridSprintTooltip =>
      'Abgeschlossene Sprints im Verhältnis zum Gesamtwert.';

  @override
  String get agileHybridCompletedTooltip =>
      'Items im Status \'Done\' im Verhältnis zum Gesamtwert.';

  @override
  String get agileAddSkillsHint => 'Kompetenzen den Teammitgliedern hinzufügen';

  @override
  String get agileSkillMatrixTitle => 'Kompetenzmatrix';

  @override
  String get agileCriticalSkills => 'Kritische Kompetenzen';

  @override
  String agileCriticalSkillsWarning(String skills) {
    return 'Nur 1 Person deckt ab: $skills';
  }

  @override
  String get agileSkills => 'Kompetenzen';

  @override
  String get agileNoSkills => 'Keine Kompetenzen';

  @override
  String get agileAddSkill => 'Kompetenz hinzufügen';

  @override
  String get agileNewSkill => 'Neue Kompetenz...';

  @override
  String get agileNewSkillDialogTitle => 'Neue Kompetenz';

  @override
  String get agileNewSkillName => 'Name der Kompetenz';

  @override
  String get agileNewSkillHint => 'Z.B.: Flutter, Python, AWS...';

  @override
  String get agileSkillCoverage => 'Kompetenzabdeckung';

  @override
  String get agileNoSkillsAvailable => 'Keine Skills verfügbar';

  @override
  String agileBasedOnCompletedItems(int count) {
    return 'Basierend auf $count abgeschlossenen Items';
  }

  @override
  String get agileNoAcceptanceCriteria => 'Keine Abnahmekriterien definiert';

  @override
  String get agileDescription => 'Beschreibung';

  @override
  String get agileNoDescription => 'Keine Beschreibung';

  @override
  String get agileTags => 'Tags';

  @override
  String get agileEstimates => 'Schätzungen';

  @override
  String get agileFinalEstimate => 'Endgültige Schätzung';

  @override
  String agileEstimatesReceived(int count) {
    return '$count Schätzungen erhalten';
  }

  @override
  String get agileInformation => 'Informationen';

  @override
  String get agileBusinessValue => 'Business Value';

  @override
  String get agileAssignee => 'Zuständiger';

  @override
  String get agileCreatedBy => 'Erstellt von';

  @override
  String get agileCreatedAt => 'Erstellt am';

  @override
  String get agileStartedAt => 'Begonnen am';

  @override
  String get agileCompletedAt => 'Abgeschlossen am';

  @override
  String get agileSprintTitle => 'Sprint';

  @override
  String get agileNewSprint => 'Neuer Sprint';

  @override
  String get agileNoSprints => 'Keine Sprints';

  @override
  String get agileCreateFirstSprint =>
      'Erstellen Sie den ersten Sprint, um zu beginnen';

  @override
  String get agileSprintStatusPlanning => 'Planung';

  @override
  String get agileSprintStatusActive => 'Aktiv';

  @override
  String get agileSprintStatusReview => 'Review';

  @override
  String get agileSprintStatusCompleted => 'Abgeschlossen';

  @override
  String get agileStartSprint => 'Sprint starten';

  @override
  String get agileCompleteSprint => 'Sprint abschließen';

  @override
  String get agileStartClosing => 'Sprint schließen';

  @override
  String get agileFinalizeSprint => 'Sprint finalisieren';

  @override
  String get agileSprintClosingPhase => 'In Schließung';

  @override
  String get agileSprintClosingDesc =>
      'Der Sprint befindet sich in der Abschlussphase. Beenden Sie die Sprint Review und finalisieren Sie den Sprint.';

  @override
  String get agileSprintClosingBanner =>
      'Sprint in Abschlussphase - Review beenden und finalisieren';

  @override
  String get agileSprintClosingStarted => 'Sprint in Abschlussphase';

  @override
  String get agileSprintClosingBoardVisible =>
      'Das Board zeigt weiterhin die Stories des Sprints';

  @override
  String get agileSprintClosingNoNewStories =>
      'Es können keine neuen Stories zum Sprint hinzugefügt werden';

  @override
  String get agileSprintClosingReviewFirst =>
      'Führen Sie die Sprint Review vor der Finalisierung durch';

  @override
  String agileSprintOverdue(int days) {
    return 'Seit $days Tagen überfällig';
  }

  @override
  String agileSprintDaysWarning(int days) {
    return '$days Tage verbleibend';
  }

  @override
  String get agileStoryDisposition => 'Story-Verbleib';

  @override
  String get agileStoryDispositionDesc =>
      'Wählen Sie, was mit unvollständigen Stories geschehen soll';

  @override
  String get agileDispositionBacklog => 'Backlog';

  @override
  String get agileDispositionReady => 'Ready';

  @override
  String get agileDispositionRefinement => 'In Refinement';

  @override
  String get agileDispositionBacklogDesc =>
      'Zurück ins Backlog zur Neupriorisierung';

  @override
  String get agileDispositionReadyDesc =>
      'Bereit für das nächste Sprint Planning';

  @override
  String get agileDispositionRefinementDesc =>
      'Muss vor dem nächsten Sprint weiter analysiert werden';

  @override
  String get agileRetroSuggestion =>
      'Möchten Sie die Retrospektive für diesen Sprint erstellen?';

  @override
  String get agileCreateRetro => 'Retrospektive erstellen';

  @override
  String get agileNotNow => 'Nicht jetzt';

  @override
  String get agileSprintReviewSection => 'Sprint Review';

  @override
  String get agileSprintSummarySection => 'Sprint-Zusammenfassung';

  @override
  String get agileReviewRecapTitle => 'Zusammenfassung Sprint Review';

  @override
  String get agileReviewApproved => 'Genehmigt';

  @override
  String get agileReviewRefinement => 'Refinement nötig';

  @override
  String get agileReviewRejected => 'Abgelehnt';

  @override
  String get agileDeleteSprint => 'Löschen';

  @override
  String get agileSprintName => 'Sprintname';

  @override
  String get agileSprintGoal => 'Sprint Goal';

  @override
  String get agileSprintGoalHint => 'Ziel des Sprints';

  @override
  String get agileStartDate => 'Startdatum';

  @override
  String get agileEndDate => 'Enddatum';

  @override
  String get agileStatsStories => 'Stories';

  @override
  String get agileStatsPoints => 'Pkt';

  @override
  String get agileStatsCompleted => 'abgeschlossen';

  @override
  String get agileStatsVelocity => 'Velocity';

  @override
  String agileDaysRemainingCount(String count) {
    return '$count Tage verbleibend';
  }

  @override
  String get agileAverageVelocity => 'Durchschnitts-Velocity';

  @override
  String agileTeamMembersCount(String count) {
    return 'Team: $count Mitglieder';
  }

  @override
  String get agileActionCancel => 'Abbrechen';

  @override
  String get agileActionSave => 'Speichern';

  @override
  String get agileActionCreate => 'Erstellen';

  @override
  String get agileSprintPlanningTitle => 'Sprint Planning';

  @override
  String get agileSprintPlanningSubtitle =>
      'Wählen Sie die Stories für diesen Sprint aus';

  @override
  String get agileBurndownChart => 'Burndown Chart';

  @override
  String get agileBurndownIdeal => 'Ideal';

  @override
  String get agileBurndownActual => 'Real';

  @override
  String get agileBurndownPlanned => 'Geplant';

  @override
  String get agileBurndownRemaining => 'Verbleibend';

  @override
  String get agileBurndownNoData => 'Keine Burndown-Daten';

  @override
  String get agileBurndownNoDataHint =>
      'Daten erscheinen, wenn der Sprint aktiv ist';

  @override
  String get agileVelocityTrend => 'Velocity-Trend';

  @override
  String get agileVelocityNoData => 'Keine Velocity-Daten';

  @override
  String get agileVelocityNoDataHint =>
      'Schließen Sie mindestens einen Sprint ab, um den Trend zu sehen';

  @override
  String get agileTeamCapacity => 'Team-Kapazität';

  @override
  String get agileTeamCapacityScrum => 'Team-Kapazität (Scrum)';

  @override
  String get agileTeamCapacityHours => 'Team-Kapazität (Stunden)';

  @override
  String get agileThroughput => 'Throughput';

  @override
  String get agileSuggestedCapacity =>
      'Empfohlene Kapazität für Sprint Planning';

  @override
  String get agileSuggestedCapacityHint =>
      'Basierend auf Durchschnitts-Velocity ± Standardabweichung (±10%)';

  @override
  String get agileSuggestedCapacityNoData =>
      'Mindestens 1 Sprint abschließen für Kapazitätsvorschläge';

  @override
  String get agileScrumGuideNote =>
      'Der Scrum Guide empfiehlt, die Planung auf historischer Velocity statt auf Stunden zu basieren.';

  @override
  String get agileHoursAvailable => 'Verfügbar';

  @override
  String get agileHoursAssigned => 'Zugewiesen';

  @override
  String get agileHoursOverloaded => 'Überlastet';

  @override
  String get agileHoursTotal => 'Gesamtkapazität';

  @override
  String get agileHoursUtilization => 'Auslastung';

  @override
  String agileMetricsTitle(String framework) {
    return 'Metriken $framework';
  }

  @override
  String get agileItemsCompleted => 'Items abgeschlossen';

  @override
  String get agileInProgress => 'In Bearbeitung';

  @override
  String get agileCycleTime => 'Cycle Time';

  @override
  String get agileLeadTime => 'Lead Time';

  @override
  String get agileDistribution => 'Story-Verteilung';

  @override
  String get agileCompletionRate => 'Abschlussrate';

  @override
  String get agileAccuracy => 'Schätzgenauigkeit';

  @override
  String get agileEfficiency => 'Flusseffizienz';

  @override
  String get removeParticipant => 'Teilnehmer entfernen';

  @override
  String get noParticipants => 'Keine Teilnehmer';

  @override
  String get participantJoined => 'ist beigetreten';

  @override
  String get participantLeft => 'hat verlassen';

  @override
  String get participantRole => 'Rolle';

  @override
  String get participantVoter => 'Wähler';

  @override
  String get participantObserver => 'Beobachter';

  @override
  String get participantModerator => 'Moderator';

  @override
  String get confirmDelete => 'Löschen bestätigen';

  @override
  String get confirmDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get ok => 'OK';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get tomorrow => 'Morgen';

  @override
  String daysAgo(int count) {
    return 'vor $count Tagen';
  }

  @override
  String hoursAgo(int count) {
    return 'vor $count Stunden';
  }

  @override
  String minutesAgo(int count) {
    return 'vor $count Minuten';
  }

  @override
  String itemCount(int count) {
    return '$count Elemente';
  }

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String greeting(String name) {
    return 'Hallo, $name!';
  }

  @override
  String get copyLink => 'Link kopieren';

  @override
  String get shareSession => 'Sitzung teilen';

  @override
  String get inviteByEmail => 'Per E-Mail einladen';

  @override
  String get inviteByLink => 'Per Link einladen';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileEmail => 'E-Mail';

  @override
  String get profileDisplayName => 'Anzeigename';

  @override
  String get profilePhotoUrl => 'Profilbild';

  @override
  String get profileEditProfile => 'Profil bearbeiten';

  @override
  String get profileReload => 'Neu laden';

  @override
  String get profilePersonalInfo => 'Persönliche Informationen';

  @override
  String get profileLastName => 'Nachname';

  @override
  String get profileCompany => 'Unternehmen';

  @override
  String get profileJobTitle => 'Rolle';

  @override
  String get profileBio => 'Bio';

  @override
  String get profileSubscription => 'Abonnement';

  @override
  String get profilePlan => 'Plan';

  @override
  String get profileBillingCycle => 'Abrechnungszyklus';

  @override
  String get profilePrice => 'Preis';

  @override
  String get profileActivationDate => 'Aktivierungsdatum';

  @override
  String get profileTrialEnd => 'Ende des Testzeitraums';

  @override
  String get profileNextRenewal => 'Nächste Erneuerung';

  @override
  String get profileDaysRemaining => 'Verbleibende Tage';

  @override
  String get profileUpgrade => 'Auf Premium wechseln';

  @override
  String get profileUpgradePlan => 'Plan-Upgrade';

  @override
  String get planFree => 'Kostenlos';

  @override
  String get planPremium => 'Premium';

  @override
  String get planElite => 'Elite';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusTrialing => 'Im Test';

  @override
  String get statusPastDue => 'Zahlung überfällig';

  @override
  String get statusPaused => 'Pausiert';

  @override
  String get statusCancelled => 'Gekündigt';

  @override
  String get statusExpired => 'Abgelaufen';

  @override
  String get cycleMonthly => 'Monatlich';

  @override
  String get cycleQuarterly => 'Vierteljährlich';

  @override
  String get cycleYearly => 'Jährlich';

  @override
  String get cycleLifetime => 'Lebenslang';

  @override
  String get pricePerMonth => 'Monat';

  @override
  String get pricePerQuarter => 'Quartal';

  @override
  String get pricePerYear => 'Jahr';

  @override
  String get priceForever => 'immer';

  @override
  String get priceFree => 'Kostenlos';

  @override
  String get profileGeneralSettings => 'Allgemeine Einstellungen';

  @override
  String get profileAnimations => 'Animationen';

  @override
  String get profileAnimationsDesc => 'UI-Animationen aktivieren';

  @override
  String get profileFeatures => 'Funktionen';

  @override
  String get profileCalendarIntegration => 'Kalender-Integration';

  @override
  String get profileCalendarIntegrationDesc =>
      'Sprints und Termine synchronisieren';

  @override
  String get profileExportSheets => 'Google Sheets Export';

  @override
  String get profileExportSheetsDesc => 'Daten in Tabellen exportieren';

  @override
  String get profileBetaFeatures => 'Beta-Funktionen';

  @override
  String get profileBetaFeaturesDesc => 'Vorabzugriff auf neue Funktionen';

  @override
  String get profileAdvancedMetrics => 'Erweiterte Metriken';

  @override
  String get profileAdvancedMetricsDesc =>
      'Detaillierte Statistiken und Berichte';

  @override
  String get profileNotifications => 'Benachrichtigungen';

  @override
  String get profileEmailNotifications => 'E-Mail-Benachrichtigungen';

  @override
  String get profileEmailNotificationsDesc => 'Updates per E-Mail erhalten';

  @override
  String get profilePushNotifications => 'Push-Benachrichtigungen';

  @override
  String get profilePushNotificationsDesc => 'Browser-Benachrichtigungen';

  @override
  String get profileSprintReminders => 'Sprint-Erinnerungen';

  @override
  String get profileSprintRemindersDesc => 'Warnungen bei Sprint-Ende';

  @override
  String get profileSessionInvites => 'Sitzungseinladungen';

  @override
  String get profileSessionInvitesDesc =>
      'Benachrichtigungen bei neuen Sitzungen';

  @override
  String get profileWeeklySummary => 'Wöchentliche Zusammenfassung';

  @override
  String get profileWeeklySummaryDesc => 'Wöchentlicher Aktivitätsbericht';

  @override
  String get profileDangerZone => 'Gefahrenzone';

  @override
  String get profileDeleteAccount => 'Account löschen';

  @override
  String get profileDeleteAccountDesc =>
      'Endgültige Löschung Ihres Accounts und aller Daten anfordern';

  @override
  String get profileDeleteAccountRequest => 'Anfordern';

  @override
  String get profileDeleteAccountIrreversible =>
      'Diese Aktion ist unwiderruflich. Alle Ihre Daten werden dauerhaft gelöscht.';

  @override
  String get profileDeleteAccountReason => 'Grund (optional)';

  @override
  String get profileDeleteAccountReasonHint =>
      'Warum möchten Sie Ihren Account löschen?';

  @override
  String get profileRequestDeletion => 'Löschung anfordern';

  @override
  String get profileDeletionInProgress => 'Löschung läuft';

  @override
  String profileDeletionRequestedAt(String date) {
    return 'Angefordert am $date';
  }

  @override
  String get profileCancelRequest => 'Anfrage abbrechen';

  @override
  String get profileDeletionRequestSent => 'Löschantrag gesendet';

  @override
  String get profileDeletionRequestCancelled => 'Anfrage abgebrochen';

  @override
  String get profileUpdated => 'Profil aktualisiert';

  @override
  String get profileLogout => 'Abmelden';

  @override
  String get profileLogoutDesc => 'Account auf diesem Gerät abmelden';

  @override
  String get profileLogoutConfirm =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get profileSubscriptionCancelled => 'Abonnement gekündigt';

  @override
  String get profileCancelSubscription => 'Abonnement kündigen';

  @override
  String get profileCancelSubscriptionConfirm =>
      'Sind Sie sicher, dass Sie Ihr Abonnement kündigen möchten? Sie können die Premium-Funktionen bis zum Ende des aktuellen Zeitraums weiter nutzen.';

  @override
  String get profileKeepSubscription => 'Nein, behalten';

  @override
  String get profileYesCancel => 'Ja, kündigen';

  @override
  String profileUpgradeComingSoon(String plan) {
    return 'Upgrade auf $plan demnächst verfügbar...';
  }

  @override
  String get profileFree => 'Kostenlos';

  @override
  String get profileMonthly => 'EUR/Monat';

  @override
  String get profileUser => 'Benutzer';

  @override
  String profileErrorPrefix(String error) {
    return 'Fehler: $error';
  }

  @override
  String get stateSaving => 'Speichern...';

  @override
  String get cardCoffee => 'Pause';

  @override
  String get cardQuestion => 'Weiß nicht';

  @override
  String get toolEisenhower => 'Eisenhower-Matrix';

  @override
  String get toolEisenhowerDesc =>
      'Organisieren Sie Aufgaben nach Dringlichkeit und Wichtigkeit. Quadranten helfen bei der Entscheidung: sofort tun, planen, delegieren oder eliminieren.';

  @override
  String get toolEisenhowerDescShort =>
      'Priorisieren nach Dringlichkeit und Wichtigkeit';

  @override
  String get toolEstimation => 'Estimation Room';

  @override
  String get toolEstimationDesc =>
      'Kollaborative Schätzsitzungen für das Team. Planning Poker, T-Shirt Sizing und andere Methoden zur Schätzung von User Stories.';

  @override
  String get toolEstimationDescShort => 'Kollaborative Schätzsitzungen';

  @override
  String get toolSmartTodo => 'Smart Todo';

  @override
  String get toolSmartTodoDesc =>
      'Intelligente und kollaborative Listen. Import aus CSV/Text, Teilnehmer einladen und Aufgaben mit Filtern verwalten.';

  @override
  String get toolSmartTodoDescShort =>
      'Intelligente und kollaborative Listen mit CSV-Import.';

  @override
  String get toolAgileProcess => 'Agile Process Manager';

  @override
  String get toolAgileProcessDesc =>
      'Managen Sie komplette agile Projekte mit Backlog, Sprint Planning, Kanban Board, Metriken und Retrospektiven.';

  @override
  String get toolAgileProcessDescShort =>
      'Komplettes agiles Management mit Backlog, Sprints und Kanban.';

  @override
  String get toolRetro => 'Retrospective Board';

  @override
  String get toolRetroDesc =>
      'Sammeln Sie Team-Feedback: Was lief gut, was kann verbessert werden und welche Aktionen sind nötig?';

  @override
  String get toolRetroDescShort =>
      'Team-Feedback zu Erfolgen und Verbesserungen sammeln.';

  @override
  String get homeUtilities => 'Dienstprogramme';

  @override
  String get homeSelectTool => 'Wählen Sie ein Programm zum Starten';

  @override
  String get statusOnline => 'Online';

  @override
  String get comingSoon => 'Demnächst verfügbar';

  @override
  String get featureComingSoon => 'Diese Funktion ist bald verfügbar!';

  @override
  String get featureSmartImport => 'Smart Import';

  @override
  String get featureCollaboration => 'Kollaboration';

  @override
  String get featureFilters => 'Filter';

  @override
  String get feature4Quadrants => '4 Quadranten';

  @override
  String get featureDragDrop => 'Drag & Drop';

  @override
  String get featureCollaborative => 'Kollaborativ';

  @override
  String get featurePlanningPoker => 'Planning Poker';

  @override
  String get featureTshirtSize => 'T-Shirt Größe';

  @override
  String get featureRealtime => 'Echtzeit';

  @override
  String get featureScrum => 'Scrum';

  @override
  String get featureKanban => 'Kanban';

  @override
  String get featureHybrid => 'Hybrid';

  @override
  String get featureWentWell => 'Gut gelaufen';

  @override
  String get featureToImprove => 'Zu verbessern';

  @override
  String get featureActions => 'Aktionen';

  @override
  String get themeLightMode => 'Helles Design';

  @override
  String get themeDarkMode => 'Dunkles Design';

  @override
  String get estimationBackToSessions => 'Zurück zu Sitzungen';

  @override
  String get estimationSessionSettings => 'Sitzungseinstellungen';

  @override
  String get estimationList => 'Liste';

  @override
  String estimationSessionsCount(int filtered, int total) {
    return 'Ihre Sitzungen ($filtered/$total)';
  }

  @override
  String get estimationNoSessionFound => 'Keine Sitzung gefunden';

  @override
  String get estimationCreateFirstSession =>
      'Erstellen Sie Ihre erste Schätzsitzung\num Aufgaben mit dem Team zu bewerten';

  @override
  String get estimationStoriesTotal => 'Stories gesamt';

  @override
  String get estimationStoriesCompleted => 'Stories abgeschlossen';

  @override
  String get estimationParticipantsActive => 'Aktive Teilnehmer';

  @override
  String estimationProgress(int completed, int total, String percent) {
    return 'Fortschritt: $completed/$total Stories';
  }

  @override
  String get estimationStart => 'Start';

  @override
  String get estimationComplete => 'Abschließen';

  @override
  String get estimationAllStoriesEstimated => 'Alle Stories wurden geschätzt!';

  @override
  String get estimationNoVotingInProgress => 'Keine Abstimmung im Gange';

  @override
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  ) {
    return 'Erledigt: $completed/$total | Gesamtschätzung: $total_estimate pt';
  }

  @override
  String estimationVoteStory(String title) {
    return 'Abstimmung: $title';
  }

  @override
  String get estimationAddStoriesToStart =>
      'Fügen Sie Stories hinzu, um zu beginnen';

  @override
  String get estimationInVoting => 'STIMMT AB';

  @override
  String get estimationReveal => 'Aufdecken';

  @override
  String get estimationSkip => 'Überspringen';

  @override
  String get estimationStories => 'Stories';

  @override
  String get estimationVotingTab => 'Abstimmung';

  @override
  String get estimationTeamTab => 'Team';

  @override
  String get estimationAddStory => 'Story hinzufügen';

  @override
  String get estimationStartVoting => 'Abstimmung starten';

  @override
  String get estimationViewVotes => 'Stimmen sehen';

  @override
  String get estimationViewDetail => 'Details sehen';

  @override
  String get estimationFinalEstimateLabel => 'Endgültige Schätzung:';

  @override
  String estimationVotesOf(String title) {
    return 'Stimmen: $title';
  }

  @override
  String get estimationParticipantVotes => 'Stimmen der Teilnehmer:';

  @override
  String get estimationPointsOrDays => 'Punkte / Tage';

  @override
  String get estimationEstimateRationale =>
      'Begründung der Schätzung (optional)';

  @override
  String get estimationExplainRationale =>
      'Erklären Sie die Begründung...\nZ.B.: Hohe technische Komplexität, externe Abhängigkeiten...';

  @override
  String get estimationRationaleHelp =>
      'Die Begründung hilft dem Team, sich an die Entscheidungen während der Schätzung zu erinnern.';

  @override
  String get estimationConfirmFinalEstimate =>
      'Endgültige Schätzung bestätigen';

  @override
  String get estimationEnterValidEstimate => 'Gültige Schätzung eingeben';

  @override
  String get estimationHintEstimate => 'Z.B.: 5, 8, 13...';

  @override
  String get estimationStatus => 'Status';

  @override
  String get estimationOrder => 'Reihenfolge';

  @override
  String get estimationVotesReceived => 'Stimmen erhalten';

  @override
  String get estimationAverageVotes => 'Durchschnitt';

  @override
  String get estimationConsensus => 'Konsens';

  @override
  String get storyStatusPending => 'Warten';

  @override
  String get storyStatusVoting => 'Abstimmung';

  @override
  String get storyStatusRevealed => 'Aufgedeckt';

  @override
  String get participantManagement => 'Teilnehmerverwaltung';

  @override
  String get participantCopySessionLink => 'Sitzungs-Link kopieren';

  @override
  String get participantInvitesTab => 'Einladungen';

  @override
  String get participantSessionLink => 'Sitzungs-Link (mit Teilnehmern teilen)';

  @override
  String get participantAddDirect =>
      'Direkten Teilnehmer hinzufügen (offene Abstimmung)';

  @override
  String get participantEmailRequired => 'E-Mail *';

  @override
  String get participantEmailHint => 'email@beispiel.com';

  @override
  String get participantNameHint => 'Anzeigename';

  @override
  String participantVotersAndObservers(int voters, int observers) {
    return '$voters Wähler, $observers Beobachter';
  }

  @override
  String get participantYou => '(du)';

  @override
  String get participantMakeVoter => 'Zum Wähler machen';

  @override
  String get participantMakeObserver => 'Zum Beobachter machen';

  @override
  String get participantRemoveTitle => 'Teilnehmer entfernen';

  @override
  String participantRemoveConfirm(String name) {
    return 'Sind Sie sicher, dass Sie \"$name\" aus der Sitzung entfernen möchten?';
  }

  @override
  String participantAddedToSession(String email) {
    return '$email wurde zur Sitzung hinzugefügt';
  }

  @override
  String participantRemovedFromSession(String name) {
    return '$name wurde aus der Sitzung entfernt';
  }

  @override
  String participantRoleUpdated(String email) {
    return 'Rolle für $email aktualisiert';
  }

  @override
  String get participantFacilitator => 'Facilitator';

  @override
  String get inviteSendNew => 'Neue Einladung senden';

  @override
  String get inviteRecipientEmail => 'E-Mail des Empfängers *';

  @override
  String get inviteCreate => 'Einladung erstellen';

  @override
  String get invitesSent => 'Gesendete Einladungen';

  @override
  String get inviteNoInvites => 'Keine Einladungen gesendet';

  @override
  String inviteCreatedFor(String email) {
    return 'Einladung für $email erstellt';
  }

  @override
  String inviteSentTo(String email) {
    return 'Einladung per E-Mail an $email gesendet';
  }

  @override
  String inviteExpiresIn(int days) {
    return 'Läuft ab in ${days}T';
  }

  @override
  String get inviteCopyLink => 'Link kopieren';

  @override
  String get inviteRevokeAction => 'Einladung widerrufen';

  @override
  String get inviteDeleteAction => 'Einladung löschen';

  @override
  String get inviteRevokeTitle => 'Einladung widerrufen?';

  @override
  String inviteRevokeConfirm(String email) {
    return 'Sind Sie sicher, dass Sie die Einladung für $email widerrufen möchten?';
  }

  @override
  String get inviteRevoke => 'Widerrufen';

  @override
  String inviteRevokedFor(String email) {
    return 'Einladung für $email widerrufen';
  }

  @override
  String get inviteDeleteTitle => 'Einladung löschen';

  @override
  String inviteDeleteConfirm(String email) {
    return 'Sind Sie sicher, dass Sie die Einladung für $email löschen möchten?\n\nDiese Aktion ist unwiderruflich.';
  }

  @override
  String inviteDeletedFor(String email) {
    return 'Einladung für $email gelöscht';
  }

  @override
  String get inviteLinkCopied => 'Link kopiert!';

  @override
  String get linkCopied => 'Link in Zwischenablage kopiert';

  @override
  String get enterValidEmail => 'Geben Sie eine gültige E-Mail-Adresse ein';

  @override
  String get sessionCreatedSuccess => 'Sitzung erfolgreich erstellt';

  @override
  String get sessionUpdated => 'Sitzung aktualisiert';

  @override
  String get sessionDeleted => 'Sitzung gelöscht';

  @override
  String get sessionStarted => 'Sitzung gestartet';

  @override
  String get sessionCompletedSuccess => 'Sitzung abgeschlossen';

  @override
  String get sessionNotFound => 'Sitzung nicht gefunden';

  @override
  String get storyAdded => 'Story hinzugefügt';

  @override
  String get storyDeleted => 'Story gelöscht';

  @override
  String estimateSaved(String estimate) {
    return 'Schätzung gespeichert: $estimate';
  }

  @override
  String get deleteSessionTitle => 'Sitzung löschen';

  @override
  String deleteSessionConfirm(String name, int count) {
    return 'Sind Sie sicher, dass Sie \"$name\" löschen möchten?\nAlle $count Stories werden ebenfalls gelöscht.';
  }

  @override
  String get deleteStoryTitle => 'Story löschen';

  @override
  String deleteStoryConfirm(String title) {
    return 'Sind Sie sicher, dass Sie \"$title\" löschen möchten?';
  }

  @override
  String get errorLoadingSession => 'Fehler beim Laden der Sitzung';

  @override
  String get errorLoadingStories => 'Fehler beim Laden der Stories';

  @override
  String get errorCreatingSession => 'Fehler beim Erstellen der Sitzung';

  @override
  String get errorUpdatingSession => 'Fehler beim Aktualisieren';

  @override
  String get errorDeletingSession => 'Fehler beim Löschen';

  @override
  String get errorAddingStory => 'Fehler beim Hinzufügen der Story';

  @override
  String get errorStartingSession => 'Fehler beim Starten der Sitzung';

  @override
  String get errorCompletingSession => 'Fehler beim Abschließen der Sitzung';

  @override
  String get errorSubmittingVote => 'Fehler beim Senden der Stimme';

  @override
  String get errorRevealingVotes => 'Fehler beim Aufdecken';

  @override
  String get errorSavingEstimate => 'Fehler beim Speichern der Schätzung';

  @override
  String get errorSkipping => 'Fehler beim Überspringen';

  @override
  String get genericWarningTitle => 'Warnung';

  @override
  String get skipRevealedStoryWarning =>
      'Diese Story wurde aufgedeckt und enthält Votes. Möchten Sie sie wirklich überspringen und die aktuellen Votes verlieren?';

  @override
  String get skipRevealedStoryConfirm => 'Ja, überspringen';

  @override
  String get retroIcebreakerTitle => 'Icebreaker: Team-Moral';

  @override
  String get retroIcebreakerQuestion =>
      'Wie hast du dich in diesem Sprint gefühlt?';

  @override
  String retroParticipantsVoted(int count) {
    return '$count Teilnehmer haben abgestimmt';
  }

  @override
  String get retroEndIcebreakerStartWriting =>
      'Icebreaker beenden & Schreiben starten';

  @override
  String get retroMoodTerrible => 'Schrecklich';

  @override
  String get retroMoodBad => 'Schlecht';

  @override
  String get retroMoodNeutral => 'Neutral';

  @override
  String get retroMoodGood => 'Gut';

  @override
  String get retroMoodExcellent => 'Ausgezeichnet';

  @override
  String get actionSubmit => 'Senden';

  @override
  String get retroIcebreakerOneWordTitle => 'Icebreaker: Ein Wort';

  @override
  String get retroIcebreakerOneWordQuestion =>
      'Beschreibe diesen Sprint mit NUR einem Wort';

  @override
  String get retroIcebreakerOneWordHint => 'Dein Wort...';

  @override
  String get retroIcebreakerSubmitted => 'Gesendet!';

  @override
  String retroIcebreakerWordsSubmitted(int count) {
    return '$count Worte gesendet';
  }

  @override
  String get retroIcebreakerWeatherTitle => 'Icebreaker: Wetter';

  @override
  String get retroIcebreakerWeatherQuestion =>
      'Welches Wetter repräsentiert am besten dein Gefühl zu diesem Sprint?';

  @override
  String get retroWeatherSunny => 'Sonnig';

  @override
  String get retroWeatherPartlyCloudy => 'Teils bewölkt';

  @override
  String get retroWeatherCloudy => 'Bewölkt';

  @override
  String get retroWeatherRainy => 'Regnerisch';

  @override
  String get retroWeatherStormy => 'Stürmisch';

  @override
  String get retroAgileCoach => 'Agile Coach';

  @override
  String get retroCoachSetup =>
      'Wählen Sie ein Template. \"Start/Stop/Continue\" ist ideal für neue Teams. Stellen Sie sicher, dass alle anwesend sind.';

  @override
  String get retroCoachIcebreaker =>
      'Brechen Sie das Eis! Machen Sie eine kurze Runde mit der Frage \"Wie geht es euch?\" oder einer lustigen Frage.';

  @override
  String get retroCoachWriting =>
      'Wir befinden uns im INCOGNITO-Modus. Schreiben Sie Karten frei, niemand sieht Ihre Notizen bis zum Ende. Vermeiden Sie Beeinflussung!';

  @override
  String get retroCoachVoting =>
      'Review-Zeit! Alle Karten sind sichtbar. Lesen Sie diese und nutzen Sie Ihre 3 Stimmen, um zu entscheiden, worüber diskutiert werden soll.';

  @override
  String get retroCoachDiscuss =>
      'Fokus auf die meistgewählten Karten. Definieren Sie klare Action Items: Wer macht was bis wann?';

  @override
  String get retroCoachCompleted =>
      'Gute Arbeit! Die Retrospektive ist abgeschlossen. Die Action Items wurden ins Backlog übertragen.';

  @override
  String retroStep(int step, String title) {
    return 'Schritt $step: $title';
  }

  @override
  String retroCurrentFocus(String title) {
    return 'Aktueller Fokus: $title';
  }

  @override
  String get retroCanvasMinColumns =>
      'Das Template erfordert mindestens 4 Spalten (Sailboat-Stil)';

  @override
  String retroAddTo(String title) {
    return 'Hinzufügen zu $title';
  }

  @override
  String get retroNoColumnsConfigured => 'Keine Spalten konfiguriert.';

  @override
  String get retroNewActionItem => 'Neues Action Item';

  @override
  String get retroEditActionItem => 'Action Item bearbeiten';

  @override
  String get retroActionWhatToDo => 'Was muss getan werden?';

  @override
  String get retroActionDescriptionHint =>
      'Beschreiben Sie die konkrete Aktion...';

  @override
  String get retroActionRequired => 'Erforderlich';

  @override
  String get retroActionLinkedCard => 'Verknüpft mit Retro-Karte (Optional)';

  @override
  String get retroActionNone => 'Keine';

  @override
  String get retroActionType => 'Aktionstyp';

  @override
  String get retroActionNoType => 'Kein spezifischer Typ';

  @override
  String get retroActionAssignee => 'Zuständiger';

  @override
  String get retroActionNoAssignee => 'Niemand';

  @override
  String get retroActionPriority => 'Priorität';

  @override
  String get retroActionDueDate => 'Frist (Deadline)';

  @override
  String get retroActionSelectDate => 'Datum wählen...';

  @override
  String get retroActionSupportResources => 'Unterstützungsressourcen';

  @override
  String get retroActionResourcesHint =>
      'Tools, Budget, extra Personen benötigt...';

  @override
  String get retroActionMonitoring => 'Überwachungsmodus';

  @override
  String get retroActionMonitoringHint =>
      'Wie prüfen wir den Fortschritt? (Z.B. Daily, Review...)';

  @override
  String get retroActionResourcesShort => 'Res';

  @override
  String get retroTableRef => 'Ref.';

  @override
  String get retroTableSourceColumn => 'Spalte';

  @override
  String get retroTableDescription => 'Beschreibung';

  @override
  String get retroTableOwner => 'Besitzer';

  @override
  String get retroTablePriority => 'Priorität';

  @override
  String get retroTableDueDate => 'Frist';

  @override
  String get retroIcebreakerTwoTruths => 'Zwei Wahrheiten und eine Lüge';

  @override
  String get retroDescTwoTruths => 'Einfach und klassisch.';

  @override
  String get retroIcebreakerCheckin => 'Emotionaler Check-in';

  @override
  String get retroDescCheckin => 'Wie fühlen sich alle?';

  @override
  String get retroTableActions => 'Aktionen';

  @override
  String get retroSupportResources => 'Unterstützungsressourcen';

  @override
  String get retroMonitoringMethod => 'Überwachungsmethode';

  @override
  String get retroUnassigned => 'Nicht zugewiesen';

  @override
  String get retroDeleteActionItem => 'Action Item löschen';

  @override
  String get retroChooseMethodology => 'Methodik wählen';

  @override
  String get retroHidingWhileTyping => 'Während des Schreibens ausgeblendet...';

  @override
  String retroVoteLimitReached(int max) {
    return 'Du hast das Limit von $max Stimmen erreicht!';
  }

  @override
  String get retroAddCardHint => 'Was sind deine Gedanken?';

  @override
  String get retroAddCard => 'Karte hinzufügen';

  @override
  String get retroTimeUp => 'Zeit abgelaufen!';

  @override
  String get retroTimeUpMessage =>
      'Die Zeit für diese Phase ist abgelaufen. Beenden Sie die Diskussion oder verlängern Sie die Zeit.';

  @override
  String get retroTimeUpOk => 'Ok, verstanden';

  @override
  String get retroStopTimer => 'Timer stoppen';

  @override
  String get retroStartTimer => 'Timer starten';

  @override
  String retroTimerMinutes(int minutes) {
    return '$minutes Min';
  }

  @override
  String get retroAddCardButton => 'Karte hinzufügen';

  @override
  String get retroDeleteRetro => 'Retrospektive löschen';

  @override
  String get retroParticipantsLabel => 'Teilnehmer';

  @override
  String get retroNotesCreated => 'Notizen erstellt';

  @override
  String retroStatusLabel(String status) {
    return 'Status: $status';
  }

  @override
  String retroDateLabel(String date) {
    return 'Datum: $date';
  }

  @override
  String retroSprintDefault(int number) {
    return 'Sprint $number';
  }

  @override
  String get smartTodoNoTasks => 'Keine Aufgaben in dieser Liste';

  @override
  String get smartTodoNoTasksInColumn => 'Keine Aufgabe';

  @override
  String smartTodoCompletionStats(int completed, int total) {
    return '$completed/$total abgeschlossen';
  }

  @override
  String get smartTodoCreatedDate => 'Erstellungsdatum';

  @override
  String get smartTodoParticipantRole => 'Teilnehmer';

  @override
  String get smartTodoUnassigned => 'Nicht zugewiesen';

  @override
  String get smartTodoNewTask => 'Neue Aufgabe';

  @override
  String get smartTodoEditTask => 'Aufgabe bearbeiten';

  @override
  String get smartTodoTaskTitle => 'Aufgabentitel';

  @override
  String get smartTodoDescription => 'Beschreibung';

  @override
  String get smartTodoDescriptionHint =>
      'Detaillierte Beschreibung hinzufügen...';

  @override
  String get smartTodoChecklist => 'CHECKLISTE';

  @override
  String get smartTodoAddChecklistItem => 'Eintrag hinzufügen';

  @override
  String get smartTodoEditItem => 'Eintrag bearbeiten';

  @override
  String get smartTodoItemTitle => 'Eintragstitel';

  @override
  String get smartTodoAttachments => 'ANHÄNGE';

  @override
  String get smartTodoAddLink => 'Link hinzufügen';

  @override
  String get smartTodoComments => 'KOMMENTARE';

  @override
  String get smartTodoWriteComment => 'Kommentar schreiben...';

  @override
  String get smartTodoAddImageTooltip => 'Bild hinzufügen (URL)';

  @override
  String get smartTodoStatus => 'STATUS';

  @override
  String get smartTodoPriority => 'PRIORITÄT';

  @override
  String get smartTodoAssignees => 'ZUSTÄNDIGE';

  @override
  String get smartTodoNoAssignee => 'Niemand';

  @override
  String get smartTodoTags => 'TAGS';

  @override
  String get smartTodoNoTags => 'Keine Tags';

  @override
  String get smartTodoDueDate => 'FRIST';

  @override
  String get smartTodoSetDate => 'Datum festlegen';

  @override
  String get smartTodoEffort => 'EFFORT';

  @override
  String get smartTodoEffortHint => 'Punkte (Z.B. 5)';

  @override
  String get smartTodoAssignTo => 'Zuweisen an';

  @override
  String get smartTodoSelectTags => 'Tags auswählen';

  @override
  String get smartTodoNoTagsAvailable => 'Keine Tags verfügbar';

  @override
  String get smartTodoNewSubtask => 'Neuer Status';

  @override
  String get smartTodoAddLinkTitle => 'Link hinzufügen';

  @override
  String get smartTodoLinkName => 'Name';

  @override
  String get smartTodoLinkUrl => 'URL';

  @override
  String get smartTodoCannotOpenLink => 'Link kann nicht geöffnet werden';

  @override
  String get smartTodoPasteImage => 'Bild einfügen';

  @override
  String get smartTodoPasteImageFound =>
      'Bild aus der Zwischenablage gefunden.';

  @override
  String get smartTodoPasteImageConfirm =>
      'Möchten Sie dieses Bild aus Ihrer Zwischenablage hinzufügen?';

  @override
  String get smartTodoYesAdd => 'Ja, hinzufügen';

  @override
  String get smartTodoAddImage => 'Bild hinzufügen';

  @override
  String get smartTodoImageUrlHint =>
      'Bild-URL einfügen (z.B. von CleanShot/Gyazo)';

  @override
  String get smartTodoImageUrl => 'Bild-URL';

  @override
  String get smartTodoPasteFromClipboard => 'Aus Zwischenablage einfügen';

  @override
  String get smartTodoEditComment => 'Bearbeiten';

  @override
  String get smartTodoSortBy => 'Sortierung';

  @override
  String get smartTodoColumnSortTitle => 'Spalte sortieren';

  @override
  String get smartTodoPendingTasks => 'Zu erledigende Aufgaben';

  @override
  String get smartTodoCompletedTasks => 'Abgeschlossene Aufgaben';

  @override
  String get smartTodoEnterTitle => 'Titel eingeben';

  @override
  String get smartTodoUser => 'Benutzer';

  @override
  String get smartTodoImportTasks => 'Aufgaben importieren';

  @override
  String get smartTodoImportStep1 => 'Schritt 1: Quelle wählen';

  @override
  String get smartTodoImportStep2 => 'Schritt 2: Spalten zuordnen';

  @override
  String get smartTodoImportStep3 => 'Schritt 3: Überprüfung & Bestätigung';

  @override
  String get smartTodoImportRetry => 'Erneut versuchen';

  @override
  String get smartTodoImportPasteText => 'Text einfügen (CSV/Txt)';

  @override
  String get smartTodoImportUploadFile => 'Datei hochladen (CSV)';

  @override
  String get smartTodoImportPasteHint =>
      'Fügen Sie Ihre Aufgaben hier ein. Verwenden Sie Komma als Trennzeichen.';

  @override
  String get smartTodoImportPasteExample =>
      'Beispiel: \'Aufgabe 1, Aufgabe 2\'';

  @override
  String get smartTodoImportSelectFile => 'CSV-Datei auswählen';

  @override
  String smartTodoImportFileSelected(String fileName) {
    return 'Datei ausgewählt: $fileName';
  }

  @override
  String smartTodoImportFileError(String error) {
    return 'Fehler beim Lesen der Datei: $error';
  }

  @override
  String get smartTodoImportNoData => 'Keine Daten gefunden';

  @override
  String get smartTodoImportColumnMapping =>
      'Wir haben diese Spalten erkannt. Ordnen Sie jede Spalte dem korrekten Feld zu.';

  @override
  String smartTodoImportColumnLabel(int index, String value) {
    return 'Spalte $index: \"$value\"';
  }

  @override
  String smartTodoImportSampleValue(String value) {
    return 'Beispielwert: \"$value\"';
  }

  @override
  String smartTodoImportFoundTasks(int count) {
    return '$count gültige Aufgaben gefunden. Vor dem Import prüfen.';
  }

  @override
  String get smartTodoImportDestinationColumn => 'Ziel:';

  @override
  String get smartTodoImportBack => 'Zurück';

  @override
  String get smartTodoImportNext => 'Weiter';

  @override
  String smartTodoImportButton(int count) {
    return '$count Aufgaben importieren';
  }

  @override
  String get smartTodoImportEnterText =>
      'Text eingeben oder eine Datei hochladen.';

  @override
  String get smartTodoImportNoValidRows => 'Keine gültigen Zeilen gefunden.';

  @override
  String get smartTodoImportMapTitle =>
      'Sie müssen mindestens den \"Title\" zuordnen.';

  @override
  String smartTodoImportParsingError(String error) {
    return 'Parsing-Fehler: $error';
  }

  @override
  String smartTodoImportSuccess(int count) {
    return '$count Aufgaben importiert!';
  }

  @override
  String smartTodoImportError(String error) {
    return 'Unmöglicher Fehler: $error';
  }

  @override
  String get smartTodoImportHelpTitle => 'Wie importiere ich Aufgaben?';

  @override
  String get smartTodoImportHelpSimpleTitle =>
      'Einfache Liste (eine Aufgabe pro Zeile)';

  @override
  String get smartTodoImportHelpSimpleDesc =>
      'Fügen Sie eine einfache Liste mit einem Titel pro Zeile ein. Jede Zeile wird zu einer Aufgabe.';

  @override
  String get smartTodoImportHelpSimpleExample =>
      'Milch kaufen\nMario anrufen\nReport beenden';

  @override
  String get smartTodoImportHelpCsvTitle => 'CSV-Format (mit Spalten)';

  @override
  String get smartTodoImportHelpCsvDesc =>
      'Verwenden Sie kommagetrennte Werte mit einer Kopfzeile. Die erste Zeile definiert die Spalten.';

  @override
  String get smartTodoImportHelpCsvExample =>
      'title,priority,assignee\nMilch kaufen,high,mario@email.com\nMario anrufen,medium,';

  @override
  String get smartTodoImportHelpFieldsTitle => 'Verfügbare Felder:';

  @override
  String get smartTodoImportHelpFieldTitle => 'Aufgabentitel (erforderlich)';

  @override
  String get smartTodoImportHelpFieldDesc => 'Aufgabenbeschreibung';

  @override
  String get smartTodoImportHelpFieldPriority =>
      'high, medium, low (oder hoch, mittel, niedrig)';

  @override
  String get smartTodoImportHelpFieldStatus =>
      'Spaltenname (Z.B. To Do, In Arbeit)';

  @override
  String get smartTodoImportHelpFieldAssignee => 'Benutzer-E-Mail';

  @override
  String get smartTodoImportHelpFieldEffort => 'Stunden (Zahl)';

  @override
  String get smartTodoImportHelpFieldTags => 'Tag (#tag oder kommagetrennt)';

  @override
  String smartTodoImportStatusHint(String columns) {
    return 'Verfügbare Spalten für STATUS: $columns';
  }

  @override
  String get smartTodoImportEmptyColumn => '(leere Spalte)';

  @override
  String get smartTodoImportFieldIgnore => '-- Ignorieren --';

  @override
  String get smartTodoImportFieldTitle => 'Titel';

  @override
  String get smartTodoImportFieldDescription => 'Beschreibung';

  @override
  String get smartTodoImportFieldPriority => 'Priorität';

  @override
  String get smartTodoImportFieldStatus => 'Status (Spalte)';

  @override
  String get smartTodoImportFieldAssignee => 'Zuständiger';

  @override
  String get smartTodoImportFieldEffort => 'Effort';

  @override
  String get smartTodoImportFieldTags => 'Tags';

  @override
  String get smartTodoDeleteTaskTitle => 'Aufgabe löschen';

  @override
  String get smartTodoDeleteTaskContent =>
      'Sind Sie sicher, dass Sie diese Aufgabe löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get smartTodoDeleteNoPermission =>
      'Sie haben keine Berechtigung, diese Aufgabe zu löschen';

  @override
  String get smartTodoSheetsExportTitle => 'Google Sheets Export';

  @override
  String get smartTodoSheetsExportExists =>
      'Es existiert bereits ein Google Sheets Dokument für diese Liste.';

  @override
  String get smartTodoSheetsOpen => 'Öffnen';

  @override
  String get smartTodoSheetsUpdate => 'Aktualisieren';

  @override
  String get smartTodoSheetsUpdating => 'Google Sheets Aktualisierung läuft...';

  @override
  String get smartTodoSheetsCreating => 'Google Sheets Erstellung läuft...';

  @override
  String get smartTodoSheetsUpdated => 'Google Sheets aktualisiert!';

  @override
  String get smartTodoSheetsCreated => 'Google Sheets erstellt!';

  @override
  String get smartTodoSheetsError => 'Fehler beim Export (siehe Log)';

  @override
  String get error => 'Fehler';

  @override
  String smartTodoAuditLogTitle(String title) {
    return 'Audit Log - $title';
  }

  @override
  String get smartTodoAuditFilterUser => 'Benutzer';

  @override
  String get smartTodoAuditFilterType => 'Typ';

  @override
  String get smartTodoAuditFilterAction => 'Aktion';

  @override
  String get smartTodoAuditFilterTag => 'Tag';

  @override
  String get smartTodoAuditFilterSearch => 'Suche';

  @override
  String get smartTodoAuditFilterAll => 'Alle';

  @override
  String get smartTodoAuditFilterAllFemale => 'Alle';

  @override
  String get smartTodoAuditPremiumRequired =>
      'Premium erforderlich für erweiterten Verlauf';

  @override
  String smartTodoAuditLastDays(int days) {
    return 'Letzte $days Tage';
  }

  @override
  String get smartTodoAuditClearFilters => 'Filter löschen';

  @override
  String get smartTodoAuditViewTimeline => 'Timeline-Ansicht';

  @override
  String get smartTodoAuditViewColumns => 'Spaltenansicht';

  @override
  String get smartTodoAuditNoActivity => 'Keine Aktivitäten aufgezeichnet';

  @override
  String get smartTodoAuditNoResults =>
      'Keine Ergebnisse für die gewählten Filter';

  @override
  String smartTodoAuditActivities(int count) {
    return '$count Aktivitäten';
  }

  @override
  String get smartTodoAuditNoUserActivity => 'Keine Aktivität';

  @override
  String get smartTodoAuditLoadMore => 'Lade weitere 50...';

  @override
  String get smartTodoAuditEmptyValue => '(leer)';

  @override
  String get smartTodoAuditEntityList => 'Liste';

  @override
  String get smartTodoAuditEntityTask => 'Aufgabe';

  @override
  String get smartTodoAuditEntityInvite => 'Einladung';

  @override
  String get smartTodoAuditEntityParticipant => 'Teilnehmer';

  @override
  String get smartTodoAuditEntityColumn => 'Spalte';

  @override
  String get smartTodoAuditEntityTag => 'Tag';

  @override
  String get smartTodoAuditActionCreate => 'Erstellt';

  @override
  String get smartTodoAuditActionUpdate => 'Geändert';

  @override
  String get smartTodoAuditActionDelete => 'Gelöscht';

  @override
  String get smartTodoAuditActionArchive => 'Archiviert';

  @override
  String get smartTodoAuditActionRestore => 'Wiederhergestellt';

  @override
  String get smartTodoAuditActionMove => 'Verschoben';

  @override
  String get smartTodoAuditActionAssign => 'Zugewiesen';

  @override
  String get smartTodoAuditActionInvite => 'Eingeladen';

  @override
  String get smartTodoAuditActionJoin => 'Beigetreten';

  @override
  String get smartTodoAuditActionRevoke => 'Widerrufen';

  @override
  String get smartTodoAuditActionReorder => 'Neu geordnet';

  @override
  String get smartTodoAuditActionBatchCreate => 'Import';

  @override
  String get smartTodoAuditTimeNow => 'Jetzt';

  @override
  String smartTodoAuditTimeMinutesAgo(int count) {
    return 'vor $count Min';
  }

  @override
  String smartTodoAuditTimeHoursAgo(int count) {
    return 'vor $count Std';
  }

  @override
  String smartTodoAuditTimeDaysAgo(int count) {
    return 'vor $count Tagen';
  }

  @override
  String get smartTodoCfdTitle => 'CFD Analytics';

  @override
  String get smartTodoCfdTooltip => 'CFD Analytics';

  @override
  String get smartTodoCfdDateRange => 'Zeitraum:';

  @override
  String get smartTodoCfd7Days => '7 Tage';

  @override
  String get smartTodoCfd14Days => '14 Tage';

  @override
  String get smartTodoCfd30Days => '30 Tage';

  @override
  String get smartTodoCfd90Days => '90 Tage';

  @override
  String get smartTodoCfdError => 'Fehler beim Laden';

  @override
  String get smartTodoCfdRetry => 'Aktualisieren';

  @override
  String get smartTodoCfdNoData => 'Keine Daten verfügbar';

  @override
  String get smartTodoCfdNoDataHint =>
      'Aufgabenbewegungen werden hier verfolgt';

  @override
  String get smartTodoCfdKeyMetrics => 'Schlüssel-Metriken';

  @override
  String get smartTodoCfdLeadTime => 'Lead Time';

  @override
  String get smartTodoCfdLeadTimeTooltip => 'Zeit von Erstellung bis Abschluss';

  @override
  String get smartTodoCfdCycleTime => 'Cycle Time';

  @override
  String get smartTodoCfdCycleTimeTooltip =>
      'Zeit von Arbeitsbeginn bis Abschluss';

  @override
  String get smartTodoCfdThroughput => 'Throughput';

  @override
  String get smartTodoCfdThroughputTooltip =>
      'Abgeschlossene Aufgaben pro Woche';

  @override
  String get smartTodoCfdWip => 'WIP';

  @override
  String get smartTodoCfdWipTooltip => 'Laufende Arbeit';

  @override
  String get smartTodoCfdLimit => 'Limit';

  @override
  String get smartTodoCfdCompleted => 'abgeschlossen';

  @override
  String get smartTodoCfdFlowAnalysis => 'Flussanalyse';

  @override
  String get smartTodoCfdArrived => 'Eingetroffen';

  @override
  String get smartTodoCfdBacklogShrinking => 'Backlog schrumpft';

  @override
  String get smartTodoCfdBacklogGrowing => 'Backlog wächst';

  @override
  String get smartTodoCfdBottlenecks => 'Engpass-Erkennung';

  @override
  String get smartTodoCfdNoBottlenecks => 'Keine Engpässe';

  @override
  String get smartTodoCfdTasks => 'Aufgaben';

  @override
  String get smartTodoCfdAvgAge => 'Durchschnittsalter';

  @override
  String get smartTodoCfdAgingWip => 'Veraltete laufende Arbeit';

  @override
  String get smartTodoCfdTask => 'Aufgabe';

  @override
  String get smartTodoCfdColumn => 'Spalte';

  @override
  String get smartTodoCfdAge => 'Alter';

  @override
  String get smartTodoCfdDays => 'Tage';

  @override
  String get smartTodoCfdHowCalculated => 'Wie wird das berechnet?';

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
  String get smartTodoCfdSample => 'Stichprobe';

  @override
  String get smartTodoCfdVsPrevious => 'vs Vorzeitraum';

  @override
  String get smartTodoCfdArrivalRate => 'Eingangsrate';

  @override
  String get smartTodoCfdCompletionRate => 'Abschlussrate';

  @override
  String get smartTodoCfdNetFlow => 'Nettofluss';

  @override
  String get smartTodoCfdPerDay => '/Tag';

  @override
  String get smartTodoCfdPerWeek => '/Woche';

  @override
  String get smartTodoCfdSeverity => 'Schweregrad';

  @override
  String get smartTodoCfdAssignee => 'Zuständiger';

  @override
  String get smartTodoCfdUnassigned => 'Nicht zugewiesen';

  @override
  String get smartTodoCfdLeadTimeExplanation =>
      'Die Lead Time misst die Gesamtzeit von der Erstellung einer Aufgabe bis zu ihrem Abschluss.\n\n**Formel:**\nLead Time = Abschlussdatum - Erstellungsdatum\n\n**Metriken:**\n- **Durchschnitt**: Mittelwert aller Lead Times\n- **Median**: Mittlerer Wert (unempfindlicher gegen Ausreißer)\n- **P85**: 85% der Aufgaben werden innerhalb dieser Zeit abgeschlossen\n- **P95**: 95% der Aufgaben werden innerhalb dieser Zeit abgeschlossen\n\n**Warum es wichtig ist:**\nDie Lead Time repräsentiert die Kundenerfahrung - die gesamte Wartezeit. Nutzen Sie den P85 für Lieferzeit-Prognosen für Kunden.';

  @override
  String get smartTodoCfdCycleTimeExplanation =>
      'Die Cycle Time misst die Zeit von dem Moment, in dem die Arbeit tatsächlich beginnt (Aufgabe verlässt \'To Do\'), bis zum Abschluss.\n\n**Formel:**\nCycle Time = Abschlussdatum - Arbeitsbeginn-Datum\n\n**Unterschied zur Lead Time:**\n- **Lead Time** = Kundenperspektive (inklusive Warten)\n- **Cycle Time** = Teamperspektive (nur aktive Arbeit)\n\n**Wie wird \'Arbeitsbeginn\' erkannt:**\nDas erste Mal, wenn eine Aufgabe die Spalte \'To Do\' verlässt, wird als Arbeitsbeginn-Datum registriert.';

  @override
  String get smartTodoCfdThroughputExplanation =>
      'Der Throughput misst, wie viele Aufgaben pro Zeiteinheit abgeschlossen werden.\n\n**Formeln:**\n- Tagesschnitt = Abgeschlossene Aufgaben / Tage im Zeitraum\n- Wochenschritt = Tagesschnitt x 7\n\n**Wie man es nutzt:**\nLiefertermin-Prognose:\nVerbleibende Aufgaben / Wochen-Throughput = Wochen bis zum Abschluss\n\n**Beispiel:**\n30 verbleibende Aufgaben, Throughput von 10/Woche = ~3 Wochen';

  @override
  String get smartTodoCfdWipExplanation =>
      'WIP (Work In Progress) zählt die aktuell in Bearbeitung befindlichen Aufgaben - nicht in \'To Do\' und nicht in \'Erledigt\'.\n\n**Formel:**\nWIP = Aufgaben gesamt - Aufgaben in To Do - Aufgaben in Erledigt\n\n**Little\'s Law:**\nLead Time = WIP / Throughput\n\nEine Reduzierung des WIP reduziert direkt die Lead Time!\n\n**Empfohlenes WIP-Limit:**\nTeamgröße x 2 (Best Practice Kanban)\n\n**Status:**\n- Gesund: WIP <= Limit\n- Vorsicht: WIP > Limit x 1.25\n- Kritisch: WIP > Limit x 1.5';

  @override
  String get smartTodoCfdFlowExplanation =>
      'Die Flussanalyse vergleicht die Eingangsrate neuer Aufgaben mit der Rate der abgeschlossenen Aufgaben.\n\n**Formeln:**\n- Eingangsrate = Neu erstellte Aufgaben / Tage\n- Abschlussrate = Abgeschlossene Aufgaben / Tage\n- Nettofluss = Abgeschlossen - Eingetroffen\n\n**Status-Interpretation:**\n- **Leert sich** (Abschluss > Eingang): WIP schrumpft - gut!\n- **Ausgeglichen** (innerhalb +/-10%): Stabiler Fluss\n- **Füllt sich** (Eingang > Abschluss): WIP wächst - Aktion erforderlich';

  @override
  String get smartTodoCfdBottleneckExplanation =>
      'Die Engpass-Erkennung identifiziert Spalten, in denen sich Aufgaben ansammeln oder zu lange bleiben.\n\n**Algorithmus:**\nSchweregrad = (Zähl-Score + Alter-Score) / 2\n\nWobei:\n- Zähl-Score = Aufgaben in Spalte / 10\n- Alter-Score = Durchschnittsalter / 7 Tage\n\n**Gemeldet wenn:**\n- 2+ Aufgaben in Spalte, ODER\n- Durchschnittsalter > 2 Tage\n\n**Schweregrade:**\n- Niedrig (< 0.3): Beobachten\n- Mittel (0.3-0.6): Untersuchen\n- Hoch (> 0.6): Eingreifen';

  @override
  String get smartTodoCfdAgingExplanation =>
      'Aging WIP zeigt die aktuell in Bearbeitung befindlichen Aufgaben, sortiert nach der Bearbeitungsdauer.\n\n**Formel:**\nAlter = Jetzt - Arbeitsbeginn-Datum (in Tagen)\n\n**Status nach Alter:**\n- Frisch (< 3 Tage): Normal\n- Vorsicht (3-7 Tage): Könnte Aufmerksamkeit erfordern\n- Kritisch (> 7 Tage): Wahrscheinlich blockiert - untersuchen!\n\nAlte Aufgaben deuten oft auf Blockaden, unklare Anforderungen oder Scope Creep hin.';

  @override
  String get smartTodoCfdTeamBalance => 'Team-Balance';

  @override
  String get smartTodoCfdTeamBalanceExplanation =>
      'Die Team-Balance zeigt die Verteilung der Aufgaben unter den Mitgliedern.\n\n**Balance-Score:**\nBerechnet mittels Variationskoeffizient (CV).\nPunktezahl = 1 / (1 + CV)\n\n**Status:**\n- Ausgeglichen (≥80%): Arbeit gleichmäßig verteilt\n- Uneinheitlich (50-80%): Gewisse Ungleichgewichte\n- Unaustariert (<50%): Signifikante Disparität\n\n**Spalten:**\n- To Do: Wartende Aufgaben\n- WIP: Aufgaben in Bearbeitung\n- Erledigt: Abgeschlossene Aufgaben';

  @override
  String get smartTodoCfdBalanced => 'Ausgeglichen';

  @override
  String get smartTodoCfdUneven => 'Uneinheitlich';

  @override
  String get smartTodoCfdImbalanced => 'Unaustariert';

  @override
  String get smartTodoCfdMember => 'Mitglied';

  @override
  String get smartTodoCfdTotal => 'Gesamt';

  @override
  String get smartTodoCfdToDo => 'To Do';

  @override
  String get smartTodoCfdInProgress => 'In Arbeit';

  @override
  String get smartTodoCfdDone => 'Erledigt';

  @override
  String get smartTodoNewTaskDefault => 'Neue Aufgabe';

  @override
  String get smartTodoRename => 'Umbenennen';

  @override
  String get smartTodoAddActivity => 'Aufgabe hinzufügen';

  @override
  String get smartTodoAddColumn => 'Spalte hinzufügen';

  @override
  String get smartTodoParticipantManagement => 'Teilnehmerverwaltung';

  @override
  String get smartTodoParticipantsTab => 'Teilnehmer';

  @override
  String get smartTodoInvitesTab => 'Einladungen';

  @override
  String get smartTodoAddParticipant => 'Teilnehmer hinzufügen';

  @override
  String smartTodoMembers(int count) {
    return 'Mitglieder ($count)';
  }

  @override
  String get smartTodoNoInvitesPending => 'Keine ausstehenden Einladungen';

  @override
  String smartTodoRoleLabel(String role) {
    return 'Rolle: $role';
  }

  @override
  String get smartTodoExpired => 'ABGELAUFEN';

  @override
  String smartTodoSentBy(String name) {
    return 'Gesendet von $name';
  }

  @override
  String get smartTodoResendEmail => 'E-Mail erneut senden';

  @override
  String get smartTodoRevoke => 'Widerrufen';

  @override
  String get smartTodoSendingEmail => 'Sende E-Mail...';

  @override
  String get smartTodoEmailResent => 'E-Mail erneut gesendet!';

  @override
  String get smartTodoEmailSendError => 'Fehler beim Senden.';

  @override
  String get smartTodoInvalidSession =>
      'Ungültige Sitzung zum Senden der E-Mail.';

  @override
  String get smartTodoEmail => 'E-Mail';

  @override
  String get smartTodoRole => 'Rolle';

  @override
  String get smartTodoInviteCreated =>
      'Einladung erstellt und erfolgreich gesendet!';

  @override
  String get smartTodoInviteCreatedNoEmail =>
      'Einladung erstellt, aber E-Mail nicht gesendet (Login/Google-Berechtigungen prüfen).';

  @override
  String get smartTodoUserAlreadyInvited => 'Benutzer bereits eingeladen.';

  @override
  String get smartTodoInviteCollaborator => 'Mitarbeiter einladen';

  @override
  String get smartTodoEditorRole => 'Editor (Kann bearbeiten)';

  @override
  String get smartTodoViewerRole => 'Viewer (Nur Ansicht)';

  @override
  String get smartTodoSendEmailNotification => 'E-Mail-Benachrichtigung senden';

  @override
  String get smartTodoSend => 'Senden';

  @override
  String get smartTodoInvalidEmail => 'Ungültige E-Mail';

  @override
  String get smartTodoUserNotAuthenticated =>
      'Benutzer nicht authentifiziert oder E-Mail fehlt';

  @override
  String get smartTodoGoogleLoginRequired =>
      'Google-Login erforderlich, um E-Mails zu senden';

  @override
  String smartTodoInviteSent(String email) {
    return 'Einladung an $email gesendet';
  }

  @override
  String get smartTodoUserAlreadyInvitedOrPending =>
      'Benutzer bereits eingeladen oder Einladung ausstehend.';

  @override
  String get smartTodoFilterToday => 'Heute';

  @override
  String get smartTodoFilterMyTasks => 'Meine Aufgaben';

  @override
  String get smartTodoFilterOwner => 'Owner';

  @override
  String get smartTodoViewGlobalTasks => 'Globale Aufgaben sehen';

  @override
  String get smartTodoViewLists => 'Listen sehen';

  @override
  String get smartTodoNewListDialogTitle => 'Neue Liste';

  @override
  String get smartTodoTitleLabel => 'Titel *';

  @override
  String get smartTodoDescriptionLabel => 'Beschreibung';

  @override
  String get smartTodoCancel => 'Abbrechen';

  @override
  String get smartTodoCreate => 'Erstellen';

  @override
  String get smartTodoSave => 'Speichern';

  @override
  String get smartTodoNoListsPresent => 'Keine Listen vorhanden';

  @override
  String get smartTodoCreateFirstList =>
      'Erstellen Sie Ihre erste Liste, um zu beginnen';

  @override
  String smartTodoMembersCount(int count) {
    return '$count Mitglieder';
  }

  @override
  String get smartTodoRenameListTitle => 'Liste umbenennen';

  @override
  String get smartTodoNewNameLabel => 'Neuer Name';

  @override
  String get smartTodoDeleteListTitle => 'Liste löschen';

  @override
  String get smartTodoDeleteListConfirm =>
      'Sind Sie sicher, dass Sie diese Liste und alle ihre Aufgaben löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get smartTodoDelete => 'Löschen';

  @override
  String get smartTodoEdit => 'Bearbeiten';

  @override
  String get smartTodoSearchHint => 'Listen suchen...';

  @override
  String get smartTodoSearchTasksHint => 'Suchen...';

  @override
  String smartTodoNoSearchResults(String query) {
    return 'Keine Ergebnisse für \"$query\"';
  }

  @override
  String get smartTodoColumnTodo => 'Zu erledigen';

  @override
  String get smartTodoColumnInProgress => 'In Arbeit';

  @override
  String get smartTodoColumnDone => 'Erledigt';

  @override
  String get smartTodoAllPeople => 'Alle Personen';

  @override
  String smartTodoPeopleCount(int count) {
    return '$count Personen';
  }

  @override
  String get smartTodoFilterByPerson => 'Nach Person filtern';

  @override
  String get smartTodoApplyFilters => 'Filter anwenden';

  @override
  String get smartTodoAllTags => 'Alle Tags';

  @override
  String smartTodoTagsCount(int count) {
    return '$count Tags';
  }

  @override
  String get smartTodoFilterByTag => 'Nach Tag filtern';

  @override
  String get smartTodoTagAlreadyExists => 'Tag existiert bereits';

  @override
  String smartTodoError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get profileMenuTitle => 'Profil';

  @override
  String get profileMenuLogout => 'Abmelden';

  @override
  String get profileLogoutDialogTitle => 'Abmelden';

  @override
  String get profileLogoutDialogConfirm =>
      'Sind Sie sicher, dass Sie sich abmelden möchten?';

  @override
  String get agileAddToSprint => 'Zum Sprint hinzufügen';

  @override
  String get agileEstimated => 'Geschätzt';

  @override
  String get agilePoints => 'Pt';

  @override
  String agilePointsValue(int points) {
    return '$points Pt';
  }

  @override
  String get agileGuide => 'Leitfaden';

  @override
  String get backlogProductBacklog => 'Product Backlog';

  @override
  String get backlogArchiveCompleted => 'Abgeschlossene Archiv';

  @override
  String get backlogStories => 'Stories';

  @override
  String get backlogEstimated => 'geschätzt';

  @override
  String get backlogShowActive => 'Aktives Backlog anzeigen';

  @override
  String backlogShowArchive(int count) {
    return 'Archiv anzeigen ($count abgeschlossen)';
  }

  @override
  String get backlogTab => 'Backlog';

  @override
  String backlogArchiveTab(int count) {
    return 'Archiv ($count)';
  }

  @override
  String get backlogFilters => 'Filter';

  @override
  String get backlogNewStory => 'Neue Story';

  @override
  String get backlogSearchHint => 'Suche nach Titel, Beschreibung oder ID...';

  @override
  String get backlogStatusFilter => 'Status: ';

  @override
  String get backlogPriorityFilter => 'Priorität: ';

  @override
  String get backlogTagFilter => 'Tag: ';

  @override
  String get backlogAllStatuses => 'Alle';

  @override
  String get backlogAllPriorities => 'Alle';

  @override
  String get backlogRemoveFilters => 'Filter entfernen';

  @override
  String get backlogNoStoryFound => 'Keine Story gefunden';

  @override
  String get sprintBacklog => 'Sprint Backlog';

  @override
  String get scrumToDo => 'To Do';

  @override
  String get agileStatusRefinement => 'Refining';

  @override
  String get agileStatusReady => 'Bereit';

  @override
  String get agileStatusInProgress => 'In Arbeit';

  @override
  String get agileStatusInReview => 'In Review';

  @override
  String get agileStatusDone => 'Erledigt';

  @override
  String get backlog => 'Backlog';

  @override
  String get kanbanPolicySortPriority => 'Nach Business-Priorität sortieren';

  @override
  String get kanbanPolicyMax2Days => 'Max 2 Tage in dieser Spalte';

  @override
  String get kanbanPolicyReqAcceptance =>
      'Erfordert definierte Abnahmekriterien';

  @override
  String get kanbanPolicyItemReady => 'Item ist bereit zur Bearbeitung';

  @override
  String get kanbanPolicyEstimationsDone =>
      'Schätzung abgeschlossen (falls erforderlich)';

  @override
  String get kanbanPolicyMax1PerPerson => 'Max 1 Item pro Person';

  @override
  String kanbanPolicyMax1PerPersonParam(int count) {
    return 'Max $count Items pro Person';
  }

  @override
  String get kanbanPolicyDailyUpdate => 'Tägliches Update obligatorisch';

  @override
  String get kanbanPolicyMax24h => 'Max 24h in dieser Spalte';

  @override
  String kanbanPolicyMaxHoursParam(int count) {
    return 'Max $count Stunden in dieser Spalte';
  }

  @override
  String kanbanPolicyMaxDaysParam(int count) {
    return 'Max $count Tage in dieser Spalte';
  }

  @override
  String get kanbanPolicyReqCodeReview => 'Erfordert genehmigte Code-Review';

  @override
  String get kanbanPolicyAllAcceptanceMet => 'Alle Abnahmekriterien erfüllt';

  @override
  String get kanbanPolicyCheckTitle => 'Policy-Prüfung';

  @override
  String get kanbanPolicyCheckMessage =>
      'Diese Aktion verletzt folgende Policies:';

  @override
  String get kanbanPolicyCheckProceed => 'Trotzdem fortfahren';

  @override
  String get kanbanPolicyCheckCancel => 'Abbrechen und korrigieren';

  @override
  String get kanbanPolicyActiveLabel => 'Prüfung aktiv';

  @override
  String get kanbanPolicyViolationTitle => 'Policy-Verletzung';

  @override
  String get kanbanPolicyViolationMessage => 'Das Verschieben von ';

  @override
  String get kanbanPolicyViolationTo => ' nach ';

  @override
  String get kanbanPolicyViolationViolations => ' verletzt:';

  @override
  String get kanbanPolicySettingMaxHours => 'Max Stunden';

  @override
  String get kanbanPolicySettingMaxDays => 'Max Tage';

  @override
  String get kanbanPolicySettingMaxItems => 'Max Items';

  @override
  String get kanbanPolicyUnitHours => 'Stunden';

  @override
  String get kanbanPolicyUnitDays => 'Tage';

  @override
  String get kanbanPolicyHelpConfigurable =>
      'Jede Spalte kann nun individuelle Zeitlimits und WIP-Grenzwerte haben.';

  @override
  String get kanbanPolicyMovingTip =>
      'Sie können fortfahren, wenn Sie dies für eine gültige Ausnahme halten.';

  @override
  String get kanbanMoveAnyway => 'Trotzdem verschieben';

  @override
  String get backlogEmpty => 'Backlog leer';

  @override
  String get backlogAddFirstStory => 'Fügen Sie die erste User Story hinzu';

  @override
  String get kanbanWipExceeded =>
      'WIP-Limit überschritten! Schließen Sie einige Items ab, bevor Sie neue beginnen.';

  @override
  String get kanbanInfo => 'Info';

  @override
  String get kanbanConfigureWip => 'WIP konfigurieren';

  @override
  String kanbanWipTooltip(int current, int max) {
    return 'WIP: $current von $max max';
  }

  @override
  String get kanbanNoWipLimit => 'Kein WIP-Limit';

  @override
  String get kanbanWipWhyTitle => 'Warum diese nutzen?';

  @override
  String get kanbanWipReasonFocus =>
      'Reduziert Multitasking und erhöht den Fokus';

  @override
  String get kanbanWipReasonBottlenecks => 'Macht Engpässe sichtbar';

  @override
  String get kanbanWipReasonFlow => 'Verbessert den Arbeitsfluss';

  @override
  String get kanbanWipReasonSpeed => 'Beschleunigt den Abschluss von Items';

  @override
  String get kanbanWipOverLimitTitle =>
      'Was tun, wenn ein Limit überschritten ist?';

  @override
  String get kanbanWipOverLimitStep1 =>
      '1. Schließe bestehende Items ab, bevor du neue beginnst';

  @override
  String get kanbanWipOverLimitStep2 => '2. Hilf Kollegen bei Items im Review';

  @override
  String get kanbanWipOverLimitStep3 =>
      '3. Analysiere, warum das Limit überschritten wurde';

  @override
  String get kanbanWipMovingTip =>
      'Tipp: Schließe andere Items ab oder verschiebe sie, bevor du neue beginnst, um einen optimalen Fluss zu erhalten.';

  @override
  String kanbanItems(int count) {
    return '$count Items';
  }

  @override
  String get kanbanEmpty => 'Leer';

  @override
  String kanbanWipLimitTitle(String column) {
    return 'WIP-Limit: $column';
  }

  @override
  String get kanbanWipLimitDesc =>
      'Legen Sie die maximale Anzahl an Items fest, die sich gleichzeitig in dieser Spalte befinden dürfen.';

  @override
  String get kanbanWipLimitLabel => 'WIP-Limit';

  @override
  String get kanbanWipLimitHint => 'Leer lassen für kein Limit';

  @override
  String kanbanWipLimitSuggestion(int count) {
    return 'Tipp: Starte mit $count und passe es für das Team an.';
  }

  @override
  String get kanbanRemoveLimit => 'Limit entfernen';

  @override
  String get kanbanWipExceededTitle => 'WIP-Limit überschritten';

  @override
  String get kanbanWipExceededMessage => 'Verschieben von ';

  @override
  String get kanbanWipExceededIn => ' nach ';

  @override
  String get kanbanWipExceededWillExceed =>
      ' wird das WIP-Limit überschreiten.';

  @override
  String kanbanColumnLabel(String name) {
    return 'Spalte: $name';
  }

  @override
  String kanbanCurrentCount(int current, int limit) {
    return 'Aktuell: $current | Limit: $limit';
  }

  @override
  String kanbanAfterMove(int count) {
    return 'Nach dem Verschieben: $count';
  }

  @override
  String get kanbanSuggestion =>
      'Tipp: Schließe andere Items ab oder verschiebe sie, bevor du neue beginnst, um einen optimalen Fluss zu erhalten.';

  @override
  String get kanbanWipExplanationTitle => 'Was sind WIP-Limits?';

  @override
  String get kanbanWipWhat => 'Was sind WIP-Limits?';

  @override
  String get kanbanWipWhatDesc =>
      'WIP (Work In Progress) Limits sind Begrenzungen für die Anzahl der Items, die gleichzeitig in einer Spalte sein dürfen.';

  @override
  String get kanbanWipWhy => 'Warum nutzen?';

  @override
  String get kanbanWipBenefit1 => '- Reduzieren Multitasking und Fokus';

  @override
  String get kanbanWipBenefit2 => '- Zeigen Engpässe auf';

  @override
  String get kanbanWipBenefit3 => '- Verbessern den Workflow';

  @override
  String get kanbanWipBenefit4 => '- Beschleunigen den Abschluss';

  @override
  String get kanbanWipWhatToDo => 'Was tun bei Überschreitung?';

  @override
  String get kanbanWipWhatToDoDesc =>
      '1. Schließe Items ab, bevor du neue startest\n2. Hilf beim Lösen von Blockaden im Review\n3. Analysiere die Ursache';

  @override
  String get kanbanUnderstood => 'Verstanden';

  @override
  String sprintTitle(int count) {
    return 'Sprint ($count)';
  }

  @override
  String get sprintNew => 'Neuer Sprint';

  @override
  String get sprintNoSprints => 'Keine Sprints';

  @override
  String get sprintCreateFirst => 'Ertelle den ersten Sprint, um zu beginnen';

  @override
  String sprintNumber(int number) {
    return 'Sprint $number';
  }

  @override
  String get sprintStart => 'Sprint starten';

  @override
  String get sprintComplete => 'Sprint abschließen';

  @override
  String sprintDays(int days) {
    return '${days}T';
  }

  @override
  String sprintStoriesCount(int count) {
    return '$count';
  }

  @override
  String get sprintStoriesLabel => 'Stories';

  @override
  String get sprintPointsPlanned => 'Pt';

  @override
  String get sprintPointsCompleted => 'abgeschlossen';

  @override
  String get sprintVelocity => 'Velocity';

  @override
  String sprintDaysRemaining(int days) {
    return '${days}T verbleibend';
  }

  @override
  String get sprintStartButton => 'Starten';

  @override
  String get sprintCompleteActiveFirst =>
      'Schließen Sie den aktiven Sprint ab, bevor Sie einen neuen starten';

  @override
  String get sprintPlanningAlreadyExists =>
      'Es existiert bereits ein Sprint in Planung. Löschen oder starten Sie diesen zuerst.';

  @override
  String get sprintDeletePlanningTitle => 'Sprint-Planung löschen';

  @override
  String sprintDeletePlanningConfirm(String sprintName) {
    return 'Möchten Sie den Sprint \"$sprintName\" löschen? Die zugeordneten Stories kehren ins Backlog zurück.';
  }

  @override
  String sprintDeletedSuccess(String sprintName) {
    return 'Sprint \"$sprintName\" gelöscht. Stories wurden ins Backlog verschoben.';
  }

  @override
  String get sprintEditTitle => 'Sprint bearbeiten';

  @override
  String get sprintNewTitle => 'Neuer Sprint';

  @override
  String get sprintNameLabel => 'Sprint-Name';

  @override
  String get sprintNameHint => 'z.B. Sprint 1 - MVP';

  @override
  String get sprintNameRequired => 'Namen eingeben';

  @override
  String get sprintGoalLabel => 'Sprint-Ziel';

  @override
  String get sprintGoalHint => 'Ziel dieses Sprints';

  @override
  String get sprintStartDateLabel => 'Startdatum';

  @override
  String get sprintEndDateLabel => 'Enddatum';

  @override
  String sprintDuration(int days) {
    return 'Dauer: $days Tage';
  }

  @override
  String sprintAverageVelocity(String velocity) {
    return 'Durschn. Velocity: $velocity Pt/Sprint';
  }

  @override
  String sprintTeamMembers(int count) {
    return 'Team: $count Mitglieder';
  }

  @override
  String get sprintPlanningTitle => 'Sprint Planning';

  @override
  String get sprintPlanningSubtitle =>
      'Wählen Sie die Stories für diesen Sprint aus';

  @override
  String get sprintPlanningSelected => 'Ausgewählt';

  @override
  String get sprintPlanningSuggested => 'Vorgeschlagen';

  @override
  String get sprintPlanningCapacity => 'Kapazität';

  @override
  String get sprintPlanningBasedOnVelocity => 'basiert auf durschn. Velocity';

  @override
  String sprintPlanningDays(int days) {
    return '$days Tage';
  }

  @override
  String get sprintPlanningExceeded =>
      'Achtung: Empfohlene Velocity überschritten';

  @override
  String get sprintPlanningNoStories => 'Keine Stories im Backlog verfügbar';

  @override
  String get sprintPlanningNotEstimated => 'Nicht geschätzt';

  @override
  String sprintPlanningConfirm(int count) {
    return 'Bestätigen ($count Stories)';
  }

  @override
  String get storyFormEditTitle => 'Story bearbeiten';

  @override
  String get storyFormNewTitle => 'Neue User Story';

  @override
  String get storyFormDetailsTab => 'Details';

  @override
  String get storyFormAcceptanceTab => 'Akzeptanzkriterien';

  @override
  String get storyFormOtherTab => 'Sonstiges';

  @override
  String get storyFormTitleLabel => 'Titel *';

  @override
  String get storyFormTitleHint => 'Z.B. US-123: Als Benutzer möchte ich...';

  @override
  String get storyFormTitleRequired => 'Titel ist erforderlich';

  @override
  String get storyFormUseTemplate => 'User Story Vorlage verwenden';

  @override
  String get storyFormTemplateSubtitle => 'Als... möchte ich... Damit...';

  @override
  String get storyFormAsA => 'Als...';

  @override
  String get storyFormAsAHint => 'Benutzer, Admin, Kunde...';

  @override
  String get storyFormIWant => 'Ich möchte...';

  @override
  String get storyFormIWantHint => 'etwas tun können...';

  @override
  String get storyFormIWantRequired => 'Geben Sie an, was der Benutzer möchte';

  @override
  String get storyFormSoThat => 'Damit...';

  @override
  String get storyFormSoThatHint => 'ein Nutzen entsteht...';

  @override
  String get storyFormDescriptionLabel => 'Beschreibung';

  @override
  String get storyFormDescriptionHint => 'Abnahmekriterien, Notizen...';

  @override
  String get storyFormDescriptionRequired => 'Beschreibung eingeben';

  @override
  String get storyFormPreview => 'Vorschau:';

  @override
  String get storyFormEmptyDescription => '(leere Beschreibung)';

  @override
  String get storyFormAcceptanceCriteriaTitle => 'Abnahmekriterien';

  @override
  String get storyFormAcceptanceCriteriaSubtitle =>
      'Definieren Sie, wann die Story als abgeschlossen gilt';

  @override
  String get storyFormAddCriterionHint => 'Abnahmekriterium hinzufügen...';

  @override
  String get storyFormNoCriteria => 'Keine Kriterien definiert';

  @override
  String get storyFormSuggestions => 'Vorschläge:';

  @override
  String get storyFormSuggestion1 => 'Daten werden korrekt gespeichert';

  @override
  String get storyFormSuggestion2 => 'Benutzer erhält eine Bestätigung';

  @override
  String get storyFormSuggestion3 => 'Formular zeigt Validierungsfehler';

  @override
  String get storyFormSuggestion4 => 'Funktion ist mobil zugänglich';

  @override
  String get storyFormPriorityLabel => 'Priorität (MoSCoW)';

  @override
  String get storyFormBusinessValueLabel => 'Business Value';

  @override
  String get storyFormBusinessValueHigh => 'Hoher Business-Wert';

  @override
  String get storyFormBusinessValueMedium => 'Mittlerer Wert';

  @override
  String get storyFormBusinessValueLow => 'Niedriger Business-Wert';

  @override
  String get storyFormStoryPointsLabel => 'In Story Points geschätzt';

  @override
  String get storyFormStoryPointsTooltip =>
      'Story Points repräsentieren die relative Komplexität der Arbeit.\nNutzen Sie die Fibonacci-Folge: 1 (einfach) -> 21 (sehr komplex).';

  @override
  String get storyFormNoPoints => 'Keine';

  @override
  String get storyFormPointsSimple => 'Schnelle und einfache Aufgabe';

  @override
  String get storyFormPointsMedium => 'Mittelschwere Aufgabe';

  @override
  String get storyFormPointsComplex => 'Komplexe Aufgabe, erfordert Analyse';

  @override
  String get storyFormPointsVeryComplex =>
      'Sehr komplex, ziehen Sie eine Aufteilung der Story in Betracht';

  @override
  String get storyFormTagsLabel => 'Tags';

  @override
  String get storyFormAddTagHint => 'Tag hinzufügen...';

  @override
  String get storyFormExistingTags => 'Existierende Tags:';

  @override
  String get storyFormAssigneeLabel => 'Zuweisen an';

  @override
  String get storyFormAssigneeHint => 'Wählen Sie ein Teammitglied';

  @override
  String get storyFormNotAssigned => 'Nicht zugewiesen';

  @override
  String storyDetailPointsLabel(int points) {
    return '$points Punkte';
  }

  @override
  String get storyDetailDescriptionTitle => 'Beschreibung';

  @override
  String get storyDetailNoDescription => 'Keine Beschreibung';

  @override
  String storyDetailAcceptanceCriteria(int completed, int total) {
    return 'Abnahmekriterien ($completed/$total)';
  }

  @override
  String get storyDetailNoCriteria => 'Keine Kriterien definiert';

  @override
  String get storyDetailEstimationTitle => 'Schätzung';

  @override
  String get storyDetailFinalEstimate => 'Endgültige Schätzung: ';

  @override
  String storyDetailEstimatesReceived(int count) {
    return '$count Schätzungen erhalten';
  }

  @override
  String get storyDetailInfoTitle => 'Informationen';

  @override
  String get storyDetailBusinessValue => 'Business Value';

  @override
  String get storyDetailAssignedTo => 'Zugewiesen an';

  @override
  String get storyDetailSprint => 'Sprint';

  @override
  String get storyDetailCreatedAt => 'Erstellt am';

  @override
  String get storyDetailStartedAt => 'Gestartet am';

  @override
  String get storyDetailCompletedAt => 'Abgeschlossen am';

  @override
  String get landingBadge => 'Tools für agile Teams';

  @override
  String get landingHeroTitle => 'Bauen Sie bessere Produkte\nmit Keisen';

  @override
  String get landingHeroSubtitle =>
      'Priorisieren, schätzen und verwalten Sie Ihre Projekte mit kollaborativen Tools. Alles an einem Ort, kostenlos.';

  @override
  String get landingStartFree => 'Kostenlos starten';

  @override
  String get landingEverythingNeed => 'Alles, was Sie brauchen';

  @override
  String get landingModernTools => 'Tools für moderne Teams';

  @override
  String get landingSmartTodoBadge => 'Produktivität';

  @override
  String get landingSmartTodoTitle => 'Smart Todo Liste';

  @override
  String get landingSmartTodoSubtitle =>
      'Intelligente und kollaborative Aufgabenverwaltung';

  @override
  String get landingSmartTodoCollaborativeTitle =>
      'Kollaborative Aufgabenlisten';

  @override
  String get landingSmartTodoCollaborativeDesc =>
      'Smart Todo verwandelt das tägliche Aufgabenmanagement in einen flüssigen und kollaborativen Prozess. Erstellen Sie Listen, weisen Sie Aufgaben Teammitgliedern zu und verfolgen Sie den Fortschritt in Echtzeit.\n\nIdeal für verteilte Teams, die eine kontinuierliche Synchronisierung benötigen.';

  @override
  String get landingSmartTodoImportTitle => 'Flexibler Import';

  @override
  String get landingSmartTodoImportDesc =>
      'Importieren Sie Ihre Aufgaben mit wenigen Klicks aus externen Quellen. Unterstützung für CSV, Kopieren/Einfügen aus Excel oder Freitext. Das System erkennt die Datenstruktur automatisch.\n\nMigrieren Sie problemlos von anderen Tools ohne Datenverlust.';

  @override
  String get landingSmartTodoShareTitle => 'Freigabe und Einladungen';

  @override
  String get landingSmartTodoShareDesc =>
      'Laden Sie Kollegen und Mitarbeiter per E-Mail zu Ihren Listen ein. Jeder Teilnehmer kann Aufgaben sehen, kommentieren und den Status aktualisieren.\n\nPerfekt für die Verwaltung übergreifender Projekte mit Stakeholdern.';

  @override
  String get landingSmartTodoFeaturesTitle => 'Smart Todo Funktionen';

  @override
  String get landingEisenhowerBadge => 'Priorisierung';

  @override
  String get landingEisenhowerSubtitle =>
      'Die Methode der Führungskräfte für Zeitmanagement';

  @override
  String get landingEisenhowerUrgentImportantTitle => 'Dringend vs. Wichtig';

  @override
  String get landingEisenhowerUrgentImportantDesc =>
      'Die Eisenhower-Matrix unterteilt Aufgaben in vier Quadranten basierend auf Dringlichkeit und Wichtigkeit.\n\nDieses Framework hilft zu unterscheiden, was sofortige Aufmerksamkeit benötigt und was zu langfristigen Zielen beiträgt.';

  @override
  String get landingEisenhowerDecisionsTitle => 'Bessere Entscheidungen';

  @override
  String get landingEisenhowerDecisionsDesc =>
      'Durch die konsequente Anwendung der Matrix entwickeln Sie ein ergebnisorientiertes Mindset. Konzentrieren Sie sich auf das, was echten Wert generiert.\n\nUnser digitales Tool macht diesen Prozess unmittelbar: Ziehen Sie Aufgaben in den richtigen Quadranten.';

  @override
  String get landingEisenhowerBenefitsTitle =>
      'Warum die Eisenhower-Matrix nutzen?';

  @override
  String get landingEisenhowerBenefitsDesc =>
      'Studien zeigen, dass 80% der täglichen Aktivitäten in die Quadranten 3 und 4 fallen (nicht wichtig). Die Matrix hilft, diese zu identifizieren.';

  @override
  String get landingEisenhowerQuadrants =>
      'Quadrant 1: Dringend + Wichtig → Sofort erledigen\nQuadrant 2: Nicht dringend + Wichtig → Planen\nQuadrant 3: Dringend + Nicht wichtig → Delegieren\nQuadrant 4: Nicht dringend + Nicht wichtig → Eliminieren';

  @override
  String get landingAgileBadge => 'Methoden';

  @override
  String get landingAgileTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSubtitle =>
      'Best Practices für iterative Softwareentwicklung';

  @override
  String get landingAgileIterativeTitle => 'Iterative Entwicklung';

  @override
  String get landingAgileIterativeDesc =>
      'Agile unterteilt die Arbeit in kurze Zyklen, Sprints genannt. Jede Iteration produziert ein funktionierendes Produktinkrement.\n\nMit Keisen verwalten Sie Ihr Backlog, planen Sprints und überwachen die Velocity.';

  @override
  String get landingAgileScrumTitle => 'Scrum Framework';

  @override
  String get landingAgileScrumDesc =>
      'Scrum definiert Rollen (PO, Scrum Master, Team), Events (Planning, Daily, Review, Retro) und Artefakte (Backlog).\n\nKeisen unterstützt alle Scrum-Events mit dedizierten Tools.';

  @override
  String get landingAgileKanbanTitle => 'Kanban Board';

  @override
  String get landingAgileKanbanDesc =>
      'Kanban visualisiert den Workflow durch Spalten. Begrenzen Sie WIP, um den Durchsatz zu maximieren.\n\nUnser Board unterstützt WIP-Limits und Fluss-Metriken.';

  @override
  String get landingEstimationBadge => 'Schätzung';

  @override
  String get landingEstimationTitle => 'Kollaborative Schätztechniken';

  @override
  String get landingEstimationSubtitle =>
      'Wählen Sie die beste Methode für präzise Schätzungen';

  @override
  String get landingEstimationFeaturesTitle => 'Estimation Room Funktionen';

  @override
  String get landingRetroBadge => 'Retrospektive';

  @override
  String get landingRetroTitle => 'Interaktive Retrospektiven';

  @override
  String get landingRetroSubtitle =>
      'Echtzeit-Tools: Timer, anonyme Abstimmung, Action Items und KI-Berichte.';

  @override
  String get landingRetroActionTitle => 'Action Items Tracking';

  @override
  String get landingRetroActionDesc =>
      'Jede Retro generiert verfolgbare Action Items mit Besitzer und Deadline. Überwachen Sie das Follow-up.';

  @override
  String get landingWorkflowBadge => 'Workflow';

  @override
  String get landingWorkflowTitle => 'Wie es funktioniert';

  @override
  String get landingWorkflowSubtitle => 'In 3 einfachen Schritten starten';

  @override
  String get landingStep1Title => 'Projekt erstellen';

  @override
  String get landingStep1Desc =>
      'Erstellen Sie Ihr Agiles Projekt und laden Sie das Team ein. Konfigurieren Sie alles.';

  @override
  String get landingStep2Title => 'Kollaborieren';

  @override
  String get landingStep2Desc =>
      'Schätzen Sie Stories gemeinsam, organisieren Sie Sprints und verfolgen Sie den Fortschritt.';

  @override
  String get landingStep3Title => 'Verbessern';

  @override
  String get landingStep3Desc =>
      'Analysieren Sie Metriken, führen Sie Retrospektiven durch und verbessern Sie den Prozess.';

  @override
  String get landingCtaTitle => 'Bereit zum Starten?';

  @override
  String get landingCtaDesc =>
      'Kostenlos registrieren und mit dem Team zusammenarbeiten.';

  @override
  String get landingFooterBrandDesc =>
      'Kollaborative Tools für agile Teams.\nGemeinsam planen, schätzen und verbessern.';

  @override
  String get landingFooterProduct => 'Produkt';

  @override
  String get landingFooterResources => 'Ressourcen';

  @override
  String get landingFooterCompany => 'Unternehmen';

  @override
  String get landingFooterLegal => 'Rechtliches';

  @override
  String get landingCopyright => '© 2026 Keisen. Alle Rechte vorbehalten.';

  @override
  String get featureSmartImportDesc =>
      'Schnelle Aufgabenerstellung\nTeamzuweisung\nPrioritäten und Deadlines\nAbschlussbenachrichtigungen';

  @override
  String get featureImportDesc =>
      'CSV-Import\nExcel Kopieren/Einfügen\nIntelligentes Parsing\nAutomatisches Mapping';

  @override
  String get featureShareDesc =>
      'E-Mail-Einladungen\nKonfigurierbare Berechtigungen\nAufgabenkommentare\nÄnderungshistorie';

  @override
  String get featureSmartTaskCreation => 'Schnelle Aufgabenerstellung';

  @override
  String get featureTeamAssignment => 'Teamzuweisung';

  @override
  String get featurePriorityDeadline => 'Priorität & Fristen';

  @override
  String get featureCompletionNotifications => 'Abschluss-Benachrichtigungen';

  @override
  String get featureCsvImport => 'CSV-Import';

  @override
  String get featureExcelPaste => 'Excel Kopieren/Einfügen';

  @override
  String get featureSmartParsing => 'Intelligenter Parsing';

  @override
  String get featureAutoMapping => 'Automatisches Mapping';

  @override
  String get featureEmailInvites => 'E-Mail-Einladungen';

  @override
  String get featurePermissions => 'Berechtigungen';

  @override
  String get featureTaskComments => 'Kommentare';

  @override
  String get featureHistory => 'Historie';

  @override
  String get featureAdvancedFilters => 'Erweiterte Filter';

  @override
  String get featureFullTextSearch => 'Volltextsuche';

  @override
  String get featureSorting => 'Sortierung';

  @override
  String get featureTagsCategories => 'Tags & Kategorien';

  @override
  String get featureArchiving => 'Archivierung';

  @override
  String get featureSort => 'Sortierung';

  @override
  String get featureDataExport => 'Datenexport';

  @override
  String get landingIntroFeatures =>
      'Sprint Planning mit Kapazität\nPriorisiertes Backlog (Drag & Drop)\nVelocity & Burndown Chart\nFacilitated Daily Standup';

  @override
  String get landingAgileScrumFeatures =>
      'Backlog mit Story Points\nSprint Backlog mit Breakdown\nIntegrierte Retro-Board\nAutomatische Metriken';

  @override
  String get landingAgileKanbanFeatures =>
      'Anpassbare Spalten\nWIP-Limits\nIntuitives Drag & Drop\nLead & Cycle Time';

  @override
  String get landingEstimationPokerDesc =>
      'Die klassische Methode: Jeder wählt eine Karte. Gleichzeitiges Aufdecken vermeidet Bias.';

  @override
  String get landingEstimationTShirtTitle => 'T-Shirt Größen';

  @override
  String get landingEstimationTShirtSubtitle => 'Relative Größen';

  @override
  String get landingEstimationTShirtDesc =>
      'Schnellschätzung mit XS, S, M, L, XL, XXL. Ideal für Grooming.';

  @override
  String get landingEstimationPertTitle => 'Drei-Punkt (PERT)';

  @override
  String get landingEstimationPertSubtitle =>
      'Optimistisch / Wahrscheinlich / Pessimistisch';

  @override
  String get landingEstimationPertDesc =>
      'Statistische Technik zur Berechnung der gewichteten Schätzung.';

  @override
  String get landingEstimationBucketTitle => 'Bucket-System';

  @override
  String get landingEstimationBucketSubtitle => 'Schnelle Kategorisierung';

  @override
  String get landingEstimationBucketDesc =>
      'Stories werden vordefinierten Buckets zugeordnet. Ideal für große Mengen.';

  @override
  String get landingEstimationChipHiddenVote => 'Verdeckte Wahl';

  @override
  String get landingEstimationChipTimer => 'Timer konfigurierbar';

  @override
  String get landingEstimationChipStats => 'Echtzeit-Statistiken';

  @override
  String get landingEstimationChipParticipants => 'Bis zu 20 Teilnehmer';

  @override
  String get landingEstimationChipHistory => 'Schätzhistorie';

  @override
  String get landingEstimationChipExport => 'Ergebnisexport';

  @override
  String get landingRetroTemplateStartStopTitle => 'Start / Stop / Continue';

  @override
  String get landingRetroTemplateStartStopDesc =>
      'Klassisches Format: Beginnen, Beenden, Beibehalten.';

  @override
  String get landingRetroTemplateMadSadTitle => 'Mad / Sad / Glad';

  @override
  String get landingRetroTemplateMadSadDesc =>
      'Emotionale Retro: Was hat uns verärgert, traurig oder froh gemacht.';

  @override
  String get landingRetroTemplate4LsTitle => '4L\'s';

  @override
  String get landingRetroTemplate4LsDesc =>
      'Liked, Learned, Lacked, Longed For.';

  @override
  String get landingRetroTemplateSailboatTitle => 'Sailboat (Segelboot)';

  @override
  String get landingRetroTemplateSailboatDesc =>
      'Visualisierung von Hilfe, Hindernissen, Risiken und Zielen.';

  @override
  String get landingRetroTemplateWentWellTitle =>
      'Gut gelaufen / Zu verbessern';

  @override
  String get landingRetroTemplateWentWellDesc =>
      'Direktes Format: Positives und Verbesserungspotenzial.';

  @override
  String get landingRetroTemplateDakiTitle => 'DAKI';

  @override
  String get landingRetroTemplateDakiDesc =>
      'Drop, Add, Keep, Improve - konkrete Entscheidungen.';

  @override
  String get landingRetroFeatureTrackingTitle => 'Action Items Tracking';

  @override
  String get landingRetroFeatureTrackingDesc =>
      'Verfolgbare Action Items mit Zuständigkeit und Frist.';

  @override
  String get landingAgileSectionBadge => 'Methoden';

  @override
  String get landingAgileSectionTitle => 'Agile & Scrum Framework';

  @override
  String get landingAgileSectionSubtitle =>
      'Motive für iterative Softwareentwicklung';

  @override
  String get landingSmartTodoCollabTitle => 'Kollaborative Aufgabenlisten';

  @override
  String get landingSmartTodoCollabDesc =>
      'Verwalten Sie tägliche Aufgaben flüssig im Team. Echtzeit-Fortschrittsverfolgung.';

  @override
  String get landingSmartTodoCollabFeatures =>
      'Schnell-Erstellung\nTeamzuweisung\nPrioritäten & Deadlines\nBenachrichtigungen';

  @override
  String get landingSmartTodoImportFeatures =>
      'CSV-Import\nExcel Copy/Paste\nSmart Parsing\nAuto-Mapping';

  @override
  String get landingSmartTodoSharingTitle => 'Freigabe & Einladungen';

  @override
  String get landingSmartTodoSharingDesc =>
      'Laden Sie Mitarbeiter ein, kommentieren Sie und aktualisieren Sie den Status.';

  @override
  String get landingSmartTodoSharingFeatures =>
      'Einladungen\nBerechtigungen\nKommentare\nHistorie';

  @override
  String get landingSmartTodoChipFilters => 'Erweiterte Filter';

  @override
  String get landingSmartTodoChipSearch => 'Volltextsuche';

  @override
  String get landingSmartTodoChipSort => 'Sortierung';

  @override
  String get landingSmartTodoChipTags => 'Tags & Kategorien';

  @override
  String get landingSmartTodoChipArchive => 'Archivierung';

  @override
  String get landingSmartTodoChipExport => 'Export';

  @override
  String get landingEisenhowerTitle => 'Eisenhower-Matrix';

  @override
  String get landingEisenhowerUrgentTitle => 'Dringend vs. Wichtig';

  @override
  String get landingEisenhowerUrgentDesc =>
      'Unterteilt Aufgaben in vier Quadranten zur besseren Fokussierung.';

  @override
  String get landingEisenhowerUrgentFeatures =>
      'Q1: Dringend+Wichtig → Tun\nQ2: Wichtig+Nicht dringend → Planen\nQ3: Dringend+Unwichtig → Delegieren\nQ4: Unwichtig+Nicht dringend → Löschen';

  @override
  String get landingEisenhowerDecisionsFeatures =>
      'Drag & Drop\nEchtzeit-Kollaboration\nVerteilungs-Statistiken\nBerichts-Export';

  @override
  String get landingEisenhowerUrgentLabel => 'DRINGEND';

  @override
  String get landingEisenhowerNotUrgentLabel => 'NICHT DRINGEND';

  @override
  String get landingEisenhowerImportantLabel => 'WICHTIG';

  @override
  String get landingEisenhowerNotImportantLabel => 'NICHT WICHTIG';

  @override
  String get landingEisenhowerDoLabel => 'TUN';

  @override
  String get landingEisenhowerDoDesc => 'Krisen, Fristen, Notfälle';

  @override
  String get landingEisenhowerPlanLabel => 'PLANEN';

  @override
  String get landingEisenhowerPlanDesc => 'Strategie, Wachstum';

  @override
  String get landingEisenhowerDelegateLabel => 'DELEGIEREN';

  @override
  String get landingEisenhowerDelegateDesc => 'Meetings, Unterbrechungen';

  @override
  String get landingEisenhowerEliminateLabel => 'LÖSCHEN';

  @override
  String get landingEisenhowerEliminateDesc => 'Zeitfresser, Ablenkungen';

  @override
  String get landingFooterFeatures => 'Funktionen';

  @override
  String get landingFooterPricing => 'Pricing';

  @override
  String get landingFooterChangelog => 'Changelog';

  @override
  String get landingFooterRoadmap => 'Roadmap';

  @override
  String get landingFooterDocs => 'Dokumentation';

  @override
  String jiraConnectedSuccess(String name) {
    return 'Verbunden als $name';
  }

  @override
  String get landingFooterAgileGuides => 'Agile Leitfäden';

  @override
  String get landingFooterBlog => 'Blog';

  @override
  String get landingFooterCommunity => 'Community';

  @override
  String get landingFooterAbout => 'Über uns';

  @override
  String get landingFooterContact => 'Kontakt';

  @override
  String get landingFooterJobs => 'Jobs';

  @override
  String get landingFooterPress => 'Press Kit';

  @override
  String get landingFooterPrivacy => 'Datenschutz';

  @override
  String get landingFooterTerms => 'Nutzungsbedingungen';

  @override
  String get landingFooterCookies => 'Cookie-Richtlinie';

  @override
  String get landingFooterGdpr => 'DSGVO';

  @override
  String get legalCookieTitle => 'Wir verwenden Cookies';

  @override
  String get legalCookieMessage =>
      'Wir nutzen Cookies, um Ihr Erlebnis zu verbessern. Durch Fortfahren akzeptieren Sie deren Nutzung.';

  @override
  String get legalCookieAccept => 'Alle akzeptieren';

  @override
  String get legalCookieRefuse => 'Nur notwendige';

  @override
  String get legalCookiePolicy => 'Cookie-Richtlinie';

  @override
  String get legalPrivacyPolicy => 'Datenschutz';

  @override
  String get legalTermsOfService => 'Nutzungsbedingungen';

  @override
  String get legalGDPR => 'DSGVO';

  @override
  String get legalLastUpdatedLabel => 'Zuletzt aktualisiert';

  @override
  String get legalLastUpdatedDate => '18. Januar 2026';

  @override
  String get legalAcceptTerms =>
      'Ich akzeptiere die Bedingungen und Datenschutzbestimmungen';

  @override
  String get legalMustAcceptTerms =>
      'Sie müssen die Bedingungen akzeptieren, um fortzufahren';

  @override
  String get legalPrivacyContent =>
      '## 1. Einleitung\nWillkommen bei **Keisen**. Ihr Datenschutz ist uns wichtig. Diese Richtlinie erklärt, wie wir Informationen sammeln, nutzen und schützen.\n\n## 2. Daten, die wir sammeln\n### 2.1 Vom Benutzer bereitgestellte Infos\n- **Account-Daten:** Name, E-Mail (via Google Sign-In).\n- **Inhalte:** Aufgaben, Schätzungen, Retros, Kommentare.\n### 2.2 Automatisch gesammelte Infos\n- **System-Logs:** IP, Browser, Zeitstempel. Cookies für die Session.\n\n## 3. Nutzung der Daten\nWir nutzen Daten für: Betrieb, Verbesserung der Plattform, personalisierte Erfahrung und Service-Mails.\n\n## 4. Datenteilung\nKein Verkauf von Daten. Nutzung von **Google Firebase** für Hosting/Auth.\n\n## 5. Sicherheit\nBranchenübliche Standards (Verschlüsselung) werden angewendet.\n\n## 6. Ihre Rechte\nZugang, Korrektur, Löschung (\"Recht auf Vergessenwerden\"). Kontakt: suppkesien@gmail.com.\n\n## 7. Änderungen\nWir aktualisieren diese Policy gelegentlich auf dieser Seite.';

  @override
  String get legalTermsContent =>
      '## 1. Akzeptanz\nDurch die Nutzung von **Keisen** akzeptieren Sie diese Bedingungen.\n\n## 2. Dienstbeschreibung\nKollaborative agile Plattform. Wir behalten uns Änderungen vor.\n\n## 3. Account\nSie sind für die Sicherheit Ihres Accounts zuständig.\n\n## 4. Verhalten\nKeine illegalen Inhalte oder unbefugter Zugriff.\n\n## 5. Geistiges Eigentum\nKeisen ist Eigentum von Leonardo Torella.\n\n## 6. Haftung\nBereitstellung \"wie gesehen\". Keine Haftung für indirekte Schäden.\n\n## 7. Recht\nEs gilt italienisches Recht.\n\n## 8. Kontakt\nsuppkesien@gmail.com.';

  @override
  String get legalCookiesContent =>
      '## 1. Was sind Cookies?\nKleine Textdateien auf Ihrem Gerät.\n\n## 2. Nutzung\n### 2.1 Technische Cookies\nNotwendig für den Betrieb (z.B. Login via Firebase).\n### 2.2 Analyse\nAnonyme Daten zur Verbesserung des Auftritts.\n\n## 3. Verwaltung\nKontrolle über Browsereinstellungen möglich.\n\n## 4. Drittanbieter\nFirebase nutzt eigene Cookies.';

  @override
  String get legalGdprContent =>
      '## DSGVO-Verpflichtung\nKeisen schützt personenbezogene Daten gemäß der EU-DSGVO.\n\n## Verantwortlicher\n**Keisen Team**\nE-Mail: suppkesien@gmail.com\n\n## Rechtsgrundlage\nEinwilligung, Vertragserfüllung oder berechtigtes Interesse.\n\n## Datenübertragung\nSichere Google Cloud Server (Firebase) mit SCC-Konformität.\n\n## Ihre Rechte\nZugang, Berichtigung, Löschung, Einschränkung, Übertragbarkeit. Kontakt via E-Mail. Antwort innerhalb eines Monats.';

  @override
  String get profilePrivacy => 'Datenschutz';

  @override
  String get profileExportData => 'Meine Daten exportieren';

  @override
  String get profileDeleteAccountConfirm =>
      'Sind Sie sicher, dass Sie Ihren Account löschen möchten? Dies ist unwiderruflich.';

  @override
  String get subscriptionTitle => 'Abonnement';

  @override
  String get subscriptionTabPlans => 'Pläne';

  @override
  String get subscriptionTabUsage => 'Nutzung';

  @override
  String get subscriptionTabBilling => 'Abrechnung';

  @override
  String subscriptionActiveProjects(int count) {
    return '$count aktive Projekte';
  }

  @override
  String subscriptionActiveLists(int count) {
    return '$count Todo-Listen';
  }

  @override
  String get subscriptionCurrentPlan => 'Aktueller Plan';

  @override
  String subscriptionUpgradeTo(String plan) {
    return 'Upgrade auf $plan';
  }

  @override
  String subscriptionDowngradeTo(String plan) {
    return 'Downgrade auf $plan';
  }

  @override
  String subscriptionChoose(String plan) {
    return 'Wähle $plan';
  }

  @override
  String get subscriptionMonthly => 'Monatlich';

  @override
  String get subscriptionYearly => 'Jährlich (-17%)';

  @override
  String get subscriptionLimitReached => 'Limit erreicht';

  @override
  String get subscriptionLimitProjects =>
      'Projektlimit (5) erreicht. Kontaktieren Sie uns für mehr.';

  @override
  String get subscriptionLimitLists =>
      'Listenlimit erreicht. Upgrade auf Premium möglich.';

  @override
  String get subscriptionLimitTasks =>
      'Aufgabenlimit für dieses Projekt erreicht.';

  @override
  String get subscriptionLimitInvites => 'Einladungslimit erreicht.';

  @override
  String get subscriptionLimitEstimations => 'Schätzungslimit erreicht.';

  @override
  String get subscriptionLimitRetrospectives => 'Retro-Limit erreicht.';

  @override
  String get subscriptionLimitAgileProjects =>
      'Agile Projektlimit (5) erreicht.';

  @override
  String get subscriptionLimitDefault =>
      'Limit Ihres aktuellen Plans erreicht.';

  @override
  String get subscriptionCurrentUsage => 'Aktuelle Nutzung';

  @override
  String get subscriptionUpgradeToPremium => 'Werde Premium';

  @override
  String get subscriptionBenefitProjects => '30 aktive Projekte';

  @override
  String get subscriptionBenefitLists => '30 Todo-Listen';

  @override
  String get subscriptionBenefitTasks => '100 Aufgaben pro Projekt';

  @override
  String get subscriptionBenefitNoAds => 'Keine Werbung';

  @override
  String get subscriptionStartingFrom => 'Kontaktieren Sie uns für Infos';

  @override
  String get subscriptionLater => 'Später';

  @override
  String get subscriptionViewPlans => 'Entwickler kontaktieren';

  @override
  String get subscriptionContactDeveloper => 'Entwickler kontaktieren';

  @override
  String get subscriptionOfficialEmail => 'leonardo.torella@gmail.com';

  @override
  String subscriptionCanCreateOne(String entity) {
    return 'Noch 1 $entity erstellbar';
  }

  @override
  String subscriptionCanCreateMany(int count, String entity) {
    return 'Noch $count $entity erstellbar';
  }

  @override
  String get subscriptionUpgrade => 'UPGRADE';

  @override
  String subscriptionUsed(int count) {
    return 'Genutzt: $count';
  }

  @override
  String get subscriptionUnlimited => 'Unbegrenzt';

  @override
  String subscriptionLimit(int count) {
    return 'Limit: $count';
  }

  @override
  String get subscriptionPlanUsage => 'Plan-Nutzung';

  @override
  String get subscriptionRefresh => 'Aktualisieren';

  @override
  String get subscriptionAdsActive => 'Werbung aktiv';

  @override
  String get subscriptionRemoveAds => 'Premium werden, um Werbung zu entfernen';

  @override
  String get subscriptionNoAds => 'Keine Werbung';

  @override
  String get subscriptionLoadError =>
      'Nutzungsdaten konnten nicht geladen werden';

  @override
  String get subscriptionAdLabel => 'AD';

  @override
  String get subscriptionAdPlaceholder => 'Ad Platzhalter';

  @override
  String get subscriptionDevEnvironment => '(Entwicklungsumgebung)';

  @override
  String get subscriptionRemoveAdsUnlock =>
      'Werbung entfernen & Profi-Features freischalten';

  @override
  String get subscriptionUpgradeButton => 'Upgrade';

  @override
  String subscriptionLoadingError(String error) {
    return 'Ladefehler: $error';
  }

  @override
  String get subscriptionCompletePayment =>
      'Zahlung im geöffneten Fenster abschließen';

  @override
  String subscriptionError(String error) {
    return 'Fehler: $error';
  }

  @override
  String get subscriptionConfirmDowngrade => 'Downgrade bestätigen';

  @override
  String get subscriptionDowngradeMessage =>
      'Sind Sie sicher, dass Sie zum Free-Plan wechseln möchten?\n\nIhr Abonnement bleibt bis zum Ende des aktuellen Zeitraums aktiv, danach wechseln Sie automatisch zum Free-Plan.\n\nSie verlieren Ihre Daten nicht, aber einige Funktionen könnten eingeschränkt sein.';

  @override
  String get subscriptionCancel => 'Abbrechen';

  @override
  String get subscriptionConfirmDowngradeButton => 'Downgrade bestätigen';

  @override
  String get subscriptionCancelled =>
      'Abonnement gekündigt. Es bleibt bis zum Ende des Zeitraums aktiv.';

  @override
  String subscriptionPortalError(String error) {
    return 'Fehler beim Öffnen des Portals: $error';
  }

  @override
  String get subscriptionRetry => 'Erneut versuchen';

  @override
  String get subscriptionChooseRightPlan => 'Wählen Sie den passenden Plan';

  @override
  String get subscriptionStartFree => 'Kostenlos starten, jederzeit upgraden';

  @override
  String subscriptionPlan(String plan) {
    return '$plan Plan';
  }

  @override
  String subscriptionPlanName(String plan) {
    return 'Aktueller Plan: $plan';
  }

  @override
  String subscriptionTrialUntil(String date) {
    return 'Testversion bis $date';
  }

  @override
  String subscriptionRenewal(String date) {
    return 'Verlängerung: $date';
  }

  @override
  String get subscriptionManage => 'Verwalten';

  @override
  String get subscriptionLoginRequired => 'Anmelden, um Nutzung zu sehen';

  @override
  String get subscriptionSuggestion => 'Tipp';

  @override
  String get subscriptionSuggestionText =>
      'Wechseln Sie zu Premium, um mehr Projekte freizuschalten, Werbung zu entfernen und Limits zu erhöhen. 7 Tage kostenlos testen!';

  @override
  String get subscriptionPaymentManagement => 'Zahlungsverwaltung';

  @override
  String get subscriptionNoActiveSubscription => 'Kein aktives Abonnement';

  @override
  String get subscriptionUsingFreePlan => 'Sie nutzen den Free-Plan';

  @override
  String get subscriptionViewPaidPlans => 'Kostenpflichtige Pläne ansehen';

  @override
  String get subscriptionPaymentMethod => 'Zahlungsmethode';

  @override
  String get subscriptionEditPaymentMethod => 'Karte oder Methode bearbeiten';

  @override
  String get subscriptionInvoices => 'Rechnungen';

  @override
  String get subscriptionViewInvoices =>
      'Rechnungen anzeigen und herunterladen';

  @override
  String get subscriptionCancelSubscription => 'Abonnement kündigen';

  @override
  String get subscriptionAccessUntilEnd =>
      'Zugriff bleibt bis zum Ende des Zeitraums aktiv';

  @override
  String get subscriptionPaymentHistory => 'Zahlungsverlauf';

  @override
  String get subscriptionNoPayments => 'Keine Zahlungen registriert';

  @override
  String get subscriptionCompleted => 'Abgeschlossen';

  @override
  String get subscriptionDateNotAvailable => 'Datum nicht verfügbar';

  @override
  String get subscriptionFaq => 'Häufig gestellte Fragen';

  @override
  String get subscriptionFaqCancel => 'Kann ich jederzeit kündigen?';

  @override
  String get subscriptionFaqCancelAnswer =>
      'Ja, Sie können Ihr Abonnement jederzeit kündigen. Der Zugriff bleibt bis zum Ende des bezahlten Zeitraums aktiv.';

  @override
  String get subscriptionFaqTrial =>
      'Wie funktioniert die kostenlose Testversion?';

  @override
  String get subscriptionFaqTrialAnswer =>
      'Mit der Testversion haben Sie vollen Zugriff auf alle Funktionen. Nach Ablauf beginnt automatisch das kostenpflichtige Abonnement.';

  @override
  String get subscriptionFaqChange => 'Kann ich den Plan wechseln?';

  @override
  String get subscriptionFaqChangeAnswer =>
      'Sie können jederzeit ein Up- oder Downgrade durchführen. Der Betrag wird anteilig berechnet.';

  @override
  String get subscriptionFaqData => 'Sind meine Daten sicher?';

  @override
  String get subscriptionFaqDataAnswer =>
      'Absolut. Sie verlieren Ihre Daten nie, auch wenn Sie zu einem niedrigeren Plan wechseln. Funktionen könnten eingeschränkt sein, aber Daten bleiben zugänglich.';

  @override
  String get subscriptionStatusActive => 'Aktiv';

  @override
  String get subscriptionStatusTrialing => 'Testversion';

  @override
  String get subscriptionStatusPastDue => 'Zahlung überfällig';

  @override
  String get subscriptionStatusCancelled => 'Gekündigt';

  @override
  String get subscriptionStatusExpired => 'Abgelaufen';

  @override
  String get subscriptionStatusPaused => 'Pausiert';

  @override
  String get subscriptionStatus => 'Status';

  @override
  String get subscriptionStarted => 'Gestartet';

  @override
  String get subscriptionNextRenewal => 'Nächste Verlängerung';

  @override
  String get subscriptionTrialEnd => 'Testende';

  @override
  String get toolSectionTitle => 'Tools';

  @override
  String get deadlineTitle => 'Fristen';

  @override
  String get deadlineNoUpcoming => 'Keine anstehenden Fristen';

  @override
  String get deadlineAll => 'Alle';

  @override
  String get deadlineToday => 'Heute';

  @override
  String get deadlineTomorrow => 'Morgen';

  @override
  String get deadlineSprint => 'Sprint';

  @override
  String get deadlineTask => 'Aufgabe';

  @override
  String get favTitle => 'Favoriten';

  @override
  String get favFilterAll => 'Alle';

  @override
  String get favFilterTodo => 'Todo-Listen';

  @override
  String get favFilterMatrix => 'Matrizen';

  @override
  String get favFilterProject => 'Projekte';

  @override
  String get favFilterPoker => 'Schätzungen';

  @override
  String get actionRemoveFromFavorites => 'Aus Favoriten entfernen';

  @override
  String get favFilterRetro => 'Retro';

  @override
  String get favNoFavorites => 'Keine Favoriten gefunden';

  @override
  String get favTypeTodo => 'Todo-Liste';

  @override
  String get favTypeMatrix => 'Eisenhower-Matrix';

  @override
  String get favTypeProject => 'Agiles Projekt';

  @override
  String get favTypeRetro => 'Retrospektive';

  @override
  String get favTypePoker => 'Planning Poker';

  @override
  String get favTypeTool => 'Tool';

  @override
  String get deadline2Days => '2 Tage';

  @override
  String get deadline3Days => '3 Tage';

  @override
  String get deadline5Days => '5 Tage';

  @override
  String get deadlineConfigTitle => 'Verknüpfungen konfigurieren';

  @override
  String get deadlineConfigDesc =>
      'Wählen Sie die Zeitintervalle für die Kopfzeile.';

  @override
  String get smartTodoClose => 'Schließen';

  @override
  String get smartTodoDone => 'Fertig';

  @override
  String get smartTodoAdd => 'Hinzufügen';

  @override
  String get smartTodoEmailLabel => 'E-Mail';

  @override
  String get exceptionLoginGoogleRequired =>
      'Google-Login erforderlich, um E-Mails zu senden';

  @override
  String get exceptionUserNotAuthenticated => 'Benutzer nicht authentifiziert';

  @override
  String errorLoginFailed(String error) {
    return 'Login-Fehler: $error';
  }

  @override
  String retroParticipantsTitle(int count) {
    return 'Teilnehmer ($count)';
  }

  @override
  String get actionReopen => 'Wieder öffnen';

  @override
  String get retroWaitingForFacilitator => 'Warten auf den Facilitator...';

  @override
  String get retroGeneratingSheet => 'Google Sheet wird generiert...';

  @override
  String get retroExportSuccess => 'Export abgeschlossen!';

  @override
  String get retroExportSuccessMessage =>
      'Ihre Retrospektive wurde nach Google Sheets exportiert.';

  @override
  String get retroExportError => 'Fehler beim Export nach Sheets.';

  @override
  String get retroReportCopied => 'Bericht in Zwischenablage kopiert!';

  @override
  String get retroReopenTitle => 'Retrospektive wieder öffnen';

  @override
  String get retroReopenConfirm =>
      'Sind Sie sicher? Sie kehren zur Diskussionsphase zurück.';

  @override
  String get errorAuthRequired => 'Authentifizierung erforderlich';

  @override
  String get errorRetroIdMissing => 'Retrospektiven-ID fehlt';

  @override
  String get pokerInviteAccepted =>
      'Einladung angenommen! Weiterleitung zur Session.';

  @override
  String get pokerInviteRefused => 'Einladung abgelehnt';

  @override
  String get pokerConfirmRefuseTitle => 'Einladung ablehnen';

  @override
  String get pokerConfirmRefuseContent =>
      'Sind Sie sicher, dass Sie diese Einladung ablehnen möchten?';

  @override
  String get pokerVerifyingInvite => 'Einladung wird geprüft...';

  @override
  String get actionBackHome => 'Zurück zu Home';

  @override
  String get actionSignin => 'Anmelden';

  @override
  String get exceptionStoryNotFound => 'Story nicht gefunden';

  @override
  String get exceptionNoTasksInProject => 'Keine Aufgaben im Projekt gefunden';

  @override
  String get exceptionInvitePending =>
      'Es existiert bereits eine ausstehende Einladung für diese E-Mail';

  @override
  String get exceptionAlreadyParticipant => 'Benutzer ist bereits Teilnehmer';

  @override
  String get exceptionInviteInvalid => 'Einladung ungültig oder abgelaufen';

  @override
  String get exceptionInviteCalculated => 'Einladung abgelaufen';

  @override
  String get exceptionInviteWrongUser =>
      'Einladung ist für einen anderen Benutzer bestimmt';

  @override
  String get todoImportTasks => 'Aufgaben importieren';

  @override
  String get todoExportSheets => 'Nach Sheets exportieren';

  @override
  String get todoDeleteColumnTitle => 'Spalte löschen';

  @override
  String get todoDeleteColumnConfirm =>
      'Sind Sie sicher? Aufgaben in dieser Spalte gehen verloren.';

  @override
  String get exceptionListNotFound => 'Liste nicht gefunden';

  @override
  String get langItalian => 'Italienisch';

  @override
  String get langEnglish => 'Englisch';

  @override
  String get langFrench => 'Französisch';

  @override
  String get langSpanish => 'Spanisch';

  @override
  String get langPortuguese => 'Portugiesisch';

  @override
  String get langRussian => 'Russisch';

  @override
  String get langGerman => 'Deutsch';

  @override
  String get langIndonesian => 'Indonesisch';

  @override
  String get jsonExportLabel => 'JSON-Kopie Ihrer Daten herunterladen';

  @override
  String errorExporting(String error) {
    return 'Fehler beim Export: $error';
  }

  @override
  String get smartTodoViewKanban => 'Kanban';

  @override
  String get smartTodoViewList => 'Liste';

  @override
  String get smartTodoViewResource => 'Nach Ressource';

  @override
  String get smartTodoViewCalendar => 'Calendario';

  @override
  String get smartTodoInviteTooltip => 'Einladen';

  @override
  String get smartTodoOptionsTooltip => 'Weitere Optionen';

  @override
  String get smartTodoActionImport => 'Aufgaben importieren';

  @override
  String get smartTodoActionExportSheets => 'Nach Sheets exportieren';

  @override
  String get smartTodoDeleteColumnTitle => 'Spalte löschen';

  @override
  String get smartTodoDeleteColumnContent =>
      'Sind Sie sicher? Aufgaben in dieser Spalte werden nicht mehr sichtbar sein.';

  @override
  String get smartTodoNewColumn => 'Neue Spalte';

  @override
  String get smartTodoColumnNameHint => 'Spaltenname';

  @override
  String get smartTodoColorLabel => 'FARBE';

  @override
  String get smartTodoMarkAsDone => 'Als erledigt markieren';

  @override
  String get smartTodoColumnDoneDescription =>
      'Aufgaben in dieser Spalte gelten als \'Erledigt\' (durchgestrichen).';

  @override
  String get smartTodoListSettingsTitle => 'Listeneinstellungen';

  @override
  String get smartTodoRenameList => 'Liste umbenennen';

  @override
  String get smartTodoManageTags => 'Tags verwalten';

  @override
  String get smartTodoDeleteList => 'Liste löschen';

  @override
  String get smartTodoEditPermissionError =>
      'Sie können nur Ihnen zugewiesene Aufgaben bearbeiten';

  @override
  String errorDeletingAccount(String error) {
    return 'Fehler beim Löschen des Accounts: $error';
  }

  @override
  String get errorRecentLoginRequired =>
      'Ein aktueller Login ist erforderlich. Bitte melden Sie sich ab und wieder an.';

  @override
  String actionGuide(String framework) {
    return '$framework-Leitfaden';
  }

  @override
  String get actionExportSheets => 'Nach Google Sheets exportieren';

  @override
  String get actionAuditLog => 'Audit-Log';

  @override
  String get actionInviteMember => 'Mitglied einladen';

  @override
  String get actionSettings => 'Einstellungen';

  @override
  String get retroSelectIcebreakerTooltip => 'Icebreaker-Aktivität wählen';

  @override
  String get retroIcebreakerLabel => 'Anfangsaktivität';

  @override
  String get retroTimePhasesOptional => 'Phasen-Timer (Optional)';

  @override
  String get retroTimePhasesDesc => 'Dauer in Minuten für jede Phase:';

  @override
  String get retroIcebreakerSectionTitle => 'Icebreaker';

  @override
  String get retroBoardTitle => 'Retrospektiven-Board';

  @override
  String get searchPlaceholder => 'Überall suchen...';

  @override
  String get searchResultsTitle => 'Suchergebnisse';

  @override
  String searchNoResults(Object query) {
    return 'Keine Ergebnisse für \'$query\'';
  }

  @override
  String get searchResultTypeProject => 'Projekt';

  @override
  String get searchResultTypeTodo => 'Todo-Liste';

  @override
  String get searchResultTypeRetro => 'Retrospektive';

  @override
  String get searchResultTypeEisenhower => 'Eisenhower-Matrix';

  @override
  String get searchResultTypeEstimation => 'Estimation Room';

  @override
  String get searchBackToDashboard => 'Zurück zum Dashboard';

  @override
  String get smartTodoAddItem => 'Eintrag hinzufügen';

  @override
  String get smartTodoAddImageUrl => 'Bild hinzufügen (URL)';

  @override
  String get smartTodoNone => 'Keine';

  @override
  String get smartTodoPointsHint => 'Punkte (z.B. 5)';

  @override
  String get smartTodoNewItem => 'Neuer Eintrag';

  @override
  String get smartTodoDeleteComment => 'Löschen';

  @override
  String get priorityHigh => 'HOCH';

  @override
  String get priorityMedium => 'MITTEL';

  @override
  String get priorityLow => 'NIEDRIG';

  @override
  String get exportToEstimation => 'An Estimation senden';

  @override
  String get exportToEstimationDesc =>
      'Schätzsitzung mit diesen Aufgaben erstellen';

  @override
  String get exportToEisenhower => 'An Eisenhower senden';

  @override
  String get exportToEisenhowerDesc =>
      'Eisenhower-Matrix mit diesen Aufgaben erstellen';

  @override
  String get selectTasksToExport => 'Aufgaben wählen';

  @override
  String get selectTasksToExportDesc =>
      'Wählen Sie die Aufgaben zum Exportieren';

  @override
  String get noTasksSelected => 'Keine Aufgaben ausgewählt';

  @override
  String get selectAtLeastOne => 'Wählen Sie mindestens eine Aufgabe';

  @override
  String get createEstimationSession => 'Schätzsitzung erstellen';

  @override
  String tasksSelectedCount(int count) {
    return '$count Aufgaben ausgewählt';
  }

  @override
  String get exportSuccess => 'Erfolgreich exportiert';

  @override
  String get exportFromEstimation => 'In Liste exportieren';

  @override
  String get exportFromEstimationDesc =>
      'Geschätzte Stories in eine Smart Todo Liste exportieren';

  @override
  String get selectDestinationList => 'Zielliste wählen';

  @override
  String get createNewList => 'Neue Liste erstellen';

  @override
  String get existingList => 'Existierende Liste';

  @override
  String get listName => 'Listenname';

  @override
  String get listNameHint => 'Name für die neue Liste';

  @override
  String get selectList => 'Liste wählen';

  @override
  String get selectListHint => 'Wählen Sie eine Liste';

  @override
  String get noListsAvailable =>
      'Keine Listen verfügbar. Eine neue wird erstellt.';

  @override
  String storiesSelectedCount(int count) {
    return '$count Stories ausgewählt';
  }

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get deselectAll => 'Alle abwählen';

  @override
  String get importStories => 'Stories importieren';

  @override
  String storiesImportedCount(int count) {
    return '$count Stories importiert';
  }

  @override
  String get noEstimatedStories =>
      'Keine Stories mit Schätzungen zum Importieren';

  @override
  String get selectDestinationMatrix => 'Zielmatrix wählen';

  @override
  String get existingMatrix => 'Existierende Matrix';

  @override
  String get createNewMatrix => 'Neue Matrix erstellen';

  @override
  String get matrixName => 'Matrixname';

  @override
  String get matrixNameHint => 'Name für die neue Matrix';

  @override
  String get selectMatrix => 'Matrix wählen';

  @override
  String get selectMatrixHint => 'Wählen Sie eine Zielmatrix';

  @override
  String get noMatricesAvailable =>
      'Keine Matrizen verfügbar. Erstellen Sie eine neue.';

  @override
  String activitiesCreated(int count) {
    return '$count Aktivitäten erstellt';
  }

  @override
  String get importFromEisenhower => 'Von Eisenhower importieren';

  @override
  String get importFromEisenhowerDesc =>
      'Priorisierte Aufgaben zu dieser Liste hinzufügen';

  @override
  String get quadrantQ1 => 'Dringend & Wichtig';

  @override
  String get quadrantQ2 => 'Nicht Dringend & Wichtig';

  @override
  String get quadrantQ3 => 'Dringend & Nicht Wichtig';

  @override
  String get quadrantQ4 => 'Nicht Dringend & Nicht Wichtig';

  @override
  String get warningQ4Tasks =>
      'Q4-Aufgaben lohnen sich meist nicht. Sind Sie sicher?';

  @override
  String get priorityMappingInfo =>
      'Prioritätszuordnung: Q1=Hoch, Q2=Mittel, Q3/Q4=Niedrig';

  @override
  String get selectColumns => 'Spalten wählen';

  @override
  String get allTasks => 'Alle Aufgaben';

  @override
  String get filterByColumn => 'Nach Spalte filtern';

  @override
  String get exportFromEisenhower => 'An Todo-Liste senden';

  @override
  String get exportFromEisenhowerDesc =>
      'Aktivitäten zum Export nach Smart Todo auswählen';

  @override
  String get filterByQuadrant => 'Nach Quadrant filtern:';

  @override
  String get allActivities => 'Alle';

  @override
  String activitiesSelectedCount(int count) {
    return '$count Aktivitäten ausgewählt';
  }

  @override
  String get noActivitiesSelected => 'Keine Aktivitäten in diesem Filter';

  @override
  String get unvoted => 'NICHT ABGESTIMMT';

  @override
  String tasksCreated(int count) {
    return '$count Aufgaben erstellt';
  }

  @override
  String get exportToUserStories => 'An agiles Projekt senden';

  @override
  String get exportToUserStoriesDesc =>
      'User Stories an ein agiles Projekt senden';

  @override
  String get selectDestinationProject => 'Zielprojekt wählen';

  @override
  String get existingProject => 'Existierendes Projekt';

  @override
  String get createNewProject => 'Neues Projekt erstellen';

  @override
  String get projectName => 'Projektname';

  @override
  String get projectNameHint => 'Name für das neue Projekt';

  @override
  String get selectProject => 'Projekt wählen';

  @override
  String get selectProjectHint => 'Spezifizieren Sie ein Zielprojekt';

  @override
  String get noProjectsAvailable =>
      'Keine Projekte verfügbar. Erstellen Sie ein neues.';

  @override
  String get userStoryFieldMappingInfo =>
      'Zuordnung: Titel → Story-Titel, Beschreibung → Beschreibung, Effort → Story Points, Priorität → Business Value';

  @override
  String storiesCreated(int count) {
    return '$count Stories erstellt';
  }

  @override
  String get configureNewProject => 'Neues Projekt konfigurieren';

  @override
  String get exportToAgileSprint => 'An Sprint senden';

  @override
  String get actionSend => 'Senden';

  @override
  String get exportToAgileSprintDesc =>
      'Geschätzte Stories zu einem agilen Projekt hinzufügen';

  @override
  String get selectSprint => 'Sprint wählen';

  @override
  String get selectSprintHint => 'Wählen Sie einen Zielsprint';

  @override
  String get noSprintsAvailable =>
      'Keine Sprints verfügbar. Erstellen Sie zuerst einen Sprint in der Planung.';

  @override
  String get sprintExportFieldMappingInfo =>
      'Zuordnung: Titel → Story-Titel, Beschreibung → Beschreibung, Schätzung → Story Points';

  @override
  String get exportToSprint => 'In agiles Projekt exportieren';

  @override
  String totalStoryPoints(int count) {
    return '$count Story Points insgesamt';
  }

  @override
  String storiesAddedToSprint(int count, String sprintName) {
    return '$count Stories zu $sprintName hinzugefügt';
  }

  @override
  String storiesAddedToProject(int count, String projectName) {
    return '$count Stories zum Projekt $projectName hinzugefügt';
  }

  @override
  String get exportEisenhowerToSprintDesc =>
      'Eisenhower-Aktivitäten in User Stories im agilen Projekt umwandeln';

  @override
  String get exportEisenhowerToEstimationDesc =>
      'Schätzsitzung aus Aktivitäten erstellen';

  @override
  String get selectedActivities => 'ausgewählte Aktivitäten';

  @override
  String get noActivitiesToExport => 'Keine Aktivitäten zum Exportieren';

  @override
  String get hiddenQ4Activities => 'Ausgeblendet';

  @override
  String get q4Activities => 'Q4-Aktivitäten (Eliminieren)';

  @override
  String get showQ4 => 'Q4 anzeigen';

  @override
  String get hideQ4 => 'Q4 ausblenden';

  @override
  String get showingAllActivities => 'Alle Aktivitäten werden angezeigt';

  @override
  String get eisenhowerMappingInfo =>
      'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Wichtigkeit→Business Value.';

  @override
  String get estimationExportInfo =>
      'Aktivitäten werden als zu schätzende Stories hinzugefügt. Q4-Aktivitäten werden nicht übertragen.';

  @override
  String get createSession => 'Sitzung erstellen';

  @override
  String get estimationType => 'Schätztyp';

  @override
  String activitiesAddedToSprint(int count, String sprintName) {
    return '$count Aktivitäten zu $sprintName hinzugefügt';
  }

  @override
  String activitiesAddedToProject(int count, String projectName) {
    return '$count Aktivitäten zum Projekt $projectName hinzugefügt';
  }

  @override
  String estimationSessionCreated(int count) {
    return 'Schätzsitzung mit $count Aktivitäten erstellt';
  }

  @override
  String activitiesExportedToSprint(int count, String sprintName) {
    return '$count Aktivitäten in Sprint $sprintName exportiert';
  }

  @override
  String activitiesExportedToEstimation(int count, String sessionName) {
    return '$count Aktivitäten in Schätzsitzung $sessionName exportiert';
  }

  @override
  String get archiveAction => 'Archivieren';

  @override
  String get archiveRestoreAction => 'Wiederherstellen';

  @override
  String get archiveShowArchived => 'Archivierte anzeigen';

  @override
  String get archiveHideArchived => 'Archivierte ausblenden';

  @override
  String archiveConfirmTitle(String itemType) {
    return '$itemType archivieren';
  }

  @override
  String get archiveConfirmMessage =>
      'Sind Sie sicher, dass Sie dieses Element archivieren möchten? Es kann später wiederhergestellt werden.';

  @override
  String archiveRestoreConfirmTitle(String itemType) {
    return '$itemType wiederherstellen';
  }

  @override
  String get archiveRestoreConfirmMessage =>
      'Möchten Sie dieses Element aus dem Archiv wiederherstellen?';

  @override
  String get archiveSuccessMessage => 'Projekt archiviert';

  @override
  String get archiveRestoreSuccessMessage => 'Projekt wiederhergestellt';

  @override
  String get archiveErrorMessage => 'Fehler beim Archivieren des Projekts';

  @override
  String get archiveRestoreErrorMessage =>
      'Fehler beim Wiederherstellen des Projekts';

  @override
  String get archiveFilterLabel => 'Archiv';

  @override
  String get archiveFilterActive => 'Aktiv';

  @override
  String get archiveFilterArchived => 'Archiviert';

  @override
  String get archiveFilterAll => 'Alle';

  @override
  String get archiveBadge => 'ARCHIV';

  @override
  String get archiveEmptyMessage => 'Keine archivierten Elemente';

  @override
  String get completeAction => 'Abschließen';

  @override
  String get reopenAction => 'Wieder öffnen';

  @override
  String completeConfirmTitle(String itemType) {
    return '$itemType abschließen';
  }

  @override
  String get completeConfirmMessage =>
      'Sind Sie sicher, dass Sie dieses Element abschließen möchten?';

  @override
  String get completeSuccessMessage => 'Element erfolgreich abgeschlossen';

  @override
  String get reopenSuccessMessage => 'Element erfolgreich wieder geöffnet';

  @override
  String get completedBadge => 'Abgeschlossen';

  @override
  String get inviteNewInvite => 'NEUE EINLADUNG';

  @override
  String get inviteRole => 'Rolle:';

  @override
  String get inviteSendEmailNotification => 'Benachrichtigungs-E-Mail senden';

  @override
  String get inviteSendInvite => 'Einladung senden';

  @override
  String get inviteLink => 'Einladungslink:';

  @override
  String get inviteList => 'EINLADUNGEN';

  @override
  String get inviteResend => 'Erneut senden';

  @override
  String get inviteRevokeMessage => 'Die Einladung wird ungültig.';

  @override
  String get inviteResent => 'Einladung erneut gesendet';

  @override
  String inviteSentByEmail(String email) {
    return 'Einladung per E-Mail an $email gesendet';
  }

  @override
  String get inviteStatusPending => 'Ausstehend';

  @override
  String get inviteStatusAccepted => 'Angenommen';

  @override
  String get inviteStatusDeclined => 'Abgelehnt';

  @override
  String get inviteStatusExpired => 'Abgelaufen';

  @override
  String get inviteStatusRevoked => 'Widerrufen';

  @override
  String get inviteGmailAuthTitle => 'Gmail-Autorisierung';

  @override
  String get inviteGmailAuthMessage =>
      'Zum Senden von Einladungs-E-Mails ist eine erneute Google-Authentifizierung erforderlich.\n\nMöchten Sie fortfahren?';

  @override
  String get inviteGmailAuthNo => 'Nein, nur Link';

  @override
  String get inviteGmailAuthYes => 'Autorisieren';

  @override
  String get inviteGmailNotAvailable =>
      'Gmail-Autorisierung nicht verfügbar. Bitte aus- und einloggen.';

  @override
  String get inviteGmailNoPermission => 'Gmail-Berechtigung nicht erteilt.';

  @override
  String get inviteEnterEmail => 'E-Mail eingeben';

  @override
  String get inviteInvalidEmail => 'Ungültige E-Mail';

  @override
  String get pendingInvites => 'Ausstehende Einladungen';

  @override
  String get noPendingInvites => 'Keine ausstehenden Einladungen';

  @override
  String invitedBy(String name) {
    return 'Eingeladen von $name';
  }

  @override
  String get inviteOpenInstance => 'Öffnen';

  @override
  String get inviteAcceptFirst => 'Einladung annehmen, um zu öffnen';

  @override
  String get inviteAccept => 'Annehmen';

  @override
  String get inviteDecline => 'Ablehnen';

  @override
  String get inviteAcceptedSuccess => 'Einladung erfolgreich angenommen!';

  @override
  String get inviteAcceptedError => 'Fehler beim Annehmen der Einladung';

  @override
  String get inviteDeclinedSuccess => 'Einladung abgelehnt';

  @override
  String get inviteDeclinedError => 'Fehler beim Ablehnen der Einladung';

  @override
  String get inviteDeclineTitle => 'Einladung ablehnen?';

  @override
  String get inviteDeclineMessage =>
      'Sind Sie sicher, dass Sie diese Einladung ablehnen möchten?';

  @override
  String expiresInHours(int hours) {
    return 'Läuft in ${hours}h ab';
  }

  @override
  String expiresInDays(int days) {
    return 'Läuft in ${days}T ab';
  }

  @override
  String get close => 'Schließen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get raciTitle => 'RACI-Matrix';

  @override
  String get raciNoActivities => 'Keine Aktivitäten verfügbar';

  @override
  String get raciAddActivity => 'Aktivität hinzufügen';

  @override
  String get raciAddColumn => 'Spalte hinzufügen';

  @override
  String get raciActivities => 'AKTIVITÄTEN';

  @override
  String get raciAssignRole => 'Rolle zuweisen';

  @override
  String get raciNone => 'Keine';

  @override
  String get raciSaving => 'Speichern...';

  @override
  String get raciSaveChanges => 'Änderungen speichern';

  @override
  String get raciSavedSuccessfully => 'Änderungen korrekt gespeichert';

  @override
  String get raciErrorSaving => 'Fehler beim Speichern';

  @override
  String get raciMissingAccountable => 'Accountable (A) fehlt';

  @override
  String get raciOnlyOneAccountable => 'Nur ein Accountable pro Aktivität';

  @override
  String get raciDuplicateRoles => 'Doppelte Rollen';

  @override
  String get raciNoResponsible => 'Kein Responsible (R) zugewiesen';

  @override
  String get raciTooManyInformed =>
      'Zu viele Informed (I): Reduzierung erwägen';

  @override
  String get raciNewColumn => 'Neue Spalte';

  @override
  String get raciRemoveColumn => 'Spalte entfernen';

  @override
  String raciRemoveColumnConfirm(String name) {
    return 'Spalte \"$name\" entfernen? Alle Rollenzuweisungen für diese Spalte werden gelöscht.';
  }

  @override
  String get votingDialogTitle => 'Abstimmen';

  @override
  String votingDialogVoteOf(String participant) {
    return 'Stimme von $participant';
  }

  @override
  String get votingDialogUrgency => 'DRINGLICHKEIT';

  @override
  String get votingDialogImportance => 'WICHTIGKEIT';

  @override
  String get votingDialogNotUrgent => 'Nicht dringend';

  @override
  String get votingDialogVeryUrgent => 'Sehr dringend';

  @override
  String get votingDialogNotImportant => 'Nicht wichtig';

  @override
  String get votingDialogVeryImportant => 'Sehr wichtig';

  @override
  String get votingDialogConfirmVote => 'Stimme bestätigen';

  @override
  String get votingDialogQuadrant => 'Quadrant:';

  @override
  String get voteCollectionTitle => 'Stimmen sammeln';

  @override
  String get voteCollectionParticipants => 'Teilnehmer';

  @override
  String get voteCollectionResult => 'Ergebnis:';

  @override
  String get voteCollectionAverage => 'Mittelwert:';

  @override
  String get voteCollectionSaveVotes => 'Stimmen speichern';

  @override
  String get scatterChartTitle => 'Aktivitätsverteilung';

  @override
  String get scatterChartNoActivities => 'Keine Aktivitäten bewertet';

  @override
  String get scatterChartVoteToShow =>
      'Aktivitäten bewerten, um sie im Diagramm anzuzeigen';

  @override
  String get scatterChartUrgencyLabel => 'Dringlichkeit:';

  @override
  String get scatterChartImportanceLabel => 'Wichtigkeit:';

  @override
  String get scatterChartAxisUrgency => 'DRINGLICHKEIT';

  @override
  String get scatterChartAxisImportance => 'WICHTIGKEIT';

  @override
  String get scatterChartQ1Label => 'Q1 - TUN';

  @override
  String get scatterChartQ2Label => 'Q2 - PLANEN';

  @override
  String get scatterChartQ3Label => 'Q3 - DELEGIEREN';

  @override
  String get scatterChartQ4Label => 'Q4 - ELIMINIEREN';

  @override
  String get scatterChartCardTitle => 'Verteilungsdiagramm';

  @override
  String get votingStatusYou => 'Du';

  @override
  String get votingStatusReset => 'Reset';

  @override
  String get estimationDecimalHintPlaceholder => 'z.B. 2.5';

  @override
  String get estimationDecimalSuffixDays => 'Tage';

  @override
  String get estimationDecimalVote => 'Abstimmen';

  @override
  String estimationDecimalVoteValue(String value) {
    return 'Stimme: $value Tage';
  }

  @override
  String get estimationDecimalQuickSelect => 'Schnellauswahl:';

  @override
  String get estimationDecimalEnterValue => 'Wert eingeben';

  @override
  String get estimationDecimalInvalidValue => 'Ungültiger Wert';

  @override
  String estimationDecimalMinValue(String value) {
    return 'Min: $value';
  }

  @override
  String estimationDecimalMaxValue(String value) {
    return 'Max: $value';
  }

  @override
  String get estimationThreePointTitle => 'Drei-Punkt-Schätzung (PERT)';

  @override
  String get estimationThreePointOptimistic => 'Optimistisch (O)';

  @override
  String get estimationThreePointRealistic => 'Realistisch (M)';

  @override
  String get estimationThreePointPessimistic => 'Pessimistisch';

  @override
  String get estimationThreePointBestCase => 'Bester Fall';

  @override
  String get estimationThreePointMostLikely => 'Wahrscheinlichster Fall';

  @override
  String get estimationThreePointWorstCase => 'Schlechtester Fall';

  @override
  String get estimationThreePointAllFieldsRequired =>
      'Alle Felder sind erforderlich';

  @override
  String get estimationThreePointInvalidValues => 'Ungültige Werte';

  @override
  String get estimationThreePointOptMustBeLteReal =>
      'Optimistisch muss <= Realistisch sein';

  @override
  String get estimationThreePointRealMustBeLtePess =>
      'Realistisch muss <= Pessimistisch sein';

  @override
  String get estimationThreePointOptMustBeLtePess =>
      'Optimistisch muss <= Pessimistisch sein';

  @override
  String get estimationThreePointGuide => 'Leitfaden:';

  @override
  String get estimationThreePointGuideO =>
      'O: Schätzung im besten Fall (alles läuft gut)';

  @override
  String get estimationThreePointGuideM =>
      'M: Wahrscheinlichste Schätzung (normale Bedingungen)';

  @override
  String get estimationThreePointGuideP =>
      'P: Schätzung im schlechtesten Fall (unvorhergesehenes)';

  @override
  String get estimationThreePointStdDev => 'Std.-Abw.';

  @override
  String get estimationThreePointDaysSuffix => 'Tg';

  @override
  String get storyFormNewStory => 'Neue Story';

  @override
  String get storyFormEnterTitle => 'Titel eingeben';

  @override
  String get sessionSearchHint => 'Sitzungen suchen...';

  @override
  String get sessionSearchFilters => 'Filter';

  @override
  String get sessionSearchFiltersTooltip => 'Filter';

  @override
  String get sessionSearchStatusLabel => 'Status: ';

  @override
  String get sessionSearchStatusAll => 'Alle';

  @override
  String get sessionSearchStatusDraft => 'Entwurf';

  @override
  String get sessionSearchStatusActive => 'Aktiv';

  @override
  String get sessionSearchStatusCompleted => 'Abgeschlossen';

  @override
  String get sessionSearchModeLabel => 'Modus: ';

  @override
  String get sessionSearchModeAll => 'Alle';

  @override
  String get sessionSearchRemoveFilters => 'Filter entfernen';

  @override
  String get sessionSearchActiveFilters => 'Aktive Filter:';

  @override
  String get sessionSearchRemoveAllFilters => 'Alle entfernen';

  @override
  String participantsTitle(int count) {
    return 'Teilnehmer ($count)';
  }

  @override
  String get participantRoleFacilitator => 'Facilitator';

  @override
  String get participantRoleVoters => 'Wähler';

  @override
  String get participantRoleObservers => 'Beobachter';

  @override
  String get votingBoardVotesRevealed => 'Stimmen enthüllt';

  @override
  String get votingBoardVotingInProgress => 'Abstimmung läuft';

  @override
  String votingBoardVotesCount(int voted, int total) {
    return '$voted/$total Stimmen';
  }

  @override
  String get estimationSelectYourEstimate => 'Wählen Sie Ihre Schätzung';

  @override
  String estimationVoteSelected(String value) {
    return 'Gewählte Stimme: $value';
  }

  @override
  String get estimationDotVotingTitle => 'Dot Voting';

  @override
  String get estimationDotVotingDesc =>
      'Abstimmungsmodus mit Punktvergabe.\nDemnächst...';

  @override
  String get estimationBucketSystemTitle => 'Bucket System';

  @override
  String get estimationBucketSystemDesc =>
      'Schätzung nach Affinität mit Gruppierung.\nDemnächst...';

  @override
  String get estimationModeTitle => 'Schätzmodus';

  @override
  String get statisticsTitle => 'Abstimmungsstatistiken';

  @override
  String get statisticsAverage => 'Durchschnitt';

  @override
  String get statisticsMedian => 'Median';

  @override
  String get statisticsMode => 'Modalwert';

  @override
  String get statisticsVoters => 'Wähler';

  @override
  String get statisticsPertStats => 'PERT-Statistiken';

  @override
  String get statisticsPertAvg => 'PERT-Durchschnitt';

  @override
  String get statisticsStdDev => 'Std.-Abw.';

  @override
  String get statisticsVariance => 'Varianz';

  @override
  String get statisticsRange => 'Bereich:';

  @override
  String get statisticsConsensusReached => 'Konsens erreicht!';

  @override
  String get retroGuideTooltip => 'Leitfaden für Retrospektiven';

  @override
  String get retroSearchPlaceholder => 'Retrospektive suchen...';

  @override
  String get retroNoSearchResults => 'Keine Suchergebnisse';

  @override
  String get retroNewRetro => 'Neue Retrospektive';

  @override
  String get retroNoProjectsFound => 'Keine Projekte gefunden.';

  @override
  String retroDeleteMessage(String retroName) {
    return 'Sind Sie sicher, dass Sie die Retrospektive \"$retroName\" dauerhaft löschen möchten?\n\nDiese Aktion ist unumkehrbar und löscht alle zugehörigen Daten (Karten, Stimmen, Action Items).';
  }

  @override
  String get retroDeletePermanently => 'Dauerhaft löschen';

  @override
  String get retroDeletedSuccess => 'Retrospektive erfolgreich gelöscht';

  @override
  String retroDeleteActionItemsWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dies löscht auch $count verknüpfte Action Items.',
      one: 'Dies löscht auch 1 verknüpftes Action Item.',
    );
    return '$_temp0';
  }

  @override
  String get actionIrreversible =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get lessonsLearnedSearchPlaceholder => 'Lektionen suchen...';

  @override
  String errorPrefix(String error) {
    return 'Fehler: $error';
  }

  @override
  String get loaderProjectIdMissing => 'Projekt-ID fehlt';

  @override
  String get loaderProjectNotFound => 'Projekt nicht gefunden';

  @override
  String get loaderLoadError => 'Fehler beim Laden';

  @override
  String get loaderError => 'Fehler';

  @override
  String get loaderUnknownError => 'Unbekannter Fehler';

  @override
  String get actionGoBack => 'Zurückgehen';

  @override
  String get authRequired => 'Authentifizierung erforderlich';

  @override
  String get retroIdMissing => 'Retrospektive-ID fehlt';

  @override
  String get pokerInviteStatusAccepted => 'Angenommen';

  @override
  String get pokerInviteStatusDeclined => 'Abgelehnt';

  @override
  String get pokerInviteStatusExpired => 'Abgelaufen';

  @override
  String get pokerInviteStatusRevoked => 'Widerrufen';

  @override
  String get pokerInviteStatusPending => 'Ausstehend';

  @override
  String get pokerInviteYouAreInvited => 'Du bist eingeladen';

  @override
  String pokerInviteInvitedBy(String name) {
    return 'Eingeladen von';
  }

  @override
  String get pokerInviteSessionLabel => 'Sitzung';

  @override
  String get pokerInviteProjectLabel => 'Projekt';

  @override
  String get pokerInviteRoleLabel => 'Rolle';

  @override
  String get pokerInviteExpiryLabel => 'Ablauf';

  @override
  String pokerInviteExpiryDays(int days) {
    return 'Tage';
  }

  @override
  String get pokerInviteDecline => 'Ablehnen';

  @override
  String get pokerInviteAccept => 'Annehmen';

  @override
  String loadingMatrixError(String error) {
    return 'Fehler beim Laden der Matrix';
  }

  @override
  String loadingDataError(String error) {
    return 'Fehler beim Laden der Daten';
  }

  @override
  String loadingActivitiesError(String error) {
    return 'Fehler beim Laden der Aktivitäten';
  }

  @override
  String smartTodoSprintDays(int days) {
    return '$days Tage/Sprint';
  }

  @override
  String smartTodoHoursPerDay(int hours) {
    return '$hours Std/Tag';
  }

  @override
  String get smartTodoImageFromClipboardFound =>
      'Bild in der Zwischenablage gefunden';

  @override
  String get smartTodoAddImageFromClipboard =>
      'Bild aus Zwischenablage hinzufügen';

  @override
  String get smartTodoInviteCreatedAndSent => 'Einladung erstellt und gesendet';

  @override
  String get retroColumnDropDesc =>
      'Was bringt keinen Mehrwert und sollte eliminiert werden?';

  @override
  String get retroColumnAddDesc =>
      'Welche neuen Praktiken sollten wir einführen?';

  @override
  String get retroColumnKeepDesc =>
      'Was läuft gut and sollte beibehalten werden?';

  @override
  String get retroColumnImproveDesc => 'Was können wir besser machen?';

  @override
  String get retroColumnStart => 'Start';

  @override
  String get retroColumnStartDesc =>
      'Welche neuen Aktivitäten sollten wir starten?';

  @override
  String get retroColumnStop => 'Stopp';

  @override
  String get retroColumnStopDesc => 'Was sollte gestoppt werden?';

  @override
  String get retroColumnContinue => 'Weiter';

  @override
  String get retroColumnContinueDesc => 'Was sollten wir fortführen?';

  @override
  String get retroColumnLongedFor => 'Gewünscht';

  @override
  String get retroColumnLikedDesc => 'Was hat dir gefallen?';

  @override
  String get retroColumnLearnedDesc => 'Was hast du gelernt?';

  @override
  String get retroColumnLackedDesc => 'Was hat gefehlt?';

  @override
  String get retroColumnLongedForDesc => 'Was wünschst du dir für die Zukunft?';

  @override
  String get retroColumnMadDesc => 'Was hat dich geärgert?';

  @override
  String get retroColumnSadDesc => 'Was hat dich traurig gemacht?';

  @override
  String get retroColumnGladDesc => 'Was hat dich gefreut?';

  @override
  String get retroColumnWindDesc => 'Was hat uns vorangebracht?';

  @override
  String get retroColumnAnchorDesc => 'Was hat uns gebremst?';

  @override
  String get retroColumnRockDesc => 'Welche Risiken siehst du?';

  @override
  String get retroColumnGoalDesc => 'Was ist unser Ziel?';

  @override
  String get retroColumnMoreDesc => 'Wovon sollten wir mehr tun?';

  @override
  String get retroColumnLessDesc => 'Wovon sollten wir weniger tun?';

  @override
  String get actionTypeMaintain => 'Beibehalten';

  @override
  String get actionTypeStop => 'Stoppen';

  @override
  String get actionTypeBegin => 'Beginnen';

  @override
  String get actionTypeIncrease => 'Erhöhen';

  @override
  String get actionTypeDecrease => 'Verringern';

  @override
  String get actionTypePrevent => 'Verhindern';

  @override
  String get actionTypeCelebrate => 'Feiern';

  @override
  String get actionTypeReplicate => 'Replizieren';

  @override
  String get actionTypeShare => 'Teilen';

  @override
  String get actionTypeProvide => 'Bereitstellen';

  @override
  String get actionTypePlan => 'Planen';

  @override
  String get actionTypeLeverage => 'Nutzen';

  @override
  String get actionTypeRemove => 'Entfernen';

  @override
  String get actionTypeMitigate => 'Abmildern';

  @override
  String get actionTypeAlign => 'Ausrichten';

  @override
  String get actionTypeEliminate => 'Eliminieren';

  @override
  String get actionTypeImplement => 'Implementieren';

  @override
  String get actionTypeEnhance => 'Verbessern';

  @override
  String get actionItemStatus => 'Status';

  @override
  String get actionStatusOpen => 'Offen';

  @override
  String get actionStatusInProgress => 'In Bearbeitung';

  @override
  String get actionStatusCompleted => 'Abgeschlossen';

  @override
  String get actionStatusDeferred => 'Aufgeschoben';

  @override
  String get retroSectionActive => 'Aktiv';

  @override
  String get retroSectionHistory => 'Verlauf';

  @override
  String get retroSectionActionTracker => 'Massnahmen-Tracker';

  @override
  String get retroSectionLessonsLearned => 'Lessons Learned';

  @override
  String get retroNoActiveRetro => 'Keine aktive Retrospektive';

  @override
  String get retroStartNew => 'Neue Retrospektive';

  @override
  String get retroHistoryEmpty => 'Keine abgeschlossenen Retrospektiven';

  @override
  String get retroViewSummary => 'Zusammenfassung anzeigen';

  @override
  String get retroSummaryTitle => 'Retrospektive-Zusammenfassung';

  @override
  String retroSummaryCards(Object count) {
    return 'Karten';
  }

  @override
  String retroSummaryActions(Object count) {
    return 'Massnahmen';
  }

  @override
  String get retroSummarySentiment => 'Stimmung';

  @override
  String get actionTrackerTitle => 'Massnahmen-Tracker';

  @override
  String get actionTrackerEmpty => 'Keine Massnahmen gefunden';

  @override
  String get actionTrackerFilterByAssignee => 'Nach Zuständigem filtern';

  @override
  String get actionTrackerFilterByStatus => 'Nach Status filtern';

  @override
  String get actionTrackerFilterByRetro => 'Nach Retrospektive filtern';

  @override
  String get actionTrackerCompletionRate => 'Abschlussrate';

  @override
  String get actionTrackerCarryForward => 'Übertragen';

  @override
  String get actionTrackerCarryForwardDesc =>
      'Wählen Sie unvollständige Massnahmen aus, die in die neue Retrospektive übertragen werden sollen';

  @override
  String get actionTrackerCarryForwardConfirm =>
      'Gewählte Massnahmen übertragen';

  @override
  String get lessonsLearnedTitle => 'Lessons Learned Register';

  @override
  String get lessonsLearnedEmpty => 'Keine Lektionen erfasst';

  @override
  String get lessonsLearnedCreate => 'Lektion erstellen';

  @override
  String get lessonsLearnedEdit => 'Lektion bearbeiten';

  @override
  String get lessonsLearnedDelete => 'Lektion löschen';

  @override
  String get lessonsLearnedDeleteConfirm =>
      'Möchten Sie diese Lektion wirklich löschen?';

  @override
  String get lessonCategoryProcess => 'Prozess';

  @override
  String get lessonCategoryTechnical => 'Technisch';

  @override
  String get lessonCategoryTeam => 'Team';

  @override
  String get lessonCategoryCommunication => 'Kommunikation';

  @override
  String get lessonCategoryTools => 'Werkzeuge';

  @override
  String get lessonCategoryQuality => 'Qualität';

  @override
  String get lessonCategoryEstimation => 'Schätzung';

  @override
  String get lessonTypeStrength => 'Stärke';

  @override
  String get lessonTypeWeakness => 'Schwäche';

  @override
  String get lessonTypeRecommendation => 'Empfehlung';

  @override
  String get lessonFieldTitle => 'Titel';

  @override
  String get lessonFieldDescription => 'Beschreibung';

  @override
  String get lessonFieldRootCause => 'Ursache';

  @override
  String get lessonFieldRecommendation => 'Empfehlung';

  @override
  String get lessonFieldTags => 'Tags';

  @override
  String get lessonIsRecurring => 'Wiederkehrend';

  @override
  String lessonOccurrenceCount(Object count) {
    return 'Vorkommen';
  }

  @override
  String get lessonIsResolved => 'Gelöst';

  @override
  String get generateLessonsTitle => 'Lessons Learned generieren';

  @override
  String get generateLessonsDesc =>
      'Generieren Sie Lektionen automatisch aus Ihren Karten oder Massnahmen';

  @override
  String get generateLessonsFromCards => 'Aus Retro-Karten generieren';

  @override
  String get generateLessonsFromActions => 'Aus Massnahmen generieren';

  @override
  String get generateLessonsSelectToSave =>
      'Wählen Sie die Lektionen aus, die Sie speichern möchten';

  @override
  String get generateLessonsSave => 'Ausgewählte Lektionen speichern';

  @override
  String get retroTrendTitle => 'Retro-Trends';

  @override
  String get retroTrendSentiment => 'Sentiment-Trend';

  @override
  String get retroTrendActionCompletion => 'Massnahmen-Abschluss';

  @override
  String get retroTrendImproving => 'Verbessernd';

  @override
  String get retroTrendStable => 'Stabil';

  @override
  String get retroTrendDeclining => 'Abnehmend';

  @override
  String get crossProjectImport => 'Projektübergreifender Import';

  @override
  String get crossProjectImportActions => 'Massnahmen importieren';

  @override
  String get crossProjectImportLessons => 'Lessons Learned importieren';

  @override
  String get crossProjectSelectProject => 'Projekt auswählen';

  @override
  String get crossProjectNoProjects => 'Keine anderen Projekte verfügbar';

  @override
  String crossProjectImportSuccess(Object count) {
    return 'Erfolgreich importiert';
  }

  @override
  String get crossProjectAggregatedView => 'Aggregierte Ansicht';

  @override
  String get tooltipTrackerStatusClick => 'Klicken, um den Status zu ändern';

  @override
  String get tooltipTrackerFilterStatus => 'Nach Status filtern';

  @override
  String get tooltipTrackerFilterAssignee => 'Nach Zuständigem filtern';

  @override
  String get tooltipTrackerFilterRetro => 'Nach Retrospektive filtern';

  @override
  String get tooltipTrackerCompletionRate =>
      'Prozentsatz der abgeschlossenen Massnahmen';

  @override
  String get tooltipTrackerOverdue => 'Überfällige Massnahme';

  @override
  String get tooltipPriorityCritical => 'Kritisch: Sofort erledigen';

  @override
  String get tooltipPriorityHigh => 'Hoch: In diesem Sprint erledigen';

  @override
  String get tooltipPriorityMedium => 'Mittel';

  @override
  String get tooltipPriorityLow => 'Niedrig';

  @override
  String get tooltipLessonCategoryFilter => 'Nach Kategorie filtern';

  @override
  String get tooltipLessonTypeFilter => 'Nach Typ filtern';

  @override
  String get tooltipLessonResolvedFilter => 'Nach Status filtern';

  @override
  String get tooltipLessonRecurring => 'Wiederkehrendes Muster';

  @override
  String get tooltipLessonResolved => 'Als gelöst markiert';

  @override
  String get tooltipLessonImport =>
      'Lektionen aus anderen Projekten importieren';

  @override
  String get tooltipLessonAdd => 'Neue Lektion manuell hinzufügen';

  @override
  String get tooltipLessonLongPressDelete => 'Gedrückt halten zum Löschen';

  @override
  String get tooltipCarryForwardDesc =>
      'Unvollständige Massnahmen in die neue Retro übernehmen';

  @override
  String get tooltipCarryForwardSelectAll => 'Alle auswählen/abwählen';

  @override
  String get tooltipCrossProjectImportDesc =>
      'Massnahmen oder Lektionen aus anderen Projekten importieren';

  @override
  String get tooltipTrendSentiment =>
      'Stimmungsentwicklung über die letzten Retrospektiven';

  @override
  String get tooltipTrendCompletion => 'Massnahmen-Abschlussrate Trend';

  @override
  String get tooltipTrendImproving => 'Positiver Trend';

  @override
  String get tooltipTrendDeclining => 'Negativer Trend';

  @override
  String get tooltipTrendStable => 'Stabiler Trend';

  @override
  String get tooltipHistoryRetroCard => 'Retrospektive-Zusammenfassung öffnen';

  @override
  String get tooltipHistorySentiment =>
      'Durchschnittliches Sentiment dieser Retro';

  @override
  String get tooltipHistoryActionCount => 'Anzahl der erstellten Massnahmen';

  @override
  String get tooltipFormRootCause =>
      'Beschreiben Sie die eigentliche Ursache (Why?)';

  @override
  String get tooltipFormRecommendation =>
      'Geben Sie konkrete Ratschläge für die Zukunft';

  @override
  String get tooltipFormTags =>
      'Kategorisieren Sie die Lektion für einfacheres Suchen';

  @override
  String get tooltipFormRecurring => 'Markieren, wenn dies öfter vorkommt';

  @override
  String get tooltipFormResolved =>
      'Markieren, wenn das Problem dauerhaft gelöst ist';

  @override
  String get guideActionTrackingTitle => 'Massnahmen-Verfolgung';

  @override
  String get guideActionTrackingDesc =>
      'Verfolgen Sie die in der Retrospektive vereinbarten Massnahmen, um eine kontinuierliche Verbesserung sicherzustellen.';

  @override
  String get guideLessonsLearnedTitle => 'Lessons Learned';

  @override
  String get guideLessonsLearnedDesc =>
      'Erfassen und teilen Sie Wissen, um Fehler nicht zu wiederholen und Success Stories zu festigen.';

  @override
  String get guideContinuousImprovementTitle => 'Kontinuierliche Verbesserung';

  @override
  String get guideContinuousImprovementDesc =>
      'Nutzen Sie Trends und Analysen, um das Team-Wachstum über die Zeit zu visualisieren.';

  @override
  String get guideCarryForwardTitle => 'Massnahmen übertragen';

  @override
  String get guideCarryForwardDesc =>
      'Verlieren Sie keine wichtigen Punkte. Übertragen Sie unvollständige Massnahmen in die nächste Sitzung.';

  @override
  String retroFromSprint(Object name) {
    return 'Aus Sprint';
  }

  @override
  String actionItemsCompleted(Object completed, Object total) {
    return '$completed/$total abgeschlossen';
  }

  @override
  String get coachTipSSCWriting =>
      'Konzentrieren Sie sich auf konkretes, beobachtbares Verhalten. Jeder Punkt sollte etwas sein, auf das das Team direkt einwirken kann. Vermeiden Sie vage Aussagen.';

  @override
  String get coachTipSSCVoting =>
      'Stimmen Sie basierend auf Wirkung und Machbarkeit ab. Die am höchsten bewerteten Punkte werden zu den Verpflichtungen des nächsten Sprints.';

  @override
  String get coachTipSSCDiscuss =>
      'Definieren Sie für jeden Top-Punkt: WER macht WAS bis WANN. Verwandeln Sie Erkenntnisse in spezifische Aktionen.';

  @override
  String get coachTipMSGWriting =>
      'Schaffen Sie einen sicheren Raum für Emotionen. Alle Gefühle sind gültig. Fokus auf die Situation, nicht die Person. Nutzen Sie \'Ich fühle mich...\'-Aussagen.';

  @override
  String get coachTipMSGVoting =>
      'Stimmen Sie ab, um geteilte Erfahrungen zu identifizieren. Muster in Emotionen offenbaren Teamdynamiken, die Aufmerksamkeit erfordern.';

  @override
  String get coachTipMSGDiscuss =>
      'Erkennen Sie Emotionen an, bevor Sie Probleme lösen. Fragen Sie \'Was würde helfen?\', anstatt sofort zu Lösungen zu springen. Hören Sie aktiv zu.';

  @override
  String get coachTip4LsWriting =>
      'Reflektieren Sie über Erkenntnisse, nicht nur Ereignisse. Überlegen Sie, welche Einsichten Sie mitnehmen. Jedes L steht für eine andere Perspektive.';

  @override
  String get coachTip4LsVoting =>
      'Priorisieren Sie Erkenntnisse, die zukünftige Sprints verbessern könnten. Fokus auf transferierbares Wissen.';

  @override
  String get coachTip4LsDiscuss =>
      'Verwandeln Sie Erkenntnisse in Dokumentation oder Prozessänderungen. Fragen Sie \'Wie können wir dieses Wissen mit anderen teilen?\'';

  @override
  String get coachTipSailboatWriting =>
      'Nutzen Sie die Metapher: Wind treibt uns voran (Enabler), Anker bremsen uns (Blocker), Felsen sind Risiken, die Insel ist das Ziel.';

  @override
  String get coachTipSailboatVoting =>
      'Priorisieren Sie nach Risikoauswirkung und Enabler-Potenzial. Balance zwischen Blocker-Beseitigung und Stärken-Nutzung.';

  @override
  String get coachTipSailboatDiscuss =>
      'Erstellen Sie ein Risikoregister für die Felsen. Definieren Sie Minderungsstrategien. Nutzen Sie den Wind, um die Anker zu überwinden.';

  @override
  String get coachTipDAKIWriting =>
      'Seien Sie entscheidungsfreudig: Eliminieren Sie Zeitfresser, fügen Sie Fehlendes hinzu, behalten Sie Funktionierendes, verbessern Sie Ausbaufähiges.';

  @override
  String get coachTipDAKIVoting =>
      'Stimmen Sie pragmatisch ab. Fokus auf Änderungen mit sofortiger, messbarer Wirkung.';

  @override
  String get coachTipDAKIDiscuss =>
      'Treffen Sie klare Teamentscheidungen. Verpflichten Sie sich für jeden Punkt zu einer spezifischen Aktion oder entscheiden Sie explizit dagegen.';

  @override
  String get coachTipStarfishWriting =>
      'Nutzen Sie die Nuancen: Beibehalten, Mehr von, Weniger von, Stoppen, Starten. Dies ermöglicht differenziertes Feedback.';

  @override
  String get coachTipStarfishVoting =>
      'Berücksichtigen Sie Aufwand vs. Wirkung. \'Mehr\' und \'Weniger\' sind oft einfacher umzusetzen als \'Start\' und \'Stopp\'.';

  @override
  String get coachTipStarfishDiscuss =>
      'Definieren Sie spezifische Metriken für \'Mehr\' und \'Weniger\'. Wie viel mehr? Wie messen wir das? Klare Kalibrierungsziele setzen.';

  @override
  String get discussPromptSSCStart =>
      'Welche neue Praktik sollten wir starten? Denken Sie an Lücken im Prozess, die eine neue Gewohnheit füllen könnte.';

  @override
  String get discussPromptSSCStop =>
      'Was verschwendet Zeit oder Energie? Betrachten Sie Aktivitäten ohne angemessenen Mehrwert.';

  @override
  String get discussPromptSSCContinue =>
      'Was läuft gut? Erkennen und verstärken Sie effektive Praktiken.';

  @override
  String get discussPromptMSGMad =>
      'Was hat Sie frustriert? Diskutieren Sie Situationen, beschuldigen Sie keine Personen.';

  @override
  String get discussPromptMSGSad =>
      'Was hat Sie enttäuscht? Welche Erwartungen wurden nicht erfüllt?';

  @override
  String get discussPromptMSGGlad =>
      'Was hat Sie glücklich gemacht? Welche Momente waren in diesem Sprint zufriedenstellend?';

  @override
  String get discussPrompt4LsLiked =>
      'Was hat Ihnen gefallen? Was machte die Arbeit angenehm?';

  @override
  String get discussPrompt4LsLearned =>
      'Welche neuen Fähigkeiten oder Erkenntnisse haben Sie gewonnen?';

  @override
  String get discussPrompt4LsLacked =>
      'Was hat gefehlt? Welche Ressourcen oder Unterstützung hätten geholfen?';

  @override
  String get discussPrompt4LsLonged =>
      'Was wünschen Sie sich? Was würde zukünftige Sprints besser machen?';

  @override
  String get discussPromptSailboatWind =>
      'Was hat uns vorangebracht? Stärken und externe Unterstützung.';

  @override
  String get discussPromptSailboatAnchor =>
      'Was hat uns gebremst? Welche Hindernisse hielten uns zurück?';

  @override
  String get discussPromptSailboatRock =>
      'Welche Risiken sehen wir am Horizont? Was könnte uns entgleisen lassen?';

  @override
  String get discussPromptSailboatGoal =>
      'Was ist unser Ziel? Sind wir uns über die Richtung einig?';

  @override
  String get discussPromptDAKIDrop =>
      'Was sollten wir eliminieren? Was bringt keinen Mehrwert?';

  @override
  String get discussPromptDAKIAdd =>
      'Was sollten wir einführen? Was fehlt in unserem Toolkit?';

  @override
  String get discussPromptDAKIKeep =>
      'Was müssen wir bewahren? Was ist essenziell für unseren Erfolg?';

  @override
  String get discussPromptDAKIImprove =>
      'Was könnte besser sein? Wo haben wir Ausbaupotenzial?';

  @override
  String get discussPromptStarfishKeep =>
      'Was sollten wir genau so beibehalten, wie es ist?';

  @override
  String get discussPromptStarfishMore =>
      'Was sollten wir steigern? Mehr davon tun?';

  @override
  String get discussPromptStarfishLess =>
      'Was sollten wir reduzieren? Weniger davon tun?';

  @override
  String get discussPromptStarfishStop =>
      'Was sollten wir komplett einstellen?';

  @override
  String get discussPromptStarfishStart =>
      'Welche neue Sache sollten wir beginnen?';

  @override
  String get discussPromptGeneric =>
      'Welche Erkenntnisse ergeben sich aus dieser Spalte? Welche Muster sehen Sie?';

  @override
  String get smartPromptSSCStartQuestion =>
      'Welche spezifische neue Praktik werden Sie starten und wie messen Sie deren Übernahme?';

  @override
  String get smartPromptSSCStartExample =>
      'z.B. \'Tägliches 15-Min.-Standup um 9:30 Uhr starten, Teilnahme 2 Wochen lang tracken\'';

  @override
  String get smartPromptSSCStartPlaceholder =>
      'Wir starten [Praktik] bis [Datum], gemessen an [Metrik]';

  @override
  String get smartPromptSSCStopQuestion =>
      'Was werden Sie aufhören zu tun und was tun Sie stattdessen?';

  @override
  String get smartPromptSSCStopExample =>
      'z.B. \'Status-Updates nicht mehr per E-Mail senden, stattdessen Slack-Kanal #updates nutzen\'';

  @override
  String get smartPromptSSCStopPlaceholder =>
      'Wir stoppen [Praktik] und nutzen stattdessen [Alternative]';

  @override
  String get smartPromptSSCContinueQuestion =>
      'Welche Praktik führen Sie weiter und wie stellen Sie sicher, dass sie nicht einschläft?';

  @override
  String get smartPromptSSCContinueExample =>
      'z.B. \'Code-Reviews innerhalb von 4h beibehalten, in Definition of Done aufnehmen\'';

  @override
  String get smartPromptSSCContinuePlaceholder =>
      'Wir führen [Praktik] weiter, verstärkt durch [Mechanismus]';

  @override
  String get smartPromptMSGMadQuestion =>
      'Welche Aktion adressiert diese Frustration und wer leitet sie?';

  @override
  String get smartPromptMSGMadExample =>
      'z.B. \'Meeting mit PM planen, um Anforderungsprozess zu klären - Maria bis Freitag\'';

  @override
  String get smartPromptMSGMadPlaceholder =>
      '[Aktion gegen Frustration], Verantwortlich: [Name], bis: [Datum]';

  @override
  String get smartPromptMSGSadQuestion =>
      'Welche Änderung verhindert, dass sich diese Enttäuschung wiederholt?';

  @override
  String get smartPromptMSGSadExample =>
      'z.B. \'Kommunikations-Checkliste für Stakeholder-Updates erstellen - wöchentliche Prüfung\'';

  @override
  String get smartPromptMSGSadPlaceholder =>
      '[Präventivmaßnahme], getrackt über [Methode]';

  @override
  String get smartPromptMSGGladQuestion =>
      'Wie können wir replizieren oder verstärken, was uns glücklich gemacht hat?';

  @override
  String get smartPromptMSGGladExample =>
      'z.B. \'Pairing-Session-Format dokumentieren und bis zum Wochenende mit anderen Teams teilen\'';

  @override
  String get smartPromptMSGGladPlaceholder =>
      '[Aktion zum Replizieren/Verstärken], teilen mit [Zielgruppe]';

  @override
  String get smartPrompt4LsLikedQuestion =>
      'Wie stellen wir sicher, dass diese positive Erfahrung fortbesteht?';

  @override
  String get smartPrompt4LsLikedExample =>
      'z.B. \'Mob-Programming-Session als wöchentlich wiederkehrenden Termin im Kalender festlegen\'';

  @override
  String get smartPrompt4LsLikedPlaceholder =>
      '[Aktion zur Erhaltung positiver Erfahrung]';

  @override
  String get smartPrompt4LsLearnedQuestion =>
      'Wie dokumentieren und teilen Sie diese Erkenntnis?';

  @override
  String get smartPrompt4LsLearnedExample =>
      'z.B. \'Wiki-Artikel über neuen Testansatz schreiben, im Tech-Talk nächsten Monat präsentieren\'';

  @override
  String get smartPrompt4LsLearnedPlaceholder =>
      'Dokumentieren in [Ort], teilen via [Metode] bis [Datum]';

  @override
  String get smartPrompt4LsLackedQuestion =>
      'Welche spezifischen Ressourcen oder Unterstützung fordern Sie bei wem an?';

  @override
  String get smartPrompt4LsLackedExample =>
      'z.B. \'CI/CD-Trainingsbudget beim Manager anfordern - bis zur nächsten Planung einreichen\'';

  @override
  String get smartPrompt4LsLackedPlaceholder =>
      '[Ressource] anfordern von [Person/Team], Deadline: [Datum]';

  @override
  String get smartPrompt4LsLongedQuestion =>
      'Welcher erste konkrete Schritt bringt Sie diesem Wunsch näher?';

  @override
  String get smartPrompt4LsLongedExample =>
      'z.B. \'Vorschlag für 20% Zeit für Nebenprojekte entwerfen - Teamlead am Montag vorlegen\'';

  @override
  String get smartPrompt4LsLongedPlaceholder =>
      'Erster Schritt zu [Wunsch]: [Aktion] bis [Datum]';

  @override
  String get smartPromptSailboatWindQuestion =>
      'Wie nutzen Sie diesen Enabler, um den Fortschritt zu beschleunigen?';

  @override
  String get smartPromptSailboatWindExample =>
      'z.B. \'Starke QA-Kompetenz für Mentoring Junioren nutzen - erste Sitzung diese Woche planen\'';

  @override
  String get smartPromptSailboatWindPlaceholder =>
      '[Enabler] nutzen durch [spezifische Aktion]';

  @override
  String get smartPromptSailboatAnchorQuestion =>
      'Welche spezifische Aktion beseitigt oder reduziert diesen Blocker?';

  @override
  String get smartPromptSailboatAnchorExample =>
      'z.B. \'Infrastrukturproblem an CTO eskalieren - Briefing bis Mittwoch vorbereiten\'';

  @override
  String get smartPromptSailboatAnchorPlaceholder =>
      '[Blocker] entfernen durch [Aktion], Eskalation an [Person] falls nötig';

  @override
  String get smartPromptSailboatRockQuestion =>
      'Welche Minderungsstrategie implementieren Sie für dieses Risiko?';

  @override
  String get smartPromptSailboatRockExample =>
      'z.B. \'Fallback-Plan für Vendor-Abhängigkeit erstellen - Alternativen bis Sprint-Ende dokumentieren\'';

  @override
  String get smartPromptSailboatRockPlaceholder =>
      '[Risiko] mindern durch [Strategie], Trigger: [Bedingung]';

  @override
  String get smartPromptSailboatGoalQuestion =>
      'Welcher Meilenstein bestätigt den Fortschritt in Richtung dieses Ziels?';

  @override
  String get smartPromptSailboatGoalExample =>
      'z.B. \'MVP-Demo für Stakeholder bis 15. Feb., Feedback via Umfrage sammeln\'';

  @override
  String get smartPromptSailboatGoalPlaceholder =>
      'Meilenstein zu [Ziel]: [Ergebnis] bis [Datum]';

  @override
  String get smartPromptDAKIDropQuestion =>
      'Was eliminieren Sie und wie stellen Sie sicher, dass es nicht zurückkehrt?';

  @override
  String get smartPromptDAKIDropExample =>
      'z.B. \'Manuelle Deployment-Schritte entfernen - bis Sprint-Ende automatisieren\'';

  @override
  String get smartPromptDAKIDropPlaceholder =>
      '[Praktik] eliminieren, Rückkehr verhindern durch [Mechanismus]';

  @override
  String get smartPromptDAKIAddQuestion =>
      'Welche neue Praktik führen Sie ein und wie validieren Sie deren Funktion?';

  @override
  String get smartPromptDAKIAddExample =>
      'z.B. \'Feature-Flag-System hinzufügen - an 2 Features testen, Ergebnisse in 2 Wochen prüfen\'';

  @override
  String get smartPromptDAKIAddPlaceholder =>
      '[Praktik] hinzufügen, Erfolg validieren via [Metrik]';

  @override
  String get smartPromptDAKIKeepQuestion =>
      'Wie schützen Sie diese Praktik davor, depriorisiert zu werden?';

  @override
  String get smartPromptDAKIKeepExample =>
      'z.B. \'Code-Review-Standards beibehalten - in Team-Charta aufnehmen, monatliches Audit\'';

  @override
  String get smartPromptDAKIKeepPlaceholder =>
      '[Praktik] schützen durch [Mechanismus]';

  @override
  String get smartPromptDAKIImproveQuestion =>
      'Welche spezifische Verbesserung nehmen Sie vor und wie messen Sie diese?';

  @override
  String get smartPromptDAKIImproveExample =>
      'z.B. \'Testabdeckung von 60% auf 80% erhöhen - Fokus zuerst auf Zahlungsmodul\'';

  @override
  String get smartPromptDAKIImprovePlaceholder =>
      '[Praktik] verbessern von [aktuell] auf [Ziel] bis [Datum]';

  @override
  String get smartPromptStarfishKeepQuestion =>
      'Welche Praktik behalten Sie bei und wer stellt die Konsistenz sicher?';

  @override
  String get smartPromptStarfishKeepExample =>
      'z.B. \'Freitags-Demos beibehalten - Tom bucht Raum, Agenda geteilt bis Donnerstag\'';

  @override
  String get smartPromptStarfishKeepPlaceholder =>
      '[Praktik] beibehalten, Verantwortlich: [Name]';

  @override
  String get smartPromptStarfishMoreQuestion =>
      'Was steigern Sie und um wie viel?';

  @override
  String get smartPromptStarfishMoreExample =>
      'z.B. \'Pair-Programming von 2h auf 6h pro Woche pro Entwickler steigern\'';

  @override
  String get smartPromptStarfishMorePlaceholder =>
      '[Praktik] von [aktuell] auf [Ziel] steigern';

  @override
  String get smartPromptStarfishLessQuestion =>
      'Was reduzieren Sie und um wie viel?';

  @override
  String get smartPromptStarfishLessExample =>
      'z.B. \'Meetings von 10h auf 6h pro Woche reduzieren - wiederkehrende Review streichen\'';

  @override
  String get smartPromptStarfishLessPlaceholder =>
      '[Praktik] von [aktuell] auf [Ziel] reduzieren';

  @override
  String get smartPromptStarfishStopQuestion =>
      'Was stellen Sie komplett ein und was ersetzt es ggf.?';

  @override
  String get smartPromptStarfishStopExample =>
      'z.B. \'Detailliertes Zeit-Tracking auf Tasks einstellen - Schätzungen basieren auf Vertrauen\'';

  @override
  String get smartPromptStarfishStopPlaceholder =>
      '[Praktik] einstellen, Wert ersetzen durch [Alternative] oder nichts';

  @override
  String get smartPromptStarfishStartQuestion =>
      'Welche neue Praktik starten Sie und wann ist der erste Termin?';

  @override
  String get smartPromptStarfishStartExample =>
      'z.B. \'Tech Debt Tuesday starten - erste Session nächste Woche, 2h geschützte Zeit\'';

  @override
  String get smartPromptStarfishStartPlaceholder =>
      '[Praktik] starten, erster Termin: [Datum/Zeit]';

  @override
  String get smartPromptGenericQuestion =>
      'Welche spezifische Aktion adressiert diesen Punkt?';

  @override
  String get smartPromptGenericExample =>
      'z.B. \'Spezifische Aktion mit Verantwortlichem, Deadline und Erfolgskriterien definieren\'';

  @override
  String get smartPromptGenericPlaceholder =>
      '[Aktion], Verantwortlich: [Name], bis: [Datum]';

  @override
  String get methodologyFocusAction =>
      'Aktionsorientiert: Fokus auf konkrete Verhaltensänderungen';

  @override
  String get methodologyFocusEmotion =>
      'Emotionsfokussiert: Untersuchung der Teamgefühle für psychologische Sicherheit';

  @override
  String get methodologyFocusLearning =>
      'Lernorientiert: Schwerpunkt auf Erfassung und Austausch von Wissen';

  @override
  String get methodologyFocusRisk =>
      'Risiko und Ziel: Balance zwischen Enablern, Blockern, Risiken und Zielen';

  @override
  String get methodologyFocusCalibration =>
      'Kalibrierung: Nuancierte Anpassungen mittels Abstufungen (mehr/weniger)';

  @override
  String get methodologyFocusDecision =>
      'Entscheidungsorientiert: Klare Teamentscheidungen über Praktiken';

  @override
  String get exportSheetOverview => 'Übersicht';

  @override
  String get exportSheetActionItems => 'Aktionen';

  @override
  String get exportSheetBoardItems => 'Board-Elemente';

  @override
  String get exportSheetTeamHealth => 'Team-Gesundheit';

  @override
  String get exportSheetLessonsLearned => 'Lessons Learned';

  @override
  String get exportSheetRiskRegister => 'Risikoregister';

  @override
  String get exportSheetCalibrationMatrix => 'Kalibrierungsmatrix';

  @override
  String get exportSheetDecisionLog => 'Entscheidungsprotokoll';

  @override
  String get exportHeaderRetrospectiveReport => 'RETROSPEKTIVEN-BERICHT';

  @override
  String get exportHeaderTitle => 'Titel:';

  @override
  String get exportHeaderDate => 'Datum:';

  @override
  String get exportHeaderTemplate => 'Vorlage:';

  @override
  String get exportHeaderMethodology => 'Methodik-Fokus:';

  @override
  String get exportHeaderSentiments => 'Gefühle (Durchschnitt):';

  @override
  String get exportHeaderParticipants => 'TEILNEHMER';

  @override
  String get exportHeaderSummary => 'ZUSAMMENFASSUNG';

  @override
  String get exportHeaderTotalItems => 'Elemente gesamt:';

  @override
  String get exportHeaderActionItems => 'Aktionen:';

  @override
  String get exportHeaderSuggestedFollowUp => 'Vorgeschlagenes Follow-up:';

  @override
  String get exportTeamHealthTitle => 'TEAM-GESUNDHEITSANALYSE';

  @override
  String get exportTeamHealthEmotionalDistribution => 'Emotionale Verteilung';

  @override
  String get exportTeamHealthMadCount => 'Mad-Elemente:';

  @override
  String get exportTeamHealthSadCount => 'Sad-Elemente:';

  @override
  String get exportTeamHealthGladCount => 'Glad-Elemente:';

  @override
  String get exportTeamHealthMadItems => 'FRUSTRATIONEN (Mad)';

  @override
  String get exportTeamHealthSadItems => 'ENTTÄUSCHUNGEN (Sad)';

  @override
  String get exportTeamHealthGladItems => 'ERFOLGE (Glad)';

  @override
  String get exportTeamHealthRecommendation => 'Gesundheitsempfehlung:';

  @override
  String get exportTeamHealthHighFrustration =>
      'Hohe Frustration festgestellt. Problemlösungs-Session in Betracht ziehen.';

  @override
  String get exportTeamHealthBalanced =>
      'Ausgeglichener emotionaler Zustand. Team zeigt gesunde Reflexion.';

  @override
  String get exportTeamHealthPositive =>
      'Positive Team-Moral. Energie für herausfordernde Verbesserungen nutzen.';

  @override
  String get exportLessonsLearnedTitle => 'LESSONS LEARNED REGISTER';

  @override
  String get exportLessonsLearnedWhatWorked => 'WAS HAT FUNKTIONIERT (Liked)';

  @override
  String get exportLessonsLearnedNewSkills =>
      'NEUE FÄHIGKEITEN & ERKENNTNISSE (Learned)';

  @override
  String get exportLessonsLearnedGaps => 'LÜCKEN & FEHLENDES (Lacked)';

  @override
  String get exportLessonsLearnedWishes => 'ZUKUNFTSWÜNSCHE (Longed For)';

  @override
  String get exportLessonsLearnedKnowledgeActions =>
      'Wissensaustausch-Aktionen';

  @override
  String get exportLessonsLearnedDocumentationNeeded =>
      'Benötigte Dokumentation:';

  @override
  String get exportLessonsLearnedTrainingNeeded =>
      'Benötigtes Training/Sharing:';

  @override
  String get exportRiskRegisterTitle => 'RISIKO- UND ENABLER-REGISTER';

  @override
  String get exportRiskRegisterEnablers => 'ENABLER (Wind)';

  @override
  String get exportRiskRegisterBlockers => 'BLOCKER (Anker)';

  @override
  String get exportRiskRegisterRisks => 'RISIKEN (Felsen)';

  @override
  String get exportRiskRegisterGoals => 'ZIELE (Insel)';

  @override
  String get exportRiskRegisterRiskItem => 'Risiko';

  @override
  String get exportRiskRegisterImpact => 'Potenzielle Auswirkung';

  @override
  String get exportRiskRegisterMitigation => 'Minderungsaktion';

  @override
  String get exportRiskRegisterStatus => 'Status';

  @override
  String get exportRiskRegisterGoalAlignment => 'Zielabgleich-Prüfung:';

  @override
  String get exportRiskRegisterGoalAlignmentNote =>
      'Prüfen, ob aktuelle Aktionen mit den Zielen übereinstimmen.';

  @override
  String get exportCalibrationTitle => 'KALIBRIERUNGSMATRIX';

  @override
  String get exportCalibrationKeepDoing => 'WEITERMACHEN';

  @override
  String get exportCalibrationDoMore => 'MEHR DAVON';

  @override
  String get exportCalibrationDoLess => 'WENIGER DAVON';

  @override
  String get exportCalibrationStopDoing => 'AUFHÖREN DAMIT';

  @override
  String get exportCalibrationStartDoing => 'STARTEN DAMIT';

  @override
  String get exportCalibrationPractice => 'Praktik';

  @override
  String get exportCalibrationCurrentState => 'Aktueller Status';

  @override
  String get exportCalibrationTargetState => 'Zielstatus';

  @override
  String get exportCalibrationAdjustment => 'Anpassung';

  @override
  String get exportCalibrationNote =>
      'Die Kalibrierung fokussiert auf Feinabstimmung bestehender Praktiken.';

  @override
  String get exportDecisionLogTitle => 'ENTSCHEIDUNGSPROTOKOLL';

  @override
  String get exportDecisionLogDrop => 'ZU STOPPENDE ENTSCHEIDUNGEN';

  @override
  String get exportDecisionLogAdd => 'NEUE ENTSCHEIDUNGEN';

  @override
  String get exportDecisionLogKeep => 'BEIZUBEHALTENDE ENTSCHEIDUNGEN';

  @override
  String get exportDecisionLogImprove => 'ZU VERBESSERNDE ENTSCHEIDUNGEN';

  @override
  String get exportDecisionLogDecision => 'Entscheidung';

  @override
  String get exportDecisionLogRationale => 'Begründung';

  @override
  String get exportDecisionLogOwner => 'Verantwortlich';

  @override
  String get exportDecisionLogDeadline => 'Deadline';

  @override
  String get exportDecisionLogPrioritizationNote => 'Priorisierungsempfehlung:';

  @override
  String get exportDecisionLogPrioritizationHint =>
      'Zuerst DROP-Entscheidungen treffen, um Kapazitäten freizumachen, dann neue hinzufügen.';

  @override
  String get exportNoItems => 'Keine Einträge registriert';

  @override
  String get exportNoActionItems => 'Keine Aktionen';

  @override
  String get exportNotApplicable => 'N/A';

  @override
  String get facilitatorGuideTitle => 'Leitfaden für Aktionssammlung';

  @override
  String get facilitatorGuideCoverage => 'Abdeckung';

  @override
  String get facilitatorGuideComplete => 'Vollständig';

  @override
  String get facilitatorGuideIncomplete => 'Unvollständig';

  @override
  String get facilitatorGuideSuggestedOrder => 'Empfohlene Reihenfolge:';

  @override
  String get facilitatorGuideMissingRequired => 'Erforderliche Aktionen fehlen';

  @override
  String get facilitatorGuideColumnHasAction => 'Hat Aktion';

  @override
  String get facilitatorGuideColumnNoAction => 'Keine Aktion';

  @override
  String get facilitatorGuideRequired => 'Erforderlich';

  @override
  String get facilitatorGuideOptional => 'Optional';

  @override
  String get agileEdit => 'Bearbeiten';

  @override
  String get agileSettings => 'Einstellungen';

  @override
  String get agileDelete => 'Löschen';

  @override
  String get agileDeleteProjectTitle => 'Projekt löschen';

  @override
  String agileDeleteProjectConfirm(String projectName) {
    return 'Sind Sie sicher, dass Sie \"$projectName\" löschen möchten?';
  }

  @override
  String get agileDeleteProjectWarning => 'Diese Aktion löscht dauerhaft:';

  @override
  String agileDeleteWarningUserStories(int count) {
    return '$count User Stories';
  }

  @override
  String agileDeleteWarningSprints(int count) {
    return '$count Sprints';
  }

  @override
  String get agileDeleteProjectData => 'Alle Projektdaten';

  @override
  String get agileProjectSettingsTitle => 'Projekteinstellungen';

  @override
  String get agileKeyRoles => 'Schlüsselrollen';

  @override
  String get agileKeyRolesSubtitle => 'Weisen Sie die Scrum-Hauptrollen zu';

  @override
  String get agileRoleProductOwner => 'Product Owner';

  @override
  String get agileRoleProductOwnerDesc =>
      'Verwaltet das Backlog und definiert Produktprioritäten';

  @override
  String get agileRoleScrumMaster => 'Scrum Master';

  @override
  String get agileRoleScrumMasterDesc =>
      'Erleichtert den Scrum-Prozess und räumt Hindernisse aus';

  @override
  String get agileRoleDevTeam => 'Development Team';

  @override
  String get agileNoDevTeamMembers =>
      'Keine Mitglieder im Team. + klicken zum Hinzufügen.';

  @override
  String get agileRolesInfo =>
      'Rollen werden mit speziellen Icons angezeigt. Weitere Teilnehmer können unter \'Team\' hinzugefügt werden.';

  @override
  String agileAssignedTo(String name) {
    return '$name zugewiesen';
  }

  @override
  String get agileUnassigned => 'Nicht zugewiesen';

  @override
  String get agileAssignableLater => 'Nach der Erstellung zuweisbar';

  @override
  String get agileAddToTeam => 'Aggiungi al Team';

  @override
  String get agileAllMembersAssigned =>
      'Alle Mitglieder sind bereits zugewiesen';

  @override
  String get agileClose => 'Chiudi';

  @override
  String get agileProjectNameLabel => 'Projektname *';

  @override
  String get agileProjectNameHint => 'z.B. Mode PMO v2';

  @override
  String get agileEnterProjectName => 'Geben Sie den Projektnamen ein';

  @override
  String get agileProjectDescLabel => 'Beschreibung';

  @override
  String get agileProjectDescHint => 'Optionale Projektbeschreibung';

  @override
  String get agileFrameworkLabel => 'Agiles Framework';

  @override
  String get agileDiscoverDifferences => 'Unterschiede entdecken';

  @override
  String get agileSprintConfig => 'Sprint-Konfiguration';

  @override
  String get agileSprintDuration => 'Sprint-Dauer (Tage)';

  @override
  String get agileHoursPerDay => 'Stunden/Tag';

  @override
  String get agileCreateProjectTitle => 'Neues agiles Projekt';

  @override
  String get agileEditProjectTitle => 'Projekt bearbeiten';

  @override
  String get agileSelectParticipant => 'Teilnehmer auswählen';

  @override
  String get agileAssignRolesHint =>
      'Weisen Sie Hauptrollen zu. Später anpassbar.';

  @override
  String get agileArchiveAction => 'Archivieren';

  @override
  String get agileRestoreAction => 'Wiederherstellen';

  @override
  String get agileSetupTitle => 'Projekt-Setup';

  @override
  String agileStepComplete(int completed, int total) {
    return '$completed von $total Schritten abgeschlossen';
  }

  @override
  String get agileSetupCompleteTitle => 'Setup abgeschlossen!';

  @override
  String get agileSetupCompleteMessage => 'Ihr Projekt ist startbereit.';

  @override
  String get agileChecklistAddMembers => 'Teammitglieder hinzufügen';

  @override
  String get agileChecklistAddMembersDesc =>
      'Laden Sie Mitglieder zur Zusammenarbeit ein';

  @override
  String get agileChecklistInvite => 'Einladen';

  @override
  String agileChecklistCreateStories(String itemType) {
    return 'Erste $itemType erstellen';
  }

  @override
  String get agileChecklistAddItems =>
      'Mindestens 3 Einträge im Backlog erstellen';

  @override
  String get agileChecklistAdd => 'Hinzufügen';

  @override
  String get agileChecklistWipLimits => 'WIP-Limits konfigurieren';

  @override
  String get agileChecklistWipLimitsDesc =>
      'Limits für jede Kanban-Spalte setzen';

  @override
  String get agileChecklistConfigure => 'Konfigurieren';

  @override
  String agileChecklistEstimate(String itemType) {
    return '$itemType schätzen';
  }

  @override
  String get agileChecklistEstimateDesc =>
      'Story Points zur besseren Planung zuweisen';

  @override
  String get agileChecklistCreateSprint => 'Ersten Sprint erstellen';

  @override
  String get agileChecklistSprintDesc => 'Stories auswählen und Arbeit starten';

  @override
  String get agileChecklistCreateSprintAction => 'Sprint erstellen';

  @override
  String get agileChecklistStartWork => 'Arbeit starten';

  @override
  String get agileChecklistStartWorkDesc =>
      'Einen Eintrag in \'In Arbeit\' verschieben';

  @override
  String get agileTipStartSprintTitle => 'Bereit für einen Sprint?';

  @override
  String get agileTipStartSprintMessage =>
      'Sie haben genug Stories im Backlog. Planen Sie den ersten Sprint.';

  @override
  String get agileTipWipTitle => 'WIP-Limits konfigurieren';

  @override
  String get agileTipWipMessage =>
      'WIP-Limits sind essenziell für Kanban. Begrenzen Sie parallele Arbeit.';

  @override
  String get agileTipHybridTitle => 'Konfigurieren Sie Ihr Scrumban';

  @override
  String get agileTipHybridMessage =>
      'Nutzen Sie Sprints oder WIP-Limits für kontinuierlichen Fluss. Experimentieren Sie!';

  @override
  String get agileTipDiscover => 'Entdecken';

  @override
  String get agileTipClose => 'Schließen';

  @override
  String get agileNextStepInviteTitle => 'Team einladen';

  @override
  String get agileNextStepInviteDesc =>
      'Mitglieder zur Zusammenarbeit hinzufügen.';

  @override
  String get agileNextStepBacklogTitle => 'Backlog erstellen';

  @override
  String agileNextStepBacklogDesc(String itemType) {
    return 'Erste $itemType zum Backlog hinzufügen.';
  }

  @override
  String get agileNextStepSprintTitle => 'Sprint planen';

  @override
  String agileNextStepSprintDesc(int count) {
    return 'Sie haben $count fertige Einträge. Erster Sprint!';
  }

  @override
  String get agileNextStepWipTitle => 'WIP-Limits konfigurieren';

  @override
  String get agileNextStepWipDesc =>
      'Begrenzen Sie parallele Arbeit für besseren Fluss.';

  @override
  String get agileNextStepWorkTitle => 'Arbeit starten';

  @override
  String get agileNextStepWorkDesc =>
      'Verschieben Sie einen Eintrag auf \'In Arbeit\'.';

  @override
  String get agileNextStepAddToSprintDesc =>
      'Verschieben Sie ein Element auf \'To Do\', um Stories zum Sprint hinzuzufügen.';

  @override
  String get agileNextStepGoToKanban => 'Zum Kanban';

  @override
  String get agileActionNewStory => 'Neue Story';

  @override
  String get agileBacklogTitle => 'Product Backlog';

  @override
  String get agileBacklogArchiveTitle => 'Archiv Abgeschlossen';

  @override
  String get agileBacklogToggleActive => 'Aktives Backlog anzeigen';

  @override
  String agileBacklogToggleArchive(int count) {
    return 'Archiv anzeigen ($count abgeschlossen)';
  }

  @override
  String agileBacklogArchiveBadge(int count) {
    return 'Archiv ($count)';
  }

  @override
  String get agileBacklogSearchHint =>
      'Nach Titel, Beschreibung oder ID suchen...';

  @override
  String agileBacklogStatsStories(int count) {
    return '$count Stories';
  }

  @override
  String agileBacklogStatsPoints(int points) {
    return '$points Pt';
  }

  @override
  String agileBacklogStatsEstimated(int count) {
    return '$count geschätzt';
  }

  @override
  String get agileFiltersStatus => 'Status:';

  @override
  String get agileFiltersPriority => 'Priorität:';

  @override
  String get agileFiltersTags => 'Tags:';

  @override
  String get agileFiltersAll => 'Alle';

  @override
  String get agileFiltersClear => 'Filter entfernen';

  @override
  String get agileEmptyBacklogMatch => 'Keine Story gefunden';

  @override
  String get agileEmptyBacklog => 'Backlog leer';

  @override
  String get agileEmptyBacklogHint => 'Erste User Story hinzufügen';

  @override
  String get agileEstTitle => 'Story schätzen';

  @override
  String get agileEstMethod => 'Schätzmethode';

  @override
  String get agileEstSelectValue => 'Wert wählen';

  @override
  String get agileEstSubmit => 'Schätzung bestätigen';

  @override
  String get agileEstCancel => 'Abbrechen';

  @override
  String get agileEstPokerTitle => 'Planning Poker (Fibonacci)';

  @override
  String get agileEstPokerDesc => 'Komplexität in Story Points wählen';

  @override
  String get agileEstTShirtTitle => 'T-Shirt Sizing';

  @override
  String get agileEstTShirtDesc => 'Relative Größe der Story wählen';

  @override
  String get agileEstThreePointTitle => 'Drei-Punkt-Schätzung (PERT)';

  @override
  String get agileEstThreePointDesc =>
      'Drei Werte für PERT-Berechnung eingeben';

  @override
  String get agileEstBucketTitle => 'Bucket System';

  @override
  String get agileEstBucketDesc => 'Story im passenden Bucket platzieren';

  @override
  String get agileEstBucketHint =>
      'Größere Buckets bedeuten komplexere Stories';

  @override
  String get agileEstReference => 'Referenz:';

  @override
  String get agileEstRefXS => 'XS = Wenige Stunden';

  @override
  String get agileEstRefS => 'S = ~1 Tag';

  @override
  String get agileEstRefM => 'M = ~2-3 Tage';

  @override
  String get agileEstRefL => 'L = ~1 Woche';

  @override
  String get agileEstRefXL => 'XL = ~2 Wochen';

  @override
  String get agileEstRefXXL => 'XXL = Zu groß, aufteilen';

  @override
  String get agileEstOptimistic => 'Optimistisch (O)';

  @override
  String get agileEstOptimisticHint => 'Bester Fall';

  @override
  String get agileEstMostLikely => 'Wahrscheinlich (M)';

  @override
  String get agileEstMostLikelyHint => 'Normalfall';

  @override
  String get agileEstPessimistic => 'Pessimistisch (P)';

  @override
  String get agileEstPessimisticHint => 'Schlechtester Fall';

  @override
  String get agileEstPointsSuffix => 'Pt';

  @override
  String get agileEstFormula => 'PERT-Formel: (O + 4M + P) / 6';

  @override
  String agileEstResult(String value) {
    return 'Schätzung: $value Punkte';
  }

  @override
  String get agileEstErrorThreePoint => 'Alle drei Werte eingeben';

  @override
  String get agileEstErrorSelect => 'Wert wählen';

  @override
  String agileEstExisting(int count) {
    return 'Vorhandene Schätzungen ($count)';
  }

  @override
  String get agileEstYou => 'Du';

  @override
  String get scrumPermBacklogTitle => 'Backlog-Berechtigungen';

  @override
  String get scrumPermBacklogDesc =>
      'Nur der Product Owner kann Stories erstellen, bearbeiten, löschen und prioritieren';

  @override
  String get scrumPermSprintTitle => 'Sprint-Berechtigungen';

  @override
  String get scrumPermSprintDesc =>
      'Nur der Scrum Master kann Sprints erstellen, starten und abschließen';

  @override
  String get scrumPermEstimateTitle => 'Schätz-Berechtigungen';

  @override
  String get scrumPermEstimateDesc =>
      'Nur das Development Team kann Stories schätzen';

  @override
  String get scrumPermKanbanTitle => 'Kanban-Berechtigungen';

  @override
  String get scrumPermKanbanDesc =>
      'Das Dev-Team kann eigene Stories verschieben, PO und SM alle';

  @override
  String get scrumPermTeamTitle => 'Team-Berechtigungen';

  @override
  String get scrumPermTeamDesc =>
      'PO und SM können Mitglieder einladen, nur der PO Rollen ändern';

  @override
  String get scrumPermDeniedBacklogCreate =>
      'Nur der Product Owner kann neue Stories erstellen';

  @override
  String get scrumPermDeniedBacklogEdit =>
      'Nur der Product Owner kann Stories bearbeiten';

  @override
  String get scrumPermDeniedBacklogDelete =>
      'Nur der Product Owner kann Stories löschen';

  @override
  String get scrumPermDeniedBacklogPrioritize =>
      'Nur der Product Owner kann das Backlog prioritieren';

  @override
  String get scrumPermDeniedSprintCreate =>
      'Nur der Scrum Master kann Sprints erstellen';

  @override
  String get scrumPermDeniedSprintStart =>
      'Nur der Scrum Master kann Sprints starten';

  @override
  String get scrumPermDeniedSprintComplete =>
      'Nur der Scrum Master kann Sprints abschließen';

  @override
  String get scrumPermDeniedEstimate =>
      'Nur das Development Team kann Stories schätzen';

  @override
  String get scrumPermDeniedInvite =>
      'Nur PO und SM können neue Mitglieder einladen';

  @override
  String get scrumPermDeniedRoleChange =>
      'Nur der Product Owner kann Teamrollen ändern';

  @override
  String get scrumPermDeniedWipConfig =>
      'Nur der Scrum Master kann WIP-Limits konfigurieren';

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
  String get scrumMatrixTitle => 'Scrum-Berechtigungsmatrix';

  @override
  String get scrumMatrixSubtitle => 'Basiert auf der Scrum Guide 2020';

  @override
  String get scrumMatrixLegend => 'Legende';

  @override
  String get scrumMatrixLegendFull => 'Verwaltet';

  @override
  String get scrumMatrixLegendPartial => 'Teilweise';

  @override
  String get scrumMatrixLegendView => 'Ansehen';

  @override
  String get scrumMatrixLegendNone => 'Keine';

  @override
  String get scrumMatrixCategoryBacklog => 'BACKLOG';

  @override
  String get scrumMatrixCategorySprint => 'SPRINT';

  @override
  String get scrumMatrixCategoryEstimation => 'SCHÄTZUNG';

  @override
  String get scrumMatrixCategoryKanban => 'KANBAN';

  @override
  String get scrumMatrixCategoryTeam => 'TEAM';

  @override
  String get scrumMatrixCategoryRetro => 'RETROSPEKTIVE';

  @override
  String get scrumMatrixActionCreateStory => 'Story erstellen';

  @override
  String get scrumMatrixActionEditStory => 'Story bearbeiten';

  @override
  String get scrumMatrixActionDeleteStory => 'Story löschen';

  @override
  String get scrumMatrixActionPrioritize => 'Backlog prioritieren';

  @override
  String get scrumMatrixActionAddAcceptance => 'Akzeptanzkriterien definieren';

  @override
  String get scrumMatrixActionCreateSprint => 'Sprint erstellen';

  @override
  String get scrumMatrixActionStartSprint => 'Sprint starten';

  @override
  String get scrumMatrixActionCompleteSprint => 'Sprint abschließen';

  @override
  String get scrumMatrixActionConfigWip => 'WIP-Limits konfigurieren';

  @override
  String get scrumMatrixActionEstimate => 'Story Points schätzen';

  @override
  String get scrumMatrixActionFinalEstimate => 'Finaler Schätzwert';

  @override
  String get scrumMatrixActionMoveOwn => 'Eigene Stories verschieben';

  @override
  String get scrumMatrixActionMoveAny => 'Alle Stories verschieben';

  @override
  String get scrumMatrixActionSelfAssign => 'Selbst zuweisen';

  @override
  String get scrumMatrixActionAssignOthers => 'Andere zuweisen';

  @override
  String get scrumMatrixActionChangeStatus => 'Status ändern';

  @override
  String get scrumMatrixActionInvite => 'Mitglieder einladen';

  @override
  String get scrumMatrixActionRemove => 'Mitglieder entfernen';

  @override
  String get scrumMatrixActionChangeRole => 'Rollen ändern';

  @override
  String get scrumMatrixActionFacilitateRetro => 'Retro moderieren';

  @override
  String get scrumMatrixActionParticipateRetro => 'An Retro teilnehmen';

  @override
  String get scrumMatrixActionAddRetroItem => 'Retro-Eintrag hinzufügen';

  @override
  String get scrumMatrixActionVoteRetro => 'Abstimmen';

  @override
  String get scrumMatrixColPO => 'PO';

  @override
  String get scrumMatrixColSM => 'SM';

  @override
  String get scrumMatrixColDev => 'Dev';

  @override
  String get scrumMatrixColStake => 'Stake';

  @override
  String get agileInviteTitle => 'Zum Team einladen';

  @override
  String get agileInviteNew => 'NEUE EINLADUNG';

  @override
  String get agileInviteEmailLabel => 'E-Mail';

  @override
  String get agileInviteEmailHint => 'name@beispiel.com';

  @override
  String get agileInviteEnterEmail => 'E-Mail eingeben';

  @override
  String get agileInviteInvalidEmail => 'Ungültige E-Mail';

  @override
  String get agileInviteProjectRole => 'Projektrolle';

  @override
  String get agileInviteTeamRole => 'Teamrolle';

  @override
  String get agileInviteSendEmail => 'E-Mail-Benachrichtigung senden';

  @override
  String get agileInviteSendBtn => 'Einladung senden';

  @override
  String get agileInviteLink => 'Einladungslink:';

  @override
  String get agileInviteLinkCopied => 'Link copiato!';

  @override
  String get agileInviteListTitle => 'EINLADUNGEN';

  @override
  String get agileInviteClose => 'Schließen';

  @override
  String get agileInviteGmailAuthTitle => 'Gmail-Autorisierung';

  @override
  String get agileInviteGmailAuthContent =>
      'Zum Senden von Einladungen ist eine erneute Google-Authentifizierung erforderlich.\n\nFortfahren?';

  @override
  String get agileInviteGmailAuthNo => 'Nein, nur Link';

  @override
  String get agileInviteGmailAuthYes => 'Autorisieren';

  @override
  String agileInviteSentEmail(String email) {
    return 'Einladung per E-Mail an $email gesendet';
  }

  @override
  String agileInviteCreated(String email) {
    return 'Einladung erstellt für $email';
  }

  @override
  String get agileInviteRevokeTitle => 'Einladung widerrufen?';

  @override
  String get agileInviteRevokeContent => 'Die Einladung wird ungültig.';

  @override
  String get agileInviteRevokeBtn => 'Widerrufen';

  @override
  String get agileInviteResend => 'Erneut senden';

  @override
  String get agileInviteResent => 'Einladung erneut gesendet';

  @override
  String get agileInviteStatusPending => 'Ausstehend';

  @override
  String get agileInviteStatusAccepted => 'Angenommen';

  @override
  String get agileInviteStatusDeclined => 'Abgelehnt';

  @override
  String get agileInviteStatusExpired => 'Abgelaufen';

  @override
  String get agileInviteStatusRevoked => 'Widerrufen';

  @override
  String get agileRoleMember => 'Mitglied';

  @override
  String get agileRoleAdmin => 'Admin';

  @override
  String get agileRoleViewer => 'Beobachter';

  @override
  String get agileRoleOwner => 'Besitzer';

  @override
  String get agileEditStory => 'Story bearbeiten';

  @override
  String get agileNewStory => 'Neue User Story';

  @override
  String get agileDetailsTab => 'Details';

  @override
  String get agileAcceptanceCriteriaTab => 'Akzeptanzkriterien';

  @override
  String get agileOtherTab => 'Sonstiges';

  @override
  String get agileTitleLabel => 'Titel';

  @override
  String get agileTitleHint => 'Kurzbeschreibung der Funktionalität';

  @override
  String get agileUseStoryTemplate => 'User Story Template nutzen';

  @override
  String get agileStoryTemplateSubtitle => 'Als ein... möchte ich... um zu...';

  @override
  String get agileAsA => 'Als ein...';

  @override
  String get agileAsAHint => 'Benutzer, Admin, Kunde...';

  @override
  String get agileIWant => 'möchte ich...';

  @override
  String get agileIWantHint => 'etwas tun können...';

  @override
  String get agileSoThat => 'um zu...';

  @override
  String get agileSoThatHint => 'einen Nutzen zu erzielen...';

  @override
  String get agileDescriptionLabel => 'Beschreibung';

  @override
  String get agileDescriptionHint => 'Freie Beschreibung der Story';

  @override
  String get agilePreview => 'Vorschau:';

  @override
  String get agileEmptyDescription => '(leere Beschreibung)';

  @override
  String get agileDefineComplete =>
      'Definieren Sie, wann die Story als abgeschlossen gilt';

  @override
  String get agileAddCriterionHint => 'Akzeptanzkriterium hinzufügen...';

  @override
  String get agileNoCriteria => 'Keine Kriterien definiert';

  @override
  String get agileSuggestions => 'Vorschläge:';

  @override
  String get agilePriorityMoscow => 'Priorität (MoSCoW)';

  @override
  String get agileBusinessValueLow => 'Niedriger Business Value';

  @override
  String get agileBusinessValueMedium => 'Mittlerer Wert';

  @override
  String get agileBusinessValueHigh => 'Hoher Business Value';

  @override
  String get agileEstimatedStoryPoints => 'Geschätzt in Story Points';

  @override
  String get agileStoryPointsTooltip =>
      'Story Points repräsentieren die relative Komplexität der Arbeit.\nNutzen Sie die Fibonacci-Folge: 1 (einfach) -> 21 (sehr komplex).';

  @override
  String get agileNoPoints => 'Keine';

  @override
  String get agileAddTagHint => 'Tag hinzufügen...';

  @override
  String get agileExistingTags => 'Existierende Tags:';

  @override
  String get agileAssignTo => 'Zuweisen an';

  @override
  String get agileSelectMemberHint => 'Teammitglied auswählen';

  @override
  String get agilePointsComplexityVeryLow => 'Schnelle, einfache Aufgabe';

  @override
  String get agilePointsComplexityLow => 'Aufgabe mittlerer Komplexität';

  @override
  String get agilePointsComplexityMedium =>
      'Komplexe Aufgabe, erfordert Analyse';

  @override
  String get agilePointsComplexityHigh =>
      'Sehr komplex, Story eventuell aufteilen';

  @override
  String agileDurationDays(Object days) {
    return 'Dauer: $days Tage';
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
  String get agileSelectedPoints => 'Ausgewählte Punkte';

  @override
  String get agileSuggestedPoints => 'Vorgeschlagene Punkte';

  @override
  String agileDaysRemaining(Object days) {
    return '${days}T verbleibend';
  }

  @override
  String get agileSelectAtLeastOne => 'Wählen Sie mindestens eine Story aus';

  @override
  String agileConfirmStories(String count) {
    return 'Bestätige $count Stories';
  }

  @override
  String get kanbanPoliciesDescription =>
      'Explizite Policies definieren die Regeln für diese Spalte (Kanban Praktik #4)';

  @override
  String get kanbanPoliciesEmpty => 'Keine Policies definiert';

  @override
  String get kanbanPoliciesAdd => 'Policy hinzufügen';

  @override
  String get kanbanPoliciesHint => 'z.B. Max. 24h in dieser Spalte';

  @override
  String kanbanPoliciesIndicator(int count) {
    return 'Aktive Policies: $count';
  }

  @override
  String get sprintReviewTitle => 'Sprint Review';

  @override
  String get sprintReviewSubtitle =>
      'Überprüfung der abgeschlossenen Arbeit mit Stakeholdern';

  @override
  String get sprintReviewConductBy => 'Geleitet von';

  @override
  String get sprintReviewDate => 'Review-Datum';

  @override
  String get sprintReviewAttendees => 'Teilnehmer';

  @override
  String get sprintReviewSelectAttendees => 'Teilnehmer auswählen';

  @override
  String get sprintReviewDemoNotes => 'Demo-Notizen';

  @override
  String get sprintReviewDemoNotesHint =>
      'Beschreiben Sie die gezeigten Funktionalitäten';

  @override
  String get sprintReviewFeedback => 'Erhaltenes Feedback';

  @override
  String get sprintReviewFeedbackHint => 'Feedback der Stakeholder';

  @override
  String get sprintReviewBacklogUpdates => 'Backlog-Updates';

  @override
  String get sprintReviewBacklogUpdatesHint =>
      'Besprochene Änderungen am Backlog';

  @override
  String get sprintReviewNextFocus => 'Fokus nächster Sprint';

  @override
  String get sprintReviewNextFocusHint => 'Prioritäten für den nächsten Sprint';

  @override
  String get sprintReviewMarketNotes => 'Markt-/Budgetnotizen';

  @override
  String get sprintReviewMarketNotesHint =>
      'Marktbedingungen, Timeline, Budget';

  @override
  String get sprintReviewStoriesCompleted => 'Abgeschlossene Stories';

  @override
  String get sprintReviewStoriesNotCompleted => 'Nicht abgeschlossene Stories';

  @override
  String get sprintReviewPointsCompleted => 'Abgeschlossene Punkte';

  @override
  String get sprintReviewSave => 'Review speichern';

  @override
  String get sprintReviewWarning => 'Achtung: Sprint Review';

  @override
  String get sprintReviewWarningMessage =>
      'Die Sprint Review wurde noch nicht durchgeführt. Laut Scrum Guide 2020 ist die Sprint Review ein Pflichttermin vor Abschluss des Sprints.';

  @override
  String get sprintReviewCompleteAnyway => 'Trotzdem abschließen';

  @override
  String get sprintReviewDoReview => 'Review durchführen';

  @override
  String get sprintReviewCompleted => 'Sprint Review abgeschlossen';

  @override
  String get swimlaneTitle => 'Swimlanes';

  @override
  String get swimlaneDescription => 'Cards nach Attribut gruppieren';

  @override
  String get swimlaneTypeNone => 'Keine';

  @override
  String get swimlaneTypeNoneDesc => 'Standardansicht ohne Gruppierung';

  @override
  String get swimlaneTypeClassOfService => 'Serviceklasse';

  @override
  String get swimlaneTypeClassOfServiceDesc =>
      'Nach Priorität/Dringlichkeit gruppieren';

  @override
  String get swimlaneTypeAssignee => 'Verantwortlicher';

  @override
  String get swimlaneTypeAssigneeDesc => 'Nach Teammitglied gruppieren';

  @override
  String get swimlaneTypePriority => 'Priorität';

  @override
  String get swimlaneTypePriorityDesc => 'Nach Prioritätsstufe gruppieren';

  @override
  String get swimlaneTypeTag => 'Tag';

  @override
  String get swimlaneTypeTagDesc => 'Nach Story-Tag gruppieren';

  @override
  String get swimlaneUnassigned => 'Nicht zugewiesen';

  @override
  String get swimlaneNoTag => 'Kein Tag';

  @override
  String get agileMetricsVelocityTitle => 'Velocity';

  @override
  String get agileMetricsVelocityDesc =>
      'Misst die Menge der abgeschlossenen Story Points pro Sprint. Hilft bei der Kapazitätsplanung.';

  @override
  String get agileMetricsLeadTimeDesc =>
      'Gesamtzeit von Erstellung bis Abschluss. Inklusive Wartezeit im Backlog.';

  @override
  String get agileMetricsCycleTimeDesc =>
      'Formel: Zeit in aktiven Zuständen (In Progress / Review). Exklusive Wartezeit im Backlog.';

  @override
  String get agileMetricsThroughputDesc =>
      'Anzahl abgeschlossener Items pro Zeiteinheit. Zeigt die Produktivität.';

  @override
  String get agileMetricsDistributionDesc =>
      'Visualisiert die Verteilung nach Status. Hilft Engpässe zu identifizieren.';

  @override
  String get agilePredictability => 'Vorhersehbarkeit';

  @override
  String agilePredictabilityDesc(int days) {
    return '85% der Items werden in ≤$days Tagen abgeschlossen';
  }

  @override
  String agileThroughputWeekly(int weeks) {
    return 'Abgeschlossene Items/Woche (letzte $weeks Wo.)';
  }

  @override
  String get agileNoDataVelocity => 'Keine Velocity-Daten';

  @override
  String get agileNoDataLeadTime => 'Keine Lead-Time-Daten';

  @override
  String get agileNoDataCycleTime => 'Keine Cycle-Time-Daten';

  @override
  String get agileNoDataThroughput => 'Keine Durchsatz-Daten';

  @override
  String get agileNoDataAccuracy => 'Keine Genauigkeits-Daten';

  @override
  String get agileStartFinishOneItem =>
      'Schließen Sie mindestens ein Item ab zur Berechnung';

  @override
  String get timeDays => 'Tage';

  @override
  String get auditLogTitle => 'Audit-Log';

  @override
  String auditLogEventCount(int count) {
    return '$count Ereignisse';
  }

  @override
  String get actionRefresh => 'Aktualisieren';

  @override
  String get auditLogFilterEntityType => 'Typ';

  @override
  String get auditLogFilterAction => 'Aktion';

  @override
  String get auditLogFilterFromDate => 'Von';

  @override
  String get actionDetails => 'Details';

  @override
  String get auditLogDetailsTitle => 'Änderungsdetails';

  @override
  String get auditLogPreviousValue => 'Vorheriger Wert:';

  @override
  String get auditLogNewValue => 'Neuer Wert:';

  @override
  String get auditLogNoEvents => 'Keine Ereignisse registriert';

  @override
  String get auditLogNoEventsDesc => 'Projektaktivitäten werden hier geloggt';

  @override
  String get recentActivityTitle => 'Kürzliche Aktivitäten';

  @override
  String get actionViewAll => 'Alle sehen';

  @override
  String get recentActivityNone => 'Keine kürzlichen Aktivitäten';

  @override
  String get burndownChartTitle => 'Burndown-Unterstützung';

  @override
  String get agileIdeal => 'Ideal';

  @override
  String get agileActual => 'Real';

  @override
  String get agileRemaining => 'Verbleibend';

  @override
  String get agileBurndownNoDataDesc =>
      'Daten erscheinen, wenn der Sprint aktiv ist';

  @override
  String get agileCompleteActiveFirst =>
      'Aktivieren Sprint vor dem Start eines anderen';

  @override
  String get kanbanSwimlanes => 'Swimlanes:';

  @override
  String get kanbanSwimlaneLabel => 'Swimlane';

  @override
  String get agileNoTags => 'Keine Tags';

  @override
  String get kanbanWipExceededBanner =>
      'WIP-Limit überschritten! Schließen Sie Items ab, bevor Sie neue starten.';

  @override
  String get kanbanConfigWip => 'WIP konfigurieren';

  @override
  String get kanbanPoliciesDesc =>
      'Explizite Policies helfen dem Team, die Regeln dieser Spalte zu verstehen.';

  @override
  String get kanbanNewPolicyHint => 'Neue Policy...';

  @override
  String kanbanWipLimitOf(int count, int limit) {
    return 'WIP: $count von $limit max';
  }

  @override
  String get kanbanWipExplanationDesc =>
      'WIP-Limits (Work In Progress) begrenzen die Anzahl der Items, die gleichzeitig in einer Spalte sein dürfen.';

  @override
  String get kanbanUnderstand => 'Verstanden';

  @override
  String get agileHours => 'Stunden';

  @override
  String get agileStoriesPerSprint => 'Stories / Sprint';

  @override
  String get agileSprints => 'Sprints';

  @override
  String get agileTeamComposition => 'Team-Zusammensetzung';

  @override
  String get agileHoursNote =>
      'Stunden sind eine interne Referenz. Für die Scrum-Planung nutzen Sie Story Points.';

  @override
  String agileWorkloadBalanceTooltip(String avg, String min, String max) {
    return 'Team-Durchschnitt: $avg SP\nBalance-Bereich: $min - $max SP\nStatus basiert auf Abweichung vom Durchschnitt.';
  }

  @override
  String get agileHealthTimeTooltip =>
      'Vergangene Tage / Gesamttage (basiert auf Start/Ende).';

  @override
  String get agileHealthWorkTooltip =>
      'Abgeschlossene Story Points vs. fest geplante.';

  @override
  String get agileHealthProgressTooltip =>
      'Anzahl der Stories aktuell in Bearbeitung.';

  @override
  String get agileHealthDoneTooltip =>
      'Abgeschlossene Stories vs. Gesamtanzahl im Sprint.';

  @override
  String get agileHealthCommitmentTooltip =>
      'Zuverlässigkeit (Abgeschlossen / Geplant) basierend auf vergangenen Sprints.';

  @override
  String get agileHealthVelocityTooltip =>
      'Täglicher Durchschnitt abgeschlossener Story Points in diesem Sprint.';

  @override
  String get agileSprintScopeTooltip =>
      'Überwacht Änderungen am Sprint-Umfang. \'Original\' sind Punkte beim Start, \'Current\' aktuelle Punkte.';

  @override
  String get agileEstimationAccuracyTooltip =>
      'Formel: (Abgeschlossen / Geplant) x 100. Zeigt Team-Zuverlässigkeit.';

  @override
  String get agileCommitmentTrendTooltip =>
      'Trend der Team-Zuverlässigkeit: Geplant vs. Abgeschlossen pro Sprint.';

  @override
  String get agileNoTeamMembers => 'Keine Teammitglieder';

  @override
  String get agileGmailAuthError =>
      'Gmail-Autorisierung fehlgeschlagen. Bitte aus- und einloggen.';

  @override
  String get agileGmailPermissionDenied => 'Gmail-Berechtigung verweigert.';

  @override
  String get agileResend => 'Erneut senden';

  @override
  String get agileRevoke => 'Widerrufen';

  @override
  String get agileVelocityUnits => 'Story Points / Sprint';

  @override
  String get agileFiltersTitle => 'Filter';

  @override
  String get agilePlanned => 'Geplant';

  @override
  String get archiveDeleteSuccess => 'Erfolgreich archiviert/gelöscht';

  @override
  String get agileNoItems => 'Keine Elemente anzuzeigen';

  @override
  String agileItemsOfTotal(int completed, int total) {
    return '$completed von $total';
  }

  @override
  String get agileItemsCompletedLabel => 'Abgeschlossene Elemente';

  @override
  String get agileDaysRemainingSuffix => 'Tage verbleibend';

  @override
  String get agileItemsMore => 'weitere Items';

  @override
  String get wipAgeTitle => 'Alter Work Items';

  @override
  String get wipAgeEmpty => 'Keine Items in Bearbeitung';

  @override
  String wipAgeDays(int count) {
    return '$count Tage';
  }

  @override
  String get wipAgeWarning =>
      'Einige Items sind schon zu lange in Bearbeitung. Mögliche Blockaden.';

  @override
  String get agilePerWeekSuffix => '/Wo';

  @override
  String get average => 'Durchschnitt';

  @override
  String get agileAvgVelocitySprint => 'Velocity (Sprint)';

  @override
  String get agileAvgVelocityWeekly => 'Velocity (Woche)';

  @override
  String get agileAvgVelocitySprintTooltip =>
      'Durchschnitt abgeschlossener Punkte pro Sprint.';

  @override
  String get agileAvgVelocityWeeklyTooltip =>
      'Durchschnitt abgeschlossener Punkte pro Woche.';

  @override
  String get agileFiltersDoneTooltip =>
      'Abgeschlossene Stories werden standardmäßig archiviert. Filter wählen zum Ansehen.';

  @override
  String agileBacklogDoneBadge(Object count) {
    return '($count) Done';
  }

  @override
  String get agileBacklogDoneBadgeTooltip =>
      'Diese Stories sind standardmäßig ausgeblendet. Filter \'Done\' wählen.';

  @override
  String get agileFlowEfficiencyTooltip =>
      'Formel: (Aktive Zeit / Gesamtzeit im System) x 100. Echtzeit-Einschätzung.';

  @override
  String get getAgileFlowCycleTimeTooltip =>
      'Mittlere Zeit in aktiven Zuständen. Wartende Items (Ready) zählen mit 0 aktiver Zeit.';

  @override
  String get agileFlowLeadTimeTooltip =>
      'Mittlere Gesamtzeit im System (Erstellung bis heute/Abschluss).';

  @override
  String get agileFlowWipTooltip =>
      'Work In Progress: Anzahl Stories aktuell in Bearbeitung.';

  @override
  String get agileBlockedItemsTooltip =>
      'Stories mit unerfüllten Abhängigkeiten.';

  @override
  String agileItemsCount(int count) {
    return '$count Elemente';
  }

  @override
  String get agileDaysLeft => 'Verbleibende Tage';

  @override
  String get all => 'Alle';

  @override
  String get kanbanGuidePoliciesTitle => 'Explizite Policies';

  @override
  String get agileDaysLabel => 'Tage';

  @override
  String get agileStatRemaining => 'verbleibend';

  @override
  String get agileStatsCompletedLabel => 'Abgeschlossen';

  @override
  String get agileStatsPlannedLabel => 'Geplant';

  @override
  String get agileProgressLabel => 'Fortschritt';

  @override
  String get agileDurationLabel => 'Dauer';

  @override
  String get agileVelocityLabel => 'Velocity';

  @override
  String get agileStoriesLabel => 'Stories';

  @override
  String get agileSprintSummary => 'Sprint-Zusammenfassung';

  @override
  String get agileStoriesTotal => 'Stories gesamt';

  @override
  String get agileStoriesCompleted => 'Stories abgeschlossen';

  @override
  String get agilePointsCompletedLabel => 'Abgeschlossene Story Points';

  @override
  String get agileStoriesIncomplete => 'Unvollständige Stories';

  @override
  String get agileIncompleteReturnToBacklog => '(gehen zurück ins Backlog)';

  @override
  String get agilePointsLabel => 'Story Points';

  @override
  String get agileRecordReview => 'Sprint Review durchführen';

  @override
  String get agileCompleteSprintAction => 'Sprint schließen';

  @override
  String get agileMissingReview => 'Sprint Review noch nicht durchgeführt';

  @override
  String get agileSprintReviewCompleted => 'Sprint Review abgeschlossen';

  @override
  String get agileReviewNotesLabel => 'Review-Notizen';

  @override
  String get agileReviewFeedbackLabel => 'Stakeholder-Feedback';

  @override
  String get agileReviewNextFocus => 'Fokus nächster Sprint';

  @override
  String get agileBacklogUpdatesLabel => 'Backlog-Änderungen';

  @override
  String get agileSaveReview => 'Review speichern';

  @override
  String get agileGenerateRecap => 'Genera Recap';

  @override
  String get agileRecapCopied => 'Recap copiato negli appunti!';

  @override
  String get agileConductedBy => 'Durchgeführt von';

  @override
  String get agileReviewDate => 'Review-Datum';

  @override
  String get agileReviewOutcome => 'Review-Ergebnis';

  @override
  String get agileStoriesRejected => 'Nicht akzeptierte Stories';

  @override
  String get agileRejectedWarning =>
      'Unvollständige/abgelehnte Stories gehen zurück ins Backlog.';

  @override
  String get agileReviewDemoHint => 'Was wurde in der Demo gezeigt?';

  @override
  String get agileReviewFeedbackHint => 'Erhaltenes Feedback der Stakeholder';

  @override
  String get agileReviewBacklogHint => 'Neue Änderung am Backlog...';

  @override
  String get agileReviewNextFocusHint => 'Woran sollte das Team arbeiten?';

  @override
  String get agileReviewScrumGuide =>
      'Der Scrum Guide 2020 empfiehlt die Sprint Review vor dem Abschluss des Sprints.';

  @override
  String agileSprintCompleteConfirm(String name) {
    return 'Möchten Sie \"$name\" wirklich abschließen?';
  }

  @override
  String agileSprintCompleteSuccess(String velocity) {
    return 'Sprint abgeschlossen! Velocity: $velocity pts/Woche';
  }

  @override
  String get agileSprintReviewSaveSuccess => 'Sprint Review gespeichert';

  @override
  String get agileEstimationAccuracy => 'Planungszuverlässigkeit';

  @override
  String get agileCompleteOneSprintFirst =>
      'Schließen Sie mindestens einen Sprint ab';

  @override
  String get agileNoDataAccuracyFix => 'Keine Genauigkeitsdaten';

  @override
  String get agileScrumGuideRecommends =>
      'Der Scrum Guide empfiehlt Planung basierend auf historischer Velocity, nicht auf Stunden.';

  @override
  String get agileNoSkillsDefined => 'Keine Kompetenzen definiert';

  @override
  String get agileAddSkillsToMembers =>
      'Kompetenzen zu Teammitgliedern hinzufügen';

  @override
  String get retroNoSprintWarningTitle => 'Kein Sprint abgeschlossen';

  @override
  String get retroNoSprintWarningMessage =>
      'Um eine Scrum-Retrospektive zu erstellen, müssen Sie zuerst mindestens einen Sprint abschließen. Retrospektiven sind an Sprints gebunden, um Verbesserungen über Iterationen hinweg zu verfolgen.';

  @override
  String get agileGoToSprints => 'Zu den Sprints';

  @override
  String get agileSprintReviewHistory => 'Sprint Review Historie';

  @override
  String get agileNoSprintReviews => 'Keine Sprint Reviews';

  @override
  String get agileNoSprintReviewsHint =>
      'Schließen Sie einen Sprint ab und führen Sie eine Review durch, um sie hier zu sehen';

  @override
  String get agileAttendees => 'Teilnehmer';

  @override
  String get agileStoryEvaluations => 'Story-Bewertungen';

  @override
  String get agileDecisions => 'Entscheidungen';

  @override
  String get agileDemoNotes => 'Demo-Notizen';

  @override
  String get agileFeedback => 'Feedback';

  @override
  String get agileStoryApproved => 'Genehmigt';

  @override
  String get agileStoryNeedsRefinement => 'Refinement nötig';

  @override
  String get agileStoryRejected => 'Abgelehnt';

  @override
  String get agileAddAttendee => 'Teilnehmer hinzufügen';

  @override
  String get agileAddDecision => 'Entscheidung hinzufügen';

  @override
  String get agileNoDecisions => 'Keine Entscheidungen hinzugefügt';

  @override
  String get agileTooltipApproved => 'Genehmigt';

  @override
  String get agileTooltipRefinement => 'Refinement nötig';

  @override
  String get agileTooltipRejected => 'Abgelehnt';

  @override
  String get agileReviewGuidance =>
      'Wählen Sie das Ergebnis. \'Refinement nötig\' und \'Abgelehnt\' schicken die Story zurück ins Backlog.';

  @override
  String get agileEvaluateStories => 'Stories bewerten';

  @override
  String get agileSelectRole => 'Rolle auswählen';

  @override
  String get agileStatsNotCompleted => 'Nicht abgeschlossen';

  @override
  String get agileFramework => 'Framework';

  @override
  String get teamMembers => 'Teammitglieder';

  @override
  String get eisenhowerImportCsv => 'CSV importieren';

  @override
  String get eisenhowerImportPreview => 'Aktivitätsvorschau';

  @override
  String get eisenhowerImportSelectFile =>
      'CSV-Datei zum Importieren auswählen';

  @override
  String get eisenhowerImportFormatHint =>
      'Erwartetes Format: Aktivität, Beschreibung, Quadrant, Dringlichkeit, Wichtigkeit';

  @override
  String get eisenhowerImportClickToSelect => 'Klicken zum Auswählen';

  @override
  String get eisenhowerImportSupportedFormats =>
      'Unterstützte Formate: .csv (UTF-8 oder Latin-1)';

  @override
  String get eisenhowerImportNoActivities =>
      'Keine Aktivitäten in der Datei gefunden';

  @override
  String get eisenhowerImportMarkRevealed => 'Als bereits gevotet markieren';

  @override
  String get eisenhowerImportMarkRevealedHint =>
      'Aktivitäten erscheinen direkt im berechneten Quadranten';

  @override
  String eisenhowerImportSuccess(int count) {
    return '$count Aktivitäten importiert';
  }

  @override
  String get actionSelectAll => 'Alle auswählen';

  @override
  String get actionDeselectAll => 'Alle abwählen';

  @override
  String get actionImport => 'Importieren';

  @override
  String get eisenhowerImportShowInstructions => 'Anleitung zeigen/verbergen';

  @override
  String get eisenhowerImportInstructionsTitle => 'Erforderliches CSV-Format';

  @override
  String get eisenhowerImportInstructionsBody =>
      'Die CSV-Datei muss mindestens die Spalte \'Aktivität\' oder \'Title\' enthalten. Optionale Spalten: Beschreibung, Dringlichkeit (1-10), Wichtigkeit (1-10). Die erste Zeile muss die Kopfzeile sein.';

  @override
  String get eisenhowerImportExampleFormat =>
      'Aktivität,Beschreibung,Dringlichkeit,Wichtigkeit\n\"Aufgabenname\",\"Optionale Beschreibung\",8.5,7.2';

  @override
  String get eisenhowerImportChangeFile => 'Datei ändern';

  @override
  String eisenhowerImportSkippedRows(int count) {
    return '$count Zeilen wegen Fehlern übersprungen';
  }

  @override
  String eisenhowerImportAndMore(int count) {
    return '...und $count weitere Zeilen';
  }

  @override
  String eisenhowerImportFoundActivities(int valid, int total) {
    return '$valid gültige Aktivitäten in $total Zeilen gefunden';
  }

  @override
  String eisenhowerImportErrorEmptyTitle(int row) {
    return 'Zeile $row: Titel leer';
  }

  @override
  String eisenhowerImportErrorInvalidRow(int row) {
    return 'Zeile $row: ungültiges Format';
  }

  @override
  String get eisenhowerImportErrorMissingColumn =>
      'Spalte \'Aktivität\' oder \'Title\' im Header nicht gefunden';

  @override
  String get eisenhowerImportErrorEmptyFile => 'Die Datei ist leer';

  @override
  String get eisenhowerImportErrorNoHeader =>
      'Header in der ersten Zeile nicht gefunden';

  @override
  String eisenhowerImportErrorRow(int row) {
    return 'Zeile $row';
  }

  @override
  String get eisenhowerImportErrorReadFile =>
      'Datei konnte nicht gelesen werden';

  @override
  String get agileSprintHealthTitle => 'Sprint-Gesundheit';

  @override
  String get agileSprintHealthNoSprint => 'Kein aktiver Sprint';

  @override
  String get agileSprintHealthNoSprintDesc =>
      'Starten Sie einen Sprint, um Gesundheitsmetriken zu sehen';

  @override
  String get agileSprintHealthGoal => 'Sprint-Ziel';

  @override
  String get agileSprintHealthOnTrack => 'Auf Kurs';

  @override
  String get agileSprintHealthAtRisk => 'Gefährdet';

  @override
  String get agileSprintHealthOffTrack => 'Verspätet';

  @override
  String get agileSprintHealthTime => 'Zeit';

  @override
  String get agileSprintHealthWork => 'Arbeit';

  @override
  String get agileSprintHealthDaysLeft => 'Tage verbleibend';

  @override
  String get agileSprintHealthSpRemaining => 'SP verbleibend';

  @override
  String get agileSprintHealthStoriesInProgress => 'In Bearbeitung';

  @override
  String get agileSprintHealthStoriesDone => 'Erledigte Stories';

  @override
  String get agileSprintHealthCommitment => 'Zuverlässigkeit';

  @override
  String get agileSprintHealthDailyVelocity => 'Tägl. Velocity';

  @override
  String get agileSprintHealthPrediction => 'Vorhersage';

  @override
  String get agileSprintHealthOnTime => 'Pünktlich';

  @override
  String get agileSprintHealthStoriesBreakdown => 'Story-Verteilung';

  @override
  String get agileSprintBurndownTitle => 'Sprint-Burndown';

  @override
  String get agileSprintBurndownNoData => 'Keine Burndown-Daten';

  @override
  String get agileSprintBurndownNoDataDesc =>
      'Stories dem Sprint zuweisen, um Burndown zu sehen';

  @override
  String get agileWorkloadTitle => 'Team-Load';

  @override
  String get agileWorkloadBalanced => 'Ausgeglichen';

  @override
  String get agileWorkloadUnbalanced => 'Unausgeglichen';

  @override
  String get agileWorkloadTotalStories => 'Stories gesamt';

  @override
  String get agileWorkloadAssigned => 'Zugewiesen';

  @override
  String get agileWorkloadAvgSp => 'Durchschn. SP/Person';

  @override
  String get agileWorkloadStories => 'Stories';

  @override
  String get agileWorkloadInProgress => 'in Bearbeitung';

  @override
  String get agileWorkloadUnassigned => 'Nicht zugewiesen';

  @override
  String get agileWorkloadUnassignedWarning => 'Stories ohne Verantwortlichen';

  @override
  String get agileWorkloadNoStories => 'Keine Stories zum Analysieren';

  @override
  String get agileWorkloadNoStoriesDesc =>
      'Erstellen Sie Stories und weisen Sie diese Teammitgliedern zu';

  @override
  String get agileWorkloadOverloaded => 'Überlastet';

  @override
  String get agileCommitmentTrendTitle => 'Commitment-Trend';

  @override
  String get agileCommitmentTrendNoData => 'Keine Daten verfügbar';

  @override
  String get agileCommitmentTrendNoDataDesc =>
      'Schließen Sie einen Sprint ab, um den Trend zu sehen';

  @override
  String get agileCommitmentTrendPlanned => 'Geplant';

  @override
  String get agileCommitmentTrendCompleted => 'Abgeschlossen';

  @override
  String get agileCommitmentTrendAvg => 'Durchschnitt';

  @override
  String get agileFlowEfficiencyTitle => 'Flow-Effizienz & WIP';

  @override
  String get agileFlowEfficiencyNoData => 'Keine Daten verfügbar';

  @override
  String get agileFlowEfficiencyNoDataDesc =>
      'Fügen Sie Stories hinzu, um die Flow-Analyse zu sehen';

  @override
  String get agileFlowEfficiency => 'Flow-Effizienz';

  @override
  String get agileFlowCycleTime => 'Cycle-Time';

  @override
  String get agileFlowLeadTime => 'Lead-Time';

  @override
  String get agileFlowDays => 'Tage';

  @override
  String get agileFlowWipByStatus => 'WIP nach Status';

  @override
  String get agileFlowAvg => 'Durchschn.';

  @override
  String get agileBlockedItemsTitle => 'Blockierte Elemente';

  @override
  String get agileBlockedItemsNone => 'Keine blockierte Elemente';

  @override
  String get agileBlockedItemsNoneDesc => 'Alle Abhängigkeiten sind erfüllt';

  @override
  String agileBlockedItemsCount(Object count) {
    return '$count blockiert';
  }

  @override
  String get agileBlockedItemsSp => 'SP blockiert';

  @override
  String get agileBlockedItemsBlockedBy => 'Blockiert durch';

  @override
  String get agileBlockedItemsDependency => 'Abhängigkeit';

  @override
  String get agileBlockedItemsDependencies => 'Abhängigkeiten';

  @override
  String get agileSprintScopeTitle => 'Sprint-Umfang';

  @override
  String get agileSprintScopeNoSprint => 'Kein aktiver Sprint';

  @override
  String get agileSprintScopeNoSprintDesc =>
      'Starten Sie einen Sprint, um Umfangänderungen zu überwachen';

  @override
  String get agileSprintScopeOriginal => 'Original';

  @override
  String get agileSprintScopeCurrent => 'Aktuell';

  @override
  String get agileSprintScopeDelta => 'Delta';

  @override
  String get agileSprintScopeCreep => 'Scope-Creep';

  @override
  String get agileSprintScopeReduction => 'Umfang-Reduktion';

  @override
  String get agileSprintScopeStable => 'Stabil';

  @override
  String get agileSprintScopeSp => 'SP';

  @override
  String get landingIntegrationBadge => 'Integration';

  @override
  String get landingIntegrationTitle => 'Ein vernetztes Ökosystem';

  @override
  String get landingIntegrationSubtitle =>
      'Ihre Tools arbeiten zusammen. Vom Gedanken zur Delivery ohne Brüche.';

  @override
  String get landingIntegrationFlowTitle =>
      'Von der Liste zur Lieferung, in einem Fluss';

  @override
  String get landingIntegrationStep1 => 'Sammeln';

  @override
  String get landingIntegrationStep1Desc => 'Smart Todo';

  @override
  String get landingIntegrationStep2 => 'Priorisieren';

  @override
  String get landingIntegrationStep2Desc => 'Eisenhower';

  @override
  String get landingIntegrationStep3 => 'Schätzen';

  @override
  String get landingIntegrationStep3Desc => 'Estimation Room';

  @override
  String get landingIntegrationStep4 => 'Ausführen';

  @override
  String get landingIntegrationStep4Desc => 'Agile Process';

  @override
  String get landingIntegrationStep5 => 'Verbessern';

  @override
  String get landingIntegrationStep5Desc => 'Retrospektiven';

  @override
  String get landingIntegrationExport0Title =>
      'Smart Todo → Eisenhower / Schätzung / Sprint';

  @override
  String get landingIntegrationExport0Desc =>
      'Verwandeln Sie Tasks in prioritierte Aktivitäten, Stories oder Backlog-Items.';

  @override
  String get landingIntegrationExport1Title =>
      'Eisenhower → Todo / Schätzung / Sprint';

  @override
  String get landingIntegrationExport1Desc =>
      'Exportieren Sie prioritierte Aktivitäten zu Tasks, Schätz-Stories oder User Stories.';

  @override
  String get landingIntegrationExport2Title =>
      'Estimation Room → Todo / Sprint';

  @override
  String get landingIntegrationExport2Desc =>
      'Senden Sie Stories inklusive Points nach der Schätzung in Listen oder das Backlog.';

  @override
  String get landingIntegrationExport3Title => 'Agile Process → Retrospektiven';

  @override
  String get landingIntegrationExport3Desc =>
      'Verknüpfen Sie Retrospektiven mit Sprints und nutzen Sie verfügbare Metriken.';

  @override
  String get landingIntegrationDashboardTitle => 'Einheitliches Dashboard';

  @override
  String get landingIntegrationDashboardDesc =>
      'Favoriten, Termine und Einladungen aller Tools an einem Ort.';

  @override
  String jiraTransitionTitle(Object transitionName) {
    return 'Übergang abschließen: $transitionName';
  }

  @override
  String get jiraTransitionInfo =>
      'Jira benötigt zusätzliche Informationen für diesen Übergang.';

  @override
  String get jiraTransitionConfirm => 'Bestätigen';

  @override
  String get jiraTransitionCancel => 'Abbrechen';

  @override
  String get jiraFieldRequired => 'Pflichtfeld';

  @override
  String jiraSyncSuccess(Object transitionName) {
    return 'Jira: $transitionName abgeschlossen';
  }

  @override
  String jiraSyncedTo(Object statusName) {
    return 'Jira: Synchronisiert auf $statusName';
  }

  @override
  String jiraSyncFromSuccess(Object issueKey) {
    return 'Synchronisiert von Jira: $issueKey';
  }

  @override
  String jiraSyncFailed(Object error) {
    return 'Synchronisation fehlgeschlagen: $error';
  }

  @override
  String jiraSyncWarning(Object warning) {
    return 'Jira-Warnung: $warning';
  }

  @override
  String get actionSyncJira => 'Mit Jira synchronisieren';

  @override
  String get validationRequired => 'Erforderlich';

  @override
  String get jiraInvalidDomain => 'Ungültige Domain';

  @override
  String get jiraInvalidEmail => 'Ungültige E-Mail';

  @override
  String get jiraCreateTokenLink => 'API-Token erstellen >';

  @override
  String get agileHelpTitle => 'Kurzanleitung';

  @override
  String get agileHelpStep1Title => 'Backlog befüllen';

  @override
  String get agileHelpStep1Desc => 'Erstellen Sie User Stories im Backlog-Tab.';

  @override
  String get agileHelpStep2Title => 'Sprint planen';

  @override
  String get agileHelpStep2Desc => 'Neuen Sprint erstellen und Stories wählen.';

  @override
  String get agileHelpStep3Title => 'Auf dem Board arbeiten';

  @override
  String get agileHelpStep3Desc => 'Status per Drag & Drop aktualisieren.';

  @override
  String get agileHelpStep4Title => 'Synchronisieren & Schließen';

  @override
  String get agileHelpStep4Desc =>
      'Jira-Status synchonisieren und Sprint abschließen.';

  @override
  String get actionNext => 'Weiter';

  @override
  String get actionBack => 'Zurück';

  @override
  String get actionFinish => 'Fertig';

  @override
  String get agileStartSprintHint =>
      'Sprint starten, um aktive Stories zu sehen';

  @override
  String get workflowTitle => 'Arbeitsfluss';

  @override
  String get workflowShowButton => 'Fluss zeigen';

  @override
  String get workflowDiagramTitle => 'Zustandsdiagramm';

  @override
  String get workflowLegend => 'Legende';

  @override
  String get workflowScrumDesc =>
      'Scrum-Stories fließen durch Planning, Development, Review und Done. Iterativ mit festen Zeitboxen.';

  @override
  String get workflowKanbanDesc =>
      'Arbeit fließt kontinuierlich basierend auf WIP-Limits und Kapazität.';

  @override
  String get workflowHybridDesc => 'Kombiniert Scrum-Sprints mit Kanban-Fluss.';

  @override
  String get workflowFromAny => 'Von überall';

  @override
  String get workflowFromAnyDesc => 'Übergang aus jedem Status möglich';

  @override
  String get workflowCycleLabel => 'Rework';

  @override
  String get workflowCycleDesc => 'Bidirektionaler Übergang (Zyklus)';

  @override
  String get workflowOptionalDesc => 'Optionaler Schritt';

  @override
  String get kanbanPoliciesActive => 'Aktive Richtlinien (Autom. Kontrollen)';

  @override
  String get kanbanPoliciesExplicit => 'Explizite Richtlinien (Notizen)';

  @override
  String get agileTeam => 'Team';

  @override
  String get agileRoleDevelopmentTeam => 'Development Team';

  @override
  String get agileRoleDevelopmentTeamDesc => 'Ausführende Teammitglieder';

  @override
  String get feedbackTitle => 'Come ti trovi con Keisen?';

  @override
  String get feedbackSubtitle => 'La tua opinione ci aiuta a migliorare';

  @override
  String get feedbackCommentHint => 'Lascia un commento (opzionale)';

  @override
  String get feedbackDismiss => 'Non ora';

  @override
  String get feedbackThankYou => 'Grazie per il tuo feedback!';

  @override
  String get estimationThreePointFormula => 'Formula: (O + 4M + P) / 6';

  @override
  String get estimationThreePointOptHint => 'Best case';

  @override
  String get estimationThreePointRealHint => 'Most likely';

  @override
  String get estimationThreePointPessHint => 'Worst case';

  @override
  String get estimationThreePointReqError => 'All fields are required';

  @override
  String get estimationThreePointInvalidError => 'Invalid values';

  @override
  String get estimationThreePointGuideTitle => 'Guide:';

  @override
  String get estimationThreePointGuideText =>
      'O: Best-case estimate (everything goes right)\nM: Most likely estimate (normal conditions)\nP: Worst-case estimate (unforeseen events)';

  @override
  String get estimationThreePointVarPERT => 'PERT';

  @override
  String get estimationThreePointVarDevStd => 'Std. Dev';

  @override
  String get estimationThreePointVarRange => 'Range';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get exportCsvSelected => 'CSV-Export gestartet...';

  @override
  String get errorExportingCsv => 'Fehler beim CSV-Export';
}
