import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart';
import '../themes/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../widgets/profile_menu_widget.dart';
import '../widgets/language_selector_widget.dart';
import '../widgets/home/section_favorites.dart';
import '../widgets/home/section_deadlines.dart';
import '../widgets/home/section_tools.dart';

/// Home Screen - Dashboard stile Appwrite con supporto Dark/Light Theme
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800; // Increased breakpoint for better tablet support
    final isDark = context.isDarkMode;
    final themeController = ThemeControllerProvider.maybeOf(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: context.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              l10n.appTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
        actions: [
          // Language Selector
          const LanguageSelectorWidget(),
          const SizedBox(width: 4),
          // Theme Toggle Button
          if (themeController != null)
            _HoverIconButton(
              icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              tooltip: isDark ? l10n.themeLightMode : l10n.themeDarkMode,
              onTap: () => themeController.toggleTheme(),
            ),
          // Profile Menu con avatar, info utente e logout
          if (user != null)
            ProfileMenuWidget(
              onProfileTap: () => Navigator.pushNamed(context, '/profile'),
              onLogout: () => authService.signOut(),
              showSubscriptionBadge: true,
              avatarSize: 32,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Builder(
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0),
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 32, vertical: 16),
            child: isMobile 
                ? _buildMobileLayout(context, l10n)
                : _buildDesktopLayout(context, l10n),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        // Top Half: Favorites and Deadlines
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                flex: 1,
                child: SectionFavorites(),
              ),
              const SizedBox(width: 24),
              const Expanded(
                flex: 1,
                child: SectionDeadlines(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Bottom Half: Tools
        const Expanded(
          flex: 1,
          child: SectionTools(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 400,
            child: SectionFavorites(),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 400,
            child: SectionDeadlines(),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 400,
            child: SectionTools(),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.featureComingSoon),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/// Hover Icon Button
class _HoverIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HoverIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<_HoverIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHovered
                  ? context.surfaceVariantColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              widget.icon,
              color: _isHovered
                  ? context.textPrimaryColor
                  : context.textSecondaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
