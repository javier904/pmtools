import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
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
    final Color headerColor = column.color.withOpacity(0.2);
    final Color bgColor = column.color.withOpacity(0.05);
    final Color textColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87;

    return Container(
      color: bgColor,
      child: Column(
        children: [
          // Header
          Tooltip(
            message: column.description.isNotEmpty ? column.description : column.title,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: column.color, // Full distinct color
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              width: double.infinity,
              child: Column( // Changed Row to Column to accommodate description
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        column.icon, 
                        size: 20, 
                        color: ThemeData.estimateBrightnessForColor(column.color) == Brightness.dark 
                            ? Colors.white 
                            : Colors.black87
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          column.title.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 0.5,
                            color: ThemeData.estimateBrightnessForColor(column.color) == Brightness.dark 
                                ? Colors.white 
                                : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (column.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      column.description,
                      style: TextStyle(
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                        color: ThemeData.estimateBrightnessForColor(column.color) == Brightness.dark 
                            ? Colors.white.withOpacity(0.9) 
                            : Colors.black87.withOpacity(0.7),
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
              padding: const EdgeInsets.all(12),
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

    final cardContent = Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isContentVisible)
               Text(
                item.content,
                style: const TextStyle(fontSize: 15, height: 1.3),
              )
            else
               _buildBlurredContent(context),

            const SizedBox(height: 12),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isContentVisible)
                    Row(
                        children: [
                            CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.grey.shade300,
                                child: Text(item.authorName.isNotEmpty ? item.authorName[0] : '?', 
                                    style: const TextStyle(fontSize: 9, color: Colors.black)),
                            ),
                            const SizedBox(width: 6),
                            Text(
                                item.authorName,
                                style: TextStyle(fontSize: 11, color: Theme.of(context).disabledColor),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.visibility_off, size: 14, color: Colors.grey),
          SizedBox(width: 8),
          Text(
            'Hiding while typing...',
            style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteWidget(BuildContext context, RetroItem item) {
    final bool hasVoted = item.hasVoted(currentUserEmail);

    return InkWell(
      onTap: () {
         final int totalVotes = retro.items.where((i) => i.hasVoted(currentUserEmail)).length;

         if (!hasVoted && totalVotes >= retro.maxVotesPerUser) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Hai raggiunto il limite di ${retro.maxVotesPerUser} voti!'), duration: const Duration(seconds: 1)),
           );
           return;
         }
         
         final service = RetrospectiveFirestoreService();
         service.voteItem(retro.id, item.id, currentUserEmail);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: hasVoted ? Colors.red.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: hasVoted ? Border.all(color: Colors.red.withOpacity(0.3)) : Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              hasVoted ? Icons.favorite : Icons.favorite_border,
              size: 14,
              color: hasVoted ? Colors.red : Colors.grey,
            ),
            const SizedBox(width: 4),
            Text('${item.votes}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: hasVoted ? Colors.red : Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, RetroColumn column) {
    final bool canAdd = retro.currentPhase == RetroPhase.writing || retro.currentPhase == RetroPhase.discuss;
    if (!canAdd) return const SizedBox.shrink();

    return InkWell(
      onTap: () => _showAddDialog(context, column),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor, width: 1), // Standard border
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(Icons.add, color: Theme.of(context).disabledColor),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context, RetroColumn column) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add to ${column.title}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'What are your thoughts?'),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
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
            child: const Text('Add Card'),
          ),
        ],
      ),
    );
  }
}
