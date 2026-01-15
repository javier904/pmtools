import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

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
  late int _businessValue;
  late List<String> _tags;
  late List<AcceptanceCriterion> _acceptanceCriteria;
  String? _assigneeEmail;
  bool _useTemplate = true;

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
    _businessValue = widget.story?.businessValue ?? 5;
    _tags = List.from(widget.story?.tags ?? []);
    _acceptanceCriteria = List.from(widget.story?.acceptanceCriteria
            .map((text) => AcceptanceCriterion(text: text, completed: false))
            .toList() ??
        []);
    _assigneeEmail = widget.story?.assigneeEmail;
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
      businessValue: _businessValue,
      storyPoints: widget.story?.storyPoints,
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
      startedAt: widget.story?.startedAt,
      completedAt: widget.story?.completedAt,
    );

    Navigator.pop(context, story);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            _isEditing ? Icons.edit : Icons.add_circle,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(_isEditing ? 'Modifica Story' : 'Nuova User Story'),
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
                const TabBar(
                  tabs: [
                    Tab(text: 'Dettagli'),
                    Tab(text: 'Acceptance Criteria'),
                    Tab(text: 'Altro'),
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
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(_isEditing ? 'Salva' : 'Crea'),
        ),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Titolo',
              hintText: 'Breve descrizione della funzionalità',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Inserisci un titolo';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Template toggle
          SwitchListTile(
            title: const Text('Usa template User Story'),
            subtitle: const Text('As a... I want... So that...'),
            value: _useTemplate,
            onChanged: (value) => setState(() => _useTemplate = value),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8),

          // Description fields
          if (_useTemplate) ...[
            TextFormField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: 'As a...',
                hintText: 'utente, admin, cliente...',
                border: OutlineInputBorder(),
                prefixText: 'As a ',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _featureController,
              decoration: const InputDecoration(
                labelText: 'I want...',
                hintText: 'poter fare qualcosa...',
                border: OutlineInputBorder(),
                prefixText: 'I want ',
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Inserisci cosa vuole l\'utente';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _benefitController,
              decoration: const InputDecoration(
                labelText: 'So that...',
                hintText: 'ottenere un beneficio...',
                border: OutlineInputBorder(),
                prefixText: 'So that ',
              ),
            ),
          ] else ...[
            TextFormField(
              controller: _featureController,
              decoration: const InputDecoration(
                labelText: 'Descrizione',
                hintText: 'Descrizione libera della story',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Inserisci una descrizione';
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: 16),

          // Preview
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Anteprima:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _buildDescription().isNotEmpty
                      ? _buildDescription()
                      : '(descrizione vuota)',
                  style: TextStyle(
                    fontStyle: _buildDescription().isEmpty
                        ? FontStyle.italic
                        : FontStyle.normal,
                    color: _buildDescription().isEmpty ? context.textMutedColor : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptanceCriteriaTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acceptance Criteria',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Definisci quando la story può considerarsi completata',
            style: TextStyle(color: context.textSecondaryColor, fontSize: 12),
          ),
          const SizedBox(height: 12),

          // Input nuovo criterio
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _criteriaController,
                  decoration: const InputDecoration(
                    hintText: 'Aggiungi criterio di accettazione...',
                    border: OutlineInputBorder(),
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
                          'Nessun criterio definito',
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
          const Text(
            'Suggerimenti:',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority
          const Text('Priorità (MoSCoW)', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: StoryPriority.values.map((priority) => ChoiceChip(
              label: Text(priority.displayName),
              selected: _priority == priority,
              onSelected: (_) => setState(() => _priority = priority),
              avatar: Icon(priority.icon, size: 16),
              selectedColor: priority.color.withOpacity(0.2),
            )).toList(),
          ),
          const SizedBox(height: 16),

          // Business Value
          const Text('Business Value', style: TextStyle(fontWeight: FontWeight.w500)),
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
          const SizedBox(height: 16),

          // Tags
          const Text('Tags', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _tagController,
                  decoration: const InputDecoration(
                    hintText: 'Aggiungi tag...',
                    border: OutlineInputBorder(),
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
            const Text('Tag esistenti:', style: TextStyle(fontSize: 12)),
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
            const Text('Assegna a', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _assigneeEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Seleziona un membro del team',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Non assegnato'),
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
    if (_businessValue >= 8) return 'Alto valore di business';
    if (_businessValue >= 5) return 'Valore medio';
    return 'Basso valore di business';
  }
}

class AcceptanceCriterion {
  final String text;
  final bool completed;

  AcceptanceCriterion({required this.text, required this.completed});
}
