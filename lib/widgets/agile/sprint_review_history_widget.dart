import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/sprint_model.dart';
import '../../l10n/app_localizations.dart';

/// Widget per visualizzare la cronologia delle Sprint Review
///
/// Mostra tutte le Sprint Review in ordine cronologico (più recente in alto)
/// con card espandibili per vedere i dettagli.
class SprintReviewHistoryWidget extends StatelessWidget {
  final List<SprintModel> sprints;
  final Function(SprintModel)? onTap;
  final Function(SprintModel)? onEdit;

  const SprintReviewHistoryWidget({
    super.key,
    required this.sprints,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Filtra sprint con review completata e ordina per data (più recente prima)
    final sprintsWithReviews = sprints
        .where((s) => s.hasSprintReview)
        .toList()
      ..sort((a, b) => b.sprintReview!.date.compareTo(a.sprintReview!.date));

    if (sprintsWithReviews.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Icon(Icons.history, color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              l10n.agileSprintReviewHistory,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${sprintsWithReviews.length}',
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Lista delle review
        ...sprintsWithReviews.map((sprint) => _buildReviewCard(context, sprint, l10n)),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.rate_review_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              l10n.agileNoSprintReviews,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.agileNoSprintReviewsHint,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, SprintModel sprint, AppLocalizations l10n) {
    final review = sprint.sprintReview!;
    final dateFormat = DateFormat('dd MMM yyyy', 'it');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'S${sprint.number}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          title: Text(sprint.name),
          subtitle: Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                dateFormat.format(review.date),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Icon(Icons.person, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                review.conductedByName,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stats badges
              if (review.storyOutcomes.isNotEmpty) ...[
                _buildStatBadge(
                  '${review.approvedStories.length}',
                  Colors.green,
                  '✅',
                ),
                const SizedBox(width: 4),
                if (review.storiesNeedingRefinement.isNotEmpty)
                  _buildStatBadge(
                    '${review.storiesNeedingRefinement.length}',
                    Colors.orange,
                    '🔄',
                  ),
              ],
              const SizedBox(width: 8),
              const Icon(Icons.expand_more),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),

                  // Metriche
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric(
                        l10n.agileStatsCompleted,
                        '${review.storiesCompleted}',
                        Colors.green,
                      ),
                      _buildMetric(
                        l10n.agileStatsNotCompleted,
                        '${review.storiesNotCompleted}',
                        Colors.orange,
                      ),
                      _buildMetric(
                        l10n.agilePoints,
                        '${review.pointsCompleted}',
                        Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Attendees con ruoli
                  if (review.attendeesWithRoles.isNotEmpty) ...[
                    Text(
                      l10n.agileAttendees,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: review.attendeesWithRoles.map((attendee) {
                        return Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(attendee.roleIcon, style: const TextStyle(fontSize: 14)),
                          ),
                          label: Text(
                            '${attendee.name} (${attendee.roleDisplayName})',
                            style: const TextStyle(fontSize: 11),
                          ),
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Story outcomes
                  if (review.storyOutcomes.isNotEmpty) ...[
                    Text(
                      l10n.agileStoryEvaluations,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    ...review.storyOutcomes.take(5).map((outcome) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Text(outcome.outcome.icon, style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                outcome.storyTitle,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (outcome.storyPoints != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${outcome.storyPoints} SP',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                    if (review.storyOutcomes.length > 5)
                      Text(
                        '+ ${review.storyOutcomes.length - 5} altre...',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    const SizedBox(height: 12),
                  ],

                  // Decisioni
                  if (review.decisions.isNotEmpty) ...[
                    Text(
                      l10n.agileDecisions,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    ...review.decisions.take(3).map((decision) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Color(decision.type.colorValue).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                decision.type.displayName,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(decision.type.colorValue),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                decision.description,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                  ],

                  // Demo notes
                  if (review.demoNotes.isNotEmpty) ...[
                    Text(
                      l10n.agileDemoNotes,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.demoNotes,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Feedback
                  if (review.feedback.isNotEmpty) ...[
                    Text(
                      l10n.agileFeedback,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.feedback,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Actions (if editable)
                  if (onEdit != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => onEdit!(sprint),
                          icon: const Icon(Icons.edit, size: 16),
                          label: Text(l10n.actionEdit),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBadge(String value, Color color, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 10)),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
