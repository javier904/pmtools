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

  const RetroBoardWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
    required this.isIncognito,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Strategy Dispatcher
    switch (retro.template) {
      case RetroTemplate.sailboat:
      case RetroTemplate.starfish: // Assuming Starfish also uses Canvas logic or similar
        return RetroCanvasWidget(
          retro: retro,
          currentUserEmail: currentUserEmail,
          currentUserName: currentUserName,
        );

      case RetroTemplate.fourLs:
      case RetroTemplate.madSadGlad:
      case RetroTemplate.startStopContinue:
      default:
        // Standard Column-based templates
        return RetroLinearBoardWidget(
          retro: retro,
          currentUserEmail: currentUserEmail,
          currentUserName: currentUserName,
        );
    }
  }
}
