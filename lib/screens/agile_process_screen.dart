import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/agile_project_model.dart';
import '../models/agile_enums.dart';
import '../models/team_member_model.dart';
import '../services/agile_firestore_service.dart';
import '../services/agile_audit_service.dart';
import '../services/auth_service.dart';
import '../services/user_profile_service.dart';
import '../themes/app_theme.dart';
import '../widgets/agile/methodology_guide_dialog.dart';
import '../themes/app_colors.dart';
import 'agile_project_detail_screen.dart';
import '../widgets/home/favorite_star.dart';
import '../l10n/app_localizations.dart';
import '../widgets/agile/agile_project_form_dialog.dart';
import '../services/subscription/subscription_limits_service.dart';
import '../widgets/subscription/limit_reached_dialog.dart';

/// Screen principale per la gestione dei Progetti Agile
///
/// Implementa:
/// - Lista dei progetti dell'utente
/// - Creazione/modifica/eliminazione progetti
/// - Navigazione al dettaglio progetto
class AgileProcessScreen extends StatefulWidget {
  final String? initialProjectId;

  const AgileProcessScreen({super.key, this.initialProjectId});

  @override
  State<AgileProcessScreen> createState() => _AgileProcessScreenState();
}

class _AgileProcessScreenState extends State<AgileProcessScreen> {
  final AgileFirestoreService _firestoreService = AgileFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  bool _hasCheckedArgs = false;

  // Stato
  AgileProjectModel? _selectedProject;
  int _initialDetailIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _statusFilter = 'all'; // 'all', 'active', 'completed'
  bool _showArchived = false;
  bool _isCreating = false;
  Map<String, String>? _resolvedNames = {};
  final UserProfileService _userProfileService = UserProfileService();

  String get _currentUserEmail => _authService.currentUser?.email ?? '';
  String get _currentUserName => _authService.currentUser?.displayName ?? 'Utente';

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasCheckedArgs) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['initialAction'] == 'retro') {
        // Schedule callback to show snackbar after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showGuide('Seleziona un progetto per accedere alle sue Retrospettive 🚀');
        });
      }

      // Auto-navigate to project if initialProjectId is provided
      if (widget.initialProjectId != null) {
        _loadInitialProject(widget.initialProjectId!);
      }

      _hasCheckedArgs = true;
    }
  }

  Future<void> _loadInitialProject(String projectId) async {
    try {
      final project = await _firestoreService.getProject(projectId);
      if (project != null && mounted) {
        _openProjectDetail(project);
      }
    } catch (e) {
      // Fallback: resta sulla lista progetti
    }
  }

  void _showGuide(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.touch_app, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.purple.shade700,
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Resolve display names for all participants in the project list
  Future<void> _resolveParticipantNames(List<AgileProjectModel> projects) async {
    final Set<String> emailsToResolve = {};
    for (final project in projects) {
      emailsToResolve.add(project.createdBy);
      emailsToResolve.addAll(project.participants.keys);
    }

    for (final email in emailsToResolve) {
      final normalizedEmail = email.toLowerCase().trim();
      if (!(_resolvedNames?.containsKey(normalizedEmail) ?? false)) {
        final name = await _userProfileService.getNameByEmail(email);
        if (mounted) {
          setState(() {
            (_resolvedNames ??= {})[normalizedEmail] = name;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se c'è un progetto selezionato, mostra solo il dettaglio (ha il suo Scaffold)
    if (_selectedProject != null) {
      return _buildProjectDetail();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        surfaceTintColor: context.surfaceColor,
        foregroundColor: context.textPrimaryColor,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.agileProcessTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: MediaQuery.of(context).size.width < 600
          ? [
              // ═══ MOBILE: compact actions ═══
              IconButton(
                icon: Icon(Icons.menu_book_rounded, color: Colors.teal.shade700),
                tooltip: AppLocalizations.of(context)!.agileMethodologyGuide,
                onPressed: () => MethodologyGuideDialog.show(context),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'toggle_archived') {
                    setState(() => _showArchived = !_showArchived);
                  } else if (value == 'home') {
                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle_archived',
                    child: Row(children: [
                      Icon(_showArchived ? Icons.visibility_off : Icons.visibility, size: 18, color: const Color(0xFF8B5CF6)),
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: TextButton.icon(
                  onPressed: () => MethodologyGuideDialog.show(context),
                  icon: Icon(Icons.menu_book_rounded, size: 18, color: Colors.teal.shade700),
                  label: Text(
                    AppLocalizations.of(context)!.agileMethodologyGuide,
                    style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(
                  _showArchived
                      ? (AppLocalizations.of(context)?.archiveHideArchived ?? 'Hide archived')
                      : (AppLocalizations.of(context)?.archiveShowArchived ?? 'Show archived'),
                  style: const TextStyle(fontSize: 12),
                ),
                selected: _showArchived,
                onSelected: (value) => setState(() => _showArchived = value),
                avatar: Icon(
                  _showArchived ? Icons.visibility_off : Icons.visibility,
                  size: 16,
                  color: const Color(0xFF8B5CF6),
                ),
                selectedColor: AppColors.warning.withOpacity(0.2),
                showCheckmark: false,
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
      body: _buildProjectList(),
      floatingActionButton: _buildFAB(),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // LISTA PROGETTI
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildProjectList() {
    return StreamBuilder<List<AgileProjectModel>>(
      stream: _firestoreService.streamProjectsFiltered(
        userEmail: _currentUserEmail,
        includeArchived: _showArchived,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Errore: ${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Riprova'),
                ),
              ],
            ),
          );
        }

        final projects = snapshot.data ?? [];
        if (projects.isNotEmpty) {
          _resolveParticipantNames(projects);
        }

        // Filtra per ricerca
        final filteredProjects = _searchQuery.isEmpty
            ? projects
            : projects.where((p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

        return Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Barra di ricerca
              _buildSearchFilterSection(),
              const SizedBox(height: 16),
              // Lista progetti
              Expanded(
                child: filteredProjects.isEmpty
                    ? (projects.isEmpty ? _buildEmptyState() : _buildNoResultsState())
                    : _buildProjectGrid(filteredProjects),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchFilterSection() {
    final l10n = AppLocalizations.of(context);
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
              hintText: l10n?.agileSearchProjects ?? 'Search projects...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                         _searchController.clear();
                         setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() => _searchQuery = value);
              });
            },
          ),
          const SizedBox(height: 12),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStandardFilterChip((l10n?.retroFilterAll ?? 'All'), 'all'),
                const SizedBox(width: 8),
                _buildStandardFilterChip((l10n?.retroFilterActive ?? 'Active'), 'active'),
                const SizedBox(width: 8),
                _buildStandardFilterChip((l10n?.retroFilterCompleted ?? 'Completed'), 'completed'),
                if (MediaQuery.of(context).size.width < 700) ...[
                  const SizedBox(width: 8),
                  ActionChip(
                    label: const Text(
                      'New Project',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                    ),
                    backgroundColor: AppColors.primary,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: _showCreateProjectDialog,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStandardFilterChip(String label, String status) {
    bool isSelected = false;
    if (status == 'all') isSelected = _statusFilter == 'all';
    else if (status == 'active') isSelected = _statusFilter == 'active';
    else if (status == 'completed') isSelected = _statusFilter == 'completed';

    const Color fabColor = Color(0xFF8B5CF6);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _statusFilter = status;
            if (status == 'all') {
              _showArchived = true;
            } else if (status == 'active') {
              _showArchived = false;
            } else if (status == 'completed') {
              _showArchived = true;
            }
          });
        }
      },
      backgroundColor: Theme.of(context).cardColor,
      selectedColor: fabColor.withOpacity(0.2),
      checkmarkColor: fabColor,
      side: BorderSide(
        color: isSelected ? fabColor : Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildProjectGrid(List<AgileProjectModel> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ═══ MOBILE (<600px): ListView a tutta larghezza ═══
        if (constraints.maxWidth < 600) {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            itemCount: projects.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) => _buildProjectCard(projects[index]),
          );
        }

        // ═══ DESKTOP (>=600px): GridView originale ═══
        final compactCrossAxisCount = constraints.maxWidth > 1400
            ? 6
            : constraints.maxWidth > 1100
                ? 5
                : constraints.maxWidth > 800
                    ? 4
                    : 3;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: compactCrossAxisCount,
            childAspectRatio: 2.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) => _buildProjectCard(projects[index]),
        );
      },
    );
  }

  Widget _buildProjectCard(AgileProjectModel project) {
    final l10n = AppLocalizations.of(context)!;
    final isOwner = project.isOwner(_currentUserEmail);
    final canManage = project.canManage(_currentUserEmail);
    final frameworkColor = _getFrameworkColor(project.framework);

    // Calcola progress (completedSprintCount / sprintCount o 0)
    final progressPercent = project.sprintCount > 0
        ? (project.completedSprintCount / project.sprintCount * 100).round()
        : 0;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _openProjectDetail(project),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header: Icona Framework + Titolo + Menu
              Row(
                children: [
                  // Icona framework con status dot (sprint attivo)
                  Tooltip(
                    message: '${project.framework.displayName}${project.hasActiveSprint ? ' - Sprint in corso' : ''}',
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: frameworkColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(project.framework.icon, color: frameworkColor, size: 14),
                          ),
                          if (project.hasActiveSprint)
                            Positioned(
                              right: 1,
                              bottom: 1,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Theme.of(context).cardColor, width: 1),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Titolo con tooltip
                  Expanded(
                    child: Tooltip(
                      message: '${project.name}${project.description.isNotEmpty ? '\n${project.description}' : ''}',
                      child: Text(
                        project.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: project.isArchived ? context.textMutedColor : context.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Badge archiviato
                  if (project.isArchived)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Tooltip(
                        message: AppLocalizations.of(context)!.archiveBadge,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.archive, size: 12, color: Colors.orange),
                        ),
                      ),
                    ),
                  // Badge ruolo
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                     decoration: BoxDecoration(
                       color: isOwner ? Colors.blue.withOpacity(0.1) : Colors.purple.withOpacity(0.1),
                       borderRadius: BorderRadius.circular(4),
                     ),
                     child: Text(
                       isOwner ? (l10n.retroOwner ?? 'Owner') : (l10n.retroGuest ?? 'Ospite'),
                       style: TextStyle(
                         fontSize: 10,
                         fontWeight: FontWeight.bold,
                         color: isOwner ? Colors.blue : Colors.purple,
                       ),
                     ),
                  ),
                  const SizedBox(width: 4),
                  FavoriteStar(
                    resourceId: project.id,
                    type: 'agile_project',
                    title: project.name,
                    colorHex: '#9C27B0',
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  // Menu opzioni
                  if (canManage)
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showProjectMenuAtPosition(context, project, details.globalPosition, isOwner);
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(Icons.more_vert, size: 16, color: context.textSecondaryColor),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Progress bar (se ci sono sprint)
              if (project.sprintCount > 0)
                Tooltip(
                  message: '${project.completedSprintCount}/${project.sprintCount} sprint (${progressPercent}%)',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: project.completedSprintCount / project.sprintCount,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressPercent >= 80 ? Colors.green : progressPercent >= 50 ? Colors.orange : Colors.blue,
                      ),
                      minHeight: 2,
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              // Stats compatte
              Row(
                children: [
                  _buildParticipantAgileProjectStat(project),
                  const SizedBox(width: 12),
                  _buildCompactStat(Icons.assignment_outlined, '${project.backlogCount}', 'User Stories'),
                  if (project.sprintCount > 0) ...[
                    const SizedBox(width: 12),
                    _buildCompactStat(Icons.replay, '${project.sprintCount}', 'Sprint'),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactStat(IconData icon, String value, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: context.textMutedColor),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce la statistica partecipanti con tooltip dettagliato (owner + ruoli)
  Widget _buildParticipantAgileProjectStat(AgileProjectModel project) {
    final participantLines = <String>[];

    // Owner
    final normalizedOwnerEmail = project.createdBy.toLowerCase().trim();
    final ownerName = _resolvedNames?[normalizedOwnerEmail] ?? project.createdBy;
    participantLines.add('$ownerName - 👑 Owner');

    // Partecipanti con ruoli
    for (final entry in project.participants.entries) {
      if (entry.key == project.createdBy) continue;
      final member = entry.value;
      final email = member.email;
      final normalizedEmail = email.toLowerCase().trim();
      final resolvedName = _resolvedNames?[normalizedEmail] ?? (member.name.isNotEmpty ? member.name : email);
      
      final roleLabel = switch (member.teamRole.name) {
        'productOwner' => '⭐ Product Owner',
        'scrumMaster' => '🛡️ Scrum Master',
        'developer' => '💻 Developer',
        _ => '👥 Member',
      };
      participantLines.add('$resolvedName - $roleLabel');
    }

    final tooltipText = 'Team:\n${participantLines.join('\n')}';

    return Tooltip(
      message: tooltipText,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people, size: 18, color: context.textMutedColor),
          const SizedBox(width: 5),
          Text(
            '${project.participantCount}',
            style: TextStyle(
              fontSize: 14,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactRolesRow(AgileProjectModel project) {
    final hasAnyRole = project.productOwnerEmail != null ||
                       project.scrumMasterEmail != null ||
                       project.developmentTeamEmails.isNotEmpty;

    if (!hasAnyRole) {
      return Row(
        children: [
          Icon(Icons.person_add_outlined, size: 12, color: context.textMutedColor),
          const SizedBox(width: 4),
          Text(
            'Assegna ruoli',
            style: TextStyle(fontSize: 10, color: context.textMutedColor, fontStyle: FontStyle.italic),
          ),
        ],
      );
    }

    return Row(
      children: [
        // Product Owner - Teal/Blu intenso
        if (project.productOwnerEmail != null)
          _buildCompactRoleChip(
            icon: Icons.star_rounded,
            label: 'PO',
            color: const Color(0xFF0097A7), // Teal/Cyan scuro
            name: project.productOwner?.name ?? project.productOwnerEmail!,
            description: 'Product Owner - Gestisce priorità e backlog',
          ),

        // Scrum Master - Arancione
        if (project.scrumMasterEmail != null) ...[
          if (project.productOwnerEmail != null) const SizedBox(width: 6),
          _buildCompactRoleChip(
            icon: Icons.shield_rounded,
            label: 'SM',
            color: const Color(0xFFFF6D00), // Arancione vivo
            name: project.scrumMaster?.name ?? project.scrumMasterEmail!,
            description: 'Scrum Master - Facilita il processo',
          ),
        ],

        // Dev Team - Verde
        if (project.developmentTeamEmails.isNotEmpty) ...[
          if (project.productOwnerEmail != null || project.scrumMasterEmail != null) const SizedBox(width: 6),
          _buildCompactRoleChip(
            icon: Icons.groups_rounded,
            label: '${project.developmentTeamEmails.length}',
            color: const Color(0xFF43A047), // Verde
            name: project.developmentTeam.map((m) => m.name).join(', '),
            description: 'Development Team - ${project.developmentTeamEmails.length} sviluppatori',
          ),
        ],
      ],
    );
  }

  Widget _buildCompactRoleChip({
    required IconData icon,
    required String label,
    required Color color,
    required String name,
    required String description,
  }) {
    return Tooltip(
      richMessage: TextSpan(
        children: [
          TextSpan(
            text: '$description\n',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          TextSpan(
            text: name,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.4), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Ora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m fa';
    if (diff.inHours < 24) return '${diff.inHours}h fa';
    if (diff.inDays < 7) return '${diff.inDays}g fa';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w fa';
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildRoleAvatar({
    required IconData icon,
    required Color color,
    required String name,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              name.isNotEmpty && name.length > 10
                  ? '${name.substring(0, 10)}...'
                  : (name.isNotEmpty ? name.split(' ').first : '?'),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Icona principale
          const Icon(Icons.rocket_launch_rounded, size: 60, color: Colors.white),
          const SizedBox(height: 32),
          Text(
            'Nessun Progetto Agile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea il tuo primo progetto per iniziare\na gestire sprint, backlog e team.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: context.textSecondaryColor, height: 1.5),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _showCreateProjectDialog,
            icon: const Icon(Icons.add),
            label: const Text('Crea Progetto'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 48),

          // Card guida metodologie
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade500, Colors.teal.shade700],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Non sai quale metodologia scegliere?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Scopri le differenze tra Scrum, Kanban e Hybrid. La guida ti aiutera a scegliere la metodologia piu adatta al tuo team.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => MethodologyGuideDialog.show(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Leggi la Guida', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: context.textMutedColor),
          const SizedBox(height: 16),
          Text(
            'Nessun risultato per "$_searchQuery"',
            style: TextStyle(color: context.textSecondaryColor),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DETTAGLIO PROGETTO
  // ══════════════════════════════════════════════════════════════════════════

  Widget _buildProjectDetail() {
    if (_selectedProject == null) return const SizedBox.shrink();

    return AgileProjectDetailScreen(
      project: _selectedProject!,
      initialIndex: _initialDetailIndex,
      onBack: () {
        setState(() {
          _selectedProject = null;
          _initialDetailIndex = 0; // Reset index on back
        });
        // Aggiorna l'URL del browser al dashboard
        SystemNavigator.routeInformationUpdated(uri: Uri.parse('/agile-process'));
      },
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════

  Widget? _buildFAB() {
    // FAB solo nella lista progetti (il dettaglio ha il suo FAB)
    if (MediaQuery.of(context).size.width < 700) {
      return null;
    }
    return FloatingActionButton.extended(
      onPressed: _showCreateProjectDialog,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(AppLocalizations.of(context)!.agileNewProject, style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primary,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  void _openProjectDetail(AgileProjectModel project, {int initialIndex = 0}) {
    setState(() {
      _selectedProject = project;
      _initialDetailIndex = initialIndex;
    });
    // Aggiorna l'URL del browser con il projectId
    SystemNavigator.routeInformationUpdated(uri: Uri.parse('/agile-process/${project.id}'));
  }

  Future<void> _showCreateProjectDialog() async {
    // Prevent duplicate dialogs from rapid tapping
    if (_isCreating) return;
    _isCreating = true;

    final result = await AgileProjectFormDialog.show(
      context,
      creatorEmail: _currentUserEmail,
      creatorName: _currentUserName,
    );

    if (result != null && mounted) {
      // Validate limits before creating
      final results = await Future.wait([
        _limitsService.canCreateProject(
          _currentUserEmail,
          entityType: 'agile_project',
        ),
        _limitsService.validateServerSide('agile_project'),
      ]);

      final limitCheck = results[0];
      final serverCheck = results[1];

      if (!limitCheck.allowed) {
        if (mounted) {
          LimitReachedDialog.show(
            context: context,
            limitResult: limitCheck,
            entityType: 'agile_project',
          );
        }
        _isCreating = false;
        return;
      }

      if (!serverCheck.allowed) {
        if (mounted) {
          LimitReachedDialog.show(
            context: context,
            limitResult: serverCheck,
            entityType: 'agile_project',
          );
        }
        _isCreating = false;
        return;
      }

      try {
        final project = await _firestoreService.createProject(
          name: result.name,
          description: result.description,
          createdBy: _currentUserEmail,
          createdByName: _currentUserName,
          framework: result.framework,
          sprintDurationDays: result.sprintDurationDays,
          workingHoursPerDay: result.workingHoursPerDay,
          productOwnerEmail: result.productOwnerEmail,
          scrumMasterEmail: result.scrumMasterEmail,
        );

        // Log audit
        await _auditService.logCreate(
          projectId: project.id,
          entityType: AuditEntityType.project,
          entityId: project.id,
          entityName: project.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          description: 'Creato progetto ${project.name}',
        );

        _showSuccess('Progetto "${project.name}" creato con successo!');
      } catch (e) {
        _showError('Errore creazione progetto: $e');
      }
    }

    _isCreating = false;
  }

  void _showProjectMenuAtPosition(BuildContext context, AgileProjectModel project, Offset globalPosition, bool isOwner) async {
    final l10n = AppLocalizations.of(context)!;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      overlay.size.width - globalPosition.dx,
      overlay.size.height - globalPosition.dy,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem(value: 'edit', child: Row(children: [const Icon(Icons.edit, size: 18), const SizedBox(width: 8), Text(l10n.agileEdit)])),
        // Archive/Restore option
        PopupMenuItem(
          value: project.isArchived ? 'restore' : 'archive',
          child: Row(
            children: [
              Icon(
                project.isArchived ? Icons.unarchive : Icons.archive,
                size: 18,
                color: Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(project.isArchived ? l10n.archiveRestoreAction : l10n.archiveAction),
            ],
          ),
        ),
        if (isOwner) PopupMenuItem(value: 'delete', child: Row(children: [const Icon(Icons.delete, size: 18, color: Colors.red), const SizedBox(width: 8), Text(l10n.agileDelete, style: const TextStyle(color: Colors.red))])),
      ],
    );

    if (result != null && mounted) {
      switch (result) {
        case 'edit':
          _showEditProjectDialog(project);
          break;
        case 'team':
          _openProjectDetail(project, initialIndex: 3);
          break;
        case 'archive':
          _archiveProject(project);
          break;
        case 'restore':
          _restoreProject(project);
          break;
        case 'delete':
          _confirmDeleteProject(project);
          break;
      }
    }
  }

  Future<void> _archiveProject(AgileProjectModel project) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await _firestoreService.archiveProject(project.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.archiveSuccessMessage : l10n.archiveErrorMessage),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _restoreProject(AgileProjectModel project) async {
    final l10n = AppLocalizations.of(context)!;
    final success = await _firestoreService.restoreProject(project.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? l10n.archiveRestoreSuccessMessage : l10n.archiveRestoreErrorMessage),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  Future<void> _showEditProjectDialog(AgileProjectModel project) async {
    final result = await AgileProjectFormDialog.show(
      context,
      project: project,
    );

    if (result != null && mounted) {
      try {
          // Aggiorna i ruoli dei partecipanti
          final Map<String, TeamMemberModel> updatedParticipants = Map.from(project.participants);
          
          // Helper per aggiornare ruolo
          void updateRole(String? email, TeamRole newRole) {
            if (email == null) return;
            final normalized = email.toLowerCase();
            if (updatedParticipants.containsKey(normalized)) {
              updatedParticipants[normalized] = updatedParticipants[normalized]!.copyWith(
                teamRole: newRole,
              );
            }
          }

          // 1. Reset vecchi ruoli PO/SM a Developer (se non sono confermati nei nuovi ruoli)
          // Questo evita duplicati di ruoli unici
          for (final key in updatedParticipants.keys) {
            final member = updatedParticipants[key]!;
            if (member.teamRole == TeamRole.productOwner || member.teamRole == TeamRole.scrumMaster || 
                member.teamRole == TeamRole.serviceRequestManager || member.teamRole == TeamRole.serviceDeliveryManager) {
              
              final isNewPO = result.productOwnerEmail?.toLowerCase() == key;
              final isNewSM = result.scrumMasterEmail?.toLowerCase() == key;
              
              if (!isNewPO && !isNewSM) {
                // Ha perso il ruolo, torna developer/member
                updatedParticipants[key] = member.copyWith(teamRole: TeamRole.developer);
              }
            }
          }

          // 2. Assegna nuovi ruoli
          // Nota: PO vince su SM se scelti per la stessa persona (gerarchia permessi)
          final isKanban = result.framework == AgileFramework.kanban;
          final targetPORole = isKanban ? TeamRole.serviceRequestManager : TeamRole.productOwner;
          final targetSMRole = isKanban ? TeamRole.serviceDeliveryManager : TeamRole.scrumMaster;

          if (result.scrumMasterEmail != null) {
            updateRole(result.scrumMasterEmail, targetSMRole);
          }
          if (result.productOwnerEmail != null) {
            updateRole(result.productOwnerEmail, targetPORole);
          }

          // 3. Update Development Team roles
          for (final email in result.developmentTeamEmails) {
            // Ensure they are set as developers (if not accidentally PO/SM, though UI prevents it)
             if (email != result.productOwnerEmail && email != result.scrumMasterEmail) {
                updateRole(email, TeamRole.developer);
             }
          }

        final updatedProject = project.copyWith(
          name: result.name,
          description: result.description,
          framework: result.framework,
          sprintDurationDays: result.sprintDurationDays,
          workingHoursPerDay: result.workingHoursPerDay,
          productOwnerEmail: result.productOwnerEmail,
          scrumMasterEmail: result.scrumMasterEmail,
          developmentTeamEmails: result.developmentTeamEmails,
          participants: updatedParticipants, // Salva mappa aggiornata
          updatedAt: DateTime.now(),
        );

        await _firestoreService.updateProject(updatedProject);

        // Log audit
        await _auditService.logUpdate(
          projectId: project.id,
          entityType: AuditEntityType.project,
          entityId: project.id,
          entityName: result.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
        );

        _showSuccess('Progetto aggiornato con successo!');
      } catch (e) {
        _showError('Errore aggiornamento progetto: $e');
      }
    }
  }

  Future<void> _confirmDeleteProject(AgileProjectModel project) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.agileDeleteProjectTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.agileDeleteProjectConfirm(project.name)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[700]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${l10n.agileDeleteProjectWarning}\n'
                      '• ${l10n.agileDeleteWarningUserStories(project.backlogCount)}\n'
                      '• ${l10n.agileDeleteWarningSprints(project.sprintCount)}\n'
                      '• ${l10n.agileDeleteProjectData}',
                      style: TextStyle(color: Colors.red[700], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.agileDelete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _firestoreService.deleteProject(project.id);

        // Log audit (nel progetto che stiamo eliminando - potrebbe non essere visibile)
        await _auditService.logDelete(
          projectId: project.id,
          entityType: AuditEntityType.project,
          entityId: project.id,
          entityName: project.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
        );

        _showSuccess('Progetto "${project.name}" eliminato.');
      } catch (e) {
        _showError('Errore eliminazione progetto: $e');
      }
    }
  }

  Future<void> _showProjectSettingsDialog(AgileProjectModel project) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ProjectSettingsDialog(project: project),
    );

    if (result != null && mounted) {
      try {
        final updatedProject = project.copyWith(
          productOwnerEmail: result['productOwnerEmail'],
          scrumMasterEmail: result['scrumMasterEmail'],
          developmentTeamEmails: result['developmentTeamEmails'] != null
              ? List<String>.from(result['developmentTeamEmails'])
              : project.developmentTeamEmails,
          updatedAt: DateTime.now(),
        );

        await _firestoreService.updateProject(updatedProject);

        // Log audit
        await _auditService.logUpdate(
          projectId: project.id,
          entityType: AuditEntityType.project,
          entityId: project.id,
          entityName: project.name,
          performedBy: _currentUserEmail,
          performedByName: _currentUserName,
          description: 'Aggiornati ruoli chiave del progetto',
        );

        _showSuccess('Impostazioni salvate con successo!');
      } catch (e) {
        _showError('Errore salvataggio impostazioni: $e');
      }
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // UTILITY
  // ══════════════════════════════════════════════════════════════════════════

  Color _getFrameworkColor(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return Colors.blue;
      case AgileFramework.kanban:
        return Colors.teal;
      case AgileFramework.hybrid:
        return Colors.purple;
    }
  }
}


// ══════════════════════════════════════════════════════════════════════════════
// DIALOG IMPOSTAZIONI PROGETTO (Gestione Ruoli)
// ══════════════════════════════════════════════════════════════════════════════

class _ProjectSettingsDialog extends StatefulWidget {
  final AgileProjectModel project;

  const _ProjectSettingsDialog({required this.project});

  @override
  State<_ProjectSettingsDialog> createState() => _ProjectSettingsDialogState();
}

class _ProjectSettingsDialogState extends State<_ProjectSettingsDialog> {
  String? _productOwnerEmail;
  String? _scrumMasterEmail;
  List<String> _developmentTeamEmails = [];

  @override
  void initState() {
    super.initState();
    _productOwnerEmail = widget.project.productOwnerEmail;
    _scrumMasterEmail = widget.project.scrumMasterEmail;
    _developmentTeamEmails = List.from(widget.project.developmentTeamEmails);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final participants = widget.project.participants.values.toList();
    final isKanban = widget.project.framework == AgileFramework.kanban;

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.settings, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Text(l10n.agileProjectSettingsTitle),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sezione Ruoli Chiave
              _buildSectionHeader(
                icon: Icons.people_alt,
                title: l10n.agileKeyRoles,
                subtitle: l10n.agileKeyRolesSubtitle,
              ),
              const SizedBox(height: 16),

              // Product Owner / Service Request Manager
              _buildRoleCard(
                icon: Icons.account_circle,
                label: isKanban ? l10n.agileRoleSRM : l10n.agileRoleProductOwner,
                color: const Color(0xFF7B1FA2),
                description: isKanban ? l10n.agileRoleSRMDesc : l10n.agileRoleProductOwnerDesc,
                selectedEmail: _productOwnerEmail,
                participants: participants,
                onChanged: (email) => setState(() => _productOwnerEmail = email),
              ),
              const SizedBox(height: 12),

              // Scrum Master / Service Delivery Manager
              _buildRoleCard(
                icon: Icons.supervised_user_circle,
                label: isKanban ? l10n.agileRoleSDM : l10n.agileRoleScrumMaster,
                color: const Color(0xFF1976D2),
                description: isKanban ? l10n.agileRoleSDMDesc : l10n.agileRoleScrumMasterDesc,
                selectedEmail: _scrumMasterEmail,
                participants: participants,
                onChanged: (email) => setState(() => _scrumMasterEmail = email),
              ),
              const SizedBox(height: 12),

              // Development Team
              _buildDevelopmentTeamCard(participants),

              const SizedBox(height: 24),

              // Info box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.agileRolesInfo,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        ElevatedButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save, size: 18),
          label: Text(l10n.actionSave),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: context.textMutedColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required IconData icon,
    required String label,
    required Color color,
    required String description,
    required String? selectedEmail,
    required List<TeamMemberModel> participants,
    required ValueChanged<String?> onChanged,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final selectedMember = selectedEmail != null
        ? participants.where((p) => p.email == selectedEmail).firstOrNull
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: DropdownButton<String?>(
              value: selectedEmail,
              isExpanded: true,
              underline: const SizedBox(),
              hint: Text(
                l10n.agileSelectParticipant,
                style: TextStyle(color: context.textMutedColor),
              ),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Row(
                    children: [
                      Icon(Icons.person_off, color: context.textMutedColor, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        l10n.agileUnassigned,
                        style: TextStyle(
                          color: context.textMutedColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                ...participants.map((p) => DropdownMenuItem<String?>(
                  value: p.email,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: color.withOpacity(0.2),
                        child: Text(
                          p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              p.name,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              p.email,
                              style: TextStyle(
                                fontSize: 11,
                                color: context.textMutedColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
              onChanged: onChanged,
            ),
          ),
          if (selectedMember != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    l10n.agileAssignedTo(selectedMember.name),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDevelopmentTeamCard(List<TeamMemberModel> participants) {
    final teamMembers = _developmentTeamEmails
        .map((email) => participants.where((p) => p.email == email).firstOrNull)
        .whereType<TeamMemberModel>()
        .toList();
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF388E3C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF388E3C).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF388E3C).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.groups, color: Color(0xFF388E3C), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agileRoleDevTeam,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF388E3C),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      l10n.agileRoleDevTeamDesc,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Add member button
              IconButton(
                icon: const Icon(Icons.person_add, color: Color(0xFF388E3C)),
                tooltip: 'Aggiungi membro al team',
                onPressed: () => _showAddTeamMemberDialog(participants),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Team members list
          if (teamMembers.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_add, color: context.textMutedColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    l10n.agileNoDevTeamMembers,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textMutedColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teamMembers.map((member) => Chip(
                avatar: CircleAvatar(
                  backgroundColor: const Color(0xFF388E3C).withOpacity(0.2),
                  child: Text(
                    member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                ),
                label: Text(member.name),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {
                  setState(() {
                    _developmentTeamEmails.remove(member.email);
                  });
                },
              )).toList(),
            ),
        ],
      ),
    );
  }

  void _showAddTeamMemberDialog(List<TeamMemberModel> participants) {
    final l10n = AppLocalizations.of(context)!;
    // Filter out already selected members and PO/SM
    final availableParticipants = participants.where((p) {
      return !_developmentTeamEmails.contains(p.email) &&
          p.email != _productOwnerEmail &&
          p.email != _scrumMasterEmail;
    }).toList();

    if (availableParticipants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.agileAllMembersAssigned),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.agileAddToTeam),
        content: SizedBox(
          width: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableParticipants.length,
            itemBuilder: (context, index) {
              final participant = availableParticipants[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF388E3C).withOpacity(0.2),
                  child: Text(
                    participant.name.isNotEmpty
                        ? participant.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                ),
                title: Text(participant.name),
                subtitle: Text(
                  participant.email,
                  style: TextStyle(fontSize: 12, color: context.textMutedColor),
                ),
                onTap: () {
                  setState(() {
                    _developmentTeamEmails.add(participant.email);
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
             onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.agileClose),
          ),
        ],
      ),
    );
  }

  void _submit() {
    Navigator.of(context).pop({
      'productOwnerEmail': _productOwnerEmail,
      'scrumMasterEmail': _scrumMasterEmail,
      'developmentTeamEmails': _developmentTeamEmails,
    });
  }
}
