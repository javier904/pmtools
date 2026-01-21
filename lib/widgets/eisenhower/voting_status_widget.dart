import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../l10n/app_localizations.dart';

/// Widget che mostra lo stato della votazione indipendente
///
/// Visualizza:
/// - Lista dei votanti con stato (pronto/in attesa)
/// - Progress bar della votazione
/// - Bottone per rivelare (se facilitatore e tutti pronti)
class VotingStatusWidget extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final Map<String, EisenhowerParticipantModel> participants;
  final String currentUserEmail;
  final bool isFacilitator;
  final VoidCallback? onReveal;
  final VoidCallback? onReset;
  final Function(String voterEmail)? onVote;

  const VotingStatusWidget({
    super.key,
    required this.activity,
    required this.participants,
    required this.currentUserEmail,
    required this.isFacilitator,
    this.onReveal,
    this.onReset,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final voters = participants.entries
        .where((e) => e.value.canVote)
        .toList();
    final readyCount = activity.readyVoters.length;
    final totalVoters = voters.length;
    final progress = totalVoters > 0 ? readyCount / totalVoters : 0.0;
    final allReady = readyCount >= totalVoters && totalVoters > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con titolo e badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.how_to_vote, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      l10n.eisenhowerVotingInProgress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '$readyCount/$totalVoters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: allReady ? Colors.green : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                allReady ? Colors.green : Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lista votanti
          ...voters.map((entry) => _buildVoterRow(
                context,
                entry.key,
                entry.value,
                activity.readyVoters.contains(entry.key),
                l10n,
              )),

          // Azioni
          if (isFacilitator) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                if (onReset != null)
                  TextButton.icon(
                    onPressed: onReset,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Reset'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                    ),
                  ),
                const Spacer(),
                if (onReveal != null)
                  ElevatedButton.icon(
                    onPressed: allReady ? onReveal : null,
                    icon: const Icon(Icons.visibility),
                    label: Text(l10n.eisenhowerRevealVotes),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: allReady ? Colors.green : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ],

          // Info per non-facilitatori
          if (!isFacilitator && !allReady) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.orange[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.eisenhowerWaitingForOthers,
                      style: TextStyle(fontSize: 12, color: Colors.orange[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVoterRow(
    BuildContext context,
    String email,
    EisenhowerParticipantModel participant,
    bool hasVoted,
    AppLocalizations l10n,
  ) {
    final isCurrentUser = email.toLowerCase() == currentUserEmail.toLowerCase();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Avatar con stato
          Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: hasVoted
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.grey.withValues(alpha: 0.2),
                child: Text(
                  participant.initial,
                  style: TextStyle(
                    color: hasVoted ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              if (hasVoted)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Nome e ruolo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      participant.name,
                      style: TextStyle(
                        fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Tu',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (participant.isFacilitator) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.star, size: 14, color: Colors.amber[600]),
                    ],
                  ],
                ),
                Text(
                  participant.role.displayName,
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Stato voto
          if (hasVoted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, size: 14, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    l10n.eisenhowerReady,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          else if (isCurrentUser && onVote != null)
            ElevatedButton.icon(
              onPressed: () => onVote!(email),
              icon: const Icon(Icons.how_to_vote, size: 14),
              label: Text(l10n.eisenhowerVoteSubmit),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                textStyle: const TextStyle(fontSize: 11),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.eisenhowerWaiting,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Widget compatto per mostrare lo stato della votazione
class VotingStatusBadge extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final int totalVoters;

  const VotingStatusBadge({
    super.key,
    required this.activity,
    required this.totalVoters,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final readyCount = activity.readyVoters.length;
    final allReady = readyCount >= totalVoters && totalVoters > 0;

    if (activity.isRevealed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.visibility, size: 14, color: Colors.amber),
            const SizedBox(width: 4),
            Text(
              l10n.storyStatusRevealed,
              style: const TextStyle(fontSize: 11, color: Colors.amber),
            ),
          ],
        ),
      );
    }

    if (activity.isIndependentVotingInProgress) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: allReady
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.blue.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              allReady ? Icons.check_circle : Icons.how_to_vote,
              size: 14,
              color: allReady ? Colors.green : Colors.blue,
            ),
            const SizedBox(width: 4),
            Text(
              l10n.eisenhowerVotedParticipants(readyCount, totalVoters),
              style: TextStyle(
                fontSize: 11,
                color: allReady ? Colors.green : Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
