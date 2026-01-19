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
    return AlertDialog(
      title: Text(AppLocalizations.of(context)?.retroChooseMethodology ?? 'Scegli Metodologia'),
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
        TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.actionCancel ?? 'Annulla')),
        ElevatedButton(
          onPressed: () {
            widget.onSelect(_selectedTemplate);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)?.actionConfirm ?? 'Conferma'),
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
                      _getTemplateName(template, AppLocalizations.of(context)!), 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  const SizedBox(height: 4),
                  Text(
                      _getTemplateDesc(template, AppLocalizations.of(context)!), 
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
                            _getUsageSuggestion(template, AppLocalizations.of(context)!),
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

  String _getTemplateName(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroTemplateStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroTemplateSailboat;
      case RetroTemplate.fourLs: return l10n.retroTemplate4Ls;
      case RetroTemplate.starfish: return l10n.retroTemplateStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroTemplateMadSadGlad;
      case RetroTemplate.daki: return l10n.retroTemplateDAKI;
    }
  }

  String _getTemplateDesc(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroDescStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroDescSailboat;
      case RetroTemplate.fourLs: return l10n.retroDesc4Ls;
      case RetroTemplate.starfish: return l10n.retroDescStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroDescMadSadGlad;
      case RetroTemplate.daki: return l10n.retroDescDAKI;
    }
  }

  String _getUsageSuggestion(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroUsageStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroUsageSailboat;
      case RetroTemplate.fourLs: return l10n.retroUsage4Ls;
      case RetroTemplate.starfish: return l10n.retroUsageStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroUsageMadSadGlad;
      case RetroTemplate.daki: return l10n.retroUsageDAKI;
    }
  }
}
