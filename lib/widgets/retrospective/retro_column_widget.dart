import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RetroColumnWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final RetroColumn column;
  final String currentUserEmail;
  final String currentUserName;

  const RetroColumnWidget({
    Key? key,
    required this.retro,
    required this.column,
    required this.currentUserEmail,
    required this.currentUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get items for this column
    final items = retro.getItemsForColumn(column.id);
    
    // Theme
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark 
        ? column.color.withValues(alpha: 0.03)
        : column.color.withValues(alpha: 0.05);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
        ),
      ),
      child: Column(
        children: [
          // Header
          Tooltip(
            message: column.description.isNotEmpty ? column.description : column.title,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    column.color,
                    column.color.withValues(alpha: 0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: column.color.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        column.icon, 
                        size: 22, 
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          column.title.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            letterSpacing: 1.2,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (column.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      column.description,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 80),
              itemCount: items.length + 1, 
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return _buildAddButton(context, column);
                }
                return _buildItemCard(context, items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, RetroItem item) {
    final bool isMine = item.authorEmail == currentUserEmail;
    final bool isContentVisible = isMine || retro.areTeamCardsVisible || retro.currentPhase != RetroPhase.writing;
    final bool isDraggable = retro.currentPhase == RetroPhase.discuss;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final cardContent = Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Tint
          Positioned.fill(
            child: Container(
              color: column.color.withValues(alpha: isDark ? 0.05 : 0.03),
            ),
          ),
          
          // Left Accent Bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 5,
            child: Container(color: column.color),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isContentVisible)
                   Text(
                    item.content,
                    style: TextStyle(
                      fontSize: 15, 
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                    ),
                  )
                else
                   _buildBlurredContent(context),

                const SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isContentVisible)
                        Row(
                            children: [
                                CircleAvatar(
                                    radius: 10,
                                    backgroundColor: column.color.withValues(alpha: 0.2),
                                    child: Text(
                                      item.authorName.isNotEmpty ? item.authorName[0].toUpperCase() : '?', 
                                      style: TextStyle(
                                        fontSize: 10, 
                                        fontWeight: FontWeight.bold,
                                        color: column.color,
                                      ),
                                    ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                    item.authorName,
                                    style: TextStyle(
                                      fontSize: 12, 
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                ),
                            ],
                        )
                    else
                        const Text('???', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey)),

                    if (retro.currentPhase == RetroPhase.voting || retro.currentPhase == RetroPhase.discuss)
                      _buildVoteWidget(context, item)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (isDraggable) {
    if (isDraggable) {
      return Draggable<RetroItem>(
        data: item,
        feedback: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          child: SizedBox(
            width: 300,
            child: cardContent,
          ),
        ),
        childWhenDragging: Opacity(opacity: 0.5, child: cardContent),
        child: cardContent,
      );
    }
    }
    return cardContent;
  }

  Widget _buildBlurredContent(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.visibility_off, size: 14, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            l10n.retroHidingWhileTyping,
            style: const TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteWidget(BuildContext context, RetroItem item) {
    final l10n = AppLocalizations.of(context)!;
    final bool hasVoted = item.hasVoted(currentUserEmail);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
         final int totalVotes = retro.items.where((i) => i.hasVoted(currentUserEmail)).length;

         if (!hasVoted && totalVotes >= retro.maxVotesPerUser) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(l10n.retroVoteLimitReached(retro.maxVotesPerUser)), duration: const Duration(seconds: 1)),
           );
           return;
         }

         final service = RetrospectiveFirestoreService();
         service.voteItem(retro.id, item.id, currentUserEmail);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: hasVoted 
              ? Colors.red.withValues(alpha: 0.15) 
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hasVoted ? Colors.red.withValues(alpha: 0.4) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasVoted ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: hasVoted ? Colors.red : (isDark ? Colors.grey[400] : Colors.grey[500]),
            ),
            const SizedBox(width: 6),
            Text(
              '${item.votes}', 
              style: TextStyle(
                fontSize: 13, 
                fontWeight: FontWeight.w800, 
                color: hasVoted ? Colors.red : (isDark ? Colors.grey[300] : Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, RetroColumn column) {
    final l10n = AppLocalizations.of(context)!;
    final bool canAdd = retro.currentPhase == RetroPhase.writing || retro.currentPhase == RetroPhase.discuss;
    if (!canAdd) return const SizedBox.shrink();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: () => _showAddDialog(context, column),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: column.color.withValues(alpha: 0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
            color: column.color.withValues(alpha: isDark ? 0.05 : 0.02),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: column.color, size: 24),
                const SizedBox(width: 12),
                Text(
                  l10n.retroAddCardButton.toUpperCase(),
                  style: TextStyle(
                    color: column.color,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context, RetroColumn column) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.retroAddTo(column.title)),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: l10n.retroAddCardHint),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.actionCancel)),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final newItem = RetroItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  columnId: column.id,
                  content: controller.text.trim(),
                  authorEmail: currentUserEmail,
                  authorName: currentUserName,
                  createdAt: DateTime.now(),
                );

                RetrospectiveFirestoreService().addRetroItem(retro.id, newItem);
                Navigator.pop(context);
              }
            },
            child: Text(l10n.retroAddCard),
          ),
        ],
      ),
    );
  }
}
