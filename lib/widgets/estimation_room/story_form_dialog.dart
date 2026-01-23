import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per creare una nuova story
class StoryFormDialog extends StatefulWidget {
  const StoryFormDialog({super.key});

  @override
  State<StoryFormDialog> createState() => _StoryFormDialogState();
}

class _StoryFormDialogState extends State<StoryFormDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.estimationNewStoryTitle),
      content: SizedBox(
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.estimationStoryTitleLabel,
                hintText: l10n.estimationStoryTitleHint,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l10n.estimationStoryDescriptionLabel,
                hintText: l10n.estimationStoryDescriptionHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.estimationEnterTitleAlert)),
              );
              return;
            }
            Navigator.pop(context, {
              'title': _titleController.text.trim(),
              'description': _descriptionController.text.trim(),
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.actionAdd),
        ),
      ],
    );
  }
}
