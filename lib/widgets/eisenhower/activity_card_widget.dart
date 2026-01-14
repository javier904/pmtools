import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import 'voting_status_widget.dart';

/// Card per visualizzare una singola attività nella matrice
class ActivityCardWidget extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final Color? quadrantColor;
  final VoidCallback onTap;
  final VoidCallback? onVoteTap;
  final VoidCallback? onDeleteTap;
  final bool showActions;
  final bool compact;

  // Parametri per votazione indipendente
  final String? currentUserEmail;
  final bool isFacilitator;
  final int totalVoters;
  final VoidCallback? onStartIndependentVoting;
  final VoidCallback? onSubmitIndependentVote;
  final VoidCallback? onRevealVotes;
  final VoidCallback? onResetVoting;

  const ActivityCardWidget({
    super.key,
    required this.activity,
    this.quadrantColor,
    required this.onTap,
    this.onVoteTap,
    this.onDeleteTap,
    this.showActions = true,
    this.compact = false,
    // Parametri votazione indipendente
    this.currentUserEmail,
    this.isFacilitator = false,
    this.totalVoters = 0,
    this.onStartIndependentVoting,
    this.onSubmitIndependentVote,
    this.onRevealVotes,
    this.onResetVoting,
  });

  @override
  Widget build(BuildContext context) {
    final color = quadrantColor ??
        (activity.quadrant != null
            ? Color(activity.quadrant!.colorValue)
            : Colors.grey);

    if (compact) {
      return _buildCompactCard(context, color);
    }
    return _buildFullCard(context, color);
  }

  Widget _buildCompactCard(BuildContext context, Color color) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // Indicatore colore
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              // Titolo
              Expanded(
                child: Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Punteggio se votato
              if (activity.hasVotes) ...[
                const SizedBox(width: 4),
                _buildScoreBadge(color),
              ],
              // Azioni
              if (showActions) ...[
                if (onVoteTap != null)
                  IconButton(
                    icon: Icon(
                      activity.hasVotes ? Icons.edit : Icons.how_to_vote,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    onPressed: onVoteTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    tooltip: activity.hasVotes ? 'Modifica voti' : 'Vota',
                  ),
                if (onDeleteTap != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                    onPressed: onDeleteTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    tooltip: 'Elimina',
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullCard(BuildContext context, Color color) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con titolo e azioni
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indicatore quadrante
                  if (activity.quadrant != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        activity.quadrant!.name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  if (activity.quadrant != null) const SizedBox(width: 8),
                  // Titolo
                  Expanded(
                    child: Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Menu azioni
                  if (showActions)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      padding: EdgeInsets.zero,
                      onSelected: (value) {
                        switch (value) {
                          case 'vote':
                            onVoteTap?.call();
                            break;
                          case 'delete':
                            onDeleteTap?.call();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'vote',
                          child: Row(
                            children: [
                              Icon(
                                activity.hasVotes ? Icons.edit : Icons.how_to_vote,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(activity.hasVotes ? 'Modifica voti' : 'Vota'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Elimina', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              // Descrizione
              if (activity.description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              // Tags
              if (activity.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: activity.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              // Footer con punteggi
              if (activity.hasVotes) ...[
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Urgenza
                    _buildScoreIndicator(
                      'Urgenza',
                      activity.aggregatedUrgency,
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    // Importanza
                    _buildScoreIndicator(
                      'Importanza',
                      activity.aggregatedImportance,
                      Colors.blue,
                    ),
                    const Spacer(),
                    // Numero voti
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.how_to_vote, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${activity.voteCount}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber, size: 14, color: Colors.amber[700]),
                      const SizedBox(width: 6),
                      Text(
                        'In attesa di voti',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // === SEZIONE VOTAZIONE INDIPENDENTE ===
              if (activity.isIndependentVotingInProgress) ...[
                const SizedBox(height: 12),
                _buildIndependentVotingSection(),
              ] else if (!activity.hasVotes && !activity.isRevealed && totalVoters > 1) ...[
                // Mostra bottoni per avviare votazione solo se non ci sono già voti
                const SizedBox(height: 12),
                _buildVotingButtons(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Costruisce la sezione per la votazione indipendente in corso
  Widget _buildIndependentVotingSection() {
    final readyCount = activity.readyVoters.length;
    final allReady = readyCount >= totalVoters && totalVoters > 0;
    final hasCurrentUserVoted =
        currentUserEmail != null && activity.hasVoterReady(currentUserEmail!);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con badge stato
          Row(
            children: [
              VotingStatusBadge(activity: activity, totalVoters: totalVoters),
              const Spacer(),
              if (isFacilitator && onResetVoting != null)
                IconButton(
                  icon: const Icon(Icons.refresh, size: 18),
                  onPressed: onResetVoting,
                  tooltip: 'Reset votazione',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: totalVoters > 0 ? readyCount / totalVoters : 0.0,
              minHeight: 6,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                allReady ? Colors.green : Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Testo stato
          Text(
            '$readyCount su $totalVoters partecipanti hanno votato',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),

          // Bottoni azione
          Row(
            children: [
              // Bottone per votare (se l'utente non ha ancora votato)
              if (!hasCurrentUserVoted && onSubmitIndependentVote != null)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onSubmitIndependentVote,
                    icon: const Icon(Icons.how_to_vote, size: 16),
                    label: const Text('VOTA'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              // Badge "Hai votato"
              if (hasCurrentUserVoted)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: Colors.green),
                        const SizedBox(width: 6),
                        Text(
                          'Hai votato',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Bottone Rivela (solo facilitatore, solo se tutti pronti)
              if (isFacilitator && onRevealVotes != null) ...[
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: allReady ? onRevealVotes : null,
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text('RIVELA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: allReady ? Colors.green : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// Costruisce i bottoni per avviare la votazione (rapida o indipendente)
  Widget _buildVotingButtons() {
    return Row(
      children: [
        // Voto Rapido (esistente)
        if (onVoteTap != null)
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onVoteTap,
              icon: const Icon(Icons.flash_on, size: 16),
              label: const Text('Voto Rapido'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        if (onVoteTap != null && onStartIndependentVoting != null)
          const SizedBox(width: 8),
        // Voto Indipendente (solo facilitatore)
        if (isFacilitator && onStartIndependentVoting != null)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onStartIndependentVoting,
              icon: const Icon(Icons.group, size: 16),
              label: const Text('Voto Team'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScoreBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'U:${activity.aggregatedUrgency.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'I:${activity.aggregatedImportance.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(String label, double value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

/// Card per attività non ancora votata (da mostrare in lista separata)
class UnvotedActivityCard extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final VoidCallback onVoteTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const UnvotedActivityCard({
    super.key,
    required this.activity,
    required this.onVoteTap,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.help_outline,
            color: Colors.grey[500],
          ),
        ),
        title: Text(
          activity.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: activity.description.isNotEmpty
            ? Text(
                activity.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: onVoteTap,
              icon: const Icon(Icons.how_to_vote, size: 16),
              label: const Text('Vota'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
            if (onDeleteTap != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDeleteTap,
                tooltip: 'Elimina',
              ),
          ],
        ),
      ),
    );
  }
}
