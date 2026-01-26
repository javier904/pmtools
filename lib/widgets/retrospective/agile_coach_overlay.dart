import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class AgileCoachOverlay extends StatefulWidget {
  final RetroPhase phase;
  final RetroTemplate? template;

  const AgileCoachOverlay({
    Key? key,
    required this.phase,
    this.template,
  }) : super(key: key);

  @override
  State<AgileCoachOverlay> createState() => _AgileCoachOverlayState();
}

class _AgileCoachOverlayState extends State<AgileCoachOverlay> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    // Use primary color for the coach bubble to match the app theme
    final bgColor = Theme.of(context).colorScheme.primary;
    final fgColor = Theme.of(context).colorScheme.onPrimary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isExpanded ? 300 : 60,
      height: _isExpanded ? 160 : 60,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: _isExpanded ? _buildExpandedContent(fgColor) : _buildCollapsedContent(),
    );
  }

  Widget _buildCollapsedContent() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = true),
      child: const Center(
        child: Icon(Icons.lightbulb_outline, color: Colors.amberAccent, size: 30),
      ),
    );
  }

  Widget _buildExpandedContent(Color fgColor) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () => setState(() => _isExpanded = false),
            child: Icon(Icons.close, color: fgColor.withOpacity(0.7), size: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, color: fgColor),
                  const SizedBox(width: 8),
                  Text(
                    l10n.retroAgileCoach,
                    style: TextStyle(color: fgColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _getCoachMessage(l10n),
                    style: TextStyle(color: fgColor.withOpacity(0.9), fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCoachMessage(AppLocalizations l10n) {
    // For writing, voting, discuss phases: use template-specific tips if template is available
    if (widget.template != null &&
        (widget.phase == RetroPhase.writing ||
         widget.phase == RetroPhase.voting ||
         widget.phase == RetroPhase.discuss)) {
      return RetroMethodologyGuide.getCoachTip(l10n, widget.template!, widget.phase);
    }

    // For other phases: use generic phase tips
    switch (widget.phase) {
      case RetroPhase.setup:
        return l10n.retroCoachSetup;
      case RetroPhase.icebreaker:
        return l10n.retroCoachIcebreaker;
      case RetroPhase.writing:
        return l10n.retroCoachWriting;
      case RetroPhase.voting:
        return l10n.retroCoachVoting;
      case RetroPhase.discuss:
        return l10n.retroCoachDiscuss;
      case RetroPhase.completed:
        return l10n.retroCoachCompleted;
    }
  }
}
