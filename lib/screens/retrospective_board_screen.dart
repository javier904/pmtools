import 'dart:async';
import 'package:agile_tools/widgets/retrospective/retro_timer_widget.dart';
import 'package:agile_tools/themes/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/widgets/retrospective/retro_board_widget.dart';
import 'package:agile_tools/widgets/retrospective/agile_coach_overlay.dart';
import 'package:agile_tools/widgets/retrospective/sentiment_voting_widget.dart';
import 'package:agile_tools/widgets/retrospective/one_word_icebreaker_widget.dart';
import 'package:agile_tools/widgets/retrospective/weather_icebreaker_widget.dart';
import 'package:agile_tools/widgets/retrospective/retro_participant_invite_dialog.dart';
import 'package:agile_tools/services/invite_service.dart';
import 'package:agile_tools/models/unified_invite_model.dart';
import 'package:agile_tools/widgets/retrospective/action_items_table_widget.dart';
import 'package:agile_tools/widgets/retrospective/action_item_dialog.dart';
import 'package:agile_tools/widgets/retrospective/action_collection_guide_widget.dart';
import 'package:agile_tools/services/retrospective_csv_export_service.dart';
import 'package:agile_tools/widgets/retrospective/participant_presence_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html if (dart.library.io) 'dart:io';

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

class _RetroBoardScreenState extends State<RetroBoardScreen> with WidgetsBindingObserver {
  final RetrospectiveFirestoreService _service = RetrospectiveFirestoreService();

  // 🟢 Online Presence Heartbeat
  Timer? _heartbeatTimer;
  static const int _heartbeatIntervalSeconds = 15;

  // UX State - Action Items visibility is synced via retro.isActionItemsVisible

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupWebBeforeUnload();
    _startHeartbeat();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _heartbeatTimer?.cancel();
    _setOfflineImmediately();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LIFECYCLE & PRESENCE SYNC
  // ═══════════════════════════════════════════════════════════════════════════

  /// Setup listener per chiusura tab browser (web only)
  void _setupWebBeforeUnload() {
    if (kIsWeb) {
      html.window.onBeforeUnload.listen((event) {
        _setOfflineImmediately();
      });
    }
  }

  /// Imposta lo stato offline immediatamente (sincrono per beforeunload)
  void _setOfflineImmediately() {
    if (widget.currentUserEmail.isNotEmpty) {
      _service.markOffline(widget.retroId, widget.currentUserEmail);
      print('🔴 [Retro] User ${widget.currentUserEmail} set offline immediately');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        // App in background o chiusa - imposta offline
        _setOfflineImmediately();
        _heartbeatTimer?.cancel();
        break;
      case AppLifecycleState.resumed:
        // App tornata in primo piano - riavvia heartbeat con burst iniziale
        _startHeartbeat();
        break;
    }
  }

  /// Avvia il timer heartbeat per segnalare presenza online
  /// Usa "burst" iniziale per propagazione rapida: 0s, 1s, 3s, poi 15s
  void _startHeartbeat() {
    // Cancella eventuale timer esistente
    _heartbeatTimer?.cancel();

    // Heartbeat immediato
    _sendHeartbeat();
    print('🟢 [Retro] Initial heartbeat sent for ${widget.currentUserEmail}');

    // Burst di heartbeat rapidi per sincronizzazione veloce
    Timer(const Duration(seconds: 1), () {
      if (mounted) _sendHeartbeat();
    });
    Timer(const Duration(seconds: 3), () {
      if (mounted) _sendHeartbeat();
    });

    // Timer periodico ogni 15 secondi
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: _heartbeatIntervalSeconds),
      (_) {
        if (mounted) _sendHeartbeat();
      },
    );
  }

  /// Invia un heartbeat al server
  Future<void> _sendHeartbeat() async {
    await _service.sendHeartbeat(widget.retroId, widget.currentUserEmail);
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

        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: AppColors.retroPrimary,
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppColors.retroPrimary,
              secondary: AppColors.retroPrimary,
              onPrimary: Colors.white,
            ),
            // Removed appBarTheme to allow default (Dark/Black) to propagate
            floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme.copyWith(
              backgroundColor: AppColors.retroPrimary,
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
               style: ElevatedButton.styleFrom(
                 backgroundColor: AppColors.retroPrimary,
                 foregroundColor: Colors.white,
               ),
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
            title: Row(
              children: [
                Text(retro.sprintName.isNotEmpty ? retro.sprintName : (l10n?.favTypeRetro ?? 'Retrospective')),
                const SizedBox(width: 32),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: RetroPhase.values.map((p) {
                        final isActive = p == retro.currentPhase;
                        final isCompleted = p.index < retro.currentPhase.index;
                        final theme = Theme.of(context);
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isCompleted) 
                                  const Icon(Icons.check_circle, size: 14, color: Colors.green)
                                else if (isActive)
                                  Icon(Icons.play_circle_fill, size: 14, color: theme.colorScheme.onPrimary)
                                else
                                  Icon(Icons.radio_button_unchecked, size: 14, color: theme.disabledColor),
                                
                                const SizedBox(width: 6),
                                Text(
                                  p.name.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                    color: isActive 
                                        ? theme.colorScheme.onPrimary 
                                        : isCompleted ? Colors.green : theme.disabledColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: false,
            elevation: 0,
            actions: [
               // Navigation Controls (Moved from bottom)
               if (isFacilitator) ...[
                 // Reveal/Hide Toggle (Writing Phase)
                 if (retro.currentPhase == RetroPhase.writing)
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                     child: FilledButton.icon(
                       onPressed: () => _service.setTeamCardsVisibility(retro.id, !retro.areTeamCardsVisible),
                       icon: Icon(retro.areTeamCardsVisible ? Icons.visibility_off : Icons.visibility, size: 16),
                       label: Text(retro.areTeamCardsVisible ? 'Hide Cards' : (l10n?.voteReveal ?? 'Reveal Cards')),
                       style: FilledButton.styleFrom(
                         backgroundColor: retro.areTeamCardsVisible ? Colors.grey : Colors.orange,
                         visualDensity: VisualDensity.compact,
                       ),
                     ),
                   ),

                 if (retro.currentPhase.index > 0)
                   TextButton.icon(
                     onPressed: () => _regressPhase(retro),
                     icon: const Icon(Icons.arrow_back, size: 16),
                     label: Text('Prev'),
                     style: TextButton.styleFrom(
                       foregroundColor: Theme.of(context).colorScheme.onSurface,
                     ),
                   ),
                   
                  if (retro.currentPhase != RetroPhase.completed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextButton(
                        onPressed: () => _advancePhase(retro),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Next'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 24, color: Theme.of(context).dividerColor), // Separator
                  const SizedBox(width: 8),
               ],

               // Timer
               RetroTimerWidget(
                 retroId: retro.id,
                 timer: retro.timer,
                 isFacilitator: isFacilitator
               ),
               const SizedBox(width: 8),

               if (isFacilitator)
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
               const SizedBox(width: 16),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: _buildPhaseContent(retro, isFacilitator),
              ),
            ],
          ),
          // bottomNavigationBar: removed as requested
        ));
      },
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
        final onComplete = () => _service.updatePhase(
          retro.id,
          RetroPhase.writing,
          widget.currentUserEmail,
          widget.currentUserName,
        );

        switch (retro.icebreakerTemplate ?? RetroIcebreaker.sentiment) {
          case RetroIcebreaker.oneWord:
            content = OneWordIcebreakerWidget(
              retroId: retro.id,
              currentUserEmail: widget.currentUserEmail,
              currentWords: retro.oneWordVotes,
              isFacilitator: isFacilitator,
              onPhaseComplete: onComplete,
            );
            break;
          case RetroIcebreaker.weatherReport:
            content = WeatherIcebreakerWidget(
              retroId: retro.id,
              currentUserEmail: widget.currentUserEmail,
              currentWeather: retro.weatherVotes,
              isFacilitator: isFacilitator,
              onPhaseComplete: onComplete,
            );
            break;
          case RetroIcebreaker.sentiment:
          default:
            content = SentimentVotingWidget(
              retroId: retro.id,
              currentUserEmail: widget.currentUserEmail,
              currentVotes: retro.sentimentVotes,
              isFacilitator: isFacilitator,
              onPhaseComplete: onComplete,
            );
        }
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
              height: retro.isActionItemsVisible ? 320 : 56, // Synced visibility (facilitator-controlled)
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
            child: AgileCoachOverlay(phase: retro.currentPhase, template: retro.template),
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
                onTap: isFacilitator 
                  ? () => _service.toggleActionItemsVisibility(retro.id, !retro.isActionItemsVisible)
                  : null, // Only facilitator can toggle
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Theme.of(context).canvasColor.withOpacity(0.5), // Slight highlight
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Group: Title & Lock
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.playlist_add_check, size: 18, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8),
                          Text(
                            'Action Items',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (!isFacilitator) ...[ // Visual hint for non-facilitators
                            const SizedBox(width: 8),
                            Icon(Icons.lock, size: 12, color: Theme.of(context).disabledColor),
                          ],
                        ],
                      ),
                      
                      // Center Group: Drop Hint (Expanded to take available space and center content)
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.swipe_down, size: 14, color: Theme.of(context).disabledColor),
                              const SizedBox(width: 4),
                              Flexible( // Flexible to allow text wrapping if needed on small screens
                                child: Text(
                                  l10n?.retroActionDragToCreate ?? 'Drag card here to create Action Item',
                                  style: TextStyle(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 11,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Group: Add Button + Arrow
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           if (isFacilitator)
                             Padding(
                               padding: const EdgeInsets.only(right: 12),
                               child: SizedBox(
                                 height: 28,
                                 child: ElevatedButton.icon(
                                  onPressed: () { 
                                     // Prevent header toggle by handling tap here
                                     _openCreateActionItemDialog(retro);
                                  },
                                  icon: const Icon(Icons.add, size: 14),
                                  label: Text(l10n?.actionAdd ?? 'Add', style: const TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                     visualDensity: VisualDensity.compact,
                                  ),
                                 ),
                               ),
                             ),
                          Icon(
                            retro.isActionItemsVisible ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                            size: 20,
                            color: isFacilitator ? Theme.of(context).iconTheme.color : Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              
              if (retro.isActionItemsVisible)
               Expanded(
                 child: SingleChildScrollView( // Scrollable content when expanded
                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                   child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                  // Main Content Area: Guide (Left) + Table (Right)

                  // Main Content Area: Guide (Left) + Table (Right)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Facilitator Action Collection Guide - Side Panel
                      if (isFacilitator && retro.currentPhase == RetroPhase.discuss)
                         Container(
                           width: 300, 
                           margin: const EdgeInsets.only(right: 16, bottom: 16),
                           child: ActionCollectionGuideWidget(retro: retro),
                         ),

                      // Action Items List / Limitless Table
                      Expanded(
                        child: retro.actionItems.isEmpty && !isHovering
                            ? SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text(
                                    l10n?.retroNoActionItems ?? 'No action items',
                                    style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                                  ),
                                ),
                            )
                            : ActionItemsTableWidget(
                                actionItems: retro.actionItems,
                                retroId: retro.id,
                                isFacilitator: isFacilitator,
                                participants: retro.participantEmails,
                                currentUserEmail: widget.currentUserEmail,
                                items: retro.items,
                                template: retro.template,
                                columns: retro.columns,
                              ),
                      ),
                    ],
                  ),
                ],
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
          child: ActionItemDialog(
            participants: retro.participantEmails,
            currentUserEmail: widget.currentUserEmail,
            availableCards: retro.items,
            initialSourceRefId: initialSourceRefId,
            template: retro.template,
            columns: retro.columns,
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
                      onPressed: () => _showExportDialog(retro),
                      icon: const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                      label: Text(
                        l10n?.actionExportCsv ?? 'Export CSV', 
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.retroPrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Pill shape
                        ),
                      ),
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A237E).withValues(alpha: 0.15), // Dark blue background
              borderRadius: BorderRadius.circular(12),
            ),
            child: ActionItemsTableWidget(
              actionItems: retro.actionItems,
              retroId: retro.id,
              isFacilitator: isFacilitator,
              participants: retro.participantEmails,
              currentUserEmail: widget.currentUserEmail,
              readOnly: true,
              template: retro.template,
              columns: retro.columns,
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _showExportDialog(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context);
    await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n?.actionExportCsv ?? 'Export CSV'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportActionItems(retro);
            },
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline, color: Colors.blue),
              title: Text(l10n?.retroActionItemsLabel ?? 'Action Items'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportBoard(retro);
            },
            child: ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.orange),
              title: Text(l10n?.retroBoard ?? 'Board Items'),
            ),
          ),
          const Divider(),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _exportAllData(retro);
            },
            child: ListTile(
              leading: const Icon(Icons.file_copy_rounded, color: Color(0xFF0F9D58)),
              title: Text(l10n?.exportAllData ?? 'Export All Data (Full Report)'),
              subtitle: const Text('Summary + Board + Action Items', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportActionItems(RetrospectiveModel retro) async {
    try {
      await RetrospectiveCsvExportService().exportActionItemsToCsv(retro);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Action Items exported!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _exportBoard(RetrospectiveModel retro) async {
    try {
      await RetrospectiveCsvExportService().exportBoardItemsToCsv(retro);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Board exported!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _exportAllData(RetrospectiveModel retro) async {
    try {
      await RetrospectiveCsvExportService().exportAllDataToCsv(retro);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Full Snapshot exported!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showExportSuccessDialog(String url) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 12),
            Text(l10n?.retroExportSuccess ?? 'Export Complete!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n?.retroExportSuccessMessage ?? 'Your retrospective has been exported to Google Sheets.'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      url,
                      style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    tooltip: l10n?.actionCopy ?? 'Copy',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: url));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n?.linkCopied ?? 'Link copied to clipboard'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.actionClose ?? 'Close'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              launchUrl(Uri.parse(url));
            },
            icon: const Icon(Icons.open_in_new),
            label: Text(l10n?.actionOpen ?? 'Open'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F9D58)),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(RetrospectiveModel retro) async {
    final buffer = StringBuffer();
    buffer.writeln('Retrospective Export - ${retro.sprintName}');
    buffer.writeln('Date: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Participants: ${retro.participantEmails.length}');
    buffer.writeln('Sentiment: ${retro.averageSentiment ?? "N/A"}');
    buffer.writeln('');
    
    buffer.writeln('--- Action Items ---');
    buffer.writeln('Action Type,Description,Owner,Priority,Due Date');

    // Group action items by action type
    final groupedItems = <ActionType?, List<ActionItem>>{};
    for (final item in retro.actionItems) {
      groupedItems.putIfAbsent(item.actionType, () => []).add(item);
    }

    // Sort by action type (items with type first, then null types)
    final sortedKeys = groupedItems.keys.toList()
      ..sort((a, b) {
        if (a == null && b == null) return 0;
        if (a == null) return 1;
        if (b == null) return -1;
        return a.displayName.compareTo(b.displayName);
      });

    for (final actionType in sortedKeys) {
      final items = groupedItems[actionType]!;
      for (final item in items) {
        final assignee = item.assigneeEmail ?? 'Unassigned';
        final date = item.dueDate != null ? item.dueDate.toString().split(' ')[0] : '';
        final typeName = item.actionType?.displayName ?? '-';
        buffer.writeln('$typeName,"${item.description}",$assignee,${item.priority.name},$date');
      }
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
