import 'package:flutter/material.dart';
import '../../services/secure_storage_service.dart';
import '../../services/jira_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class JiraAuthDialog extends StatefulWidget {
  const JiraAuthDialog({super.key});

  @override
  State<JiraAuthDialog> createState() => _JiraAuthDialogState();
}

class _JiraAuthDialogState extends State<JiraAuthDialog> {
  final _domainController = TextEditingController();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCurrentSettings();
  }

  Future<void> _loadCurrentSettings() async {
    setState(() => _isLoading = true);
    final creds = await SecureStorageService().getJiraCredentials();
    if (mounted) {
      if (creds['domain'] != null) _domainController.text = creds['domain']!;
      if (creds['email'] != null) _emailController.text = creds['email']!;
      if (creds['apiToken'] != null) _tokenController.text = creds['apiToken']!;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Basic validation of domain format
      String domain = _domainController.text.trim();
      if (domain.startsWith('https://')) {
        domain = domain.replaceFirst('https://', '');
      }
      if (domain.endsWith('/')) {
        domain = domain.substring(0, domain.length - 1);
      }

      await SecureStorageService().saveJiraCredentials(
        domain: domain,
        email: _emailController.text.trim(),
        apiToken: _tokenController.text.trim(),
      );

      // Verify connection
      final userProfile = await JiraService().getCurrentUser();
      final displayName = userProfile['displayName'] as String? ?? 'User';

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSuccess = true;
        });
        
        // Wait a moment to show success state
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               content: Text(l10n.jiraConnectedSuccess(displayName)),
               backgroundColor: Colors.green,
             ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('JiraException: ', '');
        _isLoading = false;
        _isSuccess = false;
      });
    }
  }

  Future<void> _clearSettings() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    await SecureStorageService().clearJiraCredentials();
    _domainController.clear();
    _emailController.clear();
    _tokenController.clear();
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(l10n.jiraSettingsCleared)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.link, color: Colors.blue),
          const SizedBox(width: 8),
          Text(l10n.profileJiraIntegration),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.profileJiraIntegrationDesc,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                
                // Domain
                TextFormField(
                  controller: _domainController,
                  decoration: InputDecoration(
                    labelText: l10n.jiraDomain,
                    hintText: 'company.atlassian.net',
                    prefixIcon: const Icon(Icons.language),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.validationRequired;
                    if (!value.contains('.')) return l10n.jiraInvalidDomain;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: l10n.jiraEmail,
                    hintText: 'email@company.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.validationRequired;
                    if (!value.contains('@')) return l10n.jiraInvalidEmail;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // API Token
                TextFormField(
                  controller: _tokenController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: l10n.jiraApiToken,
                    prefixIcon: const Icon(Icons.key),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? l10n.validationRequired : null,
                ),
                const SizedBox(height: 8),
                
                // Link helper
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse('https://id.atlassian.com/manage-profile/security/api-tokens'),
                  ),
                  child: Text(
                    l10n.jiraCreateTokenLink,
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),

                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        if (_tokenController.text.isNotEmpty)
          TextButton(
            onPressed: (_isLoading || _isSuccess) ? null : _clearSettings,
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.jiraDisconnect),
          ),
        TextButton(
          onPressed: (_isLoading || _isSuccess) ? null : () => Navigator.pop(context),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: (_isLoading || _isSuccess) ? null : _saveSettings,
          style: _isSuccess ? FilledButton.styleFrom(backgroundColor: Colors.green) : null,
          child: _isLoading 
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                  const SizedBox(width: 8),
                  Text(l10n.stateLoading),
                ],
              )
            : _isSuccess
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check, size: 16),
                      const SizedBox(width: 8),
                      Text(l10n.stateSuccess),
                    ],
                  )
                : Text(l10n.jiraConnect),
        ),
      ],
    );
  }
}
