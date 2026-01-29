import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/agile_enums.dart';
import '../../models/sprint_model.dart';
import '../../models/team_member_model.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

class TeamWorkloadWidget extends StatelessWidget {
  final List<TeamMemberModel> teamMembers;
  final List<UserStoryModel> stories;
  final SprintModel? currentSprint;

  const TeamWorkloadWidget({
    super.key,
    required this.teamMembers,
    required this.stories,
    this.currentSprint,
  });

  List<UserStoryModel> get _filteredStories {
    if (currentSprint != null) {
      return stories
          .where((s) => s.sprintId == currentSprint!.id)
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

    final membersWithStories =
        memberWorkloads.where((m) => m.assignedStories > 0).toList();
    final avgSP = membersWithStories.isEmpty
        ? 0.0
        : membersWithStories.fold<int>(0, (sum, m) => sum + m.totalSP) /
            membersWithStories.length;

    final isUnbalanced = membersWithStories.length > 1 &&
        membersWithStories.any(
            (m) => m.totalSP > avgSP * 1.5 || m.totalSP < avgSP * 0.5);

    for (final m in memberWorkloads) {
      m.isOverloaded = avgSP > 0 && m.totalSP > avgSP * 1.5;
    }

    return _WorkloadData(
      filtered: filtered,
      memberWorkloads: memberWorkloads,
      unassigned: unassigned,
      totalAssigned: totalAssigned,
      avgSP: avgSP,
      isUnbalanced: isUnbalanced,
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
                color: colorScheme.onSurface.withOpacity(0.4),
              ),
              const SizedBox(height: 12),
              Text(
                l10n?.agileWorkloadNoStories ?? 'No stories to analyze',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n?.agileWorkloadNoStoriesDesc ??
                    'Create stories and assign them to team members',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
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
        ? AppColors.success.withOpacity(0.15)
        : AppColors.warning.withOpacity(0.15);
    final textColor = isBalanced ? AppColors.success : AppColors.warning;
    final label = isBalanced
        ? (l10n?.agileWorkloadBalanced ?? 'Balanced')
        : (l10n?.agileWorkloadUnbalanced ?? 'Unbalanced');
    final icon = isBalanced ? Icons.check_circle_outline : Icons.warning_amber;

    return Container(
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
            l10n?.agileWorkloadAvgSp ?? 'Avg SP/Person',
            data.avgSP.toStringAsFixed(1),
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
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
              color: colorScheme.onSurface.withOpacity(0.6),
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
      ..sort((a, b) => b.totalSP.compareTo(a.totalSP));

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

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: mw.isOverloaded
              ? Border.all(
                  color: AppColors.warning.withOpacity(0.5), width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar, name, role, SP badge
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: colorScheme.primary.withOpacity(0.15),
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
                    color: colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${mw.totalSP} SP',
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
                  color: colorScheme.onSurface.withOpacity(0.55),
                ),
              ),
            ] else ...[
              const SizedBox(height: 4),
              Text(
                '0 ${l10n?.agileWorkloadStories ?? 'stories'}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
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
        color: AppColors.warning.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
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
                      color: colorScheme.onSurface.withOpacity(0.7),
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
    this.isOverloaded = false,
  });
}

class _WorkloadData {
  final List<UserStoryModel> filtered;
  final List<_MemberWorkload> memberWorkloads;
  final List<UserStoryModel> unassigned;
  final int totalAssigned;
  final double avgSP;
  final bool isUnbalanced;

  const _WorkloadData({
    required this.filtered,
    required this.memberWorkloads,
    required this.unassigned,
    required this.totalAssigned,
    required this.avgSP,
    required this.isUnbalanced,
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
