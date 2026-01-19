
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/retrospective/retro_list_widget.dart';
import '../../models/retrospective_model.dart';
import '../../services/retrospective_firestore_service.dart';

import '../retrospective_board_screen.dart';
import '../../widgets/retrospective/retro_methodology_dialog.dart';
import 'package:agile_tools/models/agile_project_model.dart';
import 'package:agile_tools/models/sprint_model.dart';
import 'package:agile_tools/services/agile_firestore_service.dart';
import '../../themes/app_colors.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class RetroGlobalDashboard extends StatefulWidget {
  const RetroGlobalDashboard({Key? key}) : super(key: key);

  @override
  State<RetroGlobalDashboard> createState() => _RetroGlobalDashboardState();
}

class _RetroGlobalDashboardState extends State<RetroGlobalDashboard> {
  final RetrospectiveFirestoreService _retroService = RetrospectiveFirestoreService();
  final TextEditingController _searchController = TextEditingController();
  RetroStatus? _selectedFilter; // null = All
  
  // State
  RetroTemplate selectedTemplate = RetroTemplate.startStopContinue; // Added
  
  late String _currentUserEmail;
  late String _currentUserName;
  late Stream<List<RetrospectiveModel>> _retrospectivesStream; // Added

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _currentUserEmail = user?.email ?? '';
    _currentUserName = user?.displayName ?? 'User';
    // Initialize stream once
    _retrospectivesStream = _retroService.streamUserRetrospectives(_currentUserEmail);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.psychology_rounded),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.retroBoardTitle),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Guida alle Retrospettive',
            onPressed: () => showDialog(
              context: context,
              builder: (context) => RetroMethodologyDialog(
                onSelect: (template) {
                  setState(() => selectedTemplate = template);
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchFilterSection(),
          Expanded(
            child: StreamBuilder<List<RetrospectiveModel>>(
              stream: _retrospectivesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Errore: ${snapshot.error}'));
                }

                var retros = snapshot.data ?? [];

                // Filter logic
                if (_searchController.text.isNotEmpty) {
                  final query = _searchController.text.toLowerCase();
                  retros = retros.where((r) => 
                    r.sprintName.toLowerCase().contains(query)).toList();
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
                              ? 'Nessun risultato per la ricerca' 
                              : 'Nessuna retrospettiva trovata',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        if (_searchController.text.isEmpty) ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: _showCreateStandaloneDialog,
                            icon: const Icon(Icons.add),
                            label: const Text('Crea Nuova'),
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
                    onDelete: _confirmDeleteRetro, // Pass delete handler
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateStandaloneDialog,
        backgroundColor: AppColors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
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
              hintText: 'Cerca retrospettiva...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
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
                _buildFilterChip('Tutte', null),
                const SizedBox(width: 8),
                _buildFilterChip('Active', RetroStatus.active),
                const SizedBox(width: 8),
                _buildFilterChip('Completed', RetroStatus.completed),
                const SizedBox(width: 8),
                _buildFilterChip('Draft', RetroStatus.draft),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, RetroStatus? status) {
    final isSelected = _selectedFilter == status;
    final theme = Theme.of(context);
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: Colors.transparent,
      selectedColor: theme.primaryColor,
      checkmarkColor: isSelected ? Colors.white : theme.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : null, // White text when selected
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected 
              ? theme.primaryColor 
              : theme.dividerColor,
        ),
      ),
    );
  }

  void _navigateToBoard(RetrospectiveModel retro) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RetroBoardScreen(
          retroId: retro.id,
          currentUserEmail: _currentUserEmail,
          currentUserName: _currentUserName,
        ),
      ),
    );
  }

  void _confirmDeleteRetro(RetrospectiveModel retro) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Retrospettiva'),
        content: Text(
            'Sei sicuro di voler eliminare definitivamente la retrospettiva "${retro.sprintName}"?\n\nQuesta azione è irreversibile e cancellerà tutti i dati associati (card, voti, action items).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context); // Close dialog
              
              try {
                await _retroService.deleteRetrospective(retro.id);
                if (mounted) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Retrospettiva eliminata con successo')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('Errore durante l\'eliminazione: $e')),
                  );
                }
              }
            },
            child: const Text('Elimina definitivamente', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showCreateStandaloneDialog() {
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

    final agileService = AgileFirestoreService();

    // Trigger explicit load
    agileService.getUserProjects(_currentUserEmail).then((projects) {
       userProjects = projects;
       loadingProjects = false;
    });

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
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
          title: const Text('Nuova Retrospettiva'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Standalone / Linked Toggle
                Row(
                  children: [
                    const Text('Collega a Sprint?'),
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
                     const Text('Nessun progetto trovato.', style: TextStyle(color: Colors.red))
                  else
                    DropdownButtonFormField<AgileProjectModel>(
                      value: selectedProject,
                      decoration: const InputDecoration(labelText: 'Seleziona Progetto'),
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
                        decoration: const InputDecoration(labelText: 'Seleziona Sprint'),
                         items: projectSprints.map((s) => DropdownMenuItem(
                          value: s,
                          child: Text('Sprint ${s.number}: ${s.name}'),
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
                    decoration: const InputDecoration(
                      labelText: 'Titolo Sessione',
                      hintText: 'Es: Weekly Sync, Project Review...',
                    ),
                    autofocus: !linkToProject,
                  ),

                const SizedBox(height: 16),
                DropdownButtonFormField<RetroTemplate>(
                  value: selectedTemplate,
                  decoration: const InputDecoration(labelText: 'Template'),
                  isExpanded: true, // Ensure proper layout for long text
                  selectedItemBuilder: (BuildContext context) {
                    return RetroTemplate.values.map<Widget>((RetroTemplate t) {
                      return Text(
                        t.displayName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      );
                    }).toList();
                  },
                  items: RetroTemplate.values.map((t) {
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
                                  t.displayName, 
                                  style: const TextStyle(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  t.usageSuggestion,
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
                      const Text('Voti per utente:', style: TextStyle(fontWeight: FontWeight.w500)),
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
                            Text(_getTemplateName(selectedTemplate, AppLocalizations.of(context)!), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getTemplateDesc(selectedTemplate, AppLocalizations.of(context)!),
                          style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getUsageSuggestion(selectedTemplate, AppLocalizations.of(context)!),
                          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.blue.shade800),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                child: Text(_getIcebreakerName(i, AppLocalizations.of(context)!)),
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
                   _getIcebreakerDesc(selectedIcebreaker, AppLocalizations.of(context)!),
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
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                
                if (title.isNotEmpty || (linkToProject && selectedSprint != null)) {
                  final retroTitle = title.isEmpty && selectedSprint != null 
                      ? selectedSprint!.name 
                      : title;

                  // Crea modello
                  final newRetro = RetrospectiveModel(
                    id: '', // Sarà generato dal service
                    sprintName: retroTitle,
                    template: selectedTemplate,
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
              child: const Text('Crea'),
            ),
          ],
        );
        }
      ),
    );
  }

  String _getTemplateName(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroTemplateStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroTemplateSailboat;
      case RetroTemplate.fourLs: return l10n.retroTemplate4Ls;
      case RetroTemplate.starfish: return l10n.retroTemplateStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroTemplateMadSadGlad;
      case RetroTemplate.daki: return l10n.retroTemplateDAKI;
    }
  }

  String _getTemplateDesc(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroDescStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroDescSailboat;
      case RetroTemplate.fourLs: return l10n.retroDesc4Ls;
      case RetroTemplate.starfish: return l10n.retroDescStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroDescMadSadGlad;
      case RetroTemplate.daki: return l10n.retroDescDAKI;
    }
  }

  String _getUsageSuggestion(RetroTemplate template, AppLocalizations l10n) {
    switch (template) {
      case RetroTemplate.startStopContinue: return l10n.retroUsageStartStopContinue;
      case RetroTemplate.sailboat: return l10n.retroUsageSailboat;
      case RetroTemplate.fourLs: return l10n.retroUsage4Ls;
      case RetroTemplate.starfish: return l10n.retroUsageStarfish;
      case RetroTemplate.madSadGlad: return l10n.retroUsageMadSadGlad;
      case RetroTemplate.daki: return l10n.retroUsageDAKI;
    }
  }

  String _getIcebreakerName(RetroIcebreaker ib, AppLocalizations l10n) {
    switch (ib) {
      case RetroIcebreaker.sentiment: return l10n.retroIcebreakerSentiment;
      case RetroIcebreaker.oneWord: return l10n.retroIcebreakerOneWord;
      case RetroIcebreaker.weatherReport: return l10n.retroIcebreakerWeather;
    }
  }

  String _getIcebreakerDesc(RetroIcebreaker ib, AppLocalizations l10n) {
    switch (ib) {
      case RetroIcebreaker.sentiment: return l10n.retroIcebreakerSentimentDesc;
      case RetroIcebreaker.oneWord: return l10n.retroIcebreakerOneWordDesc;
      case RetroIcebreaker.weatherReport: return l10n.retroIcebreakerWeatherDesc;
    }
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
}
