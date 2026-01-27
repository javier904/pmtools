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
    final l10n = AppLocalizations.of(context)!;
    if (retrospectives.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              l10n.retroNoRetrosFound,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onCreateNew,
              icon: const Icon(Icons.add),
              label: Text(l10n.retroCreateNew),
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
            childAspectRatio: 2.5,
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
        // EDIT: Allowed only before Voting phase
        if (onEdit != null && retro.currentPhase.index < RetroPhase.voting.index)
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                const Icon(Icons.edit, size: 16),
                const SizedBox(width: 8),
                Text(l10n?.actionEdit ?? 'Edit', style: const TextStyle(fontSize: 13)),
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
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(Icons.delete, size: 16, color: Colors.red),
                const SizedBox(width: 8),
                Text(l10n?.actionDelete ?? 'Delete', style: const TextStyle(fontSize: 13, color: Colors.red)),
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
    final l10n = AppLocalizations.of(context)!;
    final statusColor = _getStatusColor(retro.status);
    final statusLabel = _getStatusLabel(retro.status, l10n);

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => onTap(retro),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icona Template + Titolo + Menu
              Row(
                children: [
                  // Icona template con status dot
                  Tooltip(
                    message: '${retro.template.getLocalizedDisplayName(l10n)} - $statusLabel',
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: AppColors.pink.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(retro.template.icon, color: AppColors.pink, size: 14),
                          ),
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Theme.of(context).cardColor, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Titolo con tooltip
                  Expanded(
                    child: Tooltip(
                      message: retro.sprintName.isNotEmpty ? retro.sprintName : 'Sprint ${retro.sprintNumber}',
                      child: Text(
                        retro.sprintName.isNotEmpty ? retro.sprintName : 'Sprint ${retro.sprintNumber}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: retro.isArchived ? Colors.grey : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Badge archiviato
                  if (retro.isArchived)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Tooltip(
                        message: l10n.archiveBadge,
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
                    colorHex: '#E91E63',
                    size: 16,
                  ),
                  const SizedBox(width: 4),
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
              const SizedBox(height: 4),
              // Progress bar (phase-based)
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: _getPhaseProgress(retro.currentPhase),
                  minHeight: 2,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    retro.currentPhase == RetroPhase.completed
                        ? Colors.green
                        : AppColors.pink.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Stats compatte
              Row(
                children: [
                  _buildCompactRetroStat(
                    Icons.sticky_note_2_outlined,
                    '${retro.items.length}',
                    l10n.retroNotesCreated,
                  ),
                  const SizedBox(width: 12),
                  if (retro.actionItems.isNotEmpty) ...[
                    _buildCompactRetroStat(
                      Icons.check_circle_outline,
                      '${retro.actionItems.length}',
                      l10n.retroActionItemsLabel,
                    ),
                    const SizedBox(width: 12),
                  ],
                  _buildParticipantRetroStat(retro, l10n),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getPhaseProgress(RetroPhase phase) {
    switch (phase) {
      case RetroPhase.setup:
        return 0.0;
      case RetroPhase.icebreaker:
        return 0.2;
      case RetroPhase.writing:
        return 0.4;
      case RetroPhase.voting:
        return 0.6;
      case RetroPhase.discuss:
        return 0.8;
      case RetroPhase.completed:
        return 1.0;
    }
  }

  Widget _buildCompactRetroStat(IconData icon, String value, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce la statistica partecipanti con tooltip dettagliato (owner + partecipanti)
  Widget _buildParticipantRetroStat(RetrospectiveModel retro, AppLocalizations l10n) {
    final participantLines = <String>[];

    // Owner (createdBy)
    participantLines.add('${retro.createdBy} - 👑 Owner');

    // Partecipanti (non-owner)
    for (final email in retro.participantEmails) {
      if (email == retro.createdBy) continue;
      participantLines.add('$email - 👥 ${l10n.retroParticipantsLabel}');
    }

    final tooltipText = '${l10n.participants}:\n${participantLines.join('\n')}';

    return Tooltip(
      message: tooltipText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people, 
            size: 18, 
            color: (retro.createdBy == currentUserEmail) 
                ? const Color(0xFFFF4081) // Pink for Owner
                : Colors.grey, // Grey for Guest
          ),
          const SizedBox(width: 5),
          Text(
            '${retro.participantEmails.length}',
            style: TextStyle(
              fontSize: 14,
              color: (retro.createdBy == currentUserEmail) 
                  ? const Color(0xFFFF4081) // Pink Text for Owner (matching icon)
                  : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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

  String _getStatusLabel(RetroStatus status, AppLocalizations l10n) {
    switch (status) {
      case RetroStatus.draft: return l10n.retroStatusDraft;
      case RetroStatus.active: return l10n.retroStatusActive;
      case RetroStatus.completed: return l10n.retroStatusCompleted;
    }
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
