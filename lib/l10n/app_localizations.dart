import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In it, this message translates to:
  /// **'Keisen'**
  String get appTitle;

  /// No description provided for @goToHome.
  ///
  /// In it, this message translates to:
  /// **'Vai alla Home'**
  String get goToHome;

  /// No description provided for @actionSave.
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In it, this message translates to:
  /// **'Modifica'**
  String get actionEdit;

  /// No description provided for @actionCreate.
  ///
  /// In it, this message translates to:
  /// **'Crea'**
  String get actionCreate;

  /// No description provided for @actionAdd.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi'**
  String get actionAdd;

  /// No description provided for @actionClose.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get actionClose;

  /// No description provided for @actionRetry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get actionRetry;

  /// No description provided for @actionConfirm.
  ///
  /// In it, this message translates to:
  /// **'Conferma'**
  String get actionConfirm;

  /// No description provided for @actionSearch.
  ///
  /// In it, this message translates to:
  /// **'Cerca'**
  String get actionSearch;

  /// No description provided for @actionFilter.
  ///
  /// In it, this message translates to:
  /// **'Filtra'**
  String get actionFilter;

  /// No description provided for @actionExport.
  ///
  /// In it, this message translates to:
  /// **'Esporta'**
  String get actionExport;

  /// No description provided for @actionCopy.
  ///
  /// In it, this message translates to:
  /// **'Copia'**
  String get actionCopy;

  /// No description provided for @actionShare.
  ///
  /// In it, this message translates to:
  /// **'Condividi'**
  String get actionShare;

  /// No description provided for @actionDone.
  ///
  /// In it, this message translates to:
  /// **'Fatto'**
  String get actionDone;

  /// No description provided for @actionReset.
  ///
  /// In it, this message translates to:
  /// **'Reset'**
  String get actionReset;

  /// No description provided for @actionOpen.
  ///
  /// In it, this message translates to:
  /// **'Apri'**
  String get actionOpen;

  /// No description provided for @stateLoading.
  ///
  /// In it, this message translates to:
  /// **'Caricamento...'**
  String get stateLoading;

  /// No description provided for @stateEmpty.
  ///
  /// In it, this message translates to:
  /// **'Nessun elemento'**
  String get stateEmpty;

  /// No description provided for @stateError.
  ///
  /// In it, this message translates to:
  /// **'Errore'**
  String get stateError;

  /// No description provided for @stateSuccess.
  ///
  /// In it, this message translates to:
  /// **'Successo'**
  String get stateSuccess;

  /// No description provided for @subscriptionCurrent.
  ///
  /// In it, this message translates to:
  /// **'ATTUALE'**
  String get subscriptionCurrent;

  /// No description provided for @subscriptionRecommended.
  ///
  /// In it, this message translates to:
  /// **'CONSIGLIATO'**
  String get subscriptionRecommended;

  /// No description provided for @subscriptionFree.
  ///
  /// In it, this message translates to:
  /// **'Gratis'**
  String get subscriptionFree;

  /// No description provided for @subscriptionPerMonth.
  ///
  /// In it, this message translates to:
  /// **'/mese'**
  String get subscriptionPerMonth;

  /// No description provided for @subscriptionPerYear.
  ///
  /// In it, this message translates to:
  /// **'/anno'**
  String get subscriptionPerYear;

  /// No description provided for @subscriptionSaveYearly.
  ///
  /// In it, this message translates to:
  /// **'Risparmi €{amount}/anno'**
  String subscriptionSaveYearly(String amount);

  /// No description provided for @subscriptionTrialDays.
  ///
  /// In it, this message translates to:
  /// **'{days} giorni di prova gratuita'**
  String subscriptionTrialDays(int days);

  /// No description provided for @subscriptionUnlimitedProjects.
  ///
  /// In it, this message translates to:
  /// **'Progetti illimitati'**
  String get subscriptionUnlimitedProjects;

  /// No description provided for @subscriptionProjectsActive.
  ///
  /// In it, this message translates to:
  /// **'{count} progetti attivi'**
  String subscriptionProjectsActive(int count);

  /// No description provided for @subscriptionUnlimitedLists.
  ///
  /// In it, this message translates to:
  /// **'Liste illimitate'**
  String get subscriptionUnlimitedLists;

  /// No description provided for @subscriptionSmartTodoLists.
  ///
  /// In it, this message translates to:
  /// **'Liste Smart Todo'**
  String subscriptionSmartTodoLists(int count);

  /// No description provided for @subscriptionActiveProjectsLabel.
  ///
  /// In it, this message translates to:
  /// **'Progetti attivi'**
  String get subscriptionActiveProjectsLabel;

  /// No description provided for @subscriptionSmartTodoListsLabel.
  ///
  /// In it, this message translates to:
  /// **'Liste Smart Todo'**
  String get subscriptionSmartTodoListsLabel;

  /// No description provided for @subscriptionUnlimitedTasks.
  ///
  /// In it, this message translates to:
  /// **'Task illimitati'**
  String get subscriptionUnlimitedTasks;

  /// No description provided for @subscriptionTasksPerProject.
  ///
  /// In it, this message translates to:
  /// **'{count} task per progetto'**
  String subscriptionTasksPerProject(int count);

  /// No description provided for @subscriptionUnlimitedInvites.
  ///
  /// In it, this message translates to:
  /// **'Inviti illimitati'**
  String get subscriptionUnlimitedInvites;

  /// No description provided for @subscriptionInvitesPerProject.
  ///
  /// In it, this message translates to:
  /// **'{count} inviti per progetto'**
  String subscriptionInvitesPerProject(int count);

  /// No description provided for @subscriptionWithAds.
  ///
  /// In it, this message translates to:
  /// **'Con pubblicità'**
  String get subscriptionWithAds;

  /// No description provided for @subscriptionWithoutAds.
  ///
  /// In it, this message translates to:
  /// **'Senza pubblicità'**
  String get subscriptionWithoutAds;

  /// No description provided for @authSignInGoogle.
  ///
  /// In it, this message translates to:
  /// **'Accedi con Google'**
  String get authSignInGoogle;

  /// No description provided for @authSignOut.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get authSignOut;

  /// No description provided for @authLogoutConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler uscire?'**
  String get authLogoutConfirm;

  /// No description provided for @formNameRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci il tuo nome'**
  String get formNameRequired;

  /// No description provided for @authError.
  ///
  /// In it, this message translates to:
  /// **'Errore di autenticazione'**
  String get authError;

  /// No description provided for @authUserNotFound.
  ///
  /// In it, this message translates to:
  /// **'Utente non trovato'**
  String get authUserNotFound;

  /// No description provided for @authWrongPassword.
  ///
  /// In it, this message translates to:
  /// **'Password errata'**
  String get authWrongPassword;

  /// No description provided for @authEmailInUse.
  ///
  /// In it, this message translates to:
  /// **'Email già in uso'**
  String get authEmailInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In it, this message translates to:
  /// **'Password troppo debole'**
  String get authWeakPassword;

  /// No description provided for @authInvalidEmail.
  ///
  /// In it, this message translates to:
  /// **'Email non valida'**
  String get authInvalidEmail;

  /// No description provided for @appSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Keisen per Team'**
  String get appSubtitle;

  /// No description provided for @authOr.
  ///
  /// In it, this message translates to:
  /// **'oppure'**
  String get authOr;

  /// No description provided for @authPassword.
  ///
  /// In it, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authRegister.
  ///
  /// In it, this message translates to:
  /// **'Registrati'**
  String get authRegister;

  /// No description provided for @authLogin.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get authLogin;

  /// No description provided for @authHaveAccount.
  ///
  /// In it, this message translates to:
  /// **'Hai già un account?'**
  String get authHaveAccount;

  /// No description provided for @authNoAccount.
  ///
  /// In it, this message translates to:
  /// **'Non hai un account?'**
  String get authNoAccount;

  /// No description provided for @navHome.
  ///
  /// In it, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navProfile.
  ///
  /// In it, this message translates to:
  /// **'Profilo'**
  String get navProfile;

  /// No description provided for @navSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get navSettings;

  /// No description provided for @eisenhowerTitle.
  ///
  /// In it, this message translates to:
  /// **'Matrice di Eisenhower'**
  String get eisenhowerTitle;

  /// No description provided for @eisenhowerYourMatrices.
  ///
  /// In it, this message translates to:
  /// **'Le tue matrici'**
  String get eisenhowerYourMatrices;

  /// No description provided for @eisenhowerNoMatrices.
  ///
  /// In it, this message translates to:
  /// **'Nessuna matrice creata'**
  String get eisenhowerNoMatrices;

  /// No description provided for @eisenhowerNewMatrix.
  ///
  /// In it, this message translates to:
  /// **'Nuova Matrice'**
  String get eisenhowerNewMatrix;

  /// No description provided for @eisenhowerViewGrid.
  ///
  /// In it, this message translates to:
  /// **'Griglia'**
  String get eisenhowerViewGrid;

  /// No description provided for @eisenhowerViewChart.
  ///
  /// In it, this message translates to:
  /// **'Grafico'**
  String get eisenhowerViewChart;

  /// No description provided for @eisenhowerViewList.
  ///
  /// In it, this message translates to:
  /// **'Lista'**
  String get eisenhowerViewList;

  /// No description provided for @eisenhowerViewRaci.
  ///
  /// In it, this message translates to:
  /// **'RACI'**
  String get eisenhowerViewRaci;

  /// No description provided for @quadrantUrgent.
  ///
  /// In it, this message translates to:
  /// **'URGENTE'**
  String get quadrantUrgent;

  /// No description provided for @quadrantNotUrgent.
  ///
  /// In it, this message translates to:
  /// **'NON URGENTE'**
  String get quadrantNotUrgent;

  /// No description provided for @quadrantImportant.
  ///
  /// In it, this message translates to:
  /// **'IMPORTANTE'**
  String get quadrantImportant;

  /// No description provided for @quadrantNotImportant.
  ///
  /// In it, this message translates to:
  /// **'NON IMPORTANTE'**
  String get quadrantNotImportant;

  /// No description provided for @quadrantQ1Title.
  ///
  /// In it, this message translates to:
  /// **'FAI SUBITO'**
  String get quadrantQ1Title;

  /// No description provided for @quadrantQ2Title.
  ///
  /// In it, this message translates to:
  /// **'PIANIFICA'**
  String get quadrantQ2Title;

  /// No description provided for @quadrantQ3Title.
  ///
  /// In it, this message translates to:
  /// **'DELEGA'**
  String get quadrantQ3Title;

  /// No description provided for @quadrantQ4Title.
  ///
  /// In it, this message translates to:
  /// **'ELIMINA'**
  String get quadrantQ4Title;

  /// No description provided for @quadrantQ1Subtitle.
  ///
  /// In it, this message translates to:
  /// **'Urgente e Importante'**
  String get quadrantQ1Subtitle;

  /// No description provided for @quadrantQ2Subtitle.
  ///
  /// In it, this message translates to:
  /// **'Importante, Non Urgente'**
  String get quadrantQ2Subtitle;

  /// No description provided for @quadrantQ3Subtitle.
  ///
  /// In it, this message translates to:
  /// **'Urgente, Non Importante'**
  String get quadrantQ3Subtitle;

  /// No description provided for @quadrantQ4Subtitle.
  ///
  /// In it, this message translates to:
  /// **'Non Urgente, Non Importante'**
  String get quadrantQ4Subtitle;

  /// No description provided for @eisenhowerNoActivities.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attivita'**
  String get eisenhowerNoActivities;

  /// No description provided for @eisenhowerNewActivity.
  ///
  /// In it, this message translates to:
  /// **'Nuova Attivita'**
  String get eisenhowerNewActivity;

  /// No description provided for @eisenhowerExportSheets.
  ///
  /// In it, this message translates to:
  /// **'Esporta su Google Sheets'**
  String get eisenhowerExportSheets;

  /// No description provided for @eisenhowerInviteParticipants.
  ///
  /// In it, this message translates to:
  /// **'Invita Partecipanti'**
  String get eisenhowerInviteParticipants;

  /// No description provided for @eisenhowerDeleteMatrix.
  ///
  /// In it, this message translates to:
  /// **'Elimina Matrice'**
  String get eisenhowerDeleteMatrix;

  /// No description provided for @eisenhowerDeleteMatrixConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare questa matrice?'**
  String get eisenhowerDeleteMatrixConfirm;

  /// No description provided for @eisenhowerActivityTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo attivita'**
  String get eisenhowerActivityTitle;

  /// No description provided for @eisenhowerActivityNotes.
  ///
  /// In it, this message translates to:
  /// **'Note'**
  String get eisenhowerActivityNotes;

  /// No description provided for @eisenhowerDueDate.
  ///
  /// In it, this message translates to:
  /// **'Data scadenza'**
  String get eisenhowerDueDate;

  /// No description provided for @eisenhowerPriority.
  ///
  /// In it, this message translates to:
  /// **'Priorita'**
  String get eisenhowerPriority;

  /// No description provided for @eisenhowerAssignee.
  ///
  /// In it, this message translates to:
  /// **'Assegnatario'**
  String get eisenhowerAssignee;

  /// No description provided for @eisenhowerCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completata'**
  String get eisenhowerCompleted;

  /// No description provided for @eisenhowerMoveToQuadrant.
  ///
  /// In it, this message translates to:
  /// **'Sposta nel quadrante'**
  String get eisenhowerMoveToQuadrant;

  /// No description provided for @eisenhowerMatrixSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni Matrice'**
  String get eisenhowerMatrixSettings;

  /// No description provided for @eisenhowerBackToList.
  ///
  /// In it, this message translates to:
  /// **'Lista'**
  String get eisenhowerBackToList;

  /// No description provided for @eisenhowerPriorityList.
  ///
  /// In it, this message translates to:
  /// **'Lista Priorita'**
  String get eisenhowerPriorityList;

  /// No description provided for @eisenhowerAllActivities.
  ///
  /// In it, this message translates to:
  /// **'Tutte le attivita'**
  String get eisenhowerAllActivities;

  /// No description provided for @eisenhowerToVote.
  ///
  /// In it, this message translates to:
  /// **'Da votare'**
  String get eisenhowerToVote;

  /// No description provided for @eisenhowerVoted.
  ///
  /// In it, this message translates to:
  /// **'Votate'**
  String get eisenhowerVoted;

  /// No description provided for @eisenhowerTotal.
  ///
  /// In it, this message translates to:
  /// **'Totali'**
  String get eisenhowerTotal;

  /// No description provided for @eisenhowerEditParticipants.
  ///
  /// In it, this message translates to:
  /// **'Modifica partecipanti'**
  String get eisenhowerEditParticipants;

  /// No description provided for @eisenhowerActivityCountLabel.
  ///
  /// In it, this message translates to:
  /// **'{count} attivita'**
  String eisenhowerActivityCountLabel(int count);

  /// No description provided for @eisenhowerVoteCountLabel.
  ///
  /// In it, this message translates to:
  /// **'{count} voti'**
  String eisenhowerVoteCountLabel(int count);

  /// No description provided for @eisenhowerModifyVotes.
  ///
  /// In it, this message translates to:
  /// **'Modifica voti'**
  String get eisenhowerModifyVotes;

  /// No description provided for @eisenhowerVote.
  ///
  /// In it, this message translates to:
  /// **'Vota'**
  String get eisenhowerVote;

  /// No description provided for @eisenhowerQuadrant.
  ///
  /// In it, this message translates to:
  /// **'Quadrante'**
  String get eisenhowerQuadrant;

  /// No description provided for @eisenhowerUrgencyAvg.
  ///
  /// In it, this message translates to:
  /// **'Urgenza media'**
  String get eisenhowerUrgencyAvg;

  /// No description provided for @eisenhowerImportanceAvg.
  ///
  /// In it, this message translates to:
  /// **'Importanza media'**
  String get eisenhowerImportanceAvg;

  /// No description provided for @eisenhowerVotesLabel.
  ///
  /// In it, this message translates to:
  /// **'Voti:'**
  String get eisenhowerVotesLabel;

  /// No description provided for @eisenhowerNoVotesYet.
  ///
  /// In it, this message translates to:
  /// **'Nessun voto ancora raccolto'**
  String get eisenhowerNoVotesYet;

  /// No description provided for @eisenhowerEditMatrix.
  ///
  /// In it, this message translates to:
  /// **'Modifica Matrice'**
  String get eisenhowerEditMatrix;

  /// No description provided for @eisenhowerAddActivity.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Attivita'**
  String get eisenhowerAddActivity;

  /// No description provided for @eisenhowerDeleteActivity.
  ///
  /// In it, this message translates to:
  /// **'Elimina Attivita'**
  String get eisenhowerDeleteActivity;

  /// No description provided for @eisenhowerDeleteActivityConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare \"{title}\"?'**
  String eisenhowerDeleteActivityConfirm(String title);

  /// No description provided for @eisenhowerMatrixCreated.
  ///
  /// In it, this message translates to:
  /// **'Matrice creata con successo'**
  String get eisenhowerMatrixCreated;

  /// No description provided for @eisenhowerMatrixUpdated.
  ///
  /// In it, this message translates to:
  /// **'Matrice aggiornata'**
  String get eisenhowerMatrixUpdated;

  /// No description provided for @eisenhowerMatrixDeleted.
  ///
  /// In it, this message translates to:
  /// **'Matrice eliminata'**
  String get eisenhowerMatrixDeleted;

  /// No description provided for @eisenhowerActivityAdded.
  ///
  /// In it, this message translates to:
  /// **'Attivita aggiunta'**
  String get eisenhowerActivityAdded;

  /// No description provided for @eisenhowerActivityDeleted.
  ///
  /// In it, this message translates to:
  /// **'Attivita eliminata'**
  String get eisenhowerActivityDeleted;

  /// No description provided for @eisenhowerVotesSaved.
  ///
  /// In it, this message translates to:
  /// **'Voti salvati'**
  String get eisenhowerVotesSaved;

  /// No description provided for @eisenhowerExportCompleted.
  ///
  /// In it, this message translates to:
  /// **'Export completato!'**
  String get eisenhowerExportCompleted;

  /// No description provided for @eisenhowerExportCompletedDialog.
  ///
  /// In it, this message translates to:
  /// **'Export Completato'**
  String get eisenhowerExportCompletedDialog;

  /// No description provided for @eisenhowerExportDialogContent.
  ///
  /// In it, this message translates to:
  /// **'Il foglio Google Sheets e stato creato.\nVuoi aprirlo nel browser?'**
  String get eisenhowerExportDialogContent;

  /// No description provided for @eisenhowerOpen.
  ///
  /// In it, this message translates to:
  /// **'Apri'**
  String get eisenhowerOpen;

  /// No description provided for @eisenhowerAddParticipantsFirst.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi prima dei partecipanti alla matrice'**
  String get eisenhowerAddParticipantsFirst;

  /// No description provided for @eisenhowerSearchLabel.
  ///
  /// In it, this message translates to:
  /// **'Ricerca:'**
  String get eisenhowerSearchLabel;

  /// No description provided for @eisenhowerSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca matrici...'**
  String get eisenhowerSearchHint;

  /// No description provided for @eisenhowerNoMatrixFound.
  ///
  /// In it, this message translates to:
  /// **'Nessuna matrice trovata'**
  String get eisenhowerNoMatrixFound;

  /// No description provided for @eisenhowerCreateFirstMatrix.
  ///
  /// In it, this message translates to:
  /// **'Crea la tua prima Matrice di Eisenhower\nper organizzare le tue priorita'**
  String get eisenhowerCreateFirstMatrix;

  /// No description provided for @eisenhowerCreateMatrix.
  ///
  /// In it, this message translates to:
  /// **'Crea Matrice'**
  String get eisenhowerCreateMatrix;

  /// No description provided for @eisenhowerClickToOpen.
  ///
  /// In it, this message translates to:
  /// **'Matrice Eisenhower\nClicca per aprire'**
  String get eisenhowerClickToOpen;

  /// No description provided for @eisenhowerTotalActivities.
  ///
  /// In it, this message translates to:
  /// **'Attivita totali nella matrice'**
  String get eisenhowerTotalActivities;

  /// No description provided for @eisenhowerVotedActivities.
  ///
  /// In it, this message translates to:
  /// **'Attivita votate'**
  String get eisenhowerVotedActivities;

  /// No description provided for @eisenhowerPendingVoting.
  ///
  /// In it, this message translates to:
  /// **'Attivita da votare'**
  String get eisenhowerPendingVoting;

  /// No description provided for @eisenhowerStartVoting.
  ///
  /// In it, this message translates to:
  /// **'Avvia Votazione Indipendente'**
  String get eisenhowerStartVoting;

  /// No description provided for @eisenhowerStartVotingDesc.
  ///
  /// In it, this message translates to:
  /// **'Vuoi avviare una sessione di voto indipendente per \"{title}\"?\n\nOgni partecipante votera senza vedere i voti degli altri, fino a quando tutti avranno votato e i voti verranno rivelati.'**
  String eisenhowerStartVotingDesc(String title);

  /// No description provided for @eisenhowerStart.
  ///
  /// In it, this message translates to:
  /// **'Avvia'**
  String get eisenhowerStart;

  /// No description provided for @eisenhowerVotingStarted.
  ///
  /// In it, this message translates to:
  /// **'Votazione avviata'**
  String get eisenhowerVotingStarted;

  /// No description provided for @eisenhowerResetVoting.
  ///
  /// In it, this message translates to:
  /// **'Resettare Votazione?'**
  String get eisenhowerResetVoting;

  /// No description provided for @eisenhowerResetVotingDesc.
  ///
  /// In it, this message translates to:
  /// **'Tutti i voti verranno cancellati.'**
  String get eisenhowerResetVotingDesc;

  /// No description provided for @eisenhowerVotingReset.
  ///
  /// In it, this message translates to:
  /// **'Votazione resettata'**
  String get eisenhowerVotingReset;

  /// No description provided for @eisenhowerMinVotersRequired.
  ///
  /// In it, this message translates to:
  /// **'Servono almeno 2 votanti per la votazione indipendente'**
  String get eisenhowerMinVotersRequired;

  /// No description provided for @eisenhowerDeleteMatrixWithActivities.
  ///
  /// In it, this message translates to:
  /// **'Verranno eliminate anche tutte le {count} attivita.'**
  String eisenhowerDeleteMatrixWithActivities(int count);

  /// No description provided for @eisenhowerYourMatricesCount.
  ///
  /// In it, this message translates to:
  /// **'Le tue matrici ({filtered}/{total})'**
  String eisenhowerYourMatricesCount(int filtered, int total);

  /// No description provided for @formTitleRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un titolo'**
  String get formTitleRequired;

  /// No description provided for @formTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Es: Priorita Q1 2025'**
  String get formTitleHint;

  /// No description provided for @formDescriptionHint.
  ///
  /// In it, this message translates to:
  /// **'Descrizione opzionale'**
  String get formDescriptionHint;

  /// No description provided for @formParticipantHint.
  ///
  /// In it, this message translates to:
  /// **'Nome partecipante'**
  String get formParticipantHint;

  /// No description provided for @formAddParticipantHint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi almeno un partecipante per poter votare'**
  String get formAddParticipantHint;

  /// No description provided for @formActivityTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Es: Completare documentazione API'**
  String get formActivityTitleHint;

  /// No description provided for @errorCreatingMatrix.
  ///
  /// In it, this message translates to:
  /// **'Errore creazione matrice'**
  String get errorCreatingMatrix;

  /// No description provided for @errorUpdatingMatrix.
  ///
  /// In it, this message translates to:
  /// **'Errore aggiornamento'**
  String get errorUpdatingMatrix;

  /// No description provided for @errorDeletingMatrix.
  ///
  /// In it, this message translates to:
  /// **'Errore eliminazione'**
  String get errorDeletingMatrix;

  /// No description provided for @errorAddingActivity.
  ///
  /// In it, this message translates to:
  /// **'Errore aggiunta attivita'**
  String get errorAddingActivity;

  /// No description provided for @errorSavingVotes.
  ///
  /// In it, this message translates to:
  /// **'Errore salvataggio voti'**
  String get errorSavingVotes;

  /// No description provided for @errorExport.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'export'**
  String get errorExport;

  /// No description provided for @errorStartingVoting.
  ///
  /// In it, this message translates to:
  /// **'Errore avvio votazione'**
  String get errorStartingVoting;

  /// No description provided for @errorResetVoting.
  ///
  /// In it, this message translates to:
  /// **'Errore reset'**
  String get errorResetVoting;

  /// No description provided for @errorLoadingActivities.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento attivita'**
  String get errorLoadingActivities;

  /// No description provided for @eisenhowerWaitingForVotes.
  ///
  /// In it, this message translates to:
  /// **'In attesa di voti'**
  String get eisenhowerWaitingForVotes;

  /// No description provided for @eisenhowerVotedParticipants.
  ///
  /// In it, this message translates to:
  /// **'{ready}/{total} voti'**
  String eisenhowerVotedParticipants(int ready, int total);

  /// No description provided for @eisenhowerVoteSubmit.
  ///
  /// In it, this message translates to:
  /// **'VOTA'**
  String get eisenhowerVoteSubmit;

  /// No description provided for @eisenhowerVotedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Hai votato'**
  String get eisenhowerVotedSuccess;

  /// No description provided for @eisenhowerRevealVotes.
  ///
  /// In it, this message translates to:
  /// **'RIVELA VOTI'**
  String get eisenhowerRevealVotes;

  /// No description provided for @eisenhowerQuickVote.
  ///
  /// In it, this message translates to:
  /// **'Voto Rapido'**
  String get eisenhowerQuickVote;

  /// No description provided for @eisenhowerTeamVote.
  ///
  /// In it, this message translates to:
  /// **'Voto Team'**
  String get eisenhowerTeamVote;

  /// No description provided for @eisenhowerUrgency.
  ///
  /// In it, this message translates to:
  /// **'URGENZA'**
  String get eisenhowerUrgency;

  /// No description provided for @eisenhowerImportance.
  ///
  /// In it, this message translates to:
  /// **'IMPORTANZA'**
  String get eisenhowerImportance;

  /// No description provided for @eisenhowerUrgencyShort.
  ///
  /// In it, this message translates to:
  /// **'U:'**
  String get eisenhowerUrgencyShort;

  /// No description provided for @eisenhowerImportanceShort.
  ///
  /// In it, this message translates to:
  /// **'I:'**
  String get eisenhowerImportanceShort;

  /// No description provided for @eisenhowerVotingInProgress.
  ///
  /// In it, this message translates to:
  /// **'VOTAZIONE IN CORSO'**
  String get eisenhowerVotingInProgress;

  /// No description provided for @eisenhowerWaitingForOthers.
  ///
  /// In it, this message translates to:
  /// **'In attesa che tutti votino. Il facilitatore rivelerà i voti.'**
  String get eisenhowerWaitingForOthers;

  /// No description provided for @eisenhowerReady.
  ///
  /// In it, this message translates to:
  /// **'Pronto'**
  String get eisenhowerReady;

  /// No description provided for @eisenhowerWaiting.
  ///
  /// In it, this message translates to:
  /// **'In attesa'**
  String get eisenhowerWaiting;

  /// No description provided for @eisenhowerIndividualVotes.
  ///
  /// In it, this message translates to:
  /// **'VOTI INDIVIDUALI'**
  String get eisenhowerIndividualVotes;

  /// No description provided for @eisenhowerResult.
  ///
  /// In it, this message translates to:
  /// **'RISULTATO'**
  String get eisenhowerResult;

  /// No description provided for @eisenhowerAverage.
  ///
  /// In it, this message translates to:
  /// **'MEDIA'**
  String get eisenhowerAverage;

  /// No description provided for @eisenhowerVotesRevealed.
  ///
  /// In it, this message translates to:
  /// **'Voti Rivelati'**
  String get eisenhowerVotesRevealed;

  /// No description provided for @eisenhowerNextActivity.
  ///
  /// In it, this message translates to:
  /// **'Prossima Attività'**
  String get eisenhowerNextActivity;

  /// No description provided for @eisenhowerNoVotesRecorded.
  ///
  /// In it, this message translates to:
  /// **'Nessun voto registrato'**
  String get eisenhowerNoVotesRecorded;

  /// No description provided for @eisenhowerWaitingForStart.
  ///
  /// In it, this message translates to:
  /// **'In attesa'**
  String get eisenhowerWaitingForStart;

  /// No description provided for @eisenhowerPreVotesTooltip.
  ///
  /// In it, this message translates to:
  /// **'Voti anticipati che verranno conteggiati quando il facilitatore avvia la votazione'**
  String get eisenhowerPreVotesTooltip;

  /// No description provided for @eisenhowerObserverWaiting.
  ///
  /// In it, this message translates to:
  /// **'In attesa che il facilitatore avvii la votazione collettiva'**
  String get eisenhowerObserverWaiting;

  /// No description provided for @eisenhowerPreVoteTooltip.
  ///
  /// In it, this message translates to:
  /// **'Esprimi il tuo voto in anticipo. Verrà conteggiato quando la votazione sarà avviata.'**
  String get eisenhowerPreVoteTooltip;

  /// No description provided for @eisenhowerPreVote.
  ///
  /// In it, this message translates to:
  /// **'Pre-vota'**
  String get eisenhowerPreVote;

  /// No description provided for @eisenhowerPreVoted.
  ///
  /// In it, this message translates to:
  /// **'Hai pre-votato'**
  String get eisenhowerPreVoted;

  /// No description provided for @eisenhowerStartVotingTooltip.
  ///
  /// In it, this message translates to:
  /// **'Avvia la sessione di votazione collettiva. I pre-voti esistenti verranno preservati.'**
  String get eisenhowerStartVotingTooltip;

  /// No description provided for @eisenhowerResetVotingTooltip.
  ///
  /// In it, this message translates to:
  /// **'Resetta la votazione cancellando tutti i voti'**
  String get eisenhowerResetVotingTooltip;

  /// No description provided for @eisenhowerObserverWaitingVotes.
  ///
  /// In it, this message translates to:
  /// **'Osservando la votazione in corso...'**
  String get eisenhowerObserverWaitingVotes;

  /// No description provided for @eisenhowerWaitingForAllVotes.
  ///
  /// In it, this message translates to:
  /// **'In attesa che tutti i partecipanti votino'**
  String get eisenhowerWaitingForAllVotes;

  /// No description provided for @eisenhowerRevealTooltipReady.
  ///
  /// In it, this message translates to:
  /// **'Tutti hanno votato! Clicca per rivelare i risultati.'**
  String get eisenhowerRevealTooltipReady;

  /// No description provided for @eisenhowerRevealTooltipNotReady.
  ///
  /// In it, this message translates to:
  /// **'Mancano ancora {count} voti'**
  String eisenhowerRevealTooltipNotReady(int count);

  /// No description provided for @eisenhowerVotingLocked.
  ///
  /// In it, this message translates to:
  /// **'Votazione chiusa'**
  String get eisenhowerVotingLocked;

  /// No description provided for @eisenhowerVotingLockedTooltip.
  ///
  /// In it, this message translates to:
  /// **'I voti sono stati rivelati. Non è più possibile votare su questa attività.'**
  String get eisenhowerVotingLockedTooltip;

  /// No description provided for @eisenhowerOnlineParticipants.
  ///
  /// In it, this message translates to:
  /// **'{online} di {total} partecipanti online'**
  String eisenhowerOnlineParticipants(int online, int total);

  /// No description provided for @eisenhowerVoting.
  ///
  /// In it, this message translates to:
  /// **'Votazione'**
  String get eisenhowerVoting;

  /// No description provided for @eisenhowerAllActivitiesVoted.
  ///
  /// In it, this message translates to:
  /// **'Tutte le attività sono state votate!'**
  String get eisenhowerAllActivitiesVoted;

  /// No description provided for @estimationTitle.
  ///
  /// In it, this message translates to:
  /// **'Estimation Room'**
  String get estimationTitle;

  /// No description provided for @estimationYourSessions.
  ///
  /// In it, this message translates to:
  /// **'Le tue sessioni'**
  String get estimationYourSessions;

  /// No description provided for @estimationNoSessions.
  ///
  /// In it, this message translates to:
  /// **'Nessuna sessione creata'**
  String get estimationNoSessions;

  /// No description provided for @estimationNewSession.
  ///
  /// In it, this message translates to:
  /// **'Nuova Sessione'**
  String get estimationNewSession;

  /// No description provided for @estimationEditSession.
  ///
  /// In it, this message translates to:
  /// **'Modifica Sessione'**
  String get estimationEditSession;

  /// No description provided for @estimationJoinSession.
  ///
  /// In it, this message translates to:
  /// **'Unisciti a sessione'**
  String get estimationJoinSession;

  /// No description provided for @estimationSessionCode.
  ///
  /// In it, this message translates to:
  /// **'Codice sessione'**
  String get estimationSessionCode;

  /// No description provided for @estimationEnterCode.
  ///
  /// In it, this message translates to:
  /// **'Inserisci codice'**
  String get estimationEnterCode;

  /// No description provided for @sessionStatusDraft.
  ///
  /// In it, this message translates to:
  /// **'Bozza'**
  String get sessionStatusDraft;

  /// No description provided for @sessionStatusActive.
  ///
  /// In it, this message translates to:
  /// **'Attiva'**
  String get sessionStatusActive;

  /// No description provided for @sessionStatusCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completata'**
  String get sessionStatusCompleted;

  /// No description provided for @sessionName.
  ///
  /// In it, this message translates to:
  /// **'Nome sessione'**
  String get sessionName;

  /// No description provided for @sessionNameRequired.
  ///
  /// In it, this message translates to:
  /// **'Nome Sessione *'**
  String get sessionNameRequired;

  /// No description provided for @sessionNameHint.
  ///
  /// In it, this message translates to:
  /// **'Es: Sprint 15 - Stima User Stories'**
  String get sessionNameHint;

  /// No description provided for @sessionDescription.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get sessionDescription;

  /// No description provided for @sessionCardSet.
  ///
  /// In it, this message translates to:
  /// **'Set di Carte'**
  String get sessionCardSet;

  /// No description provided for @cardSetFibonacci.
  ///
  /// In it, this message translates to:
  /// **'Fibonacci (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ?)'**
  String get cardSetFibonacci;

  /// No description provided for @cardSetSimplified.
  ///
  /// In it, this message translates to:
  /// **'Semplificato (1, 2, 3, 5, 8, 13, ?, ?)'**
  String get cardSetSimplified;

  /// No description provided for @sessionEstimationMode.
  ///
  /// In it, this message translates to:
  /// **'Modalita di Stima'**
  String get sessionEstimationMode;

  /// No description provided for @sessionEstimationModeLocked.
  ///
  /// In it, this message translates to:
  /// **'Non è possibile cambiare modalità dopo l\'avvio della votazione'**
  String get sessionEstimationModeLocked;

  /// No description provided for @sessionAutoReveal.
  ///
  /// In it, this message translates to:
  /// **'Auto-reveal'**
  String get sessionAutoReveal;

  /// No description provided for @sessionAutoRevealDesc.
  ///
  /// In it, this message translates to:
  /// **'Rivela quando tutti votano'**
  String get sessionAutoRevealDesc;

  /// No description provided for @sessionAllowObservers.
  ///
  /// In it, this message translates to:
  /// **'Osservatori'**
  String get sessionAllowObservers;

  /// No description provided for @sessionAllowObserversDesc.
  ///
  /// In it, this message translates to:
  /// **'Permetti partecipanti non votanti'**
  String get sessionAllowObserversDesc;

  /// No description provided for @sessionConfiguration.
  ///
  /// In it, this message translates to:
  /// **'Configurazione'**
  String get sessionConfiguration;

  /// No description provided for @voteConsensus.
  ///
  /// In it, this message translates to:
  /// **'Consenso raggiunto!'**
  String get voteConsensus;

  /// No description provided for @voteResults.
  ///
  /// In it, this message translates to:
  /// **'Risultati Votazione'**
  String get voteResults;

  /// No description provided for @voteRevote.
  ///
  /// In it, this message translates to:
  /// **'Rivota'**
  String get voteRevote;

  /// No description provided for @voteReveal.
  ///
  /// In it, this message translates to:
  /// **'Rivela'**
  String get voteReveal;

  /// No description provided for @voteHide.
  ///
  /// In it, this message translates to:
  /// **'Nascondi'**
  String get voteHide;

  /// No description provided for @voteAverage.
  ///
  /// In it, this message translates to:
  /// **'Media'**
  String get voteAverage;

  /// No description provided for @voteMedian.
  ///
  /// In it, this message translates to:
  /// **'Mediana'**
  String get voteMedian;

  /// No description provided for @voteMode.
  ///
  /// In it, this message translates to:
  /// **'Moda'**
  String get voteMode;

  /// No description provided for @voteVoters.
  ///
  /// In it, this message translates to:
  /// **'Votanti'**
  String get voteVoters;

  /// No description provided for @voteDistribution.
  ///
  /// In it, this message translates to:
  /// **'Distribuzione voti'**
  String get voteDistribution;

  /// No description provided for @voteFinalEstimate.
  ///
  /// In it, this message translates to:
  /// **'Stima finale'**
  String get voteFinalEstimate;

  /// No description provided for @voteSelectFinal.
  ///
  /// In it, this message translates to:
  /// **'Seleziona stima finale'**
  String get voteSelectFinal;

  /// No description provided for @voteAverageTooltip.
  ///
  /// In it, this message translates to:
  /// **'Media aritmetica dei voti numerici'**
  String get voteAverageTooltip;

  /// No description provided for @voteMedianTooltip.
  ///
  /// In it, this message translates to:
  /// **'Valore centrale quando i voti sono ordinati'**
  String get voteMedianTooltip;

  /// No description provided for @voteModeTooltip.
  ///
  /// In it, this message translates to:
  /// **'Voto più frequente (il valore scelto più volte)'**
  String get voteModeTooltip;

  /// No description provided for @voteVotersTooltip.
  ///
  /// In it, this message translates to:
  /// **'Numero totale di partecipanti che hanno votato'**
  String get voteVotersTooltip;

  /// No description provided for @voteWaiting.
  ///
  /// In it, this message translates to:
  /// **'In attesa di voti...'**
  String get voteWaiting;

  /// No description provided for @voteSubmitted.
  ///
  /// In it, this message translates to:
  /// **'Voto inviato'**
  String get voteSubmitted;

  /// No description provided for @voteNotSubmitted.
  ///
  /// In it, this message translates to:
  /// **'Non ha votato'**
  String get voteNotSubmitted;

  /// No description provided for @storyToEstimate.
  ///
  /// In it, this message translates to:
  /// **'Storia da stimare'**
  String get storyToEstimate;

  /// No description provided for @storyTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo storia'**
  String get storyTitle;

  /// No description provided for @storyDescription.
  ///
  /// In it, this message translates to:
  /// **'Descrizione storia'**
  String get storyDescription;

  /// No description provided for @storyAddNew.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi storia'**
  String get storyAddNew;

  /// No description provided for @storyNoStories.
  ///
  /// In it, this message translates to:
  /// **'Nessuna storia da stimare'**
  String get storyNoStories;

  /// No description provided for @storyComplete.
  ///
  /// In it, this message translates to:
  /// **'Storia completata'**
  String get storyComplete;

  /// No description provided for @storySkip.
  ///
  /// In it, this message translates to:
  /// **'Salta storia'**
  String get storySkip;

  /// No description provided for @estimationModeFibonacci.
  ///
  /// In it, this message translates to:
  /// **'Fibonacci'**
  String get estimationModeFibonacci;

  /// No description provided for @estimationModeTshirt.
  ///
  /// In it, this message translates to:
  /// **'Taglie T-Shirt'**
  String get estimationModeTshirt;

  /// No description provided for @estimationModeDecimal.
  ///
  /// In it, this message translates to:
  /// **'Decimale'**
  String get estimationModeDecimal;

  /// No description provided for @estimationModeThreePoint.
  ///
  /// In it, this message translates to:
  /// **'Three-Point (PERT)'**
  String get estimationModeThreePoint;

  /// No description provided for @estimationModeDotVoting.
  ///
  /// In it, this message translates to:
  /// **'Dot Voting'**
  String get estimationModeDotVoting;

  /// No description provided for @estimationModeBucketSystem.
  ///
  /// In it, this message translates to:
  /// **'Bucket System'**
  String get estimationModeBucketSystem;

  /// No description provided for @estimationModeFiveFingers.
  ///
  /// In it, this message translates to:
  /// **'Five Fingers'**
  String get estimationModeFiveFingers;

  /// No description provided for @estimationVotesRevealed.
  ///
  /// In it, this message translates to:
  /// **'Voti Rivelati'**
  String get estimationVotesRevealed;

  /// No description provided for @estimationVotingInProgress.
  ///
  /// In it, this message translates to:
  /// **'Votazione in Corso'**
  String get estimationVotingInProgress;

  /// No description provided for @estimationVotesCountFormatted.
  ///
  /// In it, this message translates to:
  /// **'{count}/{total} voti'**
  String estimationVotesCountFormatted(int count, int total);

  /// No description provided for @estimationConsensusReached.
  ///
  /// In it, this message translates to:
  /// **'Consenso raggiunto!'**
  String get estimationConsensusReached;

  /// No description provided for @estimationVotingResults.
  ///
  /// In it, this message translates to:
  /// **'Risultati Votazione'**
  String get estimationVotingResults;

  /// No description provided for @estimationRevote.
  ///
  /// In it, this message translates to:
  /// **'Rivota'**
  String get estimationRevote;

  /// No description provided for @estimationAverage.
  ///
  /// In it, this message translates to:
  /// **'Media'**
  String get estimationAverage;

  /// No description provided for @estimationAverageTooltip.
  ///
  /// In it, this message translates to:
  /// **'Media aritmetica dei voti numerici'**
  String get estimationAverageTooltip;

  /// No description provided for @estimationMedian.
  ///
  /// In it, this message translates to:
  /// **'Mediana'**
  String get estimationMedian;

  /// No description provided for @estimationMedianTooltip.
  ///
  /// In it, this message translates to:
  /// **'Valore centrale quando i voti sono ordinati'**
  String get estimationMedianTooltip;

  /// No description provided for @estimationMode.
  ///
  /// In it, this message translates to:
  /// **'Moda'**
  String get estimationMode;

  /// No description provided for @estimationModeTooltip.
  ///
  /// In it, this message translates to:
  /// **'Voto più frequente (il valore scelto più volte)'**
  String get estimationModeTooltip;

  /// No description provided for @estimationVoters.
  ///
  /// In it, this message translates to:
  /// **'Votanti'**
  String get estimationVoters;

  /// No description provided for @estimationVotersTooltip.
  ///
  /// In it, this message translates to:
  /// **'Numero totale di partecipanti che hanno votato'**
  String get estimationVotersTooltip;

  /// No description provided for @estimationVoteDistribution.
  ///
  /// In it, this message translates to:
  /// **'Distribuzione voti'**
  String get estimationVoteDistribution;

  /// No description provided for @estimationSelectFinalEstimate.
  ///
  /// In it, this message translates to:
  /// **'Seleziona stima finale'**
  String get estimationSelectFinalEstimate;

  /// No description provided for @estimationFinalEstimate.
  ///
  /// In it, this message translates to:
  /// **'Stima finale'**
  String get estimationFinalEstimate;

  /// No description provided for @eisenhowerChartTitle.
  ///
  /// In it, this message translates to:
  /// **'Distribuzione Attività'**
  String get eisenhowerChartTitle;

  /// No description provided for @quadrantLabelDo.
  ///
  /// In it, this message translates to:
  /// **'Q1 - FAI'**
  String get quadrantLabelDo;

  /// No description provided for @quadrantLabelPlan.
  ///
  /// In it, this message translates to:
  /// **'Q2 - PIANIFICA'**
  String get quadrantLabelPlan;

  /// No description provided for @quadrantLabelDelegate.
  ///
  /// In it, this message translates to:
  /// **'Q3 - DELEGA'**
  String get quadrantLabelDelegate;

  /// No description provided for @quadrantLabelEliminate.
  ///
  /// In it, this message translates to:
  /// **'Q4 - ELIMINA'**
  String get quadrantLabelEliminate;

  /// No description provided for @eisenhowerNoRatedActivities.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività votata'**
  String get eisenhowerNoRatedActivities;

  /// No description provided for @eisenhowerVoteToSeeChart.
  ///
  /// In it, this message translates to:
  /// **'Vota le attività per visualizzarle nel grafico'**
  String get eisenhowerVoteToSeeChart;

  /// No description provided for @eisenhowerChartCardTitle.
  ///
  /// In it, this message translates to:
  /// **'Grafico Distribuzione'**
  String get eisenhowerChartCardTitle;

  /// No description provided for @raciAddColumnTitle.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Colonna RACI'**
  String get raciAddColumnTitle;

  /// No description provided for @raciColumnType.
  ///
  /// In it, this message translates to:
  /// **'Tipo'**
  String get raciColumnType;

  /// No description provided for @raciTypePerson.
  ///
  /// In it, this message translates to:
  /// **'Persona (Partecipante)'**
  String get raciTypePerson;

  /// No description provided for @raciTypeCustom.
  ///
  /// In it, this message translates to:
  /// **'Personalizzato (Team/Altro)'**
  String get raciTypeCustom;

  /// No description provided for @raciSelectParticipant.
  ///
  /// In it, this message translates to:
  /// **'Seleziona partecipante'**
  String get raciSelectParticipant;

  /// No description provided for @raciColumnName.
  ///
  /// In it, this message translates to:
  /// **'Nome colonna'**
  String get raciColumnName;

  /// No description provided for @raciColumnNameHint.
  ///
  /// In it, this message translates to:
  /// **'Es.: Team Sviluppo'**
  String get raciColumnNameHint;

  /// No description provided for @raciDeleteColumnTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Colonna'**
  String get raciDeleteColumnTitle;

  /// No description provided for @raciDeleteColumnConfirm.
  ///
  /// In it, this message translates to:
  /// **'Vuoi eliminare la colonna \'{name}\'? Le assegnazioni relative verranno perse.'**
  String raciDeleteColumnConfirm(String name);

  /// No description provided for @estimationOnlineParticipants.
  ///
  /// In it, this message translates to:
  /// **'{online} di {total} partecipanti online'**
  String estimationOnlineParticipants(int online, int total);

  /// No description provided for @estimationNewStoryTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuova Story'**
  String get estimationNewStoryTitle;

  /// No description provided for @estimationStoryTitleLabel.
  ///
  /// In it, this message translates to:
  /// **'Titolo *'**
  String get estimationStoryTitleLabel;

  /// No description provided for @estimationStoryTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Es: US-123: Come utente voglio...'**
  String get estimationStoryTitleHint;

  /// No description provided for @estimationStoryDescriptionLabel.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get estimationStoryDescriptionLabel;

  /// No description provided for @estimationStoryDescriptionHint.
  ///
  /// In it, this message translates to:
  /// **'Criteri di accettazione, note...'**
  String get estimationStoryDescriptionHint;

  /// No description provided for @estimationEnterTitleAlert.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un titolo'**
  String get estimationEnterTitleAlert;

  /// No description provided for @estimationParticipantsHeader.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti'**
  String get estimationParticipantsHeader;

  /// No description provided for @estimationRoleFacilitator.
  ///
  /// In it, this message translates to:
  /// **'Facilitatore'**
  String get estimationRoleFacilitator;

  /// No description provided for @estimationRoleVoters.
  ///
  /// In it, this message translates to:
  /// **'Votanti'**
  String get estimationRoleVoters;

  /// No description provided for @estimationRoleObservers.
  ///
  /// In it, this message translates to:
  /// **'Osservatori'**
  String get estimationRoleObservers;

  /// No description provided for @estimationYouSuffix.
  ///
  /// In it, this message translates to:
  /// **'(tu)'**
  String get estimationYouSuffix;

  /// No description provided for @estimationDecimalTitle.
  ///
  /// In it, this message translates to:
  /// **'Stima Decimale'**
  String get estimationDecimalTitle;

  /// No description provided for @estimationDecimalHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci la tua stima in giorni (es: 1.5, 2.25)'**
  String get estimationDecimalHint;

  /// No description provided for @estimationQuickSelect.
  ///
  /// In it, this message translates to:
  /// **'Selezione rapida:'**
  String get estimationQuickSelect;

  /// No description provided for @estimationDaysSuffix.
  ///
  /// In it, this message translates to:
  /// **'giorni'**
  String get estimationDaysSuffix;

  /// No description provided for @estimationVoteValue.
  ///
  /// In it, this message translates to:
  /// **'Voto: {value} giorni'**
  String estimationVoteValue(String value);

  /// No description provided for @estimationEnterValueAlert.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un valore'**
  String get estimationEnterValueAlert;

  /// No description provided for @estimationInvalidValueAlert.
  ///
  /// In it, this message translates to:
  /// **'Valore non valido'**
  String get estimationInvalidValueAlert;

  /// No description provided for @estimationMinAlert.
  ///
  /// In it, this message translates to:
  /// **'Min: {value}'**
  String estimationMinAlert(double value);

  /// No description provided for @estimationMaxAlert.
  ///
  /// In it, this message translates to:
  /// **'Max: {value}'**
  String estimationMaxAlert(double value);

  /// No description provided for @retroTitle.
  ///
  /// In it, this message translates to:
  /// **'Le mie Retrospettive'**
  String get retroTitle;

  /// No description provided for @retroNoRetros.
  ///
  /// In it, this message translates to:
  /// **'Nessuna retrospettiva'**
  String get retroNoRetros;

  /// No description provided for @retroCreateNew.
  ///
  /// In it, this message translates to:
  /// **'Crea Nuova'**
  String get retroCreateNew;

  /// No description provided for @retroGuidance.
  ///
  /// In it, this message translates to:
  /// **'Guida alle Retrospettive'**
  String get retroGuidance;

  /// No description provided for @retroSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca retrospettiva...'**
  String get retroSearchHint;

  /// No description provided for @retroNoResults.
  ///
  /// In it, this message translates to:
  /// **'Nessun risultato per la ricerca'**
  String get retroNoResults;

  /// No description provided for @retroFilterAll.
  ///
  /// In it, this message translates to:
  /// **'Tutte'**
  String get retroFilterAll;

  /// No description provided for @retroFilterActive.
  ///
  /// In it, this message translates to:
  /// **'Active'**
  String get retroFilterActive;

  /// No description provided for @retroFilterCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completed'**
  String get retroFilterCompleted;

  /// No description provided for @retroFilterDraft.
  ///
  /// In it, this message translates to:
  /// **'Draft'**
  String get retroFilterDraft;

  /// No description provided for @retroDeleteTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Retrospettiva'**
  String get retroDeleteTitle;

  /// No description provided for @retroDeleteConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro?'**
  String retroDeleteConfirm(String title);

  /// No description provided for @retroDeleteSuccess.
  ///
  /// In it, this message translates to:
  /// **'Retrospettiva eliminata con successo'**
  String get retroDeleteSuccess;

  /// No description provided for @retroDeleteError.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'eliminazione: {error}'**
  String retroDeleteError(String error);

  /// No description provided for @retroDeleteConfirmAction.
  ///
  /// In it, this message translates to:
  /// **'Elimina definitivamente'**
  String get retroDeleteConfirmAction;

  /// No description provided for @retroNewRetroTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuova Retrospettiva'**
  String get retroNewRetroTitle;

  /// No description provided for @retroLinkToSprint.
  ///
  /// In it, this message translates to:
  /// **'Collega a Sprint?'**
  String get retroLinkToSprint;

  /// No description provided for @retroNoProjectFound.
  ///
  /// In it, this message translates to:
  /// **'Nessun progetto trovato.'**
  String get retroNoProjectFound;

  /// No description provided for @retroSelectProject.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Progetto'**
  String get retroSelectProject;

  /// No description provided for @retroSelectSprint.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Sprint'**
  String get retroSelectSprint;

  /// No description provided for @retroSprintLabel.
  ///
  /// In it, this message translates to:
  /// **'Sprint {number}: {name}'**
  String retroSprintLabel(int number, String name);

  /// No description provided for @retroSessionTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo Sessione'**
  String get retroSessionTitle;

  /// No description provided for @retroSessionTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Es: Weekly Sync, Project Review...'**
  String get retroSessionTitleHint;

  /// No description provided for @retroTemplateLabel.
  ///
  /// In it, this message translates to:
  /// **'Template'**
  String get retroTemplateLabel;

  /// No description provided for @retroVotesPerUser.
  ///
  /// In it, this message translates to:
  /// **'Voti per utente:'**
  String get retroVotesPerUser;

  /// No description provided for @retroActionClose.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get retroActionClose;

  /// No description provided for @retroActionCreate.
  ///
  /// In it, this message translates to:
  /// **'Crea'**
  String get retroActionCreate;

  /// No description provided for @retroStatusDraft.
  ///
  /// In it, this message translates to:
  /// **'Bozza'**
  String get retroStatusDraft;

  /// No description provided for @retroStatusActive.
  ///
  /// In it, this message translates to:
  /// **'In Corso'**
  String get retroStatusActive;

  /// No description provided for @retroStatusCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completata'**
  String get retroStatusCompleted;

  /// No description provided for @retroTemplateStartStopContinue.
  ///
  /// In it, this message translates to:
  /// **'Start, Stop, Continue'**
  String get retroTemplateStartStopContinue;

  /// No description provided for @retroTemplateSailboat.
  ///
  /// In it, this message translates to:
  /// **'Barca a Vela'**
  String get retroTemplateSailboat;

  /// No description provided for @retroTemplate4Ls.
  ///
  /// In it, this message translates to:
  /// **'4 Ls'**
  String get retroTemplate4Ls;

  /// No description provided for @retroTemplateStarfish.
  ///
  /// In it, this message translates to:
  /// **'Stella Marina'**
  String get retroTemplateStarfish;

  /// No description provided for @retroTemplateMadSadGlad.
  ///
  /// In it, this message translates to:
  /// **'Mad Sad Glad'**
  String get retroTemplateMadSadGlad;

  /// No description provided for @retroTemplateDAKI.
  ///
  /// In it, this message translates to:
  /// **'DAKI (Drop Add Keep Improve)'**
  String get retroTemplateDAKI;

  /// No description provided for @retroDescStartStopContinue.
  ///
  /// In it, this message translates to:
  /// **'Orientata all\'azione: Iniziare, Smettere, Continuare.'**
  String get retroDescStartStopContinue;

  /// No description provided for @retroDescSailboat.
  ///
  /// In it, this message translates to:
  /// **'Visiva: Vento (spinge), Ancore (frena), Rocce (rischi), Isola (obiettivi).'**
  String get retroDescSailboat;

  /// No description provided for @retroDesc4Ls.
  ///
  /// In it, this message translates to:
  /// **'Liked (Piaciuto), Learned (Imparato), Lacked (Mancato), Longed For (Desiderato).'**
  String get retroDesc4Ls;

  /// No description provided for @retroDescStarfish.
  ///
  /// In it, this message translates to:
  /// **'Keep, Stop, Start, More, Less.'**
  String get retroDescStarfish;

  /// No description provided for @retroDescMadSadGlad.
  ///
  /// In it, this message translates to:
  /// **'Emotiva: Arrabbiato, Triste, Felice.'**
  String get retroDescMadSadGlad;

  /// No description provided for @retroDescDAKI.
  ///
  /// In it, this message translates to:
  /// **'Pragmatica: Elimina, Aggiungi, Mantieni, Migliora.'**
  String get retroDescDAKI;

  /// No description provided for @retroUsageStartStopContinue.
  ///
  /// In it, this message translates to:
  /// **'Ideale per feedback azionabili e focus sui cambiamenti comportamentali.'**
  String get retroUsageStartStopContinue;

  /// No description provided for @retroUsageSailboat.
  ///
  /// In it, this message translates to:
  /// **'Ideale per visualizzare il viaggio del team, obiettivi e rischi. Ottima per il pensiero creativo.'**
  String get retroUsageSailboat;

  /// No description provided for @retroUsage4Ls.
  ///
  /// In it, this message translates to:
  /// **'Riflessiva: Ideale per imparare dal passato ed evidenziare aspetti emotivi e di apprendimento.'**
  String get retroUsage4Ls;

  /// No description provided for @retroUsageStarfish.
  ///
  /// In it, this message translates to:
  /// **'Calibrazione: Ideale per scalare gli sforzi (fare di più/meno), non solo stop/start binari.'**
  String get retroUsageStarfish;

  /// No description provided for @retroUsageMadSadGlad.
  ///
  /// In it, this message translates to:
  /// **'Ideale per check-in emotivi, risolvere conflitti o dopo uno sprint stressante.'**
  String get retroUsageMadSadGlad;

  /// No description provided for @retroUsageDAKI.
  ///
  /// In it, this message translates to:
  /// **'Decisiva: Ideale per fare pulizia. Focus su decisioni concrete di Eliminare o Aggiungere.'**
  String get retroUsageDAKI;

  /// No description provided for @retroIcebreakerSentiment.
  ///
  /// In it, this message translates to:
  /// **'Voto Sentiment'**
  String get retroIcebreakerSentiment;

  /// No description provided for @retroIcebreakerOneWord.
  ///
  /// In it, this message translates to:
  /// **'Una Parola'**
  String get retroIcebreakerOneWord;

  /// No description provided for @retroIcebreakerWeather.
  ///
  /// In it, this message translates to:
  /// **'Meteo'**
  String get retroIcebreakerWeather;

  /// No description provided for @retroIcebreakerSentimentDesc.
  ///
  /// In it, this message translates to:
  /// **'Vota da 1 a 5 come ti sei sentito durante lo sprint.'**
  String get retroIcebreakerSentimentDesc;

  /// No description provided for @retroIcebreakerOneWordDesc.
  ///
  /// In it, this message translates to:
  /// **'Descrivi lo sprint con una sola parola.'**
  String get retroIcebreakerOneWordDesc;

  /// No description provided for @retroIcebreakerWeatherDesc.
  ///
  /// In it, this message translates to:
  /// **'Scegli un\'icona meteo che rappresenta lo sprint.'**
  String get retroIcebreakerWeatherDesc;

  /// No description provided for @retroPhaseIcebreaker.
  ///
  /// In it, this message translates to:
  /// **'ICEBREAKER'**
  String get retroPhaseIcebreaker;

  /// No description provided for @retroPhaseWriting.
  ///
  /// In it, this message translates to:
  /// **'SCRITTURA'**
  String get retroPhaseWriting;

  /// No description provided for @retroPhaseVoting.
  ///
  /// In it, this message translates to:
  /// **'VOTAZIONE'**
  String get retroPhaseVoting;

  /// No description provided for @retroPhaseDiscuss.
  ///
  /// In it, this message translates to:
  /// **'DISCUSSIONE'**
  String get retroPhaseDiscuss;

  /// No description provided for @retroActionItemsLabel.
  ///
  /// In it, this message translates to:
  /// **'Action Items'**
  String get retroActionItemsLabel;

  /// No description provided for @retroActionDragToCreate.
  ///
  /// In it, this message translates to:
  /// **'Trascina qui una card per creare un Action Item collegato'**
  String get retroActionDragToCreate;

  /// No description provided for @retroNoActionItems.
  ///
  /// In it, this message translates to:
  /// **'Nessun Action Item ancora creato.'**
  String get retroNoActionItems;

  /// No description provided for @facilitatorGuideNextColumn.
  ///
  /// In it, this message translates to:
  /// **'Prossimo: Raccogli azione da'**
  String get facilitatorGuideNextColumn;

  /// No description provided for @collectionRationaleSSC.
  ///
  /// In it, this message translates to:
  /// **'Prima Stop per rimuovere bloccanti, poi Start nuove pratiche, infine Continue ciò che funziona.'**
  String get collectionRationaleSSC;

  /// No description provided for @collectionRationaleMSG.
  ///
  /// In it, this message translates to:
  /// **'Prima affrontare le frustrazioni, poi le delusioni, poi celebrare i successi.'**
  String get collectionRationaleMSG;

  /// No description provided for @collectionRationale4Ls.
  ///
  /// In it, this message translates to:
  /// **'Prima colmare le lacune, poi pianificare aspirazioni future, mantenere ciò che funziona, condividere apprendimenti.'**
  String get collectionRationale4Ls;

  /// No description provided for @collectionRationaleSailboat.
  ///
  /// In it, this message translates to:
  /// **'Prima mitigare i rischi, rimuovere bloccanti, poi sfruttare gli abilitatori e allinearsi agli obiettivi.'**
  String get collectionRationaleSailboat;

  /// No description provided for @collectionRationaleStarfish.
  ///
  /// In it, this message translates to:
  /// **'Fermare pratiche negative, ridurne altre, mantenere quelle buone, aumentare quelle di valore, iniziarne di nuove.'**
  String get collectionRationaleStarfish;

  /// No description provided for @collectionRationaleDAKI.
  ///
  /// In it, this message translates to:
  /// **'Drop per liberare capacità, Add nuove pratiche, Improve quelle esistenti, Keep ciò che funziona.'**
  String get collectionRationaleDAKI;

  /// No description provided for @missingSuggestionSSCStop.
  ///
  /// In it, this message translates to:
  /// **'Considera quale pratica sta bloccando il team e dovrebbe essere fermata.'**
  String get missingSuggestionSSCStop;

  /// No description provided for @missingSuggestionSSCStart.
  ///
  /// In it, this message translates to:
  /// **'Pensa a quale nuova pratica potrebbe aiutare il team a migliorare.'**
  String get missingSuggestionSSCStart;

  /// No description provided for @missingSuggestionMSGMad.
  ///
  /// In it, this message translates to:
  /// **'Affronta le frustrazioni del team - cosa sta causando rabbia?'**
  String get missingSuggestionMSGMad;

  /// No description provided for @missingSuggestionMSGSad.
  ///
  /// In it, this message translates to:
  /// **'Risolvi le delusioni - cosa ha reso triste il team?'**
  String get missingSuggestionMSGSad;

  /// No description provided for @missingSuggestion4LsLacked.
  ///
  /// In it, this message translates to:
  /// **'Cosa mancava di cui il team aveva bisogno?'**
  String get missingSuggestion4LsLacked;

  /// No description provided for @missingSuggestion4LsLonged.
  ///
  /// In it, this message translates to:
  /// **'Cosa desidera il team per il futuro?'**
  String get missingSuggestion4LsLonged;

  /// No description provided for @missingSuggestionSailboatAnchor.
  ///
  /// In it, this message translates to:
  /// **'Cosa sta trattenendo il team dal raggiungere gli obiettivi?'**
  String get missingSuggestionSailboatAnchor;

  /// No description provided for @missingSuggestionSailboatRock.
  ///
  /// In it, this message translates to:
  /// **'Quali rischi minacciano il progresso del team?'**
  String get missingSuggestionSailboatRock;

  /// No description provided for @missingSuggestionStarfishStop.
  ///
  /// In it, this message translates to:
  /// **'Quale pratica il team dovrebbe completamente smettere di fare?'**
  String get missingSuggestionStarfishStop;

  /// No description provided for @missingSuggestionStarfishStart.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova pratica il team dovrebbe iniziare?'**
  String get missingSuggestionStarfishStart;

  /// No description provided for @missingSuggestionDAKIDrop.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovrebbe il team decidere di eliminare?'**
  String get missingSuggestionDAKIDrop;

  /// No description provided for @missingSuggestionDAKIAdd.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova decisione dovrebbe prendere il team?'**
  String get missingSuggestionDAKIAdd;

  /// No description provided for @missingSuggestionGeneric.
  ///
  /// In it, this message translates to:
  /// **'Considera di creare un\'azione da questa colonna.'**
  String get missingSuggestionGeneric;

  /// No description provided for @facilitatorGuideAllCovered.
  ///
  /// In it, this message translates to:
  /// **'Tutte le colonne richieste coperte!'**
  String get facilitatorGuideAllCovered;

  /// No description provided for @facilitatorGuideMissing.
  ///
  /// In it, this message translates to:
  /// **'Mancano azioni per'**
  String get facilitatorGuideMissing;

  /// No description provided for @retroPhaseStart.
  ///
  /// In it, this message translates to:
  /// **'Inizia'**
  String get retroPhaseStart;

  /// No description provided for @retroPhaseStop.
  ///
  /// In it, this message translates to:
  /// **'Smetti'**
  String get retroPhaseStop;

  /// No description provided for @retroPhaseContinue.
  ///
  /// In it, this message translates to:
  /// **'Continua'**
  String get retroPhaseContinue;

  /// No description provided for @retroColumnMad.
  ///
  /// In it, this message translates to:
  /// **'Arrabbiato'**
  String get retroColumnMad;

  /// No description provided for @retroColumnSad.
  ///
  /// In it, this message translates to:
  /// **'Triste'**
  String get retroColumnSad;

  /// No description provided for @retroColumnGlad.
  ///
  /// In it, this message translates to:
  /// **'Felice'**
  String get retroColumnGlad;

  /// No description provided for @retroColumnLiked.
  ///
  /// In it, this message translates to:
  /// **'Piaciuto'**
  String get retroColumnLiked;

  /// No description provided for @retroColumnLearned.
  ///
  /// In it, this message translates to:
  /// **'Imparato'**
  String get retroColumnLearned;

  /// No description provided for @retroColumnLacked.
  ///
  /// In it, this message translates to:
  /// **'Mancato'**
  String get retroColumnLacked;

  /// No description provided for @retroColumnLonged.
  ///
  /// In it, this message translates to:
  /// **'Desiderato'**
  String get retroColumnLonged;

  /// No description provided for @retroColumnWind.
  ///
  /// In it, this message translates to:
  /// **'Vento'**
  String get retroColumnWind;

  /// No description provided for @retroColumnAnchor.
  ///
  /// In it, this message translates to:
  /// **'Ancore'**
  String get retroColumnAnchor;

  /// No description provided for @retroColumnRock.
  ///
  /// In it, this message translates to:
  /// **'Scogli'**
  String get retroColumnRock;

  /// No description provided for @retroColumnGoal.
  ///
  /// In it, this message translates to:
  /// **'Isola'**
  String get retroColumnGoal;

  /// No description provided for @retroColumnKeep.
  ///
  /// In it, this message translates to:
  /// **'Mantieni'**
  String get retroColumnKeep;

  /// No description provided for @retroColumnMore.
  ///
  /// In it, this message translates to:
  /// **'Di Più'**
  String get retroColumnMore;

  /// No description provided for @retroColumnLess.
  ///
  /// In it, this message translates to:
  /// **'Di Meno'**
  String get retroColumnLess;

  /// No description provided for @retroColumnDrop.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get retroColumnDrop;

  /// No description provided for @retroColumnAdd.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi'**
  String get retroColumnAdd;

  /// No description provided for @retroColumnImprove.
  ///
  /// In it, this message translates to:
  /// **'Migliora'**
  String get retroColumnImprove;

  /// No description provided for @settingsLanguage.
  ///
  /// In it, this message translates to:
  /// **'Lingua'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In it, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsThemeLight.
  ///
  /// In it, this message translates to:
  /// **'Chiaro'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In it, this message translates to:
  /// **'Scuro'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In it, this message translates to:
  /// **'Sistema'**
  String get settingsThemeSystem;

  /// No description provided for @formTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo'**
  String get formTitle;

  /// No description provided for @formDescription.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get formDescription;

  /// No description provided for @formName.
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get formName;

  /// No description provided for @formRequired.
  ///
  /// In it, this message translates to:
  /// **'Campo obbligatorio'**
  String get formRequired;

  /// No description provided for @formHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un valore'**
  String get formHint;

  /// No description provided for @formOptional.
  ///
  /// In it, this message translates to:
  /// **'Opzionale'**
  String get formOptional;

  /// No description provided for @errorGeneric.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String errorGeneric(String error);

  /// No description provided for @errorLoading.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento dati'**
  String get errorLoading;

  /// No description provided for @errorSaving.
  ///
  /// In it, this message translates to:
  /// **'Errore salvataggio'**
  String get errorSaving;

  /// No description provided for @errorNetwork.
  ///
  /// In it, this message translates to:
  /// **'Errore di connessione'**
  String get errorNetwork;

  /// No description provided for @errorPermission.
  ///
  /// In it, this message translates to:
  /// **'Permesso negato'**
  String get errorPermission;

  /// No description provided for @errorNotFound.
  ///
  /// In it, this message translates to:
  /// **'Non trovato'**
  String get errorNotFound;

  /// No description provided for @successSaved.
  ///
  /// In it, this message translates to:
  /// **'Salvato con successo'**
  String get successSaved;

  /// No description provided for @successDeleted.
  ///
  /// In it, this message translates to:
  /// **'Eliminato con successo'**
  String get successDeleted;

  /// No description provided for @successCopied.
  ///
  /// In it, this message translates to:
  /// **'Copiato negli appunti'**
  String get successCopied;

  /// No description provided for @filterAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get filterAll;

  /// No description provided for @filterRemove.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi filtri'**
  String get filterRemove;

  /// No description provided for @filterActive.
  ///
  /// In it, this message translates to:
  /// **'Attivi'**
  String get filterActive;

  /// No description provided for @filterCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completati'**
  String get filterCompleted;

  /// No description provided for @participants.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti'**
  String get participants;

  /// No description provided for @addParticipant.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi partecipante'**
  String get addParticipant;

  /// No description provided for @removeParticipant.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi partecipante'**
  String get removeParticipant;

  /// No description provided for @noParticipants.
  ///
  /// In it, this message translates to:
  /// **'Nessun partecipante'**
  String get noParticipants;

  /// No description provided for @participantJoined.
  ///
  /// In it, this message translates to:
  /// **'si e unito'**
  String get participantJoined;

  /// No description provided for @participantLeft.
  ///
  /// In it, this message translates to:
  /// **'ha lasciato'**
  String get participantLeft;

  /// No description provided for @participantRole.
  ///
  /// In it, this message translates to:
  /// **'Ruolo'**
  String get participantRole;

  /// No description provided for @participantVoter.
  ///
  /// In it, this message translates to:
  /// **'Votante'**
  String get participantVoter;

  /// No description provided for @participantObserver.
  ///
  /// In it, this message translates to:
  /// **'Osservatore'**
  String get participantObserver;

  /// No description provided for @participantModerator.
  ///
  /// In it, this message translates to:
  /// **'Moderatore'**
  String get participantModerator;

  /// No description provided for @confirmDelete.
  ///
  /// In it, this message translates to:
  /// **'Conferma eliminazione'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In it, this message translates to:
  /// **'Questa azione non puo essere annullata.'**
  String get confirmDeleteMessage;

  /// No description provided for @yes.
  ///
  /// In it, this message translates to:
  /// **'Si'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In it, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In it, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @today.
  ///
  /// In it, this message translates to:
  /// **'Oggi'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In it, this message translates to:
  /// **'Ieri'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In it, this message translates to:
  /// **'Domani'**
  String get tomorrow;

  /// No description provided for @daysAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} giorni fa'**
  String daysAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} ore fa'**
  String hoursAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} minuti fa'**
  String minutesAgo(int count);

  /// No description provided for @itemCount.
  ///
  /// In it, this message translates to:
  /// **'{count} elementi'**
  String itemCount(int count);

  /// No description provided for @welcomeBack.
  ///
  /// In it, this message translates to:
  /// **'Bentornato'**
  String get welcomeBack;

  /// No description provided for @greeting.
  ///
  /// In it, this message translates to:
  /// **'Ciao, {name}!'**
  String greeting(String name);

  /// No description provided for @copyLink.
  ///
  /// In it, this message translates to:
  /// **'Copia link'**
  String get copyLink;

  /// No description provided for @shareSession.
  ///
  /// In it, this message translates to:
  /// **'Condividi sessione'**
  String get shareSession;

  /// No description provided for @inviteByEmail.
  ///
  /// In it, this message translates to:
  /// **'Invita via email'**
  String get inviteByEmail;

  /// No description provided for @inviteByLink.
  ///
  /// In it, this message translates to:
  /// **'Invita via link'**
  String get inviteByLink;

  /// No description provided for @profileTitle.
  ///
  /// In it, this message translates to:
  /// **'Profilo'**
  String get profileTitle;

  /// No description provided for @profileEmail.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileDisplayName.
  ///
  /// In it, this message translates to:
  /// **'Nome visualizzato'**
  String get profileDisplayName;

  /// No description provided for @profilePhotoUrl.
  ///
  /// In it, this message translates to:
  /// **'Foto profilo'**
  String get profilePhotoUrl;

  /// No description provided for @profileEditProfile.
  ///
  /// In it, this message translates to:
  /// **'Modifica profilo'**
  String get profileEditProfile;

  /// No description provided for @profileReload.
  ///
  /// In it, this message translates to:
  /// **'Ricarica'**
  String get profileReload;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In it, this message translates to:
  /// **'Informazioni Personali'**
  String get profilePersonalInfo;

  /// No description provided for @profileLastName.
  ///
  /// In it, this message translates to:
  /// **'Cognome'**
  String get profileLastName;

  /// No description provided for @profileCompany.
  ///
  /// In it, this message translates to:
  /// **'Azienda'**
  String get profileCompany;

  /// No description provided for @profileJobTitle.
  ///
  /// In it, this message translates to:
  /// **'Ruolo'**
  String get profileJobTitle;

  /// No description provided for @profileBio.
  ///
  /// In it, this message translates to:
  /// **'Bio'**
  String get profileBio;

  /// No description provided for @profileSubscription.
  ///
  /// In it, this message translates to:
  /// **'Abbonamento'**
  String get profileSubscription;

  /// No description provided for @profilePlan.
  ///
  /// In it, this message translates to:
  /// **'Piano'**
  String get profilePlan;

  /// No description provided for @profileBillingCycle.
  ///
  /// In it, this message translates to:
  /// **'Ciclo di fatturazione'**
  String get profileBillingCycle;

  /// No description provided for @profilePrice.
  ///
  /// In it, this message translates to:
  /// **'Prezzo'**
  String get profilePrice;

  /// No description provided for @profileActivationDate.
  ///
  /// In it, this message translates to:
  /// **'Data attivazione'**
  String get profileActivationDate;

  /// No description provided for @profileTrialEnd.
  ///
  /// In it, this message translates to:
  /// **'Fine periodo di prova'**
  String get profileTrialEnd;

  /// No description provided for @profileNextRenewal.
  ///
  /// In it, this message translates to:
  /// **'Prossimo rinnovo'**
  String get profileNextRenewal;

  /// No description provided for @profileDaysRemaining.
  ///
  /// In it, this message translates to:
  /// **'Giorni rimanenti'**
  String get profileDaysRemaining;

  /// No description provided for @profileUpgrade.
  ///
  /// In it, this message translates to:
  /// **'Passa a Premium'**
  String get profileUpgrade;

  /// No description provided for @profileUpgradePlan.
  ///
  /// In it, this message translates to:
  /// **'Upgrade Piano'**
  String get profileUpgradePlan;

  /// No description provided for @planFree.
  ///
  /// In it, this message translates to:
  /// **'Gratuito'**
  String get planFree;

  /// No description provided for @planPremium.
  ///
  /// In it, this message translates to:
  /// **'Premium'**
  String get planPremium;

  /// No description provided for @planElite.
  ///
  /// In it, this message translates to:
  /// **'Elite'**
  String get planElite;

  /// No description provided for @statusActive.
  ///
  /// In it, this message translates to:
  /// **'Attivo'**
  String get statusActive;

  /// No description provided for @statusTrialing.
  ///
  /// In it, this message translates to:
  /// **'In prova'**
  String get statusTrialing;

  /// No description provided for @statusPastDue.
  ///
  /// In it, this message translates to:
  /// **'Pagamento scaduto'**
  String get statusPastDue;

  /// No description provided for @statusPaused.
  ///
  /// In it, this message translates to:
  /// **'In pausa'**
  String get statusPaused;

  /// No description provided for @statusCancelled.
  ///
  /// In it, this message translates to:
  /// **'Cancellato'**
  String get statusCancelled;

  /// No description provided for @statusExpired.
  ///
  /// In it, this message translates to:
  /// **'Scaduto'**
  String get statusExpired;

  /// No description provided for @cycleMonthly.
  ///
  /// In it, this message translates to:
  /// **'Mensile'**
  String get cycleMonthly;

  /// No description provided for @cycleQuarterly.
  ///
  /// In it, this message translates to:
  /// **'Trimestrale'**
  String get cycleQuarterly;

  /// No description provided for @cycleYearly.
  ///
  /// In it, this message translates to:
  /// **'Annuale'**
  String get cycleYearly;

  /// No description provided for @cycleLifetime.
  ///
  /// In it, this message translates to:
  /// **'Sempre'**
  String get cycleLifetime;

  /// No description provided for @pricePerMonth.
  ///
  /// In it, this message translates to:
  /// **'mese'**
  String get pricePerMonth;

  /// No description provided for @pricePerQuarter.
  ///
  /// In it, this message translates to:
  /// **'trim'**
  String get pricePerQuarter;

  /// No description provided for @pricePerYear.
  ///
  /// In it, this message translates to:
  /// **'anno'**
  String get pricePerYear;

  /// No description provided for @priceForever.
  ///
  /// In it, this message translates to:
  /// **'sempre'**
  String get priceForever;

  /// No description provided for @priceFree.
  ///
  /// In it, this message translates to:
  /// **'Gratuito'**
  String get priceFree;

  /// No description provided for @profileGeneralSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni Generali'**
  String get profileGeneralSettings;

  /// No description provided for @profileAnimations.
  ///
  /// In it, this message translates to:
  /// **'Animazioni'**
  String get profileAnimations;

  /// No description provided for @profileAnimationsDesc.
  ///
  /// In it, this message translates to:
  /// **'Abilita animazioni UI'**
  String get profileAnimationsDesc;

  /// No description provided for @profileFeatures.
  ///
  /// In it, this message translates to:
  /// **'Funzionalita'**
  String get profileFeatures;

  /// No description provided for @profileCalendarIntegration.
  ///
  /// In it, this message translates to:
  /// **'Integrazione Calendario'**
  String get profileCalendarIntegration;

  /// No description provided for @profileCalendarIntegrationDesc.
  ///
  /// In it, this message translates to:
  /// **'Sincronizza sprint e scadenze'**
  String get profileCalendarIntegrationDesc;

  /// No description provided for @profileExportSheets.
  ///
  /// In it, this message translates to:
  /// **'Export Google Sheets'**
  String get profileExportSheets;

  /// No description provided for @profileExportSheetsDesc.
  ///
  /// In it, this message translates to:
  /// **'Esporta dati in fogli di calcolo'**
  String get profileExportSheetsDesc;

  /// No description provided for @profileBetaFeatures.
  ///
  /// In it, this message translates to:
  /// **'Funzionalita Beta'**
  String get profileBetaFeatures;

  /// No description provided for @profileBetaFeaturesDesc.
  ///
  /// In it, this message translates to:
  /// **'Accesso anticipato a nuove funzionalita'**
  String get profileBetaFeaturesDesc;

  /// No description provided for @profileAdvancedMetrics.
  ///
  /// In it, this message translates to:
  /// **'Metriche Avanzate'**
  String get profileAdvancedMetrics;

  /// No description provided for @profileAdvancedMetricsDesc.
  ///
  /// In it, this message translates to:
  /// **'Statistiche e report dettagliati'**
  String get profileAdvancedMetricsDesc;

  /// No description provided for @profileNotifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche'**
  String get profileNotifications;

  /// No description provided for @profileEmailNotifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche Email'**
  String get profileEmailNotifications;

  /// No description provided for @profileEmailNotificationsDesc.
  ///
  /// In it, this message translates to:
  /// **'Ricevi aggiornamenti via email'**
  String get profileEmailNotificationsDesc;

  /// No description provided for @profilePushNotifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche Push'**
  String get profilePushNotifications;

  /// No description provided for @profilePushNotificationsDesc.
  ///
  /// In it, this message translates to:
  /// **'Notifiche nel browser'**
  String get profilePushNotificationsDesc;

  /// No description provided for @profileSprintReminders.
  ///
  /// In it, this message translates to:
  /// **'Promemoria Sprint'**
  String get profileSprintReminders;

  /// No description provided for @profileSprintRemindersDesc.
  ///
  /// In it, this message translates to:
  /// **'Avvisi per scadenze sprint'**
  String get profileSprintRemindersDesc;

  /// No description provided for @profileSessionInvites.
  ///
  /// In it, this message translates to:
  /// **'Inviti Sessioni'**
  String get profileSessionInvites;

  /// No description provided for @profileSessionInvitesDesc.
  ///
  /// In it, this message translates to:
  /// **'Notifiche per nuove sessioni'**
  String get profileSessionInvitesDesc;

  /// No description provided for @profileWeeklySummary.
  ///
  /// In it, this message translates to:
  /// **'Riepilogo Settimanale'**
  String get profileWeeklySummary;

  /// No description provided for @profileWeeklySummaryDesc.
  ///
  /// In it, this message translates to:
  /// **'Report settimanale delle attivita'**
  String get profileWeeklySummaryDesc;

  /// No description provided for @profileDangerZone.
  ///
  /// In it, this message translates to:
  /// **'Zona Pericolosa'**
  String get profileDangerZone;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In it, this message translates to:
  /// **'Elimina account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteAccountDesc.
  ///
  /// In it, this message translates to:
  /// **'Richiedi la cancellazione definitiva del tuo account e di tutti i dati associati'**
  String get profileDeleteAccountDesc;

  /// No description provided for @profileDeleteAccountRequest.
  ///
  /// In it, this message translates to:
  /// **'Richiedi'**
  String get profileDeleteAccountRequest;

  /// No description provided for @profileDeleteAccountIrreversible.
  ///
  /// In it, this message translates to:
  /// **'Questa azione e irreversibile. Tutti i tuoi dati verranno eliminati definitivamente.'**
  String get profileDeleteAccountIrreversible;

  /// No description provided for @profileDeleteAccountReason.
  ///
  /// In it, this message translates to:
  /// **'Motivo (opzionale)'**
  String get profileDeleteAccountReason;

  /// No description provided for @profileDeleteAccountReasonHint.
  ///
  /// In it, this message translates to:
  /// **'Perche vuoi eliminare il tuo account?'**
  String get profileDeleteAccountReasonHint;

  /// No description provided for @profileRequestDeletion.
  ///
  /// In it, this message translates to:
  /// **'Richiedi Eliminazione'**
  String get profileRequestDeletion;

  /// No description provided for @profileDeletionInProgress.
  ///
  /// In it, this message translates to:
  /// **'Cancellazione in corso'**
  String get profileDeletionInProgress;

  /// No description provided for @profileDeletionRequestedAt.
  ///
  /// In it, this message translates to:
  /// **'Richiesta il {date}'**
  String profileDeletionRequestedAt(String date);

  /// No description provided for @profileCancelRequest.
  ///
  /// In it, this message translates to:
  /// **'Annulla richiesta'**
  String get profileCancelRequest;

  /// No description provided for @profileDeletionRequestSent.
  ///
  /// In it, this message translates to:
  /// **'Richiesta di eliminazione inviata'**
  String get profileDeletionRequestSent;

  /// No description provided for @profileDeletionRequestCancelled.
  ///
  /// In it, this message translates to:
  /// **'Richiesta annullata'**
  String get profileDeletionRequestCancelled;

  /// No description provided for @profileUpdated.
  ///
  /// In it, this message translates to:
  /// **'Profilo aggiornato'**
  String get profileUpdated;

  /// No description provided for @profileLogout.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get profileLogout;

  /// No description provided for @profileLogoutDesc.
  ///
  /// In it, this message translates to:
  /// **'Disconnetti il tuo account da questo dispositivo'**
  String get profileLogoutDesc;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler uscire?'**
  String get profileLogoutConfirm;

  /// No description provided for @profileSubscriptionCancelled.
  ///
  /// In it, this message translates to:
  /// **'Abbonamento annullato'**
  String get profileSubscriptionCancelled;

  /// No description provided for @profileCancelSubscription.
  ///
  /// In it, this message translates to:
  /// **'Annulla Abbonamento'**
  String get profileCancelSubscription;

  /// No description provided for @profileCancelSubscriptionConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler annullare il tuo abbonamento? Potrai continuare a utilizzare le funzionalita premium fino alla scadenza del periodo corrente.'**
  String get profileCancelSubscriptionConfirm;

  /// No description provided for @profileKeepSubscription.
  ///
  /// In it, this message translates to:
  /// **'No, mantieni'**
  String get profileKeepSubscription;

  /// No description provided for @profileYesCancel.
  ///
  /// In it, this message translates to:
  /// **'Si, annulla'**
  String get profileYesCancel;

  /// No description provided for @profileUpgradeComingSoon.
  ///
  /// In it, this message translates to:
  /// **'Upgrade a {plan} in arrivo...'**
  String profileUpgradeComingSoon(String plan);

  /// No description provided for @profileFree.
  ///
  /// In it, this message translates to:
  /// **'Gratuito'**
  String get profileFree;

  /// No description provided for @profileMonthly.
  ///
  /// In it, this message translates to:
  /// **'EUR/mese'**
  String get profileMonthly;

  /// No description provided for @profileUser.
  ///
  /// In it, this message translates to:
  /// **'Utente'**
  String get profileUser;

  /// No description provided for @profileErrorPrefix.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String profileErrorPrefix(String error);

  /// No description provided for @stateSaving.
  ///
  /// In it, this message translates to:
  /// **'Salvataggio...'**
  String get stateSaving;

  /// No description provided for @cardCoffee.
  ///
  /// In it, this message translates to:
  /// **'Pausa'**
  String get cardCoffee;

  /// No description provided for @cardQuestion.
  ///
  /// In it, this message translates to:
  /// **'Non so'**
  String get cardQuestion;

  /// No description provided for @toolEisenhower.
  ///
  /// In it, this message translates to:
  /// **'Matrice Eisenhower'**
  String get toolEisenhower;

  /// No description provided for @toolEisenhowerDesc.
  ///
  /// In it, this message translates to:
  /// **'Organizza le attivita in base a urgenza e importanza. Quadranti per decidere cosa fare subito, pianificare, delegare o eliminare.'**
  String get toolEisenhowerDesc;

  /// No description provided for @toolEisenhowerDescShort.
  ///
  /// In it, this message translates to:
  /// **'Prioritizza per urgenza e importanza'**
  String get toolEisenhowerDescShort;

  /// No description provided for @toolEstimation.
  ///
  /// In it, this message translates to:
  /// **'Estimation Room'**
  String get toolEstimation;

  /// No description provided for @toolEstimationDesc.
  ///
  /// In it, this message translates to:
  /// **'Sessioni di stima collaborative per il team. Planning Poker, T-Shirt sizing e altri metodi per stimare user stories.'**
  String get toolEstimationDesc;

  /// No description provided for @toolEstimationDescShort.
  ///
  /// In it, this message translates to:
  /// **'Sessioni di stima collaborative'**
  String get toolEstimationDescShort;

  /// No description provided for @toolSmartTodo.
  ///
  /// In it, this message translates to:
  /// **'Smart Todo'**
  String get toolSmartTodo;

  /// No description provided for @toolSmartTodoDesc.
  ///
  /// In it, this message translates to:
  /// **'Liste intelligenti e collaborative. Importa da CSV/testo, invita partecipanti e gestisci task con filtri avanzati.'**
  String get toolSmartTodoDesc;

  /// No description provided for @toolSmartTodoDescShort.
  ///
  /// In it, this message translates to:
  /// **'Liste intelligenti e collaborative. Importa da CSV, invita e gestisci.'**
  String get toolSmartTodoDescShort;

  /// No description provided for @toolAgileProcess.
  ///
  /// In it, this message translates to:
  /// **'Agile Process Manager'**
  String get toolAgileProcess;

  /// No description provided for @toolAgileProcessDesc.
  ///
  /// In it, this message translates to:
  /// **'Gestisci progetti agili completi con backlog, sprint planning, kanban board, metriche e retrospettive.'**
  String get toolAgileProcessDesc;

  /// No description provided for @toolAgileProcessDescShort.
  ///
  /// In it, this message translates to:
  /// **'Gestisci progetti agili con backlog, sprint, kanban e metriche.'**
  String get toolAgileProcessDescShort;

  /// No description provided for @toolRetro.
  ///
  /// In it, this message translates to:
  /// **'Retrospective Board'**
  String get toolRetro;

  /// No description provided for @toolRetroDesc.
  ///
  /// In it, this message translates to:
  /// **'Raccogli feedback dal team su cosa e andato bene, cosa migliorare e le azioni da intraprendere.'**
  String get toolRetroDesc;

  /// No description provided for @toolRetroDescShort.
  ///
  /// In it, this message translates to:
  /// **'Raccogli feedback dal team su cosa e andato bene e cosa migliorare.'**
  String get toolRetroDescShort;

  /// No description provided for @homeUtilities.
  ///
  /// In it, this message translates to:
  /// **'Utilities'**
  String get homeUtilities;

  /// No description provided for @homeSelectTool.
  ///
  /// In it, this message translates to:
  /// **'Seleziona uno strumento per iniziare'**
  String get homeSelectTool;

  /// No description provided for @statusOnline.
  ///
  /// In it, this message translates to:
  /// **'Online'**
  String get statusOnline;

  /// No description provided for @comingSoon.
  ///
  /// In it, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @featureComingSoon.
  ///
  /// In it, this message translates to:
  /// **'Questa funzionalita sara disponibile presto!'**
  String get featureComingSoon;

  /// No description provided for @featureSmartImport.
  ///
  /// In it, this message translates to:
  /// **'Smart Import'**
  String get featureSmartImport;

  /// No description provided for @featureCollaboration.
  ///
  /// In it, this message translates to:
  /// **'Collaborazione'**
  String get featureCollaboration;

  /// No description provided for @featureFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri'**
  String get featureFilters;

  /// No description provided for @feature4Quadrants.
  ///
  /// In it, this message translates to:
  /// **'4 Quadranti'**
  String get feature4Quadrants;

  /// No description provided for @featureDragDrop.
  ///
  /// In it, this message translates to:
  /// **'Drag & Drop'**
  String get featureDragDrop;

  /// No description provided for @featureCollaborative.
  ///
  /// In it, this message translates to:
  /// **'Collaborativo'**
  String get featureCollaborative;

  /// No description provided for @featurePlanningPoker.
  ///
  /// In it, this message translates to:
  /// **'Planning Poker'**
  String get featurePlanningPoker;

  /// No description provided for @featureTshirtSize.
  ///
  /// In it, this message translates to:
  /// **'T-Shirt Size'**
  String get featureTshirtSize;

  /// No description provided for @featureRealtime.
  ///
  /// In it, this message translates to:
  /// **'Real-time'**
  String get featureRealtime;

  /// No description provided for @featureScrum.
  ///
  /// In it, this message translates to:
  /// **'Scrum'**
  String get featureScrum;

  /// No description provided for @featureKanban.
  ///
  /// In it, this message translates to:
  /// **'Kanban'**
  String get featureKanban;

  /// No description provided for @featureHybrid.
  ///
  /// In it, this message translates to:
  /// **'Hybrid'**
  String get featureHybrid;

  /// No description provided for @featureWentWell.
  ///
  /// In it, this message translates to:
  /// **'Went Well'**
  String get featureWentWell;

  /// No description provided for @featureToImprove.
  ///
  /// In it, this message translates to:
  /// **'To Improve'**
  String get featureToImprove;

  /// No description provided for @featureActions.
  ///
  /// In it, this message translates to:
  /// **'Actions'**
  String get featureActions;

  /// No description provided for @themeLightMode.
  ///
  /// In it, this message translates to:
  /// **'Tema Chiaro'**
  String get themeLightMode;

  /// No description provided for @themeDarkMode.
  ///
  /// In it, this message translates to:
  /// **'Tema Scuro'**
  String get themeDarkMode;

  /// No description provided for @estimationBackToSessions.
  ///
  /// In it, this message translates to:
  /// **'Torna alle sessioni'**
  String get estimationBackToSessions;

  /// No description provided for @estimationSessionSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni Sessione'**
  String get estimationSessionSettings;

  /// No description provided for @estimationList.
  ///
  /// In it, this message translates to:
  /// **'Lista'**
  String get estimationList;

  /// No description provided for @estimationSessionsCount.
  ///
  /// In it, this message translates to:
  /// **'Le tue sessioni ({filtered}/{total})'**
  String estimationSessionsCount(int filtered, int total);

  /// No description provided for @estimationNoSessionFound.
  ///
  /// In it, this message translates to:
  /// **'Nessuna sessione trovata'**
  String get estimationNoSessionFound;

  /// No description provided for @estimationCreateFirstSession.
  ///
  /// In it, this message translates to:
  /// **'Crea la tua prima sessione di stima\nper stimare le attivita con il team'**
  String get estimationCreateFirstSession;

  /// No description provided for @estimationStoriesTotal.
  ///
  /// In it, this message translates to:
  /// **'Stories totali'**
  String get estimationStoriesTotal;

  /// No description provided for @estimationStoriesCompleted.
  ///
  /// In it, this message translates to:
  /// **'Stories completate'**
  String get estimationStoriesCompleted;

  /// No description provided for @estimationParticipantsActive.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti attivi'**
  String get estimationParticipantsActive;

  /// No description provided for @estimationProgress.
  ///
  /// In it, this message translates to:
  /// **'Avanzamento: {completed}/{total} stories ({percent}%)'**
  String estimationProgress(int completed, int total, String percent);

  /// No description provided for @estimationStart.
  ///
  /// In it, this message translates to:
  /// **'Avvia'**
  String get estimationStart;

  /// No description provided for @estimationComplete.
  ///
  /// In it, this message translates to:
  /// **'Completa'**
  String get estimationComplete;

  /// No description provided for @estimationAllStoriesEstimated.
  ///
  /// In it, this message translates to:
  /// **'Tutte le stories sono state stimate!'**
  String get estimationAllStoriesEstimated;

  /// No description provided for @estimationNoVotingInProgress.
  ///
  /// In it, this message translates to:
  /// **'Nessuna votazione in corso'**
  String get estimationNoVotingInProgress;

  /// No description provided for @estimationCompletedLabel.
  ///
  /// In it, this message translates to:
  /// **'Completate: {completed}/{total} | Stima totale: {total_estimate} pt'**
  String estimationCompletedLabel(
    int completed,
    int total,
    String total_estimate,
  );

  /// No description provided for @estimationVoteStory.
  ///
  /// In it, this message translates to:
  /// **'Vota: {title}'**
  String estimationVoteStory(String title);

  /// No description provided for @estimationAddStoriesToStart.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi delle stories per iniziare'**
  String get estimationAddStoriesToStart;

  /// No description provided for @estimationInVoting.
  ///
  /// In it, this message translates to:
  /// **'IN VOTAZIONE'**
  String get estimationInVoting;

  /// No description provided for @estimationReveal.
  ///
  /// In it, this message translates to:
  /// **'Rivela'**
  String get estimationReveal;

  /// No description provided for @estimationSkip.
  ///
  /// In it, this message translates to:
  /// **'Salta'**
  String get estimationSkip;

  /// No description provided for @estimationStories.
  ///
  /// In it, this message translates to:
  /// **'Stories'**
  String get estimationStories;

  /// No description provided for @estimationAddStory.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Story'**
  String get estimationAddStory;

  /// No description provided for @estimationStartVoting.
  ///
  /// In it, this message translates to:
  /// **'Inizia votazione'**
  String get estimationStartVoting;

  /// No description provided for @estimationViewVotes.
  ///
  /// In it, this message translates to:
  /// **'Vedi voti'**
  String get estimationViewVotes;

  /// No description provided for @estimationViewDetail.
  ///
  /// In it, this message translates to:
  /// **'Vedi dettaglio'**
  String get estimationViewDetail;

  /// No description provided for @estimationFinalEstimateLabel.
  ///
  /// In it, this message translates to:
  /// **'Stima finale:'**
  String get estimationFinalEstimateLabel;

  /// No description provided for @estimationVotesOf.
  ///
  /// In it, this message translates to:
  /// **'Voti: {title}'**
  String estimationVotesOf(String title);

  /// No description provided for @estimationParticipantVotes.
  ///
  /// In it, this message translates to:
  /// **'Voti dei partecipanti:'**
  String get estimationParticipantVotes;

  /// No description provided for @estimationPointsOrDays.
  ///
  /// In it, this message translates to:
  /// **'punti / giorni'**
  String get estimationPointsOrDays;

  /// No description provided for @estimationEstimateRationale.
  ///
  /// In it, this message translates to:
  /// **'Motivazione della stima (opzionale)'**
  String get estimationEstimateRationale;

  /// No description provided for @estimationExplainRationale.
  ///
  /// In it, this message translates to:
  /// **'Spiega il razionale della stima...\nEs: Complessita tecnica elevata, dipendenze esterne...'**
  String get estimationExplainRationale;

  /// No description provided for @estimationRationaleHelp.
  ///
  /// In it, this message translates to:
  /// **'La motivazione aiuta il team a ricordare le decisioni prese durante la stima.'**
  String get estimationRationaleHelp;

  /// No description provided for @estimationConfirmFinalEstimate.
  ///
  /// In it, this message translates to:
  /// **'Conferma Stima Finale'**
  String get estimationConfirmFinalEstimate;

  /// No description provided for @estimationEnterValidEstimate.
  ///
  /// In it, this message translates to:
  /// **'Inserisci una stima valida'**
  String get estimationEnterValidEstimate;

  /// No description provided for @estimationHintEstimate.
  ///
  /// In it, this message translates to:
  /// **'Es: 5, 8, 13...'**
  String get estimationHintEstimate;

  /// No description provided for @estimationStatus.
  ///
  /// In it, this message translates to:
  /// **'Stato'**
  String get estimationStatus;

  /// No description provided for @estimationOrder.
  ///
  /// In it, this message translates to:
  /// **'Ordine'**
  String get estimationOrder;

  /// No description provided for @estimationVotesReceived.
  ///
  /// In it, this message translates to:
  /// **'Voti ricevuti'**
  String get estimationVotesReceived;

  /// No description provided for @estimationAverageVotes.
  ///
  /// In it, this message translates to:
  /// **'Media voti'**
  String get estimationAverageVotes;

  /// No description provided for @estimationConsensus.
  ///
  /// In it, this message translates to:
  /// **'Consenso'**
  String get estimationConsensus;

  /// No description provided for @storyStatusPending.
  ///
  /// In it, this message translates to:
  /// **'In attesa'**
  String get storyStatusPending;

  /// No description provided for @storyStatusVoting.
  ///
  /// In it, this message translates to:
  /// **'In votazione'**
  String get storyStatusVoting;

  /// No description provided for @storyStatusRevealed.
  ///
  /// In it, this message translates to:
  /// **'Voti rivelati'**
  String get storyStatusRevealed;

  /// No description provided for @participantManagement.
  ///
  /// In it, this message translates to:
  /// **'Gestione Partecipanti'**
  String get participantManagement;

  /// No description provided for @participantCopySessionLink.
  ///
  /// In it, this message translates to:
  /// **'Copia link sessione'**
  String get participantCopySessionLink;

  /// No description provided for @participantInvitesTab.
  ///
  /// In it, this message translates to:
  /// **'Inviti'**
  String get participantInvitesTab;

  /// No description provided for @participantSessionLink.
  ///
  /// In it, this message translates to:
  /// **'Link Sessione (condividi con i partecipanti)'**
  String get participantSessionLink;

  /// No description provided for @participantAddDirect.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Partecipante Diretto (es. voto palese)'**
  String get participantAddDirect;

  /// No description provided for @participantEmailRequired.
  ///
  /// In it, this message translates to:
  /// **'Email *'**
  String get participantEmailRequired;

  /// No description provided for @participantEmailHint.
  ///
  /// In it, this message translates to:
  /// **'email@esempio.com'**
  String get participantEmailHint;

  /// No description provided for @participantNameHint.
  ///
  /// In it, this message translates to:
  /// **'Nome visualizzato'**
  String get participantNameHint;

  /// No description provided for @participantVotersAndObservers.
  ///
  /// In it, this message translates to:
  /// **'{voters} votanti, {observers} osservatori'**
  String participantVotersAndObservers(int voters, int observers);

  /// No description provided for @participantYou.
  ///
  /// In it, this message translates to:
  /// **'(tu)'**
  String get participantYou;

  /// No description provided for @participantMakeVoter.
  ///
  /// In it, this message translates to:
  /// **'Rendi Votante'**
  String get participantMakeVoter;

  /// No description provided for @participantMakeObserver.
  ///
  /// In it, this message translates to:
  /// **'Rendi Osservatore'**
  String get participantMakeObserver;

  /// No description provided for @participantRemoveTitle.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi Partecipante'**
  String get participantRemoveTitle;

  /// No description provided for @participantRemoveConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler rimuovere \"{name}\" dalla sessione?'**
  String participantRemoveConfirm(String name);

  /// No description provided for @participantAddedToSession.
  ///
  /// In it, this message translates to:
  /// **'{email} aggiunto alla sessione'**
  String participantAddedToSession(String email);

  /// No description provided for @participantRemovedFromSession.
  ///
  /// In it, this message translates to:
  /// **'{name} rimosso dalla sessione'**
  String participantRemovedFromSession(String name);

  /// No description provided for @participantRoleUpdated.
  ///
  /// In it, this message translates to:
  /// **'Ruolo aggiornato per {email}'**
  String participantRoleUpdated(String email);

  /// No description provided for @participantFacilitator.
  ///
  /// In it, this message translates to:
  /// **'Facilitatore'**
  String get participantFacilitator;

  /// No description provided for @inviteSendNew.
  ///
  /// In it, this message translates to:
  /// **'Invia Nuovo Invito'**
  String get inviteSendNew;

  /// No description provided for @inviteRecipientEmail.
  ///
  /// In it, this message translates to:
  /// **'Email destinatario *'**
  String get inviteRecipientEmail;

  /// No description provided for @inviteCreate.
  ///
  /// In it, this message translates to:
  /// **'Crea Invito'**
  String get inviteCreate;

  /// No description provided for @invitesSent.
  ///
  /// In it, this message translates to:
  /// **'Inviti Inviati'**
  String get invitesSent;

  /// No description provided for @inviteNoInvites.
  ///
  /// In it, this message translates to:
  /// **'Nessun invito inviato'**
  String get inviteNoInvites;

  /// No description provided for @inviteCreatedFor.
  ///
  /// In it, this message translates to:
  /// **'Invito creato per {email}'**
  String inviteCreatedFor(String email);

  /// No description provided for @inviteSentTo.
  ///
  /// In it, this message translates to:
  /// **'Invito inviato via email a {email}'**
  String inviteSentTo(String email);

  /// No description provided for @inviteExpiresIn.
  ///
  /// In it, this message translates to:
  /// **'Scade tra {days}g'**
  String inviteExpiresIn(int days);

  /// No description provided for @inviteCopyLink.
  ///
  /// In it, this message translates to:
  /// **'Copia link'**
  String get inviteCopyLink;

  /// No description provided for @inviteRevokeAction.
  ///
  /// In it, this message translates to:
  /// **'Revoca invito'**
  String get inviteRevokeAction;

  /// No description provided for @inviteDeleteAction.
  ///
  /// In it, this message translates to:
  /// **'Elimina invito'**
  String get inviteDeleteAction;

  /// No description provided for @inviteRevokeTitle.
  ///
  /// In it, this message translates to:
  /// **'Revocare invito?'**
  String get inviteRevokeTitle;

  /// No description provided for @inviteRevokeConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler revocare l\'invito per {email}?'**
  String inviteRevokeConfirm(String email);

  /// No description provided for @inviteRevoke.
  ///
  /// In it, this message translates to:
  /// **'Revoca'**
  String get inviteRevoke;

  /// No description provided for @inviteRevokedFor.
  ///
  /// In it, this message translates to:
  /// **'Invito revocato per {email}'**
  String inviteRevokedFor(String email);

  /// No description provided for @inviteDeleteTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Invito'**
  String get inviteDeleteTitle;

  /// No description provided for @inviteDeleteConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare l\'invito per {email}?\n\nQuesta azione e irreversibile.'**
  String inviteDeleteConfirm(String email);

  /// No description provided for @inviteDeletedFor.
  ///
  /// In it, this message translates to:
  /// **'Invito eliminato per {email}'**
  String inviteDeletedFor(String email);

  /// No description provided for @inviteLinkCopied.
  ///
  /// In it, this message translates to:
  /// **'Link copiato!'**
  String get inviteLinkCopied;

  /// No description provided for @linkCopied.
  ///
  /// In it, this message translates to:
  /// **'Link copiato negli appunti'**
  String get linkCopied;

  /// No description provided for @enterValidEmail.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un indirizzo email valido'**
  String get enterValidEmail;

  /// No description provided for @sessionCreatedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Sessione creata con successo'**
  String get sessionCreatedSuccess;

  /// No description provided for @sessionUpdated.
  ///
  /// In it, this message translates to:
  /// **'Sessione aggiornata'**
  String get sessionUpdated;

  /// No description provided for @sessionDeleted.
  ///
  /// In it, this message translates to:
  /// **'Sessione eliminata'**
  String get sessionDeleted;

  /// No description provided for @sessionStarted.
  ///
  /// In it, this message translates to:
  /// **'Sessione avviata'**
  String get sessionStarted;

  /// No description provided for @sessionCompletedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Sessione completata'**
  String get sessionCompletedSuccess;

  /// No description provided for @sessionNotFound.
  ///
  /// In it, this message translates to:
  /// **'Sessione non trovata'**
  String get sessionNotFound;

  /// No description provided for @storyAdded.
  ///
  /// In it, this message translates to:
  /// **'Story aggiunta'**
  String get storyAdded;

  /// No description provided for @storyDeleted.
  ///
  /// In it, this message translates to:
  /// **'Story eliminata'**
  String get storyDeleted;

  /// No description provided for @estimateSaved.
  ///
  /// In it, this message translates to:
  /// **'Stima salvata: {estimate}'**
  String estimateSaved(String estimate);

  /// No description provided for @deleteSessionTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Sessione'**
  String get deleteSessionTitle;

  /// No description provided for @deleteSessionConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare \"{name}\"?\nVerranno eliminate anche tutte le {count} stories.'**
  String deleteSessionConfirm(String name, int count);

  /// No description provided for @deleteStoryTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Story'**
  String get deleteStoryTitle;

  /// No description provided for @deleteStoryConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare \"{title}\"?'**
  String deleteStoryConfirm(String title);

  /// No description provided for @errorLoadingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento sessione'**
  String get errorLoadingSession;

  /// No description provided for @errorLoadingStories.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento stories'**
  String get errorLoadingStories;

  /// No description provided for @errorCreatingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore creazione sessione'**
  String get errorCreatingSession;

  /// No description provided for @errorUpdatingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore aggiornamento'**
  String get errorUpdatingSession;

  /// No description provided for @errorDeletingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore eliminazione'**
  String get errorDeletingSession;

  /// No description provided for @errorAddingStory.
  ///
  /// In it, this message translates to:
  /// **'Errore aggiunta story'**
  String get errorAddingStory;

  /// No description provided for @errorStartingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore avvio sessione'**
  String get errorStartingSession;

  /// No description provided for @errorCompletingSession.
  ///
  /// In it, this message translates to:
  /// **'Errore completamento sessione'**
  String get errorCompletingSession;

  /// No description provided for @errorSubmittingVote.
  ///
  /// In it, this message translates to:
  /// **'Errore invio voto'**
  String get errorSubmittingVote;

  /// No description provided for @errorRevealingVotes.
  ///
  /// In it, this message translates to:
  /// **'Errore reveal'**
  String get errorRevealingVotes;

  /// No description provided for @errorSavingEstimate.
  ///
  /// In it, this message translates to:
  /// **'Errore salvataggio stima'**
  String get errorSavingEstimate;

  /// No description provided for @errorSkipping.
  ///
  /// In it, this message translates to:
  /// **'Errore skip'**
  String get errorSkipping;

  /// No description provided for @retroIcebreakerTitle.
  ///
  /// In it, this message translates to:
  /// **'Icebreaker: Morale del Team'**
  String get retroIcebreakerTitle;

  /// No description provided for @retroIcebreakerQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come ti sei sentito riguardo a questo sprint?'**
  String get retroIcebreakerQuestion;

  /// No description provided for @retroParticipantsVoted.
  ///
  /// In it, this message translates to:
  /// **'{count} partecipanti hanno votato'**
  String retroParticipantsVoted(int count);

  /// No description provided for @retroEndIcebreakerStartWriting.
  ///
  /// In it, this message translates to:
  /// **'Termina Icebreaker & Inizia Scrittura'**
  String get retroEndIcebreakerStartWriting;

  /// No description provided for @retroMoodTerrible.
  ///
  /// In it, this message translates to:
  /// **'Terribile'**
  String get retroMoodTerrible;

  /// No description provided for @retroMoodBad.
  ///
  /// In it, this message translates to:
  /// **'Male'**
  String get retroMoodBad;

  /// No description provided for @retroMoodNeutral.
  ///
  /// In it, this message translates to:
  /// **'Neutro'**
  String get retroMoodNeutral;

  /// No description provided for @retroMoodGood.
  ///
  /// In it, this message translates to:
  /// **'Bene'**
  String get retroMoodGood;

  /// No description provided for @retroMoodExcellent.
  ///
  /// In it, this message translates to:
  /// **'Eccellente'**
  String get retroMoodExcellent;

  /// No description provided for @actionSubmit.
  ///
  /// In it, this message translates to:
  /// **'Invia'**
  String get actionSubmit;

  /// No description provided for @retroIcebreakerOneWordTitle.
  ///
  /// In it, this message translates to:
  /// **'Icebreaker: Una Parola'**
  String get retroIcebreakerOneWordTitle;

  /// No description provided for @retroIcebreakerOneWordQuestion.
  ///
  /// In it, this message translates to:
  /// **'Descrivi questo sprint con UNA sola parola'**
  String get retroIcebreakerOneWordQuestion;

  /// No description provided for @retroIcebreakerOneWordHint.
  ///
  /// In it, this message translates to:
  /// **'La tua parola...'**
  String get retroIcebreakerOneWordHint;

  /// No description provided for @retroIcebreakerSubmitted.
  ///
  /// In it, this message translates to:
  /// **'Inviato!'**
  String get retroIcebreakerSubmitted;

  /// No description provided for @retroIcebreakerWordsSubmitted.
  ///
  /// In it, this message translates to:
  /// **'{count} parole inviate'**
  String retroIcebreakerWordsSubmitted(int count);

  /// No description provided for @retroIcebreakerWeatherTitle.
  ///
  /// In it, this message translates to:
  /// **'Icebreaker: Meteo'**
  String get retroIcebreakerWeatherTitle;

  /// No description provided for @retroIcebreakerWeatherQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale meteo rappresenta meglio come ti senti riguardo a questo sprint?'**
  String get retroIcebreakerWeatherQuestion;

  /// No description provided for @retroWeatherSunny.
  ///
  /// In it, this message translates to:
  /// **'Soleggiato'**
  String get retroWeatherSunny;

  /// No description provided for @retroWeatherPartlyCloudy.
  ///
  /// In it, this message translates to:
  /// **'Parz. nuvoloso'**
  String get retroWeatherPartlyCloudy;

  /// No description provided for @retroWeatherCloudy.
  ///
  /// In it, this message translates to:
  /// **'Nuvoloso'**
  String get retroWeatherCloudy;

  /// No description provided for @retroWeatherRainy.
  ///
  /// In it, this message translates to:
  /// **'Piovoso'**
  String get retroWeatherRainy;

  /// No description provided for @retroWeatherStormy.
  ///
  /// In it, this message translates to:
  /// **'Tempestoso'**
  String get retroWeatherStormy;

  /// No description provided for @retroAgileCoach.
  ///
  /// In it, this message translates to:
  /// **'Agile Coach'**
  String get retroAgileCoach;

  /// No description provided for @retroCoachSetup.
  ///
  /// In it, this message translates to:
  /// **'Scegliete un template. \"Start/Stop/Continue\" e ottimo per i nuovi team. Assicuratevi che tutti siano presenti.'**
  String get retroCoachSetup;

  /// No description provided for @retroCoachIcebreaker.
  ///
  /// In it, this message translates to:
  /// **'Rompete il ghiaccio! Fate un giro veloce chiedendo \"Come state?\" o usando una domanda divertente.'**
  String get retroCoachIcebreaker;

  /// No description provided for @retroCoachWriting.
  ///
  /// In it, this message translates to:
  /// **'Siamo in modalita INCOGNITO. Scrivete le card liberamente, nessuno vedra cosa scrivete fino alla fine. Evitate bias!'**
  String get retroCoachWriting;

  /// No description provided for @retroCoachVoting.
  ///
  /// In it, this message translates to:
  /// **'Review Time! Tutte le card sono visibili. Leggetele e usate i vostri 3 voti per decidere di cosa discutere.'**
  String get retroCoachVoting;

  /// No description provided for @retroCoachDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Focus sulle card piu votate. Definite Action Item chiari: Chi fa cosa entro quando?'**
  String get retroCoachDiscuss;

  /// No description provided for @retroCoachCompleted.
  ///
  /// In it, this message translates to:
  /// **'Ottimo lavoro! La retrospettiva e conclusa. Gli Action Item sono stati inviati al Backlog.'**
  String get retroCoachCompleted;

  /// No description provided for @retroStep.
  ///
  /// In it, this message translates to:
  /// **'Step {step}: {title}'**
  String retroStep(int step, String title);

  /// No description provided for @retroCurrentFocus.
  ///
  /// In it, this message translates to:
  /// **'Focus attuale: {title}'**
  String retroCurrentFocus(String title);

  /// No description provided for @retroCanvasMinColumns.
  ///
  /// In it, this message translates to:
  /// **'Il template richiede almeno 4 colonne (stile Sailboat)'**
  String get retroCanvasMinColumns;

  /// No description provided for @retroAddTo.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi a {title}'**
  String retroAddTo(String title);

  /// No description provided for @retroNoColumnsConfigured.
  ///
  /// In it, this message translates to:
  /// **'Nessuna colonna configurata.'**
  String get retroNoColumnsConfigured;

  /// No description provided for @retroNewActionItem.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Action Item'**
  String get retroNewActionItem;

  /// No description provided for @retroEditActionItem.
  ///
  /// In it, this message translates to:
  /// **'Modifica Action Item'**
  String get retroEditActionItem;

  /// No description provided for @retroActionWhatToDo.
  ///
  /// In it, this message translates to:
  /// **'Cosa bisogna fare?'**
  String get retroActionWhatToDo;

  /// No description provided for @retroActionDescriptionHint.
  ///
  /// In it, this message translates to:
  /// **'Descrivi l\'azione concreta...'**
  String get retroActionDescriptionHint;

  /// No description provided for @retroActionRequired.
  ///
  /// In it, this message translates to:
  /// **'Richiesto'**
  String get retroActionRequired;

  /// No description provided for @retroActionLinkedCard.
  ///
  /// In it, this message translates to:
  /// **'Collegato a Retro Card (Opzionale)'**
  String get retroActionLinkedCard;

  /// No description provided for @retroActionNone.
  ///
  /// In it, this message translates to:
  /// **'Nessuna'**
  String get retroActionNone;

  /// No description provided for @retroActionType.
  ///
  /// In it, this message translates to:
  /// **'Tipo Azione'**
  String get retroActionType;

  /// No description provided for @retroActionNoType.
  ///
  /// In it, this message translates to:
  /// **'Nessun tipo specifico'**
  String get retroActionNoType;

  /// No description provided for @retroActionAssignee.
  ///
  /// In it, this message translates to:
  /// **'Assegnatario'**
  String get retroActionAssignee;

  /// No description provided for @retroActionNoAssignee.
  ///
  /// In it, this message translates to:
  /// **'Nessuno'**
  String get retroActionNoAssignee;

  /// No description provided for @retroActionPriority.
  ///
  /// In it, this message translates to:
  /// **'Priorita'**
  String get retroActionPriority;

  /// No description provided for @retroActionDueDate.
  ///
  /// In it, this message translates to:
  /// **'Scadenza (Deadline)'**
  String get retroActionDueDate;

  /// No description provided for @retroActionSelectDate.
  ///
  /// In it, this message translates to:
  /// **'Seleziona data...'**
  String get retroActionSelectDate;

  /// No description provided for @retroActionSupportResources.
  ///
  /// In it, this message translates to:
  /// **'Risorse di Supporto'**
  String get retroActionSupportResources;

  /// No description provided for @retroActionResourcesHint.
  ///
  /// In it, this message translates to:
  /// **'Tool, budget, persone extra necessarie...'**
  String get retroActionResourcesHint;

  /// No description provided for @retroActionMonitoring.
  ///
  /// In it, this message translates to:
  /// **'Modalita di Monitoraggio'**
  String get retroActionMonitoring;

  /// No description provided for @retroActionMonitoringHint.
  ///
  /// In it, this message translates to:
  /// **'Come verificheremo il progresso? (es. Daily, Review...)'**
  String get retroActionMonitoringHint;

  /// No description provided for @retroActionResourcesShort.
  ///
  /// In it, this message translates to:
  /// **'Res'**
  String get retroActionResourcesShort;

  /// No description provided for @retroTableRef.
  ///
  /// In it, this message translates to:
  /// **'Rif.'**
  String get retroTableRef;

  /// No description provided for @retroTableSourceColumn.
  ///
  /// In it, this message translates to:
  /// **'Colonna'**
  String get retroTableSourceColumn;

  /// No description provided for @retroTableDescription.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get retroTableDescription;

  /// No description provided for @retroTableOwner.
  ///
  /// In it, this message translates to:
  /// **'Owner'**
  String get retroTableOwner;

  /// No description provided for @retroIcebreakerTwoTruths.
  ///
  /// In it, this message translates to:
  /// **'Due Verità e una Bugia'**
  String get retroIcebreakerTwoTruths;

  /// No description provided for @retroDescTwoTruths.
  ///
  /// In it, this message translates to:
  /// **'Semplice e classico.'**
  String get retroDescTwoTruths;

  /// No description provided for @retroIcebreakerCheckin.
  ///
  /// In it, this message translates to:
  /// **'Check-in Emotivo'**
  String get retroIcebreakerCheckin;

  /// No description provided for @retroDescCheckin.
  ///
  /// In it, this message translates to:
  /// **'Come si sentono tutti?'**
  String get retroDescCheckin;

  /// No description provided for @retroTableActions.
  ///
  /// In it, this message translates to:
  /// **'Azioni'**
  String get retroTableActions;

  /// No description provided for @retroSupportResources.
  ///
  /// In it, this message translates to:
  /// **'Risorse di Supporto'**
  String get retroSupportResources;

  /// No description provided for @retroMonitoringMethod.
  ///
  /// In it, this message translates to:
  /// **'Metodo di Monitoraggio'**
  String get retroMonitoringMethod;

  /// No description provided for @retroUnassigned.
  ///
  /// In it, this message translates to:
  /// **'Non assegnato'**
  String get retroUnassigned;

  /// No description provided for @retroDeleteActionItem.
  ///
  /// In it, this message translates to:
  /// **'Elimina Action Item'**
  String get retroDeleteActionItem;

  /// No description provided for @retroChooseMethodology.
  ///
  /// In it, this message translates to:
  /// **'Scegli Metodologia'**
  String get retroChooseMethodology;

  /// No description provided for @retroHidingWhileTyping.
  ///
  /// In it, this message translates to:
  /// **'Nascosto durante la scrittura...'**
  String get retroHidingWhileTyping;

  /// No description provided for @retroVoteLimitReached.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite di {max} voti!'**
  String retroVoteLimitReached(int max);

  /// No description provided for @retroAddCardHint.
  ///
  /// In it, this message translates to:
  /// **'Quali sono i tuoi pensieri?'**
  String get retroAddCardHint;

  /// No description provided for @retroAddCard.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Card'**
  String get retroAddCard;

  /// No description provided for @retroTimeUp.
  ///
  /// In it, this message translates to:
  /// **'Tempo Scaduto!'**
  String get retroTimeUp;

  /// No description provided for @retroTimeUpMessage.
  ///
  /// In it, this message translates to:
  /// **'Il tempo per questa fase e terminato. Concludi la discussione o estendi il tempo.'**
  String get retroTimeUpMessage;

  /// No description provided for @retroTimeUpOk.
  ///
  /// In it, this message translates to:
  /// **'Ok, ho capito'**
  String get retroTimeUpOk;

  /// No description provided for @retroStopTimer.
  ///
  /// In it, this message translates to:
  /// **'Ferma Timer'**
  String get retroStopTimer;

  /// No description provided for @retroStartTimer.
  ///
  /// In it, this message translates to:
  /// **'Avvia Timer'**
  String get retroStartTimer;

  /// No description provided for @retroTimerMinutes.
  ///
  /// In it, this message translates to:
  /// **'{minutes} Min'**
  String retroTimerMinutes(int minutes);

  /// No description provided for @retroAddCardButton.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Card'**
  String get retroAddCardButton;

  /// No description provided for @retroNoRetrosFound.
  ///
  /// In it, this message translates to:
  /// **'Nessuna retrospettiva trovata'**
  String get retroNoRetrosFound;

  /// No description provided for @retroDeleteRetro.
  ///
  /// In it, this message translates to:
  /// **'Elimina Retrospettiva'**
  String get retroDeleteRetro;

  /// No description provided for @retroParticipantsLabel.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti'**
  String get retroParticipantsLabel;

  /// No description provided for @retroNotesCreated.
  ///
  /// In it, this message translates to:
  /// **'Note create'**
  String get retroNotesCreated;

  /// No description provided for @retroStatusLabel.
  ///
  /// In it, this message translates to:
  /// **'Stato: {status}'**
  String retroStatusLabel(String status);

  /// No description provided for @retroDateLabel.
  ///
  /// In it, this message translates to:
  /// **'Data: {date}'**
  String retroDateLabel(String date);

  /// No description provided for @retroSprintDefault.
  ///
  /// In it, this message translates to:
  /// **'Sprint {number}'**
  String retroSprintDefault(int number);

  /// No description provided for @smartTodoNoTasks.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attivita in questa lista'**
  String get smartTodoNoTasks;

  /// No description provided for @smartTodoNoTasksInColumn.
  ///
  /// In it, this message translates to:
  /// **'Nessun task'**
  String get smartTodoNoTasksInColumn;

  /// No description provided for @smartTodoCompletionStats.
  ///
  /// In it, this message translates to:
  /// **'{completed}/{total} completate'**
  String smartTodoCompletionStats(int completed, int total);

  /// No description provided for @smartTodoCreatedDate.
  ///
  /// In it, this message translates to:
  /// **'Data creazione'**
  String get smartTodoCreatedDate;

  /// No description provided for @smartTodoParticipantRole.
  ///
  /// In it, this message translates to:
  /// **'Partecipante'**
  String get smartTodoParticipantRole;

  /// No description provided for @smartTodoUnassigned.
  ///
  /// In it, this message translates to:
  /// **'Non Assegnati'**
  String get smartTodoUnassigned;

  /// No description provided for @smartTodoNewTask.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Task'**
  String get smartTodoNewTask;

  /// No description provided for @smartTodoEditTask.
  ///
  /// In it, this message translates to:
  /// **'Modifica Task'**
  String get smartTodoEditTask;

  /// No description provided for @smartTodoTaskTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo task'**
  String get smartTodoTaskTitle;

  /// No description provided for @smartTodoDescription.
  ///
  /// In it, this message translates to:
  /// **'DESCRIZIONE'**
  String get smartTodoDescription;

  /// No description provided for @smartTodoDescriptionHint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi una descrizione dettagliata...'**
  String get smartTodoDescriptionHint;

  /// No description provided for @smartTodoChecklist.
  ///
  /// In it, this message translates to:
  /// **'CHECKLIST'**
  String get smartTodoChecklist;

  /// No description provided for @smartTodoAddChecklistItem.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi voce'**
  String get smartTodoAddChecklistItem;

  /// No description provided for @smartTodoAttachments.
  ///
  /// In it, this message translates to:
  /// **'ALLEGATI'**
  String get smartTodoAttachments;

  /// No description provided for @smartTodoAddLink.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Link'**
  String get smartTodoAddLink;

  /// No description provided for @smartTodoComments.
  ///
  /// In it, this message translates to:
  /// **'COMMENTI'**
  String get smartTodoComments;

  /// No description provided for @smartTodoWriteComment.
  ///
  /// In it, this message translates to:
  /// **'Scrivi un commento...'**
  String get smartTodoWriteComment;

  /// No description provided for @smartTodoAddImageTooltip.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Immagine (URL)'**
  String get smartTodoAddImageTooltip;

  /// No description provided for @smartTodoStatus.
  ///
  /// In it, this message translates to:
  /// **'STATO'**
  String get smartTodoStatus;

  /// No description provided for @smartTodoPriority.
  ///
  /// In it, this message translates to:
  /// **'PRIORITÀ'**
  String get smartTodoPriority;

  /// No description provided for @smartTodoAssignees.
  ///
  /// In it, this message translates to:
  /// **'ASSEGNATARI'**
  String get smartTodoAssignees;

  /// No description provided for @smartTodoNoAssignee.
  ///
  /// In it, this message translates to:
  /// **'Nessuno'**
  String get smartTodoNoAssignee;

  /// No description provided for @smartTodoTags.
  ///
  /// In it, this message translates to:
  /// **'TAGS'**
  String get smartTodoTags;

  /// No description provided for @smartTodoNoTags.
  ///
  /// In it, this message translates to:
  /// **'Nessun tag'**
  String get smartTodoNoTags;

  /// No description provided for @smartTodoDueDate.
  ///
  /// In it, this message translates to:
  /// **'SCADENZA'**
  String get smartTodoDueDate;

  /// No description provided for @smartTodoSetDate.
  ///
  /// In it, this message translates to:
  /// **'Imposta data'**
  String get smartTodoSetDate;

  /// No description provided for @smartTodoEffort.
  ///
  /// In it, this message translates to:
  /// **'EFFORT'**
  String get smartTodoEffort;

  /// No description provided for @smartTodoEffortHint.
  ///
  /// In it, this message translates to:
  /// **'Punti (es. 5)'**
  String get smartTodoEffortHint;

  /// No description provided for @smartTodoAssignTo.
  ///
  /// In it, this message translates to:
  /// **'Assegna a'**
  String get smartTodoAssignTo;

  /// No description provided for @smartTodoSelectTags.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Tags'**
  String get smartTodoSelectTags;

  /// No description provided for @smartTodoNoTagsAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessun tag disponibile'**
  String get smartTodoNoTagsAvailable;

  /// No description provided for @smartTodoNewSubtask.
  ///
  /// In it, this message translates to:
  /// **'Nuovo stato'**
  String get smartTodoNewSubtask;

  /// No description provided for @smartTodoAddLinkTitle.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Link'**
  String get smartTodoAddLinkTitle;

  /// No description provided for @smartTodoLinkName.
  ///
  /// In it, this message translates to:
  /// **'Nome'**
  String get smartTodoLinkName;

  /// No description provided for @smartTodoLinkUrl.
  ///
  /// In it, this message translates to:
  /// **'URL'**
  String get smartTodoLinkUrl;

  /// No description provided for @smartTodoCannotOpenLink.
  ///
  /// In it, this message translates to:
  /// **'Impossibile aprire il link'**
  String get smartTodoCannotOpenLink;

  /// No description provided for @smartTodoPasteImage.
  ///
  /// In it, this message translates to:
  /// **'Incolla Immagine'**
  String get smartTodoPasteImage;

  /// No description provided for @smartTodoPasteImageFound.
  ///
  /// In it, this message translates to:
  /// **'Immagine dagli appunti trovata.'**
  String get smartTodoPasteImageFound;

  /// No description provided for @smartTodoPasteImageConfirm.
  ///
  /// In it, this message translates to:
  /// **'Vuoi aggiungere questa immagine dai tuoi appunti?'**
  String get smartTodoPasteImageConfirm;

  /// No description provided for @smartTodoYesAdd.
  ///
  /// In it, this message translates to:
  /// **'Si, aggiungi'**
  String get smartTodoYesAdd;

  /// No description provided for @smartTodoAddImage.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Immagine'**
  String get smartTodoAddImage;

  /// No description provided for @smartTodoImageUrlHint.
  ///
  /// In it, this message translates to:
  /// **'Incolla l\'URL dell\'immagine (es. catturato con CleanShot/Gyazo)'**
  String get smartTodoImageUrlHint;

  /// No description provided for @smartTodoImageUrl.
  ///
  /// In it, this message translates to:
  /// **'URL Immagine'**
  String get smartTodoImageUrl;

  /// No description provided for @smartTodoPasteFromClipboard.
  ///
  /// In it, this message translates to:
  /// **'Incolla da Appunti'**
  String get smartTodoPasteFromClipboard;

  /// No description provided for @smartTodoEditComment.
  ///
  /// In it, this message translates to:
  /// **'Modifica'**
  String get smartTodoEditComment;

  /// No description provided for @smartTodoSortBy.
  ///
  /// In it, this message translates to:
  /// **'Ordinamento'**
  String get smartTodoSortBy;

  /// No description provided for @smartTodoSortDate.
  ///
  /// In it, this message translates to:
  /// **'Recenti'**
  String get smartTodoSortDate;

  /// No description provided for @smartTodoSortManual.
  ///
  /// In it, this message translates to:
  /// **'Manuale'**
  String get smartTodoSortManual;

  /// No description provided for @smartTodoColumnSortTitle.
  ///
  /// In it, this message translates to:
  /// **'Ordina Colonna'**
  String get smartTodoColumnSortTitle;

  /// No description provided for @smartTodoPendingTasks.
  ///
  /// In it, this message translates to:
  /// **'Attivita da completare'**
  String get smartTodoPendingTasks;

  /// No description provided for @smartTodoCompletedTasks.
  ///
  /// In it, this message translates to:
  /// **'Attivita completate'**
  String get smartTodoCompletedTasks;

  /// No description provided for @smartTodoEnterTitle.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un titolo'**
  String get smartTodoEnterTitle;

  /// No description provided for @smartTodoUser.
  ///
  /// In it, this message translates to:
  /// **'Utente'**
  String get smartTodoUser;

  /// No description provided for @smartTodoImportTasks.
  ///
  /// In it, this message translates to:
  /// **'Importa Attivita'**
  String get smartTodoImportTasks;

  /// No description provided for @smartTodoImportStep1.
  ///
  /// In it, this message translates to:
  /// **'Step 1: Scegli la Sorgente'**
  String get smartTodoImportStep1;

  /// No description provided for @smartTodoImportStep2.
  ///
  /// In it, this message translates to:
  /// **'Step 2: Mappa le Colonne'**
  String get smartTodoImportStep2;

  /// No description provided for @smartTodoImportStep3.
  ///
  /// In it, this message translates to:
  /// **'Step 3: Revisione & Conferma'**
  String get smartTodoImportStep3;

  /// No description provided for @smartTodoImportRetry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get smartTodoImportRetry;

  /// No description provided for @smartTodoImportPasteText.
  ///
  /// In it, this message translates to:
  /// **'Incolla Testo (CSV/Txt)'**
  String get smartTodoImportPasteText;

  /// No description provided for @smartTodoImportUploadFile.
  ///
  /// In it, this message translates to:
  /// **'Carica File (CSV)'**
  String get smartTodoImportUploadFile;

  /// No description provided for @smartTodoImportPasteHint.
  ///
  /// In it, this message translates to:
  /// **'Incolla qui i tuoi task. Usa la virgola come separatore.'**
  String get smartTodoImportPasteHint;

  /// No description provided for @smartTodoImportPasteExample.
  ///
  /// In it, this message translates to:
  /// **'es. Comprare il latte\nChiamare Mario\nFinire il report'**
  String get smartTodoImportPasteExample;

  /// No description provided for @smartTodoImportSelectFile.
  ///
  /// In it, this message translates to:
  /// **'Seleziona File CSV'**
  String get smartTodoImportSelectFile;

  /// No description provided for @smartTodoImportFileSelected.
  ///
  /// In it, this message translates to:
  /// **'File selezionato: {fileName}'**
  String smartTodoImportFileSelected(String fileName);

  /// No description provided for @smartTodoImportFileError.
  ///
  /// In it, this message translates to:
  /// **'Errore lettura file: {error}'**
  String smartTodoImportFileError(String error);

  /// No description provided for @smartTodoImportNoData.
  ///
  /// In it, this message translates to:
  /// **'Nessun dato trovato'**
  String get smartTodoImportNoData;

  /// No description provided for @smartTodoImportColumnMapping.
  ///
  /// In it, this message translates to:
  /// **'Abbiamo rilevato queste colonne. Associa ogni colonna al campo corretto.'**
  String get smartTodoImportColumnMapping;

  /// No description provided for @smartTodoImportColumnLabel.
  ///
  /// In it, this message translates to:
  /// **'Colonna {index}: \"{value}\"'**
  String smartTodoImportColumnLabel(int index, String value);

  /// No description provided for @smartTodoImportSampleValue.
  ///
  /// In it, this message translates to:
  /// **'Esempio valore: \"{value}\"'**
  String smartTodoImportSampleValue(String value);

  /// No description provided for @smartTodoImportFoundTasks.
  ///
  /// In it, this message translates to:
  /// **'Trovati {count} task validi. Controlla prima di importare.'**
  String smartTodoImportFoundTasks(int count);

  /// No description provided for @smartTodoImportDestinationColumn.
  ///
  /// In it, this message translates to:
  /// **'Destinazione:'**
  String get smartTodoImportDestinationColumn;

  /// No description provided for @smartTodoImportBack.
  ///
  /// In it, this message translates to:
  /// **'Indietro'**
  String get smartTodoImportBack;

  /// No description provided for @smartTodoImportNext.
  ///
  /// In it, this message translates to:
  /// **'Avanti'**
  String get smartTodoImportNext;

  /// No description provided for @smartTodoImportButton.
  ///
  /// In it, this message translates to:
  /// **'Importa {count} Task'**
  String smartTodoImportButton(int count);

  /// No description provided for @smartTodoImportEnterText.
  ///
  /// In it, this message translates to:
  /// **'Inserisci del testo o carica un file.'**
  String get smartTodoImportEnterText;

  /// No description provided for @smartTodoImportNoValidRows.
  ///
  /// In it, this message translates to:
  /// **'Nessuna riga valida trovata.'**
  String get smartTodoImportNoValidRows;

  /// No description provided for @smartTodoImportMapTitle.
  ///
  /// In it, this message translates to:
  /// **'Devi mappare almeno il \"Title\".'**
  String get smartTodoImportMapTitle;

  /// No description provided for @smartTodoImportParsingError.
  ///
  /// In it, this message translates to:
  /// **'Errore Parsing: {error}'**
  String smartTodoImportParsingError(String error);

  /// No description provided for @smartTodoImportSuccess.
  ///
  /// In it, this message translates to:
  /// **'Importati {count} task!'**
  String smartTodoImportSuccess(int count);

  /// No description provided for @smartTodoImportError.
  ///
  /// In it, this message translates to:
  /// **'Errore Impossibile: {error}'**
  String smartTodoImportError(String error);

  /// No description provided for @smartTodoImportHelpTitle.
  ///
  /// In it, this message translates to:
  /// **'Come importare le attività?'**
  String get smartTodoImportHelpTitle;

  /// No description provided for @smartTodoImportHelpSimpleTitle.
  ///
  /// In it, this message translates to:
  /// **'Lista semplice (un\'attività per riga)'**
  String get smartTodoImportHelpSimpleTitle;

  /// No description provided for @smartTodoImportHelpSimpleDesc.
  ///
  /// In it, this message translates to:
  /// **'Incolla una lista semplice con un titolo per riga. Ogni riga diventa un\'attività.'**
  String get smartTodoImportHelpSimpleDesc;

  /// No description provided for @smartTodoImportHelpSimpleExample.
  ///
  /// In it, this message translates to:
  /// **'Comprare il latte\nChiamare Mario\nFinire il report'**
  String get smartTodoImportHelpSimpleExample;

  /// No description provided for @smartTodoImportHelpCsvTitle.
  ///
  /// In it, this message translates to:
  /// **'Formato CSV (con colonne)'**
  String get smartTodoImportHelpCsvTitle;

  /// No description provided for @smartTodoImportHelpCsvDesc.
  ///
  /// In it, this message translates to:
  /// **'Usa valori separati da virgola con una riga di intestazione. La prima riga definisce le colonne.'**
  String get smartTodoImportHelpCsvDesc;

  /// No description provided for @smartTodoImportHelpCsvExample.
  ///
  /// In it, this message translates to:
  /// **'title,priority,assignee\nComprare latte,high,mario@email.com\nChiamare Mario,medium,'**
  String get smartTodoImportHelpCsvExample;

  /// No description provided for @smartTodoImportHelpFieldsTitle.
  ///
  /// In it, this message translates to:
  /// **'Campi disponibili:'**
  String get smartTodoImportHelpFieldsTitle;

  /// No description provided for @smartTodoImportHelpFieldTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo attività (obbligatorio)'**
  String get smartTodoImportHelpFieldTitle;

  /// No description provided for @smartTodoImportHelpFieldDesc.
  ///
  /// In it, this message translates to:
  /// **'Descrizione attività'**
  String get smartTodoImportHelpFieldDesc;

  /// No description provided for @smartTodoImportHelpFieldPriority.
  ///
  /// In it, this message translates to:
  /// **'high, medium, low (oppure alta, media, bassa)'**
  String get smartTodoImportHelpFieldPriority;

  /// No description provided for @smartTodoImportHelpFieldStatus.
  ///
  /// In it, this message translates to:
  /// **'Nome colonna (es. Da fare, In corso)'**
  String get smartTodoImportHelpFieldStatus;

  /// No description provided for @smartTodoImportHelpFieldAssignee.
  ///
  /// In it, this message translates to:
  /// **'Email utente'**
  String get smartTodoImportHelpFieldAssignee;

  /// No description provided for @smartTodoImportHelpFieldEffort.
  ///
  /// In it, this message translates to:
  /// **'Ore (numero)'**
  String get smartTodoImportHelpFieldEffort;

  /// No description provided for @smartTodoImportHelpFieldTags.
  ///
  /// In it, this message translates to:
  /// **'Tag (#tag o separati da virgola)'**
  String get smartTodoImportHelpFieldTags;

  /// No description provided for @smartTodoImportStatusHint.
  ///
  /// In it, this message translates to:
  /// **'Colonne disponibili per STATUS: {columns}'**
  String smartTodoImportStatusHint(String columns);

  /// No description provided for @smartTodoImportEmptyColumn.
  ///
  /// In it, this message translates to:
  /// **'(colonna vuota)'**
  String get smartTodoImportEmptyColumn;

  /// No description provided for @smartTodoImportFieldIgnore.
  ///
  /// In it, this message translates to:
  /// **'-- Ignora --'**
  String get smartTodoImportFieldIgnore;

  /// No description provided for @smartTodoImportFieldTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo'**
  String get smartTodoImportFieldTitle;

  /// No description provided for @smartTodoImportFieldDescription.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get smartTodoImportFieldDescription;

  /// No description provided for @smartTodoImportFieldPriority.
  ///
  /// In it, this message translates to:
  /// **'Priorità'**
  String get smartTodoImportFieldPriority;

  /// No description provided for @smartTodoImportFieldStatus.
  ///
  /// In it, this message translates to:
  /// **'Stato (Colonna)'**
  String get smartTodoImportFieldStatus;

  /// No description provided for @smartTodoImportFieldAssignee.
  ///
  /// In it, this message translates to:
  /// **'Assegnatario'**
  String get smartTodoImportFieldAssignee;

  /// No description provided for @smartTodoImportFieldEffort.
  ///
  /// In it, this message translates to:
  /// **'Effort'**
  String get smartTodoImportFieldEffort;

  /// No description provided for @smartTodoImportFieldTags.
  ///
  /// In it, this message translates to:
  /// **'Tag'**
  String get smartTodoImportFieldTags;

  /// No description provided for @smartTodoDeleteTaskTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Attività'**
  String get smartTodoDeleteTaskTitle;

  /// No description provided for @smartTodoDeleteTaskContent.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare questa attività? Questa azione non può essere annullata.'**
  String get smartTodoDeleteTaskContent;

  /// No description provided for @smartTodoDeleteNoPermission.
  ///
  /// In it, this message translates to:
  /// **'Non hai i permessi per eliminare questa attività'**
  String get smartTodoDeleteNoPermission;

  /// No description provided for @smartTodoSheetsExportTitle.
  ///
  /// In it, this message translates to:
  /// **'Export Google Sheets'**
  String get smartTodoSheetsExportTitle;

  /// No description provided for @smartTodoSheetsExportExists.
  ///
  /// In it, this message translates to:
  /// **'Esiste già un documento Google Sheets per questa lista.'**
  String get smartTodoSheetsExportExists;

  /// No description provided for @smartTodoSheetsOpen.
  ///
  /// In it, this message translates to:
  /// **'Apri'**
  String get smartTodoSheetsOpen;

  /// No description provided for @smartTodoSheetsUpdate.
  ///
  /// In it, this message translates to:
  /// **'Aggiorna'**
  String get smartTodoSheetsUpdate;

  /// No description provided for @smartTodoSheetsUpdating.
  ///
  /// In it, this message translates to:
  /// **'Aggiornamento Google Sheets in corso...'**
  String get smartTodoSheetsUpdating;

  /// No description provided for @smartTodoSheetsCreating.
  ///
  /// In it, this message translates to:
  /// **'Creazione Google Sheets in corso...'**
  String get smartTodoSheetsCreating;

  /// No description provided for @smartTodoSheetsUpdated.
  ///
  /// In it, this message translates to:
  /// **'Google Sheets aggiornato!'**
  String get smartTodoSheetsUpdated;

  /// No description provided for @smartTodoSheetsCreated.
  ///
  /// In it, this message translates to:
  /// **'Google Sheets creato!'**
  String get smartTodoSheetsCreated;

  /// No description provided for @smartTodoSheetsError.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'export (vedi log)'**
  String get smartTodoSheetsError;

  /// No description provided for @error.
  ///
  /// In it, this message translates to:
  /// **'Errore'**
  String get error;

  /// No description provided for @smartTodoAuditLogTitle.
  ///
  /// In it, this message translates to:
  /// **'Audit Log - {title}'**
  String smartTodoAuditLogTitle(String title);

  /// No description provided for @smartTodoAuditFilterUser.
  ///
  /// In it, this message translates to:
  /// **'Utente'**
  String get smartTodoAuditFilterUser;

  /// No description provided for @smartTodoAuditFilterType.
  ///
  /// In it, this message translates to:
  /// **'Tipo'**
  String get smartTodoAuditFilterType;

  /// No description provided for @smartTodoAuditFilterAction.
  ///
  /// In it, this message translates to:
  /// **'Azione'**
  String get smartTodoAuditFilterAction;

  /// No description provided for @smartTodoAuditFilterTag.
  ///
  /// In it, this message translates to:
  /// **'Tag'**
  String get smartTodoAuditFilterTag;

  /// No description provided for @smartTodoAuditFilterSearch.
  ///
  /// In it, this message translates to:
  /// **'Cerca'**
  String get smartTodoAuditFilterSearch;

  /// No description provided for @smartTodoAuditFilterAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get smartTodoAuditFilterAll;

  /// No description provided for @smartTodoAuditFilterAllFemale.
  ///
  /// In it, this message translates to:
  /// **'Tutte'**
  String get smartTodoAuditFilterAllFemale;

  /// No description provided for @smartTodoAuditPremiumRequired.
  ///
  /// In it, this message translates to:
  /// **'Premium richiesto per storico esteso'**
  String get smartTodoAuditPremiumRequired;

  /// No description provided for @smartTodoAuditLastDays.
  ///
  /// In it, this message translates to:
  /// **'Ultimi {days} giorni'**
  String smartTodoAuditLastDays(int days);

  /// No description provided for @smartTodoAuditClearFilters.
  ///
  /// In it, this message translates to:
  /// **'Pulisci Filtri'**
  String get smartTodoAuditClearFilters;

  /// No description provided for @smartTodoAuditViewTimeline.
  ///
  /// In it, this message translates to:
  /// **'Vista Timeline'**
  String get smartTodoAuditViewTimeline;

  /// No description provided for @smartTodoAuditViewColumns.
  ///
  /// In it, this message translates to:
  /// **'Vista Colonne'**
  String get smartTodoAuditViewColumns;

  /// No description provided for @smartTodoAuditNoActivity.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività registrata'**
  String get smartTodoAuditNoActivity;

  /// No description provided for @smartTodoAuditNoResults.
  ///
  /// In it, this message translates to:
  /// **'Nessun risultato per i filtri selezionati'**
  String get smartTodoAuditNoResults;

  /// No description provided for @smartTodoAuditActivities.
  ///
  /// In it, this message translates to:
  /// **'{count} attività'**
  String smartTodoAuditActivities(int count);

  /// No description provided for @smartTodoAuditNoUserActivity.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività'**
  String get smartTodoAuditNoUserActivity;

  /// No description provided for @smartTodoAuditLoadMore.
  ///
  /// In it, this message translates to:
  /// **'Carica altri 50...'**
  String get smartTodoAuditLoadMore;

  /// No description provided for @smartTodoAuditEmptyValue.
  ///
  /// In it, this message translates to:
  /// **'(vuoto)'**
  String get smartTodoAuditEmptyValue;

  /// No description provided for @smartTodoAuditEntityList.
  ///
  /// In it, this message translates to:
  /// **'Lista'**
  String get smartTodoAuditEntityList;

  /// No description provided for @smartTodoAuditEntityTask.
  ///
  /// In it, this message translates to:
  /// **'Task'**
  String get smartTodoAuditEntityTask;

  /// No description provided for @smartTodoAuditEntityInvite.
  ///
  /// In it, this message translates to:
  /// **'Invito'**
  String get smartTodoAuditEntityInvite;

  /// No description provided for @smartTodoAuditEntityParticipant.
  ///
  /// In it, this message translates to:
  /// **'Partecipante'**
  String get smartTodoAuditEntityParticipant;

  /// No description provided for @smartTodoAuditEntityColumn.
  ///
  /// In it, this message translates to:
  /// **'Colonna'**
  String get smartTodoAuditEntityColumn;

  /// No description provided for @smartTodoAuditEntityTag.
  ///
  /// In it, this message translates to:
  /// **'Tag'**
  String get smartTodoAuditEntityTag;

  /// No description provided for @smartTodoAuditActionCreate.
  ///
  /// In it, this message translates to:
  /// **'Creato'**
  String get smartTodoAuditActionCreate;

  /// No description provided for @smartTodoAuditActionUpdate.
  ///
  /// In it, this message translates to:
  /// **'Modificato'**
  String get smartTodoAuditActionUpdate;

  /// No description provided for @smartTodoAuditActionDelete.
  ///
  /// In it, this message translates to:
  /// **'Eliminato'**
  String get smartTodoAuditActionDelete;

  /// No description provided for @smartTodoAuditActionArchive.
  ///
  /// In it, this message translates to:
  /// **'Archiviato'**
  String get smartTodoAuditActionArchive;

  /// No description provided for @smartTodoAuditActionRestore.
  ///
  /// In it, this message translates to:
  /// **'Ripristinato'**
  String get smartTodoAuditActionRestore;

  /// No description provided for @smartTodoAuditActionMove.
  ///
  /// In it, this message translates to:
  /// **'Spostato'**
  String get smartTodoAuditActionMove;

  /// No description provided for @smartTodoAuditActionAssign.
  ///
  /// In it, this message translates to:
  /// **'Assegnato'**
  String get smartTodoAuditActionAssign;

  /// No description provided for @smartTodoAuditActionInvite.
  ///
  /// In it, this message translates to:
  /// **'Invitato'**
  String get smartTodoAuditActionInvite;

  /// No description provided for @smartTodoAuditActionJoin.
  ///
  /// In it, this message translates to:
  /// **'Entrato'**
  String get smartTodoAuditActionJoin;

  /// No description provided for @smartTodoAuditActionRevoke.
  ///
  /// In it, this message translates to:
  /// **'Revocato'**
  String get smartTodoAuditActionRevoke;

  /// No description provided for @smartTodoAuditActionReorder.
  ///
  /// In it, this message translates to:
  /// **'Riordinato'**
  String get smartTodoAuditActionReorder;

  /// No description provided for @smartTodoAuditActionBatchCreate.
  ///
  /// In it, this message translates to:
  /// **'Import'**
  String get smartTodoAuditActionBatchCreate;

  /// No description provided for @smartTodoAuditTimeNow.
  ///
  /// In it, this message translates to:
  /// **'Adesso'**
  String get smartTodoAuditTimeNow;

  /// No description provided for @smartTodoAuditTimeMinutesAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} min fa'**
  String smartTodoAuditTimeMinutesAgo(int count);

  /// No description provided for @smartTodoAuditTimeHoursAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} ore fa'**
  String smartTodoAuditTimeHoursAgo(int count);

  /// No description provided for @smartTodoAuditTimeDaysAgo.
  ///
  /// In it, this message translates to:
  /// **'{count} giorni fa'**
  String smartTodoAuditTimeDaysAgo(int count);

  /// No description provided for @smartTodoCfdTitle.
  ///
  /// In it, this message translates to:
  /// **'CFD Analytics'**
  String get smartTodoCfdTitle;

  /// No description provided for @smartTodoCfdTooltip.
  ///
  /// In it, this message translates to:
  /// **'CFD Analytics'**
  String get smartTodoCfdTooltip;

  /// No description provided for @smartTodoCfdDateRange.
  ///
  /// In it, this message translates to:
  /// **'Periodo:'**
  String get smartTodoCfdDateRange;

  /// No description provided for @smartTodoCfd7Days.
  ///
  /// In it, this message translates to:
  /// **'7 giorni'**
  String get smartTodoCfd7Days;

  /// No description provided for @smartTodoCfd14Days.
  ///
  /// In it, this message translates to:
  /// **'14 giorni'**
  String get smartTodoCfd14Days;

  /// No description provided for @smartTodoCfd30Days.
  ///
  /// In it, this message translates to:
  /// **'30 giorni'**
  String get smartTodoCfd30Days;

  /// No description provided for @smartTodoCfd90Days.
  ///
  /// In it, this message translates to:
  /// **'90 giorni'**
  String get smartTodoCfd90Days;

  /// No description provided for @smartTodoCfdError.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento'**
  String get smartTodoCfdError;

  /// No description provided for @smartTodoCfdRetry.
  ///
  /// In it, this message translates to:
  /// **'Aggiorna'**
  String get smartTodoCfdRetry;

  /// No description provided for @smartTodoCfdNoData.
  ///
  /// In it, this message translates to:
  /// **'Nessun dato disponibile'**
  String get smartTodoCfdNoData;

  /// No description provided for @smartTodoCfdNoDataHint.
  ///
  /// In it, this message translates to:
  /// **'I movimenti dei task saranno tracciati qui'**
  String get smartTodoCfdNoDataHint;

  /// No description provided for @smartTodoCfdKeyMetrics.
  ///
  /// In it, this message translates to:
  /// **'Metriche Chiave'**
  String get smartTodoCfdKeyMetrics;

  /// No description provided for @smartTodoCfdLeadTime.
  ///
  /// In it, this message translates to:
  /// **'Lead Time'**
  String get smartTodoCfdLeadTime;

  /// No description provided for @smartTodoCfdLeadTimeTooltip.
  ///
  /// In it, this message translates to:
  /// **'Tempo dalla creazione al completamento'**
  String get smartTodoCfdLeadTimeTooltip;

  /// No description provided for @smartTodoCfdCycleTime.
  ///
  /// In it, this message translates to:
  /// **'Cycle Time'**
  String get smartTodoCfdCycleTime;

  /// No description provided for @smartTodoCfdCycleTimeTooltip.
  ///
  /// In it, this message translates to:
  /// **'Tempo dall\'inizio lavoro al completamento'**
  String get smartTodoCfdCycleTimeTooltip;

  /// No description provided for @smartTodoCfdThroughput.
  ///
  /// In it, this message translates to:
  /// **'Throughput'**
  String get smartTodoCfdThroughput;

  /// No description provided for @smartTodoCfdThroughputTooltip.
  ///
  /// In it, this message translates to:
  /// **'Task completati a settimana'**
  String get smartTodoCfdThroughputTooltip;

  /// No description provided for @smartTodoCfdWip.
  ///
  /// In it, this message translates to:
  /// **'WIP'**
  String get smartTodoCfdWip;

  /// No description provided for @smartTodoCfdWipTooltip.
  ///
  /// In it, this message translates to:
  /// **'Lavoro in corso'**
  String get smartTodoCfdWipTooltip;

  /// No description provided for @smartTodoCfdLimit.
  ///
  /// In it, this message translates to:
  /// **'Limite'**
  String get smartTodoCfdLimit;

  /// No description provided for @smartTodoCfdCompleted.
  ///
  /// In it, this message translates to:
  /// **'completati'**
  String get smartTodoCfdCompleted;

  /// No description provided for @smartTodoCfdFlowAnalysis.
  ///
  /// In it, this message translates to:
  /// **'Analisi Flusso'**
  String get smartTodoCfdFlowAnalysis;

  /// No description provided for @smartTodoCfdArrived.
  ///
  /// In it, this message translates to:
  /// **'Arrivati'**
  String get smartTodoCfdArrived;

  /// No description provided for @smartTodoCfdBacklogShrinking.
  ///
  /// In it, this message translates to:
  /// **'Backlog in diminuzione'**
  String get smartTodoCfdBacklogShrinking;

  /// No description provided for @smartTodoCfdBacklogGrowing.
  ///
  /// In it, this message translates to:
  /// **'Backlog in aumento'**
  String get smartTodoCfdBacklogGrowing;

  /// No description provided for @smartTodoCfdBottlenecks.
  ///
  /// In it, this message translates to:
  /// **'Rilevamento Colli di Bottiglia'**
  String get smartTodoCfdBottlenecks;

  /// No description provided for @smartTodoCfdNoBottlenecks.
  ///
  /// In it, this message translates to:
  /// **'Nessun collo di bottiglia'**
  String get smartTodoCfdNoBottlenecks;

  /// No description provided for @smartTodoCfdTasks.
  ///
  /// In it, this message translates to:
  /// **'task'**
  String get smartTodoCfdTasks;

  /// No description provided for @smartTodoCfdAvgAge.
  ///
  /// In it, this message translates to:
  /// **'Eta media'**
  String get smartTodoCfdAvgAge;

  /// No description provided for @smartTodoCfdAgingWip.
  ///
  /// In it, this message translates to:
  /// **'Lavori in Corso Invecchiati'**
  String get smartTodoCfdAgingWip;

  /// No description provided for @smartTodoCfdTask.
  ///
  /// In it, this message translates to:
  /// **'Task'**
  String get smartTodoCfdTask;

  /// No description provided for @smartTodoCfdColumn.
  ///
  /// In it, this message translates to:
  /// **'Colonna'**
  String get smartTodoCfdColumn;

  /// No description provided for @smartTodoCfdAge.
  ///
  /// In it, this message translates to:
  /// **'Eta'**
  String get smartTodoCfdAge;

  /// No description provided for @smartTodoCfdDays.
  ///
  /// In it, this message translates to:
  /// **'giorni'**
  String get smartTodoCfdDays;

  /// No description provided for @smartTodoCfdHowCalculated.
  ///
  /// In it, this message translates to:
  /// **'Come viene calcolato?'**
  String get smartTodoCfdHowCalculated;

  /// No description provided for @smartTodoCfdMedian.
  ///
  /// In it, this message translates to:
  /// **'Mediana'**
  String get smartTodoCfdMedian;

  /// No description provided for @smartTodoCfdP85.
  ///
  /// In it, this message translates to:
  /// **'P85'**
  String get smartTodoCfdP85;

  /// No description provided for @smartTodoCfdP95.
  ///
  /// In it, this message translates to:
  /// **'P95'**
  String get smartTodoCfdP95;

  /// No description provided for @smartTodoCfdMin.
  ///
  /// In it, this message translates to:
  /// **'Min'**
  String get smartTodoCfdMin;

  /// No description provided for @smartTodoCfdMax.
  ///
  /// In it, this message translates to:
  /// **'Max'**
  String get smartTodoCfdMax;

  /// No description provided for @smartTodoCfdSample.
  ///
  /// In it, this message translates to:
  /// **'Campione'**
  String get smartTodoCfdSample;

  /// No description provided for @smartTodoCfdVsPrevious.
  ///
  /// In it, this message translates to:
  /// **'vs periodo precedente'**
  String get smartTodoCfdVsPrevious;

  /// No description provided for @smartTodoCfdArrivalRate.
  ///
  /// In it, this message translates to:
  /// **'Tasso Arrivo'**
  String get smartTodoCfdArrivalRate;

  /// No description provided for @smartTodoCfdCompletionRate.
  ///
  /// In it, this message translates to:
  /// **'Tasso Completamento'**
  String get smartTodoCfdCompletionRate;

  /// No description provided for @smartTodoCfdNetFlow.
  ///
  /// In it, this message translates to:
  /// **'Flusso Netto'**
  String get smartTodoCfdNetFlow;

  /// No description provided for @smartTodoCfdPerDay.
  ///
  /// In it, this message translates to:
  /// **'/giorno'**
  String get smartTodoCfdPerDay;

  /// No description provided for @smartTodoCfdPerWeek.
  ///
  /// In it, this message translates to:
  /// **'/settimana'**
  String get smartTodoCfdPerWeek;

  /// No description provided for @smartTodoCfdSeverity.
  ///
  /// In it, this message translates to:
  /// **'Severita'**
  String get smartTodoCfdSeverity;

  /// No description provided for @smartTodoCfdAssignee.
  ///
  /// In it, this message translates to:
  /// **'Assegnatario'**
  String get smartTodoCfdAssignee;

  /// No description provided for @smartTodoCfdUnassigned.
  ///
  /// In it, this message translates to:
  /// **'Non assegnato'**
  String get smartTodoCfdUnassigned;

  /// No description provided for @smartTodoCfdLeadTimeExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il Lead Time misura il tempo totale dalla creazione di un task al suo completamento.\n\n**Formula:**\nLead Time = Data Completamento - Data Creazione\n\n**Metriche:**\n- **Media**: Media di tutti i lead time\n- **Mediana**: Valore centrale (meno sensibile agli outlier)\n- **P85**: L\'85% dei task viene completato entro questo tempo\n- **P95**: Il 95% dei task viene completato entro questo tempo\n\n**Perche e importante:**\nIl Lead Time rappresenta l\'esperienza del cliente - il tempo totale di attesa. Usa il P85 per dare stime di consegna ai clienti.'**
  String get smartTodoCfdLeadTimeExplanation;

  /// No description provided for @smartTodoCfdCycleTimeExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il Cycle Time misura il tempo da quando il lavoro inizia effettivamente (il task esce da \'Da Fare\') fino al completamento.\n\n**Formula:**\nCycle Time = Data Completamento - Data Inizio Lavoro\n\n**Differenza dal Lead Time:**\n- **Lead Time** = Prospettiva cliente (include attesa)\n- **Cycle Time** = Prospettiva team (solo lavoro attivo)\n\n**Come viene rilevato \'Inizio Lavoro\':**\nLa prima volta che un task esce dalla colonna \'Da Fare\' viene registrata come data di inizio lavoro.'**
  String get smartTodoCfdCycleTimeExplanation;

  /// No description provided for @smartTodoCfdThroughputExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il Throughput misura quanti task vengono completati per unita di tempo.\n\n**Formule:**\n- Media Giornaliera = Task Completati / Giorni nel Periodo\n- Media Settimanale = Media Giornaliera x 7\n\n**Come usarlo:**\nPrevisione date di consegna:\nTask Rimanenti / Throughput Settimanale = Settimane per Completare\n\n**Esempio:**\n30 task rimanenti, throughput di 10/settimana = ~3 settimane'**
  String get smartTodoCfdThroughputExplanation;

  /// No description provided for @smartTodoCfdWipExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il WIP (Work In Progress) conta i task attualmente in lavorazione - non in \'Da Fare\' e non in \'Fatto\'.\n\n**Formula:**\nWIP = Task Totali - Task in Da Fare - Task in Fatto\n\n**Legge di Little:**\nLead Time = WIP / Throughput\n\nRidurre il WIP riduce direttamente il Lead Time!\n\n**Limite WIP Suggerito:**\nDimensione Team x 2 (best practice Kanban)\n\n**Stato:**\n- Sano: WIP <= Limite\n- Attenzione: WIP > Limite x 1.25\n- Critico: WIP > Limite x 1.5'**
  String get smartTodoCfdWipExplanation;

  /// No description provided for @smartTodoCfdFlowExplanation.
  ///
  /// In it, this message translates to:
  /// **'L\'Analisi del Flusso confronta il tasso di arrivo nuovi task vs task completati.\n\n**Formule:**\n- Tasso Arrivo = Nuovi Task Creati / Giorni\n- Tasso Completamento = Task Completati / Giorni\n- Flusso Netto = Completati - Arrivati\n\n**Interpretazione stato:**\n- **In Svuotamento** (Completamento > Arrivo): WIP in diminuzione - bene!\n- **Bilanciato** (entro +/-10%): Flusso stabile\n- **In Riempimento** (Arrivo > Completamento): WIP in aumento - azione necessaria'**
  String get smartTodoCfdFlowExplanation;

  /// No description provided for @smartTodoCfdBottleneckExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il Rilevamento Colli di Bottiglia identifica le colonne dove i task si accumulano o rimangono troppo a lungo.\n\n**Algoritmo:**\nSeverita = (Score Conteggio + Score Eta) / 2\n\nDove:\n- Score Conteggio = Task nella Colonna / 10\n- Score Eta = Eta Media / 7 giorni\n\n**Segnalato quando:**\n- 2+ task nella colonna, OPPURE\n- Eta media > 2 giorni\n\n**Livelli di severita:**\n- Basso (< 0.3): Monitorare\n- Medio (0.3-0.6): Investigare\n- Alto (> 0.6): Intervenire'**
  String get smartTodoCfdBottleneckExplanation;

  /// No description provided for @smartTodoCfdAgingExplanation.
  ///
  /// In it, this message translates to:
  /// **'Aging WIP mostra i task attualmente in lavorazione, ordinati per quanto tempo sono stati lavorati.\n\n**Formula:**\nEta = Ora Attuale - Data Inizio Lavoro (in giorni)\n\n**Stato per eta:**\n- Fresco (< 3 giorni): Normale\n- Attenzione (3-7 giorni): Potrebbe richiedere attenzione\n- Critico (> 7 giorni): Probabilmente bloccato - investigare!\n\nI task vecchi spesso indicano blocchi, requisiti poco chiari o scope creep.'**
  String get smartTodoCfdAgingExplanation;

  /// No description provided for @smartTodoCfdTeamBalance.
  ///
  /// In it, this message translates to:
  /// **'Bilanciamento Team'**
  String get smartTodoCfdTeamBalance;

  /// No description provided for @smartTodoCfdTeamBalanceExplanation.
  ///
  /// In it, this message translates to:
  /// **'Il Bilanciamento Team mostra la distribuzione dei task tra i membri.\n\n**Punteggio Bilanciamento:**\nCalcolato usando il coefficiente di variazione (CV).\nPunteggio = 1 / (1 + CV)\n\n**Stato:**\n- Bilanciato (≥80%): Lavoro distribuito equamente\n- Disomogeneo (50-80%): Qualche squilibrio\n- Sbilanciato (<50%): Disparita significativa\n\n**Colonne:**\n- Da Fare: Task in attesa\n- WIP: Task in lavorazione\n- Fatto: Task completati'**
  String get smartTodoCfdTeamBalanceExplanation;

  /// No description provided for @smartTodoCfdBalanced.
  ///
  /// In it, this message translates to:
  /// **'Bilanciato'**
  String get smartTodoCfdBalanced;

  /// No description provided for @smartTodoCfdUneven.
  ///
  /// In it, this message translates to:
  /// **'Disomogeneo'**
  String get smartTodoCfdUneven;

  /// No description provided for @smartTodoCfdImbalanced.
  ///
  /// In it, this message translates to:
  /// **'Sbilanciato'**
  String get smartTodoCfdImbalanced;

  /// No description provided for @smartTodoCfdMember.
  ///
  /// In it, this message translates to:
  /// **'Membro'**
  String get smartTodoCfdMember;

  /// No description provided for @smartTodoCfdTotal.
  ///
  /// In it, this message translates to:
  /// **'Totale'**
  String get smartTodoCfdTotal;

  /// No description provided for @smartTodoCfdToDo.
  ///
  /// In it, this message translates to:
  /// **'Da Fare'**
  String get smartTodoCfdToDo;

  /// No description provided for @smartTodoCfdInProgress.
  ///
  /// In it, this message translates to:
  /// **'In Corso'**
  String get smartTodoCfdInProgress;

  /// No description provided for @smartTodoCfdDone.
  ///
  /// In it, this message translates to:
  /// **'Fatto'**
  String get smartTodoCfdDone;

  /// No description provided for @smartTodoNewTaskDefault.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Task'**
  String get smartTodoNewTaskDefault;

  /// No description provided for @smartTodoRename.
  ///
  /// In it, this message translates to:
  /// **'Rinomina'**
  String get smartTodoRename;

  /// No description provided for @smartTodoAddActivity.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi un\'attivita'**
  String get smartTodoAddActivity;

  /// No description provided for @smartTodoAddColumn.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Colonna'**
  String get smartTodoAddColumn;

  /// No description provided for @smartTodoParticipantManagement.
  ///
  /// In it, this message translates to:
  /// **'Gestione Partecipanti'**
  String get smartTodoParticipantManagement;

  /// No description provided for @smartTodoParticipantsTab.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti'**
  String get smartTodoParticipantsTab;

  /// No description provided for @smartTodoInvitesTab.
  ///
  /// In it, this message translates to:
  /// **'Inviti'**
  String get smartTodoInvitesTab;

  /// No description provided for @smartTodoAddParticipant.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Partecipante'**
  String get smartTodoAddParticipant;

  /// No description provided for @smartTodoMembers.
  ///
  /// In it, this message translates to:
  /// **'Membri ({count})'**
  String smartTodoMembers(int count);

  /// No description provided for @smartTodoNoInvitesPending.
  ///
  /// In it, this message translates to:
  /// **'Nessun invito in sospeso'**
  String get smartTodoNoInvitesPending;

  /// No description provided for @smartTodoRoleLabel.
  ///
  /// In it, this message translates to:
  /// **'Ruolo: {role}'**
  String smartTodoRoleLabel(String role);

  /// No description provided for @smartTodoExpired.
  ///
  /// In it, this message translates to:
  /// **'SCADUTO'**
  String get smartTodoExpired;

  /// No description provided for @smartTodoSentBy.
  ///
  /// In it, this message translates to:
  /// **'Inviato da {name}'**
  String smartTodoSentBy(String name);

  /// No description provided for @smartTodoResendEmail.
  ///
  /// In it, this message translates to:
  /// **'Reinvia Email'**
  String get smartTodoResendEmail;

  /// No description provided for @smartTodoRevoke.
  ///
  /// In it, this message translates to:
  /// **'Revoca'**
  String get smartTodoRevoke;

  /// No description provided for @smartTodoSendingEmail.
  ///
  /// In it, this message translates to:
  /// **'Invio email in corso...'**
  String get smartTodoSendingEmail;

  /// No description provided for @smartTodoEmailResent.
  ///
  /// In it, this message translates to:
  /// **'Email reinviata!'**
  String get smartTodoEmailResent;

  /// No description provided for @smartTodoEmailSendError.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'invio.'**
  String get smartTodoEmailSendError;

  /// No description provided for @smartTodoInvalidSession.
  ///
  /// In it, this message translates to:
  /// **'Sessione non valida per inviare email.'**
  String get smartTodoInvalidSession;

  /// No description provided for @smartTodoEmail.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get smartTodoEmail;

  /// No description provided for @smartTodoRole.
  ///
  /// In it, this message translates to:
  /// **'Ruolo'**
  String get smartTodoRole;

  /// No description provided for @smartTodoInviteCreated.
  ///
  /// In it, this message translates to:
  /// **'Invito creato e inviato con successo!'**
  String get smartTodoInviteCreated;

  /// No description provided for @smartTodoInviteCreatedNoEmail.
  ///
  /// In it, this message translates to:
  /// **'Invito creato, ma email non inviata (controlla login/permessi Google).'**
  String get smartTodoInviteCreatedNoEmail;

  /// No description provided for @smartTodoUserAlreadyInvited.
  ///
  /// In it, this message translates to:
  /// **'Utente gia invitato.'**
  String get smartTodoUserAlreadyInvited;

  /// No description provided for @smartTodoInviteCollaborator.
  ///
  /// In it, this message translates to:
  /// **'Invita Collaboratore'**
  String get smartTodoInviteCollaborator;

  /// No description provided for @smartTodoEditorRole.
  ///
  /// In it, this message translates to:
  /// **'Editor (Puo modificare)'**
  String get smartTodoEditorRole;

  /// No description provided for @smartTodoViewerRole.
  ///
  /// In it, this message translates to:
  /// **'Viewer (Solo visualizzazione)'**
  String get smartTodoViewerRole;

  /// No description provided for @smartTodoSendEmailNotification.
  ///
  /// In it, this message translates to:
  /// **'Invia notifica email'**
  String get smartTodoSendEmailNotification;

  /// No description provided for @smartTodoSend.
  ///
  /// In it, this message translates to:
  /// **'Invia'**
  String get smartTodoSend;

  /// No description provided for @smartTodoInvalidEmail.
  ///
  /// In it, this message translates to:
  /// **'Email non valida'**
  String get smartTodoInvalidEmail;

  /// No description provided for @smartTodoUserNotAuthenticated.
  ///
  /// In it, this message translates to:
  /// **'Utente non autenticato o email mancante'**
  String get smartTodoUserNotAuthenticated;

  /// No description provided for @smartTodoGoogleLoginRequired.
  ///
  /// In it, this message translates to:
  /// **'Necessario login Google per inviare email'**
  String get smartTodoGoogleLoginRequired;

  /// No description provided for @smartTodoInviteSent.
  ///
  /// In it, this message translates to:
  /// **'Invito inviato a {email}'**
  String smartTodoInviteSent(String email);

  /// No description provided for @smartTodoUserAlreadyInvitedOrPending.
  ///
  /// In it, this message translates to:
  /// **'Utente gia invitato o invito in attesa.'**
  String get smartTodoUserAlreadyInvitedOrPending;

  /// No description provided for @smartTodoFilterToday.
  ///
  /// In it, this message translates to:
  /// **'Oggi'**
  String get smartTodoFilterToday;

  /// No description provided for @smartTodoFilterMyTasks.
  ///
  /// In it, this message translates to:
  /// **'I Miei Task'**
  String get smartTodoFilterMyTasks;

  /// No description provided for @smartTodoFilterOwner.
  ///
  /// In it, this message translates to:
  /// **'Owner'**
  String get smartTodoFilterOwner;

  /// No description provided for @smartTodoViewGlobalTasks.
  ///
  /// In it, this message translates to:
  /// **'Vedi Task Globali'**
  String get smartTodoViewGlobalTasks;

  /// No description provided for @smartTodoViewLists.
  ///
  /// In it, this message translates to:
  /// **'Vedi Liste'**
  String get smartTodoViewLists;

  /// No description provided for @smartTodoNewListDialogTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuova Lista'**
  String get smartTodoNewListDialogTitle;

  /// No description provided for @smartTodoTitleLabel.
  ///
  /// In it, this message translates to:
  /// **'Titolo *'**
  String get smartTodoTitleLabel;

  /// No description provided for @smartTodoDescriptionLabel.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get smartTodoDescriptionLabel;

  /// No description provided for @smartTodoCancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get smartTodoCancel;

  /// No description provided for @smartTodoCreate.
  ///
  /// In it, this message translates to:
  /// **'Crea'**
  String get smartTodoCreate;

  /// No description provided for @smartTodoSave.
  ///
  /// In it, this message translates to:
  /// **'Salva'**
  String get smartTodoSave;

  /// No description provided for @smartTodoNoListsPresent.
  ///
  /// In it, this message translates to:
  /// **'Nessuna lista presente'**
  String get smartTodoNoListsPresent;

  /// No description provided for @smartTodoCreateFirstList.
  ///
  /// In it, this message translates to:
  /// **'Crea la tua prima lista per iniziare'**
  String get smartTodoCreateFirstList;

  /// No description provided for @smartTodoMembersCount.
  ///
  /// In it, this message translates to:
  /// **'{count} membri'**
  String smartTodoMembersCount(int count);

  /// No description provided for @smartTodoRenameListTitle.
  ///
  /// In it, this message translates to:
  /// **'Rinomina Lista'**
  String get smartTodoRenameListTitle;

  /// No description provided for @smartTodoNewNameLabel.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Nome'**
  String get smartTodoNewNameLabel;

  /// No description provided for @smartTodoDeleteListTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Lista'**
  String get smartTodoDeleteListTitle;

  /// No description provided for @smartTodoDeleteListConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare questa lista e tutti i suoi task? Questa azione è irreversibile.'**
  String get smartTodoDeleteListConfirm;

  /// No description provided for @smartTodoDelete.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get smartTodoDelete;

  /// No description provided for @smartTodoEdit.
  ///
  /// In it, this message translates to:
  /// **'Modifica'**
  String get smartTodoEdit;

  /// No description provided for @smartTodoSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca liste...'**
  String get smartTodoSearchHint;

  /// No description provided for @smartTodoSearchTasksHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca...'**
  String get smartTodoSearchTasksHint;

  /// No description provided for @smartTodoNoSearchResults.
  ///
  /// In it, this message translates to:
  /// **'Nessun risultato per \"{query}\"'**
  String smartTodoNoSearchResults(String query);

  /// No description provided for @smartTodoColumnTodo.
  ///
  /// In it, this message translates to:
  /// **'Da Fare'**
  String get smartTodoColumnTodo;

  /// No description provided for @smartTodoColumnInProgress.
  ///
  /// In it, this message translates to:
  /// **'In Corso'**
  String get smartTodoColumnInProgress;

  /// No description provided for @smartTodoColumnDone.
  ///
  /// In it, this message translates to:
  /// **'Fatto'**
  String get smartTodoColumnDone;

  /// No description provided for @smartTodoAllPeople.
  ///
  /// In it, this message translates to:
  /// **'Tutte le persone'**
  String get smartTodoAllPeople;

  /// No description provided for @smartTodoPeopleCount.
  ///
  /// In it, this message translates to:
  /// **'{count} persone'**
  String smartTodoPeopleCount(int count);

  /// No description provided for @smartTodoFilterByPerson.
  ///
  /// In it, this message translates to:
  /// **'Filtra per persona'**
  String get smartTodoFilterByPerson;

  /// No description provided for @smartTodoApplyFilters.
  ///
  /// In it, this message translates to:
  /// **'Applica Filtri'**
  String get smartTodoApplyFilters;

  /// No description provided for @smartTodoAllTags.
  ///
  /// In it, this message translates to:
  /// **'Tutti i tag'**
  String get smartTodoAllTags;

  /// No description provided for @smartTodoTagsCount.
  ///
  /// In it, this message translates to:
  /// **'{count} tag'**
  String smartTodoTagsCount(int count);

  /// No description provided for @smartTodoFilterByTag.
  ///
  /// In it, this message translates to:
  /// **'Filtra per tag'**
  String get smartTodoFilterByTag;

  /// No description provided for @smartTodoTagAlreadyExists.
  ///
  /// In it, this message translates to:
  /// **'Tag già esistente'**
  String get smartTodoTagAlreadyExists;

  /// No description provided for @smartTodoError.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String smartTodoError(String error);

  /// No description provided for @profileMenuTitle.
  ///
  /// In it, this message translates to:
  /// **'Profilo'**
  String get profileMenuTitle;

  /// No description provided for @profileMenuLogout.
  ///
  /// In it, this message translates to:
  /// **'Esci'**
  String get profileMenuLogout;

  /// No description provided for @profileLogoutDialogTitle.
  ///
  /// In it, this message translates to:
  /// **'Logout'**
  String get profileLogoutDialogTitle;

  /// No description provided for @profileLogoutDialogConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler uscire?'**
  String get profileLogoutDialogConfirm;

  /// No description provided for @agileAddToSprint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi a Sprint'**
  String get agileAddToSprint;

  /// No description provided for @agileEstimate.
  ///
  /// In it, this message translates to:
  /// **'STIMA'**
  String get agileEstimate;

  /// No description provided for @agileEstimated.
  ///
  /// In it, this message translates to:
  /// **'Stimata'**
  String get agileEstimated;

  /// No description provided for @agileEstimateRequired.
  ///
  /// In it, this message translates to:
  /// **'Stima richiesta (click per stimare)'**
  String get agileEstimateRequired;

  /// No description provided for @agilePoints.
  ///
  /// In it, this message translates to:
  /// **'pts'**
  String get agilePoints;

  /// No description provided for @agilePointsValue.
  ///
  /// In it, this message translates to:
  /// **'{points} pts'**
  String agilePointsValue(int points);

  /// No description provided for @agileMethodologyGuideTitle.
  ///
  /// In it, this message translates to:
  /// **'Guida alle Metodologie Agile'**
  String get agileMethodologyGuideTitle;

  /// No description provided for @agileMethodologyGuideSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Scegli la metodologia piu adatta al tuo progetto'**
  String get agileMethodologyGuideSubtitle;

  /// No description provided for @agileScrumShortDesc.
  ///
  /// In it, this message translates to:
  /// **'Sprint a tempo fisso, Velocity, Burndown. Ideale per prodotti con requisiti che evolvono.'**
  String get agileScrumShortDesc;

  /// No description provided for @agileKanbanShortDesc.
  ///
  /// In it, this message translates to:
  /// **'Flusso continuo, WIP Limits, Lead Time. Ideale per supporto e richieste continue.'**
  String get agileKanbanShortDesc;

  /// No description provided for @agileScrumbanShortDesc.
  ///
  /// In it, this message translates to:
  /// **'Mix di Sprint e flusso continuo. Ideale per team che vogliono flessibilita.'**
  String get agileScrumbanShortDesc;

  /// No description provided for @agileGuide.
  ///
  /// In it, this message translates to:
  /// **'Guida'**
  String get agileGuide;

  /// No description provided for @backlogProductBacklog.
  ///
  /// In it, this message translates to:
  /// **'Product Backlog'**
  String get backlogProductBacklog;

  /// No description provided for @backlogArchiveCompleted.
  ///
  /// In it, this message translates to:
  /// **'Archivio Completate'**
  String get backlogArchiveCompleted;

  /// No description provided for @backlogStories.
  ///
  /// In it, this message translates to:
  /// **'stories'**
  String get backlogStories;

  /// No description provided for @backlogEstimated.
  ///
  /// In it, this message translates to:
  /// **'stimate'**
  String get backlogEstimated;

  /// No description provided for @backlogShowActive.
  ///
  /// In it, this message translates to:
  /// **'Mostra Backlog attivo'**
  String get backlogShowActive;

  /// No description provided for @backlogShowArchive.
  ///
  /// In it, this message translates to:
  /// **'Mostra Archivio ({count} completate)'**
  String backlogShowArchive(int count);

  /// No description provided for @backlogTab.
  ///
  /// In it, this message translates to:
  /// **'Backlog'**
  String get backlogTab;

  /// No description provided for @backlogArchiveTab.
  ///
  /// In it, this message translates to:
  /// **'Archivio ({count})'**
  String backlogArchiveTab(int count);

  /// No description provided for @backlogFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri'**
  String get backlogFilters;

  /// No description provided for @backlogNewStory.
  ///
  /// In it, this message translates to:
  /// **'Nuova Story'**
  String get backlogNewStory;

  /// No description provided for @backlogSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca per titolo, descrizione o ID...'**
  String get backlogSearchHint;

  /// No description provided for @backlogStatusFilter.
  ///
  /// In it, this message translates to:
  /// **'Status: '**
  String get backlogStatusFilter;

  /// No description provided for @backlogPriorityFilter.
  ///
  /// In it, this message translates to:
  /// **'Priorita: '**
  String get backlogPriorityFilter;

  /// No description provided for @backlogTagFilter.
  ///
  /// In it, this message translates to:
  /// **'Tag: '**
  String get backlogTagFilter;

  /// No description provided for @backlogAllStatuses.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get backlogAllStatuses;

  /// No description provided for @backlogAllPriorities.
  ///
  /// In it, this message translates to:
  /// **'Tutte'**
  String get backlogAllPriorities;

  /// No description provided for @backlogRemoveFilters.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi filtri'**
  String get backlogRemoveFilters;

  /// No description provided for @backlogNoStoryFound.
  ///
  /// In it, this message translates to:
  /// **'Nessuna story trovata'**
  String get backlogNoStoryFound;

  /// No description provided for @backlogEmpty.
  ///
  /// In it, this message translates to:
  /// **'Backlog vuoto'**
  String get backlogEmpty;

  /// No description provided for @backlogAddFirstStory.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi la prima User Story'**
  String get backlogAddFirstStory;

  /// No description provided for @kanbanWipExceeded.
  ///
  /// In it, this message translates to:
  /// **'WIP Limit superato! Completa alcuni item prima di iniziarne di nuovi.'**
  String get kanbanWipExceeded;

  /// No description provided for @kanbanInfo.
  ///
  /// In it, this message translates to:
  /// **'Info'**
  String get kanbanInfo;

  /// No description provided for @kanbanConfigureWip.
  ///
  /// In it, this message translates to:
  /// **'Configura WIP'**
  String get kanbanConfigureWip;

  /// No description provided for @kanbanWipTooltip.
  ///
  /// In it, this message translates to:
  /// **'WIP: {current} di {max} max'**
  String kanbanWipTooltip(int current, int max);

  /// No description provided for @kanbanNoWipLimit.
  ///
  /// In it, this message translates to:
  /// **'Nessun limite WIP'**
  String get kanbanNoWipLimit;

  /// No description provided for @kanbanItems.
  ///
  /// In it, this message translates to:
  /// **'{count} items'**
  String kanbanItems(int count);

  /// No description provided for @kanbanEmpty.
  ///
  /// In it, this message translates to:
  /// **'Vuoto'**
  String get kanbanEmpty;

  /// No description provided for @kanbanWipLimitTitle.
  ///
  /// In it, this message translates to:
  /// **'WIP Limit: {column}'**
  String kanbanWipLimitTitle(String column);

  /// No description provided for @kanbanWipLimitDesc.
  ///
  /// In it, this message translates to:
  /// **'Imposta il numero massimo di item che possono essere in questa colonna contemporaneamente.'**
  String get kanbanWipLimitDesc;

  /// No description provided for @kanbanWipLimitLabel.
  ///
  /// In it, this message translates to:
  /// **'WIP Limit'**
  String get kanbanWipLimitLabel;

  /// No description provided for @kanbanWipLimitHint.
  ///
  /// In it, this message translates to:
  /// **'Lascia vuoto per nessun limite'**
  String get kanbanWipLimitHint;

  /// No description provided for @kanbanWipLimitSuggestion.
  ///
  /// In it, this message translates to:
  /// **'Suggerimento: inizia con {count} e aggiusta in base al team.'**
  String kanbanWipLimitSuggestion(int count);

  /// No description provided for @kanbanRemoveLimit.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi Limite'**
  String get kanbanRemoveLimit;

  /// No description provided for @kanbanWipExceededTitle.
  ///
  /// In it, this message translates to:
  /// **'WIP Limit Superato'**
  String get kanbanWipExceededTitle;

  /// No description provided for @kanbanWipExceededMessage.
  ///
  /// In it, this message translates to:
  /// **'Spostando '**
  String get kanbanWipExceededMessage;

  /// No description provided for @kanbanWipExceededIn.
  ///
  /// In it, this message translates to:
  /// **' in '**
  String get kanbanWipExceededIn;

  /// No description provided for @kanbanWipExceededWillExceed.
  ///
  /// In it, this message translates to:
  /// **' supererai il limite WIP.'**
  String get kanbanWipExceededWillExceed;

  /// No description provided for @kanbanColumnLabel.
  ///
  /// In it, this message translates to:
  /// **'Colonna: {name}'**
  String kanbanColumnLabel(String name);

  /// No description provided for @kanbanCurrentCount.
  ///
  /// In it, this message translates to:
  /// **'Attuale: {current} | Limite: {limit}'**
  String kanbanCurrentCount(int current, int limit);

  /// No description provided for @kanbanAfterMove.
  ///
  /// In it, this message translates to:
  /// **'Dopo lo spostamento: {count}'**
  String kanbanAfterMove(int count);

  /// No description provided for @kanbanSuggestion.
  ///
  /// In it, this message translates to:
  /// **'Suggerimento: completa o sposta altri item prima di iniziarne di nuovi per mantenere un flusso di lavoro ottimale.'**
  String get kanbanSuggestion;

  /// No description provided for @kanbanMoveAnyway.
  ///
  /// In it, this message translates to:
  /// **'Sposta Comunque'**
  String get kanbanMoveAnyway;

  /// No description provided for @kanbanWipExplanationTitle.
  ///
  /// In it, this message translates to:
  /// **'WIP Limits'**
  String get kanbanWipExplanationTitle;

  /// No description provided for @kanbanWipWhat.
  ///
  /// In it, this message translates to:
  /// **'Cosa sono i WIP Limits?'**
  String get kanbanWipWhat;

  /// No description provided for @kanbanWipWhatDesc.
  ///
  /// In it, this message translates to:
  /// **'WIP (Work In Progress) Limits sono limiti sul numero di item che possono essere in una colonna contemporaneamente.'**
  String get kanbanWipWhatDesc;

  /// No description provided for @kanbanWipWhy.
  ///
  /// In it, this message translates to:
  /// **'Perche usarli?'**
  String get kanbanWipWhy;

  /// No description provided for @kanbanWipBenefit1.
  ///
  /// In it, this message translates to:
  /// **'- Riducono il multitasking e aumentano il focus'**
  String get kanbanWipBenefit1;

  /// No description provided for @kanbanWipBenefit2.
  ///
  /// In it, this message translates to:
  /// **'- Evidenziano i colli di bottiglia'**
  String get kanbanWipBenefit2;

  /// No description provided for @kanbanWipBenefit3.
  ///
  /// In it, this message translates to:
  /// **'- Migliorano il flusso di lavoro'**
  String get kanbanWipBenefit3;

  /// No description provided for @kanbanWipBenefit4.
  ///
  /// In it, this message translates to:
  /// **'- Accelerano il completamento degli item'**
  String get kanbanWipBenefit4;

  /// No description provided for @kanbanWipWhatToDo.
  ///
  /// In it, this message translates to:
  /// **'Cosa fare se un limite e superato?'**
  String get kanbanWipWhatToDo;

  /// No description provided for @kanbanWipWhatToDoDesc.
  ///
  /// In it, this message translates to:
  /// **'1. Completa o sposta item esistenti prima di iniziarne di nuovi\n2. Aiuta i colleghi a sbloccare item in review\n3. Analizza perche il limite e stato superato'**
  String get kanbanWipWhatToDoDesc;

  /// No description provided for @kanbanUnderstood.
  ///
  /// In it, this message translates to:
  /// **'Ho capito'**
  String get kanbanUnderstood;

  /// No description provided for @kanbanBoardTitle.
  ///
  /// In it, this message translates to:
  /// **'Kanban Board'**
  String get kanbanBoardTitle;

  /// No description provided for @sprintTitle.
  ///
  /// In it, this message translates to:
  /// **'Sprint ({count})'**
  String sprintTitle(int count);

  /// No description provided for @sprintNew.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Sprint'**
  String get sprintNew;

  /// No description provided for @sprintNoSprints.
  ///
  /// In it, this message translates to:
  /// **'Nessuno sprint'**
  String get sprintNoSprints;

  /// No description provided for @sprintCreateFirst.
  ///
  /// In it, this message translates to:
  /// **'Crea il primo sprint per iniziare'**
  String get sprintCreateFirst;

  /// No description provided for @sprintNumber.
  ///
  /// In it, this message translates to:
  /// **'Sprint {number}'**
  String sprintNumber(int number);

  /// No description provided for @sprintStart.
  ///
  /// In it, this message translates to:
  /// **'Avvia Sprint'**
  String get sprintStart;

  /// No description provided for @sprintComplete.
  ///
  /// In it, this message translates to:
  /// **'Completa Sprint'**
  String get sprintComplete;

  /// No description provided for @sprintDays.
  ///
  /// In it, this message translates to:
  /// **'{days}g'**
  String sprintDays(int days);

  /// No description provided for @sprintStoriesCount.
  ///
  /// In it, this message translates to:
  /// **'{count}'**
  String sprintStoriesCount(int count);

  /// No description provided for @sprintStoriesLabel.
  ///
  /// In it, this message translates to:
  /// **'stories'**
  String get sprintStoriesLabel;

  /// No description provided for @sprintPointsPlanned.
  ///
  /// In it, this message translates to:
  /// **'pts'**
  String get sprintPointsPlanned;

  /// No description provided for @sprintPointsCompleted.
  ///
  /// In it, this message translates to:
  /// **'completati'**
  String get sprintPointsCompleted;

  /// No description provided for @sprintVelocity.
  ///
  /// In it, this message translates to:
  /// **'velocity'**
  String get sprintVelocity;

  /// No description provided for @sprintDaysRemaining.
  ///
  /// In it, this message translates to:
  /// **'{days}g rimanenti'**
  String sprintDaysRemaining(int days);

  /// No description provided for @sprintStartButton.
  ///
  /// In it, this message translates to:
  /// **'Avvia'**
  String get sprintStartButton;

  /// No description provided for @sprintCompleteActiveFirst.
  ///
  /// In it, this message translates to:
  /// **'Completa lo sprint attivo prima di avviarne un altro'**
  String get sprintCompleteActiveFirst;

  /// No description provided for @sprintEditTitle.
  ///
  /// In it, this message translates to:
  /// **'Modifica Sprint'**
  String get sprintEditTitle;

  /// No description provided for @sprintNewTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuovo Sprint'**
  String get sprintNewTitle;

  /// No description provided for @sprintNameLabel.
  ///
  /// In it, this message translates to:
  /// **'Nome Sprint'**
  String get sprintNameLabel;

  /// No description provided for @sprintNameHint.
  ///
  /// In it, this message translates to:
  /// **'es. Sprint 1 - MVP'**
  String get sprintNameHint;

  /// No description provided for @sprintNameRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nome'**
  String get sprintNameRequired;

  /// No description provided for @sprintGoalLabel.
  ///
  /// In it, this message translates to:
  /// **'Sprint Goal'**
  String get sprintGoalLabel;

  /// No description provided for @sprintGoalHint.
  ///
  /// In it, this message translates to:
  /// **'Obiettivo dello sprint'**
  String get sprintGoalHint;

  /// No description provided for @sprintStartDateLabel.
  ///
  /// In it, this message translates to:
  /// **'Data Inizio'**
  String get sprintStartDateLabel;

  /// No description provided for @sprintEndDateLabel.
  ///
  /// In it, this message translates to:
  /// **'Data Fine'**
  String get sprintEndDateLabel;

  /// No description provided for @sprintDuration.
  ///
  /// In it, this message translates to:
  /// **'Durata: {days} giorni'**
  String sprintDuration(int days);

  /// No description provided for @sprintAverageVelocity.
  ///
  /// In it, this message translates to:
  /// **'Velocity media: {velocity} pts/sprint'**
  String sprintAverageVelocity(String velocity);

  /// No description provided for @sprintTeamMembers.
  ///
  /// In it, this message translates to:
  /// **'Team: {count} membri'**
  String sprintTeamMembers(int count);

  /// No description provided for @sprintPlanningTitle.
  ///
  /// In it, this message translates to:
  /// **'Sprint Planning'**
  String get sprintPlanningTitle;

  /// No description provided for @sprintPlanningSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Seleziona le storie da completare in questo sprint'**
  String get sprintPlanningSubtitle;

  /// No description provided for @sprintPlanningSelected.
  ///
  /// In it, this message translates to:
  /// **'Selezionati'**
  String get sprintPlanningSelected;

  /// No description provided for @sprintPlanningSuggested.
  ///
  /// In it, this message translates to:
  /// **'Suggeriti'**
  String get sprintPlanningSuggested;

  /// No description provided for @sprintPlanningCapacity.
  ///
  /// In it, this message translates to:
  /// **'Capacita'**
  String get sprintPlanningCapacity;

  /// No description provided for @sprintPlanningBasedOnVelocity.
  ///
  /// In it, this message translates to:
  /// **'basato su velocity media'**
  String get sprintPlanningBasedOnVelocity;

  /// No description provided for @sprintPlanningDays.
  ///
  /// In it, this message translates to:
  /// **'{days} giorni'**
  String sprintPlanningDays(int days);

  /// No description provided for @sprintPlanningExceeded.
  ///
  /// In it, this message translates to:
  /// **'Attenzione: superata la velocity suggerita'**
  String get sprintPlanningExceeded;

  /// No description provided for @sprintPlanningNoStories.
  ///
  /// In it, this message translates to:
  /// **'Nessuna story disponibile nel backlog'**
  String get sprintPlanningNoStories;

  /// No description provided for @sprintPlanningNotEstimated.
  ///
  /// In it, this message translates to:
  /// **'Non stimata'**
  String get sprintPlanningNotEstimated;

  /// No description provided for @sprintPlanningConfirm.
  ///
  /// In it, this message translates to:
  /// **'Conferma ({count} stories)'**
  String sprintPlanningConfirm(int count);

  /// No description provided for @storyFormEditTitle.
  ///
  /// In it, this message translates to:
  /// **'Modifica Story'**
  String get storyFormEditTitle;

  /// No description provided for @storyFormNewTitle.
  ///
  /// In it, this message translates to:
  /// **'Nuova User Story'**
  String get storyFormNewTitle;

  /// No description provided for @storyFormDetailsTab.
  ///
  /// In it, this message translates to:
  /// **'Dettagli'**
  String get storyFormDetailsTab;

  /// No description provided for @storyFormAcceptanceTab.
  ///
  /// In it, this message translates to:
  /// **'Acceptance Criteria'**
  String get storyFormAcceptanceTab;

  /// No description provided for @storyFormOtherTab.
  ///
  /// In it, this message translates to:
  /// **'Altro'**
  String get storyFormOtherTab;

  /// No description provided for @storyFormTitleLabel.
  ///
  /// In it, this message translates to:
  /// **'Titolo *'**
  String get storyFormTitleLabel;

  /// No description provided for @storyFormTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Es: US-123: Come utente voglio...'**
  String get storyFormTitleHint;

  /// No description provided for @storyFormTitleRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un titolo'**
  String get storyFormTitleRequired;

  /// No description provided for @storyFormUseTemplate.
  ///
  /// In it, this message translates to:
  /// **'Usa template User Story'**
  String get storyFormUseTemplate;

  /// No description provided for @storyFormTemplateSubtitle.
  ///
  /// In it, this message translates to:
  /// **'As a... I want... So that...'**
  String get storyFormTemplateSubtitle;

  /// No description provided for @storyFormAsA.
  ///
  /// In it, this message translates to:
  /// **'As a...'**
  String get storyFormAsA;

  /// No description provided for @storyFormAsAHint.
  ///
  /// In it, this message translates to:
  /// **'utente, admin, cliente...'**
  String get storyFormAsAHint;

  /// No description provided for @storyFormIWant.
  ///
  /// In it, this message translates to:
  /// **'I want...'**
  String get storyFormIWant;

  /// No description provided for @storyFormIWantHint.
  ///
  /// In it, this message translates to:
  /// **'poter fare qualcosa...'**
  String get storyFormIWantHint;

  /// No description provided for @storyFormIWantRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci cosa vuole l\'utente'**
  String get storyFormIWantRequired;

  /// No description provided for @storyFormSoThat.
  ///
  /// In it, this message translates to:
  /// **'So that...'**
  String get storyFormSoThat;

  /// No description provided for @storyFormSoThatHint.
  ///
  /// In it, this message translates to:
  /// **'ottenere un beneficio...'**
  String get storyFormSoThatHint;

  /// No description provided for @storyFormDescriptionLabel.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get storyFormDescriptionLabel;

  /// No description provided for @storyFormDescriptionHint.
  ///
  /// In it, this message translates to:
  /// **'Criteri di accettazione, note...'**
  String get storyFormDescriptionHint;

  /// No description provided for @storyFormDescriptionRequired.
  ///
  /// In it, this message translates to:
  /// **'Inserisci una descrizione'**
  String get storyFormDescriptionRequired;

  /// No description provided for @storyFormPreview.
  ///
  /// In it, this message translates to:
  /// **'Anteprima:'**
  String get storyFormPreview;

  /// No description provided for @storyFormEmptyDescription.
  ///
  /// In it, this message translates to:
  /// **'(descrizione vuota)'**
  String get storyFormEmptyDescription;

  /// No description provided for @storyFormAcceptanceCriteriaTitle.
  ///
  /// In it, this message translates to:
  /// **'Acceptance Criteria'**
  String get storyFormAcceptanceCriteriaTitle;

  /// No description provided for @storyFormAcceptanceCriteriaSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Definisci quando la story puo considerarsi completata'**
  String get storyFormAcceptanceCriteriaSubtitle;

  /// No description provided for @storyFormAddCriterionHint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi criterio di accettazione...'**
  String get storyFormAddCriterionHint;

  /// No description provided for @storyFormNoCriteria.
  ///
  /// In it, this message translates to:
  /// **'Nessun criterio definito'**
  String get storyFormNoCriteria;

  /// No description provided for @storyFormSuggestions.
  ///
  /// In it, this message translates to:
  /// **'Suggerimenti:'**
  String get storyFormSuggestions;

  /// No description provided for @storyFormSuggestion1.
  ///
  /// In it, this message translates to:
  /// **'I dati vengono salvati correttamente'**
  String get storyFormSuggestion1;

  /// No description provided for @storyFormSuggestion2.
  ///
  /// In it, this message translates to:
  /// **'L\'utente riceve una conferma'**
  String get storyFormSuggestion2;

  /// No description provided for @storyFormSuggestion3.
  ///
  /// In it, this message translates to:
  /// **'Il form mostra errori di validazione'**
  String get storyFormSuggestion3;

  /// No description provided for @storyFormSuggestion4.
  ///
  /// In it, this message translates to:
  /// **'La funzionalita e accessibile da mobile'**
  String get storyFormSuggestion4;

  /// No description provided for @storyFormPriorityLabel.
  ///
  /// In it, this message translates to:
  /// **'Priorita (MoSCoW)'**
  String get storyFormPriorityLabel;

  /// No description provided for @storyFormBusinessValueLabel.
  ///
  /// In it, this message translates to:
  /// **'Business Value'**
  String get storyFormBusinessValueLabel;

  /// No description provided for @storyFormBusinessValueHigh.
  ///
  /// In it, this message translates to:
  /// **'Alto valore di business'**
  String get storyFormBusinessValueHigh;

  /// No description provided for @storyFormBusinessValueMedium.
  ///
  /// In it, this message translates to:
  /// **'Valore medio'**
  String get storyFormBusinessValueMedium;

  /// No description provided for @storyFormBusinessValueLow.
  ///
  /// In it, this message translates to:
  /// **'Basso valore di business'**
  String get storyFormBusinessValueLow;

  /// No description provided for @storyFormStoryPointsLabel.
  ///
  /// In it, this message translates to:
  /// **'Stimata in Story Points'**
  String get storyFormStoryPointsLabel;

  /// No description provided for @storyFormStoryPointsTooltip.
  ///
  /// In it, this message translates to:
  /// **'Gli Story Points rappresentano la complessita relativa del lavoro.\nUsa la sequenza di Fibonacci: 1 (semplice) -> 21 (molto complessa).'**
  String get storyFormStoryPointsTooltip;

  /// No description provided for @storyFormNoPoints.
  ///
  /// In it, this message translates to:
  /// **'Nessuna'**
  String get storyFormNoPoints;

  /// No description provided for @storyFormPointsSimple.
  ///
  /// In it, this message translates to:
  /// **'Compito rapido e semplice'**
  String get storyFormPointsSimple;

  /// No description provided for @storyFormPointsMedium.
  ///
  /// In it, this message translates to:
  /// **'Compito di media complessita'**
  String get storyFormPointsMedium;

  /// No description provided for @storyFormPointsComplex.
  ///
  /// In it, this message translates to:
  /// **'Compito complesso, richiede analisi'**
  String get storyFormPointsComplex;

  /// No description provided for @storyFormPointsVeryComplex.
  ///
  /// In it, this message translates to:
  /// **'Molto complesso, considera di spezzare la story'**
  String get storyFormPointsVeryComplex;

  /// No description provided for @storyFormTagsLabel.
  ///
  /// In it, this message translates to:
  /// **'Tags'**
  String get storyFormTagsLabel;

  /// No description provided for @storyFormAddTagHint.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi tag...'**
  String get storyFormAddTagHint;

  /// No description provided for @storyFormExistingTags.
  ///
  /// In it, this message translates to:
  /// **'Tag esistenti:'**
  String get storyFormExistingTags;

  /// No description provided for @storyFormAssigneeLabel.
  ///
  /// In it, this message translates to:
  /// **'Assegna a'**
  String get storyFormAssigneeLabel;

  /// No description provided for @storyFormAssigneeHint.
  ///
  /// In it, this message translates to:
  /// **'Seleziona un membro del team'**
  String get storyFormAssigneeHint;

  /// No description provided for @storyFormNotAssigned.
  ///
  /// In it, this message translates to:
  /// **'Non assegnato'**
  String get storyFormNotAssigned;

  /// No description provided for @storyDetailPointsLabel.
  ///
  /// In it, this message translates to:
  /// **'{points} punti'**
  String storyDetailPointsLabel(int points);

  /// No description provided for @storyDetailDescriptionTitle.
  ///
  /// In it, this message translates to:
  /// **'Descrizione'**
  String get storyDetailDescriptionTitle;

  /// No description provided for @storyDetailNoDescription.
  ///
  /// In it, this message translates to:
  /// **'Nessuna descrizione'**
  String get storyDetailNoDescription;

  /// No description provided for @storyDetailAcceptanceCriteria.
  ///
  /// In it, this message translates to:
  /// **'Acceptance Criteria ({completed}/{total})'**
  String storyDetailAcceptanceCriteria(int completed, int total);

  /// No description provided for @storyDetailNoCriteria.
  ///
  /// In it, this message translates to:
  /// **'Nessun criterio definito'**
  String get storyDetailNoCriteria;

  /// No description provided for @storyDetailEstimationTitle.
  ///
  /// In it, this message translates to:
  /// **'Stima'**
  String get storyDetailEstimationTitle;

  /// No description provided for @storyDetailFinalEstimate.
  ///
  /// In it, this message translates to:
  /// **'Stima finale: '**
  String get storyDetailFinalEstimate;

  /// No description provided for @storyDetailEstimatesReceived.
  ///
  /// In it, this message translates to:
  /// **'{count} stime ricevute'**
  String storyDetailEstimatesReceived(int count);

  /// No description provided for @storyDetailInfoTitle.
  ///
  /// In it, this message translates to:
  /// **'Informazioni'**
  String get storyDetailInfoTitle;

  /// No description provided for @storyDetailBusinessValue.
  ///
  /// In it, this message translates to:
  /// **'Business Value'**
  String get storyDetailBusinessValue;

  /// No description provided for @storyDetailAssignedTo.
  ///
  /// In it, this message translates to:
  /// **'Assegnato a'**
  String get storyDetailAssignedTo;

  /// No description provided for @storyDetailSprint.
  ///
  /// In it, this message translates to:
  /// **'Sprint'**
  String get storyDetailSprint;

  /// No description provided for @storyDetailCreatedAt.
  ///
  /// In it, this message translates to:
  /// **'Creato il'**
  String get storyDetailCreatedAt;

  /// No description provided for @storyDetailStartedAt.
  ///
  /// In it, this message translates to:
  /// **'Iniziato il'**
  String get storyDetailStartedAt;

  /// No description provided for @storyDetailCompletedAt.
  ///
  /// In it, this message translates to:
  /// **'Completato il'**
  String get storyDetailCompletedAt;

  /// No description provided for @landingBadge.
  ///
  /// In it, this message translates to:
  /// **'Strumenti per team agili'**
  String get landingBadge;

  /// No description provided for @landingHeroTitle.
  ///
  /// In it, this message translates to:
  /// **'Build better products\nwith Keisen'**
  String get landingHeroTitle;

  /// No description provided for @landingHeroSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Prioritizza, stima e gestisci i tuoi progetti con strumenti collaborativi. Tutto in un unico posto, gratis.'**
  String get landingHeroSubtitle;

  /// No description provided for @landingStartFree.
  ///
  /// In it, this message translates to:
  /// **'Inizia Gratis'**
  String get landingStartFree;

  /// No description provided for @landingEverythingNeed.
  ///
  /// In it, this message translates to:
  /// **'Tutto ciò di cui hai bisogno'**
  String get landingEverythingNeed;

  /// No description provided for @landingModernTools.
  ///
  /// In it, this message translates to:
  /// **'Strumenti progettati per team moderni'**
  String get landingModernTools;

  /// No description provided for @landingSmartTodoBadge.
  ///
  /// In it, this message translates to:
  /// **'Produttività'**
  String get landingSmartTodoBadge;

  /// No description provided for @landingSmartTodoTitle.
  ///
  /// In it, this message translates to:
  /// **'Smart Todo List'**
  String get landingSmartTodoTitle;

  /// No description provided for @landingSmartTodoSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Gestione task intelligente e collaborativa per team moderni'**
  String get landingSmartTodoSubtitle;

  /// No description provided for @landingSmartTodoCollaborativeTitle.
  ///
  /// In it, this message translates to:
  /// **'Liste Task Collaborative'**
  String get landingSmartTodoCollaborativeTitle;

  /// No description provided for @landingSmartTodoCollaborativeDesc.
  ///
  /// In it, this message translates to:
  /// **'Smart Todo trasforma la gestione delle attività quotidiane in un processo fluido e collaborativo. Crea liste, assegna task ai membri del team e monitora il progresso in tempo reale.\n\nIdeale per team distribuiti che necessitano di sincronizzazione continua sulle attività da completare.'**
  String get landingSmartTodoCollaborativeDesc;

  /// No description provided for @landingSmartTodoImportTitle.
  ///
  /// In it, this message translates to:
  /// **'Import Flessibile'**
  String get landingSmartTodoImportTitle;

  /// No description provided for @landingSmartTodoImportDesc.
  ///
  /// In it, this message translates to:
  /// **'Importa le tue attività da fonti esterne in pochi click. Supporto per file CSV, copia/incolla da Excel o testo libero. Il sistema riconosce automaticamente la struttura dei dati.\n\nMigra facilmente da altri tool senza perdere informazioni o dover reinserire manualmente ogni task.'**
  String get landingSmartTodoImportDesc;

  /// No description provided for @landingSmartTodoShareTitle.
  ///
  /// In it, this message translates to:
  /// **'Condivisione e Inviti'**
  String get landingSmartTodoShareTitle;

  /// No description provided for @landingSmartTodoShareDesc.
  ///
  /// In it, this message translates to:
  /// **'Invita colleghi e collaboratori alle tue liste tramite email. Ogni partecipante può visualizzare, commentare e aggiornare lo stato dei task assegnati.\n\nPerfetto per gestire progetti trasversali con stakeholder esterni o team cross-funzionali.'**
  String get landingSmartTodoShareDesc;

  /// No description provided for @landingSmartTodoFeaturesTitle.
  ///
  /// In it, this message translates to:
  /// **'Funzionalità Smart Todo'**
  String get landingSmartTodoFeaturesTitle;

  /// No description provided for @landingEisenhowerBadge.
  ///
  /// In it, this message translates to:
  /// **'Prioritizzazione'**
  String get landingEisenhowerBadge;

  /// No description provided for @landingEisenhowerSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Il metodo decisionale usato dai leader per gestire il tempo'**
  String get landingEisenhowerSubtitle;

  /// No description provided for @landingEisenhowerUrgentImportantTitle.
  ///
  /// In it, this message translates to:
  /// **'Urgente vs Importante'**
  String get landingEisenhowerUrgentImportantTitle;

  /// No description provided for @landingEisenhowerUrgentImportantDesc.
  ///
  /// In it, this message translates to:
  /// **'La Matrice di Eisenhower, ideata dal 34° Presidente degli Stati Uniti Dwight D. Eisenhower, divide le attività in quattro quadranti basati su due criteri: urgenza e importanza.\n\nQuesto framework decisionale aiuta a distinguere ciò che richiede attenzione immediata da ciò che contribuisce agli obiettivi a lungo termine.'**
  String get landingEisenhowerUrgentImportantDesc;

  /// No description provided for @landingEisenhowerDecisionsTitle.
  ///
  /// In it, this message translates to:
  /// **'Decisioni Migliori'**
  String get landingEisenhowerDecisionsTitle;

  /// No description provided for @landingEisenhowerDecisionsDesc.
  ///
  /// In it, this message translates to:
  /// **'Applicando costantemente la matrice, sviluppi un mindset orientato ai risultati. Impari a dire \"no\" alle distrazioni e a concentrarti su ciò che genera valore reale.\n\nIl nostro strumento digitale rende questo processo immediato: trascina le attività nel quadrante corretto e ottieni una visione chiara delle tue priorità.'**
  String get landingEisenhowerDecisionsDesc;

  /// No description provided for @landingEisenhowerBenefitsTitle.
  ///
  /// In it, this message translates to:
  /// **'Perché usare la Matrice di Eisenhower?'**
  String get landingEisenhowerBenefitsTitle;

  /// No description provided for @landingEisenhowerBenefitsDesc.
  ///
  /// In it, this message translates to:
  /// **'Studi dimostrano che il 80% delle attività quotidiane ricade nei quadranti 3 e 4 (non importanti). La matrice ti aiuta a identificarle e liberare tempo per ciò che conta davvero.'**
  String get landingEisenhowerBenefitsDesc;

  /// No description provided for @landingEisenhowerQuadrants.
  ///
  /// In it, this message translates to:
  /// **'Quadrante 1: Urgente + Importante → Fai subito\nQuadrante 2: Non urgente + Importante → Pianifica\nQuadrante 3: Urgente + Non importante → Delega\nQuadrante 4: Non urgente + Non importante → Elimina'**
  String get landingEisenhowerQuadrants;

  /// No description provided for @landingAgileBadge.
  ///
  /// In it, this message translates to:
  /// **'Metodologie'**
  String get landingAgileBadge;

  /// No description provided for @landingAgileTitle.
  ///
  /// In it, this message translates to:
  /// **'Agile & Scrum Framework'**
  String get landingAgileTitle;

  /// No description provided for @landingAgileSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Implementa le migliori pratiche di sviluppo software iterativo'**
  String get landingAgileSubtitle;

  /// No description provided for @landingAgileIterativeTitle.
  ///
  /// In it, this message translates to:
  /// **'Sviluppo Iterativo e Incrementale'**
  String get landingAgileIterativeTitle;

  /// No description provided for @landingAgileIterativeDesc.
  ///
  /// In it, this message translates to:
  /// **'L\'approccio Agile divide il lavoro in cicli brevi chiamati Sprint, tipicamente di 1-4 settimane. Ogni iterazione produce un incremento funzionante del prodotto.\n\nCon Keisen puoi gestire il tuo backlog, pianificare sprint e monitorare la velocity del team in tempo reale.'**
  String get landingAgileIterativeDesc;

  /// No description provided for @landingAgileScrumTitle.
  ///
  /// In it, this message translates to:
  /// **'Framework Scrum'**
  String get landingAgileScrumTitle;

  /// No description provided for @landingAgileScrumDesc.
  ///
  /// In it, this message translates to:
  /// **'Scrum è il framework Agile più diffuso. Definisce ruoli (Product Owner, Scrum Master, Team), eventi (Sprint Planning, Daily, Review, Retrospective) e artefatti (Product Backlog, Sprint Backlog).\n\nKeisen supporta tutti gli eventi Scrum con strumenti dedicati per ogni cerimonia.'**
  String get landingAgileScrumDesc;

  /// No description provided for @landingAgileKanbanTitle.
  ///
  /// In it, this message translates to:
  /// **'Kanban Board'**
  String get landingAgileKanbanTitle;

  /// No description provided for @landingAgileKanbanDesc.
  ///
  /// In it, this message translates to:
  /// **'Il metodo Kanban visualizza il flusso di lavoro attraverso colonne che rappresentano gli stati del processo. Limita il Work In Progress (WIP) per massimizzare il throughput.\n\nLa nostra Kanban board supporta personalizzazione delle colonne, WIP limits e metriche di flusso.'**
  String get landingAgileKanbanDesc;

  /// No description provided for @landingEstimationBadge.
  ///
  /// In it, this message translates to:
  /// **'Estimation'**
  String get landingEstimationBadge;

  /// No description provided for @landingEstimationTitle.
  ///
  /// In it, this message translates to:
  /// **'Tecniche di Stima Collaborative'**
  String get landingEstimationTitle;

  /// No description provided for @landingEstimationSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Scegli il metodo più adatto al tuo team per stime accurate'**
  String get landingEstimationSubtitle;

  /// No description provided for @landingEstimationFeaturesTitle.
  ///
  /// In it, this message translates to:
  /// **'Estimation Room Features'**
  String get landingEstimationFeaturesTitle;

  /// No description provided for @landingRetroBadge.
  ///
  /// In it, this message translates to:
  /// **'Retrospective'**
  String get landingRetroBadge;

  /// No description provided for @landingRetroTitle.
  ///
  /// In it, this message translates to:
  /// **'Retrospettive Interattive'**
  String get landingRetroTitle;

  /// No description provided for @landingRetroSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Strumenti collaborativi in tempo reale: timer, voto anonimo, action items e report AI.'**
  String get landingRetroSubtitle;

  /// No description provided for @landingRetroActionTitle.
  ///
  /// In it, this message translates to:
  /// **'Action Items Tracking'**
  String get landingRetroActionTitle;

  /// No description provided for @landingRetroActionDesc.
  ///
  /// In it, this message translates to:
  /// **'Ogni retrospettiva genera action items tracciabili con owner, deadline e stato. Monitora il follow-up nel tempo.'**
  String get landingRetroActionDesc;

  /// No description provided for @landingWorkflowBadge.
  ///
  /// In it, this message translates to:
  /// **'Workflow'**
  String get landingWorkflowBadge;

  /// No description provided for @landingWorkflowTitle.
  ///
  /// In it, this message translates to:
  /// **'Come funziona'**
  String get landingWorkflowTitle;

  /// No description provided for @landingWorkflowSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Inizia in 3 semplici passi'**
  String get landingWorkflowSubtitle;

  /// No description provided for @landingStep1Title.
  ///
  /// In it, this message translates to:
  /// **'Crea un progetto'**
  String get landingStep1Title;

  /// No description provided for @landingStep1Desc.
  ///
  /// In it, this message translates to:
  /// **'Crea il tuo progetto Agile e invita il team. Configura sprint, backlog e board.'**
  String get landingStep1Desc;

  /// No description provided for @landingStep2Title.
  ///
  /// In it, this message translates to:
  /// **'Collabora'**
  String get landingStep2Title;

  /// No description provided for @landingStep2Desc.
  ///
  /// In it, this message translates to:
  /// **'Stima le user stories insieme, organizza sprint e traccia il progresso in real-time.'**
  String get landingStep2Desc;

  /// No description provided for @landingStep3Title.
  ///
  /// In it, this message translates to:
  /// **'Migliora'**
  String get landingStep3Title;

  /// No description provided for @landingStep3Desc.
  ///
  /// In it, this message translates to:
  /// **'Analizza le metriche, conduci retrospettive e migliora continuamente il processo.'**
  String get landingStep3Desc;

  /// No description provided for @landingCtaTitle.
  ///
  /// In it, this message translates to:
  /// **'Ready to start?'**
  String get landingCtaTitle;

  /// No description provided for @landingCtaDesc.
  ///
  /// In it, this message translates to:
  /// **'Accedi gratuitamente e inizia a collaborare con il tuo team.'**
  String get landingCtaDesc;

  /// No description provided for @landingFooterBrandDesc.
  ///
  /// In it, this message translates to:
  /// **'Strumenti collaborativi per team agili.\nPianifica, stima e migliora insieme.'**
  String get landingFooterBrandDesc;

  /// No description provided for @landingFooterProduct.
  ///
  /// In it, this message translates to:
  /// **'Prodotto'**
  String get landingFooterProduct;

  /// No description provided for @landingFooterResources.
  ///
  /// In it, this message translates to:
  /// **'Risorse'**
  String get landingFooterResources;

  /// No description provided for @landingFooterCompany.
  ///
  /// In it, this message translates to:
  /// **'Azienda'**
  String get landingFooterCompany;

  /// No description provided for @landingFooterLegal.
  ///
  /// In it, this message translates to:
  /// **'Legale'**
  String get landingFooterLegal;

  /// No description provided for @landingCopyright.
  ///
  /// In it, this message translates to:
  /// **'© 2026 Keisen. Tutti i diritti riservati.'**
  String get landingCopyright;

  /// No description provided for @featureSmartImportDesc.
  ///
  /// In it, this message translates to:
  /// **'Creazione rapida task con descrizione\nAssegnazione a membri del team\nPriorità e deadline configurabili\nNotifiche di completamento'**
  String get featureSmartImportDesc;

  /// No description provided for @featureImportDesc.
  ///
  /// In it, this message translates to:
  /// **'Import da file CSV\nCopia/incolla da Excel\nParsing testo intelligente\nMapping campi automatico'**
  String get featureImportDesc;

  /// No description provided for @featureShareDesc.
  ///
  /// In it, this message translates to:
  /// **'Inviti via email\nPermessi configurabili\nCommenti sui task\nStorico modifiche'**
  String get featureShareDesc;

  /// No description provided for @featureSmartTaskCreation.
  ///
  /// In it, this message translates to:
  /// **'Creazione rapida task'**
  String get featureSmartTaskCreation;

  /// No description provided for @featureTeamAssignment.
  ///
  /// In it, this message translates to:
  /// **'Assegnazione al team'**
  String get featureTeamAssignment;

  /// No description provided for @featurePriorityDeadline.
  ///
  /// In it, this message translates to:
  /// **'Priorità e Scadenze'**
  String get featurePriorityDeadline;

  /// No description provided for @featureCompletionNotifications.
  ///
  /// In it, this message translates to:
  /// **'Notifiche completamento'**
  String get featureCompletionNotifications;

  /// No description provided for @featureCsvImport.
  ///
  /// In it, this message translates to:
  /// **'Import CSV'**
  String get featureCsvImport;

  /// No description provided for @featureExcelPaste.
  ///
  /// In it, this message translates to:
  /// **'Copia/Incolla Excel'**
  String get featureExcelPaste;

  /// No description provided for @featureSmartParsing.
  ///
  /// In it, this message translates to:
  /// **'Parsing Intelligente'**
  String get featureSmartParsing;

  /// No description provided for @featureAutoMapping.
  ///
  /// In it, this message translates to:
  /// **'Mapping Automatico'**
  String get featureAutoMapping;

  /// No description provided for @featureEmailInvites.
  ///
  /// In it, this message translates to:
  /// **'Inviti Email'**
  String get featureEmailInvites;

  /// No description provided for @featurePermissions.
  ///
  /// In it, this message translates to:
  /// **'Permessi Configurabili'**
  String get featurePermissions;

  /// No description provided for @featureTaskComments.
  ///
  /// In it, this message translates to:
  /// **'Commenti Task'**
  String get featureTaskComments;

  /// No description provided for @featureHistory.
  ///
  /// In it, this message translates to:
  /// **'Storico Modifiche'**
  String get featureHistory;

  /// No description provided for @featureAdvancedFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri Avanzati'**
  String get featureAdvancedFilters;

  /// No description provided for @featureFullTextSearch.
  ///
  /// In it, this message translates to:
  /// **'Ricerca Full-text'**
  String get featureFullTextSearch;

  /// No description provided for @featureSorting.
  ///
  /// In it, this message translates to:
  /// **'Ordinamento'**
  String get featureSorting;

  /// No description provided for @featureTagsCategories.
  ///
  /// In it, this message translates to:
  /// **'Tag & Categorie'**
  String get featureTagsCategories;

  /// No description provided for @featureArchiving.
  ///
  /// In it, this message translates to:
  /// **'Archiviazione'**
  String get featureArchiving;

  /// No description provided for @featureSort.
  ///
  /// In it, this message translates to:
  /// **'Ordinamento'**
  String get featureSort;

  /// No description provided for @featureDataExport.
  ///
  /// In it, this message translates to:
  /// **'Export Dati'**
  String get featureDataExport;

  /// No description provided for @landingIntroFeatures.
  ///
  /// In it, this message translates to:
  /// **'Sprint Planning con capacità team\nBacklog prioritizzato con drag & drop\nVelocity tracking e burndown chart\nDaily standup facilitato'**
  String get landingIntroFeatures;

  /// No description provided for @landingAgileScrumFeatures.
  ///
  /// In it, this message translates to:
  /// **'Product Backlog con story points\nSprint Backlog con task breakdown\nRetrospective board integrata\nMetriche Scrum automatiche'**
  String get landingAgileScrumFeatures;

  /// No description provided for @landingAgileKanbanFeatures.
  ///
  /// In it, this message translates to:
  /// **'Colonne personalizzabili\nWIP limits per colonna\nDrag & drop intuitivo\nLead time e cycle time'**
  String get landingAgileKanbanFeatures;

  /// No description provided for @landingEstimationPokerDesc.
  ///
  /// In it, this message translates to:
  /// **'Il metodo classico: ogni membro sceglie una carta (1, 2, 3, 5, 8...). Le stime sono rivelate simultaneamente per evitare bias.'**
  String get landingEstimationPokerDesc;

  /// No description provided for @landingEstimationTShirtTitle.
  ///
  /// In it, this message translates to:
  /// **'T-Shirt Size'**
  String get landingEstimationTShirtTitle;

  /// No description provided for @landingEstimationTShirtSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Taglie relative'**
  String get landingEstimationTShirtSubtitle;

  /// No description provided for @landingEstimationTShirtDesc.
  ///
  /// In it, this message translates to:
  /// **'Stima rapida usando taglie: XS, S, M, L, XL, XXL. Ideale per backlog grooming iniziale o quando serve una stima approssimativa.'**
  String get landingEstimationTShirtDesc;

  /// No description provided for @landingEstimationPertTitle.
  ///
  /// In it, this message translates to:
  /// **'Three-Point (PERT)'**
  String get landingEstimationPertTitle;

  /// No description provided for @landingEstimationPertSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Ottimista / Probabile / Pessimista'**
  String get landingEstimationPertSubtitle;

  /// No description provided for @landingEstimationPertDesc.
  ///
  /// In it, this message translates to:
  /// **'Tecnica statistica: ogni membro fornisce 3 stime (O, M, P). La formula PERT calcola la stima ponderata: (O + 4M + P) / 6.'**
  String get landingEstimationPertDesc;

  /// No description provided for @landingEstimationBucketTitle.
  ///
  /// In it, this message translates to:
  /// **'Bucket System'**
  String get landingEstimationBucketTitle;

  /// No description provided for @landingEstimationBucketSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Categorizzazione rapida'**
  String get landingEstimationBucketSubtitle;

  /// No description provided for @landingEstimationBucketDesc.
  ///
  /// In it, this message translates to:
  /// **'Le user stories vengono assegnate a \"bucket\" predefiniti. Ottimo per stimare grandi quantità di item velocemente in sessioni di refinement.'**
  String get landingEstimationBucketDesc;

  /// No description provided for @landingEstimationChipHiddenVote.
  ///
  /// In it, this message translates to:
  /// **'Voto nascosto'**
  String get landingEstimationChipHiddenVote;

  /// No description provided for @landingEstimationChipTimer.
  ///
  /// In it, this message translates to:
  /// **'Timer configurabile'**
  String get landingEstimationChipTimer;

  /// No description provided for @landingEstimationChipStats.
  ///
  /// In it, this message translates to:
  /// **'Statistiche real-time'**
  String get landingEstimationChipStats;

  /// No description provided for @landingEstimationChipParticipants.
  ///
  /// In it, this message translates to:
  /// **'Fino a 20 partecipanti'**
  String get landingEstimationChipParticipants;

  /// No description provided for @landingEstimationChipHistory.
  ///
  /// In it, this message translates to:
  /// **'Storico stime'**
  String get landingEstimationChipHistory;

  /// No description provided for @landingEstimationChipExport.
  ///
  /// In it, this message translates to:
  /// **'Export risultati'**
  String get landingEstimationChipExport;

  /// No description provided for @landingRetroTemplateStartStopTitle.
  ///
  /// In it, this message translates to:
  /// **'Start / Stop / Continue'**
  String get landingRetroTemplateStartStopTitle;

  /// No description provided for @landingRetroTemplateStartStopDesc.
  ///
  /// In it, this message translates to:
  /// **'Il formato classico: cosa iniziare a fare, cosa smettere di fare, cosa continuare a fare.'**
  String get landingRetroTemplateStartStopDesc;

  /// No description provided for @landingRetroTemplateMadSadTitle.
  ///
  /// In it, this message translates to:
  /// **'Mad / Sad / Glad'**
  String get landingRetroTemplateMadSadTitle;

  /// No description provided for @landingRetroTemplateMadSadDesc.
  ///
  /// In it, this message translates to:
  /// **'Retrospettiva emotiva: cosa ci ha fatto arrabbiare, rattristare o rallegrare.'**
  String get landingRetroTemplateMadSadDesc;

  /// No description provided for @landingRetroTemplate4LsTitle.
  ///
  /// In it, this message translates to:
  /// **'4L\'s'**
  String get landingRetroTemplate4LsTitle;

  /// No description provided for @landingRetroTemplate4LsDesc.
  ///
  /// In it, this message translates to:
  /// **'Liked, Learned, Lacked, Longed For - analisi completa dello sprint.'**
  String get landingRetroTemplate4LsDesc;

  /// No description provided for @landingRetroTemplateSailboatTitle.
  ///
  /// In it, this message translates to:
  /// **'Sailboat'**
  String get landingRetroTemplateSailboatTitle;

  /// No description provided for @landingRetroTemplateSailboatDesc.
  ///
  /// In it, this message translates to:
  /// **'Metafora visuale: vento (aiuti), ancora (ostacoli), rocce (rischi), isola (obiettivi).'**
  String get landingRetroTemplateSailboatDesc;

  /// No description provided for @landingRetroTemplateWentWellTitle.
  ///
  /// In it, this message translates to:
  /// **'Went Well / To Improve'**
  String get landingRetroTemplateWentWellTitle;

  /// No description provided for @landingRetroTemplateWentWellDesc.
  ///
  /// In it, this message translates to:
  /// **'Formato semplice e diretto: cosa è andato bene e cosa migliorare.'**
  String get landingRetroTemplateWentWellDesc;

  /// No description provided for @landingRetroTemplateDakiTitle.
  ///
  /// In it, this message translates to:
  /// **'DAKI'**
  String get landingRetroTemplateDakiTitle;

  /// No description provided for @landingRetroTemplateDakiDesc.
  ///
  /// In it, this message translates to:
  /// **'Drop, Add, Keep, Improve - decisioni concrete per il prossimo sprint.'**
  String get landingRetroTemplateDakiDesc;

  /// No description provided for @landingRetroFeatureTrackingTitle.
  ///
  /// In it, this message translates to:
  /// **'Action Items Tracking'**
  String get landingRetroFeatureTrackingTitle;

  /// No description provided for @landingRetroFeatureTrackingDesc.
  ///
  /// In it, this message translates to:
  /// **'Ogni retrospettiva genera action items tracciabili con owner, deadline e stato. Monitora il follow-up nel tempo.'**
  String get landingRetroFeatureTrackingDesc;

  /// No description provided for @landingAgileSectionBadge.
  ///
  /// In it, this message translates to:
  /// **'Metodologie'**
  String get landingAgileSectionBadge;

  /// No description provided for @landingAgileSectionTitle.
  ///
  /// In it, this message translates to:
  /// **'Agile & Scrum Framework'**
  String get landingAgileSectionTitle;

  /// No description provided for @landingAgileSectionSubtitle.
  ///
  /// In it, this message translates to:
  /// **'Implementa le migliori pratiche di sviluppo software iterativo'**
  String get landingAgileSectionSubtitle;

  /// No description provided for @landingSmartTodoCollabTitle.
  ///
  /// In it, this message translates to:
  /// **'Liste Task Collaborative'**
  String get landingSmartTodoCollabTitle;

  /// No description provided for @landingSmartTodoCollabDesc.
  ///
  /// In it, this message translates to:
  /// **'Smart Todo trasforma la gestione delle attività quotidiane in un processo fluido e collaborativo. Crea liste, assegna task ai membri del team e monitora il progresso in tempo reale.\n\nIdeale per team distribuiti che necessitano di sincronizzazione continua sulle attività da completare.'**
  String get landingSmartTodoCollabDesc;

  /// No description provided for @landingSmartTodoCollabFeatures.
  ///
  /// In it, this message translates to:
  /// **'Creazione rapida task con descrizione\nAssegnazione a membri del team\nPriorità e deadline configurabili\nNotifiche di completamento'**
  String get landingSmartTodoCollabFeatures;

  /// No description provided for @landingSmartTodoImportFeatures.
  ///
  /// In it, this message translates to:
  /// **'Import da file CSV\nCopia/incolla da Excel\nParsing testo intelligente\nMapping campi automatico'**
  String get landingSmartTodoImportFeatures;

  /// No description provided for @landingSmartTodoSharingTitle.
  ///
  /// In it, this message translates to:
  /// **'Condivisione e Inviti'**
  String get landingSmartTodoSharingTitle;

  /// No description provided for @landingSmartTodoSharingDesc.
  ///
  /// In it, this message translates to:
  /// **'Invita colleghi e collaboratori alle tue liste tramite email. Ogni partecipante può visualizzare, commentare e aggiornare lo stato dei task assegnati.\n\nPerfetto per gestire progetti trasversali con stakeholder esterni o team cross-funzionali.'**
  String get landingSmartTodoSharingDesc;

  /// No description provided for @landingSmartTodoSharingFeatures.
  ///
  /// In it, this message translates to:
  /// **'Inviti via email\nPermessi configurabili\nCommenti sui task\nStorico modifiche'**
  String get landingSmartTodoSharingFeatures;

  /// No description provided for @landingSmartTodoChipFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri avanzati'**
  String get landingSmartTodoChipFilters;

  /// No description provided for @landingSmartTodoChipSearch.
  ///
  /// In it, this message translates to:
  /// **'Ricerca full-text'**
  String get landingSmartTodoChipSearch;

  /// No description provided for @landingSmartTodoChipSort.
  ///
  /// In it, this message translates to:
  /// **'Ordinamento'**
  String get landingSmartTodoChipSort;

  /// No description provided for @landingSmartTodoChipTags.
  ///
  /// In it, this message translates to:
  /// **'Tag e categorie'**
  String get landingSmartTodoChipTags;

  /// No description provided for @landingSmartTodoChipArchive.
  ///
  /// In it, this message translates to:
  /// **'Archiviazione'**
  String get landingSmartTodoChipArchive;

  /// No description provided for @landingSmartTodoChipExport.
  ///
  /// In it, this message translates to:
  /// **'Export dati'**
  String get landingSmartTodoChipExport;

  /// No description provided for @landingEisenhowerTitle.
  ///
  /// In it, this message translates to:
  /// **'Matrice di Eisenhower'**
  String get landingEisenhowerTitle;

  /// No description provided for @landingEisenhowerUrgentTitle.
  ///
  /// In it, this message translates to:
  /// **'Urgente vs Importante'**
  String get landingEisenhowerUrgentTitle;

  /// No description provided for @landingEisenhowerUrgentDesc.
  ///
  /// In it, this message translates to:
  /// **'La Matrice di Eisenhower, ideata dal 34° Presidente degli Stati Uniti Dwight D. Eisenhower, divide le attività in quattro quadranti basati su due criteri: urgenza e importanza.\n\nQuesto framework decisionale aiuta a distinguere ciò che richiede attenzione immediata da ciò che contribuisce agli obiettivi a lungo termine.'**
  String get landingEisenhowerUrgentDesc;

  /// No description provided for @landingEisenhowerUrgentFeatures.
  ///
  /// In it, this message translates to:
  /// **'Quadrante 1: Urgente + Importante → Fai subito\nQuadrante 2: Non urgente + Importante → Pianifica\nQuadrante 3: Urgente + Non importante → Delega\nQuadrante 4: Non urgente + Non importante → Elimina'**
  String get landingEisenhowerUrgentFeatures;

  /// No description provided for @landingEisenhowerDecisionsFeatures.
  ///
  /// In it, this message translates to:
  /// **'Drag & drop intuitivo\nCollaborazione team in tempo reale\nStatistiche di distribuzione\nExport per reportistica'**
  String get landingEisenhowerDecisionsFeatures;

  /// No description provided for @landingEisenhowerUrgentLabel.
  ///
  /// In it, this message translates to:
  /// **'URGENTE'**
  String get landingEisenhowerUrgentLabel;

  /// No description provided for @landingEisenhowerNotUrgentLabel.
  ///
  /// In it, this message translates to:
  /// **'NON URGENTE'**
  String get landingEisenhowerNotUrgentLabel;

  /// No description provided for @landingEisenhowerImportantLabel.
  ///
  /// In it, this message translates to:
  /// **'IMPORTANTE'**
  String get landingEisenhowerImportantLabel;

  /// No description provided for @landingEisenhowerNotImportantLabel.
  ///
  /// In it, this message translates to:
  /// **'NON IMPORTANTE'**
  String get landingEisenhowerNotImportantLabel;

  /// No description provided for @landingEisenhowerDoLabel.
  ///
  /// In it, this message translates to:
  /// **'FAI'**
  String get landingEisenhowerDoLabel;

  /// No description provided for @landingEisenhowerDoDesc.
  ///
  /// In it, this message translates to:
  /// **'Crisi, deadline, emergenze'**
  String get landingEisenhowerDoDesc;

  /// No description provided for @landingEisenhowerPlanLabel.
  ///
  /// In it, this message translates to:
  /// **'PIANIFICA'**
  String get landingEisenhowerPlanLabel;

  /// No description provided for @landingEisenhowerPlanDesc.
  ///
  /// In it, this message translates to:
  /// **'Strategia, crescita, relazioni'**
  String get landingEisenhowerPlanDesc;

  /// No description provided for @landingEisenhowerDelegateLabel.
  ///
  /// In it, this message translates to:
  /// **'DELEGA'**
  String get landingEisenhowerDelegateLabel;

  /// No description provided for @landingEisenhowerDelegateDesc.
  ///
  /// In it, this message translates to:
  /// **'Interruzioni, meeting, email'**
  String get landingEisenhowerDelegateDesc;

  /// No description provided for @landingEisenhowerEliminateLabel.
  ///
  /// In it, this message translates to:
  /// **'ELIMINA'**
  String get landingEisenhowerEliminateLabel;

  /// No description provided for @landingEisenhowerEliminateDesc.
  ///
  /// In it, this message translates to:
  /// **'Distrazioni, social, perdite di tempo'**
  String get landingEisenhowerEliminateDesc;

  /// No description provided for @landingFooterFeatures.
  ///
  /// In it, this message translates to:
  /// **'Funzionalità'**
  String get landingFooterFeatures;

  /// No description provided for @landingFooterPricing.
  ///
  /// In it, this message translates to:
  /// **'Pricing'**
  String get landingFooterPricing;

  /// No description provided for @landingFooterChangelog.
  ///
  /// In it, this message translates to:
  /// **'Changelog'**
  String get landingFooterChangelog;

  /// No description provided for @landingFooterRoadmap.
  ///
  /// In it, this message translates to:
  /// **'Roadmap'**
  String get landingFooterRoadmap;

  /// No description provided for @landingFooterDocs.
  ///
  /// In it, this message translates to:
  /// **'Documentazione'**
  String get landingFooterDocs;

  /// No description provided for @landingFooterAgileGuides.
  ///
  /// In it, this message translates to:
  /// **'Guide Agile'**
  String get landingFooterAgileGuides;

  /// No description provided for @landingFooterBlog.
  ///
  /// In it, this message translates to:
  /// **'Blog'**
  String get landingFooterBlog;

  /// No description provided for @landingFooterCommunity.
  ///
  /// In it, this message translates to:
  /// **'Community'**
  String get landingFooterCommunity;

  /// No description provided for @landingFooterAbout.
  ///
  /// In it, this message translates to:
  /// **'Chi siamo'**
  String get landingFooterAbout;

  /// No description provided for @landingFooterContact.
  ///
  /// In it, this message translates to:
  /// **'Contatti'**
  String get landingFooterContact;

  /// No description provided for @landingFooterJobs.
  ///
  /// In it, this message translates to:
  /// **'Lavora con noi'**
  String get landingFooterJobs;

  /// No description provided for @landingFooterPress.
  ///
  /// In it, this message translates to:
  /// **'Press Kit'**
  String get landingFooterPress;

  /// No description provided for @landingFooterPrivacy.
  ///
  /// In it, this message translates to:
  /// **'Privacy Policy'**
  String get landingFooterPrivacy;

  /// No description provided for @landingFooterTerms.
  ///
  /// In it, this message translates to:
  /// **'Termini di Servizio'**
  String get landingFooterTerms;

  /// No description provided for @landingFooterCookies.
  ///
  /// In it, this message translates to:
  /// **'Cookie Policy'**
  String get landingFooterCookies;

  /// No description provided for @landingFooterGdpr.
  ///
  /// In it, this message translates to:
  /// **'GDPR'**
  String get landingFooterGdpr;

  /// No description provided for @legalCookieTitle.
  ///
  /// In it, this message translates to:
  /// **'Utilizziamo i cookie'**
  String get legalCookieTitle;

  /// No description provided for @legalCookieMessage.
  ///
  /// In it, this message translates to:
  /// **'Utilizziamo i cookie per migliorare la tua esperienza e per fini analitici. Continuando, accetti l\'uso dei cookie.'**
  String get legalCookieMessage;

  /// No description provided for @legalCookieAccept.
  ///
  /// In it, this message translates to:
  /// **'Accetta tutti'**
  String get legalCookieAccept;

  /// No description provided for @legalCookieRefuse.
  ///
  /// In it, this message translates to:
  /// **'Solo necessari'**
  String get legalCookieRefuse;

  /// No description provided for @legalCookiePolicy.
  ///
  /// In it, this message translates to:
  /// **'Cookie Policy'**
  String get legalCookiePolicy;

  /// No description provided for @legalPrivacyPolicy.
  ///
  /// In it, this message translates to:
  /// **'Privacy Policy'**
  String get legalPrivacyPolicy;

  /// No description provided for @legalTermsOfService.
  ///
  /// In it, this message translates to:
  /// **'Termini di Servizio'**
  String get legalTermsOfService;

  /// No description provided for @legalGDPR.
  ///
  /// In it, this message translates to:
  /// **'GDPR'**
  String get legalGDPR;

  /// No description provided for @legalLastUpdatedLabel.
  ///
  /// In it, this message translates to:
  /// **'Ultimo aggiornamento'**
  String get legalLastUpdatedLabel;

  /// No description provided for @legalLastUpdatedDate.
  ///
  /// In it, this message translates to:
  /// **'18 gennaio 2026'**
  String get legalLastUpdatedDate;

  /// No description provided for @legalAcceptTerms.
  ///
  /// In it, this message translates to:
  /// **'Accetto i Termini di Servizio e la Privacy Policy'**
  String get legalAcceptTerms;

  /// No description provided for @legalMustAcceptTerms.
  ///
  /// In it, this message translates to:
  /// **'Devi accettare i termini per continuare'**
  String get legalMustAcceptTerms;

  /// No description provided for @legalPrivacyContent.
  ///
  /// In it, this message translates to:
  /// **'## 1. Introduzione\nBenvenuto su **Keisen** (\"noi\", \"nostro\", \"la Piattaforma\"). La tua privacy è importante per noi. Questa Informativa sulla Privacy spiega come raccogliamo, utilizziamo, divulghiamo e proteggiamo le tue informazioni quando utilizzi la nostra applicazione web.\n\n## 2. Dati che raccogliamo\nRaccogliamo due tipi di dati e informazioni:\n\n### 2.1 Informazioni fornite dall\'utente\n- **Dati Account:** Quando accedi tramite Google Sign-In o crei un account, raccogliamo il tuo nome, indirizzo email e immagine del profilo.\n- **Contenuti Utente:** Raccogliamo i dati che inserisci volontariamente nella piattaforma, inclusi task, stime, retrospettive, commenti e configurazioni dei team.\n\n### 2.2 Informazioni raccolte automaticamente\n- **Log di sistema:** Indirizzi IP, tipo di browser, pagine visitate e timestamp.\n- **Cookies:** Utilizziamo cookie tecnici essenziali per mantenere la sessione attiva.\n\n## 3. Come utilizziamo i tuoi dati\nUtilizziamo le informazioni raccolte per:\n- Fornire, gestire e mantenere i nostri Servizi.\n- Migliorare, personalizzare ed espandere la nostra Piattaforma.\n- Analizzare come utilizzi il sito web per migliorare l\'esperienza utente.\n- Inviarti email di servizio (es. inviti ai team, aggiornamenti importanti).\n\n## 4. Condivisione dei dati\nNon vendiamo i tuoi dati personali. Condividiamo le informazioni solo con:\n- **Service Provider:** Utilizziamo **Google Firebase** (Google LLC) per l\'hosting, l\'autenticazione e il database. I dati sono trattati secondo la [Privacy Policy di Google](https://policies.google.com/privacy).\n- **Obblighi Legali:** Se richiesto dalla legge o per proteggere i nostri diritti.\n\n## 5. Sicurezza dei dati\nImplementiamo misure di sicurezza tecniche e organizzative standard del settore (come la crittografia in transito) per proteggere i tuoi dati. Tuttavia, nessun metodo di trasmissione su Internet è sicuro al 100%.\n\n## 6. I tuoi diritti\nHai il diritto di:\n- Accedere ai tuoi dati personali.\n- Richiedere la correzione di dati inesatti.\n- Richiedere la cancellazione dei tuoi dati (\"Diritto all\'oblio\").\n- Opporti al trattamento dei tuoi dati.\n\nPer esercitare questi diritti, contattaci a: suppkesien@gmail.com.\n\n## 7. Modifiche a questa Policy\nPotremmo aggiornare questa Privacy Policy di volta in volta. Ti notificheremo di eventuali modifiche pubblicando la nuova Policy su questa pagina.'**
  String get legalPrivacyContent;

  /// No description provided for @legalTermsContent.
  ///
  /// In it, this message translates to:
  /// **'## 1. Accettazione dei Termini\nAccedendo o utilizzando **Keisen**, accetti di essere vincolato da questi Termini di Servizio (\"Termini\"). Se non accetti questi Termini, non devi utilizzare i nostri Servizi.\n\n## 2. Descrizione del Servizio\nKeisen è una piattaforma di collaborazione per team agili che offre strumenti come Smart Todo, Matrice di Eisenhower, Estimation Room e Gestione Processi Agili. Ci riserviamo il diritto di modificare o interrompere il servizio in qualsiasi momento.\n\n## 3. Account Utente\nSei responsabile di mantenere la riservatezza delle credenziali del tuo account e di tutte le attività che avvengono sotto il tuo account. Ci riserviamo il diritto di sospendere o cancellare account che violano questi Termini.\n\n## 4. Comportamento dell\'Utente\nAccetti di non utilizzare il Servizio per:\n- Violare leggi locali, nazionali o internazionali.\n- Caricare contenuti offensivi, diffamatori o illegali.\n- Tentare di accedere non autorizzato ai sistemi della Piattaforma.\n\n## 5. Proprietà Intellettuale\nTutti i diritti di proprietà intellettuale relativi alla Piattaforma e ai suoi contenuti originali (esclusi i contenuti forniti dagli utenti) sono di proprietà esclusiva di Leonardo Torella.\n\n## 6. Limitazione di Responsabilità\nNella misura massima consentita dalla legge, Keisen viene fornito \"così com\'è\" e \"come disponibile\". Non garantiamo che il servizio sarà ininterrotto o privo di errori. Non saremo responsabili per danni indiretti, incidentali o consequenziali derivanti dall\'uso del servizio.\n\n## 7. Legge Applicabile\nQuesti Termini sono regolati dalle leggi dello Stato Italiano.\n\n## 8. Contatti\nPer domande su questi Termini, contattaci a: suppkesien@gmail.com.'**
  String get legalTermsContent;

  /// No description provided for @legalCookiesContent.
  ///
  /// In it, this message translates to:
  /// **'## 1. Cosa sono i Cookie?\nI cookie sono piccoli file di testo che vengono salvati sul tuo dispositivo quando visiti un sito web. Sono ampiamente utilizzati per far funzionare i siti web in modo più efficiente e fornire informazioni ai proprietari del sito.\n\n## 2. Come utilizziamo i Cookie\nUtilizziamo i cookie per diversi scopi:\n\n### 2.1 Cookie Tecnici (Essenziali)\nQuesti cookie sono necessari per il funzionamento del sito web e non possono essere disattivati nei nostri sistemi. Di solito vengono impostati solo in risposta alle azioni da te effettuate che costituiscono una richiesta di servizi, come l\'impostazione delle preferenze di privacy, l\'accesso (Login) o la compilazione di moduli.\n*Esempio:* Cookie di sessione Firebase Auth per mantenere l\'utente loggato.\n\n### 2.2 Cookie di Analisi\nQuesti cookie ci permettono di contare le visite e le fonti di traffico, in modo da poter misurare e migliorare le prestazioni del nostro sito. Tutte le informazioni raccolte da questi cookie sono aggregate e quindi anonime.\n\n## 3. Gestione dei Cookie\nLa maggior parte dei browser web consente di controllare la maggior parte dei cookie attraverso le impostazioni del browser. Tuttavia, se disabiliti i cookie essenziali, alcune parti del nostro Servizio potrebbero non funzionare correttamente (ad esempio, non potrai effettuare il login).\n\n## 4. Cookie di Terze Parti\nUtilizziamo servizi di terze parti come **Google Firebase** che potrebbero impostare i propri cookie. Ti invitiamo a consultare le rispettive informative sulla privacy per maggiori dettagli.'**
  String get legalCookiesContent;

  /// No description provided for @legalGdprContent.
  ///
  /// In it, this message translates to:
  /// **'## Impegno per la Protezione dei Dati (GDPR)\nIn conformità con il Regolamento Generale sulla Protezione dei Dati (GDPR) dell\'Unione Europea, Keisen si impegna a proteggere i dati personali degli utenti e a garantire la trasparenza nel loro trattamento.\n\n## Titolare del Trattamento\nIl Titolare del Trattamento dei dati è:\n**Keisen Team**\nEmail: suppkesien@gmail.com\n\n## Base Giuridica del Trattamento\nTrattiamo i tuoi dati personali solo quando abbiamo una base giuridica per farlo. Questo include:\n- **Consenso:** Ci hai dato il permesso di trattare i tuoi dati per uno scopo specifico.\n- **Esecuzione di un contratto:** Il trattamento è necessario per fornire i Servizi che hai richiesto (es. utilizzo della piattaforma).\n- **Interesse legittimo:** Il trattamento è necessario per i nostri legittimi interessi (es. sicurezza, miglioramento del servizio), a meno che non prevalgano i tuoi diritti e libertà fondamentali.\n\n## Trasferimento dei Dati\nI tuoi dati sono conservati su server sicuri forniti da Google Cloud Platform (Google Firebase). Google aderisce agli standard di sicurezza internazionali ed è conforme al GDPR attraverso le Clausole Contrattuali Tipo (SCC).\n\n## I Tuoi Diritti GDPR\nCome utente nell\'UE, hai i seguenti diritti:\n1.  **Diritto di accesso:** Hai il diritto di richiedere copie dei tuoi dati personali.\n2.  **Diritto di rettifica:** Hai il diritto di richiedere la correzione di informazioni che ritieni inesatte.\n3.  **Diritto alla cancellazione (\"Diritto all\'oblio\"):** Hai il diritto di richiedere la cancellazione dei tuoi dati personali, a determinate condizioni.\n4.  **Diritto alla limitazione del trattamento:** Hai il diritto di richiedere la limitazione del trattamento dei tuoi dati.\n5.  **Diritto alla portabilità dei dati:** Hai il diritto di richiedere il trasferimento dei dati che abbiamo raccolto a un\'altra organizzazione o direttamente a te.\n\n## Esercizio dei Diritti\nSe desideri esercitare uno di questi diritti, ti preghiamo di contattarci a: suppkesien@gmail.com. Risponderemo alla tua richiesta entro un mese.'**
  String get legalGdprContent;

  /// No description provided for @profilePrivacy.
  ///
  /// In it, this message translates to:
  /// **'Privacy'**
  String get profilePrivacy;

  /// No description provided for @profileExportData.
  ///
  /// In it, this message translates to:
  /// **'Esporta i miei dati'**
  String get profileExportData;

  /// No description provided for @profileDeleteAccountConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare definitivamente il tuo account? Questa azione è irreversibile.'**
  String get profileDeleteAccountConfirm;

  /// No description provided for @subscriptionTitle.
  ///
  /// In it, this message translates to:
  /// **'Abbonamento'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionTabPlans.
  ///
  /// In it, this message translates to:
  /// **'Piani'**
  String get subscriptionTabPlans;

  /// No description provided for @subscriptionTabUsage.
  ///
  /// In it, this message translates to:
  /// **'Utilizzo'**
  String get subscriptionTabUsage;

  /// No description provided for @subscriptionTabBilling.
  ///
  /// In it, this message translates to:
  /// **'Fatturazione'**
  String get subscriptionTabBilling;

  /// No description provided for @subscriptionActiveProjects.
  ///
  /// In it, this message translates to:
  /// **'{count} progetti attivi'**
  String subscriptionActiveProjects(int count);

  /// No description provided for @subscriptionActiveLists.
  ///
  /// In it, this message translates to:
  /// **'{count} liste Smart Todo'**
  String subscriptionActiveLists(int count);

  /// No description provided for @subscriptionCurrentPlan.
  ///
  /// In it, this message translates to:
  /// **'Piano attuale'**
  String get subscriptionCurrentPlan;

  /// No description provided for @subscriptionUpgradeTo.
  ///
  /// In it, this message translates to:
  /// **'Upgrade a {plan}'**
  String subscriptionUpgradeTo(String plan);

  /// No description provided for @subscriptionDowngradeTo.
  ///
  /// In it, this message translates to:
  /// **'Downgrade a {plan}'**
  String subscriptionDowngradeTo(String plan);

  /// No description provided for @subscriptionChoose.
  ///
  /// In it, this message translates to:
  /// **'Scegli {plan}'**
  String subscriptionChoose(String plan);

  /// No description provided for @subscriptionMonthly.
  ///
  /// In it, this message translates to:
  /// **'Mensile'**
  String get subscriptionMonthly;

  /// No description provided for @subscriptionYearly.
  ///
  /// In it, this message translates to:
  /// **'Annuale (-17%)'**
  String get subscriptionYearly;

  /// No description provided for @subscriptionLimitReached.
  ///
  /// In it, this message translates to:
  /// **'Limite raggiunto'**
  String get subscriptionLimitReached;

  /// No description provided for @subscriptionLimitProjects.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di progetti per il tuo piano. Passa a Premium per creare più progetti.'**
  String get subscriptionLimitProjects;

  /// No description provided for @subscriptionLimitLists.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di liste per il tuo piano. Passa a Premium per creare più liste.'**
  String get subscriptionLimitLists;

  /// No description provided for @subscriptionLimitTasks.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di task per questo progetto. Passa a Premium per aggiungere più task.'**
  String get subscriptionLimitTasks;

  /// No description provided for @subscriptionLimitInvites.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di inviti per questo progetto. Passa a Premium per invitare più persone.'**
  String get subscriptionLimitInvites;

  /// No description provided for @subscriptionLimitEstimations.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di sessioni di stima. Passa a Premium per crearne di più.'**
  String get subscriptionLimitEstimations;

  /// No description provided for @subscriptionLimitRetrospectives.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di retrospettive. Passa a Premium per crearne di più.'**
  String get subscriptionLimitRetrospectives;

  /// No description provided for @subscriptionLimitAgileProjects.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite massimo di progetti Agile. Passa a Premium per crearne di più.'**
  String get subscriptionLimitAgileProjects;

  /// No description provided for @subscriptionLimitDefault.
  ///
  /// In it, this message translates to:
  /// **'Hai raggiunto il limite del tuo piano attuale.'**
  String get subscriptionLimitDefault;

  /// No description provided for @subscriptionCurrentUsage.
  ///
  /// In it, this message translates to:
  /// **'Utilizzo attuale'**
  String get subscriptionCurrentUsage;

  /// No description provided for @subscriptionUpgradeToPremium.
  ///
  /// In it, this message translates to:
  /// **'Passa a Premium'**
  String get subscriptionUpgradeToPremium;

  /// No description provided for @subscriptionBenefitProjects.
  ///
  /// In it, this message translates to:
  /// **'30 progetti attivi'**
  String get subscriptionBenefitProjects;

  /// No description provided for @subscriptionBenefitLists.
  ///
  /// In it, this message translates to:
  /// **'30 liste Smart Todo'**
  String get subscriptionBenefitLists;

  /// No description provided for @subscriptionBenefitTasks.
  ///
  /// In it, this message translates to:
  /// **'100 task per progetto'**
  String get subscriptionBenefitTasks;

  /// No description provided for @subscriptionBenefitNoAds.
  ///
  /// In it, this message translates to:
  /// **'Nessuna pubblicità'**
  String get subscriptionBenefitNoAds;

  /// No description provided for @subscriptionStartingFrom.
  ///
  /// In it, this message translates to:
  /// **'A partire da €4.99/mese'**
  String get subscriptionStartingFrom;

  /// No description provided for @subscriptionLater.
  ///
  /// In it, this message translates to:
  /// **'Più tardi'**
  String get subscriptionLater;

  /// No description provided for @subscriptionViewPlans.
  ///
  /// In it, this message translates to:
  /// **'Vedi piani'**
  String get subscriptionViewPlans;

  /// No description provided for @subscriptionCanCreateOne.
  ///
  /// In it, this message translates to:
  /// **'Puoi creare ancora 1 {entity}'**
  String subscriptionCanCreateOne(String entity);

  /// No description provided for @subscriptionCanCreateMany.
  ///
  /// In it, this message translates to:
  /// **'Puoi creare ancora {count} {entity}'**
  String subscriptionCanCreateMany(int count, String entity);

  /// No description provided for @subscriptionUpgrade.
  ///
  /// In it, this message translates to:
  /// **'UPGRADE'**
  String get subscriptionUpgrade;

  /// No description provided for @subscriptionUsed.
  ///
  /// In it, this message translates to:
  /// **'Utilizzati: {count}'**
  String subscriptionUsed(int count);

  /// No description provided for @subscriptionUnlimited.
  ///
  /// In it, this message translates to:
  /// **'Illimitati'**
  String get subscriptionUnlimited;

  /// No description provided for @subscriptionLimit.
  ///
  /// In it, this message translates to:
  /// **'Limite: {count}'**
  String subscriptionLimit(int count);

  /// No description provided for @subscriptionPlanUsage.
  ///
  /// In it, this message translates to:
  /// **'Utilizzo del piano'**
  String get subscriptionPlanUsage;

  /// No description provided for @subscriptionRefresh.
  ///
  /// In it, this message translates to:
  /// **'Aggiorna'**
  String get subscriptionRefresh;

  /// No description provided for @subscriptionAdsActive.
  ///
  /// In it, this message translates to:
  /// **'Pubblicità attive'**
  String get subscriptionAdsActive;

  /// No description provided for @subscriptionRemoveAds.
  ///
  /// In it, this message translates to:
  /// **'Passa a Premium per rimuovere le pubblicità'**
  String get subscriptionRemoveAds;

  /// No description provided for @subscriptionNoAds.
  ///
  /// In it, this message translates to:
  /// **'Nessuna pubblicità'**
  String get subscriptionNoAds;

  /// No description provided for @subscriptionLoadError.
  ///
  /// In it, this message translates to:
  /// **'Impossibile caricare i dati di utilizzo'**
  String get subscriptionLoadError;

  /// No description provided for @subscriptionAdLabel.
  ///
  /// In it, this message translates to:
  /// **'AD'**
  String get subscriptionAdLabel;

  /// No description provided for @subscriptionAdPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Ad Placeholder'**
  String get subscriptionAdPlaceholder;

  /// No description provided for @subscriptionDevEnvironment.
  ///
  /// In it, this message translates to:
  /// **'(Ambiente di sviluppo)'**
  String get subscriptionDevEnvironment;

  /// No description provided for @subscriptionRemoveAdsUnlock.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi le pubblicità e sblocca funzionalità avanzate'**
  String get subscriptionRemoveAdsUnlock;

  /// No description provided for @subscriptionUpgradeButton.
  ///
  /// In it, this message translates to:
  /// **'Upgrade'**
  String get subscriptionUpgradeButton;

  /// No description provided for @subscriptionLoadingError.
  ///
  /// In it, this message translates to:
  /// **'Errore nel caricamento: {error}'**
  String subscriptionLoadingError(String error);

  /// No description provided for @subscriptionCompletePayment.
  ///
  /// In it, this message translates to:
  /// **'Completa il pagamento nella finestra aperta'**
  String get subscriptionCompletePayment;

  /// No description provided for @subscriptionError.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String subscriptionError(String error);

  /// No description provided for @subscriptionConfirmDowngrade.
  ///
  /// In it, this message translates to:
  /// **'Conferma downgrade'**
  String get subscriptionConfirmDowngrade;

  /// No description provided for @subscriptionDowngradeMessage.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler passare al piano Free?\n\nIl tuo abbonamento rimarrà attivo fino alla fine del periodo corrente, dopodiché passerai automaticamente al piano Free.\n\nNon perderai i tuoi dati, ma alcune funzionalità potrebbero essere limitate.'**
  String get subscriptionDowngradeMessage;

  /// No description provided for @subscriptionCancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get subscriptionCancel;

  /// No description provided for @subscriptionConfirmDowngradeButton.
  ///
  /// In it, this message translates to:
  /// **'Conferma downgrade'**
  String get subscriptionConfirmDowngradeButton;

  /// No description provided for @subscriptionCancelled.
  ///
  /// In it, this message translates to:
  /// **'Abbonamento cancellato. Rimarrà attivo fino a fine periodo.'**
  String get subscriptionCancelled;

  /// No description provided for @subscriptionPortalError.
  ///
  /// In it, this message translates to:
  /// **'Errore apertura portale: {error}'**
  String subscriptionPortalError(String error);

  /// No description provided for @subscriptionRetry.
  ///
  /// In it, this message translates to:
  /// **'Riprova'**
  String get subscriptionRetry;

  /// No description provided for @subscriptionChooseRightPlan.
  ///
  /// In it, this message translates to:
  /// **'Scegli il piano giusto per te'**
  String get subscriptionChooseRightPlan;

  /// No description provided for @subscriptionStartFree.
  ///
  /// In it, this message translates to:
  /// **'Inizia gratis, fai upgrade quando vuoi'**
  String get subscriptionStartFree;

  /// No description provided for @subscriptionPlan.
  ///
  /// In it, this message translates to:
  /// **'Piano {plan}'**
  String subscriptionPlan(String plan);

  /// No description provided for @subscriptionPlanName.
  ///
  /// In it, this message translates to:
  /// **'Piano Attuale: {plan}'**
  String subscriptionPlanName(String plan);

  /// No description provided for @subscriptionTrialUntil.
  ///
  /// In it, this message translates to:
  /// **'Trial fino al {date}'**
  String subscriptionTrialUntil(String date);

  /// No description provided for @subscriptionRenewal.
  ///
  /// In it, this message translates to:
  /// **'Rinnovo: {date}'**
  String subscriptionRenewal(String date);

  /// No description provided for @subscriptionManage.
  ///
  /// In it, this message translates to:
  /// **'Gestisci'**
  String get subscriptionManage;

  /// No description provided for @subscriptionLoginRequired.
  ///
  /// In it, this message translates to:
  /// **'Effettua il login per vedere l\'utilizzo'**
  String get subscriptionLoginRequired;

  /// No description provided for @subscriptionSuggestion.
  ///
  /// In it, this message translates to:
  /// **'Suggerimento'**
  String get subscriptionSuggestion;

  /// No description provided for @subscriptionSuggestionText.
  ///
  /// In it, this message translates to:
  /// **'Passa a Premium per sbloccare più progetti, rimuovere le pubblicità e aumentare i limiti. Prova gratis per 7 giorni!'**
  String get subscriptionSuggestionText;

  /// No description provided for @subscriptionPaymentManagement.
  ///
  /// In it, this message translates to:
  /// **'Gestione pagamenti'**
  String get subscriptionPaymentManagement;

  /// No description provided for @subscriptionNoActiveSubscription.
  ///
  /// In it, this message translates to:
  /// **'Nessun abbonamento attivo'**
  String get subscriptionNoActiveSubscription;

  /// No description provided for @subscriptionUsingFreePlan.
  ///
  /// In it, this message translates to:
  /// **'Stai usando il piano Free'**
  String get subscriptionUsingFreePlan;

  /// No description provided for @subscriptionViewPaidPlans.
  ///
  /// In it, this message translates to:
  /// **'Vedi piani a pagamento'**
  String get subscriptionViewPaidPlans;

  /// No description provided for @subscriptionPaymentMethod.
  ///
  /// In it, this message translates to:
  /// **'Metodo di pagamento'**
  String get subscriptionPaymentMethod;

  /// No description provided for @subscriptionEditPaymentMethod.
  ///
  /// In it, this message translates to:
  /// **'Modifica carta o metodo di pagamento'**
  String get subscriptionEditPaymentMethod;

  /// No description provided for @subscriptionInvoices.
  ///
  /// In it, this message translates to:
  /// **'Fatture'**
  String get subscriptionInvoices;

  /// No description provided for @subscriptionViewInvoices.
  ///
  /// In it, this message translates to:
  /// **'Visualizza e scarica le fatture'**
  String get subscriptionViewInvoices;

  /// No description provided for @subscriptionCancelSubscription.
  ///
  /// In it, this message translates to:
  /// **'Cancella abbonamento'**
  String get subscriptionCancelSubscription;

  /// No description provided for @subscriptionAccessUntilEnd.
  ///
  /// In it, this message translates to:
  /// **'L\'accesso rimarrà attivo fino a fine periodo'**
  String get subscriptionAccessUntilEnd;

  /// No description provided for @subscriptionPaymentHistory.
  ///
  /// In it, this message translates to:
  /// **'Storico pagamenti'**
  String get subscriptionPaymentHistory;

  /// No description provided for @subscriptionNoPayments.
  ///
  /// In it, this message translates to:
  /// **'Nessun pagamento registrato'**
  String get subscriptionNoPayments;

  /// No description provided for @subscriptionCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completato'**
  String get subscriptionCompleted;

  /// No description provided for @subscriptionDateNotAvailable.
  ///
  /// In it, this message translates to:
  /// **'Data non disponibile'**
  String get subscriptionDateNotAvailable;

  /// No description provided for @subscriptionFaq.
  ///
  /// In it, this message translates to:
  /// **'Domande frequenti'**
  String get subscriptionFaq;

  /// No description provided for @subscriptionFaqCancel.
  ///
  /// In it, this message translates to:
  /// **'Posso cancellare in qualsiasi momento?'**
  String get subscriptionFaqCancel;

  /// No description provided for @subscriptionFaqCancelAnswer.
  ///
  /// In it, this message translates to:
  /// **'Sì, puoi cancellare il tuo abbonamento in qualsiasi momento. L\'accesso rimarrà attivo fino alla fine del periodo pagato.'**
  String get subscriptionFaqCancelAnswer;

  /// No description provided for @subscriptionFaqTrial.
  ///
  /// In it, this message translates to:
  /// **'Come funziona il trial gratuito?'**
  String get subscriptionFaqTrial;

  /// No description provided for @subscriptionFaqTrialAnswer.
  ///
  /// In it, this message translates to:
  /// **'Con il trial gratuito hai accesso completo a tutte le funzionalità del piano scelto. Al termine del periodo di prova, inizierà automaticamente l\'abbonamento a pagamento.'**
  String get subscriptionFaqTrialAnswer;

  /// No description provided for @subscriptionFaqChange.
  ///
  /// In it, this message translates to:
  /// **'Posso cambiare piano?'**
  String get subscriptionFaqChange;

  /// No description provided for @subscriptionFaqChangeAnswer.
  ///
  /// In it, this message translates to:
  /// **'Puoi fare upgrade o downgrade in qualsiasi momento. L\'importo verrà calcolato in modo proporzionale.'**
  String get subscriptionFaqChangeAnswer;

  /// No description provided for @subscriptionFaqData.
  ///
  /// In it, this message translates to:
  /// **'I miei dati sono al sicuro?'**
  String get subscriptionFaqData;

  /// No description provided for @subscriptionFaqDataAnswer.
  ///
  /// In it, this message translates to:
  /// **'Assolutamente sì. Non perderai mai i tuoi dati, anche se passi a un piano inferiore. Alcune funzionalità potrebbero essere limitate, ma i dati restano sempre accessibili.'**
  String get subscriptionFaqDataAnswer;

  /// No description provided for @subscriptionStatusActive.
  ///
  /// In it, this message translates to:
  /// **'Attivo'**
  String get subscriptionStatusActive;

  /// No description provided for @subscriptionStatusTrialing.
  ///
  /// In it, this message translates to:
  /// **'In prova'**
  String get subscriptionStatusTrialing;

  /// No description provided for @subscriptionStatusPastDue.
  ///
  /// In it, this message translates to:
  /// **'Pagamento in ritardo'**
  String get subscriptionStatusPastDue;

  /// No description provided for @subscriptionStatusCancelled.
  ///
  /// In it, this message translates to:
  /// **'Cancellato'**
  String get subscriptionStatusCancelled;

  /// No description provided for @subscriptionStatusExpired.
  ///
  /// In it, this message translates to:
  /// **'Scaduto'**
  String get subscriptionStatusExpired;

  /// No description provided for @subscriptionStatusPaused.
  ///
  /// In it, this message translates to:
  /// **'In pausa'**
  String get subscriptionStatusPaused;

  /// No description provided for @subscriptionStatus.
  ///
  /// In it, this message translates to:
  /// **'Stato'**
  String get subscriptionStatus;

  /// No description provided for @subscriptionStarted.
  ///
  /// In it, this message translates to:
  /// **'Iniziato'**
  String get subscriptionStarted;

  /// No description provided for @subscriptionNextRenewal.
  ///
  /// In it, this message translates to:
  /// **'Prossimo rinnovo'**
  String get subscriptionNextRenewal;

  /// No description provided for @subscriptionTrialEnd.
  ///
  /// In it, this message translates to:
  /// **'Fine trial'**
  String get subscriptionTrialEnd;

  /// No description provided for @toolSectionTitle.
  ///
  /// In it, this message translates to:
  /// **'Strumenti'**
  String get toolSectionTitle;

  /// No description provided for @deadlineTitle.
  ///
  /// In it, this message translates to:
  /// **'Scadenze'**
  String get deadlineTitle;

  /// No description provided for @deadlineNoUpcoming.
  ///
  /// In it, this message translates to:
  /// **'Nessuna scadenza imminente'**
  String get deadlineNoUpcoming;

  /// No description provided for @deadlineAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get deadlineAll;

  /// No description provided for @deadlineToday.
  ///
  /// In it, this message translates to:
  /// **'Oggi'**
  String get deadlineToday;

  /// No description provided for @deadlineTomorrow.
  ///
  /// In it, this message translates to:
  /// **'Domani'**
  String get deadlineTomorrow;

  /// No description provided for @deadlineSprint.
  ///
  /// In it, this message translates to:
  /// **'Sprint'**
  String get deadlineSprint;

  /// No description provided for @deadlineTask.
  ///
  /// In it, this message translates to:
  /// **'Task'**
  String get deadlineTask;

  /// No description provided for @favTitle.
  ///
  /// In it, this message translates to:
  /// **'Preferiti'**
  String get favTitle;

  /// No description provided for @favFilterAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get favFilterAll;

  /// No description provided for @favFilterTodo.
  ///
  /// In it, this message translates to:
  /// **'Liste Todo'**
  String get favFilterTodo;

  /// No description provided for @favFilterMatrix.
  ///
  /// In it, this message translates to:
  /// **'Matrici'**
  String get favFilterMatrix;

  /// No description provided for @favFilterProject.
  ///
  /// In it, this message translates to:
  /// **'Progetti'**
  String get favFilterProject;

  /// No description provided for @favFilterPoker.
  ///
  /// In it, this message translates to:
  /// **'Stime'**
  String get favFilterPoker;

  /// No description provided for @actionRemoveFromFavorites.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi dai preferiti'**
  String get actionRemoveFromFavorites;

  /// No description provided for @favFilterRetro.
  ///
  /// In it, this message translates to:
  /// **'Retro'**
  String get favFilterRetro;

  /// No description provided for @favNoFavorites.
  ///
  /// In it, this message translates to:
  /// **'Nessun preferito trovato'**
  String get favNoFavorites;

  /// No description provided for @favTypeTodo.
  ///
  /// In it, this message translates to:
  /// **'Lista Todo'**
  String get favTypeTodo;

  /// No description provided for @favTypeMatrix.
  ///
  /// In it, this message translates to:
  /// **'Matrice Eisenhower'**
  String get favTypeMatrix;

  /// No description provided for @favTypeProject.
  ///
  /// In it, this message translates to:
  /// **'Progetto Agile'**
  String get favTypeProject;

  /// No description provided for @favTypeRetro.
  ///
  /// In it, this message translates to:
  /// **'Retrospective'**
  String get favTypeRetro;

  /// No description provided for @favTypePoker.
  ///
  /// In it, this message translates to:
  /// **'Planning Poker'**
  String get favTypePoker;

  /// No description provided for @favTypeTool.
  ///
  /// In it, this message translates to:
  /// **'Strumento'**
  String get favTypeTool;

  /// No description provided for @deadline2Days.
  ///
  /// In it, this message translates to:
  /// **'2 Giorni'**
  String get deadline2Days;

  /// No description provided for @deadline3Days.
  ///
  /// In it, this message translates to:
  /// **'3 Giorni'**
  String get deadline3Days;

  /// No description provided for @deadline5Days.
  ///
  /// In it, this message translates to:
  /// **'5 Giorni'**
  String get deadline5Days;

  /// No description provided for @deadlineConfigTitle.
  ///
  /// In it, this message translates to:
  /// **'Configura Scorciatoie'**
  String get deadlineConfigTitle;

  /// No description provided for @deadlineConfigDesc.
  ///
  /// In it, this message translates to:
  /// **'Scegli gli intervalli di tempo da mostrare nell\'intestazione.'**
  String get deadlineConfigDesc;

  /// No description provided for @smartTodoClose.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get smartTodoClose;

  /// No description provided for @smartTodoDone.
  ///
  /// In it, this message translates to:
  /// **'Fatto'**
  String get smartTodoDone;

  /// No description provided for @smartTodoAdd.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi'**
  String get smartTodoAdd;

  /// No description provided for @smartTodoEmailLabel.
  ///
  /// In it, this message translates to:
  /// **'Email'**
  String get smartTodoEmailLabel;

  /// No description provided for @exceptionLoginGoogleRequired.
  ///
  /// In it, this message translates to:
  /// **'Login Google necessario per inviare email'**
  String get exceptionLoginGoogleRequired;

  /// No description provided for @exceptionUserNotAuthenticated.
  ///
  /// In it, this message translates to:
  /// **'Utente non autenticato'**
  String get exceptionUserNotAuthenticated;

  /// No description provided for @errorLoginFailed.
  ///
  /// In it, this message translates to:
  /// **'Errore login: {error}'**
  String errorLoginFailed(String error);

  /// No description provided for @retroParticipantsTitle.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti ({count})'**
  String retroParticipantsTitle(int count);

  /// No description provided for @actionReopen.
  ///
  /// In it, this message translates to:
  /// **'Riapri'**
  String get actionReopen;

  /// No description provided for @retroWaitingForFacilitator.
  ///
  /// In it, this message translates to:
  /// **'In attesa che il facilitatore avvii la sessione...'**
  String get retroWaitingForFacilitator;

  /// No description provided for @retroGeneratingSheet.
  ///
  /// In it, this message translates to:
  /// **'Generazione Google Sheet in corso...'**
  String get retroGeneratingSheet;

  /// No description provided for @retroExportSuccess.
  ///
  /// In it, this message translates to:
  /// **'Export completato!'**
  String get retroExportSuccess;

  /// No description provided for @retroExportSuccessMessage.
  ///
  /// In it, this message translates to:
  /// **'La tua retrospettiva è stata esportata su Google Sheets.'**
  String get retroExportSuccessMessage;

  /// No description provided for @retroExportError.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'export su Sheets.'**
  String get retroExportError;

  /// No description provided for @retroReportCopied.
  ///
  /// In it, this message translates to:
  /// **'Report copiato negli appunti! Incollalo in Excel o Note.'**
  String get retroReportCopied;

  /// No description provided for @retroReopenTitle.
  ///
  /// In it, this message translates to:
  /// **'Riapri Retrospettiva'**
  String get retroReopenTitle;

  /// No description provided for @retroReopenConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler riaprire la retrospettiva? Tornerà alla fase di Discussione.'**
  String get retroReopenConfirm;

  /// No description provided for @errorAuthRequired.
  ///
  /// In it, this message translates to:
  /// **'Autenticazione richiesta'**
  String get errorAuthRequired;

  /// No description provided for @errorRetroIdMissing.
  ///
  /// In it, this message translates to:
  /// **'ID Retrospettiva mancante'**
  String get errorRetroIdMissing;

  /// No description provided for @pokerInviteAccepted.
  ///
  /// In it, this message translates to:
  /// **'Invito accettato! Verrai reindirizzato alla sessione.'**
  String get pokerInviteAccepted;

  /// No description provided for @pokerInviteRefused.
  ///
  /// In it, this message translates to:
  /// **'Invito rifiutato'**
  String get pokerInviteRefused;

  /// No description provided for @pokerConfirmRefuseTitle.
  ///
  /// In it, this message translates to:
  /// **'Rifiuta Invito'**
  String get pokerConfirmRefuseTitle;

  /// No description provided for @pokerConfirmRefuseContent.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler rifiutare questo invito?'**
  String get pokerConfirmRefuseContent;

  /// No description provided for @pokerVerifyingInvite.
  ///
  /// In it, this message translates to:
  /// **'Verifica invito in corso...'**
  String get pokerVerifyingInvite;

  /// No description provided for @actionBackHome.
  ///
  /// In it, this message translates to:
  /// **'Torna alla Home'**
  String get actionBackHome;

  /// No description provided for @actionSignin.
  ///
  /// In it, this message translates to:
  /// **'Accedi'**
  String get actionSignin;

  /// No description provided for @exceptionStoryNotFound.
  ///
  /// In it, this message translates to:
  /// **'Story non trovata'**
  String get exceptionStoryNotFound;

  /// No description provided for @exceptionNoTasksInProject.
  ///
  /// In it, this message translates to:
  /// **'Nessun task trovato nel progetto'**
  String get exceptionNoTasksInProject;

  /// No description provided for @exceptionInvitePending.
  ///
  /// In it, this message translates to:
  /// **'Esiste già un invito in attesa per questa email'**
  String get exceptionInvitePending;

  /// No description provided for @exceptionAlreadyParticipant.
  ///
  /// In it, this message translates to:
  /// **'L\'utente è già un partecipante'**
  String get exceptionAlreadyParticipant;

  /// No description provided for @exceptionInviteInvalid.
  ///
  /// In it, this message translates to:
  /// **'Invito non valido o scaduto'**
  String get exceptionInviteInvalid;

  /// No description provided for @exceptionInviteCalculated.
  ///
  /// In it, this message translates to:
  /// **'Invito scaduto'**
  String get exceptionInviteCalculated;

  /// No description provided for @exceptionInviteWrongUser.
  ///
  /// In it, this message translates to:
  /// **'Invito destinato ad un altro utente'**
  String get exceptionInviteWrongUser;

  /// No description provided for @todoImportTasks.
  ///
  /// In it, this message translates to:
  /// **'Importa Task'**
  String get todoImportTasks;

  /// No description provided for @todoExportSheets.
  ///
  /// In it, this message translates to:
  /// **'Esporta su Sheets'**
  String get todoExportSheets;

  /// No description provided for @todoDeleteColumnTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Colonna'**
  String get todoDeleteColumnTitle;

  /// No description provided for @todoDeleteColumnConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro? I task in questa colonna andranno persi.'**
  String get todoDeleteColumnConfirm;

  /// No description provided for @exceptionListNotFound.
  ///
  /// In it, this message translates to:
  /// **'Lista non trovata'**
  String get exceptionListNotFound;

  /// No description provided for @langItalian.
  ///
  /// In it, this message translates to:
  /// **'Italiano'**
  String get langItalian;

  /// No description provided for @langEnglish.
  ///
  /// In it, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langFrench.
  ///
  /// In it, this message translates to:
  /// **'Français'**
  String get langFrench;

  /// No description provided for @langSpanish.
  ///
  /// In it, this message translates to:
  /// **'Español'**
  String get langSpanish;

  /// No description provided for @jsonExportLabel.
  ///
  /// In it, this message translates to:
  /// **'Scarica una copia JSON dei tuoi dati'**
  String get jsonExportLabel;

  /// No description provided for @errorExporting.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'export: {error}'**
  String errorExporting(String error);

  /// No description provided for @smartTodoViewKanban.
  ///
  /// In it, this message translates to:
  /// **'Kanban'**
  String get smartTodoViewKanban;

  /// No description provided for @smartTodoViewList.
  ///
  /// In it, this message translates to:
  /// **'Lista'**
  String get smartTodoViewList;

  /// No description provided for @smartTodoViewResource.
  ///
  /// In it, this message translates to:
  /// **'Per Risorsa'**
  String get smartTodoViewResource;

  /// No description provided for @smartTodoInviteTooltip.
  ///
  /// In it, this message translates to:
  /// **'Invita'**
  String get smartTodoInviteTooltip;

  /// No description provided for @smartTodoOptionsTooltip.
  ///
  /// In it, this message translates to:
  /// **'Altre Opzioni'**
  String get smartTodoOptionsTooltip;

  /// No description provided for @smartTodoActionImport.
  ///
  /// In it, this message translates to:
  /// **'Importa Task'**
  String get smartTodoActionImport;

  /// No description provided for @smartTodoActionExportSheets.
  ///
  /// In it, this message translates to:
  /// **'Esporta su Sheets'**
  String get smartTodoActionExportSheets;

  /// No description provided for @smartTodoDeleteColumnTitle.
  ///
  /// In it, this message translates to:
  /// **'Elimina Colonna'**
  String get smartTodoDeleteColumnTitle;

  /// No description provided for @smartTodoDeleteColumnContent.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro? I task in questa colonna non saranno più visibili.'**
  String get smartTodoDeleteColumnContent;

  /// No description provided for @smartTodoNewColumn.
  ///
  /// In it, this message translates to:
  /// **'Nuova Colonna'**
  String get smartTodoNewColumn;

  /// No description provided for @smartTodoColumnNameHint.
  ///
  /// In it, this message translates to:
  /// **'Nome Colonna'**
  String get smartTodoColumnNameHint;

  /// No description provided for @smartTodoColorLabel.
  ///
  /// In it, this message translates to:
  /// **'COLORE'**
  String get smartTodoColorLabel;

  /// No description provided for @smartTodoMarkAsDone.
  ///
  /// In it, this message translates to:
  /// **'Segna come completato'**
  String get smartTodoMarkAsDone;

  /// No description provided for @smartTodoColumnDoneDescription.
  ///
  /// In it, this message translates to:
  /// **'I task in questa colonna saranno considerati \'Fatti\' (barrati).'**
  String get smartTodoColumnDoneDescription;

  /// No description provided for @smartTodoListSettingsTitle.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni Lista'**
  String get smartTodoListSettingsTitle;

  /// No description provided for @smartTodoRenameList.
  ///
  /// In it, this message translates to:
  /// **'Rinomina Lista'**
  String get smartTodoRenameList;

  /// No description provided for @smartTodoManageTags.
  ///
  /// In it, this message translates to:
  /// **'Gestisci Tag'**
  String get smartTodoManageTags;

  /// No description provided for @smartTodoDeleteList.
  ///
  /// In it, this message translates to:
  /// **'Elimina Lista'**
  String get smartTodoDeleteList;

  /// No description provided for @smartTodoEditPermissionError.
  ///
  /// In it, this message translates to:
  /// **'Puoi modificare solo i task a te assegnati'**
  String get smartTodoEditPermissionError;

  /// No description provided for @errorDeletingAccount.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'eliminazione dell\'account: {error}'**
  String errorDeletingAccount(String error);

  /// No description provided for @errorRecentLoginRequired.
  ///
  /// In it, this message translates to:
  /// **'È necessario aver effettuato l\'accesso di recente. Per favore, esci e rientra prima di eliminare l\'account.'**
  String get errorRecentLoginRequired;

  /// No description provided for @actionGuide.
  ///
  /// In it, this message translates to:
  /// **'Guida {framework}'**
  String actionGuide(String framework);

  /// No description provided for @actionExportSheets.
  ///
  /// In it, this message translates to:
  /// **'Esporta su Google Sheets'**
  String get actionExportSheets;

  /// No description provided for @actionAuditLog.
  ///
  /// In it, this message translates to:
  /// **'Audit Log'**
  String get actionAuditLog;

  /// No description provided for @actionInviteMember.
  ///
  /// In it, this message translates to:
  /// **'Invita Membro'**
  String get actionInviteMember;

  /// No description provided for @actionSettings.
  ///
  /// In it, this message translates to:
  /// **'Impostazioni'**
  String get actionSettings;

  /// No description provided for @retroSelectIcebreakerTooltip.
  ///
  /// In it, this message translates to:
  /// **'Seleziona l\'attività per rompere il ghiaccio'**
  String get retroSelectIcebreakerTooltip;

  /// No description provided for @retroIcebreakerLabel.
  ///
  /// In it, this message translates to:
  /// **'Attività iniziale'**
  String get retroIcebreakerLabel;

  /// No description provided for @retroTimePhasesOptional.
  ///
  /// In it, this message translates to:
  /// **'Timer Fasi (Opzionale)'**
  String get retroTimePhasesOptional;

  /// No description provided for @retroTimePhasesDesc.
  ///
  /// In it, this message translates to:
  /// **'Imposta la durata in minuti per ogni fase:'**
  String get retroTimePhasesDesc;

  /// No description provided for @retroIcebreakerSectionTitle.
  ///
  /// In it, this message translates to:
  /// **'Icebreaker'**
  String get retroIcebreakerSectionTitle;

  /// No description provided for @retroBoardTitle.
  ///
  /// In it, this message translates to:
  /// **'Bacheca Retrospettive'**
  String get retroBoardTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Cerca ovunque...'**
  String get searchPlaceholder;

  /// No description provided for @searchResultsTitle.
  ///
  /// In it, this message translates to:
  /// **'Risultati Ricerca'**
  String get searchResultsTitle;

  /// No description provided for @searchNoResults.
  ///
  /// In it, this message translates to:
  /// **'Nessun risultato per \'{query}\''**
  String searchNoResults(Object query);

  /// No description provided for @searchResultTypeProject.
  ///
  /// In it, this message translates to:
  /// **'Progetto'**
  String get searchResultTypeProject;

  /// No description provided for @searchResultTypeTodo.
  ///
  /// In it, this message translates to:
  /// **'Lista ToDo'**
  String get searchResultTypeTodo;

  /// No description provided for @searchResultTypeRetro.
  ///
  /// In it, this message translates to:
  /// **'Retrospettiva'**
  String get searchResultTypeRetro;

  /// No description provided for @searchResultTypeEisenhower.
  ///
  /// In it, this message translates to:
  /// **'Matrice Eisenhower'**
  String get searchResultTypeEisenhower;

  /// No description provided for @searchResultTypeEstimation.
  ///
  /// In it, this message translates to:
  /// **'Estimation Room'**
  String get searchResultTypeEstimation;

  /// No description provided for @searchBackToDashboard.
  ///
  /// In it, this message translates to:
  /// **'Torna alla Dashboard'**
  String get searchBackToDashboard;

  /// No description provided for @smartTodoAddItem.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi voce'**
  String get smartTodoAddItem;

  /// No description provided for @smartTodoAddImageUrl.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Immagine (URL)'**
  String get smartTodoAddImageUrl;

  /// No description provided for @smartTodoNone.
  ///
  /// In it, this message translates to:
  /// **'Nessuno'**
  String get smartTodoNone;

  /// No description provided for @smartTodoPointsHint.
  ///
  /// In it, this message translates to:
  /// **'Punti (es. 5)'**
  String get smartTodoPointsHint;

  /// No description provided for @smartTodoNewItem.
  ///
  /// In it, this message translates to:
  /// **'Nuova voce'**
  String get smartTodoNewItem;

  /// No description provided for @smartTodoDeleteComment.
  ///
  /// In it, this message translates to:
  /// **'Elimina'**
  String get smartTodoDeleteComment;

  /// No description provided for @priorityHigh.
  ///
  /// In it, this message translates to:
  /// **'ALTA'**
  String get priorityHigh;

  /// No description provided for @priorityMedium.
  ///
  /// In it, this message translates to:
  /// **'MEDIA'**
  String get priorityMedium;

  /// No description provided for @priorityLow.
  ///
  /// In it, this message translates to:
  /// **'BASSA'**
  String get priorityLow;

  /// No description provided for @exportToEstimation.
  ///
  /// In it, this message translates to:
  /// **'Esporta verso Stima'**
  String get exportToEstimation;

  /// No description provided for @exportToEstimationDesc.
  ///
  /// In it, this message translates to:
  /// **'Crea una sessione di stima con questi task'**
  String get exportToEstimationDesc;

  /// No description provided for @exportToEisenhower.
  ///
  /// In it, this message translates to:
  /// **'Invia a Eisenhower'**
  String get exportToEisenhower;

  /// No description provided for @exportToEisenhowerDesc.
  ///
  /// In it, this message translates to:
  /// **'Crea una matrice Eisenhower con questi task'**
  String get exportToEisenhowerDesc;

  /// No description provided for @selectTasksToExport.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Task'**
  String get selectTasksToExport;

  /// No description provided for @selectTasksToExportDesc.
  ///
  /// In it, this message translates to:
  /// **'Scegli quali task includere'**
  String get selectTasksToExportDesc;

  /// No description provided for @noTasksSelected.
  ///
  /// In it, this message translates to:
  /// **'Nessun task selezionato'**
  String get noTasksSelected;

  /// No description provided for @selectAtLeastOne.
  ///
  /// In it, this message translates to:
  /// **'Seleziona almeno un task'**
  String get selectAtLeastOne;

  /// No description provided for @createEstimationSession.
  ///
  /// In it, this message translates to:
  /// **'Crea Sessione di Stima'**
  String get createEstimationSession;

  /// No description provided for @tasksSelectedCount.
  ///
  /// In it, this message translates to:
  /// **'{count} task selezionati'**
  String tasksSelectedCount(int count);

  /// No description provided for @exportSuccess.
  ///
  /// In it, this message translates to:
  /// **'Esportato con successo'**
  String get exportSuccess;

  /// No description provided for @exportFromEstimation.
  ///
  /// In it, this message translates to:
  /// **'Esporta in Lista'**
  String get exportFromEstimation;

  /// No description provided for @exportFromEstimationDesc.
  ///
  /// In it, this message translates to:
  /// **'Esporta le storie stimate in una lista Smart Todo'**
  String get exportFromEstimationDesc;

  /// No description provided for @selectDestinationList.
  ///
  /// In it, this message translates to:
  /// **'Seleziona lista di destinazione'**
  String get selectDestinationList;

  /// No description provided for @createNewList.
  ///
  /// In it, this message translates to:
  /// **'Crea nuova lista'**
  String get createNewList;

  /// No description provided for @existingList.
  ///
  /// In it, this message translates to:
  /// **'Lista esistente'**
  String get existingList;

  /// No description provided for @listName.
  ///
  /// In it, this message translates to:
  /// **'Nome lista'**
  String get listName;

  /// No description provided for @listNameHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nome per la nuova lista'**
  String get listNameHint;

  /// No description provided for @selectList.
  ///
  /// In it, this message translates to:
  /// **'Seleziona lista'**
  String get selectList;

  /// No description provided for @selectListHint.
  ///
  /// In it, this message translates to:
  /// **'Scegli una lista'**
  String get selectListHint;

  /// No description provided for @noListsAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessuna lista disponibile. Ne verrà creata una nuova.'**
  String get noListsAvailable;

  /// No description provided for @storiesSelectedCount.
  ///
  /// In it, this message translates to:
  /// **'{count} storie selezionate'**
  String storiesSelectedCount(int count);

  /// No description provided for @selectAll.
  ///
  /// In it, this message translates to:
  /// **'Seleziona tutti'**
  String get selectAll;

  /// No description provided for @deselectAll.
  ///
  /// In it, this message translates to:
  /// **'Deseleziona tutti'**
  String get deselectAll;

  /// No description provided for @importStories.
  ///
  /// In it, this message translates to:
  /// **'Importa Storie'**
  String get importStories;

  /// No description provided for @storiesImportedCount.
  ///
  /// In it, this message translates to:
  /// **'{count} storie importate'**
  String storiesImportedCount(int count);

  /// No description provided for @noEstimatedStories.
  ///
  /// In it, this message translates to:
  /// **'Nessuna storia con stime da importare'**
  String get noEstimatedStories;

  /// No description provided for @selectDestinationMatrix.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Matrice Destinazione'**
  String get selectDestinationMatrix;

  /// No description provided for @existingMatrix.
  ///
  /// In it, this message translates to:
  /// **'Matrice Esistente'**
  String get existingMatrix;

  /// No description provided for @createNewMatrix.
  ///
  /// In it, this message translates to:
  /// **'Crea Nuova Matrice'**
  String get createNewMatrix;

  /// No description provided for @matrixName.
  ///
  /// In it, this message translates to:
  /// **'Nome Matrice'**
  String get matrixName;

  /// No description provided for @matrixNameHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nome per la nuova matrice'**
  String get matrixNameHint;

  /// No description provided for @selectMatrix.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Matrice'**
  String get selectMatrix;

  /// No description provided for @selectMatrixHint.
  ///
  /// In it, this message translates to:
  /// **'Scegli una matrice di destinazione'**
  String get selectMatrixHint;

  /// No description provided for @noMatricesAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessuna matrice disponibile. Creane una nuova.'**
  String get noMatricesAvailable;

  /// No description provided for @activitiesCreated.
  ///
  /// In it, this message translates to:
  /// **'{count} attività create'**
  String activitiesCreated(int count);

  /// No description provided for @importFromEisenhower.
  ///
  /// In it, this message translates to:
  /// **'Importa da Eisenhower'**
  String get importFromEisenhower;

  /// No description provided for @importFromEisenhowerDesc.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi i task prioritizzati a questa lista'**
  String get importFromEisenhowerDesc;

  /// No description provided for @quadrantQ1.
  ///
  /// In it, this message translates to:
  /// **'Urgente & Importante'**
  String get quadrantQ1;

  /// No description provided for @quadrantQ2.
  ///
  /// In it, this message translates to:
  /// **'Non Urgente & Importante'**
  String get quadrantQ2;

  /// No description provided for @quadrantQ3.
  ///
  /// In it, this message translates to:
  /// **'Urgente & Non Importante'**
  String get quadrantQ3;

  /// No description provided for @quadrantQ4.
  ///
  /// In it, this message translates to:
  /// **'Non Urgente & Non Importante'**
  String get quadrantQ4;

  /// No description provided for @warningQ4Tasks.
  ///
  /// In it, this message translates to:
  /// **'I task Q4 di solito non valgono la pena. Sei sicuro?'**
  String get warningQ4Tasks;

  /// No description provided for @priorityMappingInfo.
  ///
  /// In it, this message translates to:
  /// **'Mappatura priorità: Q1=Alta, Q2=Media, Q3/Q4=Bassa'**
  String get priorityMappingInfo;

  /// No description provided for @selectColumns.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Colonne'**
  String get selectColumns;

  /// No description provided for @allTasks.
  ///
  /// In it, this message translates to:
  /// **'Tutti i Task'**
  String get allTasks;

  /// No description provided for @filterByColumn.
  ///
  /// In it, this message translates to:
  /// **'Filtra per colonna'**
  String get filterByColumn;

  /// No description provided for @exportFromEisenhower.
  ///
  /// In it, this message translates to:
  /// **'Esporta da Eisenhower'**
  String get exportFromEisenhower;

  /// No description provided for @exportFromEisenhowerDesc.
  ///
  /// In it, this message translates to:
  /// **'Seleziona le attività da esportare su Smart Todo'**
  String get exportFromEisenhowerDesc;

  /// No description provided for @filterByQuadrant.
  ///
  /// In it, this message translates to:
  /// **'Filtra per quadrante:'**
  String get filterByQuadrant;

  /// No description provided for @allActivities.
  ///
  /// In it, this message translates to:
  /// **'Tutte'**
  String get allActivities;

  /// No description provided for @activitiesSelectedCount.
  ///
  /// In it, this message translates to:
  /// **'{count} attività selezionate'**
  String activitiesSelectedCount(int count);

  /// No description provided for @noActivitiesSelected.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività in questo filtro'**
  String get noActivitiesSelected;

  /// No description provided for @unvoted.
  ///
  /// In it, this message translates to:
  /// **'NON VOTATA'**
  String get unvoted;

  /// No description provided for @tasksCreated.
  ///
  /// In it, this message translates to:
  /// **'{count} task creati'**
  String tasksCreated(int count);

  /// No description provided for @exportToUserStories.
  ///
  /// In it, this message translates to:
  /// **'Esporta in User Stories'**
  String get exportToUserStories;

  /// No description provided for @exportToUserStoriesDesc.
  ///
  /// In it, this message translates to:
  /// **'Crea user stories in un progetto Agile'**
  String get exportToUserStoriesDesc;

  /// No description provided for @selectDestinationProject.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Progetto Destinazione'**
  String get selectDestinationProject;

  /// No description provided for @existingProject.
  ///
  /// In it, this message translates to:
  /// **'Progetto Esistente'**
  String get existingProject;

  /// No description provided for @createNewProject.
  ///
  /// In it, this message translates to:
  /// **'Crea Nuovo Progetto'**
  String get createNewProject;

  /// No description provided for @projectName.
  ///
  /// In it, this message translates to:
  /// **'Nome Progetto'**
  String get projectName;

  /// No description provided for @projectNameHint.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un nome per il nuovo progetto'**
  String get projectNameHint;

  /// No description provided for @selectProject.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Progetto'**
  String get selectProject;

  /// No description provided for @selectProjectHint.
  ///
  /// In it, this message translates to:
  /// **'Scegli un progetto di destinazione'**
  String get selectProjectHint;

  /// No description provided for @noProjectsAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessun progetto disponibile. Creane uno nuovo.'**
  String get noProjectsAvailable;

  /// No description provided for @userStoryFieldMappingInfo.
  ///
  /// In it, this message translates to:
  /// **'Mappatura: Titolo → Titolo story, Descrizione → Descrizione story, Effort → Story points, Priorità → Business value'**
  String get userStoryFieldMappingInfo;

  /// No description provided for @storiesCreated.
  ///
  /// In it, this message translates to:
  /// **'{count} stories create'**
  String storiesCreated(int count);

  /// No description provided for @configureNewProject.
  ///
  /// In it, this message translates to:
  /// **'Configura Nuovo Progetto'**
  String get configureNewProject;

  /// No description provided for @exportToAgileSprint.
  ///
  /// In it, this message translates to:
  /// **'Esporta in Sprint'**
  String get exportToAgileSprint;

  /// No description provided for @exportToAgileSprintDesc.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi le stories stimate a uno sprint Agile'**
  String get exportToAgileSprintDesc;

  /// No description provided for @selectSprint.
  ///
  /// In it, this message translates to:
  /// **'Seleziona Sprint'**
  String get selectSprint;

  /// No description provided for @selectSprintHint.
  ///
  /// In it, this message translates to:
  /// **'Scegli uno sprint di destinazione'**
  String get selectSprintHint;

  /// No description provided for @noSprintsAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessuno sprint disponibile. Crea prima uno sprint in pianificazione.'**
  String get noSprintsAvailable;

  /// No description provided for @sprintExportFieldMappingInfo.
  ///
  /// In it, this message translates to:
  /// **'Mappatura: Titolo → Titolo story, Descrizione → Descrizione, Stima → Story points'**
  String get sprintExportFieldMappingInfo;

  /// No description provided for @exportToSprint.
  ///
  /// In it, this message translates to:
  /// **'Esporta verso Sprint'**
  String get exportToSprint;

  /// No description provided for @totalStoryPoints.
  ///
  /// In it, this message translates to:
  /// **'{count} story points totali'**
  String totalStoryPoints(int count);

  /// No description provided for @storiesAddedToSprint.
  ///
  /// In it, this message translates to:
  /// **'{count} stories aggiunte a {sprintName}'**
  String storiesAddedToSprint(int count, String sprintName);

  /// No description provided for @storiesAddedToProject.
  ///
  /// In it, this message translates to:
  /// **'{count} stories aggiunte al progetto {projectName}'**
  String storiesAddedToProject(int count, String projectName);

  /// No description provided for @exportEisenhowerToSprintDesc.
  ///
  /// In it, this message translates to:
  /// **'Trasforma le attività Eisenhower in User Stories'**
  String get exportEisenhowerToSprintDesc;

  /// No description provided for @exportEisenhowerToEstimationDesc.
  ///
  /// In it, this message translates to:
  /// **'Crea una sessione di stima dalle attività'**
  String get exportEisenhowerToEstimationDesc;

  /// No description provided for @selectedActivities.
  ///
  /// In it, this message translates to:
  /// **'attività selezionate'**
  String get selectedActivities;

  /// No description provided for @noActivitiesToExport.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività da esportare'**
  String get noActivitiesToExport;

  /// No description provided for @hiddenQ4Activities.
  ///
  /// In it, this message translates to:
  /// **'Nascoste'**
  String get hiddenQ4Activities;

  /// No description provided for @q4Activities.
  ///
  /// In it, this message translates to:
  /// **'attività Q4 (Elimina)'**
  String get q4Activities;

  /// No description provided for @showQ4.
  ///
  /// In it, this message translates to:
  /// **'Mostra Q4'**
  String get showQ4;

  /// No description provided for @hideQ4.
  ///
  /// In it, this message translates to:
  /// **'Nascondi Q4'**
  String get hideQ4;

  /// No description provided for @showingAllActivities.
  ///
  /// In it, this message translates to:
  /// **'Mostrando tutte le attività'**
  String get showingAllActivities;

  /// No description provided for @eisenhowerMappingInfo.
  ///
  /// In it, this message translates to:
  /// **'Q1→Must, Q2→Should, Q3→Could, Q4→Won\'t. Importanza→Business Value.'**
  String get eisenhowerMappingInfo;

  /// No description provided for @estimationExportInfo.
  ///
  /// In it, this message translates to:
  /// **'Le attività verranno aggiunte come storie da stimare. La priorità Q non verrà trasferita.'**
  String get estimationExportInfo;

  /// No description provided for @createSession.
  ///
  /// In it, this message translates to:
  /// **'Crea Sessione'**
  String get createSession;

  /// No description provided for @estimationType.
  ///
  /// In it, this message translates to:
  /// **'Tipo di stima'**
  String get estimationType;

  /// No description provided for @activitiesAddedToSprint.
  ///
  /// In it, this message translates to:
  /// **'{count} attività aggiunte a {sprintName}'**
  String activitiesAddedToSprint(int count, String sprintName);

  /// No description provided for @activitiesAddedToProject.
  ///
  /// In it, this message translates to:
  /// **'{count} attività aggiunte al progetto {projectName}'**
  String activitiesAddedToProject(int count, String projectName);

  /// No description provided for @estimationSessionCreated.
  ///
  /// In it, this message translates to:
  /// **'Sessione di stima creata con {count} attività'**
  String estimationSessionCreated(int count);

  /// No description provided for @activitiesExportedToSprint.
  ///
  /// In it, this message translates to:
  /// **'{count} attività esportate nello sprint {sprintName}'**
  String activitiesExportedToSprint(int count, String sprintName);

  /// No description provided for @activitiesExportedToEstimation.
  ///
  /// In it, this message translates to:
  /// **'{count} attività esportate nella sessione di stima {sessionName}'**
  String activitiesExportedToEstimation(int count, String sessionName);

  /// No description provided for @archiveAction.
  ///
  /// In it, this message translates to:
  /// **'Archivia'**
  String get archiveAction;

  /// No description provided for @archiveRestoreAction.
  ///
  /// In it, this message translates to:
  /// **'Ripristina'**
  String get archiveRestoreAction;

  /// No description provided for @archiveShowArchived.
  ///
  /// In it, this message translates to:
  /// **'Mostra archiviati'**
  String get archiveShowArchived;

  /// No description provided for @archiveHideArchived.
  ///
  /// In it, this message translates to:
  /// **'Nascondi archiviati'**
  String get archiveHideArchived;

  /// No description provided for @archiveConfirmTitle.
  ///
  /// In it, this message translates to:
  /// **'Archivia {itemType}'**
  String archiveConfirmTitle(String itemType);

  /// No description provided for @archiveConfirmMessage.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler archiviare questo elemento? Potrà essere ripristinato in seguito.'**
  String get archiveConfirmMessage;

  /// No description provided for @archiveRestoreConfirmTitle.
  ///
  /// In it, this message translates to:
  /// **'Ripristina {itemType}'**
  String archiveRestoreConfirmTitle(String itemType);

  /// No description provided for @archiveRestoreConfirmMessage.
  ///
  /// In it, this message translates to:
  /// **'Vuoi ripristinare questo elemento dall\'archivio?'**
  String get archiveRestoreConfirmMessage;

  /// No description provided for @archiveSuccessMessage.
  ///
  /// In it, this message translates to:
  /// **'Elemento archiviato con successo'**
  String get archiveSuccessMessage;

  /// No description provided for @archiveRestoreSuccessMessage.
  ///
  /// In it, this message translates to:
  /// **'Elemento ripristinato con successo'**
  String get archiveRestoreSuccessMessage;

  /// No description provided for @archiveErrorMessage.
  ///
  /// In it, this message translates to:
  /// **'Errore durante l\'archiviazione'**
  String get archiveErrorMessage;

  /// No description provided for @archiveRestoreErrorMessage.
  ///
  /// In it, this message translates to:
  /// **'Errore durante il ripristino'**
  String get archiveRestoreErrorMessage;

  /// No description provided for @archiveFilterLabel.
  ///
  /// In it, this message translates to:
  /// **'Archivio'**
  String get archiveFilterLabel;

  /// No description provided for @archiveFilterActive.
  ///
  /// In it, this message translates to:
  /// **'Attivi'**
  String get archiveFilterActive;

  /// No description provided for @archiveFilterArchived.
  ///
  /// In it, this message translates to:
  /// **'Archiviati'**
  String get archiveFilterArchived;

  /// No description provided for @archiveFilterAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get archiveFilterAll;

  /// No description provided for @archiveBadge.
  ///
  /// In it, this message translates to:
  /// **'Archiviato'**
  String get archiveBadge;

  /// No description provided for @archiveEmptyMessage.
  ///
  /// In it, this message translates to:
  /// **'Nessun elemento archiviato'**
  String get archiveEmptyMessage;

  /// No description provided for @completeAction.
  ///
  /// In it, this message translates to:
  /// **'Completa'**
  String get completeAction;

  /// No description provided for @reopenAction.
  ///
  /// In it, this message translates to:
  /// **'Riapri'**
  String get reopenAction;

  /// No description provided for @completeConfirmTitle.
  ///
  /// In it, this message translates to:
  /// **'Completa {itemType}'**
  String completeConfirmTitle(String itemType);

  /// No description provided for @completeConfirmMessage.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler completare questo elemento?'**
  String get completeConfirmMessage;

  /// No description provided for @completeSuccessMessage.
  ///
  /// In it, this message translates to:
  /// **'Elemento completato con successo'**
  String get completeSuccessMessage;

  /// No description provided for @reopenSuccessMessage.
  ///
  /// In it, this message translates to:
  /// **'Elemento riaperto con successo'**
  String get reopenSuccessMessage;

  /// No description provided for @completedBadge.
  ///
  /// In it, this message translates to:
  /// **'Completato'**
  String get completedBadge;

  /// No description provided for @inviteNewInvite.
  ///
  /// In it, this message translates to:
  /// **'NUOVO INVITO'**
  String get inviteNewInvite;

  /// No description provided for @inviteRole.
  ///
  /// In it, this message translates to:
  /// **'Ruolo:'**
  String get inviteRole;

  /// No description provided for @inviteSendEmailNotification.
  ///
  /// In it, this message translates to:
  /// **'Invia email di notifica'**
  String get inviteSendEmailNotification;

  /// No description provided for @inviteSendInvite.
  ///
  /// In it, this message translates to:
  /// **'Invia Invito'**
  String get inviteSendInvite;

  /// No description provided for @inviteLink.
  ///
  /// In it, this message translates to:
  /// **'Link di invito:'**
  String get inviteLink;

  /// No description provided for @inviteList.
  ///
  /// In it, this message translates to:
  /// **'INVITI'**
  String get inviteList;

  /// No description provided for @inviteResend.
  ///
  /// In it, this message translates to:
  /// **'Reinvia'**
  String get inviteResend;

  /// No description provided for @inviteRevokeMessage.
  ///
  /// In it, this message translates to:
  /// **'L\'invito non sarà più valido.'**
  String get inviteRevokeMessage;

  /// No description provided for @inviteResent.
  ///
  /// In it, this message translates to:
  /// **'Invito reinviato'**
  String get inviteResent;

  /// No description provided for @inviteSentByEmail.
  ///
  /// In it, this message translates to:
  /// **'Invito inviato via email a {email}'**
  String inviteSentByEmail(String email);

  /// No description provided for @inviteStatusPending.
  ///
  /// In it, this message translates to:
  /// **'In attesa'**
  String get inviteStatusPending;

  /// No description provided for @inviteStatusAccepted.
  ///
  /// In it, this message translates to:
  /// **'Accettato'**
  String get inviteStatusAccepted;

  /// No description provided for @inviteStatusDeclined.
  ///
  /// In it, this message translates to:
  /// **'Rifiutato'**
  String get inviteStatusDeclined;

  /// No description provided for @inviteStatusExpired.
  ///
  /// In it, this message translates to:
  /// **'Scaduto'**
  String get inviteStatusExpired;

  /// No description provided for @inviteStatusRevoked.
  ///
  /// In it, this message translates to:
  /// **'Revocato'**
  String get inviteStatusRevoked;

  /// No description provided for @inviteGmailAuthTitle.
  ///
  /// In it, this message translates to:
  /// **'Autorizzazione Gmail'**
  String get inviteGmailAuthTitle;

  /// No description provided for @inviteGmailAuthMessage.
  ///
  /// In it, this message translates to:
  /// **'Per inviare email di invito, è necessario ri-autenticarsi con Google.\n\nVuoi procedere?'**
  String get inviteGmailAuthMessage;

  /// No description provided for @inviteGmailAuthNo.
  ///
  /// In it, this message translates to:
  /// **'No, solo link'**
  String get inviteGmailAuthNo;

  /// No description provided for @inviteGmailAuthYes.
  ///
  /// In it, this message translates to:
  /// **'Autorizza'**
  String get inviteGmailAuthYes;

  /// No description provided for @inviteGmailNotAvailable.
  ///
  /// In it, this message translates to:
  /// **'Autorizzazione Gmail non disponibile. Prova a fare logout e login.'**
  String get inviteGmailNotAvailable;

  /// No description provided for @inviteGmailNoPermission.
  ///
  /// In it, this message translates to:
  /// **'Permesso Gmail non concesso.'**
  String get inviteGmailNoPermission;

  /// No description provided for @inviteEnterEmail.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un\'email'**
  String get inviteEnterEmail;

  /// No description provided for @inviteInvalidEmail.
  ///
  /// In it, this message translates to:
  /// **'Email non valida'**
  String get inviteInvalidEmail;

  /// No description provided for @pendingInvites.
  ///
  /// In it, this message translates to:
  /// **'Inviti in Sospeso'**
  String get pendingInvites;

  /// No description provided for @noPendingInvites.
  ///
  /// In it, this message translates to:
  /// **'Nessun invito in sospeso'**
  String get noPendingInvites;

  /// No description provided for @invitedBy.
  ///
  /// In it, this message translates to:
  /// **'Invitato da {name}'**
  String invitedBy(String name);

  /// No description provided for @inviteOpenInstance.
  ///
  /// In it, this message translates to:
  /// **'Apri'**
  String get inviteOpenInstance;

  /// No description provided for @inviteAcceptFirst.
  ///
  /// In it, this message translates to:
  /// **'Accetta l\'invito per aprire'**
  String get inviteAcceptFirst;

  /// No description provided for @inviteAccept.
  ///
  /// In it, this message translates to:
  /// **'Accetta'**
  String get inviteAccept;

  /// No description provided for @inviteDecline.
  ///
  /// In it, this message translates to:
  /// **'Rifiuta'**
  String get inviteDecline;

  /// No description provided for @inviteAcceptedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Invito accettato con successo!'**
  String get inviteAcceptedSuccess;

  /// No description provided for @inviteAcceptedError.
  ///
  /// In it, this message translates to:
  /// **'Errore nell\'accettare l\'invito'**
  String get inviteAcceptedError;

  /// No description provided for @inviteDeclinedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Invito rifiutato'**
  String get inviteDeclinedSuccess;

  /// No description provided for @inviteDeclinedError.
  ///
  /// In it, this message translates to:
  /// **'Errore nel rifiutare l\'invito'**
  String get inviteDeclinedError;

  /// No description provided for @inviteDeclineTitle.
  ///
  /// In it, this message translates to:
  /// **'Rifiutare l\'invito?'**
  String get inviteDeclineTitle;

  /// No description provided for @inviteDeclineMessage.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler rifiutare questo invito?'**
  String get inviteDeclineMessage;

  /// No description provided for @expiresInHours.
  ///
  /// In it, this message translates to:
  /// **'Scade in {hours}h'**
  String expiresInHours(int hours);

  /// No description provided for @expiresInDays.
  ///
  /// In it, this message translates to:
  /// **'Scade in {days}g'**
  String expiresInDays(int days);

  /// No description provided for @close.
  ///
  /// In it, this message translates to:
  /// **'Chiudi'**
  String get close;

  /// No description provided for @cancel.
  ///
  /// In it, this message translates to:
  /// **'Annulla'**
  String get cancel;

  /// No description provided for @raciTitle.
  ///
  /// In it, this message translates to:
  /// **'Matrice RACI'**
  String get raciTitle;

  /// No description provided for @raciNoActivities.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività disponibile'**
  String get raciNoActivities;

  /// No description provided for @raciAddActivity.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Attività'**
  String get raciAddActivity;

  /// No description provided for @raciAddColumn.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi Colonna'**
  String get raciAddColumn;

  /// No description provided for @raciActivities.
  ///
  /// In it, this message translates to:
  /// **'ATTIVITÀ'**
  String get raciActivities;

  /// No description provided for @raciAssignRole.
  ///
  /// In it, this message translates to:
  /// **'Assegna ruolo'**
  String get raciAssignRole;

  /// No description provided for @raciNone.
  ///
  /// In it, this message translates to:
  /// **'Nessuno'**
  String get raciNone;

  /// No description provided for @raciSaving.
  ///
  /// In it, this message translates to:
  /// **'Salvataggio...'**
  String get raciSaving;

  /// No description provided for @raciSaveChanges.
  ///
  /// In it, this message translates to:
  /// **'Salva Modifiche'**
  String get raciSaveChanges;

  /// No description provided for @raciSavedSuccessfully.
  ///
  /// In it, this message translates to:
  /// **'Modifiche salvate correttamente'**
  String get raciSavedSuccessfully;

  /// No description provided for @raciErrorSaving.
  ///
  /// In it, this message translates to:
  /// **'Errore salvataggio'**
  String get raciErrorSaving;

  /// No description provided for @raciMissingAccountable.
  ///
  /// In it, this message translates to:
  /// **'Manca Accountable (A)'**
  String get raciMissingAccountable;

  /// No description provided for @raciOnlyOneAccountable.
  ///
  /// In it, this message translates to:
  /// **'Un solo Accountable per attività'**
  String get raciOnlyOneAccountable;

  /// No description provided for @raciDuplicateRoles.
  ///
  /// In it, this message translates to:
  /// **'Ruoli duplicati'**
  String get raciDuplicateRoles;

  /// No description provided for @raciNoResponsible.
  ///
  /// In it, this message translates to:
  /// **'Nessun Responsible (R) assegnato'**
  String get raciNoResponsible;

  /// No description provided for @raciTooManyInformed.
  ///
  /// In it, this message translates to:
  /// **'Troppi Informed (I): considera di ridurre'**
  String get raciTooManyInformed;

  /// No description provided for @raciNewColumn.
  ///
  /// In it, this message translates to:
  /// **'Nuova Colonna'**
  String get raciNewColumn;

  /// No description provided for @raciRemoveColumn.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi colonna'**
  String get raciRemoveColumn;

  /// No description provided for @raciRemoveColumnConfirm.
  ///
  /// In it, this message translates to:
  /// **'Rimuovere la colonna \"{name}\"? Tutte le assegnazioni di ruolo per questa colonna verranno eliminate.'**
  String raciRemoveColumnConfirm(String name);

  /// No description provided for @votingDialogTitle.
  ///
  /// In it, this message translates to:
  /// **'Vota'**
  String get votingDialogTitle;

  /// No description provided for @votingDialogVoteOf.
  ///
  /// In it, this message translates to:
  /// **'Voto di {participant}'**
  String votingDialogVoteOf(String participant);

  /// No description provided for @votingDialogUrgency.
  ///
  /// In it, this message translates to:
  /// **'URGENZA'**
  String get votingDialogUrgency;

  /// No description provided for @votingDialogImportance.
  ///
  /// In it, this message translates to:
  /// **'IMPORTANZA'**
  String get votingDialogImportance;

  /// No description provided for @votingDialogNotUrgent.
  ///
  /// In it, this message translates to:
  /// **'Non urgente'**
  String get votingDialogNotUrgent;

  /// No description provided for @votingDialogVeryUrgent.
  ///
  /// In it, this message translates to:
  /// **'Molto urgente'**
  String get votingDialogVeryUrgent;

  /// No description provided for @votingDialogNotImportant.
  ///
  /// In it, this message translates to:
  /// **'Non importante'**
  String get votingDialogNotImportant;

  /// No description provided for @votingDialogVeryImportant.
  ///
  /// In it, this message translates to:
  /// **'Molto importante'**
  String get votingDialogVeryImportant;

  /// No description provided for @votingDialogConfirmVote.
  ///
  /// In it, this message translates to:
  /// **'Conferma Voto'**
  String get votingDialogConfirmVote;

  /// No description provided for @votingDialogQuadrant.
  ///
  /// In it, this message translates to:
  /// **'Quadrante:'**
  String get votingDialogQuadrant;

  /// No description provided for @voteCollectionTitle.
  ///
  /// In it, this message translates to:
  /// **'Raccogli Voti'**
  String get voteCollectionTitle;

  /// No description provided for @voteCollectionParticipants.
  ///
  /// In it, this message translates to:
  /// **'partecipanti'**
  String get voteCollectionParticipants;

  /// No description provided for @voteCollectionResult.
  ///
  /// In it, this message translates to:
  /// **'Risultato:'**
  String get voteCollectionResult;

  /// No description provided for @voteCollectionAverage.
  ///
  /// In it, this message translates to:
  /// **'Media:'**
  String get voteCollectionAverage;

  /// No description provided for @voteCollectionSaveVotes.
  ///
  /// In it, this message translates to:
  /// **'Salva Voti'**
  String get voteCollectionSaveVotes;

  /// No description provided for @scatterChartTitle.
  ///
  /// In it, this message translates to:
  /// **'Distribuzione Attività'**
  String get scatterChartTitle;

  /// No description provided for @scatterChartNoActivities.
  ///
  /// In it, this message translates to:
  /// **'Nessuna attività votata'**
  String get scatterChartNoActivities;

  /// No description provided for @scatterChartVoteToShow.
  ///
  /// In it, this message translates to:
  /// **'Vota le attività per visualizzarle nel grafico'**
  String get scatterChartVoteToShow;

  /// No description provided for @scatterChartUrgencyLabel.
  ///
  /// In it, this message translates to:
  /// **'Urgenza:'**
  String get scatterChartUrgencyLabel;

  /// No description provided for @scatterChartImportanceLabel.
  ///
  /// In it, this message translates to:
  /// **'Importanza:'**
  String get scatterChartImportanceLabel;

  /// No description provided for @scatterChartAxisUrgency.
  ///
  /// In it, this message translates to:
  /// **'URGENZA'**
  String get scatterChartAxisUrgency;

  /// No description provided for @scatterChartAxisImportance.
  ///
  /// In it, this message translates to:
  /// **'IMPORTANZA'**
  String get scatterChartAxisImportance;

  /// No description provided for @scatterChartQ1Label.
  ///
  /// In it, this message translates to:
  /// **'Q1 - FAI'**
  String get scatterChartQ1Label;

  /// No description provided for @scatterChartQ2Label.
  ///
  /// In it, this message translates to:
  /// **'Q2 - PIANIFICA'**
  String get scatterChartQ2Label;

  /// No description provided for @scatterChartQ3Label.
  ///
  /// In it, this message translates to:
  /// **'Q3 - DELEGA'**
  String get scatterChartQ3Label;

  /// No description provided for @scatterChartQ4Label.
  ///
  /// In it, this message translates to:
  /// **'Q4 - ELIMINA'**
  String get scatterChartQ4Label;

  /// No description provided for @scatterChartCardTitle.
  ///
  /// In it, this message translates to:
  /// **'Grafico Distribuzione'**
  String get scatterChartCardTitle;

  /// No description provided for @votingStatusYou.
  ///
  /// In it, this message translates to:
  /// **'Tu'**
  String get votingStatusYou;

  /// No description provided for @votingStatusReset.
  ///
  /// In it, this message translates to:
  /// **'Reset'**
  String get votingStatusReset;

  /// No description provided for @estimationDecimalHintPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Es: 2.5'**
  String get estimationDecimalHintPlaceholder;

  /// No description provided for @estimationDecimalSuffixDays.
  ///
  /// In it, this message translates to:
  /// **'giorni'**
  String get estimationDecimalSuffixDays;

  /// No description provided for @estimationDecimalVote.
  ///
  /// In it, this message translates to:
  /// **'Vota'**
  String get estimationDecimalVote;

  /// No description provided for @estimationDecimalVoteValue.
  ///
  /// In it, this message translates to:
  /// **'Voto: {value} giorni'**
  String estimationDecimalVoteValue(String value);

  /// No description provided for @estimationDecimalQuickSelect.
  ///
  /// In it, this message translates to:
  /// **'Selezione rapida:'**
  String get estimationDecimalQuickSelect;

  /// No description provided for @estimationDecimalEnterValue.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un valore'**
  String get estimationDecimalEnterValue;

  /// No description provided for @estimationDecimalInvalidValue.
  ///
  /// In it, this message translates to:
  /// **'Valore non valido'**
  String get estimationDecimalInvalidValue;

  /// No description provided for @estimationDecimalMinValue.
  ///
  /// In it, this message translates to:
  /// **'Min: {value}'**
  String estimationDecimalMinValue(String value);

  /// No description provided for @estimationDecimalMaxValue.
  ///
  /// In it, this message translates to:
  /// **'Max: {value}'**
  String estimationDecimalMaxValue(String value);

  /// No description provided for @estimationThreePointTitle.
  ///
  /// In it, this message translates to:
  /// **'Stima a Tre Punti (PERT)'**
  String get estimationThreePointTitle;

  /// No description provided for @estimationThreePointOptimistic.
  ///
  /// In it, this message translates to:
  /// **'Ottimistico (O)'**
  String get estimationThreePointOptimistic;

  /// No description provided for @estimationThreePointRealistic.
  ///
  /// In it, this message translates to:
  /// **'Realistico (M)'**
  String get estimationThreePointRealistic;

  /// No description provided for @estimationThreePointPessimistic.
  ///
  /// In it, this message translates to:
  /// **'Pessimistico (P)'**
  String get estimationThreePointPessimistic;

  /// No description provided for @estimationThreePointBestCase.
  ///
  /// In it, this message translates to:
  /// **'Caso migliore'**
  String get estimationThreePointBestCase;

  /// No description provided for @estimationThreePointMostLikely.
  ///
  /// In it, this message translates to:
  /// **'Più probabile'**
  String get estimationThreePointMostLikely;

  /// No description provided for @estimationThreePointWorstCase.
  ///
  /// In it, this message translates to:
  /// **'Caso peggiore'**
  String get estimationThreePointWorstCase;

  /// No description provided for @estimationThreePointAllFieldsRequired.
  ///
  /// In it, this message translates to:
  /// **'Tutti i campi sono obbligatori'**
  String get estimationThreePointAllFieldsRequired;

  /// No description provided for @estimationThreePointInvalidValues.
  ///
  /// In it, this message translates to:
  /// **'Valori non validi'**
  String get estimationThreePointInvalidValues;

  /// No description provided for @estimationThreePointOptMustBeLteReal.
  ///
  /// In it, this message translates to:
  /// **'Ottimistico deve essere <= Realistico'**
  String get estimationThreePointOptMustBeLteReal;

  /// No description provided for @estimationThreePointRealMustBeLtePess.
  ///
  /// In it, this message translates to:
  /// **'Realistico deve essere <= Pessimistico'**
  String get estimationThreePointRealMustBeLtePess;

  /// No description provided for @estimationThreePointOptMustBeLtePess.
  ///
  /// In it, this message translates to:
  /// **'Ottimistico deve essere <= Pessimistico'**
  String get estimationThreePointOptMustBeLtePess;

  /// No description provided for @estimationThreePointGuide.
  ///
  /// In it, this message translates to:
  /// **'Guida:'**
  String get estimationThreePointGuide;

  /// No description provided for @estimationThreePointGuideO.
  ///
  /// In it, this message translates to:
  /// **'O: Stima nel caso migliore (tutto va bene)'**
  String get estimationThreePointGuideO;

  /// No description provided for @estimationThreePointGuideM.
  ///
  /// In it, this message translates to:
  /// **'M: Stima più probabile (condizioni normali)'**
  String get estimationThreePointGuideM;

  /// No description provided for @estimationThreePointGuideP.
  ///
  /// In it, this message translates to:
  /// **'P: Stima nel caso peggiore (imprevisti)'**
  String get estimationThreePointGuideP;

  /// No description provided for @estimationThreePointStdDev.
  ///
  /// In it, this message translates to:
  /// **'Dev. Std'**
  String get estimationThreePointStdDev;

  /// No description provided for @estimationThreePointDaysSuffix.
  ///
  /// In it, this message translates to:
  /// **'gg'**
  String get estimationThreePointDaysSuffix;

  /// No description provided for @storyFormNewStory.
  ///
  /// In it, this message translates to:
  /// **'Nuova Story'**
  String get storyFormNewStory;

  /// No description provided for @storyFormEnterTitle.
  ///
  /// In it, this message translates to:
  /// **'Inserisci un titolo'**
  String get storyFormEnterTitle;

  /// No description provided for @sessionSearchHint.
  ///
  /// In it, this message translates to:
  /// **'Cerca sessioni...'**
  String get sessionSearchHint;

  /// No description provided for @sessionSearchFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri'**
  String get sessionSearchFilters;

  /// No description provided for @sessionSearchFiltersTooltip.
  ///
  /// In it, this message translates to:
  /// **'Filtri'**
  String get sessionSearchFiltersTooltip;

  /// No description provided for @sessionSearchStatusLabel.
  ///
  /// In it, this message translates to:
  /// **'Stato: '**
  String get sessionSearchStatusLabel;

  /// No description provided for @sessionSearchStatusAll.
  ///
  /// In it, this message translates to:
  /// **'Tutti'**
  String get sessionSearchStatusAll;

  /// No description provided for @sessionSearchStatusDraft.
  ///
  /// In it, this message translates to:
  /// **'Bozza'**
  String get sessionSearchStatusDraft;

  /// No description provided for @sessionSearchStatusActive.
  ///
  /// In it, this message translates to:
  /// **'Attiva'**
  String get sessionSearchStatusActive;

  /// No description provided for @sessionSearchStatusCompleted.
  ///
  /// In it, this message translates to:
  /// **'Completata'**
  String get sessionSearchStatusCompleted;

  /// No description provided for @sessionSearchModeLabel.
  ///
  /// In it, this message translates to:
  /// **'Modalità: '**
  String get sessionSearchModeLabel;

  /// No description provided for @sessionSearchModeAll.
  ///
  /// In it, this message translates to:
  /// **'Tutte'**
  String get sessionSearchModeAll;

  /// No description provided for @sessionSearchRemoveFilters.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi filtri'**
  String get sessionSearchRemoveFilters;

  /// No description provided for @sessionSearchActiveFilters.
  ///
  /// In it, this message translates to:
  /// **'Filtri attivi:'**
  String get sessionSearchActiveFilters;

  /// No description provided for @sessionSearchRemoveAllFilters.
  ///
  /// In it, this message translates to:
  /// **'Rimuovi tutti'**
  String get sessionSearchRemoveAllFilters;

  /// No description provided for @participantsTitle.
  ///
  /// In it, this message translates to:
  /// **'Partecipanti ({count})'**
  String participantsTitle(int count);

  /// No description provided for @participantRoleFacilitator.
  ///
  /// In it, this message translates to:
  /// **'Facilitatore'**
  String get participantRoleFacilitator;

  /// No description provided for @participantRoleVoters.
  ///
  /// In it, this message translates to:
  /// **'Votanti'**
  String get participantRoleVoters;

  /// No description provided for @participantRoleObservers.
  ///
  /// In it, this message translates to:
  /// **'Osservatori'**
  String get participantRoleObservers;

  /// No description provided for @votingBoardVotesRevealed.
  ///
  /// In it, this message translates to:
  /// **'Voti Rivelati'**
  String get votingBoardVotesRevealed;

  /// No description provided for @votingBoardVotingInProgress.
  ///
  /// In it, this message translates to:
  /// **'Votazione in Corso'**
  String get votingBoardVotingInProgress;

  /// No description provided for @votingBoardVotesCount.
  ///
  /// In it, this message translates to:
  /// **'{voted}/{total} voti'**
  String votingBoardVotesCount(int voted, int total);

  /// No description provided for @estimationSelectYourEstimate.
  ///
  /// In it, this message translates to:
  /// **'Seleziona la tua stima'**
  String get estimationSelectYourEstimate;

  /// No description provided for @estimationVoteSelected.
  ///
  /// In it, this message translates to:
  /// **'Voto selezionato: {value}'**
  String estimationVoteSelected(String value);

  /// No description provided for @estimationDotVotingTitle.
  ///
  /// In it, this message translates to:
  /// **'Dot Voting'**
  String get estimationDotVotingTitle;

  /// No description provided for @estimationDotVotingDesc.
  ///
  /// In it, this message translates to:
  /// **'Modalità di votazione con allocazione punti.\nProssimamente...'**
  String get estimationDotVotingDesc;

  /// No description provided for @estimationBucketSystemTitle.
  ///
  /// In it, this message translates to:
  /// **'Bucket System'**
  String get estimationBucketSystemTitle;

  /// No description provided for @estimationBucketSystemDesc.
  ///
  /// In it, this message translates to:
  /// **'Stima per affinità con raggruppamento.\nProssimamente...'**
  String get estimationBucketSystemDesc;

  /// No description provided for @estimationModeTitle.
  ///
  /// In it, this message translates to:
  /// **'Modalità di Stima'**
  String get estimationModeTitle;

  /// No description provided for @statisticsTitle.
  ///
  /// In it, this message translates to:
  /// **'Statistiche Votazione'**
  String get statisticsTitle;

  /// No description provided for @statisticsAverage.
  ///
  /// In it, this message translates to:
  /// **'Media'**
  String get statisticsAverage;

  /// No description provided for @statisticsMedian.
  ///
  /// In it, this message translates to:
  /// **'Mediana'**
  String get statisticsMedian;

  /// No description provided for @statisticsMode.
  ///
  /// In it, this message translates to:
  /// **'Moda'**
  String get statisticsMode;

  /// No description provided for @statisticsVoters.
  ///
  /// In it, this message translates to:
  /// **'Votanti'**
  String get statisticsVoters;

  /// No description provided for @statisticsPertStats.
  ///
  /// In it, this message translates to:
  /// **'Statistiche PERT'**
  String get statisticsPertStats;

  /// No description provided for @statisticsPertAvg.
  ///
  /// In it, this message translates to:
  /// **'Media PERT'**
  String get statisticsPertAvg;

  /// No description provided for @statisticsStdDev.
  ///
  /// In it, this message translates to:
  /// **'Dev. Std'**
  String get statisticsStdDev;

  /// No description provided for @statisticsVariance.
  ///
  /// In it, this message translates to:
  /// **'Varianza'**
  String get statisticsVariance;

  /// No description provided for @statisticsRange.
  ///
  /// In it, this message translates to:
  /// **'Range:'**
  String get statisticsRange;

  /// No description provided for @statisticsConsensusReached.
  ///
  /// In it, this message translates to:
  /// **'Consenso raggiunto!'**
  String get statisticsConsensusReached;

  /// No description provided for @retroGuideTooltip.
  ///
  /// In it, this message translates to:
  /// **'Guida alle Retrospettive'**
  String get retroGuideTooltip;

  /// No description provided for @retroSearchPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Cerca retrospettiva...'**
  String get retroSearchPlaceholder;

  /// No description provided for @retroNoSearchResults.
  ///
  /// In it, this message translates to:
  /// **'Nessun risultato per la ricerca'**
  String get retroNoSearchResults;

  /// No description provided for @retroNewRetro.
  ///
  /// In it, this message translates to:
  /// **'Nuova Retrospettiva'**
  String get retroNewRetro;

  /// No description provided for @retroNoProjectsFound.
  ///
  /// In it, this message translates to:
  /// **'Nessun progetto trovato.'**
  String get retroNoProjectsFound;

  /// No description provided for @retroDeleteMessage.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro di voler eliminare definitivamente la retrospettiva \"{retroName}\"?\n\nQuesta azione è irreversibile e cancellerà tutti i dati associati (card, voti, action items).'**
  String retroDeleteMessage(String retroName);

  /// No description provided for @retroDeletePermanently.
  ///
  /// In it, this message translates to:
  /// **'Elimina definitivamente'**
  String get retroDeletePermanently;

  /// No description provided for @retroDeletedSuccess.
  ///
  /// In it, this message translates to:
  /// **'Retrospettiva eliminata con successo'**
  String get retroDeletedSuccess;

  /// No description provided for @errorPrefix.
  ///
  /// In it, this message translates to:
  /// **'Errore: {error}'**
  String errorPrefix(String error);

  /// No description provided for @loaderProjectIdMissing.
  ///
  /// In it, this message translates to:
  /// **'ID progetto mancante'**
  String get loaderProjectIdMissing;

  /// No description provided for @loaderProjectNotFound.
  ///
  /// In it, this message translates to:
  /// **'Progetto non trovato'**
  String get loaderProjectNotFound;

  /// No description provided for @loaderLoadError.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento'**
  String get loaderLoadError;

  /// No description provided for @loaderError.
  ///
  /// In it, this message translates to:
  /// **'Errore'**
  String get loaderError;

  /// No description provided for @loaderUnknownError.
  ///
  /// In it, this message translates to:
  /// **'Errore sconosciuto'**
  String get loaderUnknownError;

  /// No description provided for @actionGoBack.
  ///
  /// In it, this message translates to:
  /// **'Torna indietro'**
  String get actionGoBack;

  /// No description provided for @authRequired.
  ///
  /// In it, this message translates to:
  /// **'Autenticazione richiesta'**
  String get authRequired;

  /// No description provided for @retroIdMissing.
  ///
  /// In it, this message translates to:
  /// **'ID retrospettiva mancante'**
  String get retroIdMissing;

  /// No description provided for @pokerInviteStatusAccepted.
  ///
  /// In it, this message translates to:
  /// **'è già stato accettato'**
  String get pokerInviteStatusAccepted;

  /// No description provided for @pokerInviteStatusDeclined.
  ///
  /// In it, this message translates to:
  /// **'è stato rifiutato'**
  String get pokerInviteStatusDeclined;

  /// No description provided for @pokerInviteStatusExpired.
  ///
  /// In it, this message translates to:
  /// **'è scaduto'**
  String get pokerInviteStatusExpired;

  /// No description provided for @pokerInviteStatusRevoked.
  ///
  /// In it, this message translates to:
  /// **'è stato revocato'**
  String get pokerInviteStatusRevoked;

  /// No description provided for @pokerInviteStatusPending.
  ///
  /// In it, this message translates to:
  /// **'è in attesa'**
  String get pokerInviteStatusPending;

  /// No description provided for @pokerInviteYouAreInvited.
  ///
  /// In it, this message translates to:
  /// **'Sei Stato Invitato!'**
  String get pokerInviteYouAreInvited;

  /// No description provided for @pokerInviteInvitedBy.
  ///
  /// In it, this message translates to:
  /// **'{name} ti ha invitato a partecipare'**
  String pokerInviteInvitedBy(String name);

  /// No description provided for @pokerInviteSessionLabel.
  ///
  /// In it, this message translates to:
  /// **'Sessione'**
  String get pokerInviteSessionLabel;

  /// No description provided for @pokerInviteProjectLabel.
  ///
  /// In it, this message translates to:
  /// **'Progetto'**
  String get pokerInviteProjectLabel;

  /// No description provided for @pokerInviteRoleLabel.
  ///
  /// In it, this message translates to:
  /// **'Ruolo Assegnato'**
  String get pokerInviteRoleLabel;

  /// No description provided for @pokerInviteExpiryLabel.
  ///
  /// In it, this message translates to:
  /// **'Scadenza Invito'**
  String get pokerInviteExpiryLabel;

  /// No description provided for @pokerInviteExpiryDays.
  ///
  /// In it, this message translates to:
  /// **'Tra {days} giorni'**
  String pokerInviteExpiryDays(int days);

  /// No description provided for @pokerInviteDecline.
  ///
  /// In it, this message translates to:
  /// **'Rifiuta'**
  String get pokerInviteDecline;

  /// No description provided for @pokerInviteAccept.
  ///
  /// In it, this message translates to:
  /// **'Accetta Invito'**
  String get pokerInviteAccept;

  /// No description provided for @loadingMatrixError.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento matrice: {error}'**
  String loadingMatrixError(String error);

  /// No description provided for @loadingDataError.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento dati: {error}'**
  String loadingDataError(String error);

  /// No description provided for @loadingActivitiesError.
  ///
  /// In it, this message translates to:
  /// **'Errore caricamento attività: {error}'**
  String loadingActivitiesError(String error);

  /// No description provided for @smartTodoSprintDays.
  ///
  /// In it, this message translates to:
  /// **'{days} giorni/sprint'**
  String smartTodoSprintDays(int days);

  /// No description provided for @smartTodoHoursPerDay.
  ///
  /// In it, this message translates to:
  /// **'{hours}h/giorno'**
  String smartTodoHoursPerDay(int hours);

  /// No description provided for @smartTodoImageFromClipboardFound.
  ///
  /// In it, this message translates to:
  /// **'Immagine trovata negli appunti'**
  String get smartTodoImageFromClipboardFound;

  /// No description provided for @smartTodoAddImageFromClipboard.
  ///
  /// In it, this message translates to:
  /// **'Aggiungi immagine dagli appunti'**
  String get smartTodoAddImageFromClipboard;

  /// No description provided for @smartTodoInviteCreatedAndSent.
  ///
  /// In it, this message translates to:
  /// **'Invito creato e inviato'**
  String get smartTodoInviteCreatedAndSent;

  /// No description provided for @retroColumnDropDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa non porta valore e dovrebbe essere eliminato?'**
  String get retroColumnDropDesc;

  /// No description provided for @retroColumnAddDesc.
  ///
  /// In it, this message translates to:
  /// **'Quali nuove pratiche dovremmo introdurre?'**
  String get retroColumnAddDesc;

  /// No description provided for @retroColumnKeepDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa sta funzionando bene e dovrebbe continuare?'**
  String get retroColumnKeepDesc;

  /// No description provided for @retroColumnImproveDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa possiamo fare meglio?'**
  String get retroColumnImproveDesc;

  /// No description provided for @retroColumnStart.
  ///
  /// In it, this message translates to:
  /// **'Inizia'**
  String get retroColumnStart;

  /// No description provided for @retroColumnStartDesc.
  ///
  /// In it, this message translates to:
  /// **'Quali nuove attività o processi dovremmo iniziare per migliorare?'**
  String get retroColumnStartDesc;

  /// No description provided for @retroColumnStop.
  ///
  /// In it, this message translates to:
  /// **'Ferma'**
  String get retroColumnStop;

  /// No description provided for @retroColumnStopDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa non sta portando valore e dovremmo smettere di fare?'**
  String get retroColumnStopDesc;

  /// No description provided for @retroColumnContinue.
  ///
  /// In it, this message translates to:
  /// **'Continua'**
  String get retroColumnContinue;

  /// No description provided for @retroColumnContinueDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa sta funzionando bene e dobbiamo continuare a fare?'**
  String get retroColumnContinueDesc;

  /// No description provided for @retroColumnLongedFor.
  ///
  /// In it, this message translates to:
  /// **'Desiderato'**
  String get retroColumnLongedFor;

  /// No description provided for @retroColumnLikedDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti è piaciuto di questo sprint?'**
  String get retroColumnLikedDesc;

  /// No description provided for @retroColumnLearnedDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa hai imparato di nuovo?'**
  String get retroColumnLearnedDesc;

  /// No description provided for @retroColumnLackedDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa è mancato in questo sprint?'**
  String get retroColumnLackedDesc;

  /// No description provided for @retroColumnLongedForDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa desidereresti avere nel prossimo futuro?'**
  String get retroColumnLongedForDesc;

  /// No description provided for @retroColumnMadDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha fatto arrabbiare o frustrare?'**
  String get retroColumnMadDesc;

  /// No description provided for @retroColumnSadDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha deluso o reso triste?'**
  String get retroColumnSadDesc;

  /// No description provided for @retroColumnGladDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha reso felice o soddisfatto?'**
  String get retroColumnGladDesc;

  /// No description provided for @retroColumnWindDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ci ha spinto avanti? Punti di forza e supporto.'**
  String get retroColumnWindDesc;

  /// No description provided for @retroColumnAnchorDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa ci ha rallentato? Ostacoli e blocchi.'**
  String get retroColumnAnchorDesc;

  /// No description provided for @retroColumnRockDesc.
  ///
  /// In it, this message translates to:
  /// **'Quali rischi futuri vediamo all\'orizzonte?'**
  String get retroColumnRockDesc;

  /// No description provided for @retroColumnGoalDesc.
  ///
  /// In it, this message translates to:
  /// **'Qual è la nostra destinazione ideale?'**
  String get retroColumnGoalDesc;

  /// No description provided for @retroColumnMoreDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo fare di più?'**
  String get retroColumnMoreDesc;

  /// No description provided for @retroColumnLessDesc.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo fare di meno?'**
  String get retroColumnLessDesc;

  /// No description provided for @actionTypeMaintain.
  ///
  /// In it, this message translates to:
  /// **'Mantenere'**
  String get actionTypeMaintain;

  /// No description provided for @actionTypeStop.
  ///
  /// In it, this message translates to:
  /// **'Fermare'**
  String get actionTypeStop;

  /// No description provided for @actionTypeBegin.
  ///
  /// In it, this message translates to:
  /// **'Iniziare'**
  String get actionTypeBegin;

  /// No description provided for @actionTypeIncrease.
  ///
  /// In it, this message translates to:
  /// **'Aumentare'**
  String get actionTypeIncrease;

  /// No description provided for @actionTypeDecrease.
  ///
  /// In it, this message translates to:
  /// **'Diminuire'**
  String get actionTypeDecrease;

  /// No description provided for @actionTypePrevent.
  ///
  /// In it, this message translates to:
  /// **'Prevenire'**
  String get actionTypePrevent;

  /// No description provided for @actionTypeCelebrate.
  ///
  /// In it, this message translates to:
  /// **'Celebrare'**
  String get actionTypeCelebrate;

  /// No description provided for @actionTypeReplicate.
  ///
  /// In it, this message translates to:
  /// **'Replicare'**
  String get actionTypeReplicate;

  /// No description provided for @actionTypeShare.
  ///
  /// In it, this message translates to:
  /// **'Condividere'**
  String get actionTypeShare;

  /// No description provided for @actionTypeProvide.
  ///
  /// In it, this message translates to:
  /// **'Fornire'**
  String get actionTypeProvide;

  /// No description provided for @actionTypePlan.
  ///
  /// In it, this message translates to:
  /// **'Pianificare'**
  String get actionTypePlan;

  /// No description provided for @actionTypeLeverage.
  ///
  /// In it, this message translates to:
  /// **'Sfruttare'**
  String get actionTypeLeverage;

  /// No description provided for @actionTypeRemove.
  ///
  /// In it, this message translates to:
  /// **'Rimuovere'**
  String get actionTypeRemove;

  /// No description provided for @actionTypeMitigate.
  ///
  /// In it, this message translates to:
  /// **'Mitigare'**
  String get actionTypeMitigate;

  /// No description provided for @actionTypeAlign.
  ///
  /// In it, this message translates to:
  /// **'Allineare'**
  String get actionTypeAlign;

  /// No description provided for @actionTypeEliminate.
  ///
  /// In it, this message translates to:
  /// **'Eliminare'**
  String get actionTypeEliminate;

  /// No description provided for @actionTypeImplement.
  ///
  /// In it, this message translates to:
  /// **'Implementare'**
  String get actionTypeImplement;

  /// No description provided for @actionTypeEnhance.
  ///
  /// In it, this message translates to:
  /// **'Migliorare'**
  String get actionTypeEnhance;

  /// No description provided for @coachTipSSCWriting.
  ///
  /// In it, this message translates to:
  /// **'Concentrati su comportamenti concreti e osservabili. Ogni elemento deve essere qualcosa su cui il team può agire direttamente. Evita affermazioni vaghe.'**
  String get coachTipSSCWriting;

  /// No description provided for @coachTipSSCVoting.
  ///
  /// In it, this message translates to:
  /// **'Vota in base all\'impatto e alla fattibilità. Gli elementi più votati diventeranno gli impegni del prossimo sprint.'**
  String get coachTipSSCVoting;

  /// No description provided for @coachTipSSCDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Per ogni elemento più votato, definisci CHI farà COSA entro QUANDO. Trasforma le intuizioni in azioni specifiche.'**
  String get coachTipSSCDiscuss;

  /// No description provided for @coachTipMSGWriting.
  ///
  /// In it, this message translates to:
  /// **'Crea uno spazio sicuro per le emozioni. Tutti i sentimenti sono validi. Concentrati sulla situazione, non sulla persona. Usa affermazioni tipo \'Mi sento...\'.'**
  String get coachTipMSGWriting;

  /// No description provided for @coachTipMSGVoting.
  ///
  /// In it, this message translates to:
  /// **'Vota per identificare esperienze condivise. I pattern nelle emozioni rivelano dinamiche di team che richiedono attenzione.'**
  String get coachTipMSGVoting;

  /// No description provided for @coachTipMSGDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Riconosci le emozioni prima di risolvere i problemi. Chiedi \'Cosa aiuterebbe?\' invece di saltare alle soluzioni. Ascolta attivamente.'**
  String get coachTipMSGDiscuss;

  /// No description provided for @coachTip4LsWriting.
  ///
  /// In it, this message translates to:
  /// **'Rifletti sugli apprendimenti, non solo sugli eventi. Pensa a quali intuizioni porterai avanti. Ogni L rappresenta una prospettiva diversa.'**
  String get coachTip4LsWriting;

  /// No description provided for @coachTip4LsVoting.
  ///
  /// In it, this message translates to:
  /// **'Prioritizza gli apprendimenti che potrebbero migliorare gli sprint futuri. Concentrati sulla conoscenza trasferibile.'**
  String get coachTip4LsVoting;

  /// No description provided for @coachTip4LsDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Trasforma gli apprendimenti in documentazione o modifiche ai processi. Chiedi \'Come possiamo condividere questa conoscenza con altri?\''**
  String get coachTip4LsDiscuss;

  /// No description provided for @coachTipSailboatWriting.
  ///
  /// In it, this message translates to:
  /// **'Usa la metafora: il Vento ci spinge avanti (abilitatori), le Ancore ci rallentano (bloccanti), gli Scogli sono rischi futuri, l\'Isola è il nostro obiettivo.'**
  String get coachTipSailboatWriting;

  /// No description provided for @coachTipSailboatVoting.
  ///
  /// In it, this message translates to:
  /// **'Prioritizza in base all\'impatto del rischio e al potenziale degli abilitatori. Bilancia l\'affrontare i bloccanti con lo sfruttare i punti di forza.'**
  String get coachTipSailboatVoting;

  /// No description provided for @coachTipSailboatDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Crea un registro rischi per gli scogli. Definisci strategie di mitigazione. Sfrutta i venti per superare le ancore.'**
  String get coachTipSailboatDiscuss;

  /// No description provided for @coachTipDAKIWriting.
  ///
  /// In it, this message translates to:
  /// **'Sii decisivo: Elimina ciò che spreca tempo, Aggiungi ciò che manca, Mantieni ciò che funziona, Migliora ciò che potrebbe essere meglio.'**
  String get coachTipDAKIWriting;

  /// No description provided for @coachTipDAKIVoting.
  ///
  /// In it, this message translates to:
  /// **'Vota pragmaticamente. Concentrati sui cambiamenti che avranno un impatto immediato e misurabile.'**
  String get coachTipDAKIVoting;

  /// No description provided for @coachTipDAKIDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Prendi decisioni chiare come team. Per ogni elemento, impegnati in un\'azione specifica o decidi esplicitamente di non agire.'**
  String get coachTipDAKIDiscuss;

  /// No description provided for @coachTipStarfishWriting.
  ///
  /// In it, this message translates to:
  /// **'Usa le gradazioni: Mantieni (come è), Di Più (aumenta), Di Meno (diminuisci), Stop (elimina), Start (inizia). Questo permette feedback sfumati.'**
  String get coachTipStarfishWriting;

  /// No description provided for @coachTipStarfishVoting.
  ///
  /// In it, this message translates to:
  /// **'Considera lo sforzo vs l\'impatto. Gli elementi \'Di Più\' e \'Di Meno\' potrebbero essere più facili da implementare di \'Start\' e \'Stop\'.'**
  String get coachTipStarfishVoting;

  /// No description provided for @coachTipStarfishDiscuss.
  ///
  /// In it, this message translates to:
  /// **'Definisci metriche specifiche per \'di più\' e \'di meno\'. Quanto di più? Come misureremo? Stabilisci obiettivi di calibrazione chiari.'**
  String get coachTipStarfishDiscuss;

  /// No description provided for @discussPromptSSCStart.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova pratica dovremmo iniziare? Pensa alle lacune nel nostro processo che una nuova abitudine potrebbe colmare.'**
  String get discussPromptSSCStart;

  /// No description provided for @discussPromptSSCStop.
  ///
  /// In it, this message translates to:
  /// **'Cosa spreca il nostro tempo o energia? Considera le attività che non portano valore proporzionato al loro costo.'**
  String get discussPromptSSCStop;

  /// No description provided for @discussPromptSSCContinue.
  ///
  /// In it, this message translates to:
  /// **'Cosa sta funzionando bene? Riconosci e rafforza le pratiche efficaci.'**
  String get discussPromptSSCContinue;

  /// No description provided for @discussPromptMSGMad.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha frustrato? Ricorda, stiamo discutendo situazioni, non incolpando individui.'**
  String get discussPromptMSGMad;

  /// No description provided for @discussPromptMSGSad.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha deluso? Quali aspettative non sono state soddisfatte?'**
  String get discussPromptMSGSad;

  /// No description provided for @discussPromptMSGGlad.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti ha reso felice? Quali momenti ti hanno dato soddisfazione questo sprint?'**
  String get discussPromptMSGGlad;

  /// No description provided for @discussPrompt4LsLiked.
  ///
  /// In it, this message translates to:
  /// **'Cosa ti è piaciuto? Cosa ha reso il lavoro piacevole?'**
  String get discussPrompt4LsLiked;

  /// No description provided for @discussPrompt4LsLearned.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova competenza, intuizione o conoscenza hai acquisito?'**
  String get discussPrompt4LsLearned;

  /// No description provided for @discussPrompt4LsLacked.
  ///
  /// In it, this message translates to:
  /// **'Cosa è mancato? Quali risorse, supporto o chiarezza avrebbero aiutato?'**
  String get discussPrompt4LsLacked;

  /// No description provided for @discussPrompt4LsLonged.
  ///
  /// In it, this message translates to:
  /// **'Cosa desideri? Cosa renderebbe migliori gli sprint futuri?'**
  String get discussPrompt4LsLonged;

  /// No description provided for @discussPromptSailboatWind.
  ///
  /// In it, this message translates to:
  /// **'Cosa ci ha spinto avanti? Quali sono i nostri punti di forza e supporto esterno?'**
  String get discussPromptSailboatWind;

  /// No description provided for @discussPromptSailboatAnchor.
  ///
  /// In it, this message translates to:
  /// **'Cosa ci ha rallentato? Quali ostacoli interni o esterni ci hanno frenato?'**
  String get discussPromptSailboatAnchor;

  /// No description provided for @discussPromptSailboatRock.
  ///
  /// In it, this message translates to:
  /// **'Quali rischi vediamo all\'orizzonte? Cosa potrebbe deragliarci se non affrontato?'**
  String get discussPromptSailboatRock;

  /// No description provided for @discussPromptSailboatGoal.
  ///
  /// In it, this message translates to:
  /// **'Qual è la nostra destinazione? Siamo allineati su dove stiamo andando?'**
  String get discussPromptSailboatGoal;

  /// No description provided for @discussPromptDAKIDrop.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo eliminare? Cosa non porta valore?'**
  String get discussPromptDAKIDrop;

  /// No description provided for @discussPromptDAKIAdd.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo introdurre? Cosa manca dal nostro toolkit?'**
  String get discussPromptDAKIAdd;

  /// No description provided for @discussPromptDAKIKeep.
  ///
  /// In it, this message translates to:
  /// **'Cosa dobbiamo preservare? Cosa è essenziale per il nostro successo?'**
  String get discussPromptDAKIKeep;

  /// No description provided for @discussPromptDAKIImprove.
  ///
  /// In it, this message translates to:
  /// **'Cosa potrebbe essere migliore? Dove possiamo migliorare?'**
  String get discussPromptDAKIImprove;

  /// No description provided for @discussPromptStarfishKeep.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo mantenere esattamente così com\'è?'**
  String get discussPromptStarfishKeep;

  /// No description provided for @discussPromptStarfishMore.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo aumentare? Fare di più?'**
  String get discussPromptStarfishMore;

  /// No description provided for @discussPromptStarfishLess.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo ridurre? Fare di meno?'**
  String get discussPromptStarfishLess;

  /// No description provided for @discussPromptStarfishStop.
  ///
  /// In it, this message translates to:
  /// **'Cosa dovremmo eliminare completamente?'**
  String get discussPromptStarfishStop;

  /// No description provided for @discussPromptStarfishStart.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova cosa dovremmo iniziare?'**
  String get discussPromptStarfishStart;

  /// No description provided for @discussPromptGeneric.
  ///
  /// In it, this message translates to:
  /// **'Quali intuizioni sono emerse da questa colonna? Quali pattern vedi?'**
  String get discussPromptGeneric;

  /// No description provided for @smartPromptSSCStartQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale specifica nuova pratica inizierai, e come misurerai la sua adozione?'**
  String get smartPromptSSCStartQuestion;

  /// No description provided for @smartPromptSSCStartExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Iniziare standup giornaliero di 15 min alle 9:30, tracciare presenze per 2 settimane\''**
  String get smartPromptSSCStartExample;

  /// No description provided for @smartPromptSSCStartPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Inizieremo [pratica specifica] entro [data], misurata da [metrica]'**
  String get smartPromptSSCStartPlaceholder;

  /// No description provided for @smartPromptSSCStopQuestion.
  ///
  /// In it, this message translates to:
  /// **'Cosa smetterai di fare, e cosa farai invece?'**
  String get smartPromptSSCStopQuestion;

  /// No description provided for @smartPromptSSCStopExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Smettere di inviare aggiornamenti status via email, usare il canale Slack #updates invece\''**
  String get smartPromptSSCStopExample;

  /// No description provided for @smartPromptSSCStopPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Smetteremo di fare [pratica] e invece [alternativa]'**
  String get smartPromptSSCStopPlaceholder;

  /// No description provided for @smartPromptSSCContinueQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale pratica continuerai, e come ti assicurerai che non svanisca?'**
  String get smartPromptSSCContinueQuestion;

  /// No description provided for @smartPromptSSCContinueExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Continuare code review entro 4 ore, aggiungere alla Definition of Done\''**
  String get smartPromptSSCContinueExample;

  /// No description provided for @smartPromptSSCContinuePlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Continueremo [pratica], rafforzata da [meccanismo]'**
  String get smartPromptSSCContinuePlaceholder;

  /// No description provided for @smartPromptMSGMadQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale azione affronterebbe questa frustrazione e chi la guiderà?'**
  String get smartPromptMSGMadQuestion;

  /// No description provided for @smartPromptMSGMadExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Programmare meeting con PM per chiarire processo requisiti - Maria entro venerdì\''**
  String get smartPromptMSGMadExample;

  /// No description provided for @smartPromptMSGMadPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'[Azione per affrontare frustrazione], owner: [nome], entro: [data]'**
  String get smartPromptMSGMadPlaceholder;

  /// No description provided for @smartPromptMSGSadQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale cambiamento impedirebbe a questa delusione di ripetersi?'**
  String get smartPromptMSGSadQuestion;

  /// No description provided for @smartPromptMSGSadExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Creare checklist comunicazione per aggiornamenti stakeholder - revisione settimanale\''**
  String get smartPromptMSGSadExample;

  /// No description provided for @smartPromptMSGSadPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'[Azione preventiva], tracciata via [metodo]'**
  String get smartPromptMSGSadPlaceholder;

  /// No description provided for @smartPromptMSGGladQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come possiamo replicare o amplificare ciò che ci ha resi felici?'**
  String get smartPromptMSGGladQuestion;

  /// No description provided for @smartPromptMSGGladExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Documentare formato sessione pairing e condividere con altri team entro fine settimana\''**
  String get smartPromptMSGGladExample;

  /// No description provided for @smartPromptMSGGladPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'[Azione per replicare/amplificare], condividere con [audience]'**
  String get smartPromptMSGGladPlaceholder;

  /// No description provided for @smartPrompt4LsLikedQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come possiamo assicurare che questa esperienza positiva continui?'**
  String get smartPrompt4LsLikedQuestion;

  /// No description provided for @smartPrompt4LsLikedExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Rendere la sessione mob programming un evento ricorrente settimanale sul calendario\''**
  String get smartPrompt4LsLikedExample;

  /// No description provided for @smartPrompt4LsLikedPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'[Azione per preservare esperienza positiva]'**
  String get smartPrompt4LsLikedPlaceholder;

  /// No description provided for @smartPrompt4LsLearnedQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come documenterai e condividerai questo apprendimento?'**
  String get smartPrompt4LsLearnedQuestion;

  /// No description provided for @smartPrompt4LsLearnedExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Scrivere articolo wiki sul nuovo approccio testing, presentare in tech talk il mese prossimo\''**
  String get smartPrompt4LsLearnedExample;

  /// No description provided for @smartPrompt4LsLearnedPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Documentare in [posizione], condividere via [metodo] entro [data]'**
  String get smartPrompt4LsLearnedPlaceholder;

  /// No description provided for @smartPrompt4LsLackedQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quali specifiche risorse o supporto richiederai e a chi?'**
  String get smartPrompt4LsLackedQuestion;

  /// No description provided for @smartPrompt4LsLackedExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Richiedere budget formazione CI/CD al manager - inviare entro prossimo planning\''**
  String get smartPrompt4LsLackedExample;

  /// No description provided for @smartPrompt4LsLackedPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Richiedere [risorsa] da [persona/team], deadline: [data]'**
  String get smartPrompt4LsLackedPlaceholder;

  /// No description provided for @smartPrompt4LsLongedQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale primo passo concreto ti avvicinerà a questo desiderio?'**
  String get smartPrompt4LsLongedQuestion;

  /// No description provided for @smartPrompt4LsLongedExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Bozza proposta per 20% tempo per progetti side - condividere con team lead lunedì\''**
  String get smartPrompt4LsLongedExample;

  /// No description provided for @smartPrompt4LsLongedPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Primo passo verso [desiderio]: [azione] entro [data]'**
  String get smartPrompt4LsLongedPlaceholder;

  /// No description provided for @smartPromptSailboatWindQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come sfrutterai questo abilitatore per accelerare il progresso?'**
  String get smartPromptSailboatWindQuestion;

  /// No description provided for @smartPromptSailboatWindExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Usare forte competenza QA per fare mentoring ai junior - programmare prima sessione questa settimana\''**
  String get smartPromptSailboatWindExample;

  /// No description provided for @smartPromptSailboatWindPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Sfruttare [abilitatore] con [azione specifica]'**
  String get smartPromptSailboatWindPlaceholder;

  /// No description provided for @smartPromptSailboatAnchorQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale azione specifica rimuoverà o ridurrà questo bloccante?'**
  String get smartPromptSailboatAnchorQuestion;

  /// No description provided for @smartPromptSailboatAnchorExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Escalare problema infrastruttura al CTO - preparare brief entro mercoledì\''**
  String get smartPromptSailboatAnchorExample;

  /// No description provided for @smartPromptSailboatAnchorPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Rimuovere [bloccante] con [azione], escalare a [persona] se necessario'**
  String get smartPromptSailboatAnchorPlaceholder;

  /// No description provided for @smartPromptSailboatRockQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale strategia di mitigazione implementerai per questo rischio?'**
  String get smartPromptSailboatRockQuestion;

  /// No description provided for @smartPromptSailboatRockExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Aggiungere piano fallback per dipendenza vendor - documentare alternative entro fine sprint\''**
  String get smartPromptSailboatRockExample;

  /// No description provided for @smartPromptSailboatRockPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Mitigare [rischio] con [strategia], trigger: [condizione]'**
  String get smartPromptSailboatRockPlaceholder;

  /// No description provided for @smartPromptSailboatGoalQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale milestone confermerà il progresso verso questo obiettivo?'**
  String get smartPromptSailboatGoalQuestion;

  /// No description provided for @smartPromptSailboatGoalExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Demo MVP agli stakeholder entro 15 Feb, raccogliere feedback via survey\''**
  String get smartPromptSailboatGoalExample;

  /// No description provided for @smartPromptSailboatGoalPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Milestone verso [obiettivo]: [deliverable] entro [data]'**
  String get smartPromptSailboatGoalPlaceholder;

  /// No description provided for @smartPromptDAKIDropQuestion.
  ///
  /// In it, this message translates to:
  /// **'Cosa eliminerai e come ti assicurerai che non ritorni?'**
  String get smartPromptDAKIDropQuestion;

  /// No description provided for @smartPromptDAKIDropExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Rimuovere step deployment manuali - automatizzare entro fine sprint\''**
  String get smartPromptDAKIDropExample;

  /// No description provided for @smartPromptDAKIDropPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Eliminare [pratica], prevenire ritorno con [meccanismo]'**
  String get smartPromptDAKIDropPlaceholder;

  /// No description provided for @smartPromptDAKIAddQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova pratica introdurrai e come validerai che funziona?'**
  String get smartPromptDAKIAddQuestion;

  /// No description provided for @smartPromptDAKIAddExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Aggiungere sistema feature flag - provare su 2 feature, rivedere risultati in 2 settimane\''**
  String get smartPromptDAKIAddExample;

  /// No description provided for @smartPromptDAKIAddPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Aggiungere [pratica], validare successo via [metrica]'**
  String get smartPromptDAKIAddPlaceholder;

  /// No description provided for @smartPromptDAKIKeepQuestion.
  ///
  /// In it, this message translates to:
  /// **'Come proteggerai questa pratica dall\'essere deprioritizzata?'**
  String get smartPromptDAKIKeepQuestion;

  /// No description provided for @smartPromptDAKIKeepExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Mantenere standard code review - aggiungere a team charter, audit mensile\''**
  String get smartPromptDAKIKeepExample;

  /// No description provided for @smartPromptDAKIKeepPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Proteggere [pratica] con [meccanismo]'**
  String get smartPromptDAKIKeepPlaceholder;

  /// No description provided for @smartPromptDAKIImproveQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale specifico miglioramento farai e come misurerai il miglioramento?'**
  String get smartPromptDAKIImproveQuestion;

  /// No description provided for @smartPromptDAKIImproveExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Migliorare copertura test dal 60% al 80% - focus su modulo pagamenti prima\''**
  String get smartPromptDAKIImproveExample;

  /// No description provided for @smartPromptDAKIImprovePlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Migliorare [pratica] da [attuale] a [target] entro [data]'**
  String get smartPromptDAKIImprovePlaceholder;

  /// No description provided for @smartPromptStarfishKeepQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale pratica manterrai e chi è owner per garantire coerenza?'**
  String get smartPromptStarfishKeepQuestion;

  /// No description provided for @smartPromptStarfishKeepExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Mantenere demo del venerdì - Tom si assicura sala prenotata, agenda condivisa entro giovedì\''**
  String get smartPromptStarfishKeepExample;

  /// No description provided for @smartPromptStarfishKeepPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Mantenere [pratica], owner: [nome]'**
  String get smartPromptStarfishKeepPlaceholder;

  /// No description provided for @smartPromptStarfishMoreQuestion.
  ///
  /// In it, this message translates to:
  /// **'Cosa aumenterai e di quanto?'**
  String get smartPromptStarfishMoreQuestion;

  /// No description provided for @smartPromptStarfishMoreExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Aumentare pair programming da 2h a 6h a settimana per sviluppatore\''**
  String get smartPromptStarfishMoreExample;

  /// No description provided for @smartPromptStarfishMorePlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Aumentare [pratica] da [livello attuale] a [livello target]'**
  String get smartPromptStarfishMorePlaceholder;

  /// No description provided for @smartPromptStarfishLessQuestion.
  ///
  /// In it, this message translates to:
  /// **'Cosa ridurrai e di quanto?'**
  String get smartPromptStarfishLessQuestion;

  /// No description provided for @smartPromptStarfishLessExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Ridurre meeting da 10h a 6h a settimana - cancellare review ricorrente\''**
  String get smartPromptStarfishLessExample;

  /// No description provided for @smartPromptStarfishLessPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Ridurre [pratica] da [livello attuale] a [livello target]'**
  String get smartPromptStarfishLessPlaceholder;

  /// No description provided for @smartPromptStarfishStopQuestion.
  ///
  /// In it, this message translates to:
  /// **'Cosa smetterai completamente di fare e cosa lo sostituisce (se qualcosa)?'**
  String get smartPromptStarfishStopQuestion;

  /// No description provided for @smartPromptStarfishStopExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Smettere tracking tempo dettagliato sui task - stime basate su fiducia invece\''**
  String get smartPromptStarfishStopExample;

  /// No description provided for @smartPromptStarfishStopPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Smettere [pratica], sostituire con [alternativa] o niente'**
  String get smartPromptStarfishStopPlaceholder;

  /// No description provided for @smartPromptStarfishStartQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale nuova pratica inizierai e quando sarà la prima occorrenza?'**
  String get smartPromptStarfishStartQuestion;

  /// No description provided for @smartPromptStarfishStartExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Iniziare tech debt Tuesday - prima sessione prossima settimana, 2h tempo protetto\''**
  String get smartPromptStarfishStartExample;

  /// No description provided for @smartPromptStarfishStartPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'Iniziare [pratica], prima occorrenza: [data/ora]'**
  String get smartPromptStarfishStartPlaceholder;

  /// No description provided for @smartPromptGenericQuestion.
  ///
  /// In it, this message translates to:
  /// **'Quale azione specifica affronterà questo elemento?'**
  String get smartPromptGenericQuestion;

  /// No description provided for @smartPromptGenericExample.
  ///
  /// In it, this message translates to:
  /// **'es., \'Definire azione specifica con owner, deadline, e criteri di successo\''**
  String get smartPromptGenericExample;

  /// No description provided for @smartPromptGenericPlaceholder.
  ///
  /// In it, this message translates to:
  /// **'[Azione], owner: [nome], entro: [data]'**
  String get smartPromptGenericPlaceholder;

  /// No description provided for @methodologyFocusAction.
  ///
  /// In it, this message translates to:
  /// **'Orientato all\'azione: si concentra su cambiamenti comportamentali concreti'**
  String get methodologyFocusAction;

  /// No description provided for @methodologyFocusEmotion.
  ///
  /// In it, this message translates to:
  /// **'Focalizzato sulle emozioni: esplora i sentimenti del team per costruire sicurezza psicologica'**
  String get methodologyFocusEmotion;

  /// No description provided for @methodologyFocusLearning.
  ///
  /// In it, this message translates to:
  /// **'Riflessivo sull\'apprendimento: enfatizza la cattura e condivisione della conoscenza'**
  String get methodologyFocusLearning;

  /// No description provided for @methodologyFocusRisk.
  ///
  /// In it, this message translates to:
  /// **'Rischio e Obiettivo: bilancia abilitatori, bloccanti, rischi e obiettivi'**
  String get methodologyFocusRisk;

  /// No description provided for @methodologyFocusCalibration.
  ///
  /// In it, this message translates to:
  /// **'Calibrazione: usa gradazioni (più/meno) per aggiustamenti sfumati'**
  String get methodologyFocusCalibration;

  /// No description provided for @methodologyFocusDecision.
  ///
  /// In it, this message translates to:
  /// **'Decisionale: guida decisioni chiare del team sulle pratiche'**
  String get methodologyFocusDecision;

  /// No description provided for @exportSheetOverview.
  ///
  /// In it, this message translates to:
  /// **'Panoramica'**
  String get exportSheetOverview;

  /// No description provided for @exportSheetActionItems.
  ///
  /// In it, this message translates to:
  /// **'Azioni'**
  String get exportSheetActionItems;

  /// No description provided for @exportSheetBoardItems.
  ///
  /// In it, this message translates to:
  /// **'Elementi Board'**
  String get exportSheetBoardItems;

  /// No description provided for @exportSheetTeamHealth.
  ///
  /// In it, this message translates to:
  /// **'Salute del Team'**
  String get exportSheetTeamHealth;

  /// No description provided for @exportSheetLessonsLearned.
  ///
  /// In it, this message translates to:
  /// **'Lezioni Apprese'**
  String get exportSheetLessonsLearned;

  /// No description provided for @exportSheetRiskRegister.
  ///
  /// In it, this message translates to:
  /// **'Registro Rischi'**
  String get exportSheetRiskRegister;

  /// No description provided for @exportSheetCalibrationMatrix.
  ///
  /// In it, this message translates to:
  /// **'Matrice Calibrazione'**
  String get exportSheetCalibrationMatrix;

  /// No description provided for @exportSheetDecisionLog.
  ///
  /// In it, this message translates to:
  /// **'Registro Decisioni'**
  String get exportSheetDecisionLog;

  /// No description provided for @exportHeaderRetrospectiveReport.
  ///
  /// In it, this message translates to:
  /// **'REPORT RETROSPETTIVA'**
  String get exportHeaderRetrospectiveReport;

  /// No description provided for @exportHeaderTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo:'**
  String get exportHeaderTitle;

  /// No description provided for @exportHeaderDate.
  ///
  /// In it, this message translates to:
  /// **'Data:'**
  String get exportHeaderDate;

  /// No description provided for @exportHeaderTemplate.
  ///
  /// In it, this message translates to:
  /// **'Template:'**
  String get exportHeaderTemplate;

  /// No description provided for @exportHeaderMethodology.
  ///
  /// In it, this message translates to:
  /// **'Focus Metodologico:'**
  String get exportHeaderMethodology;

  /// No description provided for @exportHeaderSentiments.
  ///
  /// In it, this message translates to:
  /// **'Sentimenti (Media):'**
  String get exportHeaderSentiments;

  /// No description provided for @exportHeaderParticipants.
  ///
  /// In it, this message translates to:
  /// **'PARTECIPANTI'**
  String get exportHeaderParticipants;

  /// No description provided for @exportHeaderSummary.
  ///
  /// In it, this message translates to:
  /// **'RIEPILOGO'**
  String get exportHeaderSummary;

  /// No description provided for @exportHeaderTotalItems.
  ///
  /// In it, this message translates to:
  /// **'Elementi Totali:'**
  String get exportHeaderTotalItems;

  /// No description provided for @exportHeaderActionItems.
  ///
  /// In it, this message translates to:
  /// **'Azioni:'**
  String get exportHeaderActionItems;

  /// No description provided for @exportHeaderSuggestedFollowUp.
  ///
  /// In it, this message translates to:
  /// **'Follow-up Suggerito:'**
  String get exportHeaderSuggestedFollowUp;

  /// No description provided for @exportTeamHealthTitle.
  ///
  /// In it, this message translates to:
  /// **'ANALISI SALUTE DEL TEAM'**
  String get exportTeamHealthTitle;

  /// No description provided for @exportTeamHealthEmotionalDistribution.
  ///
  /// In it, this message translates to:
  /// **'Distribuzione Emotiva'**
  String get exportTeamHealthEmotionalDistribution;

  /// No description provided for @exportTeamHealthMadCount.
  ///
  /// In it, this message translates to:
  /// **'Elementi Mad:'**
  String get exportTeamHealthMadCount;

  /// No description provided for @exportTeamHealthSadCount.
  ///
  /// In it, this message translates to:
  /// **'Elementi Sad:'**
  String get exportTeamHealthSadCount;

  /// No description provided for @exportTeamHealthGladCount.
  ///
  /// In it, this message translates to:
  /// **'Elementi Glad:'**
  String get exportTeamHealthGladCount;

  /// No description provided for @exportTeamHealthMadItems.
  ///
  /// In it, this message translates to:
  /// **'FRUSTRAZIONI (Mad)'**
  String get exportTeamHealthMadItems;

  /// No description provided for @exportTeamHealthSadItems.
  ///
  /// In it, this message translates to:
  /// **'DELUSIONI (Sad)'**
  String get exportTeamHealthSadItems;

  /// No description provided for @exportTeamHealthGladItems.
  ///
  /// In it, this message translates to:
  /// **'CELEBRAZIONI (Glad)'**
  String get exportTeamHealthGladItems;

  /// No description provided for @exportTeamHealthRecommendation.
  ///
  /// In it, this message translates to:
  /// **'Raccomandazione Salute Team:'**
  String get exportTeamHealthRecommendation;

  /// No description provided for @exportTeamHealthHighFrustration.
  ///
  /// In it, this message translates to:
  /// **'Alto livello di frustrazione rilevato. Considera di facilitare una sessione focalizzata sulla risoluzione dei problemi.'**
  String get exportTeamHealthHighFrustration;

  /// No description provided for @exportTeamHealthBalanced.
  ///
  /// In it, this message translates to:
  /// **'Stato emotivo equilibrato. Il team mostra sane capacità di riflessione.'**
  String get exportTeamHealthBalanced;

  /// No description provided for @exportTeamHealthPositive.
  ///
  /// In it, this message translates to:
  /// **'Morale del team positivo. Sfrutta questa energia per miglioramenti sfidanti.'**
  String get exportTeamHealthPositive;

  /// No description provided for @exportLessonsLearnedTitle.
  ///
  /// In it, this message translates to:
  /// **'REGISTRO LEZIONI APPRESE'**
  String get exportLessonsLearnedTitle;

  /// No description provided for @exportLessonsLearnedWhatWorked.
  ///
  /// In it, this message translates to:
  /// **'COSA HA FUNZIONATO (Liked)'**
  String get exportLessonsLearnedWhatWorked;

  /// No description provided for @exportLessonsLearnedNewSkills.
  ///
  /// In it, this message translates to:
  /// **'NUOVE COMPETENZE E INTUIZIONI (Learned)'**
  String get exportLessonsLearnedNewSkills;

  /// No description provided for @exportLessonsLearnedGaps.
  ///
  /// In it, this message translates to:
  /// **'LACUNE E ELEMENTI MANCANTI (Lacked)'**
  String get exportLessonsLearnedGaps;

  /// No description provided for @exportLessonsLearnedWishes.
  ///
  /// In it, this message translates to:
  /// **'ASPIRAZIONI FUTURE (Longed For)'**
  String get exportLessonsLearnedWishes;

  /// No description provided for @exportLessonsLearnedKnowledgeActions.
  ///
  /// In it, this message translates to:
  /// **'Azioni di Condivisione Conoscenza'**
  String get exportLessonsLearnedKnowledgeActions;

  /// No description provided for @exportLessonsLearnedDocumentationNeeded.
  ///
  /// In it, this message translates to:
  /// **'Documentazione Necessaria:'**
  String get exportLessonsLearnedDocumentationNeeded;

  /// No description provided for @exportLessonsLearnedTrainingNeeded.
  ///
  /// In it, this message translates to:
  /// **'Formazione/Condivisione Necessaria:'**
  String get exportLessonsLearnedTrainingNeeded;

  /// No description provided for @exportRiskRegisterTitle.
  ///
  /// In it, this message translates to:
  /// **'REGISTRO RISCHI E ABILITATORI'**
  String get exportRiskRegisterTitle;

  /// No description provided for @exportRiskRegisterEnablers.
  ///
  /// In it, this message translates to:
  /// **'ABILITATORI (Vento)'**
  String get exportRiskRegisterEnablers;

  /// No description provided for @exportRiskRegisterBlockers.
  ///
  /// In it, this message translates to:
  /// **'BLOCCANTI (Ancora)'**
  String get exportRiskRegisterBlockers;

  /// No description provided for @exportRiskRegisterRisks.
  ///
  /// In it, this message translates to:
  /// **'RISCHI (Scogli)'**
  String get exportRiskRegisterRisks;

  /// No description provided for @exportRiskRegisterGoals.
  ///
  /// In it, this message translates to:
  /// **'OBIETTIVI (Isola)'**
  String get exportRiskRegisterGoals;

  /// No description provided for @exportRiskRegisterRiskItem.
  ///
  /// In it, this message translates to:
  /// **'Rischio'**
  String get exportRiskRegisterRiskItem;

  /// No description provided for @exportRiskRegisterImpact.
  ///
  /// In it, this message translates to:
  /// **'Impatto Potenziale'**
  String get exportRiskRegisterImpact;

  /// No description provided for @exportRiskRegisterMitigation.
  ///
  /// In it, this message translates to:
  /// **'Azione di Mitigazione'**
  String get exportRiskRegisterMitigation;

  /// No description provided for @exportRiskRegisterStatus.
  ///
  /// In it, this message translates to:
  /// **'Stato'**
  String get exportRiskRegisterStatus;

  /// No description provided for @exportRiskRegisterGoalAlignment.
  ///
  /// In it, this message translates to:
  /// **'Verifica Allineamento Obiettivi:'**
  String get exportRiskRegisterGoalAlignment;

  /// No description provided for @exportRiskRegisterGoalAlignmentNote.
  ///
  /// In it, this message translates to:
  /// **'Verificare se le azioni correnti sono allineate con gli obiettivi dichiarati.'**
  String get exportRiskRegisterGoalAlignmentNote;

  /// No description provided for @exportCalibrationTitle.
  ///
  /// In it, this message translates to:
  /// **'MATRICE DI CALIBRAZIONE'**
  String get exportCalibrationTitle;

  /// No description provided for @exportCalibrationKeepDoing.
  ///
  /// In it, this message translates to:
  /// **'CONTINUARE A FARE'**
  String get exportCalibrationKeepDoing;

  /// No description provided for @exportCalibrationDoMore.
  ///
  /// In it, this message translates to:
  /// **'FARE DI PIÙ'**
  String get exportCalibrationDoMore;

  /// No description provided for @exportCalibrationDoLess.
  ///
  /// In it, this message translates to:
  /// **'FARE DI MENO'**
  String get exportCalibrationDoLess;

  /// No description provided for @exportCalibrationStopDoing.
  ///
  /// In it, this message translates to:
  /// **'SMETTERE DI FARE'**
  String get exportCalibrationStopDoing;

  /// No description provided for @exportCalibrationStartDoing.
  ///
  /// In it, this message translates to:
  /// **'INIZIARE A FARE'**
  String get exportCalibrationStartDoing;

  /// No description provided for @exportCalibrationPractice.
  ///
  /// In it, this message translates to:
  /// **'Pratica'**
  String get exportCalibrationPractice;

  /// No description provided for @exportCalibrationCurrentState.
  ///
  /// In it, this message translates to:
  /// **'Stato Attuale'**
  String get exportCalibrationCurrentState;

  /// No description provided for @exportCalibrationTargetState.
  ///
  /// In it, this message translates to:
  /// **'Stato Obiettivo'**
  String get exportCalibrationTargetState;

  /// No description provided for @exportCalibrationAdjustment.
  ///
  /// In it, this message translates to:
  /// **'Aggiustamento'**
  String get exportCalibrationAdjustment;

  /// No description provided for @exportCalibrationNote.
  ///
  /// In it, this message translates to:
  /// **'La calibrazione si concentra sulla messa a punto delle pratiche esistenti piuttosto che su cambiamenti radicali.'**
  String get exportCalibrationNote;

  /// No description provided for @exportDecisionLogTitle.
  ///
  /// In it, this message translates to:
  /// **'REGISTRO DECISIONI'**
  String get exportDecisionLogTitle;

  /// No description provided for @exportDecisionLogDrop.
  ///
  /// In it, this message translates to:
  /// **'DECISIONI DA ABBANDONARE'**
  String get exportDecisionLogDrop;

  /// No description provided for @exportDecisionLogAdd.
  ///
  /// In it, this message translates to:
  /// **'DECISIONI DA AGGIUNGERE'**
  String get exportDecisionLogAdd;

  /// No description provided for @exportDecisionLogKeep.
  ///
  /// In it, this message translates to:
  /// **'DECISIONI DA MANTENERE'**
  String get exportDecisionLogKeep;

  /// No description provided for @exportDecisionLogImprove.
  ///
  /// In it, this message translates to:
  /// **'DECISIONI DA MIGLIORARE'**
  String get exportDecisionLogImprove;

  /// No description provided for @exportDecisionLogDecision.
  ///
  /// In it, this message translates to:
  /// **'Decisione'**
  String get exportDecisionLogDecision;

  /// No description provided for @exportDecisionLogRationale.
  ///
  /// In it, this message translates to:
  /// **'Motivazione'**
  String get exportDecisionLogRationale;

  /// No description provided for @exportDecisionLogOwner.
  ///
  /// In it, this message translates to:
  /// **'Responsabile'**
  String get exportDecisionLogOwner;

  /// No description provided for @exportDecisionLogDeadline.
  ///
  /// In it, this message translates to:
  /// **'Scadenza'**
  String get exportDecisionLogDeadline;

  /// No description provided for @exportDecisionLogPrioritizationNote.
  ///
  /// In it, this message translates to:
  /// **'Raccomandazione Priorità:'**
  String get exportDecisionLogPrioritizationNote;

  /// No description provided for @exportDecisionLogPrioritizationHint.
  ///
  /// In it, this message translates to:
  /// **'Concentrarsi prima sulle decisioni DROP per liberare capacità, poi aggiungere nuove pratiche.'**
  String get exportDecisionLogPrioritizationHint;

  /// No description provided for @exportNoItems.
  ///
  /// In it, this message translates to:
  /// **'Nessun elemento registrato'**
  String get exportNoItems;

  /// No description provided for @exportNoActionItems.
  ///
  /// In it, this message translates to:
  /// **'Nessuna azione'**
  String get exportNoActionItems;

  /// No description provided for @exportNotApplicable.
  ///
  /// In it, this message translates to:
  /// **'N/D'**
  String get exportNotApplicable;

  /// No description provided for @facilitatorGuideTitle.
  ///
  /// In it, this message translates to:
  /// **'Guida Raccolta Azioni'**
  String get facilitatorGuideTitle;

  /// No description provided for @facilitatorGuideCoverage.
  ///
  /// In it, this message translates to:
  /// **'Copertura'**
  String get facilitatorGuideCoverage;

  /// No description provided for @facilitatorGuideComplete.
  ///
  /// In it, this message translates to:
  /// **'Completa'**
  String get facilitatorGuideComplete;

  /// No description provided for @facilitatorGuideIncomplete.
  ///
  /// In it, this message translates to:
  /// **'Incompleta'**
  String get facilitatorGuideIncomplete;

  /// No description provided for @facilitatorGuideSuggestedOrder.
  ///
  /// In it, this message translates to:
  /// **'Ordine Suggerito:'**
  String get facilitatorGuideSuggestedOrder;

  /// No description provided for @facilitatorGuideMissingRequired.
  ///
  /// In it, this message translates to:
  /// **'Azioni richieste mancanti'**
  String get facilitatorGuideMissingRequired;

  /// No description provided for @facilitatorGuideColumnHasAction.
  ///
  /// In it, this message translates to:
  /// **'Ha azione'**
  String get facilitatorGuideColumnHasAction;

  /// No description provided for @facilitatorGuideColumnNoAction.
  ///
  /// In it, this message translates to:
  /// **'Nessuna azione'**
  String get facilitatorGuideColumnNoAction;

  /// No description provided for @facilitatorGuideRequired.
  ///
  /// In it, this message translates to:
  /// **'Richiesto'**
  String get facilitatorGuideRequired;

  /// No description provided for @facilitatorGuideOptional.
  ///
  /// In it, this message translates to:
  /// **'Opzionale'**
  String get facilitatorGuideOptional;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
