import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/planning_poker_story_model.dart';
import '../../models/planning_poker_session_model.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'poker_card_widget.dart';

/// Widget che mostra il tabellone con i voti dei partecipanti
class VotingBoardWidget extends StatelessWidget {
  final PlanningPokerStoryModel story;
  final PlanningPokerSessionModel session;
  final String currentUserEmail;
  final bool isRevealed;

  const VotingBoardWidget({
    super.key,
    required this.story,
    required this.session,
    required this.currentUserEmail,
    required this.isRevealed,
  });

  @override
  Widget build(BuildContext context) {
    final voters = session.participants.entries
        .where((e) => e.value.canVote)
        .toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header compatto
          Row(
            children: [
              Icon(
                isRevealed ? Icons.visibility : Icons.visibility_off,
                color: isRevealed ? Colors.green : Colors.orange,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                isRevealed
                    ? AppLocalizations.of(context)!.estimationVotesRevealed
                    : AppLocalizations.of(context)!.estimationVotingInProgress,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              // Contatore voti
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getProgressColor(),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  AppLocalizations.of(context)!.estimationVotesCountFormatted(story.voteCount, voters.length),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Griglia voti compatta
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: voters.map((entry) {
              final email = entry.key;
              final participant = entry.value;
              final vote = story.votes[email];
              final hasVoted = vote != null;
              final isCurrentUser = email == currentUserEmail;

              return _buildVoterCard(
                context: context,
                name: participant.name,
                email: email,
                hasVoted: hasVoted,
                voteValue: vote?.value,
                isRevealed: isRevealed,
                isCurrentUser: isCurrentUser,
                isFacilitator: participant.isFacilitator,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor() {
    final voters = session.participants.values.where((p) => p.canVote).length;
    if (voters == 0) return Colors.grey;
    final progress = story.voteCount / voters;
    if (progress >= 1) return Colors.green;
    if (progress >= 0.5) return Colors.orange;
    return Colors.amber;
  }

  Widget _buildVoterCard({
    required BuildContext context,
    required String name,
    required String email,
    required bool hasVoted,
    String? voteValue,
    required bool isRevealed,
    required bool isCurrentUser,
    required bool isFacilitator,
  }) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser ? Colors.blue : context.borderColor,
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar compatto
          Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: hasVoted
                    ? Colors.green.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: hasVoted ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              if (isFacilitator)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          // Nome
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          // Carta compatta
          if (hasVoted)
            PokerCardWidget(
              value: isRevealed ? (voteValue ?? '?') : '✓',
              isRevealed: isRevealed,
              width: 36,
              height: 52,
            )
          else
            Container(
              width: 36,
              height: 52,
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: context.borderColor,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.hourglass_empty,
                  color: context.textMutedColor,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
