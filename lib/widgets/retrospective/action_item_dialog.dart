
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ActionItemDialog extends StatefulWidget {
  final ActionItem? item;
  final List<String> participants; // Emails for assignee suggestion
  final String currentUserEmail;
  final List<RetroItem> availableCards; // New: For linking
  final String? initialSourceRefId; // New: For drag & drop
  final RetroTemplate template; // New: For action type suggestion
  final List<RetroColumn> columns; // New: For column lookup

  const ActionItemDialog({
    Key? key,
    this.item,
    required this.participants,
    required this.currentUserEmail,
    this.availableCards = const [],
    this.initialSourceRefId,
    required this.template,
    required this.columns,
  }) : super(key: key);

  @override
  State<ActionItemDialog> createState() => _ActionItemDialogState();
}

class _ActionItemDialogState extends State<ActionItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _resourcesController = TextEditingController();
  final _monitoringController = TextEditingController();

  String? _assigneeEmail;
  DateTime? _dueDate;
  ActionPriority _priority = ActionPriority.medium;
  String? _selectedSourceRefId;
  ActionType? _actionType;
  String? _selectedSourceColumnId;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _descController.text = widget.item!.description;
      _resourcesController.text = widget.item!.resources ?? '';
      _monitoringController.text = widget.item!.monitoring ?? '';
      _assigneeEmail = widget.item!.assigneeEmail;
      _dueDate = widget.item!.dueDate;
      _priority = widget.item!.priority;
      _selectedSourceRefId = widget.item!.sourceRefId;
      _selectedSourceColumnId = widget.item!.sourceColumnId;
      _actionType = widget.item!.actionType;
    } else {
      _selectedSourceRefId = widget.initialSourceRefId;
      // Auto-suggest action type based on initial source card
      if (widget.initialSourceRefId != null) {
        _updateActionTypeSuggestion(widget.initialSourceRefId);
      }
    }
  }

  /// Aggiorna il tipo azione suggerito in base alla card sorgente selezionata
  void _updateActionTypeSuggestion(String? sourceRefId) {
    if (sourceRefId == null) {
      // No source card, no suggestion
      return;
    }
    try {
      final card = widget.availableCards.firstWhere((c) => c.id == sourceRefId);
      final suggestedType = suggestActionType(widget.template, card.columnId);
      if (suggestedType != null) {
        setState(() => _actionType = suggestedType);
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _descController.dispose();
    _resourcesController.dispose();
    _monitoringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.item == null ? l10n.retroNewActionItem : l10n.retroEditActionItem),
      content: SizedBox(
        width: MediaQuery.of(context).size.width > 650 ? 600 : double.maxFinite,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SMART Action Helper - shows guiding question when source card selected
                _buildSmartPromptHelper(l10n),

                // Description
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: l10n.retroActionWhatToDo,
                    hintText: _getSmartPlaceholder(l10n),
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 2,
                  validator: (val) => val == null || val.isEmpty ? l10n.formRequired : null,
                ),
                const SizedBox(height: 16),

                // Source Card Selection
                DropdownButtonFormField<String>(
                  value: _selectedSourceRefId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.retroActionLinkedCard,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.link),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  items: [
                    DropdownMenuItem(value: null, child: Text(l10n.retroActionNone)),
                    ...widget.availableCards.where((c) => c.content.isNotEmpty).map((card) {
                      final shortText = card.content.length > 50
                          ? '${card.content.substring(0, 50)}...'
                          : card.content;
                      return DropdownMenuItem(
                        value: card.id,
                        child: Text(shortText, overflow: TextOverflow.ellipsis),
                      );
                    }).toList()
                  ],
                  onChanged: (val) {
                    setState(() {
                      _selectedSourceRefId = val;
                      // Auto-select column when card is chosen
                      if (val != null) {
                        try {
                          final card = widget.availableCards.firstWhere((c) => c.id == val);
                          _selectedSourceColumnId = card.columnId;
                        } catch (_) {}
                      }
                    });
                    _updateActionTypeSuggestion(val);
                  },
                  selectedItemBuilder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return [
                       Text(l10n.retroActionNone),
                       ...widget.availableCards.where((c) => c.content.isNotEmpty).map((card) {
                         final shortText = card.content.length > 30
                             ? '${card.content.substring(0, 30)}...'
                             : card.content;
                         return Text(shortText, overflow: TextOverflow.ellipsis);
                       })
                    ];
                  },
                ),
                const SizedBox(height: 16),

                // Action Type Selection with suggested badge
                DropdownButtonFormField<ActionType>(
                  value: _actionType,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: l10n.retroActionType,
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(
                      _actionType?.icon ?? Icons.category_outlined,
                      color: _actionType?.color,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  items: [
                    DropdownMenuItem<ActionType>(value: null, child: Text(l10n.retroActionNoType)),
                    ...ActionType.values.map((type) => DropdownMenuItem(
                      value: type,
                      child: Row(
                        children: [
                          Icon(type.icon, color: type.color, size: 20),
                          const SizedBox(width: 8),
                          Expanded(child: Text(type.getLocalizedName(l10n), overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    )).toList()
                  ],
                  onChanged: (val) => setState(() => _actionType = val),
                  selectedItemBuilder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return [
                      Text(l10n.retroActionNoType),
                      ...ActionType.values.map((type) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(type.icon, color: type.color, size: 18),
                          const SizedBox(width: 6),
                          Flexible(child: Text(type.getLocalizedName(l10n), overflow: TextOverflow.ellipsis)),
                        ],
                      )).toList()
                    ];
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    // Assignee Dropdown
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: _assigneeEmail,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: l10n.retroActionAssignee,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person_outline),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                        items: [
                          DropdownMenuItem(value: null, child: Text(l10n.retroActionNoAssignee)),
                          ...widget.participants.map((email) => DropdownMenuItem(
                            value: email,
                            child: Text(email, overflow: TextOverflow.ellipsis), 
                          ))
                        ],
                        onChanged: (val) => setState(() => _assigneeEmail = val),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Priority
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<ActionPriority>(
                        value: _priority,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: l10n.retroActionPriority,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.flag_outlined),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                        items: ActionPriority.values.map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.displayName, overflow: TextOverflow.ellipsis),
                        )).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _priority = val);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Due Date
                InkWell(
                  onTap: _pickDate,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.retroActionDueDate,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      _dueDate == null
                          ? l10n.retroActionSelectDate
                          : '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}',
                      style: TextStyle(
                        color: _dueDate == null ? context.textMutedColor : context.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Resources
                TextFormField(
                  controller: _resourcesController,
                  decoration: InputDecoration(
                    labelText: l10n.retroActionSupportResources,
                    hintText: l10n.retroActionResourcesHint,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.build_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                // Monitoring
                TextFormField(
                  controller: _monitoringController,
                  decoration: InputDecoration(
                    labelText: l10n.retroActionMonitoring,
                    hintText: l10n.retroActionMonitoringHint,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.visibility_outlined),
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
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(widget.item == null ? l10n.actionCreate : l10n.actionSave),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      // Find content and columnId for selected card
      String? sourceContent;
      String? sourceColumnId;
      if (_selectedSourceRefId != null) {
        try {
          final card = widget.availableCards.firstWhere((c) => c.id == _selectedSourceRefId);
          sourceContent = card.content;
          sourceColumnId = card.columnId;
        } catch (_) {}
      }
      
      // Fallback to manual selection if no card-linked column found
      sourceColumnId ??= _selectedSourceColumnId;

      final newItem = ActionItem(
        id: widget.item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        description: _descController.text.trim(),
        ownerEmail: widget.currentUserEmail,
        assigneeEmail: _assigneeEmail,
        createdAt: widget.item?.createdAt ?? DateTime.now(),
        dueDate: _dueDate,
        priority: _priority,
        resources: _resourcesController.text.trim(),
        monitoring: _monitoringController.text.trim(),
        isCompleted: widget.item?.isCompleted ?? false,
        completedAt: widget.item?.completedAt,
        sourceRefId: _selectedSourceRefId,
        sourceRefContent: sourceContent ?? widget.item?.sourceRefContent,
        sourceColumnId: sourceColumnId ?? widget.item?.sourceColumnId,
        actionType: _actionType,
      );

      Navigator.pop(context, newItem);
    }
  }

  /// Gets the columnId of the selected source card
  String? _getSelectedColumnId() {
    if (_selectedSourceRefId == null) return null;
    try {
      final card = widget.availableCards.firstWhere((c) => c.id == _selectedSourceRefId);
      return card.columnId;
    } catch (_) {
      return null;
    }
  }

  /// Gets the SMART placeholder for the description field
  String _getSmartPlaceholder(AppLocalizations l10n) {
    final columnId = _getSelectedColumnId();
    if (columnId == null) return l10n.retroActionDescriptionHint;

    final smartPrompt = RetroMethodologyGuide.getSmartActionPrompt(l10n, widget.template, columnId);
    return smartPrompt.placeholderText;
  }

  /// Builds the SMART prompt helper card showing guiding question and example
  Widget _buildSmartPromptHelper(AppLocalizations l10n) {
    final columnId = _getSelectedColumnId();
    if (columnId == null) return const SizedBox.shrink();

    final smartPrompt = RetroMethodologyGuide.getSmartActionPrompt(l10n, widget.template, columnId);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 18),
              const SizedBox(width: 8),
              Text(
                'SMART Action',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            smartPrompt.guidingQuestion,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            smartPrompt.exampleAction,
            style: TextStyle(
              color: context.textMutedColor,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
