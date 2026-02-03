import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class TransitionFallbackDialog extends StatefulWidget {
  final String transitionName;
  final List<dynamic> requiredFields; // Metadati dei campi richiesti da Jira

  const TransitionFallbackDialog({
    super.key,
    required this.transitionName,
    required this.requiredFields,
  });

  @override
  State<TransitionFallbackDialog> createState() => _TransitionFallbackDialogState();
}

class _TransitionFallbackDialogState extends State<TransitionFallbackDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formValues = {};

  @override
  void initState() {
    super.initState();
    // Inizializza valori di default se necessario
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.jiraTransitionTitle(widget.transitionName)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.jiraTransitionInfo),
              const SizedBox(height: 16),
              ...widget.requiredFields.map((field) => _buildField(field, l10n)),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Annulla
          child: Text(l10n.jiraTransitionCancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.jiraTransitionConfirm),
        ),
      ],
    );
  }

  Widget _buildField(dynamic field, AppLocalizations l10n) {
    final String key = field['key'];
    final String name = field['name'];
    final String type = field['schema']['type'];
    final List<dynamic>? allowedValues = field['allowedValues'];

    // Gestione Dropdown (es. Resolution)
    if (allowedValues != null && allowedValues.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButtonFormField<dynamic>(
          decoration: InputDecoration(
            labelText: name,
            border: const OutlineInputBorder(),
          ),
          items: allowedValues.map((val) {
            return DropdownMenuItem(
              value: val,
              child: Text(val['name'] ?? val['value'] ?? 'Unknown'),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              // Jira tipicamente vuole l'oggetto id o value
              _formValues[key] = {'id': val['id']}; 
            }
          },
          validator: (val) => val == null ? l10n.jiraFieldRequired : null,
        ),
      );
    }

    // Gestione Testo generica
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: name,
          border: const OutlineInputBorder(),
        ),
        onChanged: (val) => _formValues[key] = val,
        validator: (val) => (val == null || val.isEmpty) ? l10n.jiraFieldRequired : null,
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_formValues);
    }
  }
}
