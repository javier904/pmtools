import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_participant_model.dart';

/// Widget che mostra i voti rivelati con animazione
///
/// Visualizza:
/// - I voti di ogni partecipante
/// - Il risultato aggregato (media)
/// - Il quadrante finale
class VoteRevealWidget extends StatefulWidget {
  final EisenhowerActivityModel activity;
  final Map<String, EisenhowerParticipantModel> participants;
  final bool showAnimation;

  const VoteRevealWidget({
    super.key,
    required this.activity,
    required this.participants,
    this.showAnimation = true,
  });

  @override
  State<VoteRevealWidget> createState() => _VoteRevealWidgetState();
}

class _VoteRevealWidgetState extends State<VoteRevealWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    if (widget.showAnimation) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quadrant = widget.activity.quadrant;
    final quadrantInfo = quadrant != null ? _getQuadrantInfo(quadrant) : null;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: quadrantInfo?.color.withValues(alpha: 0.3) ?? Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: quadrantInfo?.color.withValues(alpha: 0.1) ?? Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con risultato
            _buildResultHeader(quadrantInfo),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // Voti individuali
            const Text(
              'VOTI INDIVIDUALI',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.activity.votes.entries.map((entry) =>
                _buildVoteRow(entry.key, entry.value)),

            // Aggregato
            if (widget.activity.votes.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              _buildAggregateRow(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultHeader(_QuadrantDisplayInfo? quadrantInfo) {
    if (quadrantInfo == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.warning, color: Colors.grey),
            SizedBox(width: 8),
            Text('Nessun voto registrato'),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: quadrantInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: quadrantInfo.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(quadrantInfo.icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    const Text(
                      'RISULTATO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  quadrantInfo.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: quadrantInfo.color,
                  ),
                ),
                Text(
                  quadrantInfo.action,
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildVoteRow(String voterEmail, EisenhowerVote vote) {
    final participant = widget.participants[voterEmail];
    final voterName = participant?.name ?? voterEmail.split('@').first;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue.withValues(alpha: 0.2),
            child: Text(
              voterName.isNotEmpty ? voterName[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              voterName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          _buildVoteBadge('U', vote.urgency, Colors.red),
          const SizedBox(width: 8),
          _buildVoteBadge('I', vote.importance, Colors.green),
        ],
      ),
    );
  }

  Widget _buildVoteBadge(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAggregateRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.functions, color: Colors.grey),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'MEDIA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          _buildVoteBadge(
            'U',
            widget.activity.aggregatedUrgency.round(),
            Colors.red,
          ),
          const SizedBox(width: 8),
          _buildVoteBadge(
            'I',
            widget.activity.aggregatedImportance.round(),
            Colors.green,
          ),
        ],
      ),
    );
  }

  _QuadrantDisplayInfo _getQuadrantInfo(EisenhowerQuadrant quadrant) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return _QuadrantDisplayInfo(
          name: 'Q1 - FAI SUBITO',
          action: 'Urgente + Importante',
          color: const Color(0xFFE53935),
          icon: Icons.priority_high,
        );
      case EisenhowerQuadrant.q2:
        return _QuadrantDisplayInfo(
          name: 'Q2 - PIANIFICA',
          action: 'Non Urgente + Importante',
          color: const Color(0xFF43A047),
          icon: Icons.schedule,
        );
      case EisenhowerQuadrant.q3:
        return _QuadrantDisplayInfo(
          name: 'Q3 - DELEGA',
          action: 'Urgente + Non Importante',
          color: const Color(0xFFFDD835),
          icon: Icons.group,
        );
      case EisenhowerQuadrant.q4:
        return _QuadrantDisplayInfo(
          name: 'Q4 - ELIMINA',
          action: 'Non Urgente + Non Importante',
          color: const Color(0xFF9E9E9E),
          icon: Icons.delete_outline,
        );
    }
  }
}

class _QuadrantDisplayInfo {
  final String name;
  final String action;
  final Color color;
  final IconData icon;

  _QuadrantDisplayInfo({
    required this.name,
    required this.action,
    required this.color,
    required this.icon,
  });
}

/// Dialog per mostrare il reveal dei voti con animazione
class VoteRevealDialog extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final Map<String, EisenhowerParticipantModel> participants;

  const VoteRevealDialog({
    super.key,
    required this.activity,
    required this.participants,
  });

  static Future<void> show({
    required BuildContext context,
    required EisenhowerActivityModel activity,
    required Map<String, EisenhowerParticipantModel> participants,
  }) {
    return showDialog(
      context: context,
      builder: (context) => VoteRevealDialog(
        activity: activity,
        participants: participants,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.visibility, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Voti Rivelati', style: TextStyle(fontSize: 18)),
                Text(
                  activity.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: VoteRevealWidget(
          activity: activity,
          participants: participants,
          showAnimation: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Chiudi'),
        ),
      ],
    );
  }
}
