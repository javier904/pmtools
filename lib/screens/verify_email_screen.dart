import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';

/// Schermata di verifica email mostrata dopo registrazione con email/password.
/// Controlla periodicamente se l'utente ha verificato l'email.
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _authService = AuthService();
  Timer? _checkTimer;
  int _cooldownSeconds = 0;
  Timer? _cooldownTimer;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    // Controlla ogni 3 secondi se l'email è stata verificata
    _checkTimer = Timer.periodic(const Duration(seconds: 3), (_) => _checkEmailVerified());
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  Future<void> _checkEmailVerified() async {
    if (_isChecking) return;
    _isChecking = true;
    try {
      await _authService.reloadUser();
      if (_authService.isEmailVerified && mounted) {
        _checkTimer?.cancel();
        // Naviga alla home
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    } catch (_) {
      // Ignora errori di reload
    } finally {
      _isChecking = false;
    }
  }

  Future<void> _resendVerification() async {
    if (_cooldownSeconds > 0) return;
    try {
      await _authService.sendEmailVerification();
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authVerificationSent)),
        );
        // Avvia cooldown 60 secondi
        setState(() => _cooldownSeconds = 60);
        _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() {
              _cooldownSeconds--;
              if (_cooldownSeconds <= 0) {
                timer.cancel();
              }
            });
          } else {
            timer.cancel();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _manualCheck() async {
    setState(() => _isChecking = true);
    try {
      await _authService.reloadUser();
      if (_authService.isEmailVerified && mounted) {
        _checkTimer?.cancel();
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      } else if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.authWaitingVerification)),
        );
      }
    } catch (_) {
      // Ignora errori
    } finally {
      if (mounted) setState(() => _isChecking = false);
    }
  }

  Future<void> _logout() async {
    _checkTimer?.cancel();
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    final userEmail = _authService.currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icona email
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_unread_outlined,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),

                // Titolo
                Text(
                  l10n.authVerifyEmail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),

                // Descrizione con email
                Text(
                  l10n.authVerifyEmailDesc(userEmail),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textSecondaryColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Bottone "Reinvia email di verifica"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _cooldownSeconds > 0 ? null : _resendVerification,
                    icon: const Icon(Icons.send),
                    label: Text(
                      _cooldownSeconds > 0
                          ? l10n.authCooldownWait(_cooldownSeconds)
                          : l10n.authResendVerification,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Bottone "Ho verificato la mia email"
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _isChecking ? null : _manualCheck,
                    icon: _isChecking
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check_circle_outline),
                    label: Text(l10n.authIVerified),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Logout link
                TextButton.icon(
                  onPressed: _logout,
                  icon: Icon(Icons.logout, size: 18, color: context.textTertiaryColor),
                  label: Text(
                    l10n.authSignOut,
                    style: TextStyle(color: context.textTertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
