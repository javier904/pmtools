import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../../models/planning_poker_session_model.dart';
import '../../models/estimation_mode.dart';
import '../../utils/validators.dart';

/// Data class for preloaded stories (from Smart Todo export)
class PreloadedStory {
  final String title;
  final String description;
  final String? sourceTaskId;
  final String? sourceListId;

  const PreloadedStory({
    required this.title,
    this.description = '',
    this.sourceTaskId,
    this.sourceListId,
  });
}

/// Dialog per creare/modificare una sessione di Planning Poker
class SessionFormDialog extends StatefulWidget {
  final PlanningPokerSessionModel? session;
  final List<PreloadedStory>? preloadedStories;
  final String? suggestedName;

  const SessionFormDialog({
    super.key,
    this.session,
    this.preloadedStories,
    this.suggestedName,
  });

  @override
  State<SessionFormDialog> createState() => _SessionFormDialogState();
}

class _SessionFormDialogState extends State<SessionFormDialog> {
  final _formKey = GlobalKey<FormState>();
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
    _nameController = TextEditingController(
      text: widget.session?.name ?? widget.suggestedName ?? '',
    );
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

  /// Verifica se la votazione è già iniziata (non si può cambiare modalità)
  /// Blocca se: sessione active, oppure ha storie completate, oppure ha una story in votazione
  bool get _isVotingStarted {
    if (widget.session == null) return false;
    final session = widget.session!;
    return session.status == PlanningPokerSessionStatus.active ||
        session.completedStoryCount > 0 ||
        session.currentStoryId != null;
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
          child: Form(
            key: _formKey,
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome (con validazione)
              TextFormField(
                controller: _nameController,
                maxLength: Validators.maxTitleLength,
                validator: (v) => Validators.title(v, fieldName: l10n.sessionNameRequired),
                decoration: InputDecoration(
                  labelText: l10n.sessionNameRequired,
                  hintText: l10n.sessionNameHint,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                  ),
                ),
                cursorColor: Colors.amber,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Descrizione (con validazione opzionale)
              TextFormField(
                controller: _descriptionController,
                maxLength: Validators.maxDescriptionLength,
                validator: Validators.description,
                decoration: InputDecoration(
                  labelText: l10n.sessionDescription,
                  hintText: l10n.formDescriptionHint,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                  ),
                ),
                cursorColor: Colors.amber,
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
              // Blocca il cambio modalità se la sessione è già attiva (votazione iniziata)
              DropdownButtonFormField<EstimationMode>(
                value: _selectedEstimationMode,
                decoration: InputDecoration(
                  labelText: l10n.sessionEstimationMode,
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber, width: 2.0),
                  ),
                  isDense: true,
                  prefixIcon: Icon(_getEstimationModeIcon(_selectedEstimationMode), size: 20, color: Colors.amber),
                  helperText: _isVotingStarted ? l10n.sessionEstimationModeLocked : null,
                  helperStyle: const TextStyle(color: Colors.orange, fontSize: 11),
                ),
                items: EstimationMode.values.map((mode) => DropdownMenuItem(
                  value: mode,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_getEstimationModeIcon(mode), size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        _getModeDisplayName(mode, l10n),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )).toList(),
                onChanged: _isVotingStarted ? null : (value) {
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
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2.0),
                    ),
                    isDense: true,
                    prefixIcon: const Icon(Icons.style, size: 20, color: Colors.amber),
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
                      activeColor: Colors.amber,
                      checkColor: Colors.white,
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
                      activeColor: Colors.amber,
                      checkColor: Colors.white,
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
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          ),
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

  String _getModeDisplayName(EstimationMode mode, AppLocalizations l10n) {
    switch (mode) {
      case EstimationMode.fibonacci:
        return l10n.estimationModeFibonacci;
      case EstimationMode.tshirt:
        return l10n.estimationModeTshirt;
      case EstimationMode.decimal:
        return l10n.estimationModeDecimal;
      case EstimationMode.threePoint:
        return l10n.estimationModeThreePoint;
      case EstimationMode.dotVoting:
        return l10n.estimationModeDotVoting;
      case EstimationMode.bucketSystem:
        return l10n.estimationModeBucketSystem;
      case EstimationMode.fiveFingers:
        return l10n.estimationModeFiveFingers;
    }
  }

  void _save() {
    // 🔒 SICUREZZA: Usa validazione Form invece di controllo manuale
    if (!_formKey.currentState!.validate()) {
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
      if (widget.preloadedStories != null) 'preloadedStories': widget.preloadedStories,
    });
  }
}
