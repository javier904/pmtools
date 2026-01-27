import 'package:flutter/material.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

/// Guida metodologica completa per le retrospettive
/// Fornisce tips, prompts e output configuration specifici per ogni metodologia
class RetroMethodologyGuide {
  /// Ottiene il coach tip specifico per template e fase
  static String getCoachTip(AppLocalizations l10n, RetroTemplate template, RetroPhase phase) {
    final key = '${template.name}_${phase.name}';

    // Tips specifici per template/fase
    switch (key) {
      // === START STOP CONTINUE ===
      case 'startStopContinue_writing':
        return l10n.coachTipSSCWriting;
      case 'startStopContinue_voting':
        return l10n.coachTipSSCVoting;
      case 'startStopContinue_discuss':
        return l10n.coachTipSSCDiscuss;

      // === MAD SAD GLAD ===
      case 'madSadGlad_writing':
        return l10n.coachTipMSGWriting;
      case 'madSadGlad_voting':
        return l10n.coachTipMSGVoting;
      case 'madSadGlad_discuss':
        return l10n.coachTipMSGDiscuss;

      // === 4Ls ===
      case 'fourLs_writing':
        return l10n.coachTip4LsWriting;
      case 'fourLs_voting':
        return l10n.coachTip4LsVoting;
      case 'fourLs_discuss':
        return l10n.coachTip4LsDiscuss;

      // === SAILBOAT ===
      case 'sailboat_writing':
        return l10n.coachTipSailboatWriting;
      case 'sailboat_voting':
        return l10n.coachTipSailboatVoting;
      case 'sailboat_discuss':
        return l10n.coachTipSailboatDiscuss;

      // === DAKI ===
      case 'daki_writing':
        return l10n.coachTipDAKIWriting;
      case 'daki_voting':
        return l10n.coachTipDAKIVoting;
      case 'daki_discuss':
        return l10n.coachTipDAKIDiscuss;

      // === STARFISH ===
      case 'starfish_writing':
        return l10n.coachTipStarfishWriting;
      case 'starfish_voting':
        return l10n.coachTipStarfishVoting;
      case 'starfish_discuss':
        return l10n.coachTipStarfishDiscuss;

      // Default: usa i tip generici per fase
      default:
        return _getGenericPhaseTip(l10n, phase);
    }
  }

  static String _getGenericPhaseTip(AppLocalizations l10n, RetroPhase phase) {
    switch (phase) {
      case RetroPhase.setup:
        return l10n.retroCoachSetup;
      case RetroPhase.icebreaker:
        return l10n.retroCoachIcebreaker;
      case RetroPhase.writing:
        return l10n.retroCoachWriting;
      case RetroPhase.voting:
        return l10n.retroCoachVoting;
      case RetroPhase.discuss:
        return l10n.retroCoachDiscuss;
      case RetroPhase.completed:
        return l10n.retroCoachCompleted;
    }
  }

  /// Ottiene la domanda di discussione per una specifica colonna
  static String getDiscussionPrompt(AppLocalizations l10n, RetroTemplate template, String columnId) {
    final key = '${template.name}_$columnId';

    switch (key) {
      // === START STOP CONTINUE ===
      case 'startStopContinue_start':
        return l10n.discussPromptSSCStart;
      case 'startStopContinue_stop':
        return l10n.discussPromptSSCStop;
      case 'startStopContinue_continue':
        return l10n.discussPromptSSCContinue;

      // === MAD SAD GLAD ===
      case 'madSadGlad_mad':
        return l10n.discussPromptMSGMad;
      case 'madSadGlad_sad':
        return l10n.discussPromptMSGSad;
      case 'madSadGlad_glad':
        return l10n.discussPromptMSGGlad;

      // === 4Ls ===
      case 'fourLs_liked':
        return l10n.discussPrompt4LsLiked;
      case 'fourLs_learned':
        return l10n.discussPrompt4LsLearned;
      case 'fourLs_lacked':
        return l10n.discussPrompt4LsLacked;
      case 'fourLs_longed':
        return l10n.discussPrompt4LsLonged;

      // === SAILBOAT ===
      case 'sailboat_wind':
        return l10n.discussPromptSailboatWind;
      case 'sailboat_anchor':
        return l10n.discussPromptSailboatAnchor;
      case 'sailboat_rock':
        return l10n.discussPromptSailboatRock;
      case 'sailboat_goal':
        return l10n.discussPromptSailboatGoal;

      // === DAKI ===
      case 'daki_drop':
        return l10n.discussPromptDAKIDrop;
      case 'daki_add':
        return l10n.discussPromptDAKIAdd;
      case 'daki_keep':
        return l10n.discussPromptDAKIKeep;
      case 'daki_improve':
        return l10n.discussPromptDAKIImprove;

      // === STARFISH ===
      case 'starfish_keep':
        return l10n.discussPromptStarfishKeep;
      case 'starfish_more':
        return l10n.discussPromptStarfishMore;
      case 'starfish_less':
        return l10n.discussPromptStarfishLess;
      case 'starfish_stop':
        return l10n.discussPromptStarfishStop;
      case 'starfish_start':
        return l10n.discussPromptStarfishStart;

      default:
        return l10n.discussPromptGeneric;
    }
  }

  /// Ottiene il prompt SMART per creare azioni concrete da una colonna specifica
  static SmartActionPrompt getSmartActionPrompt(AppLocalizations l10n, RetroTemplate template, String columnId) {
    final key = '${template.name}_$columnId';

    switch (key) {
      // === START STOP CONTINUE ===
      case 'startStopContinue_start':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSSCStartQuestion,
          exampleAction: l10n.smartPromptSSCStartExample,
          placeholderText: l10n.smartPromptSSCStartPlaceholder,
        );
      case 'startStopContinue_stop':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSSCStopQuestion,
          exampleAction: l10n.smartPromptSSCStopExample,
          placeholderText: l10n.smartPromptSSCStopPlaceholder,
        );
      case 'startStopContinue_continue':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSSCContinueQuestion,
          exampleAction: l10n.smartPromptSSCContinueExample,
          placeholderText: l10n.smartPromptSSCContinuePlaceholder,
        );

      // === MAD SAD GLAD ===
      case 'madSadGlad_mad':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptMSGMadQuestion,
          exampleAction: l10n.smartPromptMSGMadExample,
          placeholderText: l10n.smartPromptMSGMadPlaceholder,
        );
      case 'madSadGlad_sad':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptMSGSadQuestion,
          exampleAction: l10n.smartPromptMSGSadExample,
          placeholderText: l10n.smartPromptMSGSadPlaceholder,
        );
      case 'madSadGlad_glad':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptMSGGladQuestion,
          exampleAction: l10n.smartPromptMSGGladExample,
          placeholderText: l10n.smartPromptMSGGladPlaceholder,
        );

      // === 4Ls ===
      case 'fourLs_liked':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPrompt4LsLikedQuestion,
          exampleAction: l10n.smartPrompt4LsLikedExample,
          placeholderText: l10n.smartPrompt4LsLikedPlaceholder,
        );
      case 'fourLs_learned':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPrompt4LsLearnedQuestion,
          exampleAction: l10n.smartPrompt4LsLearnedExample,
          placeholderText: l10n.smartPrompt4LsLearnedPlaceholder,
        );
      case 'fourLs_lacked':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPrompt4LsLackedQuestion,
          exampleAction: l10n.smartPrompt4LsLackedExample,
          placeholderText: l10n.smartPrompt4LsLackedPlaceholder,
        );
      case 'fourLs_longed':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPrompt4LsLongedQuestion,
          exampleAction: l10n.smartPrompt4LsLongedExample,
          placeholderText: l10n.smartPrompt4LsLongedPlaceholder,
        );

      // === SAILBOAT ===
      case 'sailboat_wind':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSailboatWindQuestion,
          exampleAction: l10n.smartPromptSailboatWindExample,
          placeholderText: l10n.smartPromptSailboatWindPlaceholder,
        );
      case 'sailboat_anchor':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSailboatAnchorQuestion,
          exampleAction: l10n.smartPromptSailboatAnchorExample,
          placeholderText: l10n.smartPromptSailboatAnchorPlaceholder,
        );
      case 'sailboat_rock':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSailboatRockQuestion,
          exampleAction: l10n.smartPromptSailboatRockExample,
          placeholderText: l10n.smartPromptSailboatRockPlaceholder,
        );
      case 'sailboat_goal':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptSailboatGoalQuestion,
          exampleAction: l10n.smartPromptSailboatGoalExample,
          placeholderText: l10n.smartPromptSailboatGoalPlaceholder,
        );

      // === DAKI ===
      case 'daki_drop':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptDAKIDropQuestion,
          exampleAction: l10n.smartPromptDAKIDropExample,
          placeholderText: l10n.smartPromptDAKIDropPlaceholder,
        );
      case 'daki_add':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptDAKIAddQuestion,
          exampleAction: l10n.smartPromptDAKIAddExample,
          placeholderText: l10n.smartPromptDAKIAddPlaceholder,
        );
      case 'daki_keep':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptDAKIKeepQuestion,
          exampleAction: l10n.smartPromptDAKIKeepExample,
          placeholderText: l10n.smartPromptDAKIKeepPlaceholder,
        );
      case 'daki_improve':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptDAKIImproveQuestion,
          exampleAction: l10n.smartPromptDAKIImproveExample,
          placeholderText: l10n.smartPromptDAKIImprovePlaceholder,
        );

      // === STARFISH ===
      case 'starfish_keep':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptStarfishKeepQuestion,
          exampleAction: l10n.smartPromptStarfishKeepExample,
          placeholderText: l10n.smartPromptStarfishKeepPlaceholder,
        );
      case 'starfish_more':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptStarfishMoreQuestion,
          exampleAction: l10n.smartPromptStarfishMoreExample,
          placeholderText: l10n.smartPromptStarfishMorePlaceholder,
        );
      case 'starfish_less':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptStarfishLessQuestion,
          exampleAction: l10n.smartPromptStarfishLessExample,
          placeholderText: l10n.smartPromptStarfishLessPlaceholder,
        );
      case 'starfish_stop':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptStarfishStopQuestion,
          exampleAction: l10n.smartPromptStarfishStopExample,
          placeholderText: l10n.smartPromptStarfishStopPlaceholder,
        );
      case 'starfish_start':
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptStarfishStartQuestion,
          exampleAction: l10n.smartPromptStarfishStartExample,
          placeholderText: l10n.smartPromptStarfishStartPlaceholder,
        );

      default:
        return SmartActionPrompt(
          guidingQuestion: l10n.smartPromptGenericQuestion,
          exampleAction: l10n.smartPromptGenericExample,
          placeholderText: l10n.smartPromptGenericPlaceholder,
        );
    }
  }

  /// Ottiene la configurazione di output/export per un template
  static ExportConfig getExportConfig(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.madSadGlad:
        return const ExportConfig(
          includeTeamHealthSection: true,
          includeEmotionalSummary: true,
          groupActionsByEmotion: true,
          suggestedFollowUp: 'team_health_check',
        );
      case RetroTemplate.fourLs:
        return const ExportConfig(
          includeLessonsLearnedSection: true,
          includeKnowledgeSharingActions: true,
          groupActionsByLearning: true,
          suggestedFollowUp: 'knowledge_base_update',
        );
      case RetroTemplate.sailboat:
        return const ExportConfig(
          includeRiskRegister: true,
          includeEnablersList: true,
          includeGoalAlignment: true,
          groupActionsByRiskLevel: true,
          suggestedFollowUp: 'risk_review',
        );
      case RetroTemplate.starfish:
        return const ExportConfig(
          includeCalibrationMatrix: true,
          includeGradationSummary: true,
          groupActionsByIntensity: true,
          suggestedFollowUp: 'calibration_check',
        );
      case RetroTemplate.daki:
        return const ExportConfig(
          includePrioritizationMatrix: true,
          includeDecisionLog: true,
          groupActionsByDecision: true,
          suggestedFollowUp: 'decision_review',
        );
      case RetroTemplate.startStopContinue:
      default:
        return const ExportConfig(
          includeActionSummary: true,
          groupActionsByCategory: true,
          suggestedFollowUp: 'action_review',
        );
    }
  }

  /// Ottiene il focus principale della metodologia
  static MethodologyFocus getMethodologyFocus(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.startStopContinue:
        return MethodologyFocus.actionOriented;
      case RetroTemplate.madSadGlad:
        return MethodologyFocus.emotionFocused;
      case RetroTemplate.fourLs:
        return MethodologyFocus.learningReflective;
      case RetroTemplate.sailboat:
        return MethodologyFocus.riskAndGoal;
      case RetroTemplate.starfish:
        return MethodologyFocus.calibration;
      case RetroTemplate.daki:
        return MethodologyFocus.decisional;
    }
  }

  /// Ottiene l'icona del focus metodologico
  static IconData getMethodologyFocusIcon(MethodologyFocus focus) {
    switch (focus) {
      case MethodologyFocus.actionOriented:
        return Icons.play_arrow;
      case MethodologyFocus.emotionFocused:
        return Icons.favorite;
      case MethodologyFocus.learningReflective:
        return Icons.school;
      case MethodologyFocus.riskAndGoal:
        return Icons.flag;
      case MethodologyFocus.calibration:
        return Icons.tune;
      case MethodologyFocus.decisional:
        return Icons.gavel;
    }
  }

  /// Ottiene la descrizione del focus metodologico
  static String getMethodologyFocusDescription(AppLocalizations l10n, MethodologyFocus focus) {
    switch (focus) {
      case MethodologyFocus.actionOriented:
        return l10n.methodologyFocusAction;
      case MethodologyFocus.emotionFocused:
        return l10n.methodologyFocusEmotion;
      case MethodologyFocus.learningReflective:
        return l10n.methodologyFocusLearning;
      case MethodologyFocus.riskAndGoal:
        return l10n.methodologyFocusRisk;
      case MethodologyFocus.calibration:
        return l10n.methodologyFocusCalibration;
      case MethodologyFocus.decisional:
        return l10n.methodologyFocusDecision;
    }
  }

  /// Gets the suggested collection order for actions based on methodology
  /// Returns column IDs in priority order (first = most important to address)
  static List<String> getActionCollectionOrder(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.startStopContinue:
        // Stop first (remove blockers), then Start (add new), then Continue (maintain)
        return ['stop', 'start', 'continue'];
      case RetroTemplate.madSadGlad:
        // Mad first (address frustrations), then Sad (resolve disappointments), then Glad (celebrate)
        return ['mad', 'sad', 'glad'];
      case RetroTemplate.fourLs:
        // Lacked first (fill gaps), then Longed (plan for future), then Liked (maintain), then Learned (share)
        return ['lacked', 'longed', 'liked', 'learned'];
      case RetroTemplate.sailboat:
        // Risks first (mitigate), then Anchors (remove), then Wind (leverage), then Goals (align)
        return ['rock', 'anchor', 'wind', 'goal'];
      case RetroTemplate.starfish:
        // Stop first, then Less, then Keep, then More, then Start
        return ['stop', 'less', 'keep', 'more', 'start'];
      case RetroTemplate.daki:
        // Drop first (free capacity), then Add (implement new), then Improve, then Keep
        return ['drop', 'add', 'improve', 'keep'];
    }
  }

  /// Gets the minimum required columns that should have at least one action
  /// Returns column IDs that are mandatory for a complete retrospective
  static List<String> getRequiredActionColumns(RetroTemplate template) {
    switch (template) {
      case RetroTemplate.startStopContinue:
        return ['stop', 'start']; // Continue is optional
      case RetroTemplate.madSadGlad:
        return ['mad', 'sad']; // Must address negatives; glad is optional
      case RetroTemplate.fourLs:
        return ['lacked', 'longed']; // Must fill gaps and plan future
      case RetroTemplate.sailboat:
        return ['rock', 'anchor']; // Must address risks and blockers
      case RetroTemplate.starfish:
        return ['stop', 'start']; // Must stop something and start something
      case RetroTemplate.daki:
        return ['drop', 'add']; // Must drop and add something
    }
  }

  /// Gets a guidance message for why this order is recommended
  static String getCollectionOrderRationale(AppLocalizations l10n, RetroTemplate template) {
    switch (template) {
      case RetroTemplate.startStopContinue:
        return l10n.collectionRationaleSSC;
      case RetroTemplate.madSadGlad:
        return l10n.collectionRationaleMSG;
      case RetroTemplate.fourLs:
        return l10n.collectionRationale4Ls;
      case RetroTemplate.sailboat:
        return l10n.collectionRationaleSailboat;
      case RetroTemplate.starfish:
        return l10n.collectionRationaleStarfish;
      case RetroTemplate.daki:
        return l10n.collectionRationaleDAKI;
    }
  }

  /// Gets a suggestion message when a required column is missing actions
  static String getMissingColumnSuggestion(AppLocalizations l10n, RetroTemplate template, String columnId) {
    // Helper to get prefix-less ID if needed, but template usually matches
    final key = '${template.name}_$columnId';
    switch (key) {
      // SSC
      case 'startStopContinue_stop':
        return l10n.missingSuggestionSSCStop;
      case 'startStopContinue_start':
        return l10n.missingSuggestionSSCStart;
      // MSG
      case 'madSadGlad_mad':
        return l10n.missingSuggestionMSGMad;
      case 'madSadGlad_sad':
        return l10n.missingSuggestionMSGSad;
      // 4Ls
      case 'fourLs_lacked':
        return l10n.missingSuggestion4LsLacked;
      case 'fourLs_longed':
        return l10n.missingSuggestion4LsLonged;
      // Sailboat
      case 'sailboat_rock':
        return l10n.missingSuggestionSailboatRock;
      case 'sailboat_anchor':
        return l10n.missingSuggestionSailboatAnchor;
      // Starfish
      case 'starfish_stop':
        return l10n.missingSuggestionStarfishStop;
      case 'starfish_start':
        return l10n.missingSuggestionStarfishStart;
      // DAKI
      case 'daki_drop':
        return l10n.missingSuggestionDAKIDrop;
      case 'daki_add':
        return l10n.missingSuggestionDAKIAdd;
      default:
        return l10n.missingSuggestionGeneric;
    }
  }

  /// Gets the localized title for a standard column
  /// If the column is custom or not found, it returns the fallbackTitle
  static String getColumnTitle(AppLocalizations l10n, RetroTemplate template, String columnId, String fallbackTitle) {
    final key = '${template.name}_$columnId';
    switch (key) {
      // SSC
      case 'startStopContinue_start': return l10n.retroPhaseStart;
      case 'startStopContinue_stop': return l10n.retroPhaseStop;
      case 'startStopContinue_continue': return l10n.retroPhaseContinue;
      
      // MSG
      case 'madSadGlad_mad': return l10n.retroColumnMad;
      case 'madSadGlad_sad': return l10n.retroColumnSad;
      case 'madSadGlad_glad': return l10n.retroColumnGlad;
      
      // 4Ls
      case 'fourLs_liked': return l10n.retroColumnLiked;
      case 'fourLs_learned': return l10n.retroColumnLearned;
      case 'fourLs_lacked': return l10n.retroColumnLacked;
      case 'fourLs_longed': return l10n.retroColumnLonged;
      
      // Sailboat
      case 'sailboat_wind': return l10n.retroColumnWind;
      case 'sailboat_anchor': return l10n.retroColumnAnchor;
      case 'sailboat_rock': return l10n.retroColumnRock;
      case 'sailboat_goal': return l10n.retroColumnGoal;
      
      // Starfish
      case 'starfish_stop': return l10n.retroPhaseStop; // Reuse stop
      case 'starfish_start': return l10n.retroPhaseStart; // Reuse start
      case 'starfish_keep': return l10n.retroColumnKeep;
      case 'starfish_more': return l10n.retroColumnMore;
      case 'starfish_less': return l10n.retroColumnLess;
      
      // DAKI
      case 'daki_drop': return l10n.retroColumnDrop;
      case 'daki_add': return l10n.retroColumnAdd;
      case 'daki_keep': return l10n.retroColumnKeep; // Reuse keep
      case 'daki_improve': return l10n.retroColumnImprove;
      
      default: return fallbackTitle;
    }
  }
}

/// Prompt per aiutare a scrivere azioni SMART
class SmartActionPrompt {
  final String guidingQuestion;
  final String exampleAction;
  final String placeholderText;

  const SmartActionPrompt({
    required this.guidingQuestion,
    required this.exampleAction,
    required this.placeholderText,
  });
}

/// Configurazione export per metodologia
class ExportConfig {
  final bool includeTeamHealthSection;
  final bool includeEmotionalSummary;
  final bool includeLessonsLearnedSection;
  final bool includeKnowledgeSharingActions;
  final bool includeRiskRegister;
  final bool includeEnablersList;
  final bool includeGoalAlignment;
  final bool includeCalibrationMatrix;
  final bool includeGradationSummary;
  final bool includePrioritizationMatrix;
  final bool includeDecisionLog;
  final bool includeActionSummary;
  final bool groupActionsByEmotion;
  final bool groupActionsByLearning;
  final bool groupActionsByRiskLevel;
  final bool groupActionsByIntensity;
  final bool groupActionsByDecision;
  final bool groupActionsByCategory;
  final String suggestedFollowUp;

  const ExportConfig({
    this.includeTeamHealthSection = false,
    this.includeEmotionalSummary = false,
    this.includeLessonsLearnedSection = false,
    this.includeKnowledgeSharingActions = false,
    this.includeRiskRegister = false,
    this.includeEnablersList = false,
    this.includeGoalAlignment = false,
    this.includeCalibrationMatrix = false,
    this.includeGradationSummary = false,
    this.includePrioritizationMatrix = false,
    this.includeDecisionLog = false,
    this.includeActionSummary = false,
    this.groupActionsByEmotion = false,
    this.groupActionsByLearning = false,
    this.groupActionsByRiskLevel = false,
    this.groupActionsByIntensity = false,
    this.groupActionsByDecision = false,
    this.groupActionsByCategory = false,
    this.suggestedFollowUp = '',
  });
}

/// Focus principale della metodologia
enum MethodologyFocus {
  actionOriented,    // Start/Stop/Continue
  emotionFocused,    // Mad/Sad/Glad
  learningReflective, // 4Ls
  riskAndGoal,       // Sailboat
  calibration,       // Starfish
  decisional,        // DAKI
}
