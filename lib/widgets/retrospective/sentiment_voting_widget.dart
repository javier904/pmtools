import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class SentimentVotingWidget extends StatelessWidget {
  final String retroId;
  final String currentUserEmail;
  final Map<String, int> currentVotes;
  final bool isFacilitator;
  final VoidCallback onPhaseComplete;

  const SentimentVotingWidget({
    Key? key,
    required this.retroId,
    required this.currentUserEmail,
    required this.currentVotes,
    this.isFacilitator = false,
    required this.onPhaseComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final int? myVote = currentVotes[currentUserEmail];

    return Center(
      child: Card(
        // CardTheme from AppTheme will handle shape and color
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.retroIcebreakerTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.retroIcebreakerQuestion,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 32),

              // Voting Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEmojiOption(context, 1, '😢', l10n.retroMoodTerrible, myVote),
                  _buildEmojiOption(context, 2, '😕', l10n.retroMoodBad, myVote),
                  _buildEmojiOption(context, 3, '😐', l10n.retroMoodNeutral, myVote),
                  _buildEmojiOption(context, 4, '🙂', l10n.retroMoodGood, myVote),
                  _buildEmojiOption(context, 5, '😄', l10n.retroMoodExcellent, myVote),
                ],
              ),

              const SizedBox(height: 48),

              // Progress
              Text(
                l10n.retroParticipantsVoted(currentVotes.length),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 24),

              if (isFacilitator)
                ElevatedButton.icon(
                  onPressed: onPhaseComplete, // Proceed to Writing phase
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.retroEndIcebreakerStartWriting),
                  // Button style inherited from Theme
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiOption(BuildContext context, int value, String emoji, String label, int? selectedValue) {
    final isSelected = selectedValue == value;
    final selectedColor = Colors.blue;

    return InkWell(
      onTap: () {
        // Vote logic
        final service = RetrospectiveFirestoreService();
        service.submitSentiment(retroId, currentUserEmail, value);
      },
      borderRadius: BorderRadius.circular(50),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withOpacity(0.1) : Colors.transparent,
          border: isSelected ? Border.all(color: selectedColor, width: 2) : Border.all(color: Colors.transparent, width: 2),
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(
              fontSize: 12,
              color: isSelected ? selectedColor : context.textSecondaryColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            )),
          ],
        ),
      ),
    );
  }
}
