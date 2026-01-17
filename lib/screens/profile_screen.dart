import 'package:flutter/material.dart';
import '../models/user_profile/user_profile_model.dart';
import '../models/user_profile/subscription_model.dart';
import '../models/user_profile/user_settings_model.dart';
import '../services/user_profile_service.dart';
import '../services/auth_service.dart';

/// Schermata profilo utente completa
///
/// Sezioni:
/// - Profilo personale
/// - Abbonamento
/// - Impostazioni
/// - Richiesta cancellazione account
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileService _profileService = UserProfileService();
  final AuthService _authService = AuthService();

  UserProfileModel? _profile;
  SubscriptionModel? _subscription;
  UserSettingsModel? _settings;
  bool _isLoading = true;
  String? _error;

  // Form controllers per modifica profilo
  final _displayNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _jobTitleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _profileService.getAllUserData();
      setState(() {
        _profile = data.profile;
        _subscription = data.subscription;
        _settings = data.settings;
        _isLoading = false;
      });

      // Popola i controller
      if (_profile != null) {
        _displayNameController.text = _profile!.displayName ?? '';
        _firstNameController.text = _profile!.firstName ?? '';
        _lastNameController.text = _profile!.lastName ?? '';
        _companyController.text = _profile!.company ?? '';
        _jobTitleController.text = _profile!.jobTitle ?? '';
        _bioController.text = _profile!.bio ?? '';
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUserData,
            tooltip: 'Ricarica',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                      const SizedBox(height: 16),
                      Text('Errore: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadUserData,
                        child: const Text('Riprova'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header profilo
                          _buildProfileHeader(theme, isDark),
                          const SizedBox(height: 24),

                          // Sezione Profilo Personale
                          _buildProfileSection(theme, isDark),
                          const SizedBox(height: 16),

                          // Sezione Abbonamento
                          _buildSubscriptionSection(theme, isDark),
                          const SizedBox(height: 16),

                          // Sezione Impostazioni
                          _buildSettingsSection(theme, isDark),
                          const SizedBox(height: 16),

                          // Sezione Feature Flags
                          _buildFeatureFlagsSection(theme, isDark),
                          const SizedBox(height: 16),

                          // Sezione Notifiche
                          _buildNotificationsSection(theme, isDark),
                          const SizedBox(height: 16),

                          // Sezione Cancellazione Account
                          _buildDangerZoneSection(theme, isDark),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme, bool isDark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 48,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              backgroundImage: _profile?.photoUrl != null
                  ? NetworkImage(_profile!.photoUrl!)
                  : null,
              child: _profile?.photoUrl == null
                  ? Text(
                      _profile?.initials ?? '?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 24),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _profile?.fullName ?? 'Utente',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _profile?.email ?? '',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  if (_profile?.company != null || _profile?.jobTitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      [_profile?.jobTitle, _profile?.company]
                          .where((s) => s != null)
                          .join(' @ '),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.grey[500] : Colors.grey[700],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Badge abbonamento
            if (_subscription != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _subscription!.plan.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _subscription!.plan.color),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _subscription!.plan.icon,
                      size: 16,
                      color: _subscription!.plan.color,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _subscription!.plan.displayName,
                      style: TextStyle(
                        color: _subscription!.plan.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(ThemeData theme, bool isDark) {
    return _buildExpandableSection(
      title: 'Informazioni Personali',
      icon: Icons.person_outline,
      initiallyExpanded: true,
      children: [
        _buildTextField(
          controller: _displayNameController,
          label: 'Nome visualizzato',
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _firstNameController,
                label: 'Nome',
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _lastNameController,
                label: 'Cognome',
                icon: Icons.person_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _companyController,
                label: 'Azienda',
                icon: Icons.business_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _jobTitleController,
                label: 'Ruolo',
                icon: Icons.work_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _bioController,
          label: 'Bio',
          icon: Icons.description_outlined,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // Reset ai valori originali
                _displayNameController.text = _profile?.displayName ?? '';
                _firstNameController.text = _profile?.firstName ?? '';
                _lastNameController.text = _profile?.lastName ?? '';
                _companyController.text = _profile?.company ?? '';
                _jobTitleController.text = _profile?.jobTitle ?? '';
                _bioController.text = _profile?.bio ?? '';
              },
              child: const Text('Annulla'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: _saveProfile,
              icon: const Icon(Icons.save, size: 18),
              label: const Text('Salva'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscriptionSection(ThemeData theme, bool isDark) {
    if (_subscription == null) return const SizedBox.shrink();

    return _buildExpandableSection(
      title: 'Abbonamento',
      icon: Icons.card_membership_outlined,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _subscription!.status.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _subscription!.status.displayName,
          style: TextStyle(
            color: _subscription!.status.color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      children: [
        // Info abbonamento attuale
        _buildInfoRow(
          'Piano',
          _subscription!.plan.displayName,
          icon: _subscription!.plan.icon,
          iconColor: _subscription!.plan.color,
        ),
        _buildInfoRow(
          'Ciclo di fatturazione',
          _subscription!.billingCycle.displayName,
        ),
        _buildInfoRow(
          'Prezzo',
          _subscription!.formattedPrice,
        ),
        _buildInfoRow(
          'Data attivazione',
          _formatDate(_subscription!.startDate),
        ),
        if (_subscription!.endDate != null)
          _buildInfoRow(
            _subscription!.status == SubscriptionStatus.trialing
                ? 'Fine periodo di prova'
                : 'Prossimo rinnovo',
            _formatDate(_subscription!.endDate!),
          ),
        if (_subscription!.daysRemaining != null && _subscription!.daysRemaining! > 0)
          _buildInfoRow(
            'Giorni rimanenti',
            '${_subscription!.daysRemaining}',
            valueColor: _subscription!.daysRemaining! <= 7 ? Colors.orange : null,
          ),
        const Divider(height: 24),

        // Pulsanti azioni
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_subscription!.plan != SubscriptionPlan.enterprise)
              TextButton.icon(
                onPressed: _showUpgradeDialog,
                icon: const Icon(Icons.upgrade),
                label: const Text('Upgrade'),
              ),
            if (_subscription!.isActive && _subscription!.plan != SubscriptionPlan.free)
              TextButton.icon(
                onPressed: _showCancelSubscriptionDialog,
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Annulla'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    return _buildExpandableSection(
      title: 'Impostazioni Generali',
      icon: Icons.settings_outlined,
      children: [
        // Tema
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            _settings!.themeMode == ThemePreference.dark
                ? Icons.dark_mode
                : _settings!.themeMode == ThemePreference.light
                    ? Icons.light_mode
                    : Icons.brightness_auto,
          ),
          title: const Text('Tema'),
          subtitle: Text(_settings!.themeMode.displayName),
          trailing: SegmentedButton<ThemePreference>(
            segments: ThemePreference.values
                .map((t) => ButtonSegment(
                      value: t,
                      icon: Icon(
                        t == ThemePreference.dark
                            ? Icons.dark_mode
                            : t == ThemePreference.light
                                ? Icons.light_mode
                                : Icons.brightness_auto,
                        size: 18,
                      ),
                    ))
                .toList(),
            selected: {_settings!.themeMode},
            onSelectionChanged: (selected) {
              _updateTheme(selected.first);
            },
          ),
        ),
        const Divider(),

        // Lingua
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.language),
          title: const Text('Lingua'),
          subtitle: Text(_settings!.locale == 'it' ? 'Italiano' : 'English'),
          trailing: DropdownButton<String>(
            value: _settings!.locale,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(value: 'it', child: Text('Italiano')),
              DropdownMenuItem(value: 'en', child: Text('English')),
            ],
            onChanged: (value) {
              if (value != null) _updateLocale(value);
            },
          ),
        ),
        const Divider(),

        // Animazioni
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.animation),
          title: const Text('Animazioni'),
          subtitle: const Text('Abilita animazioni UI'),
          value: _settings!.enableAnimations,
          onChanged: _updateAnimations,
        ),
      ],
    );
  }

  Widget _buildFeatureFlagsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    final flags = _settings!.featureFlags;

    return _buildExpandableSection(
      title: 'Funzionalità',
      icon: Icons.extension_outlined,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.calendar_today),
          title: const Text('Integrazione Calendario'),
          subtitle: const Text('Sincronizza sprint e scadenze'),
          value: flags.calendarIntegration,
          onChanged: (v) => _toggleFeatureFlag('calendarIntegration', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.table_chart),
          title: const Text('Export Google Sheets'),
          subtitle: const Text('Esporta dati in fogli di calcolo'),
          value: flags.googleSheetsExport,
          onChanged: (v) => _toggleFeatureFlag('googleSheetsExport', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.science),
          title: const Text('Funzionalità Beta'),
          subtitle: const Text('Accesso anticipato a nuove funzionalità'),
          value: flags.betaFeatures,
          onChanged: (v) => _toggleFeatureFlag('betaFeatures', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.analytics),
          title: const Text('Metriche Avanzate'),
          subtitle: const Text('Statistiche e report dettagliati'),
          value: flags.advancedMetrics,
          onChanged: (v) => _toggleFeatureFlag('advancedMetrics', v),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    final notifications = _settings!.notifications;

    return _buildExpandableSection(
      title: 'Notifiche',
      icon: Icons.notifications_outlined,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.email_outlined),
          title: const Text('Notifiche Email'),
          subtitle: const Text('Ricevi aggiornamenti via email'),
          value: notifications.emailNotifications,
          onChanged: (v) => _updateNotification('emailNotifications', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.notifications_active_outlined),
          title: const Text('Notifiche Push'),
          subtitle: const Text('Notifiche nel browser'),
          value: notifications.pushNotifications,
          onChanged: (v) => _updateNotification('pushNotifications', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.alarm),
          title: const Text('Promemoria Sprint'),
          subtitle: const Text('Avvisi per scadenze sprint'),
          value: notifications.sprintReminders,
          onChanged: (v) => _updateNotification('sprintReminders', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.group_add_outlined),
          title: const Text('Inviti Sessioni'),
          subtitle: const Text('Notifiche per nuove sessioni'),
          value: notifications.sessionInvites,
          onChanged: (v) => _updateNotification('sessionInvites', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.summarize_outlined),
          title: const Text('Riepilogo Settimanale'),
          subtitle: const Text('Report settimanale delle attività'),
          value: notifications.weeklyDigest,
          onChanged: (v) => _updateNotification('weeklyDigest', v),
        ),
      ],
    );
  }

  Widget _buildDangerZoneSection(ThemeData theme, bool isDark) {
    return Card(
      color: Colors.red.withOpacity(isDark ? 0.15 : 0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red[400]),
                const SizedBox(width: 8),
                Text(
                  'Zona Pericolosa',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_profile?.hasDeletionRequest == true) ...[
              // Mostra stato richiesta cancellazione
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.hourglass_top, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cancellazione in corso',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            'Richiesta il ${_profile!.deletionRequestedAt}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: _cancelDeletionRequest,
                      child: const Text('Annulla richiesta'),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Pulsante richiesta cancellazione
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.delete_forever, color: Colors.red[400]),
                title: Text(
                  'Elimina Account',
                  style: TextStyle(color: Colors.red[400]),
                ),
                subtitle: Text(
                  'Richiedi la cancellazione definitiva del tuo account e di tutti i dati associati',
                  style: TextStyle(
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                trailing: OutlinedButton(
                  onPressed: _showDeleteAccountDialog,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                  child: const Text('Richiedi'),
                ),
              ),
            ],

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // Logout
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout),
              title: const Text('Esci'),
              subtitle: const Text('Disconnetti il tuo account da questo dispositivo'),
              trailing: OutlinedButton(
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
    bool initiallyExpanded = false,
    Widget? trailing,
  }) {
    return Card(
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: trailing,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    IconData? icon,
    Color? iconColor,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ACTIONS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> _saveProfile() async {
    if (_profile == null) return;

    try {
      final updated = _profile!.copyWith(
        displayName: _displayNameController.text.trim().isEmpty
            ? null
            : _displayNameController.text.trim(),
        firstName: _firstNameController.text.trim().isEmpty
            ? null
            : _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim().isEmpty
            ? null
            : _lastNameController.text.trim(),
        company: _companyController.text.trim().isEmpty
            ? null
            : _companyController.text.trim(),
        jobTitle: _jobTitleController.text.trim().isEmpty
            ? null
            : _jobTitleController.text.trim(),
        bio: _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
      );

      await _profileService.updateProfile(updated);
      setState(() => _profile = updated);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profilo aggiornato'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateTheme(ThemePreference theme) async {
    if (_settings == null) return;

    try {
      await _profileService.updateTheme(theme);
      setState(() {
        _settings = _settings!.copyWith(themeMode: theme);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateLocale(String locale) async {
    if (_settings == null) return;

    try {
      await _profileService.updateSettings(_settings!.copyWith(locale: locale));
      setState(() {
        _settings = _settings!.copyWith(locale: locale);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateAnimations(bool enabled) async {
    if (_settings == null) return;

    try {
      await _profileService.updateSettings(
        _settings!.copyWith(enableAnimations: enabled),
      );
      setState(() {
        _settings = _settings!.copyWith(enableAnimations: enabled);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _toggleFeatureFlag(String flagName, bool enabled) async {
    try {
      await _profileService.toggleFeatureFlag(flagName, enabled);
      await _loadUserData(); // Ricarica per sincronizzare
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateNotification(String key, bool enabled) async {
    if (_settings == null) return;

    try {
      final currentMap = _settings!.notifications.toMap();
      currentMap[key] = enabled;
      final newNotifications = NotificationSettings.fromMap(currentMap);

      await _profileService.updateNotifications(newNotifications);
      setState(() {
        _settings = _settings!.copyWith(notifications: newNotifications);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showUpgradeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upgrade Piano'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final plan in SubscriptionPlan.values.where(
              (p) => p.index > (_subscription?.plan.index ?? 0),
            ))
              ListTile(
                leading: Icon(plan.icon, color: plan.color),
                title: Text(plan.displayName),
                subtitle: Text(plan.description),
                trailing: Text(
                  plan.monthlyPrice > 0
                      ? '${plan.monthlyPrice.toStringAsFixed(2)} EUR/mese'
                      : 'Gratuito',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _activatePlan(plan);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
        ],
      ),
    );
  }

  Future<void> _activatePlan(SubscriptionPlan plan) async {
    // TODO: Integrare con sistema di pagamento
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Upgrade a ${plan.displayName} in arrivo...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showCancelSubscriptionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Annulla Abbonamento'),
        content: const Text(
          'Sei sicuro di voler annullare il tuo abbonamento? '
          'Potrai continuare a utilizzare le funzionalità premium fino alla scadenza del periodo corrente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No, mantieni'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelSubscription();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sì, annulla'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelSubscription() async {
    try {
      await _profileService.cancelSubscription(reason: 'Richiesta utente');
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Abbonamento annullato'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showDeleteAccountDialog() {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red[400]),
            const SizedBox(width: 8),
            const Text('Elimina Account'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Questa azione è irreversibile. Tutti i tuoi dati verranno eliminati definitivamente.',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Motivo (opzionale)',
                hintText: 'Perché vuoi eliminare il tuo account?',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestAccountDeletion(reasonController.text);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Richiedi Eliminazione'),
          ),
        ],
      ),
    );
  }

  Future<void> _requestAccountDeletion(String reason) async {
    try {
      await _profileService.requestAccountDeletion(reason);
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Richiesta di eliminazione inviata'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _cancelDeletionRequest() async {
    try {
      await _profileService.cancelDeletionRequest();
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Richiesta annullata'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Sei sicuro di voler uscire?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Esci'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _profileService.onLogout();
      await _authService.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }
}
