import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/user_story_model.dart';
import '../../themes/app_colors.dart';

/// Blocked Items Widget
///
/// Shows stories that are blocked by incomplete dependencies.
/// Each blocked story shows its blocking dependencies.
class BlockedItemsWidget extends StatelessWidget {
  final List<UserStoryModel> stories;

  const BlockedItemsWidget({super.key, required this.stories});

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  List<UserStoryModel> _blockedStories() {
    return stories
        .where((s) => !s.isCompleted && s.isBlockedBy(stories))
        .toList();
  }

  int _blockedSP(List<UserStoryModel> blocked) {
    return blocked.fold<int>(0, (acc, s) => acc + (s.storyPoints ?? 0));
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final blocked = _blockedStories();

    return Card(
      color: theme.colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(blocked.length, l10n, theme),
            const SizedBox(height: 12),
            if (blocked.isEmpty)
              _buildNoneState(l10n, theme)
            else
              _buildBlockedList(blocked, l10n, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int count, AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.link_off,
          size: 20,
          color: count > 0 ? AppColors.error : theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            l10n.agileBlockedItemsTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (count > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNoneState(AppLocalizations l10n, ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 20,
          color: AppColors.success,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.agileBlockedItemsNone,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                l10n.agileBlockedItemsNoneDesc,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBlockedList(
    List<UserStoryModel> blocked,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final blockedSP = _blockedSP(blocked);
    final displayCount = blocked.length > 10 ? 10 : blocked.length;
    final remaining = blocked.length - displayCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary
        Row(
          children: [
            Text(
              '${blocked.length} blocked',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (blockedSP > 0) ...[
              const SizedBox(width: 12),
              Text(
                '$blockedSP ${l10n.agileBlockedItemsSp}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        // Blocked items
        ...blocked.take(displayCount).map(
              (story) => _buildBlockedTile(story, l10n, theme),
            ),
        if (remaining > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '... +$remaining',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBlockedTile(
    UserStoryModel story,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final blocking = story.getBlockingDependencies(stories);
    final depCount = blocking.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: AppColors.error.withOpacity(0.6),
            width: 4,
          ),
        ),
        color: AppColors.error.withOpacity(0.04),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Expanded(
                child: Text(
                  story.title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              // Status chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: story.status.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  story.status.displayName,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: story.status.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
              if (story.storyPoints != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${story.storyPoints} SP',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          // Blocking deps
          Text(
            '${l10n.agileBlockedItemsBlockedBy}: $depCount ${depCount == 1 ? l10n.agileBlockedItemsDependency : l10n.agileBlockedItemsDependencies}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          if (blocking.isNotEmpty) ...[
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: blocking.take(3).map((dep) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    dep.title.length > 25
                        ? '${dep.title.substring(0, 25)}...'
                        : dep.title,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
