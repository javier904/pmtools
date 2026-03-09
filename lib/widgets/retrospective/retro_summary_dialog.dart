import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import '../user_display_name_widget.dart';

/// Read-only dialog showing a summary of a completed retrospective.
class RetroSummaryDialog extends StatelessWidget {
  final RetrospectiveModel retro;

  const RetroSummaryDialog({super.key, required this.retro});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      child: SizedBox(
        width: screenWidth > 750 ? 700 : double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(context, l10n),
            const Divider(height: 1),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMetadata(context, l10n),
                    if (retro.averageSentiment != null && retro.averageSentiment! > 0) ...[
                      const SizedBox(height: 20),
                      _buildSentiment(context, l10n),
                    ],
                    const SizedBox(height: 20),
                    _buildCards(context, l10n),
                    if (retro.actionItems.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildActionItems(context, l10n),
                    ],
                  ],
                ),
              ),
            ),

            // Footer
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.actionClose),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(retro.template.icon, size: 28, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  retro.title.isNotEmpty ? retro.title : retro.template.getLocalizedDisplayName(l10n),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (retro.title.isNotEmpty && retro.title != retro.template.getLocalizedDisplayName(l10n))
                  Text(
                    retro.template.getLocalizedDisplayName(l10n),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadata(BuildContext context, AppLocalizations l10n) {
    return Wrap(
      spacing: 24,
      runSpacing: 8,
      children: [
        _metadataChip(
          Icons.calendar_today,
          '${l10n.retroSummaryCompleted}: ${_formatDate(retro.createdAt)}',
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text('${l10n.retroSummaryFacilitator}: ', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
            UserDisplayName(
              email: retro.createdBy,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        ),
        if (retro.sprintName.isNotEmpty)
          _metadataChip(
            Icons.directions_run,
            '${l10n.retroSummarySprint}: ${retro.sprintName}',
          ),
      ],
    );
  }

  Widget _metadataChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildSentiment(BuildContext context, AppLocalizations l10n) {
    final sentiment = retro.averageSentiment!;
    final color = sentiment >= 4.0
        ? Colors.green
        : sentiment >= 3.0
            ? Colors.orange
            : Colors.red;
            
    final icon = sentiment >= 4.0
        ? Icons.sentiment_very_satisfied
        : sentiment >= 3.0
            ? Icons.sentiment_neutral
            : Icons.sentiment_dissatisfied;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Text(
            l10n.retroSummarySentiment,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Text(
            sentiment.toStringAsFixed(1),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          Text(' / 5', style: TextStyle(color: Colors.grey[600])),
          const SizedBox(width: 12),
          // Star rating
          ...List.generate(5, (i) {
            return Icon(
              i < sentiment.round() ? Icons.star : Icons.star_border,
              size: 18,
              color: color,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCards(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.retroSummaryFeedback,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...retro.columns.map((column) {
          final columnItems = retro.items.where((i) => i.columnId == column.id).toList();

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: column.color.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: column.color.withValues(alpha: 0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Icon(column.icon, size: 18, color: column.color),
                      const SizedBox(width: 8),
                      Text(
                        column.getLocalizedTitle(l10n),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: column.color,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${columnItems.length}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: column.color,
                        ),
                      ),
                    ],
                  ),
                ),
                // Items
                if (columnItems.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      l10n.retroSummaryNoCards,
                      style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic),
                    ),
                  )
                else
                  ...columnItems.map((item) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(item.content, style: const TextStyle(fontSize: 13)),
                        ),
                        if (item.votes > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.thumb_up, size: 12, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${item.votes}',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  )),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionItems(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Action Items',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${retro.actionItems.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...retro.actionItems.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.description,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  // Status chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: item.status.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: item.status.color.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item.status.icon, size: 12, color: item.status.color),
                        const SizedBox(width: 4),
                        Text(
                          item.status.displayName,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: item.status.color),
                        ),
                      ],
                    ),
                  ),
                  // Priority
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(item.priority).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.priority.displayName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor(item.priority),
                      ),
                    ),
                  ),
                  // Assignee
                  if (item.assigneeEmail != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        UserDisplayName(
                          email: item.assigneeEmail!,
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  // Due date
                  if (item.dueDate != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(item.dueDate!),
                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Color _getPriorityColor(ActionPriority priority) {
    switch (priority) {
      case ActionPriority.critical:
        return Colors.purple;
      case ActionPriority.high:
        return Colors.red.shade700;
      case ActionPriority.medium:
        return Colors.orange.shade900;
      case ActionPriority.low:
        return Colors.green.shade700;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
