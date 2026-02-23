import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/user_profile_service.dart';
import '../themes/app_theme.dart';

/// Dialog per raccogliere feedback con valutazione in stelline (1-5)
///
/// Mostrato una sola volta dopo il 3° login.
/// Se l'utente declina ("Non ora"), si ripropone al login successivo.
/// Se l'utente vota, non viene più mostrato.
class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key});

  /// Mostra il dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const FeedbackDialog(),
    );
  }

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) return;

    setState(() => _isSubmitting = true);

    try {
      final profileService = UserProfileService();
      final settings = await profileService.getCurrentSettings();
      if (settings == null) return;

      final updatedSettings = settings
          .updateModuleSetting('feedback', 'rating', _rating)
          .updateModuleSetting('feedback', 'comment', _commentController.text.trim())
          .updateModuleSetting('feedback', 'ratedAt', DateTime.now().toIso8601String());

      await profileService.updateSettings(updatedSettings);

      if (mounted) {
        Navigator.of(context).pop();
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.feedbackThankYou),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      debugPrint('Errore invio feedback: $e');
      if (mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _dismiss() async {
    try {
      final profileService = UserProfileService();
      final settings = await profileService.getCurrentSettings();
      if (settings != null) {
        final updatedSettings = settings.updateModuleSetting('feedback', 'dismissed', true);
        await profileService.updateSettings(updatedSettings);
      }
    } catch (e) {
      debugPrint('Errore dismiss feedback: $e');
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icona
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star_rounded,
                size: 48,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 20),

            // Titolo
            Text(
              l10n.feedbackTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Sottotitolo
            Text(
              l10n.feedbackSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Stelline
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return GestureDetector(
                  onTap: () => setState(() => _rating = starIndex),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      starIndex <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 40,
                      color: starIndex <= _rating ? Colors.amber : context.textTertiaryColor,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Commento opzionale
            TextField(
              controller: _commentController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: l10n.feedbackCommentHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 24),

            // Bottoni
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSubmitting ? null : _dismiss,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.feedbackDismiss),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _rating > 0 && !_isSubmitting ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(l10n.feedbackSubmit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
