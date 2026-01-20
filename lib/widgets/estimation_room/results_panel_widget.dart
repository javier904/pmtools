import 'package:flutter/material.dart';
import '../../models/planning_poker_story_model.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colori adattivi per dark/light mode
    final backgroundColor = isDark
        ? theme.colorScheme.surfaceContainerHighest
        : theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;
    final subtleTextColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: isDark ? Border.all(color: Colors.grey[700]!, width: 1) : null,
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
                stats.consensus
                    ? (l10n?.voteConsensus ?? 'Consenso raggiunto!')
                    : (l10n?.voteResults ?? 'Risultati Votazione'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              const Spacer(),
              if (isFacilitator)
                TextButton.icon(
                  onPressed: onRevote,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(l10n?.voteRevote ?? 'Rivota'),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Statistiche
          Row(
            children: [
              Expanded(child: _buildStatCard(
                context,
                l10n?.voteAverage ?? 'Media',
                stats.numericAverage?.toStringAsFixed(1) ?? '-',
                Colors.blue,
                tooltip: l10n?.voteAverageTooltip ?? 'Media aritmetica dei voti numerici',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                context,
                l10n?.voteMedian ?? 'Mediana',
                stats.numericMedian?.toStringAsFixed(1) ?? '-',
                Colors.amber,
                tooltip: l10n?.voteMedianTooltip ?? 'Valore centrale quando i voti sono ordinati',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                context,
                l10n?.voteMode ?? 'Moda',
                stats.mode ?? '-',
                Colors.orange,
                tooltip: l10n?.voteModeTooltip ?? 'Voto più frequente (il valore scelto più volte)',
              )),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(
                context,
                l10n?.voteVoters ?? 'Votanti',
                '${stats.totalVoters}',
                Colors.purple,
                tooltip: l10n?.voteVotersTooltip ?? 'Numero totale di partecipanti che hanno votato',
              )),
            ],
          ),
          const SizedBox(height: 16),
          // Distribuzione
          if (stats.distribution.isNotEmpty) ...[
            Text(
              l10n?.voteDistribution ?? 'Distribuzione voti',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            _buildDistributionChart(context, stats.distribution, stats.totalVoters),
          ],
          const SizedBox(height: 16),
          // Azioni facilitator
          if (isFacilitator && story.finalEstimate == null) ...[
            Divider(color: isDark ? Colors.grey[700] : Colors.grey[300]),
            const SizedBox(height: 12),
            Text(
              l10n?.voteSelectFinal ?? 'Seleziona stima finale',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            _buildEstimateSelector(context, stats),
          ],
          // Stima finale
          if (story.finalEstimate != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    '${l10n?.voteFinalEstimate ?? 'Stima finale'}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      story.finalEstimate!,
                      style: const TextStyle(
                        color: Colors.black87,
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

  Widget _buildStatCard(BuildContext context, String label, String value, Color color, {String? tooltip}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final card = Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(8),
        border: isDark ? Border.all(color: color.withOpacity(0.3), width: 1) : null,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? color.withOpacity(0.9) : color,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? color.withOpacity(0.7) : color.withOpacity(0.8),
                  ),
                  overflow: TextOverflow.ellipsis,
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

  Widget _buildDistributionChart(BuildContext context, Map<String, int> distribution, int total) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final subtleTextColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final barBackgroundColor = isDark ? Colors.grey[800] : Colors.grey[200];

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
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: barBackgroundColor,
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
                width: 70,
                child: Text(
                  '${entry.value} (${(percentage * 100).toStringAsFixed(0)}%)',
                  style: TextStyle(
                    fontSize: 13,
                    color: subtleTextColor,
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
      if (numValue <= 3) return Colors.amber;
      if (numValue <= 8) return Colors.blue;
      if (numValue <= 20) return Colors.orange;
      return Colors.red;
    }
    return Colors.purple;
  }

  Widget _buildEstimateSelector(BuildContext context, VoteStatistics stats) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              color: isSuggested ? (isDark ? Colors.amber[300] : Colors.amber[900]) : null,
            ),
          ),
          backgroundColor: isSuggested
              ? Colors.amber.withOpacity(isDark ? 0.3 : 0.2)
              : (isDark ? theme.colorScheme.surfaceContainerHigh : null),
          side: isSuggested
              ? const BorderSide(color: Colors.amber)
              : (isDark ? BorderSide(color: Colors.grey[600]!) : null),
          onPressed: () => onSetEstimate(value),
        );
      }).toList(),
    );
  }
}
