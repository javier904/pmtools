import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../common/avatar_widget.dart';
import '../../themes/app_colors.dart';
import '../../services/secure_storage_service.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Card per visualizzare una User Story
///
/// Mostra:
/// - ID e titolo
/// - Priority badge (MoSCoW)
/// - Story points
/// - Status
/// - Tags
/// - Assignee
/// - Progress bar se in sprint
/// Card per visualizzare una User Story
///
/// Mostra:
/// - ID e titolo (modificabile inline)
/// - Priority badge (MoSCoW) (modificabile inline)
/// - Story points
/// - Status (modificabile inline)
/// - Tags
/// - Assignee
/// - Progress bar se in sprint
class StoryCardWidget extends StatefulWidget {
  final UserStoryModel story;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final void Function(StoryStatus)? onStatusChange;
  final void Function(StoryPriority)? onPriorityChange;
  final void Function(String)? onTitleChange;
  final void Function(int?)? onStoryPointsChange;
  final void Function(String?)? onAssigneeChange;
  final List<String> teamMembers;
  final VoidCallback? onEstimate;
  final VoidCallback? onAddToSprint;
  final bool showDragHandle;
  final bool compact;
  /// Nome dello sprint a cui appartiene la story (opzionale)
  final String? sprintName;
  /// Indica se lo sprint è completato
  /// Indica se lo sprint è completato
  final bool isSprintCompleted;
  final bool compactMode;
  final List<String> policyWarnings;
  final AgileFramework framework;
  final bool canMoveToBacklog;
  final bool isBoardContext;
  final bool canMarkAsReady;

  const StoryCardWidget({
    super.key,
    required this.story,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onStatusChange,
    this.onPriorityChange,
    this.onTitleChange,
    this.onStoryPointsChange,
    this.onAssigneeChange,
    this.teamMembers = const [],
    this.onEstimate,
    this.onAddToSprint,
    this.showDragHandle = false,
    this.compact = false,
    this.sprintName,
    this.isSprintCompleted = false,
    this.compactMode = false,
    this.policyWarnings = const [],
    required this.framework,
    this.canMoveToBacklog = true, // Default true for backward compatibility
    this.isBoardContext = false,
    this.canMarkAsReady = false,
  });

  @override
  State<StoryCardWidget> createState() => _StoryCardWidgetState();
}

class _StoryCardWidgetState extends State<StoryCardWidget> {
  bool _isEditingTitle = false;
  late TextEditingController _titleController;
  final FocusNode _titleFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.story.title);
  }

  @override
  void didUpdateWidget(StoryCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.story.title != oldWidget.story.title && !_isEditingTitle) {
      _titleController.text = widget.story.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  void _startEditingTitle() {
    setState(() {
      _isEditingTitle = true;
    });
    _titleFocus.requestFocus();
  }

  void _saveTitle() {
    final newTitle = _titleController.text.trim();
    if (newTitle.isNotEmpty && newTitle != widget.story.title) {
      widget.onTitleChange?.call(newTitle);
    }
    setState(() {
      _isEditingTitle = false;
    });
  }

  void _cancelEditingTitle() {
    setState(() {
      _isEditingTitle = false;
      _titleController.text = widget.story.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: widget.story.priority.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(widget.compact ? 8 : 12),
          child: widget.compact ? _buildCompactContent(context) : _buildFullContent(context),
        ),
      ),
    );
  }

  Widget _buildCompactContent(BuildContext context) {
    return Row(
      children: [
        // Priority indicator
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: widget.story.priority.color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.story.title,
                style: const TextStyle(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Metadata (ID, Points, Integration)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    widget.story.storyId,
                    style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                  ),
                  if (widget.story.externalIntegration != null) ...[
                    Icon(Icons.link, size: 12, color: Colors.blue[700]),
                    const SizedBox(width: 2),
                    Text(
                      widget.story.externalIntegration!.externalId,
                      style: TextStyle(fontSize: 11, color: Colors.blue[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                  if (widget.story.storyPoints != null)
                    _buildPointsBadge(),
                ],
              ),
            ],
          ),
        ),
        // Status & Policy area
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 90),
              child: _buildStatusBadge(),
            ),
            if (widget.policyWarnings.isNotEmpty) ... [
              const SizedBox(width: 4),
              _buildPolicyWarningBadge(context),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFullContent(BuildContext context) {
    if (!widget.compactMode) {
      return _buildBacklogLayout(context);
    }
    return _buildKanbanLayout(context);
  }

  Widget _buildBacklogLayout(BuildContext context) {
    final story = widget.story;
    
    // Right Side Items (Priority, Points, Menu)
    // Right Side Badges only (Priority, Points)
    final headerBadges = <Widget>[
      if (widget.onPriorityChange != null)
        _buildPriorityDropdown(context)
      else
        _buildPriorityBadge(),
      if (widget.onStoryPointsChange != null)
        _buildPointsDropdown(context)
      else if (story.storyPoints != null)
        _buildPointsBadge(),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 // Header Left: Drag, ID, Sprint, Jira
                 Wrap(
                   spacing: 6,
                   runSpacing: 4,
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children: [
                     if (widget.showDragHandle)
                       ReorderableDragStartListener(
                         index: 0,
                         child: Padding(
                           padding: const EdgeInsets.only(right: 6),
                           child: Icon(Icons.drag_handle, size: 16, color: context.textMutedColor),
                         ),
                       ),
                     _buildIdBadge(context),
                     if (widget.sprintName != null && 
                         story.status != StoryStatus.backlog && 
                         story.status != StoryStatus.refinement && 
                         story.status != StoryStatus.ready) _buildSprintBadge(),
                     if (story.externalIntegration != null) _buildJiraBadge(),
                     if (widget.policyWarnings.isNotEmpty) _buildPolicyWarningBadge(context),
                   ],
                 ),
                 const SizedBox(height: 6),
                 
                 // Title
                 _buildTitleRow(context),
                 
                 // Description
                 if (story.description.isNotEmpty && !_isEditingTitle) ...[
                   const SizedBox(height: 4),
                   Text(
                     story.description,
                     style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ],
                 
                 const SizedBox(height: 8),
                 
                 // Left Footer: Status, Tags, Checklist
                 Wrap(
                   spacing: 8,
                   runSpacing: 6,
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children: [
                      // Status
                      widget.onStatusChange != null
                          ? _buildStatusDropdown(context)
                          : _buildStatusBadge(),
                      
                      // Tags
                      ...story.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(fontSize: 9, color: Colors.blue),
                        ),
                      )),
                      
                      // Checklist
                      if (story.acceptanceCriteria.isNotEmpty) 
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.checklist, size: 14, color: context.textSecondaryColor),
                            const SizedBox(width: 2),
                            Text(
                              '${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length}',
                              style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                            ),
                          ],
                        ),
                   ],
                 ),
                 
                 // Progress bar
                if (story.status == StoryStatus.inSprint || 
                    story.status == StoryStatus.inProgress || 
                    story.status == StoryStatus.inReview) ...[
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  Tooltip(
                    message: _getProgressTooltip(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _calculateProgress(),
                        backgroundColor: context.surfaceVariantColor,
                        valueColor: AlwaysStoppedAnimation(story.status.color),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Right Sidebar area: Badges + Actions Column (Intrinsic width to push to end)
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Badges Area
              if (headerBadges.isNotEmpty)
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 160),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: headerBadges,
                    ),
                  ),
                ),
              
              const SizedBox(width: 8),

              // 2. Actions Column (Menu + Avatar) - Dedicated vertical stack
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Perfect vertical alignment
                children: [
                  _buildMenuButton(),
                  _buildAssigneeAvatar(context),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanLayout(BuildContext context) {
    // Current layout implementation for Kanban
    final story = widget.story;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Expanded(
               child: Wrap(
                 spacing: 6,
                 runSpacing: 4,
                 crossAxisAlignment: WrapCrossAlignment.center,
                 children: [
                   if (widget.showDragHandle)
                       ReorderableDragStartListener(
                         index: 0,
                         child: Padding(
                           padding: const EdgeInsets.only(right: 6),
                           child: Icon(Icons.drag_handle, size: 16, color: context.textMutedColor),
                         ),
                       ),
                   _buildIdBadge(context),
                   if (widget.sprintName != null && 
                       story.status != StoryStatus.backlog && 
                       story.status != StoryStatus.refinement && 
                       story.status != StoryStatus.ready) _buildSprintBadge(),
                   if (story.externalIntegration != null) _buildJiraBadge(),
                   if (widget.policyWarnings.isNotEmpty) _buildPolicyWarningBadge(context),
                 ],
               ),
             ),
             _buildMenuButton(),
          ],
        ),
        
        const SizedBox(height: 8),
        _buildTitleRow(context),

        if (story.description.isNotEmpty && !_isEditingTitle) ...[
          const SizedBox(height: 4),
          Text(
            story.description,
            style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
             if (widget.onPriorityChange != null)
                _buildPriorityDropdown(context, compact: true)
              else
                _buildPriorityBadge(compact: true),
             
             if (widget.onStoryPointsChange != null)
                _buildPointsDropdown(context)
              else if (story.storyPoints != null)
                _buildPointsBadge(),

             ...story.tags.map((tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                tag,
                style: const TextStyle(fontSize: 9, color: Colors.blue),
              ),
            )),
          ],
        ),
        
        const SizedBox(height: 8),

        // Context Footer (Flexible)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded( // Use Expanded to ensure left part is constrained
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Flexible(
                     child: widget.onStatusChange != null
                      ? _buildStatusDropdown(context, compact: true)
                      : _buildStatusBadge(compact: true),
                   ),
                   const SizedBox(width: 8),
                   if (story.acceptanceCriteria.isNotEmpty) ...[
                      Icon(Icons.checklist, size: 14, color: context.textSecondaryColor),
                      const SizedBox(width: 2),
                      Text(
                        '${story.completedAcceptanceCriteria}/${story.acceptanceCriteria.length}',
                        style: TextStyle(fontSize: 10, color: context.textSecondaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                   ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            _buildAssigneeAvatar(context),
          ],
        ),
        
        if (story.status == StoryStatus.inSprint || 
            story.status == StoryStatus.inProgress || 
            story.status == StoryStatus.inReview) ...[
          const SizedBox(height: 8),
          Tooltip(
            message: _getProgressTooltip(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _calculateProgress(),
                backgroundColor: context.surfaceVariantColor,
                valueColor: AlwaysStoppedAnimation(story.status.color),
                minHeight: 4,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Helper methods to reuse code
  Widget _buildIdBadge(BuildContext context) {
    return Container(
         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
         decoration: BoxDecoration(
           color: context.surfaceVariantColor,
           borderRadius: BorderRadius.circular(4),
         ),
         child: Text(
           widget.story.storyId,
           style: const TextStyle(
             fontSize: 10,
             fontWeight: FontWeight.w500,
             fontFamily: 'monospace',
           ),
         ),
       );
  }

  Widget _buildSprintBadge() {
    return Container(
         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
         decoration: BoxDecoration(
           color: widget.isSprintCompleted
               ? Colors.green.withOpacity(0.15)
               : Colors.blue.withOpacity(0.15),
           borderRadius: BorderRadius.circular(4),
           border: Border.all(
             color: widget.isSprintCompleted
                 ? Colors.green.withOpacity(0.3)
                 : Colors.blue.withOpacity(0.3),
           ),
         ),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(
                 widget.isSprintCompleted ? Icons.check_circle : Icons.flag,
                 size: 10,
                 color: widget.isSprintCompleted ? Colors.green : Colors.blue,
               ),
               const SizedBox(width: 4),
               ConstrainedBox(
                 constraints: const BoxConstraints(maxWidth: 80),
                 child: Text(
                   widget.sprintName!,
                   style: TextStyle(
                     fontSize: 10,
                     fontWeight: FontWeight.w500,
                     color: widget.isSprintCompleted ? Colors.green : Colors.blue,
                   ),
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
             ],
           ),
       );
  }

  Widget _buildJiraBadge() {
     return InkWell(
       onTap: () async {
         final creds = await SecureStorageService().getJiraCredentials();
         final domain = creds['domain'];
         if (domain != null && domain.isNotEmpty) {
           final url = Uri.parse('https://$domain/browse/${widget.story.externalIntegration!.externalId}');
           if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
           }
         }
       },
       borderRadius: BorderRadius.circular(4),
       child: Container(
         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
         decoration: BoxDecoration(
           color: Colors.blue.withOpacity(0.1),
           borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
         ),
         child: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             const Icon(Icons.link, size: 10, color: Colors.blue),
             const SizedBox(width: 4),
             Flexible(
               child: Text(
                 widget.story.externalIntegration!.externalId,
                 style: const TextStyle(
                   fontSize: 9,
                   color: Colors.blue,
                   fontWeight: FontWeight.bold,
                 ),
                 overflow: TextOverflow.ellipsis,
               ),
             ),
           ],
         ),
       ),
     );
  }

  Widget _buildPolicyWarningBadge(BuildContext context) {
    return Tooltip(
      message: 'Policy Violate:\n${widget.policyWarnings.map((e) => "• $e").join('\n')}',
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      showDuration: const Duration(seconds: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.red),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 14, color: Colors.red),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'POLICY', 
                style: const TextStyle(
                  fontSize: 9, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.red,
                  letterSpacing: 0.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
      if (_isEditingTitle) {
        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green, size: 18),
              onPressed: _saveTitle,
              tooltip: 'Salva',
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red, size: 18),
              onPressed: _cancelEditingTitle,
              tooltip: 'Annulla',
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(4),
            ),
            Expanded(
              child: TextField(
                controller: _titleController,
                focusNode: _titleFocus,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  border: UnderlineInputBorder(),
                ),
                onSubmitted: (_) => _saveTitle(),
              ),
            ),
          ],
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (widget.onTitleChange != null)
            InkWell(
              onTap: _startEditingTitle,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.edit, size: 14, color: context.textMutedColor),
              ),
            ),
        ],
      );
  }

  Widget _buildMenuButton() {
    if (widget.onEdit == null && widget.onDelete == null && widget.onAddToSprint == null) {
      return const SizedBox.shrink();
    }
    return PopupMenuButton<String>(
      tooltip: AppLocalizations.of(context)!.agileCardMenuTooltip,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: const Icon(Icons.more_vert, size: 20),
      itemBuilder: (context) => [
        if (widget.onAddToSprint != null && widget.framework != AgileFramework.kanban)
          const PopupMenuItem(
            value: 'sprint',
            child: Row(
            children: [
                Icon(Icons.flag, size: 18, color: Colors.blue),
                SizedBox(width: 8),
                Text('Aggiungi a Sprint'),
              ],
            ),
          ),
        if (widget.onEdit != null)
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text('Modifica'),
              ],
            ),
          ),
        if (widget.onDelete != null)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 18, color: Colors.red),
                SizedBox(width: 8),
                Text('Elimina', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
      ],
      onSelected: (value) {
        if (value == 'sprint') widget.onAddToSprint?.call();
        if (value == 'edit') widget.onEdit?.call();
        if (value == 'delete') widget.onDelete?.call();
      },
    );
  }

  Widget _buildPriorityBadge({bool compact = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.story.priority.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: widget.story.priority.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.story.priority.icon, size: 12, color: widget.story.priority.color),
          if (!compact) ...[
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                widget.story.priority.displayName,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.story.priority.color,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityDropdown(BuildContext context, {bool compact = false}) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<StoryPriority>(
      tooltip: '${l10n.agilePriority}: ${widget.story.priority.displayName}',
      initialValue: widget.story.priority,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.story.priority.color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: widget.story.priority.color.withOpacity(0.3)),
        ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.story.priority.icon, size: 12, color: widget.story.priority.color),
              if (!compact) ...[
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    widget.story.priority.displayName,
                    style: TextStyle(
                      fontSize: 10,
                      color: widget.story.priority.color,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.arrow_drop_down, size: 14, color: widget.story.priority.color),
              ],
            ],
          ),
        ),
        itemBuilder: (context) => StoryPriority.values.map((priority) => PopupMenuItem(
          value: priority,
          child: Row(
            children: [
              Icon(priority.icon, size: 18, color: priority.color),
              const SizedBox(width: 8),
              Text(priority.displayName),
            ],
          ),
        )).toList(),
      onSelected: widget.onPriorityChange,
    );
  }

  Widget _buildPointsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars, size: 12, color: Colors.green),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              '${widget.story.storyPoints}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsDropdown(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Fibonacci + usual values + 0
    final points = [0, 1, 2, 3, 5, 8, 13, 21];
    
    return PopupMenuButton<int>(
      tooltip: '${l10n.agileEstimate}: ${widget.story.storyPoints ?? '-'}',
      initialValue: widget.story.storyPoints,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars, size: 12, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              l10n.agilePointsValue(widget.story.storyPoints ?? 0),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
             const SizedBox(width: 4),
            Icon(Icons.arrow_drop_down, size: 14, color: Colors.green[700]),
          ],
        ),
      ),
      itemBuilder: (context) => points.map((p) => PopupMenuItem(
        value: p,
        child: Text(l10n.agilePointsValue(p)),
      )).toList(),
      onSelected: (val) => widget.onStoryPointsChange?.call(val),
    );
  }

  Widget _buildAssigneeAvatar(BuildContext context) {
    if (widget.onAssigneeChange == null) {
      if (widget.story.assigneeEmail == null) return const SizedBox.shrink();
      return Tooltip(
        message: widget.story.assigneeEmail!,
        child: AvatarWidget(
          name: widget.story.assigneeEmail,
          email: widget.story.assigneeEmail,
          radius: 10,
        ),
      );
    }

    return PopupMenuButton<String?>(
      tooltip: AppLocalizations.of(context)!.agileAssign,
      initialValue: widget.story.assigneeEmail,
      child: widget.story.assigneeEmail != null
          ? Tooltip(
              message: widget.story.assigneeEmail!,
              child: AvatarWidget(
                name: widget.story.assigneeEmail,
                email: widget.story.assigneeEmail,
                radius: 10,
              ),
            )
          : Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: context.textSecondaryColor, style: BorderStyle.solid),
              ),
              child: Icon(Icons.person_add, size: 14, color: context.textSecondaryColor),
            ),
      itemBuilder: (context) => [
        PopupMenuItem<String?>(
          value: null,
          child: Row(
            children: [
              const Icon(Icons.person_off, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context)!.agileNoAssignee, style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        ...widget.teamMembers.map((email) => PopupMenuItem<String?>(
          value: email,
          child: Row(
            children: [
              AvatarWidget(name: email, email: email, radius: 10),
              SizedBox(width: 8),
              Expanded(child: Text(email, overflow: TextOverflow.ellipsis)),
            ],
          ),
        )),
      ],
      onSelected: (email) => widget.onAssigneeChange?.call(email),
    );
  }

  Widget _buildStatusBadge({bool compact = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.story.status.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: const BoxConstraints(maxWidth: 140), // Force max width to prevent overflow
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.story.status.icon, size: 12, color: widget.story.status.color),
          if (!compact) ...[
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                widget.story.status.getDisplayName(widget.framework),
                style: TextStyle(
                  fontSize: 11,
                  color: widget.story.status.color,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context, {bool compact = false}) {
    final l10n = AppLocalizations.of(context)!;
    
    // Filtra stati disponibili per Developer e contesto (board vs backlog)
    final isDev = !widget.canMoveToBacklog;
    var selectableStatuses = StoryStatus.getSelectableStatuses(
      widget.framework,
      isDeveloper: isDev,
      isBoardContext: widget.isBoardContext,
    );

    return PopupMenuButton<StoryStatus>(
      tooltip: '${l10n.agileStatus}: ${widget.story.status.getDisplayName(widget.framework)}',
      initialValue: widget.story.status,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: widget.story.status.color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: widget.story.status.color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.story.status.icon, size: 12, color: widget.story.status.color),
            if (!compact) ...[
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  widget.story.status.getDisplayName(widget.framework),
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.story.status.color,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
             const SizedBox(width: 2),
            Icon(Icons.arrow_drop_down, size: 14, color: widget.story.status.color),
          ],
        ),
      ),
      itemBuilder: (context) {
        return StoryStatus.values.map((status) {
           // Se lo stato è quello attuale, lo mostriamo sempre
           if (status == widget.story.status) {
              return PopupMenuItem(
                value: status,
                child: Row(
                  children: [
                    Icon(status.icon, size: 18, color: status.color),
                    const SizedBox(width: 8),
                    Text(status.getDisplayName(widget.framework)),
                  ],
                ),
              );
           }
           
           // Altrimenti verifichiamo se è selezionabile
           if (!selectableStatuses.contains(status)) {
             return null; 
           }

           return PopupMenuItem(
            value: status,
            child: Row(
              children: [
                Icon(status.icon, size: 18, color: status.color),
                const SizedBox(width: 8),
                Text(status.getDisplayName(widget.framework)),
              ],
            ),
          );
        }).whereType<PopupMenuItem<StoryStatus>>().toList();
      },
      onSelected: (newStatus) {
          if (newStatus == widget.story.status) return;

          // Check extra di sicurezza (anche se UI è filtrata)
          if (newStatus == StoryStatus.backlog && !widget.canMoveToBacklog) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 content: Text(l10n.agilePermissionErrorBacklog),
                 backgroundColor: Colors.red,
               ),
             );
             return;
          }
          
          widget.onStatusChange?.call(newStatus);
      },
    );
  }

  double _calculateProgress() {
    // 1. Custom Progress (Manual Override)
    if (widget.story.customProgress != null) {
      return widget.story.customProgress! / 100.0;
    }

    // 2. Acceptance Criteria
    if (widget.story.acceptanceCriteria.isNotEmpty) {
      final fraction = widget.story.completedAcceptanceCriteria / widget.story.acceptanceCriteria.length;
      // Show minimum progress for active stories even if 0 criteria completed
      if (fraction == 0.0 && 
         (widget.story.status == StoryStatus.inSprint || 
          widget.story.status == StoryStatus.inProgress || 
          widget.story.status == StoryStatus.inReview)) {
         return 0.05; 
      }
      return fraction;
    }

    // 3. Status Defaults
    switch (widget.story.status) {
      case StoryStatus.backlog:
      case StoryStatus.refinement:
      case StoryStatus.ready:
        return 0;
      case StoryStatus.inSprint:
        return 0.1;
      case StoryStatus.inProgress:
        return 0.1; // Reduced from 0.5 to 0.1 as requested
      case StoryStatus.inReview:
        return 0.8;
      case StoryStatus.done:
        return 1.0;
    }
  }

  String _getProgressTooltip(BuildContext context) {
     final l10n = AppLocalizations.of(context)!;
     
     if (widget.story.customProgress != null) {
       return l10n.agileProgressTooltipManual(widget.story.customProgress!);
     }
     
     if (widget.story.acceptanceCriteria.isNotEmpty) {
       return l10n.agileProgressTooltipCriteria(
         widget.story.completedAcceptanceCriteria,
         widget.story.acceptanceCriteria.length
       );
     }
     
     // Status based
     return l10n.agileProgressTooltipStatus(widget.story.status.getDisplayName(widget.framework));
  }
}

/// Badge standalone per la priorità MoSCoW
class PriorityBadgeWidget extends StatelessWidget {
  final StoryPriority priority;
  final bool large;

  const PriorityBadgeWidget({
    super.key,
    required this.priority,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 12 : 8,
        vertical: large ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: priority.color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(large ? 6 : 4),
        border: Border.all(color: priority.color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            priority.icon,
            size: large ? 16 : 12,
            color: priority.color,
          ),
          const SizedBox(width: 4),
          Text(
            priority.displayName,
            style: TextStyle(
              fontSize: large ? 13 : 11,
              color: priority.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
