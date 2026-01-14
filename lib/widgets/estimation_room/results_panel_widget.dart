import 'package:flutter/material.dart';
import '../../models/planning_poker_story_model.dart';

/// Widget che mostra i risultati e le statistiche dopo il reveal
class ResultsPanelWidget extends StatelessWidget {
  final PlanningPokerStoryModel story;
  final Function(String) onSetEstimate;
  final VoidCallback onRevote;
  final bool isFacilitator;

  const ResultsPanelWidget({
    super.key,
    required this.story,
    required this.onSetEstimate,
    required this.onRevote,
    required this.isFacilitator,
  });

  @override
  Widget build(BuildContext context) {
    final stats = story.statistics ?? story.calculateStatistics();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            children: [
              Icon(
                stats.consensus ? Icons.celebration : Icons.analytics,
                color: stats.consensus ? Colors.amber : Colors.blue,
              ),
              const SizedBox(width: 8),
              Text(
                stats.consensus ? 'Consenso raggiunto!' : 'Risultati Votazione',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              if (isFacilitator)
                TextButton.icon(
                  onPressed: onRevote,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Rivota'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Statistiche
          Row(
            children: [
              Expanded(child: _buildStatCard(
                'Media',
                stats.numericAverage?.toStringAsFixed(1) ?? '-',
                Colors.blue,
                tooltip: 'Media aritmetica dei voti numerici',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                'Mediana',
                stats.numericMedian?.toStringAsFixed(1) ?? '-',
                Colors.green,
                tooltip: 'Valore centrale quando i voti sono ordinati',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                'Moda',
                stats.mode ?? '-',
                Colors.orange,
                tooltip: 'Voto più frequente (il valore scelto più volte)',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                'Votanti',
                '${stats.totalVoters}',
                Colors.purple,
                tooltip: 'Numero totale di partecipanti che hanno votato',
              )),
            ],
          ),
          const SizedBox(height: 16),
          // Distribuzione
          if (stats.distribution.isNotEmpty) ...[
            const Text(
              'Distribuzione voti',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),
            _buildDistributionChart(stats.distribution, stats.totalVoters),
          ],
          const SizedBox(height: 16),
          // Azioni facilitator
          if (isFacilitator && story.finalEstimate == null) ...[
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Seleziona stima finale',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            const SizedBox(height: 8),
            _buildEstimateSelector(context, stats),
          ],
          // Stima finale
          if (story.finalEstimate != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text(
                    'Stima finale:',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      story.finalEstimate!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, {String? tooltip}) {
    final card = Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: color.withOpacity(0.8),
                ),
              ),
              if (tooltip != null) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: color.withOpacity(0.5),
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        child: card,
      );
    }
    return card;
  }

  Widget _buildDistributionChart(Map<String, int> distribution, int total) {
    // Ordina per frequenza decrescente
    final sortedEntries = distribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sortedEntries.map((entry) {
        final percentage = total > 0 ? (entry.value / total) : 0.0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percentage,
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: _getBarColor(entry.key),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: Text(
                  '${entry.value} (${(percentage * 100).toStringAsFixed(0)}%)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getBarColor(String value) {
    if (value == '?') return Colors.orange;
    if (value == '☕') return Colors.brown;
    final numValue = int.tryParse(value);
    if (numValue != null) {
      if (numValue <= 3) return Colors.green;
      if (numValue <= 8) return Colors.blue;
      if (numValue <= 20) return Colors.orange;
      return Colors.red;
    }
    return Colors.purple;
  }

  Widget _buildEstimateSelector(BuildContext context, VoteStatistics stats) {
    // Suggerisci la moda o la mediana
    final suggestions = <String>{};
    if (stats.mode != null) suggestions.add(stats.mode!);
    if (stats.numericMedian != null) {
      final medianRounded = stats.numericMedian!.round().toString();
      suggestions.add(medianRounded);
    }
    // Aggiungi tutti i valori votati
    suggestions.addAll(stats.distribution.keys);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: suggestions.map((value) {
        final isSuggested = value == stats.mode;
        return ActionChip(
          avatar: isSuggested ? const Icon(Icons.star, size: 16, color: Colors.amber) : null,
          label: Text(
            value,
            style: TextStyle(
              fontWeight: isSuggested ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          backgroundColor: isSuggested ? Colors.amber.withOpacity(0.2) : null,
          side: isSuggested ? const BorderSide(color: Colors.amber) : null,
          onPressed: () => onSetEstimate(value),
        );
      }).toList(),
    );
  }
}
