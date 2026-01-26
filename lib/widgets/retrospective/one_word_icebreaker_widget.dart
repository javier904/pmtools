import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class OneWordIcebreakerWidget extends StatefulWidget {
  final String retroId;
  final String currentUserEmail;
  final Map<String, String> currentWords; // email -> word
  final bool isFacilitator;
  final VoidCallback onPhaseComplete;

  const OneWordIcebreakerWidget({
    Key? key,
    required this.retroId,
    required this.currentUserEmail,
    required this.currentWords,
    this.isFacilitator = false,
    required this.onPhaseComplete,
  }) : super(key: key);

  @override
  State<OneWordIcebreakerWidget> createState() => _OneWordIcebreakerWidgetState();
}

class _OneWordIcebreakerWidgetState extends State<OneWordIcebreakerWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    final myWord = widget.currentWords[widget.currentUserEmail];
    if (myWord != null && myWord.isNotEmpty) {
      _controller.text = myWord;
      _hasSubmitted = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitWord() {
    final word = _controller.text.trim();
    if (word.isNotEmpty) {
      RetrospectiveFirestoreService().submitOneWord(widget.retroId, widget.currentUserEmail, word);
      setState(() => _hasSubmitted = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.retroIcebreakerOneWordTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.retroIcebreakerOneWordQuestion,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Input field
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _controller,
                  enabled: !_hasSubmitted,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: l10n.retroIcebreakerOneWordHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                  ),
                  onSubmitted: (_) => _submitWord(),
                ),
              ),
              const SizedBox(height: 16),

              if (!_hasSubmitted)
                ElevatedButton(
                  onPressed: _submitWord,
                  child: Text(l10n.actionSubmit),
                )
              else
                Chip(
                  avatar: const Icon(Icons.check_circle, color: Colors.green),
                  label: Text(l10n.retroIcebreakerSubmitted),
                  backgroundColor: Colors.green.withOpacity(0.1),
                ),

              const SizedBox(height: 32),

              // Word cloud display
              if (widget.currentWords.isNotEmpty) ...[
                Text(
                  l10n.retroIcebreakerWordsSubmitted(widget.currentWords.length),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: widget.currentWords.values.map((word) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Text(
                        word,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 24),

              if (widget.isFacilitator)
                ElevatedButton.icon(
                  onPressed: widget.onPhaseComplete,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.retroEndIcebreakerStartWriting),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
