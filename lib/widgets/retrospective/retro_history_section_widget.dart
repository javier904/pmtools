import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_trend_chart_widget.dart';

/// Displays completed retrospectives grouped by sprint name.
class RetroHistorySectionWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;
  final String currentUserEmail;
  final Function(RetrospectiveModel) onTapRetro;
  final Function(RetrospectiveModel)? onDeleteRetro;

  const RetroHistorySectionWidget({
    super.key,
    required this.retrospectives,
    required this.currentUserEmail,
    required this.onTapRetro,
    this.onDeleteRetro,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Filter completed retrospectives
    final completedRetros = retrospectives
        .where((r) => r.status == RetroStatus.completed || r.isCompleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    if (completedRetros.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            Icon(Icons.history, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              l10n.retroNoCompletedRetros,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // Group by sprintName
    final Map<String, List<RetrospectiveModel>> grouped = {};
    for (final retro in completedRetros) {
      final key = retro.sprintName.isNotEmpty ? retro.sprintName : l10n.retroStandalone;
      grouped.putIfAbsent(key, () => []).add(retro);
    }

    // Sort groups by most recent retro
    final sortedGroups = grouped.entries.toList()
      ..sort((a, b) => b.value.first.createdAt.compareTo(a.value.first.createdAt));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Trend chart at the top
          RetroTrendChartWidget(retrospectives: retrospectives),
          const SizedBox(height: 16),
          // Grouped retro list
          ...sortedGroups.map((entry) {
            return _buildSprintGroup(context, entry.key, entry.value, l10n);
          }),
        ],
      ),
    );
  }

  Widget _buildSprintGroup(
    BuildContext context,
    String sprintName,
    List<RetrospectiveModel> retros,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        initiallyExpanded: true,
        leading: Icon(Icons.directions_run, color: colorScheme.primary),
        title: Row(
          children: [
            Text(
              sprintName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${retros.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        children: retros.map((retro) => _buildRetroCard(context, retro, l10n)).toList(),
      ),
    );
  }

  Widget _buildRetroCard(
    BuildContext context,
    RetrospectiveModel retro,
    AppLocalizations l10n,
  ) {
    final completedActions = retro.actionItems.where((a) => a.isCompleted).length;
    final totalActions = retro.actionItems.length;

    return Tooltip(
      message: l10n.tooltipHistoryRetroCard,
      child: InkWell(
        onTap: () => onTapRetro(retro),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              // Template icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  retro.template.icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),

              // Retro info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      retro.template.getLocalizedDisplayName(l10n),
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${l10n.retroCompletedOn}: ${_formatDate(retro.createdAt)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              // Sentiment indicator
              if (retro.averageSentiment != null && retro.averageSentiment! > 0)
                Tooltip(
                  message: l10n.tooltipHistorySentiment,
                  child: _buildSentimentIndicator(retro.averageSentiment!),
                ),

              const SizedBox(width: 12),

              // Action items summary
              if (totalActions > 0)
                Tooltip(
                  message: l10n.tooltipHistoryActionCount,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: completedActions == totalActions
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$completedActions/$totalActions',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: completedActions == totalActions ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ),

              const SizedBox(width: 8),

              // Delete button
              if (onDeleteRetro != null)
                Tooltip(
                  message: l10n.actionDelete,
                  child: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red[400], size: 20),
                    onPressed: () => onDeleteRetro!(retro),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),

              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSentimentIndicator(double sentiment) {
    final color = sentiment > 3.5
        ? Colors.green
        : sentiment > 2.5
            ? Colors.amber
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sentiment_satisfied, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            sentiment.toStringAsFixed(1),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
