import 'package:flutter/material.dart';
import '../../models/agile_project_model.dart';
import '../../models/agile_enums.dart';
import '../../models/team_member_model.dart';
import '../../themes/app_theme.dart';
import 'methodology_guide_dialog.dart';
import '../../l10n/app_localizations.dart';

/// Result data from the project form dialog
class AgileProjectFormResult {
  final String name;
  final String description;
  final AgileFramework framework;
  final int sprintDurationDays;
  final int workingHoursPerDay;
  final String? productOwnerEmail;
  final String? scrumMasterEmail;
  final List<String> developmentTeamEmails;

  const AgileProjectFormResult({
    required this.name,
    required this.description,
    required this.framework,
    required this.sprintDurationDays,
    required this.workingHoursPerDay,
    this.productOwnerEmail,
    this.scrumMasterEmail,
    this.developmentTeamEmails = const [],
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'framework': framework,
    'sprintDurationDays': sprintDurationDays,
    'workingHoursPerDay': workingHoursPerDay,
    'productOwnerEmail': productOwnerEmail,
    'scrumMasterEmail': scrumMasterEmail,
    'developmentTeamEmails': developmentTeamEmails,
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
  List<String> _developmentTeamEmails = [];

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
    if (widget.project != null) {
      _productOwnerEmail = _validateRoleEmail(widget.project!.productOwnerEmail);
      _scrumMasterEmail = _validateRoleEmail(widget.project!.scrumMasterEmail);

      // Fallback: If metadata is missing (legacy projects), try to find role holders in participants
      if (_productOwnerEmail == null) {
        try {
          final po = widget.project!.participants.values.firstWhere((p) => 
            p.teamRole == TeamRole.productOwner || p.teamRole == TeamRole.serviceRequestManager);
          _productOwnerEmail = po.email;
        } catch (_) {}
      }
      
      if (_scrumMasterEmail == null) {
        try {
          final sm = widget.project!.participants.values.firstWhere((p) => 
            p.teamRole == TeamRole.scrumMaster || p.teamRole == TeamRole.serviceDeliveryManager);
          _scrumMasterEmail = sm.email;
        } catch (_) {}
      }

      // Populate Development Team from participants who are NOT PO or SM
      _developmentTeamEmails = widget.project!.participants.values
          .where((p) => 
              p.email != _productOwnerEmail && 
              p.email != _scrumMasterEmail)
          .map((p) => p.email)
          .toList();

    } else {
      _productOwnerEmail = null;
      _scrumMasterEmail = null;
      _developmentTeamEmails = [];
    }
  }

  String? _validateRoleEmail(String? email) {
    if (email == null) return null;
    final normalized = email.toLowerCase();
    
    // Check if we have a participant with this email (case-insensitive key check)
    if (widget.project!.participants.containsKey(normalized)) {
      // Return the ACTUAL email string from the participant model to ensure Dropdown match
      return widget.project!.participants[normalized]?.email;
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(isEditing ? l10n.agileEditProjectTitle : l10n.agileCreateProjectTitle),
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
                    decoration: InputDecoration(
                      labelText: l10n.agileProjectNameLabel,
                      hintText: l10n.agileProjectNameHint,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.folder),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.agileEnterProjectName;
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),

                // Descrizione
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: l10n.agileProjectDescLabel,
                      hintText: l10n.agileProjectDescHint,
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.description),
                    ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // Framework
                Row(
                  children: [
                    Text(
                      l10n.agileFrameworkLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => MethodologyGuideDialog.show(context, framework: _framework),
                      icon: const Icon(Icons.help_outline, size: 16),
                      label: Text(l10n.agileDiscoverDifferences),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildFrameworkSelector(),
                const SizedBox(height: 24),

                // Configurazione Sprint (Solo Scrum)
                if (_framework == AgileFramework.scrum) ...[
                  Text(
                    l10n.agileSprintConfig,
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
                          label: l10n.agileSprintDuration,
                          value: _sprintDurationDays,
                          min: 7,
                          max: 30,
                          onChanged: (v) => setState(() => _sprintDurationDays = v),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildNumberField(
                          label: l10n.agileHoursPerDay,
                          value: _workingHoursPerDay,
                          min: 4,
                          max: 12,
                          onChanged: (v) => setState(() => _workingHoursPerDay = v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Key Roles & Team
                Builder(
                  builder: (context) {
                    List<TeamMemberModel> participants;
                    if (widget.project != null) {
                      participants = widget.project!.participants.values.toList();
                    } else if (widget.creatorEmail != null && widget.creatorName != null) {
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
                      children: [
                        _buildKeyRolesSection(participants),
                        const SizedBox(height: 24),
                        _buildDevelopmentTeamCard(participants),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton.icon(
          onPressed: _submit,
          icon: Icon(isEditing ? Icons.save : Icons.add),
          label: Text(isEditing ? l10n.actionSave : l10n.actionCreate),
        ),
      ],
    );
  }

  Widget _buildFrameworkSelector() {
    // Check if project has activities (stories)
    final hasActivities = (widget.project?.backlogCount ?? 0) > 0;
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: AgileFramework.values.map((framework) {
          final isSelected = _framework == framework;
          final isHybrid = framework == AgileFramework.hybrid;
          final isDisabled = isHybrid || (hasActivities && !isSelected);
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Tooltip(
                // Show specific message if disabled due to activities
                message: (hasActivities && !isSelected) 
                    ? AppLocalizations.of(context).agileFrameworkLocked
                    : framework.detailedDescription,
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
                  onTap: isDisabled ? null : () => setState(() => _framework = framework),
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _getFrameworkColor(framework).withValues(alpha: 0.1)
                              : (isDisabled ? context.surfaceVariantColor.withValues(alpha: 0.5) : context.surfaceVariantColor),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? _getFrameworkColor(framework)
                                : context.borderColor.withValues(alpha: isDisabled ? 0.3 : 1.0),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Opacity(
                          opacity: isDisabled ? 0.5 : 1.0,
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
                      if (isHybrid)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              AppLocalizations.of(context).agileComingSoon,
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (hasActivities && !isSelected)
                         Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(Icons.lock, size: 14, color: context.textMutedColor),
                         ),
                    ],
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

  Widget _buildKeyRolesSection(List<TeamMemberModel> participants) {
    final l10n = AppLocalizations.of(context);

    // Determine labels and descriptions based on framework
    final isScrum = _framework == AgileFramework.scrum;
    
    final role1Label = isScrum ? l10n.agileRoleProductOwner : l10n.agileRoleSRM;
    final role1Desc = isScrum ? l10n.agileRoleProductOwnerDesc : l10n.agileRoleSRMDesc;
    final role1Color = isScrum ? const Color(0xFF7B1FA2) : Colors.teal; // Purple vs Teal
    
    final role2Label = isScrum ? l10n.agileRoleScrumMaster : l10n.agileRoleSDM;
    final role2Desc = isScrum ? l10n.agileRoleScrumMasterDesc : l10n.agileRoleSDMDesc;
    final role2Color = isScrum ? const Color(0xFF1976D2) : Colors.orange; // Blue vs Orange

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.agileKeyRoles,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: l10n.agileAssignRolesHint,
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Role 1: PO (Scrum) or SRM (Kanban)
        _buildRoleSelector(
          icon: Icons.account_circle,
          label: role1Label,
          color: role1Color,
          description: role1Desc,
          selectedEmail: _productOwnerEmail,
          participants: participants,
          onChanged: (email) => setState(() => _productOwnerEmail = email),
        ),
        const SizedBox(height: 12),

        // Role 2: SM (Scrum) or SDM (Kanban)
        _buildRoleSelector(
          icon: isScrum ? Icons.supervised_user_circle : Icons.timeline, 
          label: role2Label,
          color: role2Color,
          description: role2Desc,
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
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          // Role Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
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
                l10n.agileSelectParticipant,
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
                    l10n.agileUnassigned,
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
                        backgroundColor: color.withValues(alpha: 0.2),
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
                    l10n.agileAssignableLater,
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

  Widget _buildDevelopmentTeamCard(List<TeamMemberModel> participants) {
    final l10n = AppLocalizations.of(context);
    final teamMembers = _developmentTeamEmails
        .map((email) => participants.where((p) => p.email == email).firstOrNull)
        .whereType<TeamMemberModel>()
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.group, color: Colors.green, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agileRoleDevelopmentTeam,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      l10n.agileRoleDevelopmentTeamDesc,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _showAddTeamMemberDialog(participants),
                icon: const Icon(Icons.person_add, color: Colors.green),
                tooltip: l10n.agileAddToTeam,
              ),
            ],
          ),
          if (teamMembers.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teamMembers.map((member) => Container(
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.green.shade100,
                      child: Text(
                        member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            member.name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            member.email,
                            style: TextStyle(
                              fontSize: 11,
                              color: context.textMutedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, size: 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      splashRadius: 16,
                      color: context.textMutedColor,
                      onPressed: () {
                        setState(() {
                          _developmentTeamEmails.remove(member.email);
                        });
                      },
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddTeamMemberDialog(List<TeamMemberModel> participants) {
    final l10n = AppLocalizations.of(context);
    // Filter out already selected members and PO/SM
    final availableParticipants = participants.where((p) {
      return !_developmentTeamEmails.contains(p.email) &&
          p.email != _productOwnerEmail &&
          p.email != _scrumMasterEmail;
    }).toList();

    if (availableParticipants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.agileAllMembersAssigned),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.agileAddToTeam),
        content: SizedBox(
          width: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableParticipants.length,
            itemBuilder: (context, index) {
              final participant = availableParticipants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF388E3C).withValues(alpha: 0.2),
                  child: Text(
                    participant.name.isNotEmpty
                        ? participant.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                ),
                title: Text(participant.name),
                subtitle: Text(
                  participant.email,
                  style: TextStyle(fontSize: 12, color: context.textMutedColor),
                ),
                onTap: () {
                  setState(() {
                    _developmentTeamEmails.add(participant.email);
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
             onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.agileClose),
          ),
        ],
      ),
    );
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
