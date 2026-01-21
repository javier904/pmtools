import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class RetroMethodologyDialog extends StatefulWidget {
  final Function(RetroTemplate) onSelect;

  const RetroMethodologyDialog({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<RetroMethodologyDialog> createState() => _RetroMethodologyDialogState();
}

class _RetroMethodologyDialogState extends State<RetroMethodologyDialog> {
  RetroTemplate _selectedTemplate = RetroTemplate.startStopContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.retroChooseMethodology),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: RetroTemplate.values.map((template) => _buildTemplateOption(template, l10n)).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.actionCancel)),
        ElevatedButton(
          onPressed: () {
            widget.onSelect(_selectedTemplate);
            Navigator.pop(context);
          },
          child: Text(l10n.actionConfirm),
        ),
      ],
    );
  }

  Widget _buildTemplateOption(RetroTemplate template, AppLocalizations l10n) {
    final isSelected = _selectedTemplate == template;
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () => setState(() => _selectedTemplate = template),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? theme.primaryColor : Colors.grey.shade300, 
              width: 2
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? theme.primaryColor.withOpacity(0.05) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      template.getLocalizedDisplayName(l10n), 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 4),
                  Text(
                      template.getLocalizedDescription(l10n), 
                      style: TextStyle(color: Colors.grey[600], fontSize: 13)
                  ),
                  const SizedBox(height: 8),
                  // Usage Suggestion
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, size: 14, color: Colors.blue),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            template.getLocalizedUsageSuggestion(l10n),
                            style: const TextStyle(
                              color: Colors.blue, 
                              fontSize: 12, 
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Column Preview
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: template.defaultColumns.map((col) => Container(
                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                       decoration: BoxDecoration(
                         color: col.color.withOpacity(0.2),
                         borderRadius: BorderRadius.circular(4),
                         border: Border.all(color: col.color.withOpacity(0.5)),
                       ),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                            Icon(col.icon, size: 10, color: col.color),
                            const SizedBox(width: 4),
                            Text(col.getLocalizedTitle(l10n), style: TextStyle(fontSize: 10, color: Colors.grey[800])),
                         ],
                       ),
                    )).toList(),
                  )
                ],
              ),
            ),
            if (isSelected) 
               Icon(Icons.check_circle, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }
}
