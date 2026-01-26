import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../services/smart_todo_service.dart';
import '../../l10n/app_localizations.dart';

class SmartTaskImportDialog extends StatefulWidget {
  final String listId;
  final List<TodoColumn> availableColumns;
  final List<TodoLabel> availableTags;
  final SmartTodoService todoService;

  const SmartTaskImportDialog({
    super.key,
    required this.listId,
    required this.availableColumns,
    required this.availableTags,
    required this.todoService,
  });

  @override
  State<SmartTaskImportDialog> createState() => _SmartTaskImportDialogState();
}

class _SmartTaskImportDialogState extends State<SmartTaskImportDialog> {
  int _currentStep = 0;
  final TextEditingController _textInputController = TextEditingController();

  // Parsed Data
  List<List<dynamic>> _rawRows = [];
  String? _fileName;

  // Mapping
  // Index of column -> Field Name (e.g. 0 -> 'title')
  Map<int, String> _columnMapping = {};

  final List<String> _mappableFields = [
    'ignore',
    'title',
    'description',
    'priority', // Low, Medium, High
    'status', // Column Name or ID
    'assignee', // Email
    'effort', // Int
    'tags', // Tag names (comma-separated or #hashtag format)
  ];

  bool _isLoading = false;
  String? _error;
  bool _showHelp = false;
  bool _isSimpleList = false; // Track if input is a simple list (skip mapping step)

  // Destination column for all imported tasks
  String? _selectedDestinationColumn;

  // Track newly created tags during import
  final List<TodoLabel> _newTagsToCreate = [];

  @override
  Widget build(BuildContext context) {
    final dialogIsDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = dialogIsDark ? const Color(0xFF1E2633) : Colors.white;
    final dialogInputBg = dialogIsDark ? const Color(0xFF2D3748) : Colors.grey[50];
    final dialogBorder = dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!;
    final dialogTextColor = dialogIsDark ? Colors.white : Colors.black87;

    return Dialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
       child: Container(
         width: 800,
         height: 600,
         padding: const EdgeInsets.all(24),
         decoration: BoxDecoration(
           color: dialogBg,
           borderRadius: BorderRadius.circular(20),
         ),
         child: Column(
           children: [
             _buildHeader(dialogIsDark, dialogTextColor),
             Divider(color: dialogBorder),
             Expanded(
               child: _buildBody(dialogIsDark, dialogInputBg, dialogBorder, dialogTextColor),
             ),
             Divider(color: dialogBorder),
             _buildFooter(),
           ],
         ),
       ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue[50], borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.upload_file, color: Colors.blue),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.smartTodoImportTasks, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            Text(
              _getStepTitle(l10n),
              style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600])
            ),
          ],
        ),
        const Spacer(),
        IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: isDark ? Colors.grey[400] : null)),
      ],
    );
  }

  String _getStepTitle(AppLocalizations l10n) {
    // Always skip mapping step: Step 1 = Input, Step 2 = Review & Confirm
    switch (_currentStep) {
      case 0: return l10n.smartTodoImportStep1;
      case 1: return l10n.smartTodoImportStep3; // Directly to review
      default: return '';
    }
  }

  Widget _buildBody(bool isDark, Color? inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _error = null),
              child: Text(l10n.smartTodoImportRetry),
            )
          ],
        ),
      );
    }

    // Always skip mapping step - go directly from input to review
    switch (_currentStep) {
      case 0: return _buildInputStep(isDark, inputBg, borderColor, textColor);
      case 1: return _buildReviewStep(isDark, inputBg, textColor);
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildInputStep(bool isDark, Color? inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Help Section
          _buildHelpCard(isDark, textColor),
          const SizedBox(height: 8),
          TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey,
            tabs: [
              Tab(text: l10n.smartTodoImportPasteText),
              Tab(text: l10n.smartTodoImportUploadFile),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Text Input
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        l10n.smartTodoImportPasteHint,
                        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          controller: _textInputController,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: borderColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: borderColor)),
                            hintText: l10n.smartTodoImportPasteExample,
                            hintStyle: TextStyle(color: isDark ? Colors.grey[500] : null),
                            filled: true,
                            fillColor: inputBg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // File Input
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined, size: 64, color: isDark ? Colors.grey[600] : Colors.grey[300]),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _pickCsvFile,
                        icon: const Icon(Icons.folder_open),
                        label: Text(l10n.smartTodoImportSelectFile),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                      ),
                      if (_fileName != null) ...[
                        const SizedBox(height: 16),
                        Text(l10n.smartTodoImportFileSelected(_fileName!), style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(bool isDark, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: isDark ? Colors.blue.withOpacity(0.15) : Colors.blue.shade50,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: Icon(Icons.help_outline, color: Colors.blue.shade400, size: 20),
        title: Text(
          l10n.smartTodoImportHelpTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade700,
          ),
        ),
        initiallyExpanded: _showHelp,
        onExpansionChanged: (expanded) => setState(() => _showHelp = expanded),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHelpSection(
                    l10n.smartTodoImportHelpSimpleTitle,
                    l10n.smartTodoImportHelpSimpleDesc,
                    l10n.smartTodoImportHelpSimpleExample,
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildHelpSection(
                    l10n.smartTodoImportHelpCsvTitle,
                    l10n.smartTodoImportHelpCsvDesc,
                    l10n.smartTodoImportHelpCsvExample,
                    isDark,
                  ),
                  const SizedBox(height: 12),
                  _buildFieldsHelp(isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSection(String title, String description, String example, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.black26 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
          ),
          child: Text(
            example,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: isDark ? Colors.green.shade300 : Colors.green.shade800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldsHelp(bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.smartTodoImportHelpFieldsTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        _buildFieldRow('title', l10n.smartTodoImportHelpFieldTitle, isDark, required: true),
        _buildFieldRow('description', l10n.smartTodoImportHelpFieldDesc, isDark),
        _buildFieldRow('priority', l10n.smartTodoImportHelpFieldPriority, isDark),
        _buildFieldRow('status', l10n.smartTodoImportHelpFieldStatus, isDark),
        _buildFieldRow('assignee', l10n.smartTodoImportHelpFieldAssignee, isDark),
        _buildFieldRow('effort', l10n.smartTodoImportHelpFieldEffort, isDark),
        _buildFieldRow('tags', l10n.smartTodoImportHelpFieldTags ?? 'Tags (#tag or comma-separated)', isDark),
      ],
    );
  }

  Widget _buildFieldRow(String field, String description, bool isDark, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: required
                  ? (isDark ? Colors.orange.withOpacity(0.2) : Colors.orange.shade100)
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              field.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: required
                    ? Colors.orange.shade700
                    : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickCsvFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt'],
      );

      if (result != null) {
        final file = result.files.single;
        setState(() => _fileName = file.name);
        
        String content = '';
        if (kIsWeb) {
           final bytes = file.bytes;
           if (bytes != null) content = utf8.decode(bytes);
        } else {
           if (file.path != null) {
             content = await File(file.path!).readAsString();
           }
        }
        
        // Parse immediately to check validity (but store in controller/temp)
        // Ideally we store it differently, but for simplicity:
        _textInputController.text = content;
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _error = l10n.smartTodoImportFileError(e.toString()));
    }
  }

  Widget _buildMappingStep(bool isDark, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    if (_rawRows.isEmpty) return Center(child: Text(l10n.smartTodoImportNoData, style: TextStyle(color: textColor)));

    // Header Row (First 5 items max)
    final headerRow = _rawRows.first;
    // Sample Row
    final sampleRow = _rawRows.length > 1 ? _rawRows[1] : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            l10n.smartTodoImportColumnMapping,
            style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey),
          ),
        ),
        // Show available columns for STATUS field reference
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.blue.withOpacity(0.1) : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.blue.withOpacity(0.3) : Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: Colors.blue.shade400),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.smartTodoImportStatusHint(widget.availableColumns.map((c) => c.title).join(', ')),
                  style: TextStyle(fontSize: 12, color: isDark ? Colors.blue.shade200 : Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: headerRow.length,
            separatorBuilder: (_, __) => Divider(color: isDark ? Colors.white.withOpacity(0.1) : null),
            itemBuilder: (context, index) {
              final cellValue = headerRow[index].toString();
              final sampleValue = index < sampleRow.length ? sampleRow[index].toString() : '-';

              return ListTile(
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ),
                title: Text(
                  cellValue.isNotEmpty ? '"$cellValue"' : l10n.smartTodoImportEmptyColumn,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  l10n.smartTodoImportSampleValue(sampleValue),
                  style: TextStyle(color: isDark ? Colors.grey[400] : null, fontSize: 12),
                ),
                trailing: DropdownButton<String>(
                  value: _columnMapping[index] ?? 'ignore',
                  dropdownColor: isDark ? const Color(0xFF2D3748) : null,
                  style: TextStyle(color: textColor),
                  items: _mappableFields.map((field) {
                    return DropdownMenuItem(
                      value: field,
                      child: Text(_getFieldDisplayName(field, l10n)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      if (val == 'ignore') {
                        _columnMapping.remove(index);
                      } else {
                        _columnMapping[index] = val!;
                      }
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getFieldDisplayName(String field, AppLocalizations l10n) {
    switch (field) {
      case 'ignore': return l10n.smartTodoImportFieldIgnore;
      case 'title': return l10n.smartTodoImportFieldTitle;
      case 'description': return l10n.smartTodoImportFieldDescription;
      case 'priority': return l10n.smartTodoImportFieldPriority;
      case 'status': return l10n.smartTodoImportFieldStatus;
      case 'assignee': return l10n.smartTodoImportFieldAssignee;
      case 'effort': return l10n.smartTodoImportFieldEffort;
      case 'tags': return l10n.smartTodoImportFieldTags ?? 'Tags';
      default: return field.toUpperCase();
    }
  }

  Widget _buildReviewStep(bool isDark, Color? inputBg, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    // Generate Preview Models
    final previewTasks = _generateTasksFromMapping();

    // Initialize selected column if not set
    _selectedDestinationColumn ??= widget.availableColumns.first.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with task count and column selector
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.smartTodoImportFoundTasks(previewTasks.length),
                  style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
              ),
              // Column selector dropdown
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.smartTodoImportDestinationColumn ?? 'Destination:',
                    style: TextStyle(fontSize: 13, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.blue.withOpacity(0.15) : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDestinationColumn,
                        isDense: true,
                        dropdownColor: isDark ? const Color(0xFF2D3748) : Colors.white,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade400),
                        items: widget.availableColumns.map((col) {
                          return DropdownMenuItem<String>(
                            value: col.id,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Color(col.colorValue),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(col.title),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedDestinationColumn = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: previewTasks.length,
            itemBuilder: (context, index) {
              final task = previewTasks[index];
              return Card(
                elevation: 0,
                color: inputBg,
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getPriorityColor(task.priority).withOpacity(0.2),
                    radius: 10,
                  ),
                  title: Text(task.title, style: TextStyle(color: textColor)),
                  subtitle: Text(
                    '${task.description.isNotEmpty ? "${task.description} • " : ""}'
                    'Priority: ${task.priority.name} • '
                    'Status: ${_getStatusName(_selectedDestinationColumn ?? task.statusId)}',
                    style: TextStyle(color: isDark ? Colors.grey[400] : null),
                  ),
                  trailing: task.assignedTo.isNotEmpty
                    ? CircleAvatar(child: Text(task.assignedTo.first[0].toUpperCase()), radius: 12)
                    : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getStatusName(String id) {
    if (id == 'todo') return 'To Do'; // Default fallback
    try {
      return widget.availableColumns.firstWhere((c) => c.id == id).title;
    } catch (_) {
      return id; // Or 'Sconosciuto'
    }
  }
  
  Color _getPriorityColor(TodoTaskPriority p) {
    if (p == TodoTaskPriority.high) return Colors.red;
    if (p == TodoTaskPriority.medium) return Colors.orange;
    return Colors.blue;
  }

  Widget _buildFooter() {
    final l10n = AppLocalizations.of(context)!;

    // Step 0 = Input, Step 1 = Review/Import (final step)
    final isFinalStep = _currentStep == 1;
    final taskCount = _rawRows.length > 1 ? _rawRows.length - 1 : 0;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton(
              onPressed: () => setState(() => _currentStep--),
              child: Text(l10n.smartTodoImportBack),
            )
          else
            const SizedBox.shrink(),

          ElevatedButton(
            onPressed: _onNextPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Always blue to match icon
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(isFinalStep ? l10n.smartTodoImportButton(taskCount) : l10n.smartTodoImportNext),
          ),
        ],
      ),
    );
  }

  // Check if row looks like a CSV header (contains known field names)
  bool _isLikelyHeader(List<dynamic> row) {
    final knownFields = ['title', 'titolo', 'desc', 'description', 'descrizione',
                         'priority', 'priorità', 'status', 'stato', 'assignee',
                         'assegnato', 'effort', 'user', 'name', 'nome',
                         'tag', 'tags', 'label', 'labels', 'etichetta', 'etichette'];
    final rowLower = row.map((e) => e.toString().toLowerCase().trim()).toList();

    // If any cell contains a known field name, it's likely a header
    for (var cell in rowLower) {
      for (var field in knownFields) {
        if (cell.contains(field)) return true;
      }
    }
    return false;
  }

  void _onNextPressed() async {
    final l10n = AppLocalizations.of(context)!;
    if (_currentStep == 0) {
      // Validate Input & Parse
      if (_textInputController.text.isEmpty) {
        setState(() => _error = l10n.smartTodoImportEnterText);
        return;
      }

      setState(() => _isLoading = true);
      // Simulate/Run parser
      await Future.delayed(const Duration(milliseconds: 500));
      try {
        // Use CsvToListConverter
        final converter = const CsvToListConverter(eol: '\n', fieldDelimiter: ',');
        List<List<dynamic>> rows = converter.convert(_textInputController.text);

        // Remove empty rows
        rows = rows.where((r) => r.isNotEmpty && r.join('').trim().isNotEmpty).toList();

        if (rows.isEmpty) throw l10n.smartTodoImportNoValidRows;

        // Check if this is a simple list (single column, no header)
        final isSimpleList = rows.every((r) => r.length == 1) && !_isLikelyHeader(rows.first);

        if (isSimpleList) {
          // Simple list mode: each row is a task title
          // Add a fake header row so mapping step works correctly
          final dataRows = List<List<dynamic>>.from(rows);
          rows = [['title'], ...dataRows]; // Prepend header
        }

        setState(() {
          _rawRows = rows;
          _isLoading = false;
          _currentStep = 1; // Go directly to review step
          _error = null;
          _isSimpleList = isSimpleList;

          // Auto-guess mapping based on header
          _columnMapping.clear();
          final header = rows.first.map((e) => e.toString().toLowerCase()).toList();

          for (int i = 0; i < header.length; i++) {
             if (header[i].contains('titolo') || header[i].contains('title')) _columnMapping[i] = 'title';
             else if (header[i].contains('bio') || header[i].contains('desc')) _columnMapping[i] = 'description';
             else if (header[i].contains('prio')) _columnMapping[i] = 'priority';
             else if (header[i].contains('stato') || header[i].contains('status')) _columnMapping[i] = 'status';
             else if (header[i].contains('user') || header[i].contains('assign')) _columnMapping[i] = 'assignee';
             else if (header[i].contains('tag') || header[i].contains('label') || header[i].contains('etich')) _columnMapping[i] = 'tags';
          }

          // Fallback if no title mapped: Map first column to title
          if (!_columnMapping.containsValue('title')) {
            _columnMapping[0] = 'title';
          }
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
          _error = l10n.smartTodoImportParsingError(e.toString());
        });
      }
    } else if (_currentStep == 1) {
      // Step 1 = Review - Execute Import
      setState(() => _isLoading = true);
      try {
        final tasks = _generateTasksFromMapping();

        // If there are new tags, update the list first
        if (_newTagsToCreate.isNotEmpty) {
          final currentList = await widget.todoService.getList(widget.listId);
          if (currentList != null) {
            final updatedTags = [...currentList.availableTags, ..._newTagsToCreate];
            await widget.todoService.updateList(
              currentList.copyWith(availableTags: updatedTags),
            );
          }
        }

        await widget.todoService.batchCreateTasks(widget.listId, tasks);
        if (mounted) Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.smartTodoImportSuccess(tasks.length))));
      } catch (e) {
        setState(() {
          _isLoading = false;
          _error = l10n.smartTodoImportError(e.toString());
        });
      }
    }
  }
  
  List<TodoTaskModel> _generateTasksFromMapping() {
    final l10n = AppLocalizations.of(context)!;
    // Skip header row
    final dataRows = _rawRows.skip(1);
    final List<TodoTaskModel> tasks = [];

    // Clear any previously created tags
    _newTagsToCreate.clear();

    // Use selected destination column, or fallback to first column
    final destinationStatusId = _selectedDestinationColumn ?? widget.availableColumns.first.id;

    // Build a combined list of existing + new tags for matching
    List<TodoLabel> allTags = List.from(widget.availableTags);

    for (var row in dataRows) {
      String title = l10n.smartTodoNewTaskDefault;
      String desc = '';
      TodoTaskPriority priority = TodoTaskPriority.medium;
      List<String> assignedTo = [];
      int? effort;
      List<TodoLabel> taskTags = [];
      String? rawTagsValue;

      // Apply Mapping in index order
      // Iterate over cells in row (up to mapping bounds)
      for (int i = 0; i < row.length; i++) {
        if (!_columnMapping.containsKey(i)) continue;
        final field = _columnMapping[i];
        final val = row[i].toString().trim();
        if (val.isEmpty) continue;

        switch (field) {
          case 'title': title = val; break;
          case 'description': desc = val; break;
          case 'priority':
            final v = val.toLowerCase();
            if (v.contains('high') || v.contains('alta')) priority = TodoTaskPriority.high;
            if (v.contains('low') || v.contains('bassa')) priority = TodoTaskPriority.low;
            break;
          case 'status':
            // Status from CSV is ignored - user selects destination column
            break;
          case 'assignee':
            if (val.contains('@')) assignedTo.add(val); // Simple check
            break;
          case 'effort':
            effort = int.tryParse(val);
            break;
          case 'tags':
            rawTagsValue = val;
            break;
        }
      }

      // Parse tags from CSV column (comma-separated or space-separated)
      if (rawTagsValue != null && rawTagsValue.isNotEmpty) {
        final tagNames = _parseTagNames(rawTagsValue);
        for (final tagName in tagNames) {
          final tag = _findOrCreateTag(tagName, allTags);
          if (!taskTags.any((t) => t.id == tag.id)) {
            taskTags.add(tag);
          }
        }
      }

      // Parse #hashtags from title (e.g., "Fix bug #FG2555 #urgent")
      final hashtagMatches = RegExp(r'#(\w+)').allMatches(title);
      for (final match in hashtagMatches) {
        final tagName = match.group(1)!;
        final tag = _findOrCreateTag(tagName, allTags);
        if (!taskTags.any((t) => t.id == tag.id)) {
          taskTags.add(tag);
        }
      }

      // Remove hashtags from title for cleaner display
      if (hashtagMatches.isNotEmpty) {
        title = title.replaceAll(RegExp(r'\s*#\w+'), '').trim();
      }

      tasks.add(TodoTaskModel(
        id: '', // Auto-generated later or empty for new
        listId: widget.listId,
        title: title,
        description: desc,
        priority: priority,
        statusId: destinationStatusId, // Use selected destination column
        assignedTo: assignedTo,
        effort: effort,
        tags: taskTags,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return tasks;
  }

  /// Parse tag names from a string (comma-separated, space-separated, or #hashtag format)
  List<String> _parseTagNames(String input) {
    final result = <String>[];

    // First, extract any #hashtags
    final hashtagMatches = RegExp(r'#(\w+)').allMatches(input);
    for (final match in hashtagMatches) {
      result.add(match.group(1)!);
    }

    // Remove hashtags from input for further parsing
    String remaining = input.replaceAll(RegExp(r'#\w+'), '');

    // Split by comma or semicolon
    final parts = remaining.split(RegExp(r'[,;]'));
    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty) {
        result.add(trimmed);
      }
    }

    return result;
  }

  /// Find existing tag by exact title match (case-insensitive) or create a new one
  TodoLabel _findOrCreateTag(String tagName, List<TodoLabel> allTags) {
    // Try to find existing tag (case-insensitive)
    final existing = allTags.where(
      (t) => t.title.toLowerCase() == tagName.toLowerCase()
    ).firstOrNull;

    if (existing != null) {
      return existing;
    }

    // Check if we already created this tag in this import session
    final alreadyCreated = _newTagsToCreate.where(
      (t) => t.title.toLowerCase() == tagName.toLowerCase()
    ).firstOrNull;

    if (alreadyCreated != null) {
      return alreadyCreated;
    }

    // Create new tag with auto-generated color
    final newTag = TodoLabel(
      id: DateTime.now().millisecondsSinceEpoch.toString() + '_${tagName.hashCode}',
      title: tagName,
      colorValue: _generateTagColor(tagName),
    );

    // Track for later persistence
    _newTagsToCreate.add(newTag);
    allTags.add(newTag); // Add to local list for subsequent matching

    return newTag;
  }

  /// Generate a consistent color based on tag name
  int _generateTagColor(String tagName) {
    final colors = [
      0xFF2196F3, // Blue
      0xFF4CAF50, // Green
      0xFFFF9800, // Orange
      0xFF9C27B0, // Purple
      0xFFE91E63, // Pink
      0xFF00BCD4, // Cyan
      0xFF795548, // Brown
      0xFF607D8B, // Blue Grey
    ];
    return colors[tagName.hashCode.abs() % colors.length];
  }
}
