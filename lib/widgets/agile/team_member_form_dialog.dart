import 'package:flutter/material.dart';
import '../../models/team_member_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Dialog per modificare un membro del team
///
/// Permette di modificare:
/// - Nome
/// - Ruolo progetto
/// - Ruolo team
/// - Capacity (ore/giorno)
/// - Skills
class TeamMemberFormDialog extends StatefulWidget {
  final TeamMemberModel member;
  final bool canChangeProjectRole;

  const TeamMemberFormDialog({
    super.key,
    required this.member,
    this.canChangeProjectRole = true,
  });

  static Future<TeamMemberModel?> show({
    required BuildContext context,
    required TeamMemberModel member,
    bool canChangeProjectRole = true,
  }) {
    return showDialog<TeamMemberModel>(
      context: context,
      builder: (context) => TeamMemberFormDialog(
        member: member,
        canChangeProjectRole: canChangeProjectRole,
      ),
    );
  }

  @override
  State<TeamMemberFormDialog> createState() => _TeamMemberFormDialogState();
}

class _TeamMemberFormDialogState extends State<TeamMemberFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _skillController;
  late AgileParticipantRole _participantRole;
  late TeamRole _teamRole;
  late int _capacityHoursPerDay;
  late List<String> _skills;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member.name);
    _skillController = TextEditingController();
    _participantRole = widget.member.participantRole;
    _teamRole = widget.member.teamRole;
    _capacityHoursPerDay = widget.member.capacityHoursPerDay;
    _skills = List.from(widget.member.skills);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !_skills.contains(skill)) {
      setState(() {
        _skills.add(skill);
        _skillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _skills.remove(skill);
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updatedMember = widget.member.copyWith(
      name: _nameController.text.trim(),
      participantRole: _participantRole,
      teamRole: _teamRole,
      capacityHoursPerDay: _capacityHoursPerDay,
      skills: _skills,
    );

    Navigator.pop(context, updatedMember);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.person_outline, color: _teamRole.color),
          const SizedBox(width: 8),
          const Text('Modifica Membro'),
        ],
      ),
      content: SizedBox(
        width: 450,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email (non modificabile)
                Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.email, size: 18, color: context.textMutedColor),
                        const SizedBox(width: 8),
                        Text(
                          widget.member.email,
                          style: TextStyle(color: context.textSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Ruolo Progetto
                if (widget.canChangeProjectRole) ...[
                  const Text(
                    'Ruolo nel Progetto',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: AgileParticipantRole.values
                        .where((r) => r != AgileParticipantRole.owner) // Owner non modificabile
                        .map((role) => ChoiceChip(
                              label: Text(role.displayName),
                              selected: _participantRole == role,
                              onSelected: (_) => setState(() => _participantRole = role),
                              avatar: Icon(role.icon, size: 16),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Ruolo Team
                const Text(
                  'Ruolo nel Team',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: TeamRole.values.map((role) => ChoiceChip(
                    label: Text(role.displayName),
                    selected: _teamRole == role,
                    onSelected: (_) => setState(() => _teamRole = role),
                    avatar: Icon(role.icon, size: 16),
                    selectedColor: role.color.withOpacity(0.2),
                  )).toList(),
                ),
                const SizedBox(height: 16),

                // Capacity
                const Text(
                  'Capacity (ore/giorno)',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _capacityHoursPerDay.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        label: '$_capacityHoursPerDay ore',
                        onChanged: (value) => setState(() => _capacityHoursPerDay = value.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$_capacityHoursPerDay h',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) => Text(
                    _getCapacityHint(),
                    style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                  ),
                ),
                const SizedBox(height: 16),

                // Skills
                const Text(
                  'Skills',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _skillController,
                        decoration: const InputDecoration(
                          hintText: 'Aggiungi skill...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onSubmitted: (_) => _addSkill(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _addSkill,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_skills.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _skills.map((skill) => Chip(
                      label: Text(skill),
                      onDeleted: () => _removeSkill(skill),
                      deleteIcon: const Icon(Icons.close, size: 16),
                    )).toList(),
                  )
                else
                  Builder(
                    builder: (context) => Text(
                      'Nessuna skill aggiunta',
                      style: TextStyle(color: context.textTertiaryColor, fontSize: 12),
                    ),
                  ),

                // Suggerimenti skills
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: _getSuggestedSkills().map((skill) => ActionChip(
                    label: Text(skill, style: const TextStyle(fontSize: 11)),
                    onPressed: () {
                      if (!_skills.contains(skill)) {
                        setState(() => _skills.add(skill));
                      }
                    },
                    avatar: const Icon(Icons.add, size: 14),
                    visualDensity: VisualDensity.compact,
                  )).toList(),
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
          child: const Text('Salva'),
        ),
      ],
    );
  }

  String _getCapacityHint() {
    if (_capacityHoursPerDay < 4) {
      return 'Part-time ridotto';
    } else if (_capacityHoursPerDay < 6) {
      return 'Part-time';
    } else if (_capacityHoursPerDay <= 8) {
      return 'Full-time standard';
    } else {
      return 'Overtime';
    }
  }

  List<String> _getSuggestedSkills() {
    // Suggerimenti basati sul ruolo
    switch (_teamRole) {
      case TeamRole.productOwner:
        return ['Product Management', 'Stakeholder Management', 'Backlog Grooming', 'User Research'];
      case TeamRole.scrumMaster:
        return ['Facilitation', 'Coaching', 'Agile', 'Scrum', 'Kanban'];
      case TeamRole.developer:
        return ['Flutter', 'Dart', 'Firebase', 'REST API', 'Git', 'Testing'];
      case TeamRole.designer:
        return ['UI Design', 'UX Research', 'Figma', 'Prototyping', 'User Testing'];
      case TeamRole.qa:
        return ['Manual Testing', 'Automation', 'Test Planning', 'Bug Tracking'];
      case TeamRole.stakeholder:
        return ['Business Analysis', 'Requirements', 'Domain Expert'];
    }
  }
}

/// Dialog per aggiungere un nuovo membro (senza invito)
class AddTeamMemberDialog extends StatefulWidget {
  const AddTeamMemberDialog({super.key});

  static Future<TeamMemberModel?> show(BuildContext context) {
    return showDialog<TeamMemberModel>(
      context: context,
      builder: (context) => const AddTeamMemberDialog(),
    );
  }

  @override
  State<AddTeamMemberDialog> createState() => _AddTeamMemberDialogState();
}

class _AddTeamMemberDialogState extends State<AddTeamMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  AgileParticipantRole _participantRole = AgileParticipantRole.member;
  TeamRole _teamRole = TeamRole.developer;
  int _capacityHoursPerDay = 8;

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final member = TeamMemberModel(
      email: _emailController.text.trim().toLowerCase(),
      name: _nameController.text.trim(),
      participantRole: _participantRole,
      teamRole: _teamRole,
      capacityHoursPerDay: _capacityHoursPerDay,
      joinedAt: DateTime.now(),
      isOnline: false,
    );

    Navigator.pop(context, member);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.person_add, color: Colors.purple),
          SizedBox(width: 8),
          Text('Aggiungi Membro'),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un\'email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Email non valida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci un nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Ruolo Progetto
                const Text('Ruolo Progetto', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [AgileParticipantRole.member, AgileParticipantRole.admin, AgileParticipantRole.viewer]
                      .map((role) => ChoiceChip(
                            label: Text(role.displayName),
                            selected: _participantRole == role,
                            onSelected: (_) => setState(() => _participantRole = role),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Ruolo Team
                const Text('Ruolo Team', style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: TeamRole.values.map((role) => ChoiceChip(
                    label: Text(role.displayName),
                    selected: _teamRole == role,
                    onSelected: (_) => setState(() => _teamRole = role),
                  )).toList(),
                ),
                const SizedBox(height: 16),

                // Capacity
                Row(
                  children: [
                    const Text('Capacity: '),
                    Expanded(
                      child: Slider(
                        value: _capacityHoursPerDay.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        label: '$_capacityHoursPerDay ore/giorno',
                        onChanged: (value) => setState(() => _capacityHoursPerDay = value.toInt()),
                      ),
                    ),
                    Text('$_capacityHoursPerDay h', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
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
          child: const Text('Aggiungi'),
        ),
      ],
    );
  }
}
