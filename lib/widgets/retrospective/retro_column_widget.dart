import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RetroColumnWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final RetroColumn column;
  final String currentUserEmail;
  final String currentUserName;
  final bool showAuthorNames; // New Parameter

  const RetroColumnWidget({
    Key? key,
    required this.retro,
    required this.column,
    required this.currentUserEmail,
    required this.currentUserName,
    this.showAuthorNames = true, // Default true
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), // Compact header
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
                        size: 18, // Smaller icon
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          column.title.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13, // Smaller font
                            letterSpacing: 1.0,
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
                ],
              ),
            ),
          ),

          // Items List (Grid)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 80),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 Cards per row
                childAspectRatio: 2.8, // More compact (shorter)
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
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
    // Drag Enable: Discuss phase OR if Action Panel is explicitly visible (e.g. for creating action items)
    final bool isDraggable = retro.currentPhase == RetroPhase.discuss || retro.isActionItemsVisible;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final cardContent = Container(
      // ... existing decoration ...
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
           // ... existing children ...
           Positioned.fill(
            child: Container(
              color: column.color.withValues(alpha: isDark ? 0.05 : 0.03),
            ),
          ),
          Positioned(
            left: 0, top: 0, bottom: 0, width: 3, 
            child: Container(color: column.color),
          ),
          Padding(
            padding: const EdgeInsets.all(10), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isContentVisible
                   ? Text(
                      item.content,
                      style: TextStyle(
                        fontSize: 15, // Larger font
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[200] : Colors.grey[800],
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                   : _buildBlurredContent(context),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isContentVisible && showAuthorNames)
                        Expanded(child: _buildAuthorBadge(context, item, column, isDark))
                    else 
                       const Spacer(),
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
      return Draggable<RetroItem>( // Switched from LongPressDraggable to Draggable for easier interaction
        data: item,
        feedback: Material(
          elevation: 6, // Higher elevation for feedback
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          child: SizedBox(
            width: 200,
            height: 120,
            child: Opacity(opacity: 0.8, child: cardContent), // Slight opacity
          ),
        ),
        childWhenDragging: Opacity(opacity: 0.3, child: cardContent),
        child: cardContent,
      );
    }
    return cardContent;
  }
  
  // Helper for reused badge logic to keep build method clean
  Widget _buildAuthorBadge(BuildContext context, RetroItem item, RetroColumn column, bool isDark) {
      return Row(
          children: [
              CircleAvatar(
                  radius: 8, 
                  backgroundColor: column.color.withValues(alpha: 0.2),
                  child: Text(
                    item.authorName.isNotEmpty ? item.authorName[0].toUpperCase() : '?', 
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: column.color),
                  ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                    item.authorName,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
      );
  }

  Widget _buildBlurredContent(BuildContext context) {
    // Simplified blur for small cards
     return Center(
       child: Icon(Icons.visibility_off, size: 20, color: Colors.grey.withOpacity(0.5))
     );
  }

  Widget _buildVoteWidget(BuildContext context, RetroItem item) {
    final l10n = AppLocalizations.of(context)!;
    final bool hasVoted = item.hasVoted(currentUserEmail);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    // CHECK PHASE: Only allow voting in 'voting' phase
    // In other phases, show read-only count if votes > 0
    final bool isVotingPhase = retro.currentPhase == RetroPhase.voting;
    final bool showReadOnly = !isVotingPhase && item.votes > 0;

    if (!isVotingPhase && !showReadOnly) return const SizedBox.shrink();

    return InkWell(
      onTap: isVotingPhase ? () {
         final int totalVotes = retro.items.where((i) => i.hasVoted(currentUserEmail)).length;

         if (!hasVoted && totalVotes >= retro.maxVotesPerUser) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(l10n.retroVoteLimitReached(retro.maxVotesPerUser)), duration: const Duration(seconds: 1)),
           );
           return;
         }

         final service = RetrospectiveFirestoreService();
         service.voteItem(retro.id, item.id, currentUserEmail);
      } : null, // Disable tap if not voting phase
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasVoted 
              ? Colors.blue.withValues(alpha: 0.15) 
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasVoted ? Colors.blue.withValues(alpha: 0.4) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasVoted ? Icons.thumb_up : (isVotingPhase ? Icons.thumb_up_outlined : Icons.thumb_up), 
              size: 14,
              color: hasVoted ? Colors.blue : (isDark ? Colors.grey[400] : Colors.grey[500]),
            ),
            // Show count ONLY if NOT voting phase or (it's my vote and I want to see I voted? No user said hidden).
            // User: "must be hidden, and shown only when reveal is done".
            // So during Voting Phase -> Hide Count completely.
            if (!isVotingPhase && item.votes > 0) ...[
                const SizedBox(width: 4),
                Text(
                  '${item.votes}', 
                  style: TextStyle(
                    fontSize: 11, 
                    fontWeight: FontWeight.w800, 
                    color: hasVoted ? Colors.blue : (isDark ? Colors.grey[300] : Colors.grey[700]),
                  ),
                ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, RetroColumn column) {
    final l10n = AppLocalizations.of(context)!;
    // RESTRICTION: Only allow adding cards in 'Writing' phase. 
    // 'Discuss' phase is for discussion only.
    final bool canAdd = retro.currentPhase == RetroPhase.writing;
    if (!canAdd) return const SizedBox.shrink();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => _showAddDialog(context, column),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: column.color.withValues(alpha: 0.3),
            width: 1.5,
            // Note: BorderStyle.dashed not supported in Flutter web, using solid
          ),
          color: column.color.withValues(alpha: isDark ? 0.05 : 0.02),
        ),
        child: Center(
          child: Column( // Column for Grid
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: column.color, size: 20),
              const SizedBox(height: 8),
              Text(
                l10n.retroAddCardButton.toUpperCase(),
                style: TextStyle(
                  color: column.color,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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
