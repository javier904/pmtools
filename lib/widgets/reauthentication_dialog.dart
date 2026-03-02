import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../themes/app_colors.dart';

/// Dialog riutilizzabile per re-autenticazione.
/// Rileva il provider dell'utente e mostra il form appropriato.
class ReauthenticationDialog extends StatefulWidget {
  const ReauthenticationDialog({super.key});

  /// Mostra il dialog e restituisce true se la re-autenticazione è riuscita.
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ReauthenticationDialog(),
    );
  }

  @override
  State<ReauthenticationDialog> createState() => _ReauthenticationDialogState();
}

class _ReauthenticationDialogState extends State<ReauthenticationDialog> {
  final _authService = AuthService();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  bool get _isEmailProvider {
    final user = _authService.currentUser;
    return user?.providerData.any((p) => p.providerId == 'password') ?? false;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _reauthenticateWithEmail() async {
    if (_passwordController.text.isEmpty) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final email = _authService.currentUser?.email ?? '';
      await _authService.reauthenticateWithEmail(email, _passwordController.text);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _isLoading = false;
        _error = l10n.authWrongCurrentPassword;
      });
    }
  }

  Future<void> _reauthenticateWithGoogle() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await _authService.reauthenticateWithGoogle();
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.security, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(l10n.authReauthRequired),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.authReauthDesc,
            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 16),
          if (_isEmailProvider) ...[
            TextField(
              controller: _passwordController,
              obscureText: true,
              autofocus: MediaQuery.of(context).size.width > 600,
              onSubmitted: (_) => _reauthenticateWithEmail(),
              decoration: InputDecoration(
                labelText: l10n.authCurrentPassword,
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ] else ...[
            Center(
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _reauthenticateWithGoogle,
                icon: const Icon(Icons.g_mobiledata),
                label: Text(l10n.authSignInGoogle),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: const TextStyle(color: AppColors.error, fontSize: 13),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.actionCancel),
        ),
        if (_isEmailProvider)
          FilledButton(
            onPressed: _isLoading ? null : _reauthenticateWithEmail,
            child: _isLoading
                ? const SizedBox(
                    width: 18, height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(l10n.actionConfirm),
          ),
      ],
    );
  }
}
