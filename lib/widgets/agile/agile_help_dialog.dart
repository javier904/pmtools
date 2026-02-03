import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class AgileHelpDialog extends StatefulWidget {
  const AgileHelpDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const AgileHelpDialog(),
    );
  }

  @override
  State<AgileHelpDialog> createState() => _AgileHelpDialogState();
}

class _AgileHelpDialogState extends State<AgileHelpDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final steps = [
      _HelpStep(
        title: l10n.agileHelpStep1Title,
        description: l10n.agileHelpStep1Desc,
        icon: Icons.list_alt,
        color: Colors.blue,
      ),
      _HelpStep(
        title: l10n.agileHelpStep2Title,
        description: l10n.agileHelpStep2Desc,
        icon: Icons.date_range,
        color: Colors.purple,
      ),
      _HelpStep(
        title: l10n.agileHelpStep3Title,
        description: l10n.agileHelpStep3Desc,
        icon: Icons.view_kanban,
        color: Colors.orange,
      ),
      _HelpStep(
        title: l10n.agileHelpStep4Title,
        description: l10n.agileHelpStep4Desc,
        icon: Icons.sync,
        color: Colors.green,
      ),
    ];

    return Dialog(
      child: Container(
        width: 500,
        height: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: theme.primaryColor),
                const SizedBox(width: 12),
                Text(
                  l10n.agileHelpTitle,
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (idx) => setState(() => _currentPage = idx),
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: step.color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(step.icon, size: 64, color: step.color),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        step.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        step.description,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(steps.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? theme.primaryColor
                        : theme.disabledColor,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _currentPage > 0
                      ? () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          )
                      : null,
                  child: Text(l10n.actionBack),
                 ),

                 FilledButton(
                    onPressed: () {
                      if (_currentPage < steps.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },

                    child: Text(_currentPage < steps.length - 1 ? l10n.actionNext : l10n.actionFinish),
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  _HelpStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
