import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';
import '../home/favorite_star.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

class RetroListWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;
  final Function(RetrospectiveModel) onTap;
  final VoidCallback onCreateNew;
  final String currentUserEmail;
  final Function(RetrospectiveModel)? onEdit;
  final Function(RetrospectiveModel)? onDelete;
  final Function(RetrospectiveModel)? onArchive;
  final Function(RetrospectiveModel)? onRestore;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const RetroListWidget({
    Key? key,
    required this.retrospectives,
    required this.onTap,
    required this.onCreateNew,
    required this.currentUserEmail,
    this.onEdit,
    this.onDelete,
    this.onArchive,
    this.onRestore,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (retrospectives.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nessuna retrospettiva trovata',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onCreateNew,
              icon: const Icon(Icons.add),
              label: const Text('Crea Nuova'),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Card compatte - stesso layout di Agile Process Manager
        final compactCrossAxisCount = constraints.maxWidth > 1400
            ? 6
            : constraints.maxWidth > 1100
                ? 5
                : constraints.maxWidth > 800
                    ? 4
                    : constraints.maxWidth > 550
                        ? 3
                        : constraints.maxWidth > 350
                            ? 2
                            : 1;

        return GridView.builder(
          shrinkWrap: shrinkWrap,
          physics: physics,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: compactCrossAxisCount,
            childAspectRatio: 1.25,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: retrospectives.length,
          itemBuilder: (context, index) => _buildRetroCard(context, retrospectives[index]),
        );
      },
    );
  }

  void _showRetroMenuAtPosition(BuildContext context, RetrospectiveModel retro, Offset globalPosition) async {
    final l10n = AppLocalizations.of(context);
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      overlay.size.width - globalPosition.dx,
      overlay.size.height - globalPosition.dy,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      items: [
        if (onEdit != null)
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 16),
                SizedBox(width: 8),
                Text('Modifica', style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
        // Archive/Restore option
        if (retro.isArchived && onRestore != null)
          PopupMenuItem(
            value: 'restore',
            child: Row(
              children: [
                const Icon(Icons.unarchive, size: 16, color: Colors.orange),
                const SizedBox(width: 8),
                Text(l10n?.archiveRestoreAction ?? 'Restore', style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        if (!retro.isArchived && onArchive != null)
          PopupMenuItem(
            value: 'archive',
            child: Row(
              children: [
                const Icon(Icons.archive, size: 16, color: Colors.orange),
                const SizedBox(width: 8),
                Text(l10n?.archiveAction ?? 'Archive', style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        if (onDelete != null)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 16, color: Colors.red),
                SizedBox(width: 8),
                Text('Elimina', style: TextStyle(fontSize: 13, color: Colors.red)),
              ],
            ),
          ),
      ],
    );

    if (result != null) {
      switch (result) {
        case 'edit':
          onEdit?.call(retro);
          break;
        case 'archive':
          onArchive?.call(retro);
          break;
        case 'restore':
          onRestore?.call(retro);
          break;
        case 'delete':
          onDelete?.call(retro);
          break;
      }
    }
  }

  Widget _buildRetroCard(BuildContext context, RetrospectiveModel retro) {
    final statusColor = _getStatusColor(retro.status);
    final statusLabel = _getStatusLabel(retro.status);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => onTap(retro),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icona Template + Status Badge
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: retro.template.displayName,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.pink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(retro.template.icon, color: AppColors.pink),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          retro.sprintName.isNotEmpty ? retro.sprintName : 'Sprint ${retro.sprintNumber}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Tooltip(
                          message: 'Stato: $statusLabel',
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: statusColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              statusLabel,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Badge archiviato
                  if (retro.isArchived)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Tooltip(
                        message: AppLocalizations.of(context)?.archiveBadge ?? 'Archived',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.archive, size: 12, color: Colors.orange),
                        ),
                      ),
                    ),
                  FavoriteStar(
                    resourceId: retro.id,
                    type: 'retrospective',
                    title: retro.sprintName.isNotEmpty ? retro.sprintName : 'Sprint ${retro.sprintNumber}',
                    colorHex: '#E91E63', // Pink for Retros
                    size: 16,
                  ),
                  // Menu (Only for Creator)
                  if (retro.createdBy == currentUserEmail && (onEdit != null || onDelete != null || onArchive != null || onRestore != null))
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showRetroMenuAtPosition(context, retro, details.globalPosition);
                      },
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(Icons.more_vert, size: 16, color: Colors.grey),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 8),
              
              // Metadata: Membri, Output
              Row(
                children: [
                   // Partecipanti
                   Tooltip(
                     message: 'Partecipanti',
                     child: Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                   ),
                   const SizedBox(width: 4),
                   Text(
                     '${retro.participantEmails.length}',
                     style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                   ),
                   const SizedBox(width: 12),
                   
                   // Items Generator
                   Tooltip(
                     message: 'Note create',
                     child: Icon(Icons.sticky_note_2_outlined, size: 14, color: Colors.grey[600]),
                   ),
                   const SizedBox(width: 4),
                   Text(
                     '${retro.items.length}',
                     style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                   ),
                   
                   // Action Items
                   if (retro.actionItems.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Tooltip(
                        message: 'Action Items',
                        child: Icon(Icons.check_circle_outline, size: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${retro.actionItems.length}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                      ),
                   ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Data: ${_formatDate(retro.createdAt)}',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(RetroStatus status) {
    switch (status) {
      case RetroStatus.draft: return Colors.orange;
      case RetroStatus.active: return Colors.green;
      case RetroStatus.completed: return Colors.blue;
    }
  }

  String _getStatusLabel(RetroStatus status) {
    switch (status) {
      case RetroStatus.draft: return 'Bozza';
      case RetroStatus.active: return 'In Corso';
      case RetroStatus.completed: return 'Completata';
    }
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
