import 'package:flutter/material.dart';
import '../../models/retrospective_model.dart';
import '../../models/sprint_model.dart';

/// Widget principale per il board della retrospettiva
class RetroBoardWidget extends StatefulWidget {
  final RetrospectiveModel? retrospective;
  final SprintModel? sprint;
  final String currentUserEmail;
  final void Function(RetroItem item, RetroCategory category)? onAddItem;
  final void Function(String itemId, RetroCategory category)? onRemoveItem;
  final void Function(String itemId, int votes, RetroCategory category)? onVoteItem;
  final void Function(ActionItem action)? onAddAction;
  final void Function(String actionId)? onToggleAction;
  final void Function(int sentiment)? onSentimentVote;

  const RetroBoardWidget({
    super.key,
    this.retrospective,
    this.sprint,
    required this.currentUserEmail,
    this.onAddItem,
    this.onRemoveItem,
    this.onVoteItem,
    this.onAddAction,
    this.onToggleAction,
    this.onSentimentVote,
  });

  @override
  State<RetroBoardWidget> createState() => _RetroBoardWidgetState();
}

class _RetroBoardWidgetState extends State<RetroBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Sprint info header
        if (widget.sprint != null) _buildSprintHeader(),
        const SizedBox(height: 16),

        // Sentiment voting
        SentimentVoteWidget(
          votes: widget.retrospective?.sentimentVotes ?? {},
          currentUserEmail: widget.currentUserEmail,
          onVote: widget.onSentimentVote,
        ),
        const SizedBox(height: 16),

        // Three columns: Went Well, To Improve, Action Items
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Went Well
              Expanded(
                child: _buildColumn(
                  'Cosa è andato bene',
                  Icons.thumb_up,
                  Colors.green,
                  RetroCategory.wentWell,
                  widget.retrospective?.wentWell ?? [],
                ),
              ),
              const SizedBox(width: 16),
              // To Improve
              Expanded(
                child: _buildColumn(
                  'Cosa migliorare',
                  Icons.build,
                  Colors.orange,
                  RetroCategory.toImprove,
                  widget.retrospective?.toImprove ?? [],
                ),
              ),
              const SizedBox(width: 16),
              // Action Items
              Expanded(
                child: _buildActionItemsColumn(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSprintHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.history, color: Colors.purple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Retrospettiva: ${widget.sprint!.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.sprint!.goal.isNotEmpty)
                    Text(
                      'Goal: ${widget.sprint!.goal}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                ],
              ),
            ),
            // Sprint stats
            _buildSprintStat('Pianificati', '${widget.sprint!.plannedPoints}', Colors.blue),
            const SizedBox(width: 16),
            _buildSprintStat('Completati', '${widget.sprint!.completedPoints}', Colors.green),
            const SizedBox(width: 16),
            _buildSprintStat(
              'Velocity',
              widget.sprint!.velocity?.toStringAsFixed(1) ?? '-',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSprintStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildColumn(
    String title,
    IconData icon,
    Color color,
    RetroCategory category,
    List<RetroItem> items,
  ) {
    return Card(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${items.length}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length + 1, // +1 for add button
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return _buildAddItemButton(category, color);
                }
                return RetroItemWidget(
                  item: items[index],
                  color: color,
                  currentUserEmail: widget.currentUserEmail,
                  onVote: widget.onVoteItem != null
                      ? (votes) => widget.onVoteItem!(items[index].id, votes, category)
                      : null,
                  onRemove: widget.onRemoveItem != null
                      ? () => widget.onRemoveItem!(items[index].id, category)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItemButton(RetroCategory category, Color color) {
    return InkWell(
      onTap: () => _showAddItemDialog(category),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3), style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: color, size: 18),
            const SizedBox(width: 4),
            Text(
              'Aggiungi',
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItemsColumn() {
    final actions = widget.retrospective?.actionItems ?? [];

    return Card(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.assignment_turned_in, color: Colors.purple, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Action Items',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${actions.where((a) => a.isCompleted).length}/${actions.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Actions list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: actions.length + 1,
              itemBuilder: (context, index) {
                if (index == actions.length) {
                  return _buildAddActionButton();
                }
                return ActionItemWidget(
                  action: actions[index],
                  onToggle: widget.onToggleAction != null
                      ? () => widget.onToggleAction!(actions[index].id)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddActionButton() {
    return InkWell(
      onTap: _showAddActionDialog,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.purple, size: 18),
            SizedBox(width: 4),
            Text(
              'Nuova Action',
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog(RetroCategory category) {
    final controller = TextEditingController();
    final isWentWell = category == RetroCategory.wentWell;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isWentWell ? Icons.thumb_up : Icons.build,
              color: isWentWell ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 8),
            Text(isWentWell ? 'Cosa è andato bene' : 'Cosa migliorare'),
          ],
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Descrizione',
            hintText: isWentWell
                ? 'Es: Team collaboration was excellent'
                : 'Es: Need better documentation',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final item = RetroItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  content: controller.text.trim(),
                  authorEmail: widget.currentUserEmail,
                  authorName: widget.currentUserEmail.split('@').first,
                  createdAt: DateTime.now(),
                );
                widget.onAddItem?.call(item, category);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isWentWell ? Colors.green : Colors.orange,
            ),
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }

  void _showAddActionDialog() {
    final titleController = TextEditingController();
    String? assignee;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.assignment_turned_in, color: Colors.purple),
              SizedBox(width: 8),
              Text('Nuova Action Item'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Descrizione',
                  hintText: 'Es: Improve code review process',
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Assegnato a (email)',
                  hintText: 'Es: mario@example.com',
                ),
                onChanged: (value) => assignee = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isNotEmpty) {
                  final action = ActionItem(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    description: titleController.text.trim(),
                    assigneeEmail: assignee?.trim(),
                    createdAt: DateTime.now(),
                  );
                  widget.onAddAction?.call(action);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Crea'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget per singolo item della retrospettiva
class RetroItemWidget extends StatelessWidget {
  final RetroItem item;
  final Color color;
  final String currentUserEmail;
  final void Function(int votes)? onVote;
  final VoidCallback? onRemove;

  const RetroItemWidget({
    super.key,
    required this.item,
    required this.color,
    required this.currentUserEmail,
    this.onVote,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasVoted = item.votedBy.contains(currentUserEmail);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.content,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                if (onRemove != null && item.authorEmail == currentUserEmail)
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: onRemove,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: Colors.grey,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Author
                CircleAvatar(
                  radius: 10,
                  backgroundColor: color.withOpacity(0.2),
                  child: Text(
                    item.authorEmail[0].toUpperCase(),
                    style: TextStyle(fontSize: 10, color: color),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  item.authorEmail.split('@').first,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                const Spacer(),
                // Vote button
                InkWell(
                  onTap: onVote != null
                      ? () => onVote!(hasVoted ? item.votes - 1 : item.votes + 1)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: hasVoted ? color : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          hasVoted ? Icons.favorite : Icons.favorite_border,
                          size: 14,
                          color: hasVoted ? Colors.white : color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.votes}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: hasVoted ? Colors.white : color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget per action item
class ActionItemWidget extends StatelessWidget {
  final ActionItem action;
  final VoidCallback? onToggle;

  const ActionItemWidget({
    super.key,
    required this.action,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: action.isCompleted ? Colors.green.withOpacity(0.05) : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: IconButton(
          icon: Icon(
            action.isCompleted ? Icons.check_circle : Icons.circle_outlined,
            color: action.isCompleted ? Colors.green : Colors.grey,
          ),
          onPressed: onToggle,
        ),
        title: Text(
          action.title,
          style: TextStyle(
            decoration: action.isCompleted ? TextDecoration.lineThrough : null,
            color: action.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: action.assigneeEmail != null
            ? Row(
                children: [
                  const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    action.assigneeEmail!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            : null,
        trailing: action.dueDate != null
            ? Text(
                '${action.dueDate!.day}/${action.dueDate!.month}',
                style: TextStyle(
                  fontSize: 11,
                  color: action.dueDate!.isBefore(DateTime.now()) && !action.isCompleted
                      ? Colors.red
                      : Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}

/// Widget per votazione sentiment del team
class SentimentVoteWidget extends StatelessWidget {
  final Map<String, int> votes; // email -> sentiment (1-5)
  final String currentUserEmail;
  final void Function(int sentiment)? onVote;

  const SentimentVoteWidget({
    super.key,
    required this.votes,
    required this.currentUserEmail,
    this.onVote,
  });

  @override
  Widget build(BuildContext context) {
    final currentVote = votes[currentUserEmail];
    final avgSentiment = votes.isEmpty
        ? 0.0
        : votes.values.reduce((a, b) => a + b) / votes.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Sentiment icons
            const Icon(Icons.mood, color: Colors.amber),
            const SizedBox(width: 12),
            const Text(
              'Come ti sei sentito nello sprint?',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            // Vote buttons
            ...List.generate(5, (index) {
              final sentiment = index + 1;
              final isSelected = currentVote == sentiment;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: onVote != null ? () => onVote!(sentiment) : null,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _getSentimentColor(sentiment)
                          : Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? _getSentimentColor(sentiment)
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getSentimentEmoji(sentiment),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(width: 16),
            // Average
            if (votes.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: _getSentimentColor(avgSentiment.round()).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      avgSentiment.toStringAsFixed(1),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _getSentimentColor(avgSentiment.round()),
                      ),
                    ),
                    Text(
                      '${votes.length} voti',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getSentimentEmoji(int sentiment) {
    switch (sentiment) {
      case 1:
        return '😢';
      case 2:
        return '😕';
      case 3:
        return '😐';
      case 4:
        return '😊';
      case 5:
        return '🤩';
      default:
        return '😐';
    }
  }

  Color _getSentimentColor(int sentiment) {
    switch (sentiment) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

/// Widget compatto per lista retrospettive
class RetroListWidget extends StatelessWidget {
  final List<RetrospectiveModel> retrospectives;
  final void Function(RetrospectiveModel)? onTap;
  final VoidCallback? onCreateNew;

  const RetroListWidget({
    super.key,
    required this.retrospectives,
    this.onTap,
    this.onCreateNew,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.history, color: Colors.purple),
                const SizedBox(width: 8),
                const Text(
                  'Retrospettive',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (onCreateNew != null)
                  TextButton.icon(
                    onPressed: onCreateNew,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Nuova'),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          // List
          if (retrospectives.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'Nessuna retrospettiva',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: retrospectives.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final retro = retrospectives[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getAvgSentimentColor(retro.averageSentiment),
                    child: Text(
                      _getAvgSentimentEmoji(retro.averageSentiment),
                    ),
                  ),
                  title: Text('Sprint Retrospective'),
                  subtitle: Text(
                    '${retro.wentWell.length} positivi • ${retro.toImprove.length} miglioramenti • ${retro.actionItems.length} azioni',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    '${retro.createdAt.day}/${retro.createdAt.month}/${retro.createdAt.year}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  onTap: onTap != null ? () => onTap!(retro) : null,
                );
              },
            ),
        ],
      ),
    );
  }

  String _getAvgSentimentEmoji(double? avg) {
    if (avg == null) return '😐';
    if (avg >= 4.5) return '🤩';
    if (avg >= 3.5) return '😊';
    if (avg >= 2.5) return '😐';
    if (avg >= 1.5) return '😕';
    return '😢';
  }

  Color _getAvgSentimentColor(double? avg) {
    if (avg == null) return Colors.grey[200]!;
    if (avg >= 4.5) return Colors.green;
    if (avg >= 3.5) return Colors.lightGreen;
    if (avg >= 2.5) return Colors.amber;
    if (avg >= 1.5) return Colors.orange;
    return Colors.red;
  }
}
