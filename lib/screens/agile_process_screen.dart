import 'package:flutter/material.dart';
import '../models/agile_project_model.dart';
import '../models/agile_enums.dart';
import '../services/agile_firestore_service.dart';
import '../services/agile_audit_service.dart';
import '../services/auth_service.dart';
import '../widgets/agile/methodology_guide_dialog.dart';
import 'agile_project_detail_screen.dart';

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

  // Stato
  AgileProjectModel? _selectedProject;
  String _searchQuery = '';

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
  Widget build(BuildContext context) {
    // Se c'è un progetto selezionato, mostra solo il dettaglio (ha il suo Scaffold)
    if (_selectedProject != null) {
      return _buildProjectDetail();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.grey.shade800,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade500, Colors.purple.shade700],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.speed_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text(
              'Agile Process Manager',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
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
      stream: _firestoreService.streamUserProjects(_currentUserEmail),
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
        ),
        filled: true,
        fillColor: Colors.grey[100],
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

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
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

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => setState(() => _selectedProject = project),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con framework e menu
              Row(
                children: [
                  // Badge framework
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getFrameworkColor(project.framework).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          project.framework.icon,
                          size: 14,
                          color: _getFrameworkColor(project.framework),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          project.framework.displayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _getFrameworkColor(project.framework),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Menu opzioni
                  if (canManage)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Modifica'),
                            dense: true,
                          ),
                        ),
                        if (isOwner)
                          const PopupMenuItem(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete, color: Colors.red),
                              title: Text('Elimina', style: TextStyle(color: Colors.red)),
                              dense: true,
                            ),
                          ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showEditProjectDialog(project);
                        } else if (value == 'delete') {
                          _confirmDeleteProject(project);
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 12),
              // Titolo
              Text(
                project.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (project.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  project.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const Spacer(),
              // Stats
              Row(
                children: [
                  // Partecipanti
                  _buildStatChip(
                    Icons.people,
                    '${project.participantCount}',
                    'Membri',
                  ),
                  const SizedBox(width: 8),
                  // Backlog
                  _buildStatChip(
                    Icons.list_alt,
                    '${project.backlogCount}',
                    'Stories',
                  ),
                  const SizedBox(width: 8),
                  // Sprint
                  if (project.sprintCount > 0)
                    _buildStatChip(
                      Icons.loop,
                      '${project.sprintCount}',
                      'Sprint',
                    ),
                ],
              ),
              const SizedBox(height: 8),
              // Velocity e stato sprint
              Row(
                children: [
                  if (project.averageVelocity != null) ...[
                    Icon(Icons.speed, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Velocity: ${project.averageVelocity!.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                  const Spacer(),
                  if (project.hasActiveSprint)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Sprint Attivo',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
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
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade400, Colors.purple.shade600],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.speed_rounded, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 32),
          Text(
            'Nessun Progetto Agile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea il tuo primo progetto per iniziare\na gestire sprint, backlog e team.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
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
          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Nessun risultato per "$_searchQuery"',
            style: TextStyle(color: Colors.grey[600]),
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
      icon: const Icon(Icons.add),
      label: const Text('Nuovo Progetto'),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  // DIALOGS
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> _showCreateProjectDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _ProjectFormDialog(),
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

  const _ProjectFormDialog({this.project});

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
                        color: Colors.grey[700],
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
                    color: Colors.grey[700],
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
    return Row(
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
                color: Colors.grey[850],
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
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? _getFrameworkColor(framework)
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        framework.icon,
                        color: isSelected
                            ? _getFrameworkColor(framework)
                            : Colors.grey[600],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        framework.displayName,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? _getFrameworkColor(framework)
                              : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        framework.description,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[500],
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
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
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
      });
    }
  }
}
