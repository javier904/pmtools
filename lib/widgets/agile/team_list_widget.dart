import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../models/team_member_model.dart';
import '../../models/agile_enums.dart';
import '../common/avatar_widget.dart';
import '../user_display_name_widget.dart';

/// Widget per visualizzare la lista dei membri del team
///
/// Mostra:
/// - Avatar e nome
/// - Ruolo progetto e team
/// - Capacity
/// - Skills
/// - Status online
class TeamListWidget extends StatelessWidget {
  final Map<String, TeamMemberModel> participants;
  final String currentUserEmail;
  final bool isOwnerOrAdmin;
  final void Function(TeamMemberModel)? onEdit;
  final void Function(String email)? onRemove;
  final VoidCallback? onInvite;
  final AgileFramework framework;

  const TeamListWidget({
    super.key,
    required this.participants,
    required this.currentUserEmail,
    this.isOwnerOrAdmin = false,
    this.onEdit,
    this.onRemove,
    this.onInvite,
    required this.framework,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final members = participants.values.toList()
      ..sort((a, b) {
        // Ordina per ruolo (owner prima, poi admin, poi member, poi viewer)
        final roleOrder = a.role.index.compareTo(b.role.index);
        if (roleOrder != 0) return roleOrder;
        // Poi per nome
        return a.name.compareTo(b.name);
      });

    // Grid responsive
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.agileTeamTitle(members.length),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isOwnerOrAdmin && onInvite != null)
                ElevatedButton.icon(
                  onPressed: onInvite,
                  icon: const Icon(Icons.person_add, size: 18),
                  label: Text(l10n.agileActionInvite),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        const Divider(),

        // Lista membri
        if (members.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                l10n.agileNoMembers,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              // Calcola numero di colonne in base alla larghezza disponibile
              // Minima larghezza card: 300px
              final crossAxisCount = (constraints.maxWidth / 320).floor().clamp(1, 4);
              final aspectRatio = crossAxisCount == 1 ? 3.5 : 2.5; // Card più basse se in griglia

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: members.length,
                itemBuilder: (context, index) => _buildMemberCard(
                  context,
                  members[index],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildMemberCard(BuildContext context, TeamMemberModel member) {
    final l10n = AppLocalizations.of(context)!;
    final isCurrentUser = member.email.toLowerCase() == currentUserEmail.toLowerCase();
    final canEdit = isOwnerOrAdmin && !isCurrentUser;
    // Solo l'owner può rimuovere, o admin se non è owner
    final canRemove = isOwnerOrAdmin && !isCurrentUser && member.role != AgileParticipantRole.owner;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: canEdit && onEdit != null ? () => onEdit!(member) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Avatar, Name, Edit Actions
              Row(
                children: [
                  Stack(
                    children: [
                      AvatarWidget(
                        imageUrl: null,
                        name: member.name,
                        email: member.email,
                        radius: 20,
                      ),
                      if (member.isOnline)
                         Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: UserDisplayName(
                                email: member.email,
                                fallback: member.name,
                                style: TextStyle(
                                  fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (isCurrentUser) ...[
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  l10n.agileYouBadge,
                                  style: const TextStyle(fontSize: 9, color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          member.email, // Email or username
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Actions (Edit/Remove buttons removed to keep clean, tap to edit is implied or we can add a menu)
                   if (canEdit && onEdit != null)
                     IconButton(
                        icon: const Icon(Icons.edit, size: 16, color: Colors.grey),
                        onPressed: () => onEdit!(member),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Edit',
                     ),
                ],
              ),
              const Spacer(),
              // Role Badge & Capacity
              Row(
                children: [
                   _buildBadge(
                      member.teamRole.getDisplayName(framework),
                      member.teamRole.color,
                      member.teamRole.icon,
                    ),
                   if (member.participantRole == AgileParticipantRole.owner) ...[
                      const SizedBox(width: 8),
                      Tooltip(
                          message: 'Project Owner',
                          child: Icon(Icons.star, size: 14, color: Colors.amber[700]),
                      ),
                   ],
                   const Spacer(),
                   if (member.capacityHoursPerDay != 8)
                     Row(
                        children: [
                           Icon(Icons.schedule, size: 12, color: Colors.grey[600]),
                           const SizedBox(width: 4),
                           Text(
                              '${member.capacityHoursPerDay}h',
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                           ),
                        ],
                     ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// Card riepilogativa del team per la dashboard
class TeamSummaryCard extends StatelessWidget {
  final Map<String, TeamMemberModel> participants;
  final VoidCallback? onTap;

  const TeamSummaryCard({
    super.key,
    required this.participants,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final members = participants.values.toList();
    final onlineCount = members.where((m) => m.isOnline).length;
    final totalCapacity = members.fold<int>(0, (sum, m) => sum + m.capacityHoursPerDay);

    // Raggruppa per ruolo team
    final roleGroups = <TeamRole, int>{};
    for (final member in members) {
      roleGroups[member.teamRole] = (roleGroups[member.teamRole] ?? 0) + 1;
    }

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.groups, color: Colors.purple),
                  const SizedBox(width: 8),
                  const Text(
                    'Team',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${members.length} membri',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Stats
              Row(
                children: [
                  _buildStat(Icons.circle, '$onlineCount online', Colors.green),
                  const SizedBox(width: 16),
                  _buildStat(Icons.schedule, '${totalCapacity}h/day', Colors.blue),
                ],
              ),
              const SizedBox(height: 12),

              // Role breakdown
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: roleGroups.entries.map((e) => Chip(
                  avatar: Icon(e.key.icon, size: 14, color: e.key.color),
                  label: Text('${e.value}', style: const TextStyle(fontSize: 12)),
                  backgroundColor: e.key.color.withOpacity(0.1),
                  visualDensity: VisualDensity.compact,
                )).toList(),
              ),

              // Avatar stack
              if (members.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 32,
                  child: Stack(
                    children: [
                      for (int i = 0; i < members.take(5).length; i++)
                        Positioned(
                          left: i * 24.0,
                          child: AvatarWidget(
                            imageUrl: null,
                            name: members[i].name,
                            email: members[i].email,
                            radius: 16,
                          ),
                        ),
                      if (members.length > 5)
                        Positioned(
                          left: 5 * 24.0,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey[300],
                            child: Text(
                              '+${members.length - 5}',
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}
