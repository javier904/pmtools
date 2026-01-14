import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';

/// Dialog per raccogliere i voti di tutti i partecipanti per un'attività
///
/// Mostra slider per urgenza e importanza per ogni partecipante
/// e calcola in tempo reale la media e il quadrante risultante
class VoteCollectionDialog extends StatefulWidget {
  final EisenhowerActivityModel activity;
  final List<String> participants;
  final Function(Map<String, EisenhowerVote>) onSave;

  const VoteCollectionDialog({
    super.key,
    required this.activity,
    required this.participants,
    required this.onSave,
  });

  /// Mostra il dialog e ritorna i voti raccolti
  static Future<Map<String, EisenhowerVote>?> show({
    required BuildContext context,
    required EisenhowerActivityModel activity,
    required List<String> participants,
  }) async {
    return showDialog<Map<String, EisenhowerVote>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => VoteCollectionDialog(
        activity: activity,
        participants: participants,
        onSave: (votes) => Navigator.of(context).pop(votes),
      ),
    );
  }

  @override
  State<VoteCollectionDialog> createState() => _VoteCollectionDialogState();
}

class _VoteCollectionDialogState extends State<VoteCollectionDialog> {
  late Map<String, _VoteData> _votes;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeVotes();
  }

  void _initializeVotes() {
    _votes = {};
    for (final participant in widget.participants) {
      final existingVote = widget.activity.votes[participant];
      _votes[participant] = _VoteData(
        urgency: existingVote?.urgency ?? 5,
        importance: existingVote?.importance ?? 5,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Calcola l'urgenza media
  double get _averageUrgency {
    if (_votes.isEmpty) return 0;
    final sum = _votes.values.fold<int>(0, (sum, v) => sum + v.urgency);
    return sum / _votes.length;
  }

  /// Calcola l'importanza media
  double get _averageImportance {
    if (_votes.isEmpty) return 0;
    final sum = _votes.values.fold<int>(0, (sum, v) => sum + v.importance);
    return sum / _votes.length;
  }

  /// Calcola il quadrante risultante
  EisenhowerQuadrant get _calculatedQuadrant {
    return EisenhowerQuadrantExtension.calculateQuadrant(
      _averageUrgency,
      _averageImportance,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quadrant = _calculatedQuadrant;
    final quadrantColor = Color(quadrant.colorValue);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            _buildHeader(quadrantColor),
            // Contenuto scrollabile
            Flexible(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info attività
                    _buildActivityInfo(),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 16),
                    // Voti partecipanti
                    ...widget.participants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final participant = entry.value;
                      return Column(
                        children: [
                          _buildParticipantVote(participant, index),
                          if (index < widget.participants.length - 1)
                            const Divider(height: 32),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            // Riepilogo e azioni
            _buildFooter(quadrant, quadrantColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color quadrantColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: quadrantColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.how_to_vote, color: quadrantColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Raccogli Voti',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.participants.length} partecipanti',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.task_alt, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.activity.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                if (widget.activity.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.activity.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
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

  Widget _buildParticipantVote(String participant, int index) {
    final vote = _votes[participant]!;
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
    ];
    final color = colors[index % colors.length];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nome partecipante
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withOpacity(0.2),
              child: Text(
                participant.isNotEmpty ? participant[0].toUpperCase() : '?',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                participant,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            // Badge con punteggi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'U:${vote.urgency} I:${vote.importance}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Slider Urgenza
        _buildSliderRow(
          label: 'Urgenza',
          value: vote.urgency,
          color: Colors.orange,
          leftLabel: 'Non urgente',
          rightLabel: 'Molto urgente',
          onChanged: (value) {
            setState(() {
              _votes[participant] = vote.copyWith(urgency: value);
            });
          },
        ),
        const SizedBox(height: 8),
        // Slider Importanza
        _buildSliderRow(
          label: 'Importanza',
          value: vote.importance,
          color: Colors.blue,
          leftLabel: 'Non importante',
          rightLabel: 'Molto importante',
          onChanged: (value) {
            setState(() {
              _votes[participant] = vote.copyWith(importance: value);
            });
          },
        ),
      ],
    );
  }

  Widget _buildSliderRow({
    required String label,
    required int value,
    required Color color,
    required String leftLabel,
    required String rightLabel,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: color,
                  inactiveTrackColor: color.withOpacity(0.2),
                  thumbColor: color,
                  overlayColor: color.withOpacity(0.1),
                  valueIndicatorColor: color,
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: value.toString(),
                  onChanged: (v) => onChanged(v.round()),
                ),
              ),
            ),
            Container(
              width: 32,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$value',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftLabel,
                style: TextStyle(fontSize: 9, color: Colors.grey[500]),
              ),
              Text(
                rightLabel,
                style: TextStyle(fontSize: 9, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(EisenhowerQuadrant quadrant, Color quadrantColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        children: [
          // Riepilogo
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: quadrantColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: quadrantColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  _getQuadrantIcon(quadrant),
                  color: quadrantColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Risultato: ${quadrant.name} - ${quadrant.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: quadrantColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Media: Urgenza ${_averageUrgency.toStringAsFixed(1)} | '
                        'Importanza ${_averageImportance.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Azioni
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annulla'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _saveVotes,
                icon: const Icon(Icons.save),
                label: const Text('Salva Voti'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: quadrantColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getQuadrantIcon(EisenhowerQuadrant quadrant) {
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

  void _saveVotes() {
    final votes = <String, EisenhowerVote>{};
    _votes.forEach((participant, voteData) {
      votes[participant] = EisenhowerVote(
        urgency: voteData.urgency,
        importance: voteData.importance,
      );
    });
    widget.onSave(votes);
  }
}

/// Classe interna per gestire i dati del voto
class _VoteData {
  final int urgency;
  final int importance;

  _VoteData({required this.urgency, required this.importance});

  _VoteData copyWith({int? urgency, int? importance}) {
    return _VoteData(
      urgency: urgency ?? this.urgency,
      importance: importance ?? this.importance,
    );
  }
}
