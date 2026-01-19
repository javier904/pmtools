import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import 'package:pasteboard/pasteboard.dart';
import 'dart:convert';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';

class TodoTaskDialog extends StatefulWidget {
  final String listId;
  final TodoTaskModel? task;
  final List<String> listParticipants;
  final List<TodoColumn> listColumns;
  final List<TodoLabel> listAvailableTags; // New
  final String? initialStatusId;

  const TodoTaskDialog({
    super.key,
    required this.listId,
    required this.listColumns,
    this.listAvailableTags = const [], // New
    this.task,
    this.initialStatusId,
    this.listParticipants = const [],
  });

  @override
  State<TodoTaskDialog> createState() => _TodoTaskDialogState();
}

class _TodoTaskDialogState extends State<TodoTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _effortController;
  
  late String _statusId;
  late TodoTaskPriority _priority;
  DateTime? _dueDate;
  List<String> _assignedTo = [];
  List<TodoSubtask> _subtasks = [];
  List<TodoAttachment> _attachments = [];
  List<TodoComment> _comments = [];
  List<TodoLabel> _assignedTags = []; // New State
  
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final t = widget.task;
    _titleController = TextEditingController(text: t?.title ?? '');
    _descController = TextEditingController(text: t?.description ?? '');
    _effortController = TextEditingController(text: t?.effort?.toString() ?? '');
    
    // Default status: task status -> initialStatusId -> first column -> 'todo'
    _statusId = t?.statusId ?? 
                widget.initialStatusId ?? 
                (widget.listColumns.isNotEmpty ? widget.listColumns.first.id : 'todo');
                
    _priority = t?.priority ?? TodoTaskPriority.medium;
    _dueDate = t?.dueDate;
    _assignedTo = List.from(t?.assignedTo ?? [AuthService().currentUser?.email ?? '']);
    _subtasks = List.from(t?.subtasks ?? []);
    _attachments = List.from(t?.attachments ?? []);
    _comments = List.from(t?.comments ?? []);
    _assignedTags = List.from(t?.tags ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _effortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogIsDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = dialogIsDark ? const Color(0xFF1E2633) : Colors.white;
    final dialogInputBg = dialogIsDark ? const Color(0xFF2D3748) : Colors.grey[50];
    final dialogBorder = dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!;
    final dialogTextColor = dialogIsDark ? Colors.white : Colors.black87;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Focus(
        autofocus: true,
        onKeyEvent: (node, event) {
          return KeyEventResult.ignored;
        },
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyV, meta: true): _handlePasteShortcut,
            const SingleActivator(LogicalKeyboardKey.keyV, control: true): _handlePasteShortcut,
          },
          child: Container(
            width: 700,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
               color: dialogBg,
               borderRadius: BorderRadius.circular(20),
               boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 5)],
            ),
            child: Column(
              children: [
            // Modern Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: dialogBorder)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                    child: Icon(widget.task == null ? Icons.add_rounded : Icons.edit_rounded, color: Colors.blue),
                  ),
                  const SizedBox(width: 16),
                  Builder(builder: (context) {
                    final l10n = AppLocalizations.of(context)!;
                    return Text(
                      widget.task == null ? l10n.smartTodoNewTask : l10n.smartTodoEditTask,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dialogTextColor),
                    );
                  }),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: dialogIsDark ? Colors.grey[400] : null),
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(backgroundColor: dialogIsDark ? Colors.white.withOpacity(0.1) : Colors.grey[100]),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT COLUMN: Main Info
                  Expanded(
                    flex: 7,
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                         Builder(builder: (context) {
                           final l10n = AppLocalizations.of(context)!;
                           return TextField(
                             controller: _titleController,
                             decoration: InputDecoration(
                               hintText: l10n.smartTodoTaskTitle,
                               hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.grey[500] : Colors.grey[400]),
                               border: InputBorder.none,
                             ),
                             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: dialogTextColor),
                           );
                         }),
                         const SizedBox(height: 24),
                         
                         // Description
                         Text('DESCRIZIONE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: dialogIsDark ? Colors.grey[400] : Colors.grey)),
                         const SizedBox(height: 8),
                         TextField(
                           controller: _descController,
                           decoration: InputDecoration(
                             hintText: 'Aggiungi una descrizione dettagliata...',
                             hintStyle: TextStyle(color: dialogIsDark ? Colors.grey[500] : null),
                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: dialogBorder)),
                             filled: true,
                             fillColor: dialogInputBg,
                           ),
                           style: TextStyle(color: dialogTextColor),
                           maxLines: 5,
                         ),
                         const SizedBox(height: 32),

                         // Subtasks
                         _buildSectionHeader('CHECKLIST'),
                         ..._subtasks.asMap().entries.map((entry) {
                           final i = entry.key;
                           final s = entry.value;
                           return ListTile(
                             contentPadding: EdgeInsets.zero,
                             leading: Checkbox(
                               value: s.isCompleted, 
                               onChanged: (v) => setState(() => _subtasks[i] = _subtasks[i].copyWith(isCompleted: v)),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                             ),
                             title: Text(s.title, style: TextStyle(decoration: s.isCompleted ? TextDecoration.lineThrough : null)),
                             trailing: IconButton(icon: const Icon(Icons.close, size: 16), onPressed: () => setState(() => _subtasks.removeAt(i))),
                           );
                         }),
                         TextButton.icon(
                           onPressed: _addSubtask,
                           icon: const Icon(Icons.add_rounded),
                           label: const Text('Aggiungi voce'),
                           style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                         ),

                         const SizedBox(height: 32),
                         // Attachments
                         _buildSectionHeader('ALLEGATI'),
                         if (_attachments.isNotEmpty) ...[
                           const SizedBox(height: 8),
                           Wrap(
                             spacing: 8,
                             runSpacing: 8,
                             children: _attachments.asMap().entries.map((entry) {
                               final i = entry.key;
                               final a = entry.value;
                               return InkWell(
                                 onTap: () => _launchAttachment(a.url), // Click handling
                                 borderRadius: BorderRadius.circular(20),
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                   decoration: BoxDecoration(
                                     color: Colors.blue[50],
                                     borderRadius: BorderRadius.circular(20),
                                     border: Border.all(color: Colors.blue[100]!),
                                   ),
                                   child: Row(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       const Icon(Icons.link, size: 16, color: Colors.blue),
                                       const SizedBox(width: 8),
                                       Text(
                                         a.name,
                                         style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                       ),
                                       const SizedBox(width: 8),
                                       InkWell(
                                         onTap: () => setState(() => _attachments.removeAt(i)),
                                         child: const Icon(Icons.close, size: 16, color: Colors.blue),
                                       ),
                                     ],
                                   ),
                                 ),
                               );
                             }).toList(),
                           ),
                         ],
                         TextButton.icon(
                           onPressed: _addAttachment,
                           icon: const Icon(Icons.add_link_rounded),
                           label: const Text('Aggiungi Link'),
                           style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                         ),

                         const SizedBox(height: 32),
                         // Comments
                         _buildSectionHeader('COMMENTI'),
                         const SizedBox(height: 16),
                         ..._comments.asMap().entries.map((entry) {
                           final index = entry.key;
                           final c = entry.value;
                           final isMe = c.authorEmail == AuthService().currentUser?.email;
                           
                           return Padding(
                           padding: const EdgeInsets.only(bottom: 16),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               CircleAvatar(radius: 12, child: Text(c.authorName[0], style: const TextStyle(fontSize: 10))),
                               const SizedBox(width: 12),
                               Expanded(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(children: [
                                       Text(c.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                       const SizedBox(width: 8),
                                       Text(DateFormat('dd MMM HH:mm').format(c.timestamp), style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                                     ]),
                                     const SizedBox(height: 4),
                                     if (c.text.isNotEmpty)
                                       Text(c.text, style: const TextStyle(fontSize: 14)),
                                     
                                     // Render Image if present
                                     if (c.imageUrl != null && c.imageUrl!.isNotEmpty) ...[
                                       const SizedBox(height: 8),
                                       GestureDetector(
                                         onTap: () => _showImageLightbox(c.imageUrl!), // Lightbox
                                         child: Container(
                                           height: 150,
                                           width: 250,
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(8),
                                             border: Border.all(color: Colors.grey[200]!),
                                             image: DecorationImage(
                                                image: NetworkImage(c.imageUrl!),
                                                fit: BoxFit.cover,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ],
                                 ),
                               ),
                               if (isMe) 
                                 PopupMenuButton<String>(
                                   icon: Icon(Icons.more_vert, size: 16, color: Colors.grey[400]),
                                   padding: EdgeInsets.zero,
                                   itemBuilder: (context) => [
                                     const PopupMenuItem(value: 'edit', child: Text('Modifica')),
                                     const PopupMenuItem(value: 'delete', child: Text('Elimina', style: TextStyle(color: Colors.red))),
                                   ],
                                   onSelected: (value) {
                                     if (value == 'delete') {
                                       setState(() => _comments.removeAt(index));
                                     } else if (value == 'edit') {
                                       _editComment(c, index);
                                     }
                                   },
                                 ),
                             ],
                           ),
                         );
                        }),
                         Row(
                           children: [
                             IconButton(
                               icon: const Icon(Icons.image_outlined, color: Colors.grey), 
                               tooltip: 'Aggiungi Immagine (URL)',
                               onPressed: _addImageComment, // Add image action
                             ),
                             Expanded(
                               child: TextField(
                                 controller: _commentController,
                                 decoration: InputDecoration(
                                   hintText: 'Scrivi un commento...',
                                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                 ),
                               ),
                             ),
                             IconButton(icon: const Icon(Icons.send_rounded, color: Colors.blue), onPressed: _addComment),
                           ],
                         ),
                      ],
                    ),
                  ),
                  
                  // RIGHT COLUMN: Sidebar Metadata
                  Container(width: 1, color: dialogBorder),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        _buildSidebarGroup(
                           title: 'STATO',
                           isDark: dialogIsDark,
                           child: DropdownButtonFormField<String>(
                             value: _statusId,
                             decoration: _sidebarInputDec(dialogIsDark),
                             borderRadius: BorderRadius.circular(12),
                             dropdownColor: dialogBg,
                             elevation: 4,
                             icon: Icon(Icons.keyboard_arrow_down_rounded, color: dialogIsDark ? Colors.grey[400] : null),
                             style: TextStyle(color: dialogTextColor, fontSize: 14),
                             items: widget.listColumns.map((c) => DropdownMenuItem(value: c.id, child: Text(c.title))).toList(),
                             onChanged: (v) => setState(() => _statusId = v!),
                           ),
                        ),
                        
                        _buildSidebarGroup(
                           title: 'PRIORITÀ',
                           isDark: dialogIsDark,
                           child: DropdownButtonFormField<TodoTaskPriority>(
                             value: _priority,
                             decoration: _sidebarInputDec(dialogIsDark),
                             borderRadius: BorderRadius.circular(12),
                             dropdownColor: dialogBg,
                             elevation: 4,
                             icon: Icon(Icons.keyboard_arrow_down_rounded, color: dialogIsDark ? Colors.grey[400] : null),
                             style: TextStyle(color: dialogTextColor, fontSize: 14),
                             items: TodoTaskPriority.values.map((p) => DropdownMenuItem(
                               value: p, 
                               child: Row(children: [
                                 Icon(Icons.flag, size: 16, color: _getPriorityColor(p)), 
                                 const SizedBox(width: 8), 
                                 Text(p.name.toUpperCase(), style: const TextStyle(fontSize: 12))
                               ])
                             )).toList(),
                             onChanged: (v) => setState(() => _priority = v!),
                           ),
                        ),

                        _buildSidebarGroup(
                           title: 'ASSEGNATARI',
                           isDark: dialogIsDark,
                           child: InkWell(
                             onTap: _showAssigneeSelector,
                             child: Container(
                               padding: const EdgeInsets.all(12),
                               decoration: BoxDecoration(
                                 color: dialogInputBg,
                                 border: Border.all(color: dialogBorder),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: _assignedTo.isEmpty 
                                 ? Text('Nessuno', style: TextStyle(color: dialogIsDark ? Colors.grey[500] : Colors.grey))
                                 : Wrap(
                                     spacing: 4,
                                     runSpacing: 4,
                                     children: _assignedTo.map((e) => Chip(
                                       label: Text(e.split('@')[0], style: TextStyle(fontSize: 10, color: dialogTextColor)),
                                       avatar: CircleAvatar(child: Text(e[0].toUpperCase(), style: const TextStyle(fontSize: 8))),
                                       padding: EdgeInsets.zero,
                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                       onDeleted: () => setState(() => _assignedTo.remove(e)),
                                     )).toList(),
                                   ),
                             ),
                           ),
                        ),

                        _buildSidebarGroup(
                           title: 'TAGS',
                           isDark: dialogIsDark,
                           child: InkWell(
                             onTap: _showTagSelectorDialog,
                             child: Container(
                               width: double.infinity,
                               padding: const EdgeInsets.all(12),
                               decoration: BoxDecoration(
                                 color: dialogInputBg,
                                 border: Border.all(color: dialogBorder),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: _assignedTags.isEmpty 
                                 ? Text('Nessun tag', style: TextStyle(color: dialogIsDark ? Colors.grey[500] : Colors.grey))
                                 : Wrap(
                                     spacing: 4, runSpacing: 4,
                                     children: _assignedTags.map((t) => Chip(
                                       label: Text(t.title, style: const TextStyle(fontSize: 10, color: Colors.white)),
                                       backgroundColor: Color(t.colorValue),
                                       padding: EdgeInsets.zero,
                                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                       onDeleted: () => setState(() => _assignedTags.remove(t)),
                                     )).toList(),
                                ),
                             ),
                           ),
                        ),

                        _buildSidebarGroup(
                           title: 'SCADENZA',
                           isDark: dialogIsDark,
                           child: InkWell(
                             onTap: _pickDueDate,
                             borderRadius: BorderRadius.circular(8),
                             child: Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                               decoration: BoxDecoration(
                                 color: dialogInputBg,
                                 border: Border.all(color: dialogBorder),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               child: Row(
                                 children: [
                                   Expanded(
                                     child: Row(
                                       children: [
                                         Icon(Icons.calendar_today_rounded, size: 16, color: _dueDate != null ? Colors.blue : Colors.grey),
                                         const SizedBox(width: 8),
                                         Text(
                                            _dueDate != null ? DateFormat('dd MMM yyyy').format(_dueDate!) : 'Imposta data',
                                            style: TextStyle(
                                              color: _dueDate != null ? (dialogIsDark ? Colors.white : Colors.black) : Colors.grey,
                                              fontWeight: _dueDate != null ? FontWeight.w500 : FontWeight.normal
                                            ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   if (_dueDate != null)
                                     InkWell(
                                       onTap: () => setState(() => _dueDate = null),
                                       child: const Padding(
                                         padding: EdgeInsets.all(4.0),
                                         child: Icon(Icons.close, size: 16, color: Colors.grey),
                                       ),
                                     ),
                                 ],
                               ),
                             ),
                           ),
                        ),
                        
                        _buildSidebarGroup(
                           title: 'EFFORT',
                           isDark: dialogIsDark,
                           child: TextField(
                             controller: _effortController,
                             keyboardType: TextInputType.number,
                             style: TextStyle(color: dialogTextColor),
                             decoration: _sidebarInputDec(dialogIsDark).copyWith(
                               hintText: 'Punti (es. 5)',
                               hintStyle: TextStyle(color: dialogIsDark ? Colors.grey[500] : null),
                               filled: true,
                               fillColor: dialogInputBg,
                             ),
                           ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Footer (Save)
             Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoCancel ?? 'Cancel')),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(AppLocalizations.of(context)?.smartTodoSave ?? 'Save'),
                  ),
                ],
              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _sidebarInputDec(bool isDark) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), 
        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), 
        borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[300]!)
      ),
      filled: true,
      fillColor: isDark ? const Color(0xFF2D3748) : Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      isDense: true,
    );
  }

  Widget _buildSectionHeader(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.grey[400] : Colors.grey));
  }
  
  Widget _buildSidebarGroup({required String title, required Widget child, bool isDark = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? Colors.grey[400] : Colors.grey)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  void _showAssigneeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Assegna a'),
          content: SizedBox(
             width: 300,
             child: SingleChildScrollView(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: widget.listParticipants.map((email) {
                    final isSelected = _assignedTo.contains(email);
                    return CheckboxListTile(
                      title: Text(email),
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                             if (!_assignedTo.contains(email)) _assignedTo.add(email);
                          } else {
                             _assignedTo.remove(email);
                          }
                        });
                        Navigator.pop(context); // Close after select? Or keep open? Let's keep simpler: Close for now or StatefulBuilder?
                        // If we want multiple, we need StatefulBuilder in dialog or just update parent state.
                        // For simplicity, just update parent and recreate dialog logic or just use pop to refresh is clunky.
                        // Let's assume standard toggle.
                        _showAssigneeSelector(); // Re-open (simple hack) or use StatefulBuilder
                      },
                    );
                 }).toList(),
               ),
             ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoClose ?? 'Close')),
          ],
        );
      }
    );
  }

  void _showTagSelectorDialog() async {
    if (widget.listAvailableTags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.smartTodoNoTagsAvailable ?? 'No tags available. Create one in settings.')));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)?.smartTodoSelectTags ?? 'Select Tags'),
            content: SizedBox(
              width: 300,
              child: Wrap(
                spacing: 8, runSpacing: 8,
                children: widget.listAvailableTags.map((tag) {
                  final isSelected = _assignedTags.any((t) => t.id == tag.id);
                  return FilterChip(
                    label: Text(tag.title),
                    selected: isSelected,
                    checkmarkColor: Colors.white,
                    selectedColor: Color(tag.colorValue),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    onSelected: (val) {
                      this.setState(() {
                         if (val) {
                           if (!_assignedTags.any((t) => t.id == tag.id)) _assignedTags.add(tag);
                         } else {
                           _assignedTags.removeWhere((t) => t.id == tag.id);
                         }
                      });
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoDone ?? 'Done'))],
          );
        }
      )
    );
  }

  Color _getPriorityColor(TodoTaskPriority p) {
    switch (p) {
      case TodoTaskPriority.high: return Colors.red;
      case TodoTaskPriority.medium: return Colors.orange;
      case TodoTaskPriority.low: return Colors.blue;
    }
  }

  void _pickDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() => _dueDate = date);
    }
  }

  void _addSubtask() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuovo stato'),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    ).then((_) {
      if (controller.text.isNotEmpty) {
        setState(() {
          _subtasks.add(TodoSubtask(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: controller.text,
          ));
        });
      }
    });
  }

  void _addAttachment() {
    final nameCtrl = TextEditingController();
    final urlCtrl = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.smartTodoAddLinkTitle ?? 'Add Link'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.smartTodoLinkName ?? 'Name')),
            TextField(controller: urlCtrl, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.smartTodoLinkUrl ?? 'URL (https://...)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoCancel ?? 'Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(AppLocalizations.of(context)?.smartTodoAdd ?? 'Add')),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && nameCtrl.text.isNotEmpty && urlCtrl.text.isNotEmpty) {
        setState(() {
          _attachments.add(TodoAttachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: nameCtrl.text,
            url: urlCtrl.text,
          ));
        });
      }
    });
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;
    
    final user = AuthService().currentUser;
    final newComment = TodoComment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorEmail: user?.email ?? 'anonymous',
      authorName: user?.displayName ?? (AppLocalizations.of(context)?.smartTodoUser ?? 'User'),
      text: _commentController.text.trim(),
      timestamp: DateTime.now(),
    );
    
    setState(() {
      _comments.add(newComment);
      _commentController.clear();
    });
  }

  Future<void> _launchAttachment(String url) async {
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.endsWith('.jpg') || 
        lowerUrl.endsWith('.jpeg') || 
        lowerUrl.endsWith('.png') || 
        lowerUrl.endsWith('.gif') || 
        lowerUrl.endsWith('.webp')) {
      _showImageLightbox(url);
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.smartTodoCannotOpenLink ?? 'Cannot open link')));
    }
  }

  void _showImageLightbox(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            InteractiveViewer(
              child: Image.network(imageUrl),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePasteShortcut() async {
    // 1. Try generic text/url paste first
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;

    if (text != null && text.isNotEmpty) {
      final lower = text.toLowerCase();
      final isImage = lower.endsWith('.jpg') || lower.endsWith('.png') || lower.endsWith('.jpeg') || lower.endsWith('.gif') || lower.endsWith('.webp');
      
      if (isImage) {
        _promptToAddImage(text); // Helper method
        return;
      }
    }

    // 2. Try Pasteboard for image data
    try {
      final imageBytes = await Pasteboard.image;
      if (imageBytes != null) {
        // We have image bytes. 
        final base64Image = base64Encode(imageBytes);
        final dataUri = 'data:image/png;base64,$base64Image';
        
        _promptToAddImage(dataUri, isDataUri: true);
      }
    } catch (e) {
      debugPrint('Pasteboard error: $e');
    }
  }

  void _promptToAddImage(String imageSource, {bool isDataUri = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incolla Immagine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isDataUri ? 'Immagine dagli appunti trovata.' : 'Vuoi aggiungere questa immagine dai tuoi appunti?'),
            const SizedBox(height: 12),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
                image: DecorationImage(
                  image: isDataUri 
                    ? MemoryImage(base64Decode(imageSource.split(',').last)) as ImageProvider
                    : NetworkImage(imageSource),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final user = AuthService().currentUser;
              setState(() {
                _comments.add(TodoComment(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  authorEmail: user?.email ?? 'anonymous',
                  authorName: user?.displayName ?? 'Utente',
                  text: '',
                  imageUrl: imageSource,
                  timestamp: DateTime.now(),
                ));
              });
            }, 
            child: Text(AppLocalizations.of(context)!.smartTodoYesAdd)
          ),
        ],
      ),
    );
  }

  void _addImageComment() {
    final urlCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.smartTodoAddImage ?? 'Add Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)?.smartTodoImageUrlHint ?? 'Paste the image URL (e.g. captured with CleanShot/Gyazo)'),
            const SizedBox(height: 12),
            TextField(controller: urlCtrl, decoration: InputDecoration(labelText: AppLocalizations.of(context)?.smartTodoImageUrl ?? 'Image URL'), autofocus: true),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final data = await Clipboard.getData(Clipboard.kTextPlain);
                if (data?.text != null) {
                  urlCtrl.text = data!.text!;
                }
              },
              icon: const Icon(Icons.paste),
              label: Text(AppLocalizations.of(context)?.smartTodoPasteFromClipboard ?? 'Paste from Clipboard')
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoCancel ?? 'Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, urlCtrl.text), child: Text(AppLocalizations.of(context)?.smartTodoAdd ?? 'Add')),
        ],
      ),
    ).then((url) {
       if (url != null && url.isNotEmpty) {
         final user = AuthService().currentUser;
         final newComment = TodoComment(
           id: DateTime.now().millisecondsSinceEpoch.toString(),
           authorEmail: user?.email ?? 'anonymous',
           authorName: user?.displayName ?? (AppLocalizations.of(context)?.smartTodoUser ?? 'User'),
           text: '',
           imageUrl: url,
           timestamp: DateTime.now(),
         );
         setState(() => _comments.add(newComment));
       }
    });
  }

  void _editComment(TodoComment c, int index) {
      final editCtrl = TextEditingController(text: c.text);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)?.smartTodoEditComment ?? 'Edit comment'),
          content: TextField(controller: editCtrl, autofocus: true, maxLines: 3),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context)?.smartTodoCancel ?? 'Cancel')),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _comments[index] = TodoComment(
                    id: c.id,
                    authorEmail: c.authorEmail,
                    authorName: c.authorName,
                    text: editCtrl.text.trim(),
                    imageUrl: c.imageUrl, // Preserve image
                    timestamp: c.timestamp,
                  );
                });
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)?.smartTodoSave ?? 'Save'),
            ),
          ],
        ),
      );
  }

  void _save() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)?.smartTodoEnterTitle ?? 'Enter a title')));
      return;
    }

    final newTask = TodoTaskModel(
      id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      listId: widget.listId,
      title: _titleController.text,
      description: _descController.text,
      statusId: _statusId,
      priority: _priority,
      createdAt: widget.task?.createdAt ?? DateTime.now(),
      dueDate: _dueDate,
      assignedTo: _assignedTo,
      effort: int.tryParse(_effortController.text),
      subtasks: _subtasks,
      attachments: _attachments,
      comments: _comments,
      tags: _assignedTags,
      updatedAt: DateTime.now(),
    );
    
    Navigator.pop(context, newTask);
  }
}
