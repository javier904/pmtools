import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';
import 'package:agile_tools/services/lessons_learned_service.dart';
import 'package:agile_tools/widgets/retrospective/cross_project_import_dialog.dart';

class LessonsLearnedSectionWidget extends StatefulWidget {
  final String projectId;
  final String currentUserEmail;
  final Function(LessonLearnedModel)? onTapLesson;
  final VoidCallback? onAddLesson;

  const LessonsLearnedSectionWidget({
    super.key,
    required this.projectId,
    required this.currentUserEmail,
    this.onTapLesson,
    this.onAddLesson,
  });

  @override
  State<LessonsLearnedSectionWidget> createState() =>
      _LessonsLearnedSectionWidgetState();
}

class _LessonsLearnedSectionWidgetState
    extends State<LessonsLearnedSectionWidget> {
  final LessonsLearnedService _service = LessonsLearnedService();
  late Stream<List<LessonLearnedModel>> _lessonsStream;

  LessonCategory? _selectedCategory;
  LessonType? _selectedType;
  bool? _resolvedFilter; // null = all, true = resolved, false = unresolved

  @override
  void initState() {
    super.initState();
    _lessonsStream = _service.streamProjectLessons(widget.projectId);
  }

  @override
  void didUpdateWidget(covariant LessonsLearnedSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.projectId != widget.projectId) {
      _lessonsStream = _service.streamProjectLessons(widget.projectId);
    }
  }

  List<LessonLearnedModel> _applyFilters(List<LessonLearnedModel> lessons) {
    return lessons.where((lesson) {
      if (_selectedCategory != null && lesson.category != _selectedCategory) {
        return false;
      }
      if (_selectedType != null && lesson.type != _selectedType) {
        return false;
      }
      if (_resolvedFilter != null && lesson.isResolved != _resolvedFilter) {
        return false;
      }
      return true;
    }).toList();
  }

  Map<LessonCategory, int> _buildCategoryCounts(
      List<LessonLearnedModel> lessons) {
    final counts = <LessonCategory, int>{};
    for (final lesson in lessons) {
      counts[lesson.category] = (counts[lesson.category] ?? 0) + 1;
    }
    return counts;
  }

  void _showCrossProjectImport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CrossProjectImportDialog(
        currentProjectId: widget.projectId,
        currentUserEmail: widget.currentUserEmail,
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, LessonLearnedModel lesson) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.lessonsLearnedDelete),
        content: Text(l10n.lessonsLearnedDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await _service.deleteLesson(widget.projectId, lesson.id);
    }
  }

  String _emailPrefix(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex > 0) return email.substring(0, atIndex);
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return StreamBuilder<List<LessonLearnedModel>>(
      stream: _lessonsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final allLessons = snapshot.data ?? [];
        final filteredLessons = _applyFilters(allLessons);
        final categoryCounts = _buildCategoryCounts(allLessons);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.school, color: primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    l10n.lessonsLearnedTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  Tooltip(
                    message: l10n.tooltipLessonImport,
                    child: OutlinedButton.icon(
                      onPressed: () => _showCrossProjectImport(context),
                      icon: const Icon(Icons.download, size: 18),
                      label: Text(l10n.crossProjectImport),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Tooltip(
                    message: l10n.tooltipLessonAdd,
                    child: FilledButton.icon(
                      onPressed: widget.onAddLesson,
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(l10n.lessonsLearnedCreate),
                    ),
                  ),
                ],
              ),
            ),

            // Category summary chips
            if (categoryCounts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: categoryCounts.entries.map((entry) {
                    final cat = entry.key;
                    final count = entry.value;
                    final isSelected = _selectedCategory == cat;
                    return FilterChip(
                      avatar: Icon(cat.icon, size: 16, color: cat.color),
                      label: Text(
                        '${cat.getLocalizedName(l10n)} ($count)',
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : cat.color,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: cat.color.withValues(alpha: 0.8),
                      backgroundColor: cat.color.withValues(alpha: 0.1),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? cat : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

            const SizedBox(height: 8),

            // Filter row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.filter_list,
                      size: 18, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    l10n.actionFilter,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Category dropdown
                  Flexible(
                    child: Tooltip(
                      message: l10n.tooltipLessonCategoryFilter,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<LessonCategory?>(
                          value: _selectedCategory,
                          hint: Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade600),
                          ),
                          isExpanded: false,
                          isDense: true,
                          items: [
                            DropdownMenuItem<LessonCategory?>(
                              value: null,
                              child: Text('All',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700)),
                            ),
                            ...LessonCategory.values.map((cat) {
                              return DropdownMenuItem<LessonCategory?>(
                                value: cat,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(cat.icon, size: 14, color: cat.color),
                                    const SizedBox(width: 4),
                                    Text(cat.getLocalizedName(l10n),
                                        style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedCategory = value);
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Type dropdown
                  Flexible(
                    child: Tooltip(
                      message: l10n.tooltipLessonTypeFilter,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<LessonType?>(
                          value: _selectedType,
                          hint: Text(
                            'Type',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey.shade600),
                          ),
                          isExpanded: false,
                          isDense: true,
                          items: [
                            DropdownMenuItem<LessonType?>(
                              value: null,
                              child: Text('All',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700)),
                            ),
                            ...LessonType.values.map((type) {
                              return DropdownMenuItem<LessonType?>(
                                value: type,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(type.icon, size: 14, color: type.color),
                                    const SizedBox(width: 4),
                                    Text(type.getLocalizedName(l10n),
                                        style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedType = value);
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Resolved toggle
                  Tooltip(
                    message: l10n.tooltipLessonResolvedFilter,
                    child: ToggleButtons(
                      isSelected: [
                        _resolvedFilter == null,
                        _resolvedFilter == false,
                        _resolvedFilter == true,
                      ],
                      onPressed: (index) {
                        setState(() {
                          if (index == 0) {
                            _resolvedFilter = null;
                          } else if (index == 1) {
                            _resolvedFilter = false;
                          } else {
                            _resolvedFilter = true;
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      constraints:
                          const BoxConstraints(minHeight: 32, minWidth: 40),
                      textStyle: const TextStyle(fontSize: 12),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('All'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.pending_outlined,
                              size: 16, color: Colors.orange.shade700),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle,
                                  size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Text(l10n.lessonIsResolved,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Divider(height: 1),

            // Lessons list
            if (filteredLessons.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.school_outlined,
                          size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      Text(
                        l10n.lessonsLearnedEmpty,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredLessons.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final lesson = filteredLessons[index];
                    return _LessonCard(
                      lesson: lesson,
                      l10n: l10n,
                      onTap: widget.onTapLesson != null
                          ? () => widget.onTapLesson!(lesson)
                          : null,
                      onLongPress: () => _confirmDelete(context, lesson),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _LessonCard extends StatelessWidget {
  final LessonLearnedModel lesson;
  final AppLocalizations l10n;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _LessonCard({
    required this.lesson,
    required this.l10n,
    this.onTap,
    this.onLongPress,
  });

  String _emailPrefix(String email) {
    final atIndex = email.indexOf('@');
    if (atIndex > 0) return email.substring(0, atIndex);
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = lesson.type.color;
    final categoryColor = lesson.category.color;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: typeColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: type badge + resolved indicator
              Row(
                children: [
                  // Type badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: typeColor.withValues(alpha: 0.4), width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(lesson.type.icon, size: 14, color: typeColor),
                        const SizedBox(width: 4),
                        Text(
                          lesson.type.getLocalizedName(l10n),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: typeColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Category chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(lesson.category.icon,
                            size: 14, color: categoryColor),
                        const SizedBox(width: 4),
                        Text(
                          lesson.category.getLocalizedName(l10n),
                          style: TextStyle(
                            fontSize: 11,
                            color: categoryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Recurring badge
                  if (lesson.isRecurring)
                    Tooltip(
                      message: l10n.tooltipLessonRecurring,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.repeat,
                                size: 12, color: Colors.orange),
                            const SizedBox(width: 3),
                            Text(
                              l10n.lessonOccurrenceCount(
                                  lesson.occurrenceCount.toString()),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (lesson.isRecurring) const SizedBox(width: 6),

                  // Resolved indicator
                  if (lesson.isResolved)
                    Tooltip(
                      message: l10n.tooltipLessonResolved,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle,
                                size: 12, color: Colors.green),
                            const SizedBox(width: 3),
                            Text(
                              l10n.lessonIsResolved,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              // Title
              Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // Description (max 3 lines)
              Text(
                lesson.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),

              // Tags
              if (lesson.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: lesson.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '#$tag',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 8),

              // Footer: createdBy
              Row(
                children: [
                  Icon(Icons.person_outline,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    _emailPrefix(lesson.createdBy),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
