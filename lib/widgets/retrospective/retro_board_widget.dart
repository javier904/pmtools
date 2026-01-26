import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_canvas_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_linear_board_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_wizard_widget.dart';
import 'package:flutter/material.dart';

class RetroBoardWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final String currentUserEmail;
  final String currentUserName;
  final bool isIncognito; 
  final bool showAuthorNames; // New Parameter

  const RetroBoardWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
    required this.isIncognito,
    this.showAuthorNames = true, // Default true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Strategy Dispatcher
    switch (retro.template) {
      case RetroTemplate.sailboat:
        // Only Sailboat uses canvas visual (boat metaphor)
        return RetroCanvasWidget(
          retro: retro,
          currentUserEmail: currentUserEmail,
          currentUserName: currentUserName,
        );

      case RetroTemplate.starfish:
      case RetroTemplate.fourLs:
      case RetroTemplate.madSadGlad:
      case RetroTemplate.startStopContinue:
      case RetroTemplate.daki:
      default:
        // Standard Column-based templates (including Starfish with 5 columns)
        return RetroLinearBoardWidget(
          retro: retro,
          currentUserEmail: currentUserEmail,
          currentUserName: currentUserName,
          showAuthorNames: showAuthorNames,
        );
    }
  }
}
