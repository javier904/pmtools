
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/retrospective/retro_list_widget.dart';
import '../../models/retrospective_model.dart';
import '../../services/retrospective_firestore_service.dart';
import '../../services/user_profile_service.dart';

import '../retrospective_board_screen.dart';
import '../../widgets/retrospective/retro_methodology_dialog.dart';
import 'package:agile_tools/models/agile_project_model.dart';
import 'package:agile_tools/models/sprint_model.dart';
import 'package:agile_tools/services/agile_firestore_service.dart';
import '../../themes/app_colors.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import 'package:agile_tools/services/subscription/subscription_limits_service.dart';
import 'package:agile_tools/widgets/subscription/limit_reached_dialog.dart';

class RetroGlobalDashboard extends StatefulWidget {
  const RetroGlobalDashboard({Key? key}) : super(key: key);

  @override
  State<RetroGlobalDashboard> createState() => _RetroGlobalDashboardState();
}

class _RetroGlobalDashboardState extends State<RetroGlobalDashboard> {
  final RetrospectiveFirestoreService _retroService = RetrospectiveFirestoreService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();
  final TextEditingController _searchController = TextEditingController();
  RetroStatus? _selectedFilter; // null = All
  bool _showArchived = false;
  bool _isCreating = false;
  Map<String, String>? _resolvedNames = {};
  bool _isResolvingNames = false;
  final UserProfileService _userProfileService = UserProfileService();

  // State
  RetroTemplate selectedTemplate = RetroTemplate.startStopContinue; // Added

  late String _currentUserEmail;
  late String _currentUserName;

  // Cached stream to avoid Firestore SDK assertion errors on rebuild
  late Stream<List<RetrospectiveModel>> _retrosStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _currentUserEmail = user?.email ?? '';
    _currentUserName = user?.displayName ?? 'User';
    _retrosStream = _buildRetrosStream();
  }

  Stream<List<RetrospectiveModel>> _buildRetrosStream() {
    return _retroService.streamRetrospectivesFiltered(
      userEmail: _currentUserEmail,
      includeArchived: _showArchived,
    );
  }

  void _updateRetrosStream() {
    setState(() {
      _retrosStream = _buildRetrosStream();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Resolve display names for all participants in the retrospective list
  /// Resolve display names for all participants in the retrospective list
  /// Batch: raccoglie tutti i nomi e fa un solo setState alla fine
  Future<void> _resolveParticipantNames(List<RetrospectiveModel> retros) async {
    if (_isResolvingNames) return; // Evita ri-entranza

    final Set<String> emailsToResolve = {};
    for (final retro in retros) {
      emailsToResolve.add(retro.createdBy);
      emailsToResolve.addAll(retro.participantEmails);
    }

    // Filtra solo email non ancora risolte
    final unresolvedEmails = emailsToResolve
        .map((e) => e.toLowerCase().trim())
        .where((e) => !(_resolvedNames?.containsKey(e) ?? false))
        .toSet();

    if (unresolvedEmails.isEmpty) return;

    _isResolvingNames = true;
    final Map<String, String> newNames = {};
    for (final email in unresolvedEmails) {
      try {
        final name = await _userProfileService.getNameByEmail(email);
        newNames[email] = name;
      } catch (_) {
        newNames[email] = email;
      }
    }
    _isResolvingNames = false;
    if (newNames.isNotEmpty && mounted) {
      setState(() {
        (_resolvedNames ??= {}).addAll(newNames);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: AppColors.retroPrimary,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.retroPrimary,
          secondary: AppColors.retroPrimary,
        ),
        // Removed appBarTheme to allow default (Dark/Black) to propagate
        floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme.copyWith(
          backgroundColor: AppColors.retroPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      child: Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.psychology_rounded),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.retroBoardTitle),
          ],
        ),
        actions: MediaQuery.of(context).size.width < 600
          ? [
              // ═══ MOBILE: compact actions ═══
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: AppLocalizations.of(context)!.retroGuidance,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: AppColors.retroPrimary,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: AppColors.retroPrimary,
                      ),
                    ),
                    child: RetroMethodologyDialog(
                      onSelect: (template) {
                        setState(() => selectedTemplate = template);
                      },
                    ),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'toggle_archived') {
                    _showArchived = !_showArchived;
                    _updateRetrosStream();
                  } else if (value == 'home') {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle_archived',
                    child: Row(children: [
                      Icon(_showArchived ? Icons.visibility_off : Icons.visibility, size: 18),
                      const SizedBox(width: 8),
                      Text(_showArchived
                          ? (AppLocalizations.of(context)?.archiveHideArchived ?? 'Hide archived')
                          : (AppLocalizations.of(context)?.archiveShowArchived ?? 'Show archived')),
                    ]),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'home',
                    child: Row(children: [
                      const Icon(Icons.home_rounded, size: 18, color: Color(0xFF8B5CF6)),
                      const SizedBox(width: 8),
                      Text(AppLocalizations.of(context)?.navHome ?? 'Home'),
                    ]),
                  ),
                ],
              ),
            ]
          : [
              // ═══ DESKTOP: full actions ═══
              FilterChip(
                label: Text(
                  _showArchived
                      ? (AppLocalizations.of(context)?.archiveHideArchived ?? 'Hide archived')
                      : (AppLocalizations.of(context)?.archiveShowArchived ?? 'Show archived'),
                  style: const TextStyle(fontSize: 12),
                ),
                selected: _showArchived,
                onSelected: (value) {
                  _showArchived = value;
                  _updateRetrosStream();
                },
                avatar: Icon(
                  _showArchived ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                ),
                selectedColor: AppColors.warning.withValues(alpha: 0.2),
                showCheckmark: false,
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: AppLocalizations.of(context)!.retroGuidance,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Theme(
                    data: Theme.of(context).copyWith(
                      primaryColor: AppColors.retroPrimary,
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: AppColors.retroPrimary,
                      ),
                    ),
                    child: RetroMethodologyDialog(
                      onSelect: (template) {
                        setState(() => selectedTemplate = template);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.home_rounded),
                tooltip: AppLocalizations.of(context)?.navHome ?? 'Home',
                color: const Color(0xFF8B5CF6),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false),
              ),
            ],
      ),
      body: Column(
        children: [
          _buildSearchFilterSection(),
          Expanded(
            child: StreamBuilder<List<RetrospectiveModel>>(
              stream: _retrosStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text(AppLocalizations.of(context)!.retroDeleteError(snapshot.error.toString())));
                }

                var retros = snapshot.data ?? [];
                if (retros.isNotEmpty) {
                  _resolveParticipantNames(retros);
                }

                // Mostra loading finché i nomi non sono risolti (prima volta)
                if (_isResolvingNames && (_resolvedNames == null || _resolvedNames!.isEmpty)) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Filter logic
                if (_searchController.text.isNotEmpty) {
                  final query = _searchController.text.toLowerCase();
                  retros = retros.where((r) => 
                    r.title.toLowerCase().contains(query) || r.sprintName.toLowerCase().contains(query)).toList();
                }

                if (_selectedFilter != null) {
                  retros = retros.where((r) => r.status == _selectedFilter).toList();
                }

                if (retros.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.history_edu, size: 64, color: AppColors.pink),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isNotEmpty 
                              ? AppLocalizations.of(context)!.retroNoResults 
                              : AppLocalizations.of(context)!.retroNoRetrosFound,
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        if (_searchController.text.isEmpty) ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _showCreateStandaloneDialog,
                            icon: const Icon(Icons.add),
                            label: Text(AppLocalizations.of(context)!.retroCreateNew),
                          ),
                        ]
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: RetroListWidget(
                    retrospectives: retros,
                    onTap: _navigateToBoard,
                    onCreateNew: _showCreateStandaloneDialog,
                    currentUserEmail: _currentUserEmail, // Pass current user
                    resolvedNames: _resolvedNames, // Pass resolved names
                    onEdit: _showEditSettingsDialog, // Added edit handler
                    onDelete: _confirmDeleteRetro, // Pass delete handler
                    onArchive: _archiveRetro,
                    onRestore: _restoreRetro,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: MediaQuery.of(context).size.width < 700
          ? null
          : FloatingActionButton.extended(
              onPressed: _showCreateStandaloneDialog,
              backgroundColor: AppColors.pink,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                AppLocalizations.of(context)?.newRetro ?? 'New Retro',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
    ));
  }

  Widget _buildSearchFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.retroSearchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  if (value.text.isEmpty) return const SizedBox.shrink();
                  return IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  );
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.pink, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (val) => setState(() {}),
          ),
          const SizedBox(height: 12),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(AppLocalizations.of(context)!.retroFilterAll, null),
                const SizedBox(width: 8),
                _buildFilterChip(AppLocalizations.of(context)!.retroFilterActive, RetroStatus.active),
                const SizedBox(width: 8),
                _buildFilterChip(AppLocalizations.of(context)!.retroFilterCompleted, RetroStatus.completed),
                if (MediaQuery.of(context).size.width < 700) ...[
                  const SizedBox(width: 8),
                  ActionChip(
                    label: Text(
                      AppLocalizations.of(context)?.newRetro ?? 'New Retro',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                    ),
                    backgroundColor: AppColors.pink,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: _showCreateStandaloneDialog,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, RetroStatus? status) {
    final isSelected = _selectedFilter == status;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: Theme.of(context).cardColor,
      selectedColor: AppColors.pink.withOpacity(0.2),
      checkmarkColor: AppColors.pink,
      side: BorderSide(
        color: isSelected ? AppColors.pink : Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  void _navigateToBoard(RetrospectiveModel retro) {
    Navigator.pushNamed(
      context,
      '/retrospective-board/${retro.id}',
    );
  }

  void _confirmDeleteRetro(RetrospectiveModel retro) {
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
          title: Text(AppLocalizations.of(context)!.retroDeleteTitle),
          content: Text(
              AppLocalizations.of(context)!.retroDeleteConfirm(retro.title.isNotEmpty ? retro.title : retro.sprintName)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final l10n = AppLocalizations.of(context)!;
                Navigator.pop(context); // Close dialog
                
                try {
                  await _retroService.deleteRetrospective(retro.id);
                  if (mounted) {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.retroDeleteSuccess)),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.retroDeleteError(e.toString()))),
                    );
                  }
                }
              },
              child: Text(AppLocalizations.of(context)!.retroDeleteConfirmAction, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _archiveRetro(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context);
    final success = await _retroService.archiveRetrospective(retro.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? (l10n?.archiveSuccessMessage ?? 'Archived') : (l10n?.archiveErrorMessage ?? 'Error')),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _restoreRetro(RetrospectiveModel retro) async {
    final l10n = AppLocalizations.of(context);
    final success = await _retroService.restoreRetrospective(retro.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? (l10n?.archiveRestoreSuccessMessage ?? 'Restored') : (l10n?.archiveRestoreErrorMessage ?? 'Error')),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _showCreateStandaloneDialog() async {
    // Prevent duplicate dialogs from rapid tapping
    if (_isCreating) return;
    _isCreating = true;

    final titleController = TextEditingController();
    RetroTemplate selectedTemplate = RetroTemplate.startStopContinue;
    RetroIcebreaker selectedIcebreaker = RetroIcebreaker.sentiment;
    
    // Linking State
    bool linkToProject = false;
    AgileProjectModel? selectedProject;
    SprintModel? selectedSprint;
    List<AgileProjectModel> userProjects = [];
    List<SprintModel> projectSprints = [];
    bool loadingProjects = true;
    bool loadingSprints = false;
    
    // Default timers
    final Map<String, int> phaseDurations = {
      RetroPhase.icebreaker.name: 5,
      RetroPhase.writing.name: 15,
      RetroPhase.voting.name: 5,
      RetroPhase.discuss.name: 30,
    };
    int maxVotes = 3;

    // Custom columns state
    List<RetroColumn> customColumns = [
      RetroColumn(id: 'custom_1', title: '', description: '', colorHex: '#A5D6A7', iconCode: Icons.lightbulb_outline.codePoint),
      RetroColumn(id: 'custom_2', title: '', description: '', colorHex: '#EF9A9A', iconCode: Icons.build_outlined.codePoint),
    ];

    // Curated color palette for custom columns
    const columnColors = [
      '#A5D6A7', '#90CAF9', '#EF9A9A', '#FFCC80', '#CE93D8',
      '#80DEEA', '#FFE082', '#B0BEC5', '#FFAB91', '#81D4FA',
    ];

    // Curated icon list for custom columns
    final columnIcons = [
      Icons.lightbulb_outline,
      Icons.build_outlined,
      Icons.thumb_up_alt_outlined,
      Icons.thumb_down_alt_outlined,
      Icons.trending_up,
      Icons.trending_down,
      Icons.warning_amber_rounded,
      Icons.check_circle_outline,
      Icons.highlight_remove_rounded,
      Icons.play_circle_outline,
      Icons.pause_circle_outline,
      Icons.favorite_border,
      Icons.star_outline,
      Icons.flag_outlined,
      Icons.emoji_emotions_outlined,
      Icons.sentiment_dissatisfied_outlined,
      Icons.question_mark,
      Icons.rocket_launch_outlined,
    ];

    final agileService = AgileFirestoreService();

    // Trigger explicit load
    agileService.getUserProjects(_currentUserEmail).then((projects) {
       userProjects = projects;
       loadingProjects = false;
    });

    await showDialog(
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
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            
            // Initial Load Trigger (One time hack)
            if (userProjects.isEmpty && loadingProjects) {
              agileService.getUserProjects(_currentUserEmail).then((p) {
                if (context.mounted) {
                  setDialogState(() {
                    userProjects = p;
                    loadingProjects = false;
                  });
                }
              });
            }
  
            return AlertDialog(
            title: Text(AppLocalizations.of(context)!.retroNewRetroTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Standalone / Linked Toggle
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.retroLinkToSprint),
                      const Spacer(),
                      Switch(
                        value: linkToProject, 
                        onChanged: (val) {
                          setDialogState(() => linkToProject = val);
                          if (!val) {
                            selectedProject = null;
                            selectedSprint = null;
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  
                  if (linkToProject) ...[
                    if (loadingProjects)
                      const Center(child: CircularProgressIndicator())
                    else if (userProjects.isEmpty)
                       Text(AppLocalizations.of(context)!.retroNoProjectFound, style: const TextStyle(color: Colors.red))
                    else
                      DropdownButtonFormField<AgileProjectModel>(
                        value: selectedProject,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.retroSelectProject),
                        items: userProjects.map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.name),
                        )).toList(),
                        onChanged: (p) {
                           setDialogState(() {
                             selectedProject = p;
                             selectedSprint = null;
                             loadingSprints = true;
                           });
                           if (p != null) {
                             agileService.getProjectSprints(p.id).then((sprints) {
                               if (context.mounted) {
                                 setDialogState(() {
                                   projectSprints = sprints;
                                   loadingSprints = false;
                                 });
                               }
                             });
                           }
                        },
                      ),
                    const SizedBox(height: 16),
                    
                    if (selectedProject != null) ...[
                      if (loadingSprints)
                        const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()))
                      else 
                        DropdownButtonFormField<SprintModel>(
                          value: selectedSprint,
                          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.retroSelectSprint),
                           items: projectSprints.map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(AppLocalizations.of(context)!.retroSprintLabel(s.number, s.name)),
                          )).toList(),
                          onChanged: (s) {
                            setDialogState(() {
                              selectedSprint = s;
                              if (s != null) {
                                titleController.text = s.name; // Auto-fill title
                              }
                            });
                          },
                        ),
                    ]
                  ],
  
                  if (!linkToProject || selectedSprint == null)
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.retroSessionTitle,
                        hintText: AppLocalizations.of(context)!.retroSessionTitleHint,
                      ),
                      autofocus: !linkToProject && MediaQuery.of(context).size.width > 600,
                    ),
  
                  const SizedBox(height: 16),
                  DropdownButtonFormField<RetroTemplate>(
                    value: selectedTemplate,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.retroTemplateLabel),
                    isExpanded: true, // Ensure proper layout for long text
                    selectedItemBuilder: (BuildContext context) {
                      return RetroTemplate.values
                          .where((t) => t != RetroTemplate.sailboat && t != RetroTemplate.quickForm)
                          .map<Widget>((RetroTemplate t) {
                        return Text(
                          t.getLocalizedDisplayName(AppLocalizations.of(context)!),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        );
                      }).toList();
                    },
                    items: RetroTemplate.values
                        .where((t) => t != RetroTemplate.sailboat && t != RetroTemplate.quickForm)
                        .map((t) {
                      return DropdownMenuItem(
                        value: t,
                        child: Row(
                          children: [
                            Icon(t.icon, size: 20), // Uses default theme color (visible in dark mode)
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    t.getLocalizedDisplayName(AppLocalizations.of(context)!), 
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    t.getLocalizedUsageSuggestion(AppLocalizations.of(context)!),
                                    style: TextStyle(
                                      fontSize: 11, 
                                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                                      fontStyle: FontStyle.italic
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => selectedTemplate = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  // Configurazione Voti
                  Row(
                     children: [
                        Text(AppLocalizations.of(context)!.retroVotesPerUser, style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: maxVotes > 1 ? () => setDialogState(() => maxVotes--) : null,
                        ),
                        Text('$maxVotes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: maxVotes < 10 ? () => setDialogState(() => maxVotes++) : null,
                        ),
                     ],
                  ),
                  const SizedBox(height: 8),
  
                  // Template Description Box
                  Tooltip(
                    message: 'Description and usage of selected template',
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info_outline, size: 20, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(selectedTemplate.getLocalizedDisplayName(AppLocalizations.of(context)!), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedTemplate.getLocalizedDescription(AppLocalizations.of(context)!),
                            style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedTemplate.getLocalizedUsageSuggestion(AppLocalizations.of(context)!),
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blue.shade800),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // === CUSTOM COLUMNS EDITOR ===
                  if (selectedTemplate == RetroTemplate.custom) ...[
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.retroCustomConfigureColumns,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...customColumns.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final col = entry.value;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: Color(int.parse(col.colorHex.replaceFirst('#', '0xFF'))),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Color picker
                              PopupMenuButton<String>(
                                tooltip: 'Color',
                                child: Container(
                                  width: 28, height: 28,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(col.colorHex.replaceFirst('#', '0xFF'))),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.grey.shade300),
                                  ),
                                ),
                                itemBuilder: (_) => columnColors.map((c) {
                                  return PopupMenuItem(
                                    value: c,
                                    child: Container(
                                      width: 24, height: 24,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(c.replaceFirst('#', '0xFF'))),
                                        shape: BoxShape.circle,
                                        border: c == col.colorHex
                                            ? Border.all(color: Colors.black, width: 2)
                                            : Border.all(color: Colors.grey.shade300),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onSelected: (c) {
                                  setDialogState(() {
                                    customColumns[idx] = RetroColumn(
                                      id: col.id, title: col.title, description: col.description,
                                      colorHex: c, iconCode: col.iconCode,
                                    );
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              // Icon picker
                              PopupMenuButton<int>(
                                tooltip: 'Icon',
                                child: Icon(
                                  IconData(col.iconCode, fontFamily: 'MaterialIcons'),
                                  color: Color(int.parse(col.colorHex.replaceFirst('#', '0xFF'))),
                                ),
                                itemBuilder: (_) => columnIcons.map((ic) {
                                  return PopupMenuItem(
                                    value: ic.codePoint,
                                    child: Icon(ic, color: ic.codePoint == col.iconCode ? Colors.blue : null),
                                  );
                                }).toList(),
                                onSelected: (cp) {
                                  setDialogState(() {
                                    customColumns[idx] = RetroColumn(
                                      id: col.id, title: col.title, description: col.description,
                                      colorHex: col.colorHex, iconCode: cp,
                                    );
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              // Title field
                              Expanded(
                                child: TextFormField(
                                  initialValue: col.title,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)!.retroCustomColumnTitle,
                                    isDense: true,
                                    border: const OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    customColumns[idx] = RetroColumn(
                                      id: col.id, title: val, description: col.description,
                                      colorHex: col.colorHex, iconCode: col.iconCode,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 4),
                              // Remove button
                              if (customColumns.length > 2)
                                IconButton(
                                  icon: const Icon(Icons.close, size: 18),
                                  tooltip: AppLocalizations.of(context)!.retroCustomRemoveColumn,
                                  onPressed: () {
                                    setDialogState(() => customColumns.removeAt(idx));
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    // Add column button
                    if (customColumns.length < 8)
                      OutlinedButton.icon(
                        onPressed: () {
                          setDialogState(() {
                            final nextIdx = customColumns.length + 1;
                            final colorIdx = (customColumns.length) % columnColors.length;
                            customColumns.add(RetroColumn(
                              id: 'custom_$nextIdx',
                              title: '',
                              description: '',
                              colorHex: columnColors[colorIdx],
                              iconCode: columnIcons[colorIdx % columnIcons.length].codePoint,
                            ));
                          });
                        },
                        icon: const Icon(Icons.add, size: 16),
                        label: Text(AppLocalizations.of(context)!.retroCustomAddColumn),
                      )
                    else
                      Text(
                        AppLocalizations.of(context)!.retroCustomMaxColumns,
                        style: TextStyle(fontSize: 12, color: Colors.orange.shade700, fontStyle: FontStyle.italic),
                      ),
                  ],
                  const SizedBox(height: 16),
                  
                  // Icebreaker Configuration
                  Text(AppLocalizations.of(context)!.retroIcebreakerSectionTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Tooltip(
                          message: AppLocalizations.of(context)!.retroSelectIcebreakerTooltip,
                          child: DropdownButtonFormField<RetroIcebreaker>(
                            value: selectedIcebreaker,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.retroIcebreakerLabel,
                              border: const OutlineInputBorder(),
                              isDense: true,
                            ),
                            items: RetroIcebreaker.values.map((i) {
                               return DropdownMenuItem(
                                  value: i,
                                  child: Text(i.getLocalizedDisplayName(AppLocalizations.of(context)!)),
                               );
                            }).toList(),
                            onChanged: (val) {
                               if (val != null) {
                                 setDialogState(() => selectedIcebreaker = val);
                               }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                     selectedIcebreaker.getLocalizedDescription(AppLocalizations.of(context)!),
                     style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 24),
                  
                  // Phase Timers Configuration
                  ExpansionTile(
                    title: Text(AppLocalizations.of(context)!.retroTimePhasesOptional, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    tilePadding: EdgeInsets.zero,
                    children: [
                      Text(AppLocalizations.of(context)!.retroTimePhasesDesc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 8),
                      ...[
                        RetroPhase.icebreaker,
                        RetroPhase.writing,
                        RetroPhase.voting,
                        RetroPhase.discuss
                      ].map((phase) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100, 
                                child: Text(_getPhaseName(phase, AppLocalizations.of(context)!), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: phaseDurations[phase.name]?.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    suffixText: 'min',
                                  ),
                                  onChanged: (val) {
                                    final mins = int.tryParse(val);
                                    if (mins != null) {
                                      phaseDurations[phase.name] = mins;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text.trim();
                  
                  if (title.isNotEmpty || (linkToProject && selectedSprint != null)) {
                    final retroTitle = title.isEmpty && selectedSprint != null 
                        ? selectedSprint!.name 
                        : title;

                    // Fast client-side limit check (instant)
                    final limitCheck = await _limitsService.canCreateProject(
                      _currentUserEmail,
                      entityType: 'retrospective',
                    );

                    if (!limitCheck.allowed) {
                      if (context.mounted) Navigator.pop(context);
                      if (this.mounted) {
                        LimitReachedDialog.show(
                          context: this.context,
                          limitResult: limitCheck,
                          entityType: 'retrospective',
                        );
                      }
                      return;
                    }

                    // Server-side validation fire-and-forget (audit only, non-blocking)
                    _limitsService.validateServerSide('retrospective');

                    // Crea modello
                    final newRetro = RetrospectiveModel(
                      id: '', // Sarà generato dal service
                      title: retroTitle,
                      sprintName: retroTitle,
                      template: selectedTemplate,
                      columns: selectedTemplate == RetroTemplate.custom
                          ? customColumns.where((c) => c.title.trim().isNotEmpty).toList()
                          : selectedTemplate.defaultColumns,
                      createdAt: DateTime.now(),
                      createdBy: _currentUserEmail,
                      participantEmails: [_currentUserEmail],
                      projectId: selectedProject?.id,
                      sprintId: selectedSprint?.id,
                      sprintNumber: selectedSprint?.number ?? 0,
                      timer: const RetroTimer(isRunning: false), // Start stopped
                      phaseDurations: phaseDurations,
                      icebreakerTemplate: selectedIcebreaker, // Added Icebreaker
                      maxVotesPerUser: maxVotes,
                    );
  
                    // Salva
                    final id = await _retroService.createRetrospective(newRetro);
  
                     if (mounted) {
                      Navigator.pop(context);
                      // Naviga direttamente alla board
                      _navigateToBoard(newRetro.copyWith(id: id));
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.retroActionCreate),
              ),
            ],
          );
          }
        ),
      ),
    );

    _isCreating = false;
  }

  String _getPhaseName(RetroPhase phase, AppLocalizations l10n) {
    switch (phase) {
        case RetroPhase.icebreaker: return l10n.retroPhaseIcebreaker;
        case RetroPhase.writing: return l10n.retroPhaseWriting;
        case RetroPhase.voting: return l10n.retroPhaseVoting;
        case RetroPhase.discuss: return l10n.retroPhaseDiscuss;
        default: return phase.name.toUpperCase();
    }
  }


  void _showEditSettingsDialog(RetrospectiveModel retro) {
    // Double check constraints (though usually hidden by RetroListWidget)
    if (retro.currentPhase.index >= RetroPhase.voting.index) {
       return;
    }

    final l10n = AppLocalizations.of(context)!;
    int maxVotes = retro.maxVotesPerUser;
    // Deep copy durations
    final Map<String, int> phaseDurations = Map.from(retro.phaseDurations);

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
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(l10n.actionEdit),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Read-only Info
                    const SizedBox(height: 8),
                    Text(l10n.retroSessionTitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(retro.title.isNotEmpty ? retro.title : retro.sprintName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(l10n.retroTemplateLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(retro.template.getLocalizedDisplayName(l10n), style: const TextStyle(fontSize: 14)),
                    const Divider(height: 32),

                    // Editable Fields
                    // Max Votes
                    Row(
                       children: [
                          Expanded(child: Text(l10n.retroVotesPerUser, style: const TextStyle(fontWeight: FontWeight.w500))),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: maxVotes > 1 ? () => setDialogState(() => maxVotes--) : null,
                          ),
                          Text('$maxVotes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: maxVotes < 10 ? () => setDialogState(() => maxVotes++) : null,
                          ),
                       ],
                    ),
                    const SizedBox(height: 16),

                    // Phase Timers
                    ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(l10n.retroTimePhasesOptional, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      tilePadding: EdgeInsets.zero,
                      children: [
                        ...[
                          RetroPhase.icebreaker,
                          RetroPhase.writing,
                          RetroPhase.voting,
                          RetroPhase.discuss
                        ].map((phase) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100, 
                                  child: Text(_getPhaseName(phase, l10n), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                                ),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: phaseDurations[phase.name]?.toString() ?? '0',
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      suffixText: 'min',
                                    ),
                                    onChanged: (val) {
                                      final mins = int.tryParse(val);
                                      if (mins != null) {
                                        phaseDurations[phase.name] = mins;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.actionCancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    _retroService.updateSettings(
                      retro.id, 
                      maxVotes: maxVotes, 
                      phaseDurations: phaseDurations
                    );
                    Navigator.pop(context);
                  },
                  child: Text(l10n.actionSave),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
