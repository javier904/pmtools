import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/admin_service.dart';
import '../../services/auth_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AdminService _adminService = AdminService();
  final AuthService _authService = AuthService();
  
  bool _isLoading = true;
  bool _isAdmin = false;
  List<AdminUserMetrics> _metrics = [];

  // Lista di email fisse da escludere (utenti di test, apple review, admin stessi)
  static const List<String> excludedEmails = [
    'leonardotorella4@gmail.com',
    'leonardo.torella@otconsulting.com',
    'riccardo.barbieri@otconsulting.com',
    'stefano.mazzoni@otconsulting.com',
    'leotps90@gmail.com',
    'gianlucaricaldone@gmail.com',
    'gianluca.ricaldone@otconsulting.com',
    'leo.sfi@hotmail.it',
  ];
  
  // Variabili per l'ordinamento
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _checkAccessAndLoad();
  }

  Future<void> _checkAccessAndLoad() async {
    final user = _authService.currentUser;
    if (user?.email?.toLowerCase() == 'leonardotorella4@gmail.com') {
      setState(() => _isAdmin = true);
      await _loadData();
    } else {
      if (mounted) {
        setState(() {
          _isAdmin = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await _adminService.getAllUsersMetrics();
      
      // Ordina per ultimo login decrescente
      data.sort((a, b) {
        final dateA = a.profile.lastLoginAt ?? a.profile.createdAt;
        final dateB = b.profile.lastLoginAt ?? b.profile.createdAt;
        return dateB.compareTo(dateA);
      });
      
      if (mounted) {
        setState(() {
          _metrics = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Errore caricamento admin metrics: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _sort<T>(Comparable<T> Function(AdminUserMetrics m) getField, int columnIndex, bool ascending) {
    _metrics.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Accesso Negato')),
        body: const Center(child: Text('Solo gli amministratori possono accedere a questa pagina.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard - Utenti'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Ricarica',
            onPressed: _loadData,
          ),
          IconButton(
            icon: const Icon(Icons.forum_outlined),
            tooltip: 'Mostra Feedback Ricevuti',
            onPressed: () => Navigator.pushNamed(context, '/feedback-dashboard'),
          ),
        ],
      ),
      body: SelectionArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildExcludedInfo(context),
            _buildGlobalStatsCards(context),
            const Divider(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              columns: [
                const DataColumn(label: Text('Utente / Email')),
                const DataColumn(label: Text('Status')),
                DataColumn(
                  label: const Text('Data Reg.'),
                  onSort: (columnIndex, ascending) => _sort<num>(
                      (m) => m.profile.createdAt.millisecondsSinceEpoch,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Ultimo Login'),
                  onSort: (columnIndex, ascending) => _sort<num>(
                      (m) => (m.profile.lastLoginAt ?? m.profile.createdAt).millisecondsSinceEpoch,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Logins'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>(
                      (m) => m.loginCount,
                      columnIndex,
                      ascending),
                ),
                DataColumn(
                  label: const Text('Rating'),
                  numeric: true,
                  onSort: (columnIndex, ascending) => _sort<num>(
                      (m) => m.feedbackRating ?? -1,
                      columnIndex,
                      ascending),
                ),
                const DataColumn(label: Text('Commento')),
              ],
              rows: _metrics.map((m) {
                final lastLogin = m.profile.lastLoginAt;
                final loginDateStr = lastLogin != null 
                    ? DateFormat('dd/MM/yyyy HH:mm').format(lastLogin)
                    : 'Mai';

                return DataRow(
                  cells: [
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(m.profile.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(m.profile.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    DataCell(Text(m.profile.status.displayName)),
                    DataCell(Text(DateFormat('dd/MM/yyyy').format(m.profile.createdAt))),
                    DataCell(Text(loginDateStr)),
                    DataCell(Text(m.loginCount.toString())),
                    DataCell(
                      m.feedbackRating != null 
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${m.feedbackRating}'),
                                const SizedBox(width: 4),
                                const Icon(Icons.star, size: 14, color: Colors.amber),
                              ],
                            )
                          : const Text('-'),
                    ),
                    DataCell(
                      SizedBox(
                        width: 300,
                        child: Text(
                          m.feedbackComment ?? '-',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
             ),
            ),
           ),
          ),
         ),
        ],
       ),
      ),
    );
  }

  Widget _buildExcludedInfo(BuildContext context) {
    if (excludedEmails.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Tooltip(
        message: 'Utenti esclusi dalle statistiche: ${excludedEmails.join(', ')}',
        textStyle: const TextStyle(fontSize: 12, color: Colors.white),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.info_outline, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text('Info Esclusioni', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildGlobalStatsCards(BuildContext context) {
    if (_metrics.isEmpty) return const SizedBox.shrink();

    final totalUsers = _metrics.length;
    
    // Utenti reali = Utenti totali - Utenti esclusi (blacklist)
    final realMetrics = _metrics.where((m) => !excludedEmails.contains(m.profile.email.toLowerCase())).toList();
    final realUsersCount = realMetrics.length;

    final returningUsers = realMetrics.where((m) {
      if (m.loginCount > 1) return true;
      if (m.profile.lastLoginAt != null) {
        return m.profile.lastLoginAt!.difference(m.profile.createdAt).inHours >= 24;
      }
      return false;
    }).length;

    final retentionRate = realUsersCount > 0 ? (returningUsers / realUsersCount * 100).toStringAsFixed(1) : '0.0';

    final now = DateTime.now();
    final activeLast7Days = realMetrics.where((m) {
      if (m.profile.lastLoginAt == null) return false;
      return now.difference(m.profile.lastLoginAt!).inDays <= 7;
    }).length;

    final ratings = realMetrics.where((m) => m.feedbackRating != null).map((m) => m.feedbackRating!).toList();
    final averageRating = ratings.isNotEmpty 
        ? (ratings.reduce((a, b) => a + b) / ratings.length).toStringAsFixed(1) 
        : 'N/A';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildStatCard(
            title: 'Utenti Totali',
            value: totalUsers.toString(),
            icon: Icons.people_outline,
            color: Colors.blueGrey,
            tooltip: 'Numero netto totale di utenti iscritti, inclusi gli account di test.',
          ),
          _buildStatCard(
            title: 'Utenti Reali',
            value: realUsersCount.toString(),
            icon: Icons.people,
            color: Colors.blue,
            tooltip: 'Numero totale di utenti reali (totali meno gli account in blacklist/test). Tutte le statistiche seguenti si basano solo su questi.',
          ),
          _buildStatCard(
            title: 'Tasso di Ritorno',
            value: '$retentionRate%',
            icon: Icons.replay,
            color: Colors.green,
            subtitle: '$returningUsers su $realUsersCount tornati',
            tooltip: 'Percentuale (calcolata sugli utenti reali) che ha effettuato più di un login o che è rientrata a distanza di 24h.',
          ),
          _buildStatCard(
            title: 'Attivi (Ultimi 7gg)',
            value: activeLast7Days.toString(),
            icon: Icons.local_fire_department_outlined,
            color: Colors.orange,
            tooltip: 'Utenti reali che appaiono aver effettuato un login negli ultimi 7 giorni solari.',
          ),
          _buildStatCard(
            title: 'Rating Medio',
            value: averageRating,
            icon: Icons.star_outline,
            color: Colors.amber,
            tooltip: 'Media puramente aritmetica tra tutti i voti in-app lasciati dagli utenti reali.',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    String? subtitle,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 10),
      child: Container(
        width: 125,
        height: 75,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color.withValues(alpha: 0.8)),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 8, color: color.withValues(alpha: 0.6)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ] else const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
