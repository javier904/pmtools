import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';
import 'package:agile_tools/services/lessons_learned_service.dart';

class LessonLearnedDialog extends StatefulWidget {
  final String projectId;
  final String currentUserEmail;
  final String currentUserName;
  final LessonLearnedModel? existingLesson;

  const LessonLearnedDialog({
    super.key,
    required this.projectId,
    required this.currentUserEmail,
    required this.currentUserName,
    this.existingLesson,
  });

  @override
  State<LessonLearnedDialog> createState() => _LessonLearnedDialogState();
}

class _LessonLearnedDialogState extends State<LessonLearnedDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rootCauseController = TextEditingController();
  final _recommendationController = TextEditingController();
  final _tagsController = TextEditingController();

  late LessonCategory _selectedCategory;
  late LessonType _selectedType;
  late bool _isRecurring;
  late bool _isResolved;

  bool _isSaving = false;

  final _service = LessonsLearnedService();

  bool get _isEditing => widget.existingLesson != null;

  @override
  void initState() {
    super.initState();
    final lesson = widget.existingLesson;
    if (lesson != null) {
      _titleController.text = lesson.title;
      _descriptionController.text = lesson.description;
      _rootCauseController.text = lesson.rootCause ?? '';
      _recommendationController.text = lesson.recommendation ?? '';
      _tagsController.text = lesson.tags.join(', ');
      _selectedCategory = lesson.category;
      _selectedType = lesson.type;
      _isRecurring = lesson.isRecurring;
      _isResolved = lesson.isResolved;
    } else {
      _selectedCategory = LessonCategory.process;
      _selectedType = LessonType.recommendation;
      _isRecurring = false;
      _isResolved = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _rootCauseController.dispose();
    _recommendationController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  List<String> _parseTags(String text) {
    return text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final now = DateTime.now();
      final tags = _parseTags(_tagsController.text);
      final rootCause =
          _rootCauseController.text.trim().isEmpty ? null : _rootCauseController.text.trim();
      final recommendation =
          _recommendationController.text.trim().isEmpty ? null : _recommendationController.text.trim();

      if (_isEditing) {
        final updated = widget.existingLesson!.copyWith(
          category: _selectedCategory,
          type: _selectedType,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          rootCause: rootCause,
          recommendation: recommendation,
          tags: tags,
          isRecurring: _isRecurring,
          isResolved: _isResolved,
          resolvedAt: _isResolved && !widget.existingLesson!.isResolved ? now : null,
          updatedAt: now,
        );
        await _service.updateLesson(widget.projectId, updated, userName: widget.currentUserName);
      } else {
        final lesson = LessonLearnedModel(
          id: '',
          projectId: widget.projectId,
          category: _selectedCategory,
          type: _selectedType,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          rootCause: rootCause,
          recommendation: recommendation,
          tags: tags,
          isRecurring: _isRecurring,
          isResolved: _isResolved,
          resolvedAt: _isResolved ? now : null,
          createdBy: widget.currentUserEmail,
          createdAt: now,
          updatedAt: now,
        );
        await _service.createLesson(widget.projectId, lesson, userName: widget.currentUserName);
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Dialog(
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(l10n, primaryColor),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & Type row
                      Row(
                        children: [
                          Expanded(child: _buildCategoryDropdown(l10n)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildTypeDropdown(l10n)),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: l10n.lessonFieldTitle,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '${l10n.lessonFieldTitle} is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: l10n.lessonFieldDescription,
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '${l10n.lessonFieldDescription} is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Root Cause
                      TextFormField(
                        controller: _rootCauseController,
                        decoration: InputDecoration(
                          labelText: l10n.lessonFieldRootCause,
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                          helperText: l10n.tooltipFormRootCause,
                          helperMaxLines: 2,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Recommendation
                      TextFormField(
                        controller: _recommendationController,
                        decoration: InputDecoration(
                          labelText: l10n.lessonFieldRecommendation,
                          border: const OutlineInputBorder(),
                          alignLabelWithHint: true,
                          helperText: l10n.tooltipFormRecommendation,
                          helperMaxLines: 2,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      TextFormField(
                        controller: _tagsController,
                        decoration: InputDecoration(
                          labelText: l10n.lessonFieldTags,
                          border: const OutlineInputBorder(),
                          helperText: l10n.tooltipFormTags,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Toggles
                      Row(
                        children: [
                          Expanded(
                            child: Tooltip(
                              message: l10n.tooltipFormRecurring,
                              child: SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  l10n.lessonIsRecurring,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                dense: true,
                                value: _isRecurring,
                                onChanged: (v) => setState(() => _isRecurring = v),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Tooltip(
                              message: l10n.tooltipFormResolved,
                              child: SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  l10n.lessonIsResolved,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                dense: true,
                                value: _isResolved,
                                onChanged: (v) => setState(() => _isResolved = v),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
            _buildActions(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit : Icons.add_circle_outline,
            color: primaryColor,
          ),
          const SizedBox(width: 12),
          Text(
            _isEditing ? l10n.lessonsLearnedEdit : l10n.lessonsLearnedCreate,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<LessonCategory>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        border: const OutlineInputBorder(),
      ),
      items: LessonCategory.values.map((cat) {
        return DropdownMenuItem(
          value: cat,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(cat.icon, size: 18, color: cat.color),
              const SizedBox(width: 8),
              Text(cat.getLocalizedName(l10n)),
            ],
          ),
        );
      }).toList(),
      onChanged: (v) {
        if (v != null) setState(() => _selectedCategory = v);
      },
    );
  }

  Widget _buildTypeDropdown(AppLocalizations l10n) {
    return DropdownButtonFormField<LessonType>(
      value: _selectedType,
      decoration: InputDecoration(
        labelText: 'Type',
        border: const OutlineInputBorder(),
      ),
      items: LessonType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(type.icon, size: 18, color: type.color),
              const SizedBox(width: 8),
              Text(type.getLocalizedName(l10n)),
            ],
          ),
        );
      }).toList(),
      onChanged: (v) {
        if (v != null) setState(() => _selectedType = v);
      },
    );
  }

  Widget _buildActions(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
            child: Text(l10n.actionCancel),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: _isSaving ? null : _onSave,
            icon: _isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
            label: Text(l10n.actionSave),
          ),
        ],
      ),
    );
  }
}
