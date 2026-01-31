import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../services/user_profile_service.dart';
import '../models/user_profile/user_profile_model.dart' show AuthProvider;

/// Login Screen - Autenticazione Google e Email/Password con tema
class LoginScreen extends StatefulWidget {
  /// Callback chiamato dopo un login riuscito (opzionale)
  final VoidCallback? onLoginSuccess;

  /// Mostra il pulsante indietro (per uso da InviteLandingScreen)
  final bool showBackButton;

  const LoginScreen({
    super.key,
    this.onLoginSuccess,
    this.showBackButton = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isLoading = false;
  bool _isRegisterMode = false;
  bool _acceptTerms = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential = await _authService.signInWithGoogle();
      if (credential != null && credential.user != null) {
        await UserProfileService().createOrUpdateProfileFromAuth(provider: AuthProvider.google);
        _handleLoginSuccess();
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _errorMessage = '${l10n.errorGeneric}: $e';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signInWithEmail() async {
    final l10n = AppLocalizations.of(context)!;

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = l10n.formRequired);
      return;
    }

    // Validazione formato email
    final email = _emailController.text.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      setState(() => _errorMessage = l10n.authInvalidEmail);
      return;
    }

    // Validazione password minima in registrazione
    if (_isRegisterMode && _passwordController.text.length < 6) {
      setState(() => _errorMessage = l10n.authPasswordTooShort);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isRegisterMode) {
        if (_nameController.text.isEmpty) {
          setState(() => _errorMessage = l10n.formNameRequired);
          return;
        }
        if (!_acceptTerms) {
          setState(() => _errorMessage = l10n.legalMustAcceptTerms);
          return;
        }
        final credential = await _authService.registerWithEmail(
          email,
          _passwordController.text,
          _nameController.text.trim(),
        );
        if (credential != null && credential.user != null) {
          // Invia email di verifica
          await _authService.sendEmailVerification();
          await UserProfileService().createOrUpdateProfileFromAuth(provider: AuthProvider.email);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.authVerificationSent)),
            );
          }
          _handleLoginSuccess();
        }
      } else {
        final credential = await _authService.signInWithEmail(
          email,
          _passwordController.text,
        );
        if (credential != null && credential.user != null) {
          await UserProfileService().createOrUpdateProfileFromAuth(provider: AuthProvider.email);
          _handleLoginSuccess();
        }
      }
    } catch (e) {
      String message = l10n.authError;
      if (e.toString().contains('user-not-found')) {
        message = l10n.authUserNotFound;
      } else if (e.toString().contains('wrong-password')) {
        message = l10n.authWrongPassword;
      } else if (e.toString().contains('email-already-in-use')) {
        message = l10n.authEmailInUse;
      } else if (e.toString().contains('weak-password')) {
        message = l10n.authWeakPassword;
      } else if (e.toString().contains('invalid-email')) {
        message = l10n.authInvalidEmail;
      }
      setState(() => _errorMessage = message);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleLoginSuccess() {
    if (widget.onLoginSuccess != null) {
      widget.onLoginSuccess!();
    } else {
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  void _showForgotPasswordDialog() {
    final l10n = AppLocalizations.of(context)!;
    final resetEmailController = TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.authForgotPassword),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: resetEmailController,
              decoration: InputDecoration(
                labelText: l10n.profileEmail,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await _authService.resetPassword(resetEmailController.text.trim());
              } catch (_) {
                // Non rivelare se l'email esiste (sicurezza)
              }
              if (mounted) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.authResetPasswordSent)),
                );
              }
            },
            child: Text(l10n.actionSend),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: widget.showBackButton
          ? AppBar(
              backgroundColor: context.backgroundColor,
              surfaceTintColor: context.backgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    width: 80,
                    height: 80,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.textSecondaryColor),
                ),
                const SizedBox(height: 40),

                // Error message
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: isDark ? AppColors.errorLight : AppColors.error,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Google Sign In
                _buildGoogleButton(context, isDark, l10n),
                const SizedBox(height: 12),
                Text(
                   l10n.legalAcceptTerms,
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 12,
                     color: context.textSecondaryColor.withValues(alpha: 0.7),
                   ),
                ),
                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: context.borderColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(l10n.authOr, style: TextStyle(color: context.textTertiaryColor)),
                    ),
                    Expanded(child: Divider(color: context.borderColor)),
                  ],
                ),
                const SizedBox(height: 24),

                // Email/Password form
                if (_isRegisterMode) ...[
                  _buildTextField(
                    controller: _nameController,
                    label: l10n.formName,
                    icon: Icons.person,
                    context: context,
                  ),
                  const SizedBox(height: 16),
                ],
                _buildTextField(
                  controller: _emailController,
                  label: l10n.profileEmail,
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  context: context,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _passwordController,
                  label: l10n.authPassword,
                  icon: Icons.lock,
                  obscureText: true,
                  onSubmitted: (_) => _signInWithEmail(),
                  context: context,
                ),
                if (!_isRegisterMode) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: Text(
                        l10n.authForgotPassword,
                        style: TextStyle(fontSize: 13, color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                if (_isRegisterMode) ...[
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (val) => setState(() => _acceptTerms = val ?? false),
                        activeColor: AppColors.primary,
                      ),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              l10n.legalAcceptTerms,
                              style: TextStyle(fontSize: 13, color: context.textPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                const SizedBox(height: 8),

                // Submit button
                ElevatedButton(
                  onPressed: _isLoading ? null : _signInWithEmail,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(
                          _isRegisterMode ? l10n.authRegister : l10n.authLogin,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 16),

                // Toggle register/login
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isRegisterMode = !_isRegisterMode;
                      _errorMessage = null;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                  child: Text(
                    _isRegisterMode
                        ? l10n.authHaveAccount
                        : l10n.authNoAccount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context, bool isDark, AppLocalizations l10n) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _isLoading ? null : _signInWithGoogle,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  )
                : Image.network(
                    'https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg',
                    width: 20,
                    height: 20,
                    errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, size: 20),
                  ),
              const SizedBox(width: 12),
              Text(
                _isLoading ? l10n.stateLoading : l10n.authSignInGoogle,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required BuildContext context,
    TextInputType? keyboardType,
    bool obscureText = false,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: onSubmitted != null ? TextInputAction.done : TextInputAction.next,
      onSubmitted: onSubmitted,
      style: TextStyle(color: context.textPrimaryColor),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: context.textTertiaryColor),
        filled: true,
        fillColor: context.surfaceVariantColor,
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
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        labelStyle: TextStyle(color: context.textSecondaryColor),
      ),
    );
  }
}
