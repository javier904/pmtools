import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../main.dart';
import 'retrospective/retro_global_dashboard.dart';
import '../widgets/profile_menu_widget.dart';

/// Home Screen - Dashboard stile Appwrite con supporto Dark/Light Theme
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isDark = context.isDarkMode;
    final themeController = ThemeControllerProvider.maybeOf(context);

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
                'assets/icons/app_logo.png',
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Agile Tools',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
        actions: [
          // Theme Toggle Button
          if (themeController != null)
            _HoverIconButton(
              icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              tooltip: isDark ? 'Light Mode' : 'Dark Mode',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  'Utilities',
                  style: TextStyle(
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 8,
                        height: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Online',
                        style: TextStyle(fontSize: 12, color: AppColors.success, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Seleziona uno strumento per iniziare',
              style: TextStyle(fontSize: 15, color: context.textTertiaryColor),
            ),
            const SizedBox(height: 32),

            // Tools Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 800 ? 2 : 1;

                if (crossAxisCount == 2) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _ToolCard(
                              title: 'Smart Todo',
                              description: 'Liste intelligenti e collaborative. Importa da CSV/testo, invita partecipanti e gestisci task con filtri avanzati.',
                              icon: Icons.check_circle_outline_rounded,
                              color: Colors.blue,
                              features: const ['Smart Import', 'Collaborazione', 'Filtri'],
                              onTap: () => Navigator.pushNamed(context, '/smart-todo'),
                              isDark: isDark,
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: _ToolCard(
                              title: 'Matrice Eisenhower',
                              description: 'Organizza le attivita in base a urgenza e importanza. Quadranti per decidere cosa fare subito, pianificare, delegare o eliminare.',
                              icon: Icons.grid_view_rounded,
                              color: AppColors.success,
                              features: const ['4 Quadranti', 'Drag & Drop', 'Collaborativo'],
                              onTap: () => Navigator.pushNamed(context, '/eisenhower'),
                              isDark: isDark,
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: _ToolCard(
                              title: 'Estimation Room',
                              description: 'Sessioni di stima collaborative per il team. Planning Poker, T-Shirt sizing e altri metodi per stimare user stories.',
                              icon: Icons.casino_rounded,
                              color: AppColors.secondary,
                              features: const ['Planning Poker', 'T-Shirt Size', 'Real-time'],
                              onTap: () => Navigator.pushNamed(context, '/estimation-room'),
                              isDark: isDark,
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _ToolCard(
                              title: 'Agile Process Manager',
                              description: 'Gestisci progetti agili completi con backlog, sprint planning, kanban board, metriche e retrospettive.',
                              icon: Icons.rocket_launch_rounded,
                              color: AppColors.primary,
                              features: const ['Scrum', 'Kanban', 'Hybrid'],
                              onTap: () => Navigator.pushNamed(context, '/agile-process'),
                              isDark: isDark,
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: _ToolCard(
                              title: 'Retrospective Board',
                              description: 'Raccogli feedback dal team su cosa e andato bene, cosa migliorare e le azioni da intraprendere.',
                              icon: Icons.psychology_rounded,
                              color: AppColors.pink,
                              features: const ['Went Well', 'To Improve', 'Actions'],
                              isComingSoon: false,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RetroGlobalDashboard(),
                                ),
                              ),
                              isDark: isDark,
                            )),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                // Mobile - single column
                return Column(
                  children: [
                    _ToolCard(
                      title: 'Smart Todo',
                      description: 'Liste intelligenti e collaborative. Importa da CSV, invita e gestisci.',
                      icon: Icons.check_circle_outline_rounded,
                      color: Colors.blue,
                      features: const ['Smart Import', 'Collaborazione', 'Filtri'],
                      onTap: () => Navigator.pushNamed(context, '/smart-todo'),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _ToolCard(
                      title: 'Matrice Eisenhower',
                      description: 'Organizza le attivita in base a urgenza e importanza. Quadranti per decidere cosa fare subito, pianificare, delegare o eliminare.',
                      icon: Icons.grid_view_rounded,
                      color: AppColors.success,
                      features: const ['4 Quadranti', 'Drag & Drop', 'Collaborativo'],
                      onTap: () => Navigator.pushNamed(context, '/eisenhower'),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _ToolCard(
                      title: 'Estimation Room',
                      description: 'Sessioni di stima collaborative per il team. Planning Poker, T-Shirt sizing e altri metodi.',
                      icon: Icons.casino_rounded,
                      color: AppColors.secondary,
                      features: const ['Planning Poker', 'T-Shirt Size', 'Real-time'],
                      onTap: () => Navigator.pushNamed(context, '/estimation-room'),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _ToolCard(
                      title: 'Agile Process Manager',
                      description: 'Gestisci progetti agili con backlog, sprint, kanban e metriche.',
                      icon: Icons.rocket_launch_rounded,
                      color: AppColors.primary,
                      features: const ['Scrum', 'Kanban', 'Hybrid'],
                      onTap: () => Navigator.pushNamed(context, '/agile-process'),
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _ToolCard(
                      title: 'Retrospective Board',
                      description: 'Raccogli feedback dal team su cosa e andato bene e cosa migliorare.',
                      icon: Icons.psychology_rounded,
                      color: AppColors.pink,
                      features: const ['Went Well', 'To Improve', 'Actions'],
                      isComingSoon: false,
                      onTap: () => Navigator.pushNamed(
                        context, 
                        '/agile-process',
                        arguments: {'initialAction': 'retro'},
                      ),
                      isDark: isDark,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Questa funzionalita sara disponibile presto!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/// Card Tool con effetto hover
class _ToolCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;
  final VoidCallback onTap;
  final bool isComingSoon;
  final bool isDark;

  const _ToolCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
    required this.onTap,
    this.isComingSoon = false,
    required this.isDark,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.isComingSoon ? Colors.grey : widget.color;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
          transformAlignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? effectiveColor.withValues(alpha: 0.5)
                    : context.borderColor,
                width: _isHovered ? 1.5 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: effectiveColor.withValues(alpha: widget.isDark ? 0.15 : 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: effectiveColor.withValues(alpha: _isHovered ? 0.2 : 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(widget.icon, color: effectiveColor, size: 28),
                    ),
                    const Spacer(),
                    if (widget.isComingSoon)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: context.surfaceVariantColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Coming Soon',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: context.textMutedColor,
                          ),
                        ),
                      )
                    else
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? effectiveColor.withValues(alpha: 0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: _isHovered
                              ? effectiveColor
                              : context.textMutedColor,
                          size: 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isComingSoon
                        ? context.textMutedColor
                        : context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Description - fixed min height for consistent card sizes
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 65),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.isComingSoon
                          ? context.textMutedColor.withValues(alpha: 0.6)
                          : context.textSecondaryColor,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),

                // Feature tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.features.map((f) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: effectiveColor.withValues(alpha: _isHovered ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: effectiveColor.withValues(alpha: _isHovered ? 0.3 : 0.15),
                      ),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: widget.isComingSoon
                            ? context.textMutedColor
                            : effectiveColor,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
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
