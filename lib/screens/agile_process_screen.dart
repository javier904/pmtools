import 'package:flutter/material.dart';
import '../models/agile_project_model.dart';
import '../models/agile_enums.dart';
import '../models/team_member_model.dart';
import '../services/agile_firestore_service.dart';
import '../services/agile_audit_service.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../widgets/agile/methodology_guide_dialog.dart';
import '../themes/app_colors.dart';
import 'agile_project_detail_screen.dart';
import '../widgets/home/favorite_star.dart';
import '../l10n/app_localizations.dart';

/// Screen principale per la gestione dei Progetti Agile
///
/// Implementa:
/// - Lista dei progetti dell'utente
/// - Creazione/modifica/eliminazione progetti
/// - Navigazione al dettaglio progetto
class AgileProcessScreen extends StatefulWidget {
  const AgileProcessScreen({super.key});

  @override
  State<AgileProcessScreen> createState() => _AgileProcessScreenState();
}

class _AgileProcessScreenState extends State<AgileProcessScreen> {
  final AgileFirestoreService _firestoreService = AgileFirestoreService();
  final AgileAuditService _auditService = AgileAuditService();
  final AuthService _authService = AuthService();
  
  bool _hasCheckedArgs = false;

  // Stato
  AgileProjectModel? _selectedProject;
  String _searchQuery = '';
  bool _showArchived = false;

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
      _hasCheckedArgs = true;
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
            const Text(
              'Agile Process Manager',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Toggle archivio
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
            ),
            selectedColor: AppColors.warning.withValues(alpha: 0.2),
            showCheckmark: false,
          ),
          const SizedBox(width: 16),
          // Pulsante guida metodologie - piu visibile
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
                'Guida Metodologie',
                style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(width: 8),
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

        if (projects.isEmpty) {
          return _buildEmptyState();
        }

        // Filtra per ricerca
        final filteredProjects = _searchQuery.isEmpty
            ? projects
            : projects.where((p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.description.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Barra di ricerca
              _buildSearchBar(),
              const SizedBox(height: 16),
              // Lista progetti
              Expanded(
                child: filteredProjects.isEmpty
                    ? _buildNoResultsState()
                    : _buildProjectGrid(filteredProjects),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cerca progetti...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => _searchQuery = ''),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: context.surfaceVariantColor,
      ),
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildProjectGrid(List<AgileProjectModel> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : constraints.maxWidth > 500
                    ? 2
                    : 1;

        // Card molto più compatte - circa 50% della dimensione originale
        final compactCrossAxisCount = constraints.maxWidth > 1400
            ? 6
            : constraints.maxWidth > 1100
                ? 5
                : constraints.maxWidth > 800
                    ? 4
                    : constraints.maxWidth > 550
                        ? 3
                        : constraints.maxWidth > 350
                            ? 2
                            : 1;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: compactCrossAxisCount,
            childAspectRatio: 1.25, // Card più larghe che alte = più compatte
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
    final isOwner = project.isOwner(_currentUserEmail);
    final canManage = project.canManage(_currentUserEmail);
    final frameworkColor = _getFrameworkColor(project.framework);

    // Calcola progress (completedSprintCount / sprintCount o 0)
    final progressPercent = project.sprintCount > 0
        ? (project.completedSprintCount / project.sprintCount * 100).round()
        : 0;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => setState(() => _selectedProject = project),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Framework badge + menu
              Row(
                children: [
                  // Badge framework compatto
                  Tooltip(
                    message: 'Metodologia: ${project.framework.displayName}',
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: frameworkColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(project.framework.icon, size: 12, color: frameworkColor),
                          const SizedBox(width: 3),
                          Text(
                            project.framework.displayName,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: frameworkColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
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
                  // Sprint attivo badge
                  if (project.hasActiveSprint && !project.isArchived)
                    Tooltip(
                      message: 'Sprint in corso',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 3),
                            const Text(
                              'ATTIVO',
                              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                  FavoriteStar(
                    resourceId: project.id,
                    type: 'agile_project',
                    title: project.name,
                    colorHex: '#9C27B0', // Purple for Agile
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
                        child: Icon(Icons.more_vert, size: 18, color: context.textSecondaryColor),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),

              // Titolo progetto
              Text(
                project.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // Descrizione (se presente)
              if (project.description.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  project.description,
                  style: TextStyle(fontSize: 10, color: context.textMutedColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],

              const SizedBox(height: 8),

              // Key Roles Row con colori distintivi
              _buildCompactRolesRow(project),

              const Spacer(),

              // Progress bar (se ci sono sprint)
              if (project.sprintCount > 0) ...[
                Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: 'Avanzamento: ${project.completedSprintCount}/${project.sprintCount} sprint completati',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: project.sprintCount > 0 ? project.completedSprintCount / project.sprintCount : 0,
                            backgroundColor: context.surfaceVariantColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressPercent >= 80 ? Colors.green : progressPercent >= 50 ? Colors.orange : Colors.blue,
                            ),
                            minHeight: 4,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$progressPercent%',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: context.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],

              // Stats row compatto con tooltip
              Row(
                children: [
                  _buildCompactStat(Icons.people_outline, '${project.participantCount}', 'Membri del team'),
                  const SizedBox(width: 6),
                  _buildCompactStat(Icons.assignment_outlined, '${project.backlogCount}', 'User Stories nel backlog'),
                  if (project.sprintCount > 0) ...[
                    const SizedBox(width: 6),
                    _buildCompactStat(Icons.replay, '${project.sprintCount}', 'Sprint totali'),
                  ],
                  if (project.averageVelocity != null) ...[
                    const SizedBox(width: 6),
                    _buildCompactStat(Icons.speed, project.averageVelocity!.toStringAsFixed(0), 'Velocity media'),
                  ],
                ],
              ),

              const SizedBox(height: 4),

              // Data ultimo aggiornamento
              Row(
                children: [
                  Icon(Icons.update, size: 10, color: context.textMutedColor),
                  const SizedBox(width: 3),
                  Text(
                    _formatTimeAgo(project.updatedAt),
                    style: TextStyle(fontSize: 9, color: context.textMutedColor),
                  ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: context.surfaceVariantColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 11, color: context.textSecondaryColor),
            const SizedBox(width: 2),
            Text(
              value,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: context.textPrimaryColor),
            ),
          ],
        ),
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
      onBack: () => setState(() => _selectedProject = null),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // FAB
  // ══════════════════════════════════════════════════════════════════════════

  Widget? _buildFAB() {
    // FAB solo nella lista progetti (il dettaglio ha il suo FAB)
    return FloatingActionButton.extended(
      onPressed: _showCreateProjectDialog,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Nuovo Progetto', style: TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primary,
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _showCreateProjectDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ProjectFormDialog(
        creatorEmail: _currentUserEmail,
        creatorName: _currentUserName,
      ),
    );

    if (result != null && mounted) {
      try {
        final project = await _firestoreService.createProject(
          name: result['name'],
          description: result['description'] ?? '',
          createdBy: _currentUserEmail,
          createdByName: _currentUserName,
          framework: result['framework'] ?? AgileFramework.scrum,
          sprintDurationDays: result['sprintDurationDays'] ?? 14,
          workingHoursPerDay: result['workingHoursPerDay'] ?? 8,
          productOwnerEmail: result['productOwnerEmail'],
          scrumMasterEmail: result['scrumMasterEmail'],
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
        const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Modifica')])),
        const PopupMenuItem(value: 'settings', child: Row(children: [Icon(Icons.settings, size: 18), SizedBox(width: 8), Text('Impostazioni')])),
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
        if (isOwner) const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 18, color: Colors.red), SizedBox(width: 8), Text('Elimina', style: TextStyle(color: Colors.red))])),
      ],
    );

    if (result != null && mounted) {
      switch (result) {
        case 'edit':
          _showEditProjectDialog(project);
          break;
        case 'settings':
          _showProjectSettingsDialog(project);
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
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ProjectFormDialog(project: project),
    );

    if (result != null && mounted) {
      try {
        final updatedProject = project.copyWith(
          name: result['name'],
          description: result['description'],
          framework: result['framework'],
          sprintDurationDays: result['sprintDurationDays'],
          workingHoursPerDay: result['workingHoursPerDay'],
          productOwnerEmail: result['productOwnerEmail'],
          scrumMasterEmail: result['scrumMasterEmail'],
          updatedAt: DateTime.now(),
        );

        await _firestoreService.updateProject(updatedProject);

        // Log audit
        await _auditService.logUpdate(
          projectId: project.id,
          entityType: AuditEntityType.project,
          entityId: project.id,
          entityName: result['name'],
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Progetto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sei sicuro di voler eliminare "${project.name}"?'),
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
                      'Questa azione eliminerà permanentemente:\n'
                      '• ${project.backlogCount} user stories\n'
                      '• ${project.sprintCount} sprint\n'
                      '• Tutti i dati del progetto',
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
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Elimina'),
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
// DIALOG FORM PROGETTO
// ══════════════════════════════════════════════════════════════════════════════

class _ProjectFormDialog extends StatefulWidget {
  final AgileProjectModel? project;
  final String? creatorEmail;
  final String? creatorName;

  const _ProjectFormDialog({
    this.project,
    this.creatorEmail,
    this.creatorName,
  });

  @override
  State<_ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<_ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late AgileFramework _framework;
  late int _sprintDurationDays;
  late int _workingHoursPerDay;

  // Key Roles
  String? _productOwnerEmail;
  String? _scrumMasterEmail;

  bool get isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');
    _framework = widget.project?.framework ?? AgileFramework.scrum;
    _sprintDurationDays = widget.project?.sprintDurationDays ?? 14;
    _workingHoursPerDay = widget.project?.workingHoursPerDay ?? 8;
    _productOwnerEmail = widget.project?.productOwnerEmail;
    _scrumMasterEmail = widget.project?.scrumMasterEmail;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Modifica Progetto' : 'Nuovo Progetto Agile'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Progetto *',
                    hintText: 'Es: Fashion PMO v2',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.folder),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Inserisci il nome del progetto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Descrizione
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrizione',
                    hintText: 'Descrizione opzionale del progetto',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // Framework
                Row(
                  children: [
                    Text(
                      'Framework Agile',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => MethodologyGuideDialog.show(context, framework: _framework),
                      icon: const Icon(Icons.help_outline, size: 16),
                      label: const Text('Scopri le differenze'),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildFrameworkSelector(),
                const SizedBox(height: 24),

                // Configurazione Sprint
                Text(
                  'Configurazione Sprint',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: context.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildNumberField(
                        label: 'Durata Sprint (giorni)',
                        value: _sprintDurationDays,
                        min: 7,
                        max: 30,
                        onChanged: (v) => setState(() => _sprintDurationDays = v),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildNumberField(
                        label: 'Ore/Giorno',
                        value: _workingHoursPerDay,
                        min: 4,
                        max: 12,
                        onChanged: (v) => setState(() => _workingHoursPerDay = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Key Roles Section
                _buildKeyRolesSection(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        ElevatedButton.icon(
          onPressed: _submit,
          icon: Icon(isEditing ? Icons.save : Icons.add),
          label: Text(isEditing ? 'Salva' : 'Crea'),
        ),
      ],
    );
  }

  Widget _buildFrameworkSelector() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: AgileFramework.values.map((framework) {
          final isSelected = _framework == framework;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Tooltip(
                message: framework.detailedDescription,
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  height: 1.4,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.isDarkMode ? context.surfaceColor : Colors.grey[850],
                  borderRadius: BorderRadius.circular(8),
                ),
                waitDuration: const Duration(milliseconds: 500),
                child: InkWell(
                  onTap: () => setState(() => _framework = framework),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _getFrameworkColor(framework).withValues(alpha: 0.1)
                          : context.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? _getFrameworkColor(framework)
                            : context.borderColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          framework.icon,
                          color: isSelected
                              ? _getFrameworkColor(framework)
                              : context.textSecondaryColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          framework.displayName,
                          style: TextStyle(
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? _getFrameworkColor(framework)
                                : context.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          framework.description,
                          style: TextStyle(
                            fontSize: 10,
                            color: context.textTertiaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: value > min ? () => onChanged(value - 1) : null,
                iconSize: 18,
              ),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: value < max ? () => onChanged(value + 1) : null,
                iconSize: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyRolesSection() {
    // Get participants for dropdown
    List<TeamMemberModel> participants;

    if (widget.project != null) {
      // Editing existing project - use actual participants
      participants = widget.project!.participants.values.toList();
    } else if (widget.creatorEmail != null && widget.creatorName != null) {
      // Creating new project - allow creator to assign themselves
      participants = [
        TeamMemberModel(
          email: widget.creatorEmail!,
          name: widget.creatorName!,
          participantRole: AgileParticipantRole.owner,
          teamRole: TeamRole.productOwner,
          joinedAt: DateTime.now(),
        ),
      ];
    } else {
      participants = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ruoli Chiave',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: 'Assegna i ruoli principali del team.\nPotrai modificarli anche dalle impostazioni del progetto.',
              child: Icon(
                Icons.info_outline,
                size: 16,
                color: context.textMutedColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Product Owner
        _buildRoleSelector(
          icon: Icons.account_circle,
          label: 'Product Owner',
          color: const Color(0xFF7B1FA2),
          description: 'Gestisce il backlog e le priorita',
          selectedEmail: _productOwnerEmail,
          participants: participants,
          onChanged: (email) => setState(() => _productOwnerEmail = email),
        ),
        const SizedBox(height: 12),

        // Scrum Master
        _buildRoleSelector(
          icon: Icons.supervised_user_circle,
          label: 'Scrum Master',
          color: const Color(0xFF1976D2),
          description: 'Facilita il processo e rimuove ostacoli',
          selectedEmail: _scrumMasterEmail,
          participants: participants,
          onChanged: (email) => setState(() => _scrumMasterEmail = email),
        ),
      ],
    );
  }

  Widget _buildRoleSelector({
    required IconData icon,
    required String label,
    required Color color,
    required String description,
    required String? selectedEmail,
    required List<TeamMemberModel> participants,
    required ValueChanged<String?> onChanged,
  }) {
    final selectedMember = selectedEmail != null
        ? participants.where((p) => p.email == selectedEmail).firstOrNull
        : null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Role Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),

          // Role Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
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

          // Selector
          if (participants.isNotEmpty)
            // Dropdown for existing project
            DropdownButton<String?>(
              value: selectedEmail,
              hint: Text(
                'Seleziona',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textMutedColor,
                ),
              ),
              underline: const SizedBox(),
              icon: Icon(Icons.arrow_drop_down, color: color),
              items: [
                DropdownMenuItem<String?>(
                  value: null,
                  child: Text(
                    'Non assegnato',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textMutedColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                ...participants.map((p) => DropdownMenuItem<String?>(
                  value: p.email,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: color.withOpacity(0.2),
                        child: Text(
                          p.name.isNotEmpty ? p.name[0].toUpperCase() : '?',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        p.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                )),
              ],
              onChanged: onChanged,
            )
          else
            // Info for new project
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.surfaceVariantColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 14,
                    color: context.textMutedColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Assegnabile dopo la creazione',
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
    );
  }

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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'framework': _framework,
        'sprintDurationDays': _sprintDurationDays,
        'workingHoursPerDay': _workingHoursPerDay,
        'productOwnerEmail': _productOwnerEmail,
        'scrumMasterEmail': _scrumMasterEmail,
      });
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
    final participants = widget.project.participants.values.toList();

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.settings, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          const Text('Impostazioni Progetto'),
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
                title: 'Ruoli Chiave',
                subtitle: 'Assegna i ruoli principali del team Scrum',
              ),
              const SizedBox(height: 16),

              // Product Owner
              _buildRoleCard(
                icon: Icons.account_circle,
                label: 'Product Owner',
                color: const Color(0xFF7B1FA2),
                description: 'Gestisce il backlog e definisce le priorità del prodotto',
                selectedEmail: _productOwnerEmail,
                participants: participants,
                onChanged: (email) => setState(() => _productOwnerEmail = email),
              ),
              const SizedBox(height: 12),

              // Scrum Master
              _buildRoleCard(
                icon: Icons.supervised_user_circle,
                label: 'Scrum Master',
                color: const Color(0xFF1976D2),
                description: 'Facilita il processo Scrum e rimuove gli ostacoli',
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
                        'I ruoli verranno mostrati con icone dedicate nella lista progetti. '
                        'Puoi aggiungere altri partecipanti dal Team del progetto.',
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
          child: const Text('Annulla'),
        ),
        ElevatedButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save, size: 18),
          label: const Text('Salva'),
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
                'Seleziona partecipante',
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
                        'Non assegnato',
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
                    'Assegnato a ${selectedMember.name}',
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
                    const Text(
                      'Development Team',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF388E3C),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'I membri che sviluppano il prodotto',
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
                    'Nessun membro nel team. Clicca + per aggiungere.',
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
    // Filter out already selected members and PO/SM
    final availableParticipants = participants.where((p) {
      return !_developmentTeamEmails.contains(p.email) &&
          p.email != _productOwnerEmail &&
          p.email != _scrumMasterEmail;
    }).toList();

    if (availableParticipants.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tutti i partecipanti sono già assegnati a un ruolo.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aggiungi al Team'),
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
            child: const Text('Chiudi'),
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
