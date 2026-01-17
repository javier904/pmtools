import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AgileCoachOverlay extends StatefulWidget {
  final RetroPhase phase;

  const AgileCoachOverlay({Key? key, required this.phase}) : super(key: key);

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
                    'Agile Coach',
                    style: TextStyle(color: fgColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _getCoachMessage(),
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

  String _getCoachMessage() {
    switch (widget.phase) {
      case RetroPhase.setup:
        return 'Scegliete un template. "Start/Stop/Continue" è ottimo per i nuovi team. Assicuratevi che tutti siano presenti.';
      case RetroPhase.icebreaker:
        return 'Rompete il ghiaccio! Fate un giro veloce chiedendo "Come state?" o usando una domanda divertente.';
      case RetroPhase.writing:
        return 'Siamo in modalità INCOGNITO. Scrivete le card liberamente, nessuno vedrà cosa scrivete fino alla fine. Evitate bias!';
      case RetroPhase.voting:
        return 'Review Time! Tutte le card sono visibili. Leggetele e usate i vostri 3 voti per decidere di cosa discutere.';
      case RetroPhase.discuss:
        return 'Focus sulle card più votate. Definite Action Item chiari: Chi fa cosa entro quando?';
      case RetroPhase.completed:
        return 'Ottimo lavoro! La retrospettiva è conclusa. Gli Action Item sono stati inviati al Backlog.';
    }
  }
}

