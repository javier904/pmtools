import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../models/team_member_model.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';

class TeamWorkloadWidget extends StatelessWidget {
  final List<TeamMemberModel> teamMembers;
  final List<UserStoryModel> stories;
  final SprintModel? currentSprint;
  final AgileFramework framework;

  const TeamWorkloadWidget({
    super.key,
    required this.teamMembers,
    required this.stories,
    this.currentSprint,
    required this.framework,
  });

  List<UserStoryModel> get _filteredStories {
    if (currentSprint != null) {
      return stories
          .where((s) => s.sprintId == currentSprint!.id && !s.status.needsRefinement)
          .toList();
    }
    return stories
        .where((s) => s.status != StoryStatus.done)
        .toList();
  }

  Map<String?, List<UserStoryModel>> _groupByAssignee(
      List<UserStoryModel> filtered) {
    final Map<String?, List<UserStoryModel>> grouped = {};
    for (final story in filtered) {
      grouped.putIfAbsent(story.assigneeEmail, () => []).add(story);
    }
    return grouped;
  }

  _WorkloadData _computeWorkloadData() {
    final filtered = _filteredStories;
    final grouped = _groupByAssignee(filtered);

    final List<_MemberWorkload> memberWorkloads = [];
    int totalAssigned = 0;
    
    // Check if we should use Story Points or Count
    // Use SP if Scrum OR if there are actually points assigned
    final totalPoints = filtered.fold<int>(0, (sum, s) => sum + (s.storyPoints ?? 0));
    final useStoryPoints = framework == AgileFramework.scrum || totalPoints > 0;

    for (final member in teamMembers) {
      final memberStories = grouped[member.email] ?? [];
      final totalSP = memberStories.fold<int>(
          0, (sum, s) => sum + (s.storyPoints ?? 0));

      final Map<StoryStatus, int> storiesByStatus = {};
      for (final s in memberStories) {
        storiesByStatus[s.status] = (storiesByStatus[s.status] ?? 0) + 1;
      }

      final wipCount = memberStories
          .where((s) =>
              s.status == StoryStatus.inProgress ||
              s.status == StoryStatus.inReview)
          .length;

      totalAssigned += memberStories.length;

      memberWorkloads.add(_MemberWorkload(
        member: member,
        assignedStories: memberStories.length,
        totalSP: totalSP,
        storiesByStatus: storiesByStatus,
        wipCount: wipCount,
      ));
    }

    final unassigned = grouped[null] ?? [];

    // CHANGED: Use ALL filtered members for average, not just active ones
    final double avgLoad = memberWorkloads.isEmpty
        ? 0.0
        : memberWorkloads.fold<int>(0, (sum, m) => sum + (useStoryPoints ? m.totalSP : m.assignedStories)) /
            memberWorkloads.length;

    // A team is unbalanced if there is more than 1 member AND
    // anyone is outside the tolerant range (0.5x - 1.5x average)
    final isUnbalanced = memberWorkloads.length > 1 &&
        memberWorkloads.any(
            (m) {
              final load = useStoryPoints ? m.totalSP : m.assignedStories;
              return load > avgLoad * 1.5 || load < avgLoad * 0.5;
            });

    for (final m in memberWorkloads) {
      final load = useStoryPoints ? m.totalSP : m.assignedStories;
      m.isOverloaded = avgLoad > 0 && load > avgLoad * 1.5;
    }

    return _WorkloadData(
      filtered: filtered,
      memberWorkloads: memberWorkloads,
      unassigned: unassigned,
      totalAssigned: totalAssigned,
      avgLoad: avgLoad,
      isUnbalanced: isUnbalanced,
      useStoryPoints: useStoryPoints,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final data = _computeWorkloadData();

    if (data.filtered.isEmpty) {
      return _buildEmptyState(context, l10n, theme, colorScheme);
    }

    return Card(
      color: colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, l10n, theme, colorScheme, data),
            const SizedBox(height: 16),
            _buildSummaryRow(context, l10n, theme, colorScheme, data),
            const SizedBox(height: 16),
            _buildMemberList(context, l10n, theme, colorScheme, data),
            if (data.unassigned.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildUnassignedSection(
                  context, l10n, theme, colorScheme, data.unassigned),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Card(
      color: colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.assignment_outlined,
                size: 48,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(height: 12),
              Text(
                l10n?.agileWorkloadNoStories ?? 'No stories to analyze',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n?.agileWorkloadNoStoriesDesc ??
                    'Create stories and assign them to team members',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    _WorkloadData data,
  ) {
    return Row(
      children: [
        Icon(Icons.people, color: colorScheme.primary, size: 24),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            l10n?.agileWorkloadTitle ?? 'Team Workload',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        _buildBalanceBadge(context, l10n, theme, colorScheme, data),
      ],
    );
  }

  Widget _buildBalanceBadge(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    _WorkloadData data,
  ) {
    final isBalanced = !data.isUnbalanced;
    final badgeColor = isBalanced
        ? AppColors.success.withValues(alpha: 0.15)
        : AppColors.warning.withValues(alpha: 0.15);
    final textColor = isBalanced ? AppColors.success : AppColors.warning;
    final label = isBalanced
        ? (l10n?.agileWorkloadBalanced ?? 'Balanced')
        : (l10n?.agileWorkloadUnbalanced ?? 'Unbalanced');
    final icon = isBalanced ? Icons.check_circle_outline : Icons.warning_amber;

    // Calculate ranges for tooltip explanation
    final minBalanced = (data.avgLoad * 0.5).toStringAsFixed(1);
    final maxBalanced = (data.avgLoad * 1.5).toStringAsFixed(1);
    final avgFormatted = data.avgLoad.toStringAsFixed(1);
    final unit = data.useStoryPoints ? 'SP' : (l10n?.agileItems ?? 'stories');

    final tooltipMessage = l10n?.agileWorkloadBalanceTooltip(
            avgFormatted, minBalanced, maxBalanced) ??
        'Avg: $avgFormatted $unit\nRange: $minBalanced - $maxBalanced $unit';

    return Tooltip(
      message: tooltipMessage,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E), // Dark grey like existing tooltips
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: badgeColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    _WorkloadData data,
  ) {
    final assignedPct = data.filtered.isEmpty
        ? 0
        : ((data.totalAssigned / data.filtered.length) * 100).round();
    
    final unitLabel = data.useStoryPoints 
        ? (l10n?.agileWorkloadAvgSp ?? 'Avg SP/Person')
        : (l10n?.agileWorkloadAvgItems ?? 'Avg Items/Person');

    return Row(
      children: [
        Expanded(
          child: _buildSummaryItem(
            theme,
            colorScheme,
            l10n?.agileWorkloadTotalStories ?? 'Total Stories',
            '${data.filtered.length}',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildSummaryItem(
            theme,
            colorScheme,
            l10n?.agileWorkloadAssigned ?? 'Assigned',
            '$assignedPct%',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildSummaryItem(
            theme,
            colorScheme,
            unitLabel,
            data.avgLoad.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(
    ThemeData theme,
    ColorScheme colorScheme,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMemberList(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    _WorkloadData data,
  ) {
    final sorted = List<_MemberWorkload>.from(data.memberWorkloads)
      ..sort((a, b) {
        final valA = data.useStoryPoints ? a.totalSP : a.assignedStories;
        final valB = data.useStoryPoints ? b.totalSP : b.assignedStories;
        return valB.compareTo(valA);
      });

    return Column(
      children: sorted
          .map((mw) =>
              _buildMemberCard(context, l10n, theme, colorScheme, mw, data))
          .toList(),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    _MemberWorkload mw,
    _WorkloadData data,
  ) {
    final initial = mw.member.name.isNotEmpty
        ? mw.member.name[0].toUpperCase()
        : '?';
        
    final loadValue = data.useStoryPoints ? mw.totalSP : mw.assignedStories;
    final loadUnit = data.useStoryPoints ? 'SP' : (l10n?.agileItemsShort ?? 'items');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
          border: mw.isOverloaded
              ? Border.all(
                  color: AppColors.warning.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar, name, role, SP/Count badge
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                  child: Text(
                    initial,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    mw.member.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildRoleChip(theme, colorScheme, mw.member.teamRole),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$loadValue $loadUnit',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (mw.isOverloaded) ...[
                  const SizedBox(width: 6),
                  Tooltip(
                    message:
                        l10n?.agileWorkloadOverloaded ?? 'Overloaded',
                    child: Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ],
            ),
            if (mw.assignedStories > 0) ...[
              const SizedBox(height: 8),
              // Status bar
              _buildStatusBar(theme, colorScheme, mw),
              const SizedBox(height: 6),
              // Detail text
              Text(
                '${mw.assignedStories} ${l10n?.agileWorkloadStories ?? 'stories'}'
                ' \u00b7 ${mw.totalSP} SP'
                ' \u00b7 ${mw.wipCount} ${l10n?.agileWorkloadInProgress ?? 'in progress'}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
            ] else ...[
              const SizedBox(height: 4),
              Text(
                '0 ${l10n?.agileWorkloadStories ?? 'stories'}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRoleChip(
    ThemeData theme,
    ColorScheme colorScheme,
    TeamRole role,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        role.shortName,
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildStatusBar(
    ThemeData theme,
    ColorScheme colorScheme,
    _MemberWorkload mw,
  ) {
    final total = mw.assignedStories;
    if (total == 0) return const SizedBox.shrink();

    final segments = <_StatusSegment>[];
    for (final status in StoryStatus.values) {
      final count = mw.storiesByStatus[status] ?? 0;
      if (count == 0) continue;
      segments.add(_StatusSegment(
        status: status,
        count: count,
        fraction: count / total,
      ));
    }

    if (segments.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Row(
        children: segments.asMap().entries.map((entry) {
          final index = entry.key;
          final seg = entry.value;
          return Expanded(
            flex: (seg.fraction * 1000).round(),
            child: Tooltip(
              message: '${seg.status.name}: ${seg.count}',
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: seg.status.color,
                  borderRadius: BorderRadius.horizontal(
                    left: index == 0
                        ? const Radius.circular(3)
                        : Radius.zero,
                    right: index == segments.length - 1
                        ? const Radius.circular(3)
                        : Radius.zero,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUnassignedSection(
    BuildContext context,
    AppLocalizations? l10n,
    ThemeData theme,
    ColorScheme colorScheme,
    List<UserStoryModel> unassigned,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 18,
            color: AppColors.warning,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${l10n?.agileWorkloadUnassigned ?? 'Unassigned'}: ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text:
                        '${unassigned.length} ${l10n?.agileWorkloadUnassignedWarning ?? 'stories without assignee'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal data classes
// ---------------------------------------------------------------------------

class _MemberWorkload {
  final TeamMemberModel member;
  final int assignedStories;
  final int totalSP;
  final Map<StoryStatus, int> storiesByStatus;
  final int wipCount;
  bool isOverloaded;

  _MemberWorkload({
    required this.member,
    required this.assignedStories,
    required this.totalSP,
    required this.storiesByStatus,
    required this.wipCount,
  }) : isOverloaded = false;
}

class _WorkloadData {
  final List<UserStoryModel> filtered;
  final List<_MemberWorkload> memberWorkloads;
  final List<UserStoryModel> unassigned;
  final int totalAssigned;
  final double avgLoad; // Renamed from avgSP
  final bool isUnbalanced;
  final bool useStoryPoints; // New field

  const _WorkloadData({
    required this.filtered,
    required this.memberWorkloads,
    required this.unassigned,
    required this.totalAssigned,
    required this.avgLoad,
    required this.isUnbalanced,
    required this.useStoryPoints,
  });
}

class _StatusSegment {
  final StoryStatus status;
  final int count;
  final double fraction;

  const _StatusSegment({
    required this.status,
    required this.count,
    required this.fraction,
  });
}
