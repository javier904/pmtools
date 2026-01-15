import 'package:flutter/material.dart';
import '../../models/team_member_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget per visualizzare la matrice competenze del team
class SkillMatrixWidget extends StatelessWidget {
  final List<TeamMemberModel> teamMembers;
  final void Function(TeamMemberModel member, String skill)? onSkillTap;

  const SkillMatrixWidget({
    super.key,
    required this.teamMembers,
    this.onSkillTap,
  });

  @override
  Widget build(BuildContext context) {
    if (teamMembers.isEmpty) {
      return _buildEmptyState();
    }

    // Raccogli tutte le skill uniche
    final allSkills = <String>{};
    for (final member in teamMembers) {
      allSkills.addAll(member.skills);
    }
    final skillsList = allSkills.toList()..sort();

    if (skillsList.isEmpty) {
      return _buildNoSkillsState();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.grid_view, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Matrice Competenze',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Matrix
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Builder(
                builder: (context) => DataTable(
                  headingRowColor: WidgetStateProperty.all(context.surfaceVariantColor),
                columnSpacing: 16,
                columns: [
                  const DataColumn(
                    label: Text(
                      'Membro',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...skillsList.map((skill) => DataColumn(
                    label: RotatedBox(
                      quarterTurns: -1,
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )),
                ],
                rows: teamMembers.map((member) => DataRow(
                  cells: [
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: member.role.color.withOpacity(0.2),
                            child: Text(
                              (member.name ?? member.email)[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: member.role.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            member.name ?? member.email.split('@').first,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    ...skillsList.map((skill) => DataCell(
                      InkWell(
                        onTap: onSkillTap != null
                            ? () => onSkillTap!(member, skill)
                            : null,
                        child: Center(
                          child: member.skills.contains(skill)
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.circle_outlined,
                                  color: context.borderColor,
                                  size: 20,
                                ),
                        ),
                      ),
                    )),
                  ],
                )).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats
            _buildSkillStats(skillsList),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.group, size: 48, color: context.textMutedColor),
              const SizedBox(height: 16),
              Text(
                'Nessun membro nel team',
                style: TextStyle(color: context.textSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoSkillsState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 48, color: context.textMutedColor),
              const SizedBox(height: 16),
              Text(
                'Nessuna competenza definita',
                style: TextStyle(color: context.textSecondaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Aggiungi competenze ai membri del team',
                style: TextStyle(fontSize: 12, color: context.textTertiaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillStats(List<String> skillsList) {
    // Calcola copertura per ogni skill
    final skillCoverage = <String, int>{};
    for (final skill in skillsList) {
      skillCoverage[skill] = teamMembers.where((m) => m.skills.contains(skill)).length;
    }

    // Trova skill critiche (copertura < 2)
    final criticalSkills = skillCoverage.entries
        .where((e) => e.value < 2)
        .map((e) => e.key)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coverage summary
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skillsList.map((skill) {
            final coverage = skillCoverage[skill] ?? 0;
            final isCritical = coverage < 2;
            return Chip(
              avatar: CircleAvatar(
                radius: 10,
                backgroundColor: isCritical ? Colors.red : Colors.green,
                child: Text(
                  '$coverage',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              label: Builder(
                builder: (context) => Text(
                  skill,
                  style: TextStyle(
                    fontSize: 11,
                    color: isCritical ? Colors.red : null,
                  ),
                ),
              ),
              backgroundColor: isCritical
                  ? Colors.red.withOpacity(0.1)
                  : null,
            );
          }).toList(),
        ),

        // Critical skills alert
        if (criticalSkills.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Competenze critiche',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Solo 1 persona copre: ${criticalSkills.join(", ")}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Widget compatto per skill di un singolo membro
class MemberSkillsWidget extends StatelessWidget {
  final TeamMemberModel member;
  final List<String>? allTeamSkills;
  final void Function(String skill)? onAddSkill;
  final void Function(String skill)? onRemoveSkill;

  const MemberSkillsWidget({
    super.key,
    required this.member,
    this.allTeamSkills,
    this.onAddSkill,
    this.onRemoveSkill,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Competenze',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          if (member.skills.isEmpty)
            Text(
              'Nessuna competenza',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: context.textSecondaryColor,
              ),
            )
          else
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: member.skills.map((skill) => Chip(
              label: Text(skill, style: const TextStyle(fontSize: 12)),
              deleteIcon: onRemoveSkill != null
                  ? const Icon(Icons.close, size: 16)
                  : null,
              onDeleted: onRemoveSkill != null
                  ? () => onRemoveSkill!(skill)
                  : null,
              backgroundColor: AppColors.primary.withOpacity(0.1),
            )).toList(),
          ),
          if (onAddSkill != null && allTeamSkills != null) ...[
            const SizedBox(height: 8),
            _buildAddSkillButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildAddSkillButton(BuildContext context) {
    final availableSkills = (allTeamSkills ?? [])
        .where((s) => !member.skills.contains(s))
        .toList();

    return PopupMenuButton<String>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              'Aggiungi competenza',
              style: TextStyle(fontSize: 12, color: AppColors.primary),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        if (availableSkills.isEmpty) {
          return [
            const PopupMenuItem(
              enabled: false,
              child: Text('Nessuna skill disponibile'),
            ),
            PopupMenuItem(
              value: '__new__',
              child: Row(
                children: [
                  const Icon(Icons.add, size: 16),
                  const SizedBox(width: 8),
                  const Text('Nuova competenza...'),
                ],
              ),
            ),
          ];
        }
        return [
          ...availableSkills.map((skill) => PopupMenuItem(
            value: skill,
            child: Text(skill),
          )),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: '__new__',
            child: Row(
              children: [
                const Icon(Icons.add, size: 16),
                const SizedBox(width: 8),
                const Text('Nuova competenza...'),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) async {
        if (value == '__new__') {
          final newSkill = await _showNewSkillDialog(context);
          if (newSkill != null && newSkill.isNotEmpty) {
            onAddSkill?.call(newSkill);
          }
        } else {
          onAddSkill?.call(value);
        }
      },
    );
  }

  Future<String?> _showNewSkillDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuova Competenza'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Nome competenza',
            hintText: 'Es: Flutter, Python, AWS...',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }
}

/// Widget radar chart per skill coverage (opzionale, più visivo)
class SkillRadarWidget extends StatelessWidget {
  final Map<String, int> skillCoverage; // skill -> numero persone
  final int teamSize;

  const SkillRadarWidget({
    super.key,
    required this.skillCoverage,
    required this.teamSize,
  });

  @override
  Widget build(BuildContext context) {
    if (skillCoverage.isEmpty) {
      return const SizedBox.shrink();
    }

    final skills = skillCoverage.keys.toList();
    final maxCoverage = teamSize > 0 ? teamSize : 1;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.radar, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  'Copertura Competenze',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Simplified bar representation instead of radar
            ...skills.map((skill) {
              final coverage = skillCoverage[skill] ?? 0;
              final percent = coverage / maxCoverage;
              final isCritical = coverage < 2;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Builder(
                  builder: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            skill,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isCritical ? FontWeight.bold : null,
                              color: isCritical ? Colors.red : null,
                            ),
                          ),
                          Text(
                            '$coverage/$teamSize',
                            style: TextStyle(
                              fontSize: 12,
                              color: isCritical ? Colors.red : context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor: context.borderColor,
                          valueColor: AlwaysStoppedAnimation(
                            isCritical ? Colors.red : AppColors.primary,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
