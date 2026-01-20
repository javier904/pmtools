import 'package:flutter/material.dart';
import '../../models/agile_project_model.dart';
import '../../models/agile_enums.dart';
import '../../models/team_member_model.dart';
import '../../themes/app_theme.dart';
import 'methodology_guide_dialog.dart';

/// Result data from the project form dialog
class AgileProjectFormResult {
  final String name;
  final String description;
  final AgileFramework framework;
  final int sprintDurationDays;
  final int workingHoursPerDay;
  final String? productOwnerEmail;
  final String? scrumMasterEmail;

  const AgileProjectFormResult({
    required this.name,
    required this.description,
    required this.framework,
    required this.sprintDurationDays,
    required this.workingHoursPerDay,
    this.productOwnerEmail,
    this.scrumMasterEmail,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'framework': framework,
    'sprintDurationDays': sprintDurationDays,
    'workingHoursPerDay': workingHoursPerDay,
    'productOwnerEmail': productOwnerEmail,
    'scrumMasterEmail': scrumMasterEmail,
  };
}

/// Reusable dialog for creating/editing an Agile project
///
/// Can be used standalone or embedded in other dialogs.
/// Returns [AgileProjectFormResult] on successful submission.
class AgileProjectFormDialog extends StatefulWidget {
  final AgileProjectModel? project;
  final String? creatorEmail;
  final String? creatorName;
  final String? suggestedName;

  const AgileProjectFormDialog({
    super.key,
    this.project,
    this.creatorEmail,
    this.creatorName,
    this.suggestedName,
  });

  /// Shows the dialog and returns the result
  static Future<AgileProjectFormResult?> show(
    BuildContext context, {
    AgileProjectModel? project,
    String? creatorEmail,
    String? creatorName,
    String? suggestedName,
  }) {
    return showDialog<AgileProjectFormResult>(
      context: context,
      builder: (context) => AgileProjectFormDialog(
        project: project,
        creatorEmail: creatorEmail,
        creatorName: creatorName,
        suggestedName: suggestedName,
      ),
    );
  }

  @override
  State<AgileProjectFormDialog> createState() => _AgileProjectFormDialogState();
}

class _AgileProjectFormDialogState extends State<AgileProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late AgileFramework _framework;
  late int _sprintDurationDays;
  late int _workingHoursPerDay;

  // Key Roles
  String? _productOwnerEmail;
  String? _scrumMasterEmail;

  bool get isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.project?.name ?? widget.suggestedName ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.project?.description ?? '',
    );
    _framework = widget.project?.framework ?? AgileFramework.scrum;
    _sprintDurationDays = widget.project?.sprintDurationDays ?? 14;
    _workingHoursPerDay = widget.project?.workingHoursPerDay ?? 8;
    _productOwnerEmail = widget.project?.productOwnerEmail;
    _scrumMasterEmail = widget.project?.scrumMasterEmail;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Modifica Progetto' : 'Nuovo Progetto Agile'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Progetto *',
                    hintText: 'Es: Fashion PMO v2',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.folder),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci il nome del progetto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Descrizione
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrizione',
                    hintText: 'Descrizione opzionale del progetto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // Framework
                Row(
                  children: [
                    Text(
                      'Framework Agile',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => MethodologyGuideDialog.show(context, framework: _framework),
                      icon: const Icon(Icons.help_outline, size: 16),
                      label: const Text('Scopri le differenze'),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildFrameworkSelector(),
                const SizedBox(height: 24),

                // Configurazione Sprint
                Text(
                  'Configurazione Sprint',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: context.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        label: 'Durata Sprint (giorni)',
                        value: _sprintDurationDays,
                        min: 7,
                        max: 30,
                        onChanged: (v) => setState(() => _sprintDurationDays = v),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildNumberField(
                        label: 'Ore/Giorno',
                        value: _workingHoursPerDay,
                        min: 4,
                        max: 12,
                        onChanged: (v) => setState(() => _workingHoursPerDay = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Key Roles Section
                _buildKeyRolesSection(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        ElevatedButton.icon(
          onPressed: _submit,
          icon: Icon(isEditing ? Icons.save : Icons.add),
          label: Text(isEditing ? 'Salva' : 'Crea'),
        ),
      ],
    );
  }

  Widget _buildFrameworkSelector() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: AgileFramework.values.map((framework) {
          final isSelected = _framework == framework;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Tooltip(
                message: framework.detailedDescription,
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  height: 1.4,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.isDarkMode ? context.surfaceColor : Colors.grey[850],
                  borderRadius: BorderRadius.circular(8),
                ),
                waitDuration: const Duration(milliseconds: 500),
                child: InkWell(
                  onTap: () => setState(() => _framework = framework),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _getFrameworkColor(framework).withOpacity(0.1)
                          : context.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? _getFrameworkColor(framework)
                            : context.borderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          framework.icon,
                          color: isSelected
                              ? _getFrameworkColor(framework)
                              : context.textSecondaryColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          framework.displayName,
                          style: TextStyle(
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? _getFrameworkColor(framework)
                                : context.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          framework.description,
                          style: TextStyle(
                            fontSize: 10,
                            color: context.textTertiaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: value > min ? () => onChanged(value - 1) : null,
                iconSize: 18,
              ),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: value < max ? () => onChanged(value + 1) : null,
                iconSize: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyRolesSection() {
    // Get participants for dropdown
    List<TeamMemberModel> participants;

    if (widget.project != null) {
      // Editing existing project - use actual participants
      participants = widget.project!.participants.values.toList();
    } else if (widget.creatorEmail != null && widget.creatorName != null) {
      // Creating new project - allow creator to assign themselves
      participants = [
        TeamMemberModel(
          email: widget.creatorEmail!,
          name: widget.creatorName!,
          participantRole: AgileParticipantRole.owner,
          teamRole: TeamRole.productOwner,
          joinedAt: DateTime.now(),
        ),
      ];
    } else {
      participants = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ruoli Chiave',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Assegna i ruoli principali del team.\nPotrai modificarli anche dalle impostazioni del progetto.',
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Product Owner
        _buildRoleSelector(
          icon: Icons.account_circle,
          label: 'Product Owner',
          color: const Color(0xFF7B1FA2),
          description: 'Gestisce il backlog e le priorita',
          selectedEmail: _productOwnerEmail,
          participants: participants,
          onChanged: (email) => setState(() => _productOwnerEmail = email),
        ),
        const SizedBox(height: 12),

        // Scrum Master
        _buildRoleSelector(
          icon: Icons.supervised_user_circle,
          label: 'Scrum Master',
          color: const Color(0xFF1976D2),
          description: 'Facilita il processo e rimuove ostacoli',
          selectedEmail: _scrumMasterEmail,
          participants: participants,
          onChanged: (email) => setState(() => _scrumMasterEmail = email),
        ),
      ],
    );
  }

  Widget _buildRoleSelector({
    required IconData icon,
    required String label,
    required Color color,
    required String description,
    required String? selectedEmail,
    required List<TeamMemberModel> participants,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Role Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),

          // Role Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.textMutedColor,
                  ),
                ),
              ],
            ),
          ),

          // Selector
          if (participants.isNotEmpty)
            // Dropdown for existing project
            DropdownButton<String?>(
              value: selectedEmail,
              hint: Text(
                'Seleziona',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textMutedColor,
                ),
              ),
              underline: const SizedBox(),
              icon: Icon(Icons.arrow_drop_down, color: color),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(
                    'Non assegnato',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textMutedColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                ...participants.map((p) => DropdownMenuItem<String?>(
                  value: p.email,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: color.withOpacity(0.2),
                        child: Text(
                          p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        p.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                )),
              ],
              onChanged: onChanged,
            )
          else
            // Info for new project
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: context.textMutedColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Assegnabile dopo la creazione',
                    style: TextStyle(
                      fontSize: 11,
                      color: context.textMutedColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getFrameworkColor(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return Colors.blue;
      case AgileFramework.kanban:
        return Colors.teal;
      case AgileFramework.hybrid:
        return Colors.purple;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(AgileProjectFormResult(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        framework: _framework,
        sprintDurationDays: _sprintDurationDays,
        workingHoursPerDay: _workingHoursPerDay,
        productOwnerEmail: _productOwnerEmail,
        scrumMasterEmail: _scrumMasterEmail,
      ));
    }
  }
}
