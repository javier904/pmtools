import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../models/planning_poker_session_model.dart';
import '../../models/estimation_mode.dart';

/// Dialog per creare/modificare una sessione di Planning Poker
class SessionFormDialog extends StatefulWidget {
  final PlanningPokerSessionModel? session;

  const SessionFormDialog({super.key, this.session});

  @override
  State<SessionFormDialog> createState() => _SessionFormDialogState();
}

class _SessionFormDialogState extends State<SessionFormDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  // Configurazione
  String _selectedCardSet = 'fibonacci';
  EstimationMode _selectedEstimationMode = EstimationMode.fibonacci;
  bool _allowObservers = true;
  bool _autoReveal = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.session?.name ?? '');
    _descriptionController = TextEditingController(text: widget.session?.description ?? '');

    if (widget.session != null) {
      _selectedCardSet = _getCardSetKey(widget.session!.cardSet);
      _selectedEstimationMode = widget.session!.estimationMode;
      _allowObservers = widget.session!.allowObservers;
      _autoReveal = widget.session!.autoReveal;
    }
  }

  String _getCardSetKey(List<String> cardSet) {
    if (cardSet.length == PlanningPokerCardSet.tshirt.length &&
        cardSet.first == 'XS') {
      return 'tshirt';
    } else if (cardSet.length == PlanningPokerCardSet.simplified.length) {
      return 'simplified';
    }
    return 'fibonacci';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEdit = widget.session != null;

    return AlertDialog(
      title: Text(isEdit ? l10n.estimationEditSession : l10n.estimationNewSession),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.sessionNameRequired,
                  hintText: l10n.sessionNameHint,
                  border: const OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Descrizione
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.sessionDescription,
                  hintText: l10n.formDescriptionHint,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
              ),

              // Configurazione
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                l10n.sessionConfiguration,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Modalita di Stima
              DropdownButtonFormField<EstimationMode>(
                value: _selectedEstimationMode,
                decoration: InputDecoration(
                  labelText: l10n.sessionEstimationMode,
                  border: const OutlineInputBorder(),
                  isDense: true,
                  prefixIcon: Icon(_getEstimationModeIcon(_selectedEstimationMode), size: 20),
                ),
                items: EstimationMode.values.map((mode) => DropdownMenuItem(
                  value: mode,
                  child: Row(
                    children: [
                      Icon(_getEstimationModeIcon(mode), size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          mode.displayName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedEstimationMode = value;
                      // Auto-select appropriate card set based on mode
                      if (value == EstimationMode.tshirt) {
                        _selectedCardSet = 'tshirt';
                      } else if (value == EstimationMode.fibonacci) {
                        _selectedCardSet = 'fibonacci';
                      } else if (value == EstimationMode.fiveFingers) {
                        _selectedCardSet = 'simplified';
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              // Set di carte (solo per modalita che usano carte)
              if (_selectedEstimationMode == EstimationMode.fibonacci ||
                  _selectedEstimationMode == EstimationMode.fiveFingers) ...[
                DropdownButtonFormField<String>(
                  value: _selectedCardSet,
                  decoration: InputDecoration(
                    labelText: l10n.sessionCardSet,
                    border: const OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: const Icon(Icons.style, size: 20),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'fibonacci',
                      child: Text(l10n.cardSetFibonacci),
                    ),
                    DropdownMenuItem(
                      value: 'simplified',
                      child: Text(l10n.cardSetSimplified),
                    ),
                  ],
                  onChanged: (value) => setState(() => _selectedCardSet = value!),
                ),
                const SizedBox(height: 12),
              ],

              // Opzioni
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: _autoReveal,
                      onChanged: (value) => setState(() => _autoReveal = value!),
                      title: Text(l10n.sessionAutoReveal, style: const TextStyle(fontSize: 14)),
                      subtitle: Text(l10n.sessionAutoRevealDesc, style: const TextStyle(fontSize: 11)),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: _allowObservers,
                      onChanged: (value) => setState(() => _allowObservers = value!),
                      title: Text(l10n.sessionAllowObservers, style: const TextStyle(fontSize: 14)),
                      subtitle: Text(l10n.sessionAllowObserversDesc, style: const TextStyle(fontSize: 11)),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text(isEdit ? l10n.actionSave : l10n.actionCreate),
        ),
      ],
    );
  }

  /// Helper per ottenere l'icona della modalita di stima
  IconData _getEstimationModeIcon(EstimationMode mode) {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.functions_rounded; // Sigma/PERT formula
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.inventory_2_rounded; // Bucket/box icon
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.formTitleRequired)),
      );
      return;
    }

    // Determina il card set appropriato in base alla modalita
    List<String> cardSet;
    if (_selectedEstimationMode == EstimationMode.tshirt) {
      cardSet = PlanningPokerCardSet.tshirt;
    } else if (_selectedEstimationMode == EstimationMode.fiveFingers) {
      cardSet = ['1', '2', '3', '4', '5'];
    } else if (_selectedEstimationMode == EstimationMode.decimal ||
               _selectedEstimationMode == EstimationMode.threePoint) {
      // Per decimal e three-point, il card set non e usato ma serve un valore di default
      cardSet = PlanningPokerCardSet.fibonacci;
    } else {
      cardSet = PlanningPokerCardSet.all[_selectedCardSet] ?? PlanningPokerCardSet.fibonacci;
    }

    Navigator.pop(context, {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text.trim(),
      'cardSet': cardSet,
      'estimationMode': _selectedEstimationMode,
      'allowObservers': _allowObservers,
      'autoReveal': _autoReveal,
    });
  }
}
