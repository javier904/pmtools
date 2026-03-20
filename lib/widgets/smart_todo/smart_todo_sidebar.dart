import 'package:flutter/material.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../l10n/app_localizations.dart';

class SmartTodoSidebar extends StatelessWidget {
  final List<TodoListModel> userLists;
  final String? selectedListId;
  final String? selectedFilter;
  final bool showArchived;
  final ValueChanged<String> onFilterSelected;
  final ValueChanged<String> onListSelected;
  final ValueChanged<bool> onArchivedToggled;
  final VoidCallback? onToggleSidebar;
  final VoidCallback onCreateList;
  final VoidCallback? onBackPressed;

  const SmartTodoSidebar({
    super.key,
    required this.userLists,
    required this.selectedListId,
    required this.selectedFilter,
    required this.showArchived,
    required this.onFilterSelected,
    required this.onListSelected,
    required this.onArchivedToggled,
    this.onToggleSidebar,
    required this.onCreateList,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    // Filtra liste normali (non archiviate) per contatori
    final activeLists = userLists.where((l) => !l.isArchived).toList();
    
    return Container(
      width: 250,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: back arrow + compact New List button
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 12, 12, 8),
            child: Row(
              children: [
                if (onBackPressed != null)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 20),
                    tooltip: 'Back',
                    onPressed: onBackPressed,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 36),
                  ),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: onCreateList,
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(
                        l10n?.smartTodoNewListDialogTitle ?? 'New List',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              children: [
                _buildFilterItem(
                  context,
                  icon: Icons.today,
                  title: l10n?.smartTodoFilterToday ?? 'Oggi',
                  value: 'today',
                  isSelected: selectedListId == null && selectedFilter == 'today',
                  color: Colors.blue,
                ),
                _buildFilterItem(
                  context,
                  icon: Icons.person_outline,
                  title: l10n?.smartTodoFilterMyTasks ?? 'In arrivo (My Tasks)',
                  value: 'all_my',
                  isSelected: selectedListId == null && selectedFilter == 'all_my',
                  color: Colors.orange,
                ),
                _buildFilterItem(
                  context,
                  icon: Icons.folder_shared_outlined,
                  title: l10n?.smartTodoFilterOwner ?? 'Creati da me (Owner)',
                  value: 'owner',
                  isSelected: selectedListId == null && selectedFilter == 'owner',
                  color: Colors.purple,
                ),
                
                const SizedBox(height: 16),
                
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n?.smartTodoMyProjects ?? 'I MIEI PROGETTI',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: showArchived 
                                ? (l10n?.archiveHideArchived ?? 'Nascondi archiviati')
                                : (l10n?.archiveShowArchived ?? 'Mostra archiviati'),
                            child: InkWell(
                              onTap: () => onArchivedToggled(!showArchived),
                              borderRadius: BorderRadius.circular(4),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  showArchived ? Icons.visibility_off : Icons.visibility,
                                  size: 16,
                                  color: theme.iconTheme.color?.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                          if (onToggleSidebar != null)
                            Tooltip(
                              message: 'Chiudi menu',
                              child: InkWell(
                                onTap: onToggleSidebar,
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    size: 16,
                                    color: theme.iconTheme.color?.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                if (userLists.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      l10n?.smartTodoNoListsPresent ?? 'Nessun progetto',
                      style: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                for (final list in userLists)
                  if (!list.isArchived || showArchived)
                    _buildListItem(
                      context,
                      list: list,
                      isSelected: selectedListId == list.id,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isSelected,
    Color? color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onFilterSelected(value),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: color ?? theme.iconTheme.color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? theme.textTheme.bodyLarge?.color : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required TodoListModel list,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onListSelected(list.id),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? (isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.view_kanban_outlined, size: 18, color: list.isArchived ? Colors.grey : theme.iconTheme.color?.withOpacity(0.6)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    list.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: list.isArchived 
                        ? Colors.grey 
                        : (isSelected ? theme.textTheme.bodyLarge?.color : theme.textTheme.bodyMedium?.color),
                    ),
                  ),
                ),
                if (list.isArchived)
                  const Icon(Icons.archive, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
