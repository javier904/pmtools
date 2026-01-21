import 'package:flutter/material.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../l10n/app_localizations.dart';
import 'activity_card_widget.dart';

/// Widget che visualizza la griglia 2x2 della Matrice di Eisenhower
///
/// Layout:
/// ┌─────────────┬─────────────┐
/// │  Q2 (Verde) │  Q1 (Rosso) │  ← IMPORTANTE
/// │  PIANIFICA  │  FAI SUBITO │
/// ├─────────────┼─────────────┤
/// │  Q4 (Grigio)│  Q3 (Giallo)│  ← NON IMPORTANTE
/// │  ELIMINA    │  DELEGA     │
/// └─────────────┴─────────────┘
///   NON URGENTE    URGENTE
class MatrixGridWidget extends StatelessWidget {
  final List<EisenhowerActivityModel> activities;
  final Function(EisenhowerActivityModel) onActivityTap;
  final Function(EisenhowerActivityModel)? onVoteTap;
  final Function(EisenhowerActivityModel)? onDeleteTap;
  final bool showActions;

  const MatrixGridWidget({
    super.key,
    required this.activities,
    required this.onActivityTap,
    this.onVoteTap,
    this.onDeleteTap,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Raggruppa attività per quadrante
    final q1Activities = activities.byQuadrant(EisenhowerQuadrant.q1);
    final q2Activities = activities.byQuadrant(EisenhowerQuadrant.q2);
    final q3Activities = activities.byQuadrant(EisenhowerQuadrant.q3);
    final q4Activities = activities.byQuadrant(EisenhowerQuadrant.q4);

    return Column(
      children: [
        // Header con etichette
        _buildAxisLabels(l10n),
        const SizedBox(height: 8),
        // Griglia 2x2
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Etichetta verticale "IMPORTANTE"
              _buildVerticalLabel(l10n),
              // Colonna sinistra (NON URGENTE)
              Expanded(
                child: Column(
                  children: [
                    // Q2 - PIANIFICA (Non Urgente + Importante)
                    Expanded(
                      child: _QuadrantCell(
                        quadrant: EisenhowerQuadrant.q2,
                        activities: q2Activities,
                        onActivityTap: onActivityTap,
                        onVoteTap: onVoteTap,
                        onDeleteTap: onDeleteTap,
                        showActions: showActions,
                        l10n: l10n,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Q4 - ELIMINA (Non Urgente + Non Importante)
                    Expanded(
                      child: _QuadrantCell(
                        quadrant: EisenhowerQuadrant.q4,
                        activities: q4Activities,
                        onActivityTap: onActivityTap,
                        onVoteTap: onVoteTap,
                        onDeleteTap: onDeleteTap,
                        showActions: showActions,
                        l10n: l10n,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              // Colonna destra (URGENTE)
              Expanded(
                child: Column(
                  children: [
                    // Q1 - FAI SUBITO (Urgente + Importante)
                    Expanded(
                      child: _QuadrantCell(
                        quadrant: EisenhowerQuadrant.q1,
                        activities: q1Activities,
                        onActivityTap: onActivityTap,
                        onVoteTap: onVoteTap,
                        onDeleteTap: onDeleteTap,
                        showActions: showActions,
                        l10n: l10n,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Q3 - DELEGA (Urgente + Non Importante)
                    Expanded(
                      child: _QuadrantCell(
                        quadrant: EisenhowerQuadrant.q3,
                        activities: q3Activities,
                        onActivityTap: onActivityTap,
                        onVoteTap: onVoteTap,
                        onDeleteTap: onDeleteTap,
                        showActions: showActions,
                        l10n: l10n,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAxisLabels(AppLocalizations l10n) {
    return Row(
      children: [
        const SizedBox(width: 24), // Spazio per etichetta verticale
        Expanded(
          child: Center(
            child: Text(
              l10n.quadrantNotUrgent,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              l10n.quadrantUrgent,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalLabel(AppLocalizations l10n) {
    return SizedBox(
      width: 24,
      child: RotatedBox(
        quarterTurns: 3,
        child: Center(
          child: Text(
            l10n.quadrantImportant,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}

/// Cella singola di un quadrante
class _QuadrantCell extends StatelessWidget {
  final EisenhowerQuadrant quadrant;
  final List<EisenhowerActivityModel> activities;
  final Function(EisenhowerActivityModel) onActivityTap;
  final Function(EisenhowerActivityModel)? onVoteTap;
  final Function(EisenhowerActivityModel)? onDeleteTap;
  final bool showActions;
  final AppLocalizations l10n;

  const _QuadrantCell({
    required this.quadrant,
    required this.activities,
    required this.onActivityTap,
    required this.l10n,
    this.onVoteTap,
    this.onDeleteTap,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(quadrant.colorValue);
    final lightColor = color.withOpacity(0.1);

    return Container(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header del quadrante
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getQuadrantIcon(),
                  size: 18,
                  color: color.withOpacity(0.8),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${quadrant.name}: ${quadrant.localizedTitle(l10n)}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        quadrant.localizedSubtitle(l10n),
                        style: TextStyle(
                          fontSize: 10,
                          color: color.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // Badge conteggio
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${activities.length}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Lista attività
          Expanded(
            child: activities.isEmpty
                ? _buildEmptyState(color)
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: ActivityCardWidget(
                          activity: activity,
                          quadrantColor: color,
                          onTap: () => onActivityTap(activity),
                          onVoteTap: onVoteTap != null
                              ? () => onVoteTap!(activity)
                              : null,
                          onDeleteTap: onDeleteTap != null
                              ? () => onDeleteTap!(activity)
                              : null,
                          showActions: showActions,
                          compact: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 32,
            color: color.withOpacity(0.3),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.eisenhowerNoActivities,
            style: TextStyle(
              fontSize: 11,
              color: color.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getQuadrantIcon() {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return Icons.priority_high;
      case EisenhowerQuadrant.q2:
        return Icons.schedule;
      case EisenhowerQuadrant.q3:
        return Icons.group;
      case EisenhowerQuadrant.q4:
        return Icons.delete_outline;
    }
  }
}
