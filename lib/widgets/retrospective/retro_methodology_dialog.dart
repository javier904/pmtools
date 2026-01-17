import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';

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
    return AlertDialog(
      title: const Text('Scegli Metodologia'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: RetroTemplate.values.map((template) => _buildTemplateOption(template)).toList(),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annulla')),
        ElevatedButton(
          onPressed: () {
            widget.onSelect(_selectedTemplate);
            Navigator.pop(context);
          },
          child: const Text('Conferma'),
        ),
      ],
    );
  }

  Widget _buildTemplateOption(RetroTemplate template) {
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
                      template.displayName, 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 4),
                  Text(
                      template.description, 
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
                            template.usageSuggestion,
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
                            Text(col.title, style: TextStyle(fontSize: 10, color: Colors.grey[800])),
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
