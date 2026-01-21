import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final quadrant = widget.activity.quadrant;
    final quadrantInfo = quadrant != null ? _getQuadrantInfo(quadrant, l10n) : null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: quadrantInfo?.color.withValues(alpha: 0.4) ?? (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con risultato
            _buildResultHeader(quadrantInfo, l10n, isDark, textColor),
            const SizedBox(height: 10),
            Divider(color: isDark ? Colors.grey[700] : Colors.grey[300], height: 1),
            const SizedBox(height: 8),

            // Voti individuali
            Text(
              l10n.eisenhowerIndividualVotes,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6),
            ...widget.activity.votes.entries.map((entry) =>
                _buildVoteRow(entry.key, entry.value, l10n, isDark, textColor)),

            // Aggregato
            if (widget.activity.votes.isNotEmpty) ...[
              const SizedBox(height: 6),
              Divider(color: isDark ? Colors.grey[700] : Colors.grey[300], height: 1),
              const SizedBox(height: 6),
              _buildAggregateRow(l10n, isDark),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultHeader(_QuadrantDisplayInfo? quadrantInfo, AppLocalizations l10n, bool isDark, Color textColor) {
    if (quadrantInfo == null) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: isDark ? Colors.grey[400] : Colors.grey),
            const SizedBox(width: 8),
            Text(l10n.eisenhowerNoVotesRecorded, style: TextStyle(color: textColor)),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: quadrantInfo.color.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: quadrantInfo.color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(quadrantInfo.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      l10n.eisenhowerResult,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  quadrantInfo.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: quadrantInfo.color,
                  ),
                ),
                Text(
                  quadrantInfo.action,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteRow(String voterEmail, EisenhowerVote vote, AppLocalizations l10n, bool isDark, Color textColor) {
    // Unescape l'email (da _DOT_ a .) per cercare nel participants map
    final unescapedEmail = EisenhowerParticipantModel.unescapeEmail(voterEmail).toLowerCase();
    final participant = widget.participants[unescapedEmail];
    final voterName = participant?.name ?? unescapedEmail.split('@').first;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: isDark ? Colors.blue.withValues(alpha: 0.3) : Colors.blue.withValues(alpha: 0.2),
            child: Text(
              voterName.isNotEmpty ? voterName[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: 10,
                color: isDark ? Colors.blue[300] : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              voterName,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: textColor),
            ),
          ),
           _buildVoteBadge(l10n.eisenhowerUrgencyShort, vote.urgency, Colors.red, isDark),
           const SizedBox(width: 6),
           _buildVoteBadge(l10n.eisenhowerImportanceShort, vote.importance, Colors.green, isDark),
        ],
      ),
    );
  }

  Widget _buildVoteBadge(String label, int value, Color color, bool isDark) {
    final badgeColor = isDark ? color.withValues(alpha: 0.3) : color.withValues(alpha: 0.15);
    final textColorAdjusted = isDark ? Color.lerp(color, Colors.white, 0.3)! : color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: textColorAdjusted,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColorAdjusted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAggregateRow(AppLocalizations l10n, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.functions, color: isDark ? Colors.grey[400] : Colors.grey, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              l10n.eisenhowerAverage,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: isDark ? Colors.grey[400] : Colors.grey,
              ),
            ),
          ),
          _buildVoteBadge(
            l10n.eisenhowerUrgencyShort,
            widget.activity.aggregatedUrgency.round(),
            Colors.red,
            isDark,
          ),
          const SizedBox(width: 6),
          _buildVoteBadge(
            l10n.eisenhowerImportanceShort,
            widget.activity.aggregatedImportance.round(),
            Colors.green,
            isDark,
          ),
        ],
      ),
    );
  }

  _QuadrantDisplayInfo _getQuadrantInfo(EisenhowerQuadrant quadrant, AppLocalizations l10n) {
    switch (quadrant) {
      case EisenhowerQuadrant.q1:
        return _QuadrantDisplayInfo(
          name: 'Q1 - ${quadrant.localizedTitle(l10n)}',
          action: quadrant.localizedSubtitle(l10n),
          color: const Color(0xFFE53935),
          icon: Icons.priority_high,
        );
      case EisenhowerQuadrant.q2:
        return _QuadrantDisplayInfo(
          name: 'Q2 - ${quadrant.localizedTitle(l10n)}',
          action: quadrant.localizedSubtitle(l10n),
          color: const Color(0xFF43A047),
          icon: Icons.schedule,
        );
      case EisenhowerQuadrant.q3:
        return _QuadrantDisplayInfo(
          name: 'Q3 - ${quadrant.localizedTitle(l10n)}',
          action: quadrant.localizedSubtitle(l10n),
          color: const Color(0xFFFDD835),
          icon: Icons.group,
        );
      case EisenhowerQuadrant.q4:
        return _QuadrantDisplayInfo(
          name: 'Q4 - ${quadrant.localizedTitle(l10n)}',
          action: quadrant.localizedSubtitle(l10n),
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
  final VoidCallback? onNextActivity;
  final bool hasNextActivity;

  const VoteRevealDialog({
    super.key,
    required this.activity,
    required this.participants,
    this.onNextActivity,
    this.hasNextActivity = false,
  });

  static Future<void> show({
    required BuildContext context,
    required EisenhowerActivityModel activity,
    required Map<String, EisenhowerParticipantModel> participants,
    VoidCallback? onNextActivity,
    bool hasNextActivity = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) => VoteRevealDialog(
        activity: activity,
        participants: participants,
        onNextActivity: onNextActivity,
        hasNextActivity: hasNextActivity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      titlePadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      title: Row(
        children: [
          const Icon(Icons.visibility, color: Colors.amber, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.eisenhowerVotesRevealed, style: const TextStyle(fontSize: 16, color: Colors.amber)),
                Text(
                  activity.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
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
        width: 340,
        child: VoteRevealWidget(
          activity: activity,
          participants: participants,
          showAnimation: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionClose),
        ),
        // Pulsante "Prossima Attività" (solo se c'è un'altra attività da votare)
        if (hasNextActivity && onNextActivity != null)
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              onNextActivity!();
            },
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: Text(l10n.eisenhowerNextActivity),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
      ],
    );
  }
}
