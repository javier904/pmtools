import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../main.dart';

/// Landing Page moderna stile Appwrite - Supporta Dark/Light Theme
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore login: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(isMobile, isDark),
            _buildHeroSection(isMobile, isDark),
            _buildFeaturesSection(isMobile, isDark),
            _buildCTASection(isMobile, isDark),
            _buildFooter(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isDark) {
    final themeController = ThemeControllerProvider.maybeOf(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          bottom: BorderSide(color: context.borderSubtleColor),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Agile Tools',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Theme Toggle Button
          if (themeController != null) ...[
            _HoverButton(
              onTap: () => themeController.toggleTheme(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.borderColor),
                ),
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: context.textSecondaryColor,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],

          // Login Button
          _isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.textPrimaryColor,
                  ),
                )
              : _HoverButton(
                  onTap: _signInWithGoogle,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.login, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          isMobile ? 'Login' : 'Accedi con Google',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryLight),
                SizedBox(width: 8),
                Text(
                  'Strumenti per team agili',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Main Headline
          Text(
            'Build better products\nwith Agile Tools',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.bold,
              height: 1.1,
              letterSpacing: -1.5,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 24),

          // Subtitle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Prioritizza, stima e gestisci i tuoi progetti con strumenti collaborativi. Tutto in un unico posto, gratis.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: context.textSecondaryColor,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // CTA Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _HoverButton(
                onTap: _signInWithGoogle,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Inizia Gratis',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          top: BorderSide(color: context.borderSubtleColor),
        ),
      ),
      child: Column(
        children: [
          // Section Title
          Text(
            'Everything you need',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Strumenti progettati per team moderni',
            style: TextStyle(
              fontSize: 16,
              color: context.textTertiaryColor,
            ),
          ),
          const SizedBox(height: 60),

          // Features Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Column(
                  children: [
                    // Prima riga: Smart Todo + Matrice Eisenhower
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFeatureCard(
                          icon: Icons.check_circle_outline_rounded,
                          title: 'Smart Todo',
                          description: 'Liste intelligenti e collaborative. Importa da CSV/testo, invita partecipanti e gestisci task.',
                          color: Colors.blue,
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildFeatureCard(
                          icon: Icons.apps_rounded,
                          title: 'Matrice Eisenhower',
                          description: 'Prioritizza le attivita distinguendo tra urgente e importante. Organizza il lavoro con chiarezza.',
                          color: AppColors.success,
                          isDark: isDark,
                        )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Seconda riga: Estimation Room + Agile Process
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFeatureCard(
                          icon: Icons.style_rounded,
                          title: 'Estimation Room',
                          description: 'Sessioni di stima collaborative con Planning Poker, T-Shirt sizing e altri metodi.',
                          color: AppColors.secondary,
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildFeatureCard(
                          icon: Icons.speed_rounded,
                          title: 'Agile Process',
                          description: 'Gestisci backlog, sprint e kanban board. Metriche e retrospettive incluse.',
                          color: AppColors.primary,
                          isDark: isDark,
                        )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Terza riga: Retrospective (con Spacer per mantenere la griglia)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFeatureCard(
                          icon: Icons.replay_rounded,
                          title: 'Retrospective',
                          description: 'Migliora il tuo team con retrospettive strutturate. Template, voto anonimo e action items.',
                          color: Colors.orange,
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        const Spacer(),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.check_circle_outline_rounded,
                      title: 'Smart Todo',
                      description: 'Liste intelligenti e collaborative. Importa da CSV/testo e gestisci task.',
                      color: Colors.blue,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.apps_rounded,
                      title: 'Matrice Eisenhower',
                      description: 'Prioritizza le attivita distinguendo tra urgente e importante.',
                      color: AppColors.success,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.style_rounded,
                      title: 'Estimation Room',
                      description: 'Sessioni di stima collaborative con Planning Poker e altri metodi.',
                      color: AppColors.secondary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.speed_rounded,
                      title: 'Agile Process',
                      description: 'Gestisci backlog, sprint e kanban board con metriche.',
                      color: AppColors.primary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.replay_rounded,
                      title: 'Retrospective',
                      description: 'Migliora il team con retrospettive strutturate e action items.',
                      color: Colors.orange,
                      isDark: isDark,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required bool isDark,
  }) {
    return _HoverScaleCard(
      isDark: isDark,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTASection(bool isMobile, bool isDark) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 24 : 80),
      padding: EdgeInsets.all(isMobile ? 32 : 56),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
            AppColors.secondary.withValues(alpha: isDark ? 0.1 : 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            'Ready to start?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Accedi gratuitamente e inizia a collaborare con il tuo team.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 32),
          _HoverButton(
            onTap: _signInWithGoogle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white : AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.login,
                    color: isDark ? AppColors.primary : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Accedi con Google',
                    style: TextStyle(
                      color: isDark ? AppColors.primary : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: context.borderSubtleColor),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.rocket_launch, color: Colors.white, size: 14),
              ),
              const SizedBox(width: 8),
              Text(
                'Agile Tools',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '© 2025 Agile Tools. Built for modern teams.',
            style: TextStyle(
              color: context.textMutedColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget per effetto hover con scale
class _HoverScaleCard extends StatefulWidget {
  final Widget child;
  final double scale;
  final bool isDark;

  const _HoverScaleCard({
    required this.child,
    this.scale = 1.03,
    required this.isDark,
  });

  @override
  State<_HoverScaleCard> createState() => _HoverScaleCardState();
}

class _HoverScaleCardState extends State<_HoverScaleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..scale(_isHovered ? widget.scale : 1.0),
        transformAlignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: widget.isDark ? 0.2 : 0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Widget per effetto hover su bottoni
class _HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverButton({required this.child, required this.onTap});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          transformAlignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
