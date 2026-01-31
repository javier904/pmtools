import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/sprint_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_active_section_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_history_section_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_summary_dialog.dart';
import 'package:agile_tools/widgets/retrospective/action_items_tracker_widget.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/widgets/retrospective/lessons_learned_section_widget.dart';
import 'package:agile_tools/widgets/retrospective/lesson_learned_dialog.dart';
import 'package:agile_tools/models/lesson_learned_model.dart';

/// Main container widget with 4 sub-tabs for the Retrospective section.
class RetroTabSectionsWidget extends StatefulWidget {
  final String projectId;
  final List<RetrospectiveModel> retrospectives;
  final String currentUserEmail;
  final VoidCallback onCreateNew;
  final Function(RetrospectiveModel) onTapRetro;
  final Function(RetrospectiveModel)? onDeleteRetro;
  final List<SprintModel> sprints;

  const RetroTabSectionsWidget({
    super.key,
    required this.projectId,
    required this.retrospectives,
    required this.currentUserEmail,
    required this.onCreateNew,
    required this.onTapRetro,
    this.onDeleteRetro,
    required this.sprints,
  });

  @override
  State<RetroTabSectionsWidget> createState() => _RetroTabSectionsWidgetState();
}

class _RetroTabSectionsWidgetState extends State<RetroTabSectionsWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _retroService = RetrospectiveFirestoreService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              bottom: BorderSide(color: theme.dividerColor, width: 1),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            indicatorColor: theme.colorScheme.primary,
            indicatorWeight: 3,
            tabs: [
              Tab(icon: const Icon(Icons.play_circle_outline), text: l10n.retroSectionActive),
              Tab(icon: const Icon(Icons.history), text: l10n.retroSectionHistory),
              Tab(icon: const Icon(Icons.assignment_outlined), text: l10n.retroSectionActionTracker),
              Tab(icon: const Icon(Icons.school_outlined), text: l10n.retroSectionLessonsLearned),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Active Tab
              RetroActiveSectionWidget(
                retrospectives: widget.retrospectives,
                currentUserEmail: widget.currentUserEmail,
                onCreateNew: widget.onCreateNew,
                onTapRetro: widget.onTapRetro,
              ),
              // History Tab
              RetroHistorySectionWidget(
                retrospectives: widget.retrospectives,
                currentUserEmail: widget.currentUserEmail,
                onTapRetro: (retro) => _showRetroSummary(retro),
                onDeleteRetro: widget.onDeleteRetro,
              ),
              // Action Items Tab
              ActionItemsTrackerWidget(
                retrospectives: widget.retrospectives,
                currentUserEmail: widget.currentUserEmail,
                onStatusChanged: _onActionItemStatusChanged,
              ),
              // Lessons Learned Tab
              LessonsLearnedSectionWidget(
                projectId: widget.projectId,
                currentUserEmail: widget.currentUserEmail,
                onTapLesson: (lesson) => _showLessonDialog(lesson: lesson),
                onAddLesson: () => _showLessonDialog(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _onActionItemStatusChanged(
    String retroId, String actionItemId, ActionItemStatus newStatus,
  ) async {
    await _retroService.updateActionItemStatus(retroId, actionItemId, newStatus);
  }

  void _showLessonDialog({LessonLearnedModel? lesson}) {
    showDialog(
      context: context,
      builder: (context) => LessonLearnedDialog(
        projectId: widget.projectId,
        currentUserEmail: widget.currentUserEmail,
        existingLesson: lesson,
      ),
    );
  }

  void _showRetroSummary(RetrospectiveModel retro) {
    showDialog(
      context: context,
      builder: (context) => RetroSummaryDialog(retro: retro),
    );
  }
}
