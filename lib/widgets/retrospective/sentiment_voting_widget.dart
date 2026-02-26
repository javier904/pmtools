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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Card(
        margin: EdgeInsets.all(isMobile ? 8 : 24),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.retroIcebreakerTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 18 : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 8 : 16),
                Text(
                  l10n.retroIcebreakerQuestion,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                    fontSize: isMobile ? 12 : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 16 : 32),

                // Voting Options
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: isMobile ? 8 : 16,
                  runSpacing: isMobile ? 8 : 16,
                  children: [
                    _buildEmojiOption(context, 1, '😢', l10n.retroMoodTerrible, myVote, isMobile),
                    _buildEmojiOption(context, 2, '😕', l10n.retroMoodBad, myVote, isMobile),
                    _buildEmojiOption(context, 3, '😐', l10n.retroMoodNeutral, myVote, isMobile),
                    _buildEmojiOption(context, 4, '🙂', l10n.retroMoodGood, myVote, isMobile),
                    _buildEmojiOption(context, 5, '😄', l10n.retroMoodExcellent, myVote, isMobile),
                  ],
                ),

                SizedBox(height: isMobile ? 24 : 48),

                // Progress
                Text(
                  l10n.retroParticipantsVoted(currentVotes.length),
                  style: isMobile 
                      ? Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12)
                      : Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: isMobile ? 16 : 24),

                if (isFacilitator)
                  ElevatedButton.icon(
                    onPressed: onPhaseComplete, // Proceed to Writing phase
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(l10n.retroEndIcebreakerStartWriting),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiOption(BuildContext context, int value, String emoji, String label, int? selectedValue, bool isMobile) {
    final isSelected = selectedValue == value;
    // Using amber for high visibility and contrast when tapped, instead of a subtle blue
    final selectedColor = Colors.amber.shade600;

    return InkWell(
      onTap: () async {
        // Vote logic
        try {
          final service = RetrospectiveFirestoreService();
          await service.submitSentiment(retroId, currentUserEmail, value);
        } catch (e, stack) {
          print('Error submitting sentiment vote: $e');
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isMobile ? 80 : 120,
        padding: EdgeInsets.all(isMobile ? 8 : 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withValues(alpha: 0.25) : Colors.transparent,
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected ? [
            BoxShadow(color: selectedColor.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 2)
          ] : null,
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: isMobile ? 28 : 48)),
            SizedBox(height: isMobile ? 4 : 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 10 : 12,
                color: isSelected ? selectedColor : context.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
