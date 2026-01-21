import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/raci_models.dart';
import '../../services/eisenhower_firestore_service.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget per la gestione della Matrice RACI
class RaciMatrixWidget extends StatefulWidget {
  final EisenhowerMatrixModel matrix;
  final List<EisenhowerActivityModel> activities;
  final Function(EisenhowerActivityModel) onActivityTap;
  final Function(EisenhowerMatrixModel) onMatrixUpdate;
  final Function() onDataChanged;
  final VoidCallback? onAddActivity;

  const RaciMatrixWidget({
    super.key,
    required this.matrix,
    required this.activities,
    required this.onActivityTap,
    required this.onMatrixUpdate,
    required this.onDataChanged,
    this.onAddActivity,
  });

  @override
  State<RaciMatrixWidget> createState() => _RaciMatrixWidgetState();
}

class _RaciMatrixWidgetState extends State<RaciMatrixWidget> {
  final EisenhowerFirestoreService _firestoreService = EisenhowerFirestoreService();
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  Map<String, Map<String, RaciRole>> _tempAssignments = {};
  Set<String> _dirtyActivityIds = {};
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initializeAssignments();
  }

  @override
  void didUpdateWidget(covariant RaciMatrixWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activities != widget.activities) {
      _initializeAssignments();
    }
  }

  void _initializeAssignments() {
    if (_dirtyActivityIds.isEmpty) {
       _tempAssignments = {};
       for (final activity in widget.activities) {
         _tempAssignments[activity.id] = Map.from(activity.raciAssignments);
       }
    }
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (widget.activities.isEmpty) {
      return Center(child: Text(l10n.raciNoActivities));
    }

    // Sort activities: Q1 -> Q2 -> Q3 -> Q4, then Score descending
    final sortedActivities = List<EisenhowerActivityModel>.from(widget.activities);
    sortedActivities.sort((a, b) {
      final qA = a.quadrant?.index ?? 99;
      final qB = b.quadrant?.index ?? 99;
      if (qA != qB) return qA.compareTo(qB);
      final scoreA = (a.aggregatedUrgency) + (a.aggregatedImportance);
      final scoreB = (b.aggregatedUrgency) + (b.aggregatedImportance);
      return scoreB.compareTo(scoreA);
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToolbar(),
          const Divider(height: 1),
          Expanded(
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderRow(),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _verticalController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: sortedActivities.map((d) => _buildDataRow(d)).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _buildLegend(),
        ],
      ),
      floatingActionButton: _dirtyActivityIds.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _isSaving ? null : _saveChanges,
              backgroundColor: AppColors.primary,
              icon: _isSaving
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.save),
              label: Text(_isSaving ? l10n.raciSaving : '${l10n.raciSaveChanges} (${_dirtyActivityIds.length})'),
            )
          : null,
    );
  }

  Widget _buildToolbar() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: context.surfaceVariantColor,
      child: Row(
        children: [
          Icon(Icons.table_chart, size: 20, color: context.textSecondaryColor),
          const SizedBox(width: 8),
          Text(
            l10n.raciTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimaryColor),
          ),
          const Spacer(),
          if (widget.onAddActivity != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton.icon(
                onPressed: widget.onAddActivity,
                icon: const Icon(Icons.add, size: 18),
                label: Text(l10n.raciAddActivity),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
            ),
          ElevatedButton.icon(
            onPressed: _showAddColumnDialog,
            icon: const Icon(Icons.add_circle_outline, size: 18),
            label: Text(l10n.raciAddColumn),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.surfaceColor,
              foregroundColor: AppColors.primary,
              elevation: 0,
              side: BorderSide(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        border: Border(bottom: BorderSide(color: context.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.centerLeft,
            child: Text(l10n.raciActivities, style: TextStyle(fontWeight: FontWeight.bold, color: context.textSecondaryColor)),
          ),
          ...widget.matrix.raciColumns.map((col) => _buildColumnHeader(col)),
        ],
      ),
    );
  }

  Widget _buildColumnHeader(RaciColumn col) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: context.borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  col.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: context.textPrimaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  col.type.name.toUpperCase(),
                  style: TextStyle(fontSize: 9, color: context.textSecondaryColor),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _confirmDeleteColumn(col),
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.close, size: 14, color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(EisenhowerActivityModel activity) {
    final validationErrors = _validateRow(activity);
    final hasErrors = validationErrors.isNotEmpty;

    Color rowColor = context.surfaceColor;
    if (hasErrors) {
      rowColor = AppColors.error.withOpacity(0.05);
    } else {
      rowColor = AppColors.success.withOpacity(0.05);
    }

    return Container(
      decoration: BoxDecoration(
        color: rowColor,
        border: Border(bottom: BorderSide(color: context.borderColor)),
      ),
      child: Row(
        children: [
          Container(
            width: 300,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (hasErrors)
                   Tooltip(
                     message: validationErrors.join('\n'),
                     child: const Padding(
                       padding: EdgeInsets.only(right: 8),
                       child: Icon(Icons.warning_amber, color: AppColors.error, size: 18),
                     ),
                   )
                else
                   const Padding(
                       padding: EdgeInsets.only(right: 8),
                       child: Icon(Icons.check_circle_outline, color: AppColors.success, size: 18),
                   ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.title, style: TextStyle(fontWeight: FontWeight.w500, color: context.textPrimaryColor)),
                      if (activity.description.isNotEmpty)
                        Text(
                          activity.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: context.textTertiaryColor),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...widget.matrix.raciColumns.map((col) => _buildAssignmentCell(activity, col)),
        ],
      ),
    );
  }

  Widget _buildAssignmentCell(EisenhowerActivityModel activity, RaciColumn col) {
    final currentRole = _tempAssignments[activity.id]?[col.id];

    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: context.borderColor)),
      ),
      alignment: Alignment.center,
      child: _buildRoleDropdown(activity, col, currentRole),
    );
  }

  Widget _buildRoleDropdown(EisenhowerActivityModel activity, RaciColumn col, RaciRole? currentRole) {
      return PopupMenuButton<RaciRole?>(
        tooltip: 'Assegna ruolo',
        onSelected: (role) => _updateAssignment(activity, col.id, role),
        itemBuilder: (ctx) => [
          PopupMenuItem(
            value: null,
            child: Text('Nessuno', style: TextStyle(color: ctx.textMutedColor)),
          ),
          ...RaciRole.values.map((r) => PopupMenuItem(
            value: r,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: r.color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(r.label, style: TextStyle(color: r.color, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Text(r.fullName),
              ],
            ),
          )),
        ],
        child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
           decoration: BoxDecoration(
             color: currentRole?.color.withOpacity(0.1) ?? Colors.transparent,
             borderRadius: BorderRadius.circular(4),
             border: currentRole != null ? Border.all(color: currentRole.color.withOpacity(0.3)) : null,
           ),
           child: currentRole != null
               ? Text(currentRole.label, style: TextStyle(color: currentRole.color, fontWeight: FontWeight.bold))
               : Icon(Icons.add, size: 16, color: context.textMutedColor),
        ),
      );
  }

  void _updateAssignment(EisenhowerActivityModel activity, String colId, RaciRole? role) {
    setState(() {
      if (_tempAssignments[activity.id] == null) _tempAssignments[activity.id] = {};

      if (role == null) {
        _tempAssignments[activity.id]?.remove(colId);
      } else {
        _tempAssignments[activity.id]![colId] = role;
      }

      _dirtyActivityIds.add(activity.id);
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);

    try {
      final futures = <Future>[];

      for (final activityId in _dirtyActivityIds) {
        final assignments = _tempAssignments[activityId] ?? {};
        futures.add(
          _firestoreService.updateActivityRaci(
            widget.matrix.id,
            activityId,
            assignments,
          )
        );
      }

      await Future.wait(futures);

      setState(() {
        _dirtyActivityIds.clear();
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Modifiche salvate correttamente"), backgroundColor: AppColors.success),
        );
      }

      widget.onDataChanged();

    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Errore salvataggio: $e"), backgroundColor: AppColors.error),
        );
      }
    }
  }

  List<String> _validateRow(EisenhowerActivityModel activity) {
    final assignments = _tempAssignments[activity.id] ?? {};
    final errors = <String>[];

    int accountableCount = 0;
    int responsibleCount = 0;

    for (var role in assignments.values) {
      if (role == RaciRole.accountable) accountableCount++;
      if (role == RaciRole.responsible) responsibleCount++;
    }

    if (accountableCount == 0) errors.add("Manca Accountable (A)");
    if (accountableCount > 1) errors.add("Troppi Accountable (A). Ce ne deve essere solo uno.");
    if (responsibleCount == 0) errors.add("Manca Responsible (R)");

    return errors;
  }

  Future<void> _showAddColumnDialog() async {
     final participantNames = widget.matrix.participants.values.map((p) => p.name).toList();

     final result = await showDialog<RaciColumn>(
       context: context,
       builder: (context) => _AddRaciColumnDialog(
         availableParticipants: participantNames,
       ),
     );

     if (result != null) {
        final newColumns = List<RaciColumn>.from(widget.matrix.raciColumns)..add(result);
        await _updateMatrixColumns(newColumns);
     }
  }

  Future<void> _confirmDeleteColumn(RaciColumn col) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Elimina Colonna"),
        content: Text("Vuoi eliminare la colonna '${col.name}'? Le assegnazioni relative verranno perse."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Annulla")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), style: ElevatedButton.styleFrom(backgroundColor: AppColors.error), child: const Text("Elimina")),
        ],
      )
    );

    if (confirm == true) {
      final newColumns = List<RaciColumn>.from(widget.matrix.raciColumns)..removeWhere((c) => c.id == col.id);
      await _updateMatrixColumns(newColumns);
    }
  }

  Future<void> _updateMatrixColumns(List<RaciColumn> newColumns) async {
    try {
      await _firestoreService.updateRaciColumns(widget.matrix.id, newColumns);

      final updatedMatrix = await _firestoreService.getMatrix(widget.matrix.id);
      if (updatedMatrix != null) {
        widget.onMatrixUpdate(updatedMatrix);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Errore aggiornamento colonne: $e")));
      }
    }
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: context.surfaceColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: RaciRole.values.map((role) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Tooltip(
              message: role.description,
              child: Row(
                children: [
                  Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(color: role.color.withOpacity(0.2), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text(role.label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: role.color)),
                  ),
                  const SizedBox(width: 4),
                  Text(role.fullName, style: TextStyle(fontSize: 12, color: context.textPrimaryColor)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AddRaciColumnDialog extends StatefulWidget {
  final List<String> availableParticipants;
  const _AddRaciColumnDialog({required this.availableParticipants});

  @override
  State<_AddRaciColumnDialog> createState() => _AddRaciColumnDialogState();
}

class _AddRaciColumnDialogState extends State<_AddRaciColumnDialog> {
  RaciColumnType _type = RaciColumnType.person;
  String? _selectedParticipant;
  final TextEditingController _customNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Aggiungi Colonna RACI"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<RaciColumnType>(
            value: _type,
            decoration: const InputDecoration(labelText: 'Tipo'),
            items: const [
              DropdownMenuItem(value: RaciColumnType.person, child: Text("Persona (Partecipante)")),
              DropdownMenuItem(value: RaciColumnType.custom, child: Text("Personalizzato (Team/Altro)")),
            ],
            onChanged: (v) => setState(() => _type = v!),
          ),
          const SizedBox(height: 16),
          if (_type == RaciColumnType.person)
            DropdownButtonFormField<String>(
              value: _selectedParticipant,
              hint: const Text("Seleziona partecipante"),
              items: widget.availableParticipants.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _selectedParticipant = v),
            )
          else
            TextField(
              controller: _customNameController,
              decoration: const InputDecoration(labelText: "Nome Colonna", hintText: "Es. Team Legale"),
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annulla")),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Aggiungi"),
        ),
      ],
    );
  }

  void _submit() {
    String name;
    if (_type == RaciColumnType.person) {
      if (_selectedParticipant == null) return;
      name = _selectedParticipant!;
    } else {
      if (_customNameController.text.trim().isEmpty) return;
      name = _customNameController.text.trim();
    }

    final col = RaciColumn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      type: _type,
      referenceId: _type == RaciColumnType.person ? name : null,
    );
    Navigator.pop(context, col);
  }
}
