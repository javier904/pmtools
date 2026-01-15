import 'package:flutter/material.dart';
import '../../models/estimation_mode.dart';
import '../../models/planning_poker_story_model.dart';
import '../../themes/app_theme.dart';
import 'decimal_input_widget.dart';
import 'three_point_input_widget.dart';
import 'poker_card_widget.dart';

/// Widget wrapper che mostra l'input appropriato in base alla modalità di stima
class EstimationInputWrapper extends StatelessWidget {
  final EstimationMode mode;
  final List<String> cardSet;
  final String? selectedValue;
  final bool enabled;
  final Function(PlanningPokerVote vote) onVoteSubmitted;

  const EstimationInputWrapper({
    super.key,
    required this.mode,
    required this.cardSet,
    this.selectedValue,
    this.enabled = true,
    required this.onVoteSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case EstimationMode.decimal:
        return _buildDecimalInput();
      case EstimationMode.threePoint:
        return _buildThreePointInput();
      case EstimationMode.fibonacci:
      case EstimationMode.tshirt:
      case EstimationMode.fiveFingers:
        return _buildCardInput();
      case EstimationMode.dotVoting:
        return _buildDotVotingPlaceholder();
      case EstimationMode.bucketSystem:
        return _buildBucketSystemPlaceholder();
    }
  }

  Widget _buildCardInput() {
    // Ottieni le carte appropriate per la modalità
    final cards = mode.defaultCards.isNotEmpty ? mode.defaultCards : cardSet;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(_getModeIcon(), color: Colors.blue),
            const SizedBox(width: 8),
            Text(
              'Seleziona la tua stima',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((value) {
            final isSelected = value == selectedValue;
            return PokerCardWidget(
              value: value,
              isSelected: isSelected,
              isRevealed: true,
              enabled: enabled,
              onTap: () {
                final vote = PlanningPokerVote.standard(value);
                onVoteSubmitted(vote);
              },
              width: mode == EstimationMode.fiveFingers ? 70 : 60,
              height: mode == EstimationMode.fiveFingers ? 100 : 90,
            );
          }).toList(),
        ),
        if (selectedValue != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Voto selezionato: $selectedValue',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDecimalInput() {
    double? initialValue;
    if (selectedValue != null) {
      initialValue = double.tryParse(selectedValue!);
    }

    return DecimalInputWidget(
      initialValue: initialValue,
      enabled: enabled,
      onValueSubmitted: (value) {
        final vote = PlanningPokerVote.decimal(value);
        onVoteSubmitted(vote);
      },
    );
  }

  Widget _buildThreePointInput() {
    return ThreePointInputWidget(
      enabled: enabled,
      onValuesSubmitted: (optimistic, realistic, pessimistic) {
        final vote = PlanningPokerVote.threePoint(
          optimistic: optimistic,
          realistic: realistic,
          pessimistic: pessimistic,
        );
        onVoteSubmitted(vote);
      },
    );
  }

  Widget _buildDotVotingPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.radio_button_checked, size: 48, color: Colors.orange[700]),
          const SizedBox(height: 12),
          const Text(
            'Dot Voting',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Modalita\' di votazione con allocazione punti.\nComing soon...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildBucketSystemPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.view_column, size: 48, color: Colors.teal[700]),
          const SizedBox(height: 12),
          const Text(
            'Bucket System',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Stima per affinita\' con raggruppamento.\nComing soon...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  IconData _getModeIcon() {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.analytics;
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.view_column;
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }
}

/// Widget per visualizzare un voto in base alla modalità
class VoteDisplayWidget extends StatelessWidget {
  final PlanningPokerVote vote;
  final EstimationMode mode;
  final bool isRevealed;
  final bool compact;

  const VoteDisplayWidget({
    super.key,
    required this.vote,
    required this.mode,
    this.isRevealed = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRevealed) {
      return Container(
        width: compact ? 50 : 60,
        height: compact ? 35 : 40,
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(Icons.help_outline, color: Colors.white, size: 20),
        ),
      );
    }

    // Three-point vote
    if (vote.isThreePoint) {
      return ThreePointVoteDisplay(
        optimistic: vote.optimisticValue!,
        realistic: vote.realisticValue!,
        pessimistic: vote.pessimisticValue!,
        isRevealed: isRevealed,
        compact: compact,
      );
    }

    // Decimal vote
    if (vote.decimalValue != null) {
      return DecimalVoteDisplay(
        value: vote.decimalValue!,
        isRevealed: isRevealed,
      );
    }

    // Standard vote (card-based)
    if (compact) {
      return PokerCardWidget(
        value: vote.value,
        isSelected: false,
        isRevealed: true,
        width: 50,
        height: 70,
      );
    }

    return PokerCardWidget(
      value: vote.value,
      isSelected: false,
      isRevealed: true,
      width: 60,
      height: 90,
    );
  }
}

/// Widget per mostrare le statistiche in base alla modalità
class ModeAwareStatisticsWidget extends StatelessWidget {
  final VoteStatistics statistics;
  final EstimationMode mode;

  const ModeAwareStatisticsWidget({
    super.key,
    required this.statistics,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics, color: Colors.blue),
              const SizedBox(width: 8),
              const Text(
                'Statistiche Votazione',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Standard statistics
          Row(
            children: [
              _buildStatCard(
                'Media',
                statistics.numericAverage?.toStringAsFixed(2) ?? '-',
                Colors.blue,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'Mediana',
                statistics.numericMedian?.toStringAsFixed(2) ?? '-',
                Colors.green,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'Moda',
                statistics.mode ?? '-',
                Colors.orange,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'Votanti',
                statistics.totalVoters.toString(),
                Colors.purple,
              ),
            ],
          ),

          // Three-point specific statistics
          if (statistics.hasThreePointVotes) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.analytics, size: 16, color: Colors.purple),
                const SizedBox(width: 4),
                const Text(
                  'PERT Statistics',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard(
                  'PERT Avg',
                  statistics.averagePertValue?.toStringAsFixed(2) ?? '-',
                  Colors.purple,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Dev. Std',
                  statistics.averageStandardDeviation?.toStringAsFixed(2) ?? '-',
                  Colors.orange,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Varianza',
                  statistics.totalVariance?.toStringAsFixed(2) ?? '-',
                  Colors.red,
                ),
              ],
            ),
          ],

          // Range statistics
          if (statistics.minValue != null && statistics.maxValue != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Range:',
                    style: TextStyle(color: context.textSecondaryColor),
                  ),
                  Text(
                    '${statistics.minValue!.toStringAsFixed(1)} - ${statistics.maxValue!.toStringAsFixed(1)}',
                    style: TextStyle(fontWeight: FontWeight.w600, color: context.textPrimaryColor),
                  ),
                  Text(
                    '(Δ ${statistics.range?.toStringAsFixed(1) ?? '-'})',
                    style: TextStyle(color: context.textSecondaryColor),
                  ),
                ],
              ),
            ),
          ],

          // Consensus indicator
          if (statistics.consensus) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.celebration, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text(
                    'Consenso raggiunto!',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
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

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
