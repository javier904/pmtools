import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';
import 'package:agile_tools/models/agile_project_model.dart';
import 'package:agile_tools/services/agile_firestore_service.dart';
import 'package:agile_tools/services/lessons_learned_service.dart';

/// Dialog that allows the project owner to import lessons learned
/// from other projects they own.
///
/// Returns `true` on successful import, `null` on cancel.
class CrossProjectImportDialog extends StatefulWidget {
  final String currentProjectId;
  final String currentUserEmail;
  final String currentUserName;

  const CrossProjectImportDialog({
    super.key,
    required this.currentProjectId,
    required this.currentUserEmail,
    required this.currentUserName,
  });

  @override
  State<CrossProjectImportDialog> createState() =>
      _CrossProjectImportDialogState();
}

class _CrossProjectImportDialogState extends State<CrossProjectImportDialog> {
  final AgileFirestoreService _firestoreService = AgileFirestoreService();
  final LessonsLearnedService _lessonsService = LessonsLearnedService();

  // State
  bool _isLoadingProjects = true;
  bool _isLoadingLessons = false;
  bool _isImporting = false;
  List<AgileProjectModel> _ownedProjects = [];
  AgileProjectModel? _selectedProject;
  List<LessonLearnedModel> _lessons = [];
  final Set<String> _selectedLessonIds = {};

  @override
  void initState() {
    super.initState();
    _loadOwnedProjects();
  }

  Future<void> _loadOwnedProjects() async {
    try {
      final projects =
          await _firestoreService.getOwnedProjects(widget.currentUserEmail);
      final filtered = projects
          .where((p) => p.id != widget.currentProjectId)
          .toList();
      if (mounted) {
        setState(() {
          _ownedProjects = filtered;
          _isLoadingProjects = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingProjects = false;
        });
      }
    }
  }

  Future<void> _loadLessons(AgileProjectModel project) async {
    setState(() {
      _selectedProject = project;
      _isLoadingLessons = true;
      _lessons = [];
      _selectedLessonIds.clear();
    });

    try {
      final lessons = await _lessonsService.getProjectLessons(project.id);
      if (mounted) {
        setState(() {
          _lessons = lessons;
          _isLoadingLessons = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingLessons = false;
        });
      }
    }
  }

  void _toggleSelectAll() {
    setState(() {
      if (_selectedLessonIds.length == _lessons.length) {
        _selectedLessonIds.clear();
      } else {
        _selectedLessonIds
          ..clear()
          ..addAll(_lessons.map((l) => l.id));
      }
    });
  }

  Future<void> _importSelected() async {
    if (_selectedLessonIds.isEmpty) return;

    setState(() {
      _isImporting = true;
    });

    try {
      final lessonsToImport =
          _lessons.where((l) => _selectedLessonIds.contains(l.id)).toList();

      for (final lesson in lessonsToImport) {
        await _lessonsService.importLessonToProject(
          widget.currentProjectId,
          lesson,
          widget.currentUserEmail,
          importerName: widget.currentUserName,
        );
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.crossProjectImportSuccess(lessonsToImport.length),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 650,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(l10n, theme),
            const Divider(height: 1),
            // Content
            Flexible(
              child: _isLoadingProjects
                  ? const Padding(
                      padding: EdgeInsets.all(48),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _ownedProjects.isEmpty
                      ? _buildEmptyState(l10n, theme)
                      : _buildContent(l10n, theme),
            ),
            const Divider(height: 1),
            // Actions
            _buildActions(l10n, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      child: Row(
        children: [
          Icon(
            Icons.import_export,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.crossProjectImportLessons,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.crossProjectNoProjects,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project selector
          _buildProjectSelector(l10n, theme),
          const SizedBox(height: 16),
          // Lessons list
          if (_selectedProject != null) ...[
            if (_isLoadingLessons)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_lessons.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'No lessons found in this project',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              )
            else
              _buildLessonsList(l10n, theme),
          ],
        ],
      ),
    );
  }

  Widget _buildProjectSelector(AppLocalizations l10n, ThemeData theme) {
    return DropdownButtonFormField<AgileProjectModel>(
      value: _selectedProject,
      decoration: InputDecoration(
        labelText: l10n.crossProjectSelectProject,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.folder_outlined),
      ),
      items: _ownedProjects.map((project) {
        return DropdownMenuItem(
          value: project,
          child: Text(
            project.name,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (project) {
        if (project != null) {
          _loadLessons(project);
        }
      },
    );
  }

  Widget _buildLessonsList(AppLocalizations l10n, ThemeData theme) {
    final allSelected = _selectedLessonIds.length == _lessons.length;

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Select all toggle
          InkWell(
            onTap: _toggleSelectAll,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: allSelected,
                    tristate: true,
                    onChanged: (_) => _toggleSelectAll(),
                  ),
                  Text(
                    'Select All (${_lessons.length})',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_selectedLessonIds.length} selected',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Lessons
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 350),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  final lesson = _lessons[index];
                  final isSelected = _selectedLessonIds.contains(lesson.id);
                  return _buildLessonTile(lesson, isSelected, l10n, theme);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTile(
    LessonLearnedModel lesson,
    bool isSelected,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedLessonIds.remove(lesson.id);
          } else {
            _selectedLessonIds.add(lesson.id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedLessonIds.add(lesson.id);
                  } else {
                    _selectedLessonIds.remove(lesson.id);
                  }
                });
              },
            ),
            // Type badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: lesson.type.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    lesson.type.icon,
                    size: 14,
                    color: lesson.type.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lesson.type.getLocalizedName(l10n),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: lesson.type.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Title
            Expanded(
              child: Text(
                lesson.title,
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Category chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: lesson.category.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: lesson.category.color.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    lesson.category.icon,
                    size: 12,
                    color: lesson.category.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    lesson.category.getLocalizedName(l10n),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: lesson.category.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(AppLocalizations l10n, ThemeData theme) {
    final hasSelection = _selectedLessonIds.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed:
                _isImporting ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          const SizedBox(width: 12),
          Tooltip(
            message: l10n.tooltipCrossProjectImportDesc,
            child: FilledButton.icon(
              onPressed: (hasSelection && !_isImporting) ? _importSelected : null,
              icon: _isImporting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.download, size: 18),
              label: Text(
                _isImporting
                    ? 'Importing...'
                    : '${l10n.crossProjectImport} (${_selectedLessonIds.length})',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
