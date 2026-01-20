import 'package:flutter/material.dart';
import '../../services/deadline_service.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class SectionDeadlines extends StatefulWidget {
  const SectionDeadlines({super.key});

  @override
  State<SectionDeadlines> createState() => _SectionDeadlinesState();
}

class _SectionDeadlinesState extends State<SectionDeadlines> {
  int _daysFilter = -1; // -1 = All, 0 = Today, 1 = Tomorrow, etc.

  // Filters config: map of days -> visible
  final Map<int, bool> _visibleFilters = {
    -1: true, // All
    0: true, // Today
    1: true, // Tomorrow
    2: false,
    3: false,
    5: false,
  };



  @override
  Widget build(BuildContext context) {
    final service = DeadlineService();
    final isDark = context.isDarkMode;

    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.access_time_filled_rounded, color: AppColors.error, size: 24),
                const SizedBox(width: 8),
                Text(
                  l10n.deadlineTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                const Spacer(),
                _buildFilterChips(l10n),
                const SizedBox(width: 8),
                _buildConfigButton(context, l10n),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<DeadlineItem>>(
              stream: service.streamDeadlines(daysAhead: _daysFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  debugPrint('DEBUG: UI Error: ${snapshot.error}');
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        'Errore: ${snapshot.error}',
                        style: const TextStyle(color: AppColors.error, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final items = snapshot.data ?? [];

                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        l10n.deadlineNoUpcoming,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: context.textMutedColor),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _DeadlineItemTile(item: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigButton(BuildContext context, AppLocalizations l10n) {
    return InkWell(
      onTap: () => _showConfigDialog(context, l10n),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: context.surfaceVariantColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.tune_rounded, size: 18, color: context.textSecondaryColor),
      ),
    );
  }

  void _showConfigDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(l10n.deadlineConfigTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.deadlineConfigDesc, style: TextStyle(fontSize: 13, color: context.textMutedColor)),
                const SizedBox(height: 16),
                _buildCheckbox(-1, l10n.deadlineAll, setStateDialog),
                _buildCheckbox(0, l10n.deadlineToday, setStateDialog),
                _buildCheckbox(1, l10n.deadlineTomorrow, setStateDialog),
                _buildCheckbox(2, l10n.deadline2Days, setStateDialog),
                _buildCheckbox(3, l10n.deadline3Days, setStateDialog),
                _buildCheckbox(5, l10n.deadline5Days, setStateDialog),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    ).then((_) => setState(() {}));
  }

  Widget _buildCheckbox(int days, String label, StateSetter setStateDialog) {
    return CheckboxListTile(
      title: Text(label),
      value: _visibleFilters[days] ?? false,
      onChanged: (val) {
        setStateDialog(() {
          _visibleFilters[days] = val ?? false;
        });
        // If hidden and currently selected, reset to default (0)
        if (val == false && _daysFilter == days) {
          setState(() => _daysFilter = 0);
        }
      },
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildFilterChips(AppLocalizations l10n) {
    final activeOptions = _visibleFilters.entries.where((e) => e.value).map((e) => e.key).toList();
    activeOptions.sort();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: activeOptions.map((days) {
        String label;
        switch (days) {
          case -1: label = l10n.deadlineAll; break;
          case 0: label = l10n.deadlineToday; break;
          case 1: label = l10n.deadlineTomorrow; break;
          case 2: label = l10n.deadline2Days; break;
          case 3: label = l10n.deadline3Days; break;
          case 5: label = l10n.deadline5Days; break;
          default: label = '$days d';
        }

        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: _FilterChip(
            label: label,
            isSelected: _daysFilter == days,
            onTap: () => setState(() => _daysFilter = days),
          ),
        );
      }).toList(),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Align height with icons
        decoration: BoxDecoration(
          color: isSelected ? AppColors.error.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.error : context.borderColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.error : context.textMutedColor,
          ),
        ),
      ),
    );
  }
}

class _DeadlineItemTile extends StatelessWidget {
  final DeadlineItem item;

  const _DeadlineItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isUrgent = item.isToday;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isUrgent ? AppColors.error.withValues(alpha: 0.05) : context.surfaceVariantColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(10),
        border: isUrgent ? Border.all(color: AppColors.error.withValues(alpha: 0.2)) : null,
      ),
      child: Row(
        children: [
          Icon(
            item.type == DeadlineType.sprint ? Icons.rocket_launch_rounded : Icons.check_circle_outline_rounded,
            size: 18,
            color: isUrgent ? AppColors.error : context.textSecondaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_formatDate(item.date, l10n)} • ${item.type == DeadlineType.sprint ? l10n.deadlineSprint : l10n.deadlineTask}',
                  style: TextStyle(
                    color: isUrgent ? AppColors.error.withValues(alpha: 0.7) : context.textMutedColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (item.priority != null)
            _buildPriorityBadge(item.priority!),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    if (item.isToday) return l10n.deadlineToday;
    if (item.isTomorrow) return l10n.deadlineTomorrow;
    return DateFormat('dd MMM').format(date);
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high': color = AppColors.error; break;
      case 'medium': color = Colors.orange; break;
      default: color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
    );
  }
}
