import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
    Locale('it'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In it, this message translates to:
  /// **'Agile Tools'**
  String get appTitle;

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
  /// **'Agile Tools per Team'**
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
  /// **'Nome Sessione'**
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
  /// **'T-Shirt Sizes'**
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
  /// **'Si e verificato un errore'**
  String get errorGeneric;

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
  /// **'Upgrade'**
  String get profileUpgrade;

  /// No description provided for @profileUpgradePlan.
  ///
  /// In it, this message translates to:
  /// **'Upgrade Piano'**
  String get profileUpgradePlan;

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
  /// **'Elimina Account'**
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
  /// **'Aggiungi Partecipante Diretto'**
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
  /// **'Tu'**
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

  /// No description provided for @inviteExpiresIn.
  ///
  /// In it, this message translates to:
  /// **'Scade tra {days}g'**
  String inviteExpiresIn(int days);

  /// No description provided for @inviteCopyLink.
  ///
  /// In it, this message translates to:
  /// **'Copia link invito'**
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
  /// **'Revoca Invito'**
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
  /// **'Link invito copiato negli appunti'**
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

  /// No description provided for @retroNoActionItems.
  ///
  /// In it, this message translates to:
  /// **'Nessun Action Item ancora creato.'**
  String get retroNoActionItems;

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

  /// No description provided for @retroTablePriority.
  ///
  /// In it, this message translates to:
  /// **'Priorita'**
  String get retroTablePriority;

  /// No description provided for @retroTableDueDate.
  ///
  /// In it, this message translates to:
  /// **'Scadenza'**
  String get retroTableDueDate;

  /// No description provided for @retroTableActions.
  ///
  /// In it, this message translates to:
  /// **'Azioni'**
  String get retroTableActions;

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

  /// No description provided for @retroDeleteConfirm.
  ///
  /// In it, this message translates to:
  /// **'Sei sicuro?'**
  String get retroDeleteConfirm;

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

  /// No description provided for @smartTodoUnassigned.
  ///
  /// In it, this message translates to:
  /// **'Non Assegnati'**
  String get smartTodoUnassigned;

  /// No description provided for @smartTodoNewTask.
  ///
  /// In it, this message translates to:
  /// **'Nuova Attivita'**
  String get smartTodoNewTask;

  /// No description provided for @smartTodoEditTask.
  ///
  /// In it, this message translates to:
  /// **'Modifica'**
  String get smartTodoEditTask;

  /// No description provided for @smartTodoTaskTitle.
  ///
  /// In it, this message translates to:
  /// **'Titolo attivita'**
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
  /// **'PRIORITA'**
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
  /// **'Seleziona Tag'**
  String get smartTodoSelectTags;

  /// No description provided for @smartTodoNoTagsAvailable.
  ///
  /// In it, this message translates to:
  /// **'Nessun tag disponibile. Creane uno nelle impostazioni.'**
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
  /// **'URL (https://...)'**
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
  /// **'Modifica commento'**
  String get smartTodoEditComment;

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
  /// **'Esempio:\nComprare il latte, High, @mario\nFare report, Medium, @luigi'**
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
  /// **'Titolo'**
  String get storyFormTitleLabel;

  /// No description provided for @storyFormTitleHint.
  ///
  /// In it, this message translates to:
  /// **'Breve descrizione della funzionalita'**
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
  /// **'Descrizione libera della story'**
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
  /// **'Build better products\nwith Agile Tools'**
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
  /// **'L\'approccio Agile divide il lavoro in cicli brevi chiamati Sprint, tipicamente di 1-4 settimane. Ogni iterazione produce un incremento funzionante del prodotto.\n\nCon Agile Tools puoi gestire il tuo backlog, pianificare sprint e monitorare la velocity del team in tempo reale.'**
  String get landingAgileIterativeDesc;

  /// No description provided for @landingAgileScrumTitle.
  ///
  /// In it, this message translates to:
  /// **'Framework Scrum'**
  String get landingAgileScrumTitle;

  /// No description provided for @landingAgileScrumDesc.
  ///
  /// In it, this message translates to:
  /// **'Scrum è il framework Agile più diffuso. Definisce ruoli (Product Owner, Scrum Master, Team), eventi (Sprint Planning, Daily, Review, Retrospective) e artefatti (Product Backlog, Sprint Backlog).\n\nAgile Tools supporta tutti gli eventi Scrum con strumenti dedicati per ogni cerimonia.'**
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
  /// **'© 2025 Agile Tools. Tutti i diritti riservati.'**
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
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
