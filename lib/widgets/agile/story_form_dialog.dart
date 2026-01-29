import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per creare o modificare una User Story
///
/// Template: As a [user], I want [feature] so that [benefit]
class StoryFormDialog extends StatefulWidget {
  final UserStoryModel? story;
  final String projectId;
  final List<String> existingTags;
  final List<String> teamMembers; // emails

  const StoryFormDialog({
    super.key,
    this.story,
    required this.projectId,
    this.existingTags = const [],
    this.teamMembers = const [],
  });

  static Future<UserStoryModel?> show({
    required BuildContext context,
    required String projectId,
    UserStoryModel? story,
    List<String> existingTags = const [],
    List<String> teamMembers = const [],
  }) {
    return showDialog<UserStoryModel>(
      context: context,
      builder: (context) => StoryFormDialog(
        story: story,
        projectId: projectId,
        existingTags: existingTags,
        teamMembers: teamMembers,
      ),
    );
  }

  @override
  State<StoryFormDialog> createState() => _StoryFormDialogState();
}

class _StoryFormDialogState extends State<StoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _userController;
  late TextEditingController _featureController;
  late TextEditingController _benefitController;
  late TextEditingController _tagController;
  late TextEditingController _criteriaController;

  late StoryPriority _priority;
  late ClassOfService _classOfService;
  late int _businessValue;
  late List<String> _tags;
  late List<AcceptanceCriterion> _acceptanceCriteria;
  String? _assigneeEmail;
  bool _useTemplate = true;
  int? _storyPoints;

  // Fibonacci values for Story Points
  static const fibonacciValues = [1, 2, 3, 5, 8, 13, 21];

  bool get _isEditing => widget.story != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.story?.title ?? '');
    _tagController = TextEditingController();
    _criteriaController = TextEditingController();

    // Parse description for template
    if (widget.story != null && widget.story!.description.isNotEmpty) {
      final parsed = _parseDescription(widget.story!.description);
      _userController = TextEditingController(text: parsed['user'] ?? '');
      _featureController = TextEditingController(text: parsed['feature'] ?? '');
      _benefitController = TextEditingController(text: parsed['benefit'] ?? '');
      _useTemplate = parsed['isTemplate'] ?? true;
    } else {
      _userController = TextEditingController();
      _featureController = TextEditingController();
      _benefitController = TextEditingController();
    }

    _priority = widget.story?.priority ?? StoryPriority.should;
    _classOfService = widget.story?.classOfService ?? ClassOfService.standard;
    _businessValue = widget.story?.businessValue ?? 5;
    _tags = List.from(widget.story?.tags ?? []);
    _acceptanceCriteria = List.from(widget.story?.acceptanceCriteria
            .map((text) => AcceptanceCriterion(text: text, completed: false))
            .toList() ??
        []);
    _assigneeEmail = widget.story?.assigneeEmail;
    _storyPoints = widget.story?.storyPoints;
  }

  Map<String, dynamic> _parseDescription(String description) {
    // Try to parse "As a [user], I want [feature] so that [benefit]"
    final regex = RegExp(
      r'As an? (.+?),?\s+I want (.+?),?\s+so that (.+)',
      caseSensitive: false,
    );
    final match = regex.firstMatch(description);

    if (match != null) {
      return {
        'user': match.group(1),
        'feature': match.group(2),
        'benefit': match.group(3),
        'isTemplate': true,
      };
    }

    return {
      'user': '',
      'feature': description,
      'benefit': '',
      'isTemplate': false,
    };
  }

  String _buildDescription() {
    if (!_useTemplate) {
      return _featureController.text.trim();
    }

    final user = _userController.text.trim();
    final feature = _featureController.text.trim();
    final benefit = _benefitController.text.trim();

    if (user.isEmpty && benefit.isEmpty) {
      return feature;
    }

    return 'As a $user, I want $feature so that $benefit';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _userController.dispose();
    _featureController.dispose();
    _benefitController.dispose();
    _tagController.dispose();
    _criteriaController.dispose();
    super.dispose();
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() => _tags.remove(tag));
  }

  void _addCriterion() {
    final text = _criteriaController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _acceptanceCriteria.add(AcceptanceCriterion(text: text, completed: false));
        _criteriaController.clear();
      });
    }
  }

  void _removeCriterion(int index) {
    setState(() => _acceptanceCriteria.removeAt(index));
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final story = UserStoryModel(
      id: widget.story?.id ?? '',
      projectId: widget.projectId,
      title: _titleController.text.trim(),
      description: _buildDescription(),
      priority: _priority,
      classOfService: _classOfService,
      businessValue: _businessValue,
      storyPoints: _storyPoints,
      status: widget.story?.status ?? StoryStatus.backlog,
      tags: _tags,
      acceptanceCriteria: _acceptanceCriteria.map((c) => c.text).toList(),
      order: widget.story?.order ?? 0,
      createdAt: widget.story?.createdAt ?? DateTime.now(),
      createdBy: widget.story?.createdBy ?? '',
      assigneeEmail: _assigneeEmail,
      sprintId: widget.story?.sprintId,
      estimates: widget.story?.estimates ?? {},
      finalEstimate: widget.story?.finalEstimate,
      isEstimated: _storyPoints != null, // Imposta true se ha story points
      startedAt: widget.story?.startedAt,
      completedAt: widget.story?.completedAt,
    );

    Navigator.pop(context, story);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit : Icons.add_circle,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(_isEditing ? l10n.agileEditStory : l10n.agileNewStory),
        ],
      ),
      content: SizedBox(
        width: 600,
        height: 500,
        child: Form(
          key: _formKey,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: l10n.agileDetailsTab),
                    Tab(text: l10n.agileAcceptanceCriteriaTab),
                    Tab(text: l10n.agileOtherTab),
                  ],
                  labelColor: AppColors.primary,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildDetailsTab(),
                      _buildAcceptanceCriteriaTab(),
                      _buildOtherTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.agileActionCancel),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(_isEditing ? l10n.agileActionSave : l10n.agileActionCreate),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: l10n.agileTitleLabel,
              hintText: l10n.agileTitleHint,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.formTitleRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Template toggle
          SwitchListTile(
            title: Text(l10n.agileUseStoryTemplate),
            subtitle: Text(l10n.agileStoryTemplateSubtitle),
            value: _useTemplate,
            onChanged: (value) => setState(() => _useTemplate = value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),

          // Description fields
          if (_useTemplate) ...[
            TextFormField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: l10n.agileAsA,
                hintText: l10n.agileAsAHint,
                border: const OutlineInputBorder(),
                prefixText: 'As a ',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _featureController,
              decoration: InputDecoration(
                labelText: l10n.agileIWant,
                hintText: l10n.agileIWantHint,
                border: const OutlineInputBorder(),
                prefixText: 'I want ',
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.formRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _benefitController,
              decoration: InputDecoration(
                labelText: l10n.agileSoThat,
                hintText: l10n.agileSoThatHint,
                border: const OutlineInputBorder(),
                prefixText: 'So that ',
              ),
            ),
          ] else ...[
            TextFormField(
              controller: _featureController,
              decoration: InputDecoration(
                labelText: l10n.agileDescriptionLabel,
                hintText: l10n.agileDescriptionHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.formRequired;
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAcceptanceCriteriaTab() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.agileAcceptanceCriteriaTab,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.agileDefineComplete,
            style: TextStyle(color: context.textSecondaryColor, fontSize: 12),
          ),
          const SizedBox(height: 12),

          // Input nuovo criterio
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _criteriaController,
                  decoration: InputDecoration(
                    hintText: l10n.agileAddCriterionHint,
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addCriterion(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addCriterion,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Lista criteri
          Expanded(
            child: _acceptanceCriteria.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.checklist, size: 48, color: context.textMutedColor),
                        const SizedBox(height: 8),
                        Text(
                          l10n.agileNoCriteria,
                          style: TextStyle(color: context.textSecondaryColor),
                        ),
                      ],
                    ),
                  )
                : ReorderableListView.builder(
                    itemCount: _acceptanceCriteria.length,
                    onReorder: (oldIndex, newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      setState(() {
                        final item = _acceptanceCriteria.removeAt(oldIndex);
                        _acceptanceCriteria.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      final criterion = _acceptanceCriteria[index];
                      return Card(
                        key: ValueKey('criterion_$index'),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(Icons.drag_handle, color: context.textMutedColor),
                          title: Text(criterion.text),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _removeCriterion(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Suggerimenti
          const SizedBox(height: 12),
          const SizedBox(height: 12),
          Text(
            l10n.agileSuggestions,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              'I dati vengono salvati correttamente',
              'L\'utente riceve una conferma',
              'Il form mostra errori di validazione',
              'La funzionalità è accessibile da mobile',
            ].map((suggestion) => ActionChip(
              label: Text(suggestion, style: const TextStyle(fontSize: 10)),
              onPressed: () {
                if (!_acceptanceCriteria.any((c) => c.text == suggestion)) {
                  setState(() {
                    _acceptanceCriteria.add(
                      AcceptanceCriterion(text: suggestion, completed: false),
                    );
                  });
                }
              },
              visualDensity: VisualDensity.compact,
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherTab() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority
          Text(l10n.agilePriorityMoscow, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: StoryPriority.values.map((priority) => ChoiceChip(
              label: Text(_getPriorityLabel(priority, l10n)),
              selected: _priority == priority,
              onSelected: (_) => setState(() => _priority = priority),
              avatar: Icon(priority.icon, size: 16),
              selectedColor: priority.color.withOpacity(0.2),
            )).toList(),
          ),
          const SizedBox(height: 16),

          // Class of Service (Kanban)
          Row(
            children: [
              Text('Class of Service', style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Tooltip(
                message: 'Categorizza il lavoro per tipo di urgenza/impatto business (Kanban)',
                child: Icon(Icons.info_outline, size: 16, color: context.textSecondaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ClassOfService.values.map((cos) => ChoiceChip(
              label: Text(cos.displayName),
              selected: _classOfService == cos,
              onSelected: (_) => setState(() => _classOfService = cos),
              avatar: Icon(cos.icon, size: 16),
              selectedColor: cos.color.withValues(alpha: 0.2),
              tooltip: cos.description,
            )).toList(),
          ),
          const SizedBox(height: 16),

          // Business Value
          Text(l10n.agileBusinessValue, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _businessValue.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: '$_businessValue',
                  onChanged: (value) => setState(() => _businessValue = value.toInt()),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _getBusinessValueColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_businessValue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getBusinessValueColor(),
                  ),
                ),
              ),
            ],
          ),
          Text(
            _getBusinessValueLabel(),
            style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
          ),
          const SizedBox(height: 24),

          // Story Points Estimation
          Row(
            children: [
              Text(l10n.agileEstimatedStoryPoints, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Tooltip(
                message: l10n.agileStoryPointsTooltip,
                child: Icon(Icons.info_outline, size: 16, color: context.textSecondaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: Text(l10n.agileNoPoints),
                selected: _storyPoints == null,
                onSelected: (selected) {
                  if (selected) setState(() => _storyPoints = null);
                },
              ),
              ...fibonacciValues.map((points) => ChoiceChip(
                    label: Text('$points'),
                    selected: _storyPoints == points,
                    onSelected: (selected) {
                      if (selected) setState(() => _storyPoints = points);
                    },
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    backgroundColor: context.surfaceVariantColor,
                  )),
            ],
          ),
          if (_storyPoints != null) ...[
            const SizedBox(height: 4),
            Text(
              _getStoryPointsDescription(_storyPoints!),
              style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
            ),
          ],
          const SizedBox(height: 24),

          // Tags
          Text(l10n.agileTags, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagController,
                  decoration: InputDecoration(
                    hintText: l10n.agileAddTagHint,
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _addTag(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _addTag,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _tags.map((tag) => Chip(
                label: Text(tag),
                onDeleted: () => _removeTag(tag),
              )).toList(),
            ),
          if (widget.existingTags.isNotEmpty) ...[
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Text(l10n.agileExistingTags, style: const TextStyle(fontSize: 12)),
            Wrap(
              spacing: 4,
              children: widget.existingTags
                  .where((t) => !_tags.contains(t))
                  .map((tag) => ActionChip(
                        label: Text(tag, style: const TextStyle(fontSize: 11)),
                        onPressed: () {
                          if (!_tags.contains(tag)) {
                            setState(() => _tags.add(tag));
                          }
                        },
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),

          // Assignee
          if (widget.teamMembers.isNotEmpty) ...[
            Text(l10n.agileAssignTo, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _assigneeEmail,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: l10n.agileSelectMemberHint,
              ),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text(l10n.agileUnassigned),
                ),
                ...widget.teamMembers.map((email) => DropdownMenuItem(
                  value: email,
                  child: Text(email),
                )),
              ],
              onChanged: (value) => setState(() => _assigneeEmail = value),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBusinessValueColor() {
    if (_businessValue >= 8) return Colors.green;
    if (_businessValue >= 5) return Colors.orange;
    return Colors.red;
  }

  String _getBusinessValueLabel() {
    final l10n = AppLocalizations.of(context)!;
    if (_businessValue >= 8) return l10n.agileBusinessValueHigh;
    if (_businessValue >= 5) return l10n.agileBusinessValueMedium;
    return l10n.agileBusinessValueLow;
  }

  String _getStoryPointsDescription(int points) {
    final l10n = AppLocalizations.of(context)!;
    if (points <= 2) return l10n.agilePointsComplexityVeryLow;
    if (points <= 5) return l10n.agilePointsComplexityLow;
    if (points <= 13) return l10n.agilePointsComplexityMedium;
    return l10n.agilePointsComplexityHigh;
  }

  String _getPriorityLabel(StoryPriority priority, AppLocalizations l10n) {
    switch (priority) {
      case StoryPriority.must:
        return l10n.agilePriorityMust;
      case StoryPriority.should:
        return l10n.agilePriorityShould;
      case StoryPriority.could:
        return l10n.agilePriorityCould;
      case StoryPriority.wont:
        return l10n.agilePriorityWont;
    }
  }
}

class AcceptanceCriterion {
  final String text;
  final bool completed;

  AcceptanceCriterion({required this.text, required this.completed});
}
