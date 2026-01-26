import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/themes/app_colors.dart';
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
    final l10n = AppLocalizations.of(context)!;

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
            message: column.getLocalizedDescription(l10n),
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
                          column.getLocalizedTitle(l10n).toUpperCase(),
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

          // Discussion Prompt - shown only during discuss phase
          if (retro.currentPhase == RetroPhase.discuss)
            _buildDiscussionPrompt(l10n),

          // Items List (Grid) - Card size optimized for ~70 characters visibility
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 80),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220, // Larger cards for 70+ chars (~18 chars x 4 lines)
                childAspectRatio: 1.4, // Taller cards for more text
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
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
    // Edit Enable: Writing phase AND own card
    final bool canEdit = retro.currentPhase == RetroPhase.writing && isMine;

    final cardContent = Container(
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
           Positioned.fill(
            child: Container(
              color: column.color.withValues(alpha: isDark ? 0.05 : 0.03),
            ),
          ),
          Positioned(
            left: 0, top: 0, bottom: 0, width: 3,
            child: Container(color: column.color),
          ),
          // Edit button for own cards in writing phase
          if (canEdit)
            Positioned(
              top: 4,
              right: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => _showEditDialog(context, item),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: column.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.edit, size: 14, color: column.color),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => _showDeleteConfirmation(context, item),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, size: 14, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, canEdit ? 28 : 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isContentVisible
                   ? Text(
                      item.content,
                      style: TextStyle(
                        fontSize: 15,
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
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          primaryColor: AppColors.retroPrimary,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.retroPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
             style: ElevatedButton.styleFrom(
               backgroundColor: AppColors.retroPrimary,
               foregroundColor: Colors.white,
             ),
          ),
        ),
        child: AlertDialog(
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
      ),
    );
  }

  void _showEditDialog(BuildContext context, RetroItem item) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: item.content);
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          primaryColor: AppColors.retroPrimary,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.retroPrimary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
             style: ElevatedButton.styleFrom(
               backgroundColor: AppColors.retroPrimary,
               foregroundColor: Colors.white,
             ),
          ),
        ),
        child: AlertDialog(
          title: Text(l10n.actionEdit),
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
                  final updatedItem = item.copyWith(content: controller.text.trim());
                  RetrospectiveFirestoreService().updateRetroItem(retro.id, updatedItem);
                  Navigator.pop(context);
                }
              },
              child: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, RetroItem item) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.actionDelete),
        content: Text(l10n.confirmDeleteMessage),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.no)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              RetrospectiveFirestoreService().deleteRetroItem(retro.id, item.id);
              Navigator.pop(context);
            },
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
  }

  /// Builds the discussion prompt widget for the discuss phase
  Widget _buildDiscussionPrompt(AppLocalizations l10n) {
    final discussionPrompt = RetroMethodologyGuide.getDiscussionPrompt(
      l10n,
      retro.template,
      column.id,
    );

    return Container(
      height: 72.0, // Fixed height to align columns
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: column.color.withOpacity(0.08),
        border: Border(
          bottom: BorderSide(color: column.color.withOpacity(0.2)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for better reading
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2), // Align icon with first line of text
            child: Icon(Icons.chat_bubble_outline, size: 16, color: column.color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              discussionPrompt,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: column.color.withOpacity(0.9),
                overflow: TextOverflow.ellipsis, // Ellipsis if it exceeds the fixed height
              ),
              maxLines: 4, // Max lines that fit in 72px
            ),
          ),
        ],
      ),
    );
  }
}
