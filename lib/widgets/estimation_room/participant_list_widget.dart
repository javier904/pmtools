import 'package:flutter/material.dart';
import '../../models/planning_poker_participant_model.dart';
import '../../models/planning_poker_story_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget che mostra la lista dei partecipanti con il loro stato
class ParticipantListWidget extends StatelessWidget {
  final List<PlanningPokerParticipantModel> participants;
  final PlanningPokerStoryModel? currentStory;
  final String currentUserEmail;

  const ParticipantListWidget({
    super.key,
    required this.participants,
    this.currentStory,
    required this.currentUserEmail,
  });

  @override
  Widget build(BuildContext context) {
    // Separa per ruolo
    final facilitators = participants.where((p) => p.isFacilitator).toList();
    final voters = participants.where((p) => p.role == ParticipantRole.voter).toList();
    final observers = participants.where((p) => p.isObserver).toList();

    final votedCount = currentStory != null
        ? participants.where((p) => p.canVote && currentStory!.hasUserVoted(p.email)).length
        : 0;
    final totalVoters = participants.where((p) => p.canVote).length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: context.surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.people, size: 22, color: AppColors.secondary),
              const SizedBox(width: 10),
              Text(
                'Partecipanti (${participants.length})',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: context.textPrimaryColor,
                ),
              ),
              const Spacer(),
              if (currentStory != null && currentStory!.isVoting)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: votedCount == totalVoters ? AppColors.success : AppColors.warning,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$votedCount/$totalVoters',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Lista partecipanti raggruppati
          if (facilitators.isNotEmpty) ...[
            _buildRoleHeader('Facilitatore', Icons.star, AppColors.warning),
            const SizedBox(height: 4),
            ...facilitators.map((p) => _buildParticipantTile(context, p)),
          ],
          if (voters.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildRoleHeader('Votanti', Icons.how_to_vote, AppColors.secondary),
            const SizedBox(height: 4),
            ...voters.map((p) => _buildParticipantTile(context, p)),
          ],
          if (observers.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildRoleHeader('Osservatori', Icons.visibility, AppColors.q4Color),
            const SizedBox(height: 4),
            ...observers.map((p) => _buildParticipantTile(context, p)),
          ],
        ],
      ),
    );
  }

  Widget _buildRoleHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantTile(BuildContext context, PlanningPokerParticipantModel participant) {
    final isCurrentUser = participant.email == currentUserEmail;
    final hasVoted = currentStory?.hasUserVoted(participant.email) ?? false;
    final isVoting = currentStory?.isVoting ?? false;

    Color? statusColor;
    IconData? statusIcon;

    if (isVoting && participant.canVote) {
      if (hasVoted) {
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
      } else {
        statusColor = AppColors.warning;
        statusIcon = Icons.hourglass_empty;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.secondary.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isCurrentUser
            ? Border.all(color: AppColors.secondary.withOpacity(0.2))
            : null,
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: _getRoleColor(participant.role).withOpacity(0.2),
            child: Text(
              participant.initial,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _getRoleColor(participant.role),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Nome
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      participant.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.normal,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    if (isCurrentUser)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          '(tu)',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textTertiaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Status votazione
          if (statusIcon != null)
            Icon(statusIcon, size: 18, color: statusColor),
        ],
      ),
    );
  }

  Color _getRoleColor(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return AppColors.warning;
      case ParticipantRole.voter:
        return AppColors.secondary;
      case ParticipantRole.observer:
        return AppColors.q4Color;
    }
  }
}
