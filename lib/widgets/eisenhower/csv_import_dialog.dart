import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import '../../services/csv_import_service.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per importare attività da file CSV
///
/// Permette di:
/// - Selezionare un file CSV (drag&drop o picker)
/// - Visualizzare preview delle attività con validazione
/// - Mostrare errori dettagliati e righe saltate
/// - Selezionare/deselezionare attività da importare
class CsvImportDialog extends StatefulWidget {
  final String matrixId;
  final String currentUserEmail;

  const CsvImportDialog({
    super.key,
    required this.matrixId,
    required this.currentUserEmail,
  });

  /// Mostra il dialog e ritorna la lista di attività selezionate
  static Future<List<CsvActivityRow>?> show(
    BuildContext context, {
    required String matrixId,
    required String currentUserEmail,
  }) async {
    return showDialog<List<CsvActivityRow>>(
      context: context,
      builder: (context) => CsvImportDialog(
        matrixId: matrixId,
        currentUserEmail: currentUserEmail,
      ),
    );
  }

  @override
  State<CsvImportDialog> createState() => _CsvImportDialogState();
}

class _CsvImportDialogState extends State<CsvImportDialog> {
  CsvParseResult? _parseResult;
  String? _error;
  bool _isLoading = false;
  bool _markAsRevealed = true;
  String? _fileName;
  bool _showInstructions = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.upload_file, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text(l10n.eisenhowerImportCsv)),
          // Toggle istruzioni
          IconButton(
            icon: Icon(
              _showInstructions ? Icons.help : Icons.help_outline,
              color: _showInstructions ? Colors.blue : Colors.grey,
            ),
            tooltip: l10n.eisenhowerImportShowInstructions,
            onPressed: () => setState(() => _showInstructions = !_showInstructions),
          ),
        ],
      ),
      content: SizedBox(
        width: 650,
        height: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Istruzioni formato CSV
            if (_showInstructions) ...[
              _buildInstructionsCard(l10n),
              const SizedBox(height: 12),
            ],

            // File picker area
            _buildFilePickerArea(l10n),
            const SizedBox(height: 12),

            // Error/Warning messages
            if (_error != null) _buildErrorCard(_error!, isError: true),
            if (_parseResult != null && _parseResult!.hasErrors)
              _buildParseErrorsSummary(l10n),

            // Loading
            if (_isLoading) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ],

            // Success summary
            if (_parseResult != null && _parseResult!.hasActivities) ...[
              _buildSuccessSummary(l10n),
              const SizedBox(height: 8),
            ],

            // Preview list
            if (_parseResult?.activities.isNotEmpty == true) ...[
              Expanded(child: _buildActivityList(l10n)),
              const SizedBox(height: 12),
              // Options
              CheckboxListTile(
                value: _markAsRevealed,
                onChanged: (value) => setState(() => _markAsRevealed = value ?? true),
                title: Text(l10n.eisenhowerImportMarkRevealed),
                subtitle: Text(
                  l10n.eisenhowerImportMarkRevealedHint,
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
              ),
            ],

            // Empty/Initial state
            if (_parseResult == null && !_isLoading && _error == null)
              Expanded(child: _buildInitialState(l10n)),

            if (_parseResult?.activities.isEmpty == true && !_parseResult!.hasErrors)
              Expanded(child: _buildEmptyState(l10n)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton.icon(
          onPressed: _canImport ? _handleImport : null,
          icon: const Icon(Icons.upload_file),
          label: Text(l10n.actionImport),
        ),
      ],
    );
  }

  /// Card con istruzioni sul formato CSV
  Widget _buildInstructionsCard(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.withOpacity(0.15) : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: isDark ? Colors.blue.shade200 : Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                l10n.eisenhowerImportInstructionsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.blue.shade200 : Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.eisenhowerImportInstructionsBody,
            style: TextStyle(fontSize: 12, color: isDark ? Colors.blue.shade100 : Colors.blue.shade800),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? Colors.black26 : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.shade100),
            ),
            child: Text(
              l10n.eisenhowerImportExampleFormat,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: isDark ? Colors.grey[300] : Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePickerArea(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: _pickFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: _fileName != null
                ? (isDark ? Colors.green.withOpacity(0.5) : Colors.green.shade300)
                : (isDark ? Colors.blue.withOpacity(0.5) : Colors.blue.shade200),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: _fileName != null
              ? (isDark ? Colors.green.withOpacity(0.15) : Colors.green.shade50)
              : (isDark ? Colors.blue.withOpacity(0.15) : Colors.blue.shade50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _fileName != null ? Icons.check_circle : Icons.cloud_upload,
              size: 28,
              color: _fileName != null
                  ? (isDark ? Colors.green.shade300 : Colors.green.shade700)
                  : (isDark ? Colors.blue.shade300 : Colors.blue.shade700),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fileName ?? l10n.eisenhowerImportClickToSelect,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _fileName != null
                        ? (isDark ? Colors.green.shade300 : Colors.green.shade700)
                        : (isDark ? Colors.blue.shade300 : Colors.blue.shade700),
                  ),
                ),
                Text(
                  l10n.eisenhowerImportSupportedFormats,
                  style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                ),
              ],
            ),
            if (_fileName != null) ...[
              const Spacer(),
              TextButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.refresh, size: 16),
                label: Text(l10n.eisenhowerImportChangeFile),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message, {bool isError = true}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isError ? Colors.red : Colors.orange;
    final shade700 = isError 
        ? (isDark ? Colors.red.shade300 : Colors.red.shade700)
        : (isDark ? Colors.orange.shade300 : Colors.orange.shade700);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? baseColor.withOpacity(0.15) : (isError ? Colors.red.shade50 : Colors.orange.shade50),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? baseColor.withOpacity(0.3) : (isError ? Colors.red.shade200 : Colors.orange.shade200),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.warning_amber,
            color: shade700,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParseErrorsSummary(AppLocalizations l10n) {
    final errors = _parseResult!.errors;
    if (errors.isEmpty) return const SizedBox.shrink();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.orange.withOpacity(0.15) : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.orange.withOpacity(0.3) : Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: isDark ? Colors.orange.shade300 : Colors.orange.shade700, size: 18),
              const SizedBox(width: 8),
              Text(
                l10n.eisenhowerImportSkippedRows(_parseResult!.skippedRows),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.orange.shade300 : Colors.orange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...errors.take(5).map((error) => Padding(
            padding: const EdgeInsets.only(left: 26, bottom: 4),
            child: Text(
              _translateError(error, l10n),
              style: TextStyle(fontSize: 12, color: isDark ? Colors.orange.shade200 : Colors.orange.shade800),
            ),
          )),
          if (errors.length > 5)
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Text(
                l10n.eisenhowerImportAndMore(errors.length - 5),
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: isDark ? Colors.orange.shade200 : Colors.orange.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _translateError(CsvParseError error, AppLocalizations l10n) {
    switch (error.message) {
      case 'EMPTY_TITLE':
        return l10n.eisenhowerImportErrorEmptyTitle(error.rowNumber);
      case 'INVALID_ROW':
        return l10n.eisenhowerImportErrorInvalidRow(error.rowNumber);
      case 'MISSING_TITLE_COLUMN':
        return l10n.eisenhowerImportErrorMissingColumn;
      case 'EMPTY_FILE':
        return l10n.eisenhowerImportErrorEmptyFile;
      case 'NO_HEADER':
        return l10n.eisenhowerImportErrorNoHeader;
      default:
        return '${l10n.eisenhowerImportErrorRow(error.rowNumber)}: ${error.message}';
    }
  }

  Widget _buildSuccessSummary(AppLocalizations l10n) {
    final result = _parseResult!;
    final validCount = result.activities.length;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.green.withOpacity(0.15) : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.green.withOpacity(0.3) : Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: isDark ? Colors.green.shade300 : Colors.green.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.eisenhowerImportFoundActivities(validCount, result.totalRows),
              style: TextStyle(color: isDark ? Colors.green.shade300 : Colors.green.shade700),
            ),
          ),
          TextButton.icon(
            onPressed: _selectAll,
            icon: const Icon(Icons.check_box_outlined, size: 16),
            label: Text(l10n.actionSelectAll),
          ),
          TextButton.icon(
            onPressed: _deselectAll,
            icon: const Icon(Icons.check_box_outline_blank, size: 16),
            label: Text(l10n.actionDeselectAll),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: _parseResult!.activities.length,
        itemBuilder: (context, index) {
          final activity = _parseResult!.activities[index];
          return _buildActivityTile(activity, l10n);
        },
      ),
    );
  }

  Widget _buildActivityTile(CsvActivityRow activity, AppLocalizations l10n) {
    final urgencyColor = _getUrgencyColor(activity.urgencyInt);
    final importanceColor = _getImportanceColor(activity.importanceInt);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        CheckboxListTile(
          value: activity.selected,
          onChanged: (value) => setState(() => activity.selected = value ?? true),
          title: Text(
            activity.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildValueBadge('U', activity.urgency, urgencyColor),
                  const SizedBox(width: 6),
                  _buildValueBadge('I', activity.importance, importanceColor),
                  if (activity.description.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        activity.description,
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
              if (activity.hasWarning)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 12, color: isDark ? Colors.orange[300] : Colors.orange[700]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          activity.warning!,
                          style: TextStyle(fontSize: 10, color: isDark ? Colors.orange[300] : Colors.orange[700]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          dense: true,
        ),
        Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade200),
      ],
    );
  }

  Widget _buildValueBadge(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(1)}',
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildInitialState(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.description, size: 48, color: isDark ? Colors.grey[600] : Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            l10n.eisenhowerImportSelectFile,
            style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox, size: 48, color: isDark ? Colors.grey[600] : Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            l10n.eisenhowerImportNoActivities,
            style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(int value) {
    if (value >= 7) return Colors.red;
    if (value >= 4) return Colors.orange;
    return Colors.green;
  }

  Color _getImportanceColor(int value) {
    if (value >= 7) return Colors.purple;
    if (value >= 4) return Colors.blue;
    return Colors.grey;
  }

  bool get _canImport =>
      _parseResult?.activities.any((a) => a.selected) == true;

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _parseResult = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        setState(() => _isLoading = false);
        return;
      }

      final file = result.files.first;
      _fileName = file.name;

      String content;
      if (file.bytes != null) {
        // Try UTF-8 first, fallback to Latin-1
        try {
          content = utf8.decode(file.bytes!);
        } catch (_) {
          try {
            content = latin1.decode(file.bytes!);
          } catch (e) {
            content = utf8.decode(file.bytes!, allowMalformed: true);
          }
        }
      } else {
        throw Exception(AppLocalizations.of(context)!.eisenhowerImportErrorReadFile);
      }

      // Parse CSV with detailed results
      final parseResult = CsvImportService.parseCsvWithDetails(content);

      setState(() {
        _parseResult = parseResult;
        _isLoading = false;
        _showInstructions = false; // Nascondi istruzioni dopo caricamento
      });
    } on FormatException catch (e) {
      setState(() {
        _error = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _selectAll() {
    setState(() {
      for (final activity in _parseResult!.activities) {
        activity.selected = true;
      }
    });
  }

  void _deselectAll() {
    setState(() {
      for (final activity in _parseResult!.activities) {
        activity.selected = false;
      }
    });
  }

  void _handleImport() {
    final selectedActivities = _parseResult!.activities.where((a) => a.selected).toList();
    Navigator.pop(context, selectedActivities);
  }

  bool get markAsRevealed => _markAsRevealed;
}
