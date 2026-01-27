import 'package:flutter/material.dart';
import '../../models/methodology_guide.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per visualizzare la guida completa di una metodologia
class MethodologyGuideDialog extends StatefulWidget {
  final AgileFramework? initialFramework;

  const MethodologyGuideDialog({
    super.key,
    this.initialFramework,
  });

  /// Mostra il dialog
  static Future<void> show(BuildContext context, {AgileFramework? framework}) {
    return showDialog(
      context: context,
      builder: (context) => MethodologyGuideDialog(initialFramework: framework),
    );
  }

  @override
  State<MethodologyGuideDialog> createState() => _MethodologyGuideDialogState();
}

class _MethodologyGuideDialogState extends State<MethodologyGuideDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final initialIndex = widget.initialFramework != null
        ? AgileFramework.values.indexOf(widget.initialFramework!)
        : 0;
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, color: Colors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final l10n = AppLocalizations.of(context)!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.agileMethodologyGuideTitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.agileMethodologyGuideSubtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: context.textMutedColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Tab bar
            TabBar(
              controller: _tabController,
              tabs: MethodologyGuide.allGuides.map((guide) => Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(guide.icon, size: 18, color: guide.color),
                    const SizedBox(width: 8),
                    Text(guide.title),
                  ],
                ),
              )).toList(),
              labelColor: Colors.teal,
              indicatorColor: Colors.teal,
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: MethodologyGuide.allGuides.map((guide) =>
                  _MethodologyGuideContent(guide: guide),
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Contenuto della guida per una singola metodologia
class _MethodologyGuideContent extends StatelessWidget {
  final MethodologyGuide guide;

  const _MethodologyGuideContent({required this.guide});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Overview
        Card(
          color: guide.color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(guide.icon, color: guide.color, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      guide.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: guide.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  guide.overview,
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Process Flow Diagram
        _ProcessFlowDiagram(guide: guide),
        const SizedBox(height: 24),

        // Sections
        ...guide.sections.map((section) => _buildSection(section)),

        // Best Practices
        _buildListCard(
          AppLocalizations.of(context)!.agileBestPractices,
          guide.bestPractices,
          Icons.check_circle,
          Colors.green,
        ),
        const SizedBox(height: 16),

        // Anti-patterns
        _buildListCard(
          AppLocalizations.of(context)!.agileAntiPatterns,
          guide.antiPatterns,
          Icons.cancel,
          Colors.red,
        ),
        const SizedBox(height: 16),

        // FAQ
        _buildFAQSection(guide.faqs),
      ],
    );
  }

  Widget _buildSection(MethodologySection section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (section.icon != null) ...[
                    Icon(section.icon, color: guide.color, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: guide.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) => Text(
                  section.content,
                  style: TextStyle(
                    height: 1.5,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
              if (section.bulletPoints != null) ...[
                const SizedBox(height: 12),
                ...section.bulletPoints!.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_right, color: guide.color, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Builder(
                          builder: (context) => Text(
                            point,
                            style: TextStyle(
                              height: 1.4,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(String title, List<String> items, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: color.withOpacity(0.7), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Builder(
                      builder: (context) => Text(
                        item,
                        style: TextStyle(
                          height: 1.4,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(List<FAQ> faqs) {
    return Builder(
      builder: (context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.help_outline, color: guide.color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.agileFAQ,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: guide.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...faqs.map((faq) => _buildFAQItem(faq)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(FAQ faq) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.question_answer, color: guide.color.withOpacity(0.7), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  faq.question,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Builder(
              builder: (context) => Text(
                faq.answer,
                style: TextStyle(
                  height: 1.4,
                  color: context.textSecondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget compatto per mostrare un riassunto della metodologia
class MethodologyQuickInfo extends StatelessWidget {
  final AgileFramework framework;
  final VoidCallback? onLearnMore;

  const MethodologyQuickInfo({
    super.key,
    required this.framework,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final guide = MethodologyGuide.forFramework(framework);

    return Card(
      color: guide.color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(guide.icon, color: guide.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  guide.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: guide.color,
                  ),
                ),
                const Spacer(),
                if (onLearnMore != null)
                  TextButton.icon(
                    onPressed: onLearnMore,
                    icon: const Icon(Icons.menu_book, size: 16),
                    label: Text(AppLocalizations.of(context)!.agileGuide),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) => Text(
                _getShortDescription(context, framework),
                style: TextStyle(
                  fontSize: 13,
                  color: context.textSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getShortDescription(BuildContext context, AgileFramework framework) {
    final l10n = AppLocalizations.of(context)!;
    switch (framework) {
      case AgileFramework.scrum:
        return l10n.agileScrumShortDesc;
      case AgileFramework.kanban:
        return l10n.agileKanbanShortDesc;
      case AgileFramework.hybrid:
        return l10n.agileScrumbanShortDesc;
    }
  }
}

/// Pulsante per accedere alla documentazione
class MethodologyGuideButton extends StatelessWidget {
  final AgileFramework? framework;
  final bool compact;

  const MethodologyGuideButton({
    super.key,
    this.framework,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return IconButton(
        icon: const Icon(Icons.help_outline),
        tooltip: AppLocalizations.of(context)!.agileMethodologyGuide,
        onPressed: () => MethodologyGuideDialog.show(context, framework: framework),
      );
    }

    return TextButton.icon(
      onPressed: () => MethodologyGuideDialog.show(context, framework: framework),
      icon: const Icon(Icons.menu_book),
      label: Text(AppLocalizations.of(context)!.agileMethodologyGuide),
    );
  }
}

/// Diagramma del flusso del processo
class _ProcessFlowDiagram extends StatelessWidget {
  final MethodologyGuide guide;

  const _ProcessFlowDiagram({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_tree, color: guide.color, size: 20),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.agileProcessFlow,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: guide.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Roles Section
            _buildRolesSection(context),
            const SizedBox(height: 20),

            // Process Flow
            _buildProcessFlow(context),
            const SizedBox(height: 20),

            // Artifacts Section
            _buildArtifactsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRolesSection(BuildContext context) {
    final roles = _getRolesForFramework(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) => Text(
            AppLocalizations.of(context)!.agileRoles,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textMutedColor,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: roles.map((role) => _RoleChip(
            icon: role.icon,
            label: role.label,
            color: role.color,
            description: role.description,
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildProcessFlow(BuildContext context) {
    final steps = _getProcessSteps();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) => Text(
            AppLocalizations.of(context)!.agileProcessFlow, // Using same key "PROCESS FLOW"
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textMutedColor,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < steps.length; i++) ...[
                _ProcessStep(
                  step: steps[i],
                  color: guide.color,
                ),
                if (i < steps.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.arrow_forward,
                      color: guide.color.withOpacity(0.5),
                      size: 20,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArtifactsSection(BuildContext context) {
    final artifacts = _getArtifacts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) => Text(
            AppLocalizations.of(context)!.agileArtifacts,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textMutedColor,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: artifacts.map((artifact) => _ArtifactChip(
            icon: artifact.icon,
            label: artifact.label,
            color: guide.color,
          )).toList(),
        ),
      ],
    );
  }

  List<_RoleData> _getRolesForFramework(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (guide.framework) {
      case AgileFramework.scrum:
        return [
          _RoleData(
            icon: Icons.account_circle,
            label: 'Product Owner',
            color: const Color(0xFF7B1FA2),
            description: l10n.agileRolePODesc,
          ),
          _RoleData(
            icon: Icons.supervised_user_circle,
            label: 'Scrum Master',
            color: const Color(0xFF1976D2),
            description: l10n.agileRoleSMDesc,
          ),
          _RoleData(
            icon: Icons.groups,
            label: 'Development Team',
            color: const Color(0xFF388E3C),
            description: l10n.agileRoleDevTeamDesc,
          ),
          _RoleData(
            icon: Icons.business,
            label: 'Stakeholders',
            color: const Color(0xFF5D4037),
            description: l10n.agileRoleStakeholdersDesc,
          ),
        ];
      case AgileFramework.kanban:
        return [
          _RoleData(
            icon: Icons.account_circle,
            label: 'Service Request Manager',
            color: const Color(0xFF7B1FA2),
            description: l10n.agileRoleSRMDesc,
          ),
          _RoleData(
            icon: Icons.engineering,
            label: 'Service Delivery Manager',
            color: const Color(0xFF1976D2),
            description: l10n.agileRoleSDMDesc,
          ),
          _RoleData(
            icon: Icons.groups,
            label: 'Team',
            color: const Color(0xFF388E3C),
            description: l10n.agileRoleTeamDesc,
          ),
        ];
      case AgileFramework.hybrid:
        return [
          _RoleData(
            icon: Icons.account_circle,
            label: 'Product Owner',
            color: const Color(0xFF7B1FA2),
            description: l10n.agileRolePODesc,
          ),
          _RoleData(
            icon: Icons.supervised_user_circle,
            label: 'Flow Master',
            color: const Color(0xFF1976D2),
            description: l10n.agileRoleFlowMasterDesc,
          ),
          _RoleData(
            icon: Icons.groups,
            label: 'Team',
            color: const Color(0xFF388E3C),
            description: l10n.agileRoleTeamHybridDesc,
          ),
        ];
    }
  }

  List<_ProcessStepData> _getProcessSteps() {
    switch (guide.framework) {
      case AgileFramework.scrum:
        return [
          _ProcessStepData('Backlog\nGrooming', Icons.list_alt),
          _ProcessStepData('Sprint\nPlanning', Icons.event),
          _ProcessStepData('Daily\nStandup', Icons.wb_sunny),
          _ProcessStepData('Sprint\nExecution', Icons.code),
          _ProcessStepData('Sprint\nReview', Icons.rate_review),
          _ProcessStepData('Retro-\nspettiva', Icons.psychology),
        ];
      case AgileFramework.kanban:
        return [
          _ProcessStepData('Richiesta\nIn Arrivo', Icons.inbox),
          _ProcessStepData('To Do\n(WIP)', Icons.playlist_add),
          _ProcessStepData('In Progress\n(WIP)', Icons.pending),
          _ProcessStepData('Review\n(WIP)', Icons.rate_review),
          _ProcessStepData('Done\n', Icons.check_circle),
          _ProcessStepData('Metriche\n& Improve', Icons.analytics),
        ];
      case AgileFramework.hybrid:
        return [
          _ProcessStepData('Backlog\nPrioritization', Icons.list_alt),
          _ProcessStepData('Sprint\nCommitment', Icons.event),
          _ProcessStepData('Kanban\nBoard', Icons.view_column),
          _ProcessStepData('Daily\nSync', Icons.wb_sunny),
          _ProcessStepData('Review &\nRetro', Icons.rate_review),
        ];
    }
  }

  List<_ArtifactData> _getArtifacts() {
    switch (guide.framework) {
      case AgileFramework.scrum:
        return [
          _ArtifactData('Product Backlog', Icons.list_alt),
          _ArtifactData('Sprint Backlog', Icons.assignment),
          _ArtifactData('Incremento', Icons.add_box),
          _ArtifactData('Burndown Chart', Icons.trending_down),
          _ArtifactData('Velocity', Icons.speed),
        ];
      case AgileFramework.kanban:
        return [
          _ArtifactData('Kanban Board', Icons.view_column),
          _ArtifactData('WIP Limits', Icons.block),
          _ArtifactData('CFD', Icons.area_chart),
          _ArtifactData('Lead Time', Icons.timer),
          _ArtifactData('Cycle Time', Icons.loop),
        ];
      case AgileFramework.hybrid:
        return [
          _ArtifactData('Product Backlog', Icons.list_alt),
          _ArtifactData('Kanban Board', Icons.view_column),
          _ArtifactData('WIP Limits', Icons.block),
          _ArtifactData('Velocity', Icons.speed),
          _ArtifactData('Flow Metrics', Icons.analytics),
        ];
    }
  }
}

class _RoleData {
  final IconData icon;
  final String label;
  final Color color;
  final String description;

  const _RoleData({
    required this.icon,
    required this.label,
    required this.color,
    required this.description,
  });
}

class _ProcessStepData {
  final String label;
  final IconData icon;

  const _ProcessStepData(this.label, this.icon);
}

class _ArtifactData {
  final String label;
  final IconData icon;

  const _ArtifactData(this.label, this.icon);
}

class _RoleChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String description;

  const _RoleChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: description,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final _ProcessStepData step;
  final Color color;

  const _ProcessStep({
    required this.step,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(step.icon, size: 20, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            step.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtifactChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ArtifactChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
