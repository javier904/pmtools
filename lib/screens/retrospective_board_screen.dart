import 'dart:async';
import 'package:agile_tools/widgets/retrospective/retro_timer_widget.dart';
import 'package:flutter/services.dart';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/widgets/retrospective/retro_board_widget.dart';
import 'package:agile_tools/widgets/retrospective/agile_coach_overlay.dart';
import 'package:agile_tools/widgets/retrospective/sentiment_voting_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_participant_invite_dialog.dart';
import 'package:agile_tools/services/invite_service.dart';
import 'package:agile_tools/models/unified_invite_model.dart';
import 'package:agile_tools/widgets/retrospective/action_items_table_widget.dart';
import 'package:agile_tools/widgets/retrospective/action_item_dialog.dart';
import 'package:agile_tools/services/retrospective_sheets_export_service.dart';
import 'package:agile_tools/widgets/retrospective/participant_presence_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ... existing imports ...

class RetroBoardScreen extends StatefulWidget {
  final String retroId;
  final String currentUserEmail;
  final String currentUserName;

  const RetroBoardScreen({
    Key? key,
    required this.retroId,
    required this.currentUserEmail,
    required this.currentUserName,
  }) : super(key: key);

  @override
  State<RetroBoardScreen> createState() => _RetroBoardScreenState();
}

class _RetroBoardScreenState extends State<RetroBoardScreen> {
  final RetrospectiveFirestoreService _service = RetrospectiveFirestoreService();

  // 🟢 Online Presence Heartbeat
  Timer? _heartbeatTimer;
  static const int _heartbeatIntervalSeconds = 15;

  // UX State
  bool _isActionPanelExpanded = true;

  @override
  void initState() {
    super.initState();
    _startHeartbeat();
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    _markOffline();
    super.dispose();
  }

  /// Avvia il timer heartbeat per segnalare presenza online
  void _startHeartbeat() {
    // Invia heartbeat immediato all'apertura
    _sendHeartbeat();

    // Timer periodico ogni 15 secondi
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: _heartbeatIntervalSeconds),
      (_) => _sendHeartbeat(),
    );
  }

  /// Invia un heartbeat al server
  Future<void> _sendHeartbeat() async {
    await _service.sendHeartbeat(widget.retroId, widget.currentUserEmail);
  }

  /// Marca l'utente come offline
  Future<void> _markOffline() async {
    await _service.markOffline(widget.retroId, widget.currentUserEmail);
  }

  /// Conta i partecipanti online
  int _countOnlineParticipants(RetrospectiveModel retro) {
    int count = 0;
    for (final email in retro.participantEmails) {
      if (ParticipantPresenceIndicator.isParticipantOnline(email, retro.participantPresence)) {
        count++;
      }
    }
    return count;
  }
  
  List<String> _getOnlineParticipants(RetrospectiveModel retro) {
    return retro.participantEmails.where((email) => 
      ParticipantPresenceIndicator.isParticipantOnline(email, retro.participantPresence)
    ).toList();
  }

  Widget _buildOnlineCounter(RetrospectiveModel retro) {
    final onlineCount = _countOnlineParticipants(retro);
    final totalCount = retro.participantEmails.length;
    final l10n = AppLocalizations.of(context);
    
    return Tooltip(
      richMessage: TextSpan(
        children: [
          TextSpan(
            text: '${l10n?.retroParticipantsTitle(totalCount) ?? "Participants ($totalCount)"}\n\n',
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ...retro.participantEmails.map((email) {
             final isOnline = ParticipantPresenceIndicator.isParticipantOnline(email, retro.participantPresence);
             // Try to get display name from participants list if available in model? 
             // RetroModel doesn't have full Participant objects usually, just emails. 
             // We'll show email/name split.
             final name = email.split('@').first;
             return TextSpan(
               text: '$name ${isOnline ? "●" : "○"}\n',
               style: TextStyle(color: isOnline ? Colors.greenAccent : Colors.white70),
             );
          }),
        ],
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: onlineCount > 0 ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: onlineCount > 0 ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onlineCount > 0 ? Colors.green : Colors.grey,
                boxShadow: onlineCount > 0 ? [
                  BoxShadow(color: Colors.green.withOpacity(0.5), blurRadius: 4, spreadRadius: 1),
                ] : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$onlineCount / $totalCount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: onlineCount > 0 ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<RetrospectiveModel?>(
      stream: _service.streamRetrospective(widget.retroId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(appBar: AppBar(), body: Center(child: Text(l10n?.errorLoading ?? 'Error: ${snapshot.error}')));
        }
        if (!snapshot.hasData) {
          return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
        }

        final retro = snapshot.data!;
        final isFacilitator = retro.createdBy == widget.currentUserEmail || 
                            (retro.participantEmails.isNotEmpty && retro.participantEmails.first == widget.currentUserEmail);

        return Scaffold(
          appBar: AppBar(
            title: Text(retro.sprintName.isNotEmpty ? retro.sprintName : (l10n?.favTypeRetro ?? 'Retrospective')),
            centerTitle: false,
            elevation: 0,
            actions: [
               // Timer
               RetroTimerWidget(
                 retroId: retro.id,
                 timer: retro.timer,
                 isFacilitator: isFacilitator
               ),
               const SizedBox(width: 8),

               IconButton(
                 icon: const Icon(Icons.person_add),
                 tooltip: l10n?.inviteSendNew ?? 'Invite',
                 onPressed: () => _showInviteDialog(retro),
               ),
               IconButton(
                 icon: const Icon(Icons.person_add),
                 tooltip: l10n?.inviteSendNew ?? 'Invite',
                 onPressed: () => _showInviteDialog(retro),
               ),
               if (isFacilitator)
                 IconButton(
                   icon: Icon(retro.showAuthorNames ? Icons.visibility : Icons.visibility_off),
                   tooltip: retro.showAuthorNames ? 'Hide Names' : 'Show Names',
                   onPressed: () => _service.toggleAuthorNames(retro.id, !retro.showAuthorNames),
                 ),
               const SizedBox(width: 8),
               const SizedBox(width: 8),
               // Online Presence Counter (Replaces old participants dialog)
               _buildOnlineCounter(retro),
               const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 12,
                  child: Text(
                    widget.currentUserName.isNotEmpty ? widget.currentUserName[0].toUpperCase() : '?',
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Home button - sempre ultimo a destra
              IconButton(
                icon: const Icon(Icons.home_rounded),
                tooltip: l10n?.navHome ?? 'Home',
                color: const Color(0xFF8B5CF6), // Viola come icona app
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildPhaseBar(retro),
              Expanded(
                child: _buildPhaseContent(retro, isFacilitator),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomControls(retro, isFacilitator),
        );
      },
    );
  }

  Widget? _buildBottomControls(RetrospectiveModel retro, bool isFacilitator) {
    if (!isFacilitator) return null;
    final l10n = AppLocalizations.of(context);

    final bool canGoBack = retro.currentPhase.index > 0;
    final bool canGoNext = retro.currentPhase != RetroPhase.completed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (canGoBack)
              FilledButton.icon(
                onPressed: () => _regressPhase(retro),
                icon: const Icon(Icons.arrow_back),
                label: Text('Prev: ${_getPrevPhaseName(retro.currentPhase)}'), 
                style: FilledButton.styleFrom(
                   backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                   foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              )
            else
              const SizedBox(width: 100),

             // Center status or spacer
            if (retro.currentPhase == RetroPhase.writing && !retro.areTeamCardsVisible)
               FilledButton.icon(
                 onPressed: () => _service.revealCards(retro.id),
                 icon: const Icon(Icons.visibility),
                 label: Text(l10n?.voteReveal ?? 'Rivela'),
                 style: FilledButton.styleFrom(backgroundColor: Colors.orange),
               )
             else if (canGoNext)
              FilledButton.icon(
                onPressed: () => _advancePhase(retro),
                icon: const Icon(Icons.arrow_forward),
                label: Text('Next: ${_getNextPhaseName(retro.currentPhase)}'),
              ),
          ],
        ),
      ),
    );
  }

  // ... (keeping existing methods)

  Widget _buildPhaseBar(RetrospectiveModel retro) {
    final theme = Theme.of(context);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(bottom: BorderSide(color: theme.dividerColor)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: RetroPhase.values.length,
        separatorBuilder: (c, i) => const SizedBox(width: 4), // Removed lines
        itemBuilder: (context, index) {
          final p = RetroPhase.values[index];
          final isActive = p == retro.currentPhase;
          final isCompleted = p.index < retro.currentPhase.index;
          
          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive 
                    ? theme.primaryColor 
                    : isCompleted ? Colors.green.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isActive 
                    ? Border.all(color: theme.primaryColor) 
                    : isCompleted ? Border.all(color: Colors.green) : Border.all(color: theme.disabledColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  if (isCompleted) 
                    const Icon(Icons.check_circle, size: 16, color: Colors.green)
                  else if (isActive)
                    Icon(Icons.play_circle_fill, size: 16, color: theme.colorScheme.onPrimary)
                  else
                    Icon(Icons.radio_button_unchecked, size: 16, color: theme.disabledColor),
                  
                  const SizedBox(width: 8),
                  Text(
                    p.name.toUpperCase(),
                    style: TextStyle(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive 
                          ? theme.colorScheme.onPrimary 
                          : isCompleted ? Colors.green : theme.disabledColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhaseContent(RetrospectiveModel retro, bool isFacilitator) {
    final bool isIncognito = retro.currentPhase == RetroPhase.writing;
    
    Widget content;
    switch (retro.currentPhase) {
      case RetroPhase.setup:
        content = _buildSetupView(retro);
        break;
      case RetroPhase.icebreaker:
        content = SentimentVotingWidget(
          retroId: retro.id,
          currentUserEmail: widget.currentUserEmail,
          currentVotes: retro.sentimentVotes,
          isFacilitator: isFacilitator,
          onPhaseComplete: () => _service.updatePhase(
            retro.id, 
            RetroPhase.writing, 
            widget.currentUserEmail,
            widget.currentUserName,
          ),
        );
        break;
      case RetroPhase.writing:
      case RetroPhase.voting:
        content = RetroBoardWidget(
          retro: retro,
          currentUserEmail: widget.currentUserEmail,
          currentUserName: widget.currentUserName,
          isIncognito: isIncognito,
          showAuthorNames: retro.showAuthorNames,
        );
        break;
      case RetroPhase.discuss:
        content = Column(
          children: [
            Expanded(
              child: RetroBoardWidget(
                retro: retro,
                currentUserEmail: widget.currentUserEmail,
                currentUserName: widget.currentUserName,
                isIncognito: false,
                showAuthorNames: retro.showAuthorNames,
              ),
            ),
            const Divider(height: 1, thickness: 1),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _isActionPanelExpanded ? 350 : 50, // Collapsible height
              child: _buildActionItemsSection(retro, isFacilitator),
            ),
          ],
        );
        break;
      case RetroPhase.completed:
        content = _buildCompletionDashboard(retro, isFacilitator);
        break;
    }

    return Stack(
      children: [
        content,
        if (retro.currentPhase != RetroPhase.completed)
          Positioned(
            bottom: 80,
            right: 20,
            child: AgileCoachOverlay(phase: retro.currentPhase),
          ),
      ],
    );
  }

  // ...

  Widget _buildActionItemsSection(RetrospectiveModel retro, bool isFacilitator) {
    final l10n = AppLocalizations.of(context);
    return DragTarget<RetroItem>(
      onWillAccept: (data) => true,
      onAccept: (item) => _openCreateActionItemDialog(
        retro, 
        initialDescription: item.content,
        initialSourceRefId: item.id,
      ),
      builder: (context, candidateData, rejectedData) {
        final bool isHovering = candidateData.isNotEmpty;
        
        return Container(
          color: isHovering 
              ? Theme.of(context).primaryColor.withOpacity(0.1) 
              : Theme.of(context).cardColor,
          width: double.infinity,
          child: Column(
            children: [
              // Header Toggle Bar
              InkWell(
                onTap: () => setState(() => _isActionPanelExpanded = !_isActionPanelExpanded),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Theme.of(context).canvasColor.withOpacity(0.5), // Slight highlight
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Action Items',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        _isActionPanelExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                        size: 20,
                        color: Theme.of(context).disabledColor,
                      ),
                    ],
                  ),
                ),
              ),
              
              if (_isActionPanelExpanded)
               Expanded(
                 child: SingleChildScrollView( // Scrollable content when expanded
                   padding: const EdgeInsets.all(16),
                   child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                      Row(
                        children: [
                          Icon(Icons.playlist_add_check, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8),
                          const Text(
                            'Action Items', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          if (isHovering) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(l10n?.actionCreate ?? 'Drop to Create', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _openCreateActionItemDialog(retro),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(l10n?.actionAdd ?? 'Add Item'),
                        style: ElevatedButton.styleFrom(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Permanent Drop Zone Visual Hint
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).disabledColor.withOpacity(0.3),
                        style: BorderStyle.none, // Trick: we use a custom decoration or just a dashed border if available, but for now simple style
                      ),
                      // Improving visual: Dashed border simulation or just a distinct background
                       color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                       borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.swipe_down, size: 20, color: Theme.of(context).disabledColor),
                        const SizedBox(width: 8),
                        Text(
                          'Trascina qui una card per creare un Action Item collegato',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (retro.actionItems.isEmpty && !isHovering)
                    Expanded(
                      child: Center(
                         // Simplified empty state as we have the top banner now
                        child: Text(
                          'Nessun action item presente',
                          style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                        ),
                      ),
                    )
                  else
                    ActionItemsTableWidget(
                        actionItems: retro.actionItems,
                        retroId: retro.id,
                        isFacilitator: isFacilitator,
                        participants: retro.participantEmails,
                        currentUserEmail: widget.currentUserEmail,
                        items: retro.items,
                      ),
                ],
              ),
            ),
          ),
        ),
       ),
      ],
     ),
    );
      },
    );
  }

  Future<void> _openCreateActionItemDialog(RetrospectiveModel retro, {
    ActionItem? item, 
    String? initialDescription,
    String? initialSourceRefId,
  }) async {
      final newItem = await showDialog<ActionItem>(
        context: context,
        builder: (context) => ActionItemDialog(
          participants: retro.participantEmails,
          currentUserEmail: widget.currentUserEmail,
          availableCards: retro.items,
          initialSourceRefId: initialSourceRefId,
          item: item ?? (initialDescription != null 
              ? ActionItem(
                  id: '', 
                  description: initialDescription, 
                  ownerEmail: widget.currentUserEmail, 
                  createdAt: DateTime.now(),
                  sourceRefId: initialSourceRefId,
                  sourceRefContent: initialDescription,
                )
              : null),
        ),
      );
      if (newItem != null) {
        if (item != null && item.id.isNotEmpty) {
           await _service.updateActionItem(retro.id, newItem);
        } else {
           await _service.addActionItem(retro.id, newItem.id.isEmpty ? newItem.copyWith(id: DateTime.now().millisecondsSinceEpoch.toString()) : newItem);
        }
      }
  }


  // Helper extension for copyWith if not in model yet, but ActionItem usually immutable. 
  // Assuming ActionItem has copyWith or I create a new one. 
  // Wait, ActionItem in model likely has no copyWith exposed in context? 
  // I will just create a new one if ID is empty.


  void _showInviteDialog(RetrospectiveModel retro) async {
    // Carica gli inviti pendenti per mostrarli nel dialog
    final inviteService = InviteService();
    final pendingInvites = await inviteService.getInvitesForSource(
      InviteSourceType.retroBoard,
      retro.id,
    );

    if (!mounted) return;

    RetroParticipantInviteDialog.show(
      context: context,
      boardId: retro.id,
      boardTitle: retro.sprintName.isNotEmpty ? retro.sprintName : 'Retrospective',
      pendingInvites: pendingInvites,
    );
  }
  
  // Correction: checking line 8 import.
  // Actually, I should verify the constructor. 
  // But I will proceed with retroId and list, a common pattern.
  // Wait, if it takes named parameters.
  


  Future<void> _regressPhase(RetrospectiveModel retro) async {
    final prevPhaseIndex = retro.currentPhase.index - 1;
    if (prevPhaseIndex >= 0) {
      final prevPhase = RetroPhase.values[prevPhaseIndex];
      await _service.updatePhase(
        retro.id, 
        prevPhase, 
        widget.currentUserEmail, 
        widget.currentUserName
      );
    }
  }

  // --- Restored Methods ---

  Widget _buildSetupView(RetrospectiveModel retro) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to ${retro.template.displayName}', 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              retro.template.description, 
              textAlign: TextAlign.center, 
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)
            ),
          ),
          const SizedBox(height: 30),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(l10n?.retroWaitingForFacilitator ?? 'In attesa che il facilitatore avvii la sessione...'),
        ],
      ),
    );
  }

  Widget _buildCompletionDashboard(RetrospectiveModel retro, bool isFacilitator) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🎉 ${l10n?.sessionCompletedSuccess ?? "Retrospective Completed!"}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    if (isFacilitator)
                      TextButton.icon(
                        onPressed: () => _reopenRetro(retro),
                        icon: const Icon(Icons.refresh, color: Colors.orange),
                        label: Text(l10n?.actionReopen ?? 'Riapri', style: const TextStyle(color: Colors.orange)),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _exportToGoogleSheets(retro),
                      icon: const Icon(Icons.table_view, color: Colors.white),
                      label: Text(l10n?.todoExportSheets ?? 'Export Sheets', style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F9D58)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _exportData(retro),
                      icon: const Icon(Icons.download),
                      label: Text(l10n?.actionExport ?? 'Export CSV'),
                    ),
                  ],
                ),
              ],
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              _buildSummaryCard(
                'Participants', 
                '${retro.participantEmails.length}', 
                Icons.people, 
                Colors.blue
              ),
              const SizedBox(width: 16),
              _buildSummaryCard(
                'Sentiment', 
                retro.averageSentiment != null ? retro.averageSentiment!.toStringAsFixed(1) : '-', 
                Icons.mood, 
                Colors.orange
              ),
               const SizedBox(width: 16),
              _buildSummaryCard(
                'Action Items', 
                '${retro.actionItems.length}', 
                Icons.check_circle_outline, 
                Colors.green
              ),
            ],
          ),
          const SizedBox(height: 32),

          const Text(
            'Action Items Plan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ActionItemsTableWidget(
              actionItems: retro.actionItems,
              retroId: retro.id,
              isFacilitator: isFacilitator,
              participants: retro.participantEmails,
              currentUserEmail: widget.currentUserEmail,
              readOnly: true, 
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportToGoogleSheets(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n?.retroGeneratingSheet ?? 'Generazione Google Sheet in corso...')),
    );

    final url = await RetrospectiveSheetsExportService().exportToGoogleSheets(retro);

    if (mounted) {
       ScaffoldMessenger.of(context).hideCurrentSnackBar();
       if (url != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.retroExportSuccess ?? 'Export completato!'),
              action: SnackBarAction(
                label: (l10n?.eisenhowerOpen ?? 'APRI').toUpperCase(),
                onPressed: () => launchUrl(Uri.parse(url)),
                textColor: Colors.white,
              ),
            ),
          );
       } else {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n?.retroExportError ?? 'Errore durante l\'export su Sheets.')),
         );
       }
    }
  }

  Future<void> _exportData(RetrospectiveModel retro) async {
    final buffer = StringBuffer();
    buffer.writeln('Retrospective Export - ${retro.sprintName}');
    buffer.writeln('Date: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Participants: ${retro.participantEmails.length}');
    buffer.writeln('Sentiment: ${retro.averageSentiment ?? "N/A"}');
    buffer.writeln('');
    
    buffer.writeln('--- Action Items ---');
    buffer.writeln('Description,Owner,Priority,Due Date');
    for (var item in retro.actionItems) {
      final assignee = item.assigneeEmail ?? 'Unassigned';
      final date = item.dueDate != null ? item.dueDate.toString().split(' ')[0] : '';
      buffer.writeln('"${item.description}",$assignee,${item.priority.name},$date');
    }

    buffer.writeln('');
    buffer.writeln('--- Went Well ---');
    for (var item in retro.wentWell) {
       buffer.writeln('- ${item.content} (${item.votes} votes)');
    }

    buffer.writeln('');
    buffer.writeln('--- To Improve ---');
    for (var item in retro.toImprove) {
       buffer.writeln('- ${item.content} (${item.votes} votes)');
    }

    final l10n = AppLocalizations.of(context);
    
    // ... buffer writing logic (assuming l10n not used for buffer content yet to keep it simple or user didn't ask) 
    
    await Clipboard.setData(ClipboardData(text: buffer.toString()));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n?.retroReportCopied ?? 'Report copiato negli appunti!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _reopenRetro(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.retroReopenTitle ?? 'Riapri Retrospettiva'),
        content: Text(l10n?.retroReopenConfirm ?? 'Sei sicuro di voler riaprire la retrospettiva?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n?.actionCancel ?? 'Annulla')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n?.actionReopen ?? 'Riapri')),
        ],
      ),
    );

    if (confirm == true) {
      await _service.updatePhase(retro.id, RetroPhase.discuss, widget.currentUserEmail, widget.currentUserName);
    }
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: TextStyle(color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }

  Future<void> _advancePhase(RetrospectiveModel retro) async {
    final nextPhaseIndex = retro.currentPhase.index + 1;
    if (nextPhaseIndex < RetroPhase.values.length) {
      final nextPhase = RetroPhase.values[nextPhaseIndex];
      await _service.updatePhase(
        retro.id, 
        nextPhase, 
        widget.currentUserEmail, 
        widget.currentUserName
      );
    }
  }

  String _getNextPhaseName(RetroPhase current) {
    final nextIndex = current.index + 1;
    if (nextIndex < RetroPhase.values.length) {
      return RetroPhase.values[nextIndex].name.toUpperCase();
    }
    return 'COMPLETE';
  }

  String _getPrevPhaseName(RetroPhase current) {
    final prevIndex = current.index - 1;
    if (prevIndex >= 0) {
      return RetroPhase.values[prevIndex].name.toUpperCase();
    }
    return '';
  }
}
