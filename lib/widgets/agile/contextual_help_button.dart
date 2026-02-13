import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/framework_features.dart';

/// Bottone Help contestuale per Agile Projects
/// 
/// Mostra guida specifica per:
/// - Tab corrente (Backlog, Sprint, Kanban, Team, Metrics, Retro)
/// - Framework del progetto (Scrum, Kanban, Hybrid)
class ContextualHelpButton extends StatelessWidget {
  final AgileTab currentTab;
  final AgileFramework framework;

  const ContextualHelpButton({
    super.key,
    required this.currentTab,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.help_outline),
      tooltip: AppLocalizations.of(context)!.contextualHelpButton,
      onPressed: () => _showHelpDialog(context),
    );
  }

  void _showHelpDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final help = ContextualHelp.getTabHelp(currentTab, framework, l10n);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(help.icon, color: help.color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                help.title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Framework badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: framework == AgileFramework.scrum
                        ? Colors.blue.withOpacity(0.1)
                        : framework == AgileFramework.kanban
                            ? Colors.green.withOpacity(0.1)
                            : Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    framework.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      color: framework == AgileFramework.scrum
                          ? Colors.blue
                          : framework == AgileFramework.kanban
                              ? Colors.green
                              : Colors.purple,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Help content
                Text(
                  help.description,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
                
                if (help.tips.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    l10n.contextualHelpTips,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  ...help.tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 14)),
                        Expanded(
                          child: Text(tip, style: const TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  )),
                ],

                if (help.sections != null && help.sections!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  ...help.sections!.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.value,
                          style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4),
                        ),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }
}

/// Contenuto help contestuale
class ContextualHelpContent {
  final String title;
  final String description;
  final List<String> tips;
  final Map<String, String>? sections; // New: Title -> Description
  final IconData icon;
  final Color color;

  const ContextualHelpContent({
    required this.title,
    required this.description,
    required this.tips,
    this.sections,
    required this.icon,
    required this.color,
  });
}

/// Provider di contenuti help contestuali
class ContextualHelp {
  static ContextualHelpContent getTabHelp(
    AgileTab tab,
    AgileFramework framework,
    AppLocalizations l10n,
  ) {
    switch (tab) {
      case AgileTab.backlog:
        return _getBacklogHelp(framework, l10n);
      case AgileTab.sprint:
        return _getSprintHelp(framework, l10n);
      case AgileTab.kanban:
        return _getKanbanHelp(framework, l10n);
      case AgileTab.team:
        return _getTeamHelp(framework, l10n);
      case AgileTab.metrics:
        return _getMetricsHelp(framework, l10n);
      case AgileTab.retro:
        return _getRetroHelp(framework, l10n);
    }
  }

  static ContextualHelpContent _getBacklogHelp(AgileFramework framework, AppLocalizations l10n) {
    return ContextualHelpContent(
      title: l10n.contextualHelpBacklogTitle,
      description: l10n.contextualHelpBacklogDesc,
      tips: [
        l10n.contextualHelpBacklogTip1,
        l10n.contextualHelpBacklogTip2,
        l10n.contextualHelpBacklogTip3,
      ],
      icon: Icons.list_alt,
      color: Colors.blue,
    );
  }

  static ContextualHelpContent _getSprintHelp(AgileFramework framework, AppLocalizations l10n) {
    return ContextualHelpContent(
      title: l10n.contextualHelpSprintTitle,
      description: l10n.contextualHelpSprintDesc,
      tips: [
        l10n.contextualHelpSprintTip1,
        l10n.contextualHelpSprintTip2,
        l10n.contextualHelpSprintTip3,
      ],
      icon: Icons.timer,
      color: Colors.indigo,
    );
  }

  static ContextualHelpContent _getKanbanHelp(AgileFramework framework, AppLocalizations l10n) {
    final isKanbanOrHybrid = framework != AgileFramework.scrum;
    return ContextualHelpContent(
      title: l10n.contextualHelpKanbanTitle,
      description: isKanbanOrHybrid 
          ? l10n.contextualHelpKanbanDescFlow
          : l10n.contextualHelpKanbanDescScrum,
      tips: isKanbanOrHybrid
          ? [
              l10n.contextualHelpKanbanTip1,
              l10n.contextualHelpKanbanTip2,
              l10n.contextualHelpKanbanTip3,
            ]
          : [
              l10n.contextualHelpKanbanTipScrum1,
              l10n.contextualHelpKanbanTipScrum2,
            ],
      sections: isKanbanOrHybrid ? {
        l10n.kanbanPolicyHelpTitle: l10n.kanbanPolicyHelpIntro,
        l10n.kanbanPolicyRule1Title: l10n.kanbanPolicyRule1Desc,
        l10n.kanbanPolicyRule2Title: l10n.kanbanPolicyRule2Desc,
        l10n.kanbanPolicyRule3Title: l10n.kanbanPolicyRule3Desc,
        l10n.kanbanPolicyRule4Title: l10n.kanbanPolicyRule4Desc,
        l10n.kanbanPolicyHelpConfigurable: l10n.kanbanPolicyHelpConfigurable,
      } : null,
      icon: Icons.view_kanban,
      color: Colors.teal,
    );
  }

  static ContextualHelpContent _getTeamHelp(AgileFramework framework, AppLocalizations l10n) {
    return ContextualHelpContent(
      title: l10n.contextualHelpTeamTitle,
      description: l10n.contextualHelpTeamDesc,
      tips: [
        l10n.contextualHelpTeamTip1,
        l10n.contextualHelpTeamTip2,
      ],
      icon: Icons.people,
      color: Colors.orange,
    );
  }

  static ContextualHelpContent _getMetricsHelp(AgileFramework framework, AppLocalizations l10n) {
    final String description;
    final List<String> tips;
    
    if (framework == AgileFramework.scrum) {
      description = l10n.contextualHelpMetricsDescScrum;
      tips = [
        l10n.contextualHelpMetricsTipScrum1,
        l10n.contextualHelpMetricsTipScrum2,
      ];
    } else if (framework == AgileFramework.kanban) {
      description = l10n.contextualHelpMetricsDescKanban;
      tips = [
        l10n.contextualHelpMetricsTipKanban1,
        l10n.contextualHelpMetricsTipKanban2,
        l10n.contextualHelpMetricsTipKanban3,
      ];
    } else {
      description = l10n.contextualHelpMetricsDescHybrid;
      tips = [
        l10n.contextualHelpMetricsTipHybrid1,
        l10n.contextualHelpMetricsTipHybrid2,
      ];
    }
    
    return ContextualHelpContent(
      title: l10n.contextualHelpMetricsTitle,
      description: description,
      tips: tips,
      icon: Icons.analytics,
      color: Colors.purple,
    );
  }

  static ContextualHelpContent _getRetroHelp(AgileFramework framework, AppLocalizations l10n) {
    return ContextualHelpContent(
      title: l10n.contextualHelpRetroTitle,
      description: framework == AgileFramework.kanban
          ? l10n.contextualHelpRetroDescKanban
          : l10n.contextualHelpRetroDescScrum,
      sections: {
        l10n.contextualHelpRetroTabActiveTitle: l10n.contextualHelpRetroTabActive,
        l10n.contextualHelpRetroModeInteractiveTitle: l10n.contextualHelpRetroModeInteractive,
        l10n.contextualHelpRetroModeQuickTitle: l10n.contextualHelpRetroModeQuick,
        l10n.contextualHelpRetroTabHistoryTitle: l10n.contextualHelpRetroTabHistory,
        l10n.contextualHelpRetroTabActionItemsTitle: l10n.contextualHelpRetroTabActionItems,
        l10n.contextualHelpRetroTabLessonsLearnedTitle: l10n.contextualHelpRetroTabLessonsLearned,
        l10n.contextualHelpRetroIntegrationTitle: l10n.contextualHelpRetroIntegration,
      },
      tips: [
        l10n.contextualHelpRetroTip1,
        l10n.contextualHelpRetroTip2,
        l10n.contextualHelpRetroTip3,
      ],
      icon: Icons.rate_review,
      color: Colors.pink,
    );
  }
}
