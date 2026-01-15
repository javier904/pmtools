import 'package:flutter/material.dart';
import '../../models/methodology_guide.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

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
                      builder: (context) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Guida alle Metodologie Agile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Scegli la metodologia più adatta al tuo progetto',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textMutedColor,
                            ),
                          ),
                        ],
                      ),
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

        // Sections
        ...guide.sections.map((section) => _buildSection(section)),

        // Best Practices
        _buildListCard(
          'Best Practices',
          guide.bestPractices,
          Icons.check_circle,
          Colors.green,
        ),
        const SizedBox(height: 16),

        // Anti-patterns
        _buildListCard(
          'Anti-Pattern da Evitare',
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
    return Card(
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
                  'Domande Frequenti',
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
                    label: const Text('Guida'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) => Text(
                _getShortDescription(framework),
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

  String _getShortDescription(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return 'Sprint a tempo fisso, Velocity, Burndown. Ideale per prodotti con requisiti che evolvono.';
      case AgileFramework.kanban:
        return 'Flusso continuo, WIP Limits, Lead Time. Ideale per supporto e richieste continue.';
      case AgileFramework.hybrid:
        return 'Mix di Sprint e flusso continuo. Ideale per team che vogliono flessibilità.';
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
        tooltip: 'Guida alla metodologia',
        onPressed: () => MethodologyGuideDialog.show(context, framework: framework),
      );
    }

    return TextButton.icon(
      onPressed: () => MethodologyGuideDialog.show(context, framework: framework),
      icon: const Icon(Icons.menu_book),
      label: const Text('Guida Metodologie'),
    );
  }
}
