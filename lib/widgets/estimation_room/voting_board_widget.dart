import 'package:flutter/material.dart';
import '../../models/planning_poker_story_model.dart';
import '../../models/planning_poker_session_model.dart';
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
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                isRevealed ? Icons.visibility : Icons.visibility_off,
                color: isRevealed ? Colors.green : Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                isRevealed ? 'Voti Rivelati' : 'Votazione in Corso',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              // Contatore voti
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getProgressColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${story.voteCount}/${voters.length} voti',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Griglia voti
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: voters.map((entry) {
                  final email = entry.key;
                  final participant = entry.value;
                  final vote = story.votes[email];
                  final hasVoted = vote != null;
                  final isCurrentUser = email == currentUserEmail;

                  return _buildVoterCard(
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
            ),
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
    return Colors.blue;
  }

  Widget _buildVoterCard({
    required String name,
    required String email,
    required bool hasVoted,
    String? voteValue,
    required bool isRevealed,
    required bool isCurrentUser,
    required bool isFacilitator,
  }) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser ? Colors.blue : Colors.grey[200]!,
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
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: hasVoted
                    ? Colors.green.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: hasVoted ? Colors.green : Colors.grey,
                  ),
                ),
              ),
              if (isFacilitator)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Nome
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Carta
          if (hasVoted)
            PokerCardWidget(
              value: isRevealed ? (voteValue ?? '?') : '✓',
              isRevealed: isRevealed,
              width: 44,
              height: 64,
            )
          else
            Container(
              width: 44,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey[300]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.hourglass_empty,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
            ),
          const SizedBox(height: 6),
          // Status
          Text(
            hasVoted
                ? (isRevealed ? voteValue! : 'Votato ✓')
                : 'In attesa...',
            style: TextStyle(
              fontSize: 11,
              color: hasVoted ? Colors.green : Colors.grey,
              fontWeight: hasVoted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
