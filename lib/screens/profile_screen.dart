import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../models/user_profile/user_profile_model.dart';
import '../models/user_profile/subscription_model.dart';
import '../models/user_profile/user_settings_model.dart';
import '../services/user_profile_service.dart';
import '../services/auth_service.dart';
import '../services/gdpr_service.dart';
import 'dart:html' as html;
import 'dart:convert';

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
  bool _isSaving = false;
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUserData,
            tooltip: l10n.profileReload,
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
                      Text(l10n.profileErrorPrefix(_error!)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadUserData,
                        child: Text(l10n.actionRetry),
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

                          // Sezione Privacy & GDPR
                          _buildPrivacySection(theme, isDark),
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
    final l10n = AppLocalizations.of(context)!;

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
                    _profile?.fullName ?? l10n.profileUser,
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
    final l10n = AppLocalizations.of(context)!;

    return _buildExpandableSection(
      title: l10n.profilePersonalInfo,
      icon: Icons.person_outline,
      initiallyExpanded: true,
      children: [
        _buildTextField(
          controller: _displayNameController,
          label: l10n.profileDisplayName,
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _firstNameController,
                label: l10n.formName,
                icon: Icons.person_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _lastNameController,
                label: l10n.profileLastName,
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
                label: l10n.profileCompany,
                icon: Icons.business_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _jobTitleController,
                label: l10n.profileJobTitle,
                icon: Icons.work_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _bioController,
          label: l10n.profileBio,
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
              child: Text(l10n.actionCancel),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: _isSaving ? null : _saveProfile,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save, size: 18),
              label: Text(_isSaving ? l10n.stateSaving : l10n.actionSave),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscriptionSection(ThemeData theme, bool isDark) {
    if (_subscription == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;

    return _buildExpandableSection(
      title: l10n.profileSubscription,
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
          l10n.profilePlan,
          _subscription!.plan.displayName,
          icon: _subscription!.plan.icon,
          iconColor: _subscription!.plan.color,
        ),
        _buildInfoRow(
          l10n.profileBillingCycle,
          _subscription!.billingCycle.displayName,
        ),
        _buildInfoRow(
          l10n.profilePrice,
          _subscription!.formattedPrice,
        ),
        _buildInfoRow(
          l10n.profileActivationDate,
          _formatDate(_subscription!.startDate),
        ),
        if (_subscription!.endDate != null)
          _buildInfoRow(
            _subscription!.status == SubscriptionStatus.trialing
                ? l10n.profileTrialEnd
                : l10n.profileNextRenewal,
            _formatDate(_subscription!.endDate!),
          ),
        if (_subscription!.daysRemaining != null && _subscription!.daysRemaining! > 0)
          _buildInfoRow(
            l10n.profileDaysRemaining,
            '${_subscription!.daysRemaining}',
            valueColor: _subscription!.daysRemaining! <= 7 ? Colors.orange : null,
          ),
        const Divider(height: 24),

        // Pulsanti azioni
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_subscription!.plan != SubscriptionPlan.elite)
              TextButton.icon(
                onPressed: _showUpgradeDialog,
                icon: const Icon(Icons.upgrade),
                label: Text(l10n.profileUpgrade),
              ),
            if (_subscription!.isActive && _subscription!.plan != SubscriptionPlan.free)
              TextButton.icon(
                onPressed: _showCancelSubscriptionDialog,
                icon: const Icon(Icons.cancel_outlined),
                label: Text(l10n.actionCancel),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;

    return _buildExpandableSection(
      title: l10n.profileGeneralSettings,
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
          title: Text(l10n.settingsTheme),
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
          title: Text(l10n.settingsLanguage),
          subtitle: Text(_settings!.locale == 'it' ? l10n.langItalian : l10n.langEnglish),
          trailing: DropdownButton<String>(
            value: _settings!.locale,
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(value: 'it', child: Text(l10n.langItalian)),
              DropdownMenuItem(value: 'en', child: Text(l10n.langEnglish)),
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
          title: Text(l10n.profileAnimations),
          subtitle: Text(l10n.profileAnimationsDesc),
          value: _settings!.enableAnimations,
          onChanged: _updateAnimations,
        ),
      ],
    );
  }

  Widget _buildFeatureFlagsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final flags = _settings!.featureFlags;

    return _buildExpandableSection(
      title: l10n.profileFeatures,
      icon: Icons.extension_outlined,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.calendar_today),
          title: Text(l10n.profileCalendarIntegration),
          subtitle: Text(l10n.profileCalendarIntegrationDesc),
          value: flags.calendarIntegration,
          onChanged: (v) => _toggleFeatureFlag('calendarIntegration', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.table_chart),
          title: Text(l10n.profileExportSheets),
          subtitle: Text(l10n.profileExportSheetsDesc),
          value: flags.googleSheetsExport,
          onChanged: (v) => _toggleFeatureFlag('googleSheetsExport', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.science),
          title: Text(l10n.profileBetaFeatures),
          subtitle: Text(l10n.profileBetaFeaturesDesc),
          value: flags.betaFeatures,
          onChanged: (v) => _toggleFeatureFlag('betaFeatures', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.analytics),
          title: Text(l10n.profileAdvancedMetrics),
          subtitle: Text(l10n.profileAdvancedMetricsDesc),
          value: flags.advancedMetrics,
          onChanged: (v) => _toggleFeatureFlag('advancedMetrics', v),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection(ThemeData theme, bool isDark) {
    if (_settings == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final notifications = _settings!.notifications;

    return _buildExpandableSection(
      title: l10n.profileNotifications,
      icon: Icons.notifications_outlined,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.email_outlined),
          title: Text(l10n.profileEmailNotifications),
          subtitle: Text(l10n.profileEmailNotificationsDesc),
          value: notifications.emailNotifications,
          onChanged: (v) => _updateNotification('emailNotifications', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.notifications_active_outlined),
          title: Text(l10n.profilePushNotifications),
          subtitle: Text(l10n.profilePushNotificationsDesc),
          value: notifications.pushNotifications,
          onChanged: (v) => _updateNotification('pushNotifications', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.alarm),
          title: Text(l10n.profileSprintReminders),
          subtitle: Text(l10n.profileSprintRemindersDesc),
          value: notifications.sprintReminders,
          onChanged: (v) => _updateNotification('sprintReminders', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.group_add_outlined),
          title: Text(l10n.profileSessionInvites),
          subtitle: Text(l10n.profileSessionInvitesDesc),
          value: notifications.sessionInvites,
          onChanged: (v) => _updateNotification('sessionInvites', v),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.summarize_outlined),
          title: Text(l10n.profileWeeklySummary),
          subtitle: Text(l10n.profileWeeklySummaryDesc),
          value: notifications.weeklyDigest,
          onChanged: (v) => _updateNotification('weeklyDigest', v),
        ),
      ],
    );
  }

  Widget _buildPrivacySection(ThemeData theme, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return _buildExpandableSection(
      title: l10n.profilePrivacy,
      icon: Icons.privacy_tip_outlined,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.download_for_offline_outlined),
          title: Text(l10n.profileExportData),
          subtitle: Text(l10n.jsonExportLabel),
          trailing: OutlinedButton(
            onPressed: _exportData,
            child: Text(l10n.actionExport),
          ),
        ),
      ],
    );
  }

  Widget _buildDangerZoneSection(ThemeData theme, bool isDark) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      color: Colors.red.withValues(alpha: isDark ? 0.15 : 0.05),
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
                  l10n.profileDangerZone,
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.delete_forever, color: Colors.red[400]),
              title: Text(
                l10n.profileDeleteAccount,
                style: TextStyle(color: Colors.red[400]),
              ),
              subtitle: Text(
                l10n.profileDeleteAccountConfirm,
                style: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              trailing: OutlinedButton(
                onPressed: _showDeleteAccountConfirmDialog,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                child: Text(l10n.actionDelete),
              ),
            ),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // Logout
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout),
              title: Text(l10n.profileLogout),
              subtitle: Text(l10n.profileLogoutDesc),
              trailing: OutlinedButton(
                onPressed: _logout,
                child: Text(l10n.authSignOut),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportData() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final json = await GDPRService().exportUserData();
      final bytes = utf8.encode(json);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "agile_tools_data_${DateTime.now().millisecondsSinceEpoch}.json")
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorExporting(e.toString()))),
      );
    }
  }

  void _showDeleteAccountConfirmDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.profileDeleteAccount),
        content: Text(l10n.profileDeleteAccountConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteAccount();
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context)!;
    try {
      await GDPRService().deleteAccount();
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } catch (e) {
      setState(() => _isSaving = false);
      String message = l10n.errorDeletingAccount(e.toString());
      if (e.toString().contains('recent-login-required')) {
        message = l10n.errorRecentLoginRequired;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
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

    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSaving = true);

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
          SnackBar(
            content: Text(l10n.profileUpdated),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileErrorPrefix(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _updateTheme(ThemePreference theme) async {
    if (_settings == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.updateTheme(theme);
      setState(() {
        _settings = _settings!.copyWith(themeMode: theme);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateLocale(String locale) async {
    if (_settings == null) return;

    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.updateSettings(_settings!.copyWith(locale: locale));
      setState(() {
        _settings = _settings!.copyWith(locale: locale);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateAnimations(bool enabled) async {
    if (_settings == null) return;

    final l10n = AppLocalizations.of(context)!;

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
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _toggleFeatureFlag(String flagName, bool enabled) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.toggleFeatureFlag(flagName, enabled);
      await _loadUserData(); // Ricarica per sincronizzare
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateNotification(String key, bool enabled) async {
    if (_settings == null) return;

    final l10n = AppLocalizations.of(context)!;

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
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showUpgradeDialog() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.profileUpgradePlan),
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
                      ? '${plan.monthlyPrice.toStringAsFixed(2)} ${l10n.profileMonthly}'
                      : l10n.profileFree,
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
            child: Text(l10n.actionCancel),
          ),
        ],
      ),
    );
  }

  Future<void> _activatePlan(SubscriptionPlan plan) async {
    final l10n = AppLocalizations.of(context)!;

    // TODO: Integrare con sistema di pagamento
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.profileUpgradeComingSoon(plan.displayName)),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showCancelSubscriptionDialog() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.profileCancelSubscription),
        content: Text(l10n.profileCancelSubscriptionConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.profileKeepSubscription),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelSubscription();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.profileYesCancel),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelSubscription() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.cancelSubscription(reason: 'User request');
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileSubscriptionCancelled),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showDeleteAccountDialog() {
    final l10n = AppLocalizations.of(context)!;
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red[400]),
            const SizedBox(width: 8),
            Text(l10n.profileDeleteAccount),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileDeleteAccountIrreversible,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.profileDeleteAccountReason,
                hintText: l10n.profileDeleteAccountReasonHint,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _requestAccountDeletion(reasonController.text);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.profileRequestDeletion),
          ),
        ],
      ),
    );
  }

  Future<void> _requestAccountDeletion(String reason) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.requestAccountDeletion(reason);
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileDeletionRequestSent),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _cancelDeletionRequest() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      await _profileService.cancelDeletionRequest();
      await _loadUserData();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileDeletionRequestCancelled),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.profileErrorPrefix(e.toString())), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _logout() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.authSignOut),
        content: Text(l10n.profileLogoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.profileLogout),
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
