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
  final SmartTodoService todoService;

  const SmartTaskImportDialog({
    super.key, 
    required this.listId, 
    required this.availableColumns,
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
  ];

  bool _isLoading = false;
  String? _error;

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
    switch (_currentStep) {
      case 0: return l10n.smartTodoImportStep1;
      case 1: return l10n.smartTodoImportStep2;
      case 2: return l10n.smartTodoImportStep3;
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

    switch (_currentStep) {
      case 0: return _buildInputStep(isDark, inputBg, borderColor, textColor);
      case 1: return _buildMappingStep(isDark, textColor);
      case 2: return _buildReviewStep(isDark, inputBg, textColor);
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildInputStep(bool isDark, Color? inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
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
        Expanded(
          child: ListView.separated(
            itemCount: headerRow.length,
            separatorBuilder: (_, __) => Divider(color: isDark ? Colors.white.withOpacity(0.1) : null),
            itemBuilder: (context, index) {
              final cellValue = headerRow[index].toString();
              final sampleValue = index < sampleRow.length ? sampleRow[index].toString() : '-';

              return ListTile(
                title: Text(l10n.smartTodoImportColumnLabel(index + 1, cellValue), style: TextStyle(color: textColor)),
                subtitle: Text(l10n.smartTodoImportSampleValue(sampleValue), style: TextStyle(color: isDark ? Colors.grey[400] : null)),
                trailing: DropdownButton<String>(
                  value: _columnMapping[index] ?? 'ignore',
                  dropdownColor: isDark ? const Color(0xFF2D3748) : null,
                  style: TextStyle(color: textColor),
                  items: _mappableFields.map((field) {
                    return DropdownMenuItem(
                      value: field,
                      child: Text(field.toUpperCase()),
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

  Widget _buildReviewStep(bool isDark, Color? inputBg, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    // Generate Preview Models
    final previewTasks = _generateTasksFromMapping();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            l10n.smartTodoImportFoundTasks(previewTasks.length),
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
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
                    'Status: ${_getStatusName(task.statusId)}',
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
              backgroundColor: _currentStep == 2 ? Colors.green : Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(_currentStep == 2 ? l10n.smartTodoImportButton(_rawRows.length - 1) : l10n.smartTodoImportNext),
          ),
        ],
      ),
    );
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

        setState(() {
          _rawRows = rows;
          _isLoading = false;
          _currentStep = 1;
          _error = null;

          // Auto-guess mapping?
          // Simple heuristic:
          // If 'title' in header -> map to title
          // If 'desc' in header -> map to description
          // etc.
          final header = rows.first.map((e) => e.toString().toLowerCase()).toList();
          for (int i = 0; i < header.length; i++) {
             if (header[i].contains('titolo') || header[i].contains('title')) _columnMapping[i] = 'title';
             else if (header[i].contains('bio') || header[i].contains('desc')) _columnMapping[i] = 'description';
             else if (header[i].contains('prio')) _columnMapping[i] = 'priority';
             else if (header[i].contains('stato') || header[i].contains('status')) _columnMapping[i] = 'status';
             else if (header[i].contains('user') || header[i].contains('assign')) _columnMapping[i] = 'assignee';
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
      if (!_columnMapping.containsValue('title')) {
        setState(() => _error = l10n.smartTodoImportMapTitle);
        return;
      }
      setState(() {
        _currentStep = 2;
        _error = null;
      });
    } else if (_currentStep == 2) {
      // Execute Import
      setState(() => _isLoading = true);
      try {
        final tasks = _generateTasksFromMapping();
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

    for (var row in dataRows) {
      String title = l10n.smartTodoNewTaskDefault;
      String desc = '';
      TodoTaskPriority priority = TodoTaskPriority.medium;
      String statusId = widget.availableColumns.first.id;
      List<String> assignedTo = [];
      int? effort;

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
            // Try match Column Name
            try {
              final col = widget.availableColumns.firstWhere(
                (c) => c.title.toLowerCase() == val.toLowerCase(),
              );
              statusId = col.id;
            } catch (_) {}
            break;
          case 'assignee':
            if (val.contains('@')) assignedTo.add(val); // Simple check
            break;
          case 'effort':
            effort = int.tryParse(val);
            break;
        }
      }
      
      tasks.add(TodoTaskModel(
        id: '', // Auto-generated later or empty for new
        listId: widget.listId,
        title: title,
        description: desc,
        priority: priority,
        statusId: statusId,
        assignedTo: assignedTo,
        effort: effort,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return tasks;
  }
}
