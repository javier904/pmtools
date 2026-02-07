import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../themes/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per inserire il voto indipendente su un'attivita'
///
/// Mostra due slider per urgenza e importanza (1-10)
/// Il voto rimane nascosto fino al reveal
class IndependentVoteDialog extends StatefulWidget {
  final EisenhowerActivityModel activity;
  final String voterEmail;
  final String voterName;
  final EisenhowerVote? existingVote;

  const IndependentVoteDialog({
    super.key,
    required this.activity,
    required this.voterEmail,
    required this.voterName,
    this.existingVote,
  });

  /// Mostra il dialog e ritorna il voto o null se annullato
  static Future<EisenhowerVote?> show({
    required BuildContext context,
    required EisenhowerActivityModel activity,
    required String voterEmail,
    required String voterName,
    EisenhowerVote? existingVote,
  }) {
    return showDialog<EisenhowerVote>(
      context: context,
      barrierDismissible: false,
      builder: (context) => IndependentVoteDialog(
        activity: activity,
        voterEmail: voterEmail,
        voterName: voterName,
        existingVote: existingVote,
      ),
    );
  }

  @override
  State<IndependentVoteDialog> createState() => _IndependentVoteDialogState();
}

class _IndependentVoteDialogState extends State<IndependentVoteDialog> {
  late double _urgency;
  late double _importance;

  @override
  void initState() {
    super.initState();
    _urgency = widget.existingVote?.urgency.toDouble() ?? 5.0;
    _importance = widget.existingVote?.importance.toDouble() ?? 5.0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.how_to_vote, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.eisenhowerVoteSubmit, style: const TextStyle(fontSize: 18)),
                Text(
                  widget.activity.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textSecondaryColor,
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
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Info votante
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.green,
                    child: Text(
                      widget.voterName.isNotEmpty
                          ? widget.voterName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.eisenhowerVoterName(widget.voterName),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.lock, size: 16, color: context.textTertiaryColor),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Slider Urgenza
            _buildSliderSection(
              label: AppLocalizations.of(context)!.eisenhowerUrgency,
              value: _urgency,
              color: Colors.red,
              icon: Icons.warning_amber,
              lowLabel: AppLocalizations.of(context)!.eisenhowerUrgencyLow,
              highLabel: AppLocalizations.of(context)!.eisenhowerUrgencyHigh,
              onChanged: (v) => setState(() => _urgency = v),
            ),
            const SizedBox(height: 20),

            // Slider Importanza
            _buildSliderSection(
              label: AppLocalizations.of(context)!.eisenhowerImportance,
              value: _importance,
              color: Colors.green,
              icon: Icons.star,
              lowLabel: AppLocalizations.of(context)!.eisenhowerImportanceLow,
              highLabel: AppLocalizations.of(context)!.eisenhowerImportanceHigh,
              onChanged: (v) => setState(() => _importance = v),
            ),
            const SizedBox(height: 24),

            // Anteprima quadrante
            _buildQuadrantPreview(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.actionCancel),
        ),
        ElevatedButton.icon(
          onPressed: () {
            final vote = EisenhowerVote(
              urgency: _urgency.round(),
              importance: _importance.round(),
            );
            Navigator.pop(context, vote);
          },
          icon: const Icon(Icons.check),
          label: Text(AppLocalizations.of(context)!.actionConfirm),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderSection({
    required String label,
    required double value,
    required Color color,
    required IconData icon,
    required String lowLabel,
    required String highLabel,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: context.textSecondaryColor,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                value.round().toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
            valueIndicatorColor: color,
            valueIndicatorTextStyle: const TextStyle(color: Colors.white),
          ),
          child: Slider(
            value: value,
            min: 1,
            max: 10,
            divisions: 9,
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lowLabel,
                style: TextStyle(fontSize: 10, color: context.textTertiaryColor),
              ),
              Text(
                highLabel,
                style: TextStyle(fontSize: 10, color: context.textTertiaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuadrantPreview() {
    final quadrant = _calculateQuadrant();
    final quadrantInfo = _getQuadrantInfo(quadrant);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: quadrantInfo.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: quadrantInfo.color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: quadrantInfo.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(quadrantInfo.icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.eisenhowerQuadrantLabel(quadrantInfo.name),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  quadrantInfo.action,
                  style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateQuadrant() {
    final isUrgent = _urgency >= 5.5;
    final isImportant = _importance >= 5.5;

    if (isUrgent && isImportant) return 'Q1';
    if (!isUrgent && isImportant) return 'Q2';
    if (isUrgent && !isImportant) return 'Q3';
    return 'Q4';
  }

  _QuadrantInfo _getQuadrantInfo(String quadrant) {
    final l10n = AppLocalizations.of(context)!;
    switch (quadrant) {
      case 'Q1':
        return _QuadrantInfo(
          name: l10n.eisenhowerQ1Name,
          action: l10n.eisenhowerQ1Desc,
          color: Colors.red,
          icon: Icons.priority_high,
        );
      case 'Q2':
        return _QuadrantInfo(
          name: l10n.eisenhowerQ2Name,
          action: l10n.eisenhowerQ2Desc,
          color: Colors.green,
          icon: Icons.schedule,
        );
      case 'Q3':
        return _QuadrantInfo(
          name: l10n.eisenhowerQ3Name,
          action: l10n.eisenhowerQ3Desc,
          color: Colors.orange,
          icon: Icons.group,
        );
      default:
        return _QuadrantInfo(
          name: l10n.eisenhowerQ4Name,
          action: l10n.eisenhowerQ4Desc,
          color: Colors.grey,
          icon: Icons.delete_outline,
        );
    }
  }
}

class _QuadrantInfo {
  final String name;
  final String action;
  final Color color;
  final IconData icon;

  _QuadrantInfo({
    required this.name,
    required this.action,
    required this.color,
    required this.icon,
  });
}
