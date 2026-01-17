import 'package:agile_tools/models/retrospective_model.dart';
import 'package:flutter/material.dart';

class RetroListWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;
  final Function(RetrospectiveModel) onTap;
  final VoidCallback onCreateNew;
  final String currentUserEmail; // Added
  final Function(RetrospectiveModel)? onDelete; // Added
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const RetroListWidget({
    Key? key,
    required this.retrospectives,
    required this.onTap,
    required this.onCreateNew,
    required this.currentUserEmail, // Required now
    this.onDelete,
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
        // Calcola quante card per riga - simile a EstimationRoomScreen
        final cardWidth = constraints.maxWidth > 1400
            ? (constraints.maxWidth - 30) / 6
            : constraints.maxWidth > 1100
                ? (constraints.maxWidth - 25) / 5
                : constraints.maxWidth > 800
                    ? (constraints.maxWidth - 18) / 4
                    : constraints.maxWidth > 550
                        ? (constraints.maxWidth - 12) / 3
                        : constraints.maxWidth > 350
                            ? (constraints.maxWidth - 6) / 2
                            : constraints.maxWidth;

        final isVerticalList = cardWidth == constraints.maxWidth;

        // Se è una lista verticale singola, possiamo usare ListView per performance se shrinkWrap lo permette
        // Ma per coerenza visiva usiamo Wrap o Grid
        // Dato che abbiamo shrinkWrap support, usiamo SingleChildScrollView + Wrap se shrinkWrap=false?
        // No, se shrinkWrap=true, dobbiamo rendere solo il contenuto.
        
        // Se shrinkWrap è true, questo è dentro un'altra scroll view.
        // Se false, è la scroll view principale.
        
        Widget content = Wrap(
          spacing: 6,
          runSpacing: 6,
          children: retrospectives.map((retro) => SizedBox(
            width: cardWidth,
            child: _buildRetroCard(context, retro),
          )).toList(),
        );

        if (shrinkWrap) {
          return content;
        } else {
          return SingleChildScrollView(
            physics: physics,
            child: content,
          );
        }
      },
    );
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
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(retro.template.icon, color: statusColor),
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
                  // Delete Action (Only for Creator)
                  if (retro.createdBy == currentUserEmail && onDelete != null)
                     IconButton(
                       icon: const Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                       tooltip: 'Elimina Retrospettiva',
                       onPressed: () => onDelete!(retro),
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
