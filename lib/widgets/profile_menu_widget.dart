import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile/user_profile_model.dart';
import '../models/user_profile/subscription_model.dart';
import '../models/user_profile/user_settings_model.dart';
import '../services/user_profile_service.dart';
import '../services/auth_service.dart';
import '../l10n/app_localizations.dart';

/// Widget menu profilo per accesso rapido
///
/// Mostra:
/// - Avatar utente
/// - Menu dropdown con Profilo e Logout
class ProfileMenuWidget extends StatefulWidget {
  /// Callback quando si naviga al profilo
  final VoidCallback? onProfileTap;

  /// Callback quando si effettua il logout
  final VoidCallback? onLogout;

  /// Mostra il badge abbonamento
  final bool showSubscriptionBadge;

  /// Dimensione avatar
  final double avatarSize;

  const ProfileMenuWidget({
    super.key,
    this.onProfileTap,
    this.onLogout,
    this.showSubscriptionBadge = true,
    this.avatarSize = 36,
  });

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  final UserProfileService _profileService = UserProfileService();
  final AuthService _authService = AuthService();

  UserProfileModel? _profile;
  SubscriptionModel? _subscription;
  User? _firebaseUser;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Ottieni Firebase Auth user per fallback
    _firebaseUser = _authService.currentUser;

    // Prova a caricare il profilo da Firestore
    final data = await _profileService.getAllUserData();

    if (mounted) {
      setState(() {
        _profile = data.profile;
        _subscription = data.subscription;
      });
    }
  }

  /// Nome da visualizzare - priorità: Firestore > Firebase Auth > fallback
  String get _displayName {
    // 1. Prova dal profilo Firestore
    if (_profile != null) {
      if (_profile!.displayName != null && _profile!.displayName!.isNotEmpty) {
        return _profile!.displayName!;
      }
      if (_profile!.firstName != null && _profile!.firstName!.isNotEmpty) {
        return _profile!.fullName;
      }
    }

    // 2. Fallback a Firebase Auth
    if (_firebaseUser != null) {
      if (_firebaseUser!.displayName != null && _firebaseUser!.displayName!.isNotEmpty) {
        return _firebaseUser!.displayName!;
      }
      // Usa parte dell'email prima della @
      if (_firebaseUser!.email != null) {
        return _firebaseUser!.email!.split('@').first;
      }
    }

    return 'Utente';
  }

  /// Email da visualizzare
  String get _displayEmail {
    return _profile?.email ?? _firebaseUser?.email ?? '';
  }

  /// Iniziali per avatar
  String get _initials {
    if (_profile != null) {
      return _profile!.initials;
    }

    final name = _displayName;
    if (name.isNotEmpty) {
      final parts = name.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return name[0].toUpperCase();
    }
    return '?';
  }

  /// URL foto profilo
  String? get _photoUrl {
    return _profile?.photoUrl ?? _firebaseUser?.photoURL;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopupMenuButton<String>(
      offset: const Offset(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        // Header con info utente
        PopupMenuItem<String>(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                _buildAvatar(theme, size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _displayEmail,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (_subscription != null && widget.showSubscriptionBadge) ...[
                        const SizedBox(height: 4),
                        Builder(
                          builder: (context) {
                            final l10n = AppLocalizations.of(context)!;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _subscription!.plan.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _subscription!.plan.icon,
                                    size: 12,
                                    color: _subscription!.plan.color,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _subscription!.plan.getDisplayName(l10n),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: _subscription!.plan.color,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const PopupMenuDivider(),

        // Profilo
        _buildMenuItem(
          icon: Icons.person_outline,
          label: AppLocalizations.of(context)?.profileMenuTitle ?? 'Profile',
          value: 'profile',
        ),

        const PopupMenuDivider(),

        // Logout
        _buildMenuItem(
          icon: Icons.logout,
          label: AppLocalizations.of(context)?.profileMenuLogout ?? 'Logout',
          value: 'logout',
          color: Colors.red,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'profile':
            if (widget.onProfileTap != null) {
              widget.onProfileTap!();
            } else {
              Navigator.pushNamed(context, '/profile');
            }
            break;
          case 'logout':
            _handleLogout();
            break;
        }
      },
      child: _buildTrigger(theme, isDark),
    );
  }

  Widget _buildTrigger(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatar(theme, size: widget.avatarSize),
          if (widget.showSubscriptionBadge && _subscription != null) ...[
            const SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _subscription!.plan.color,
                shape: BoxShape.circle,
              ),
            ),
          ],
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme, {double size = 36}) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      backgroundImage: _photoUrl != null ? CachedNetworkImageProvider(_photoUrl!) : null,
      child: _photoUrl == null
          ? Text(
              _initials,
              style: TextStyle(
                fontSize: size * 0.4,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            )
          : null,
    );
  }

  PopupMenuItem<String> _buildMenuItem({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n?.profileLogoutDialogTitle ?? 'Logout'),
        content: Text(l10n?.profileLogoutDialogConfirm ?? 'Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n?.smartTodoCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n?.profileMenuLogout ?? 'Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _profileService.onLogout();
      await _authService.signOut();

      if (widget.onLogout != null) {
        widget.onLogout!();
      } else if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }
}

/// Widget compatto solo avatar per spazi ristretti
class ProfileAvatarWidget extends StatelessWidget {
  final UserProfileModel? profile;
  final double size;
  final VoidCallback? onTap;

  const ProfileAvatarWidget({
    super.key,
    this.profile,
    this.size = 36,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap ?? () => Navigator.pushNamed(context, '/profile'),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        backgroundImage:
            profile?.photoUrl != null ? CachedNetworkImageProvider(profile!.photoUrl!) : null,
        child: profile?.photoUrl == null
            ? Text(
                profile?.initials ?? '?',
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              )
            : null,
      ),
    );
  }
}
