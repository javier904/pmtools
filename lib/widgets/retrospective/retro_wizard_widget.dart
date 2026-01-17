import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/widgets/retrospective/retro_column_widget.dart';
import 'package:flutter/material.dart';

class RetroWizardWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final String currentUserEmail;
  final String currentUserName;
  final bool isFacilitator;

  const RetroWizardWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
    required this.isFacilitator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (retro.columns.isEmpty) return const SizedBox();

    final int currentStep = retro.currentWizardStep.clamp(0, retro.columns.length - 1);
    final column = retro.columns[currentStep];

    return Column(
      children: [
        // Stepper Header
        _buildStepperHeader(context, currentStep),
        
        // Active Column View
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RetroColumnWidget(
              retro: retro,
              column: column,
              currentUserEmail: currentUserEmail,
              currentUserName: currentUserName,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepperHeader(BuildContext context, int currentStep) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
            // Progress Indicators
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(retro.columns.length, (index) {
                    final bool isActive = index == currentStep;
                    final bool isCompleted = index < currentStep;
                    return Container(
                        width: 12, height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive 
                                ? Theme.of(context).primaryColor 
                                : (isCompleted ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey.shade300),
                        ),
                    );
                }),
            ),
            const SizedBox(height: 8),
            // Navigation Controls (Facilitator only)
            if (isFacilitator)
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                       IconButton(
                           icon: const Icon(Icons.arrow_back),
                           onPressed: currentStep > 0 
                             ? () => _updateStep(currentStep - 1)
                             : null,
                       ),
                       Text(
                           "Step ${currentStep + 1}: ${retro.columns[currentStep].title}",
                           style: const TextStyle(fontWeight: FontWeight.bold),
                       ),
                       IconButton(
                           icon: const Icon(Icons.arrow_forward),
                           onPressed: currentStep < retro.columns.length - 1
                             ? () => _updateStep(currentStep + 1)
                             : null,
                       ),
                   ],
                )
            else
               Text(
                   "Current Focus: ${retro.columns[currentStep].title}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
               )
        ],
      ),
    );
  }

  void _updateStep(int step) {
      RetrospectiveFirestoreService().updateWizardStep(
          retro.id, 
          step, 
          currentUserEmail, 
          currentUserName
      );
  }
}
