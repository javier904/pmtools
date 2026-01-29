import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../main.dart';
import '../services/user_profile_service.dart';
import 'legal/privacy_policy_screen.dart';
import 'legal/terms_of_service_screen.dart';
import 'legal/cookie_policy_screen.dart';
import 'legal/gdpr_screen.dart';
import '../widgets/language_selector_widget.dart';

/// Landing Page moderna stile Appwrite - Supporta Dark/Light Theme
/// SEO-optimized con sezioni dettagliate per metodologie Agile
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
      final credential = await _authService.signInWithGoogle();
      if (credential != null && credential.user != null) {
        // Crea/Aggiorna profilo utente su Firestore
        await UserProfileService().createOrUpdateProfileFromAuth();
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.errorLoginFailed(e.toString()) ?? 'Login error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _launchEmail(String subjectPrefix) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'suppkesien@gmail.com',
      query: 'subject=$subjectPrefix',
    );
    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
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
            if (isMobile) ...[
              _buildHeroSection(isMobile, isDark),
              _buildFeaturesSection(isMobile, isDark),
              _buildSmartTodoSection(isMobile, isDark),
              _buildEisenhowerSection(isMobile, isDark),
              _buildAgileMethodologySection(isMobile, isDark),
              _buildEstimationMethodsSection(isMobile, isDark),
              _buildRetrospectiveTypesSection(isMobile, isDark),
            ] else ...[
              _buildIntegratedDesktopLayout(context, isDark),
              // Optional: keep detail sections below if user scrolls?
              // For now, let's keep them accessible but maybe the integrated view acts as the main landing
              // User said "integrate them around", implying this replaces the top part.
              // I will keep the detailed sections below for deep diving.
              const SizedBox(height: 100),
              _buildSmartTodoSection(isMobile, isDark),
              _buildEisenhowerSection(isMobile, isDark),
              _buildAgileMethodologySection(isMobile, isDark),
              _buildEstimationMethodsSection(isMobile, isDark),
              _buildRetrospectiveTypesSection(isMobile, isDark),
            ],
            _buildWorkflowSection(isMobile, isDark),
            _buildCTASection(isMobile, isDark),
            _buildFullFooter(isMobile, isDark),
          ],

        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isDark) {
    final themeController = ThemeControllerProvider.maybeOf(context);
    final l10n = AppLocalizations.of(context)!;

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
              _PulseLogo(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    height: 40,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.appTitle,
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

          // Language Selector
          const LanguageSelectorWidget(),
          const SizedBox(width: 12),

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
                      // ... rest of the button style
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.login, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          isMobile ? l10n.authLogin : l10n.authSignInGoogle,
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
    final l10n = AppLocalizations.of(context)!;
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryLight),
                SizedBox(width: 8),
                Text(
                  l10n.landingBadge, // 'Strumenti per team agili'
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
            l10n.landingHeroTitle, // 'Build better products\nwith Keisen'
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
              l10n.landingHeroSubtitle, // 'Prioritizza, stima e gestisci...'
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.landingStartFree, // 'Inizia Gratis'
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
    final l10n = AppLocalizations.of(context)!;
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
            l10n.landingEverythingNeed, // 'Everything you need'
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 12),
          Text(
            l10n.landingModernTools, // 'Strumenti progettati per team moderni'
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
                    // Prima riga: Smart Todo + Matrice Eisenhower + Estimation Room
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _buildFeatureCard(
                            icon: Icons.check_circle_outline_rounded,
                            title: l10n.toolSmartTodo, // 'Smart Todo List'
                            description: l10n.toolSmartTodoDescShort, // 'Liste intelligenti...'
                            color: Colors.blue,
                            isDark: isDark,
                            features: [l10n.featureSmartImport, l10n.featureCollaboration, l10n.featureFilters],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: _buildFeatureCard(
                            icon: Icons.grid_view_rounded,
                            title: l10n.toolEisenhower, // 'Matrice Eisenhower'
                            description: l10n.landingEisenhowerSubtitle, // 'Organizza le attivita...'
                            color: AppColors.success,
                            isDark: isDark,
                            features: [l10n.feature4Quadrants, l10n.featureDragDrop, l10n.featureCollaborative],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: _buildFeatureCard(
                            icon: Icons.casino_rounded,
                            title: l10n.toolEstimation, // 'Estimation Room'
                            description: l10n.landingEstimationSubtitle, // 'Sessioni di stima...'
                            color: Colors.amber,
                            isDark: isDark,
                            features: [l10n.featurePlanningPoker, l10n.featureTshirtSize, l10n.featureRealtime],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Seconda riga: Agile Process + Retrospective (2 cards full width)
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _buildFeatureCard(
                            icon: Icons.rocket_launch_rounded,
                            title: l10n.landingAgileTitle, // 'Agile Process Manager'
                            description: l10n.landingAgileSubtitle, // 'Gestisci progetti...'
                            color: AppColors.primary,
                            isDark: isDark,
                            features: [l10n.featureScrum, l10n.featureKanban, l10n.featureHybrid],
                          )),
                          const SizedBox(width: 20),
                          Expanded(child: _buildFeatureCard(
                            icon: Icons.psychology_rounded,
                            title: l10n.landingRetroTitle, // 'Retrospective Board'
                            description: l10n.landingRetroSubtitle, // 'Raccogli feedback...'
                            color: AppColors.pink,
                            isDark: isDark,
                            features: [l10n.featureWentWell, l10n.featureToImprove, l10n.featureActions],
                          )),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Mobile - single column
                return Column(
                  children: [
                    _buildFeatureCard(
                      icon: Icons.check_circle_outline_rounded,
                      title: l10n.toolSmartTodo,
                      description: l10n.toolSmartTodoDescShort,
                      color: Colors.blue,
                      isDark: isDark,
                      features: [l10n.featureSmartImport, l10n.featureCollaboration, l10n.featureFilters],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.grid_view_rounded,
                      title: l10n.toolEisenhower,
                      description: l10n.landingEisenhowerSubtitle,
                      color: AppColors.success,
                      isDark: isDark,
                      features: [l10n.feature4Quadrants, l10n.featureDragDrop, l10n.featureCollaborative],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.casino_rounded,
                      title: l10n.toolEstimation,
                      description: l10n.landingEstimationSubtitle,
                      color: Colors.amber,
                      isDark: isDark,
                      features: [l10n.featurePlanningPoker, l10n.featureTshirtSize, l10n.featureRealtime],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.rocket_launch_rounded,
                      title: l10n.landingAgileTitle,
                      description: l10n.landingAgileSubtitle,
                      color: AppColors.primary,
                      isDark: isDark,
                      features: [l10n.featureScrum, l10n.featureKanban, l10n.featureHybrid],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureCard(
                      icon: Icons.psychology_rounded,
                      title: l10n.landingRetroTitle,
                      description: l10n.landingRetroSubtitle,
                      color: AppColors.pink,
                      isDark: isDark,
                      features: [l10n.featureWentWell, l10n.featureToImprove, l10n.featureActions],
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
    List<String> features = const [],
  }) {
    return _HoverScaleCard(
      isDark: isDark,
      builder: (context, _) => Container(
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
            if (features.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: features.map((f) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withValues(alpha: 0.15)),
                  ),
                  child: Text(
                    f,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIntegratedDesktopLayout(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    
    // Use MediaQuery because we are in a ScrollView, so LayoutBuilder gives infinite height
    final screenHeight = MediaQuery.of(context).size.height;
    // More aggressive compact mode for smaller laptop screens
    final isCompact = screenHeight < 900;
    
    final verticalPadding = isCompact ? 16.0 : 40.0; // Further reduced
    final spacerFlex = isCompact ? 1 : 2;
    final gap = isCompact ? 8.0 : 24.0; // Further reduced
    
    return Container(
      // Allow it to shrink for smaller screens, but keep reasonable min height
      constraints: const BoxConstraints(minHeight: 600),
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: verticalPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the whole block
            children: [
              // Top Row: Smart Todo & Eisenhower
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              Expanded(
                child: _buildCompactFeatureCard(
                  icon: Icons.check_circle_outline_rounded,
                      title: l10n.toolSmartTodo,
                      description: l10n.toolSmartTodoDescShort,
                      color: Colors.blue,
                      isDark: isDark,
                      isCompact: isCompact,
                    ),
                  ),
                  Spacer(flex: spacerFlex), 
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.grid_view_rounded,
                      title: l10n.toolEisenhower,
                      description: l10n.landingEisenhowerSubtitle,
                      color: AppColors.success,
                      isDark: isDark,
                      isCompact: isCompact,
                    ),
                  ),
                ],
              ),
              
              // Center Hero
              SizedBox(height: gap),
              _buildHeroCenterContent(isDark, isCompact: isCompact),
              SizedBox(height: gap),

              // Bottom Row: Agile & Retro
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.rocket_launch_rounded,
                      title: l10n.landingAgileTitle,
                      description: l10n.landingAgileSubtitle,
                      color: AppColors.primary,
                      isDark: isDark,
                      isCompact: isCompact,
                    ),
                  ),
                  Spacer(flex: spacerFlex),
                  Expanded(
                    child: _buildCompactFeatureCard(
                      icon: Icons.psychology_rounded,
                      title: l10n.landingRetroTitle,
                      description: l10n.landingRetroSubtitle,
                      color: AppColors.pink,
                      isDark: isDark,
                      isCompact: isCompact,
                    ),
                  ),
                ],
              ),

              // 5th Element: Estimation Room
              SizedBox(height: gap),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _buildCompactFeatureCard(
                  icon: Icons.casino_rounded,
                  title: l10n.toolEstimation,
                  description: l10n.landingEstimationSubtitle,
                  color: Colors.amber,
                  isDark: isDark,
                  centerAlign: true,
                  isCompact: isCompact,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeroCenterContent(bool isDark, {bool isCompact = false}) {
    final l10n = AppLocalizations.of(context)!;
    
    // Force line break for compact mode if requested
    String subtitle = l10n.landingHeroSubtitle;
    if (isCompact && subtitle.contains('. All')) {
      subtitle = subtitle.replaceFirst('. All', '.\nAll');
    }

    return Column(
      children: [
         // Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12 : 16, 
              vertical: isCompact ? 6 : 8
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: isCompact ? 14 : 16, color: AppColors.primaryLight),
                SizedBox(width: 8),
                Text(
                  l10n.landingBadge, 
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w500,
                    fontSize: isCompact ? 12 : 13,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isCompact ? 16 : 24),
          Text(
            l10n.landingHeroTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isCompact ? 42 : 64, // Reduced further for compact
              fontWeight: FontWeight.bold,
              height: 1.1,
              letterSpacing: -1.5,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: isCompact ? 12 : 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isCompact ? 15 : 20, 
                color: context.textSecondaryColor,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: isCompact ? 20 : 40),
           _HoverButton(
            onTap: _signInWithGoogle,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 24 : 32, 
                vertical: isCompact ? 16 : 20
              ),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.landingStartFree,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCompact ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCompactFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required bool isDark,
    bool centerAlign = false,
    bool isCompact = false,
  }) {
    // Cleaner version of feature card for the integrated view
    // Less padding, slightly smaller text to fit nicely
    return _HoverScaleCard(
      isDark: isDark,
      glowColor: color, // Pass the color for value-based glow
      builder: (context, isHovered) {
        return Container(
          // Constrain width to make tiles narrower as requested
          constraints: const BoxConstraints(maxWidth: 280), 
          padding: EdgeInsets.all(isCompact ? 12 : 24), // Reduced padding
          decoration: BoxDecoration(
            color: isHovered 
                ? null // Use gradient if hovered
                : context.surfaceColor.withOpacity(0.8), 
            gradient: isHovered
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.surfaceColor.withOpacity(0.9),
                      color.withValues(alpha: 0.15), // Subtle tint of the icon color
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered 
                  ? color.withValues(alpha: 0.5) // Brighter border on hover
                  : context.borderColor.withOpacity(0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isCompact ? 8 : 12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: isCompact ? 18 : 24),
              ),
              SizedBox(height: isCompact ? 8 : 16),
              Text(
                title,
                textAlign: centerAlign ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: isCompact ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: context.textPrimaryColor,
                ),
              ),
              SizedBox(height: isCompact ? 4 : 8),
              Text(
                description,
                textAlign: centerAlign ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: isCompact ? 12 : 13,
                  color: context.textSecondaryColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: SMART TODO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSmartTodoSection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.surfaceColor,
            context.backgroundColor,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            badge: l10n.landingSmartTodoBadge,
            title: l10n.landingSmartTodoTitle,
            subtitle: l10n.landingSmartTodoSubtitle,
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Main content
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.check_circle_outline_rounded,
            iconColor: Colors.blue,
            title: l10n.landingSmartTodoCollabTitle,
            description: l10n.landingSmartTodoCollabDesc,
            features: l10n.landingSmartTodoCollabFeatures.split('\n'),
          ),

          const SizedBox(height: 60),

          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: false,
            icon: Icons.upload_file_rounded,
            iconColor: Colors.teal,
            title: l10n.landingSmartTodoImportTitle,
            description: l10n.landingSmartTodoImportDesc,
            features: l10n.landingSmartTodoImportFeatures.split('\n'),
          ),

          const SizedBox(height: 60),

          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.people_outline_rounded,
            iconColor: Colors.purple,
            title: l10n.landingSmartTodoSharingTitle,
            description: l10n.landingSmartTodoSharingDesc,
            features: l10n.landingSmartTodoSharingFeatures.split('\n'),
          ),

          const SizedBox(height: 48),

          // Feature chips
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Icon(Icons.tips_and_updates_rounded, color: Colors.blue, size: 32),
                const SizedBox(height: 16),
                Text(
                  l10n.landingSmartTodoFeaturesTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFeatureChip(Icons.filter_list, l10n.landingSmartTodoChipFilters),
                    _buildFeatureChip(Icons.search, l10n.landingSmartTodoChipSearch),
                    _buildFeatureChip(Icons.sort, l10n.landingSmartTodoChipSort),
                    _buildFeatureChip(Icons.label_outline, l10n.landingSmartTodoChipTags),
                    _buildFeatureChip(Icons.archive_outlined, l10n.landingSmartTodoChipArchive),
                    _buildFeatureChip(Icons.download, l10n.landingSmartTodoChipExport),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: MATRICE EISENHOWER
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildEisenhowerSection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
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
          _buildSectionHeader(
            badge: l10n.landingEisenhowerBadge,
            title: l10n.landingEisenhowerTitle,
            subtitle: l10n.landingEisenhowerSubtitle,
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Eisenhower explanation
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: false,
            icon: Icons.apps_rounded,
            iconColor: AppColors.success,
            title: l10n.landingEisenhowerUrgentTitle,
            description: l10n.landingEisenhowerUrgentDesc,
            features: l10n.landingEisenhowerUrgentFeatures.split('\n'),
          ),

          const SizedBox(height: 60),

          // The four quadrants visual
          _buildEisenhowerMatrix(isMobile, isDark),

          const SizedBox(height: 60),

          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.psychology_rounded,
            iconColor: Colors.deepPurple,
            title: l10n.landingEisenhowerDecisionsTitle,
            description: l10n.landingEisenhowerDecisionsDesc,
            features: l10n.landingEisenhowerDecisionsFeatures.split('\n'),
          ),

          const SizedBox(height: 48),

          // Benefits
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: AppColors.success, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                        l10n.landingEisenhowerBenefitsTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.landingEisenhowerBenefitsDesc,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEisenhowerMatrix(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    const double labelWidth = 32;
    const double gap = 8;

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        children: [
          // Top labels row - aligned with quadrants
          Padding(
            padding: const EdgeInsets.only(left: labelWidth + gap),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      l10n.landingEisenhowerUrgentLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: context.textSecondaryColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: gap),
                Expanded(
                  child: Center(
                    child: Text(
                      l10n.landingEisenhowerNotUrgentLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: context.textSecondaryColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Matrix grid with left labels
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left labels column
                SizedBox(
                  width: labelWidth,
                  child: Column(
                    children: [
                      // IMPORTANTE label - centered with top row
                      Expanded(
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              l10n.landingEisenhowerImportantLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: context.textSecondaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: gap),
                      // NON IMPORTANTE label - centered with bottom row
                      Expanded(
                        child: Center(
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              l10n.landingEisenhowerNotImportantLabel,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: context.textSecondaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: gap),
                // Quadrants grid
                Expanded(
                  child: Column(
                    children: [
                      // Top row: FAI + PIANIFICA
                      Row(
                        children: [
                          Expanded(child: _buildQuadrant(
                            title: l10n.landingEisenhowerDoLabel,
                            subtitle: l10n.landingEisenhowerDoDesc,
                            color: Colors.red,
                            icon: Icons.bolt,
                          )),
                          const SizedBox(width: gap),
                          Expanded(child: _buildQuadrant(
                            title: l10n.landingEisenhowerPlanLabel,
                            subtitle: l10n.landingEisenhowerPlanDesc,
                            color: Colors.green,
                            icon: Icons.calendar_today,
                          )),
                        ],
                      ),
                      const SizedBox(height: gap),
                      // Bottom row: DELEGA + ELIMINA
                      Row(
                        children: [
                          Expanded(child: _buildQuadrant(
                            title: l10n.landingEisenhowerDelegateLabel,
                            subtitle: l10n.landingEisenhowerDelegateDesc,
                            color: Colors.orange,
                            icon: Icons.person_add,
                          )),
                          const SizedBox(width: gap),
                          Expanded(child: _buildQuadrant(
                            title: l10n.landingEisenhowerEliminateLabel,
                            subtitle: l10n.landingEisenhowerEliminateDesc,
                            color: Colors.grey,
                            icon: Icons.delete_outline,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuadrant({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: METODOLOGIE AGILE
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAgileMethodologySection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.surfaceColor,
            context.backgroundColor,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            badge: l10n.landingAgileSectionBadge,
            title: l10n.landingAgileSectionTitle,
            subtitle: l10n.landingAgileSectionSubtitle,
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Agile Overview
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.loop_rounded,
            iconColor: AppColors.primary,
            title: l10n.landingAgileIterativeTitle,
            description: l10n.landingAgileIterativeDesc,
            features: l10n.landingIntroFeatures.split('\n'),
          ),

          const SizedBox(height: 60),

          // Scrum Framework
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: false,
            icon: Icons.groups_rounded,
            iconColor: AppColors.secondary,
            title: l10n.landingAgileScrumTitle,
            description: l10n.landingAgileScrumDesc,
            features: l10n.landingAgileScrumFeatures.split('\n'),
          ),

          const SizedBox(height: 60),

          // Kanban
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.view_kanban_rounded,
            iconColor: Colors.orange,
            title: l10n.landingAgileKanbanTitle,
            description: l10n.landingAgileKanbanDesc,
            features: l10n.landingAgileKanbanFeatures.split('\n'),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: METODI DI STIMA
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildEstimationMethodsSection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
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
          _buildSectionHeader(
            badge: l10n.landingEstimationBadge, // 'Estimation'
            title: l10n.landingEstimationTitle, // 'Tecniche di Stima Collaborative'
            subtitle: l10n.landingEstimationSubtitle, // 'Scegli il metodo...'
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Estimation Methods Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildEstimationCard(
                    icon: Icons.style_rounded,
                    title: l10n.estimationModeFibonacci,
                    subtitle: l10n.cardSetFibonacci, // 'Fibonacci (0, 1...)'
                    description: l10n.landingEstimationPokerDesc,
                    values: ['1', '2', '3', '5', '8', '13', '21', '?'],
                    color: AppColors.secondary,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.checkroom_rounded,
                    title: l10n.landingEstimationTShirtTitle,
                    subtitle: l10n.landingEstimationTShirtSubtitle,
                    description: l10n.landingEstimationTShirtDesc,
                    values: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                    color: Colors.purple,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.functions_rounded,
                    title: l10n.landingEstimationPertTitle,
                    subtitle: l10n.landingEstimationPertSubtitle,
                    description: l10n.landingEstimationPertDesc,
                    values: ['O', 'M', 'P', '=', 'PERT'],
                    color: Colors.teal,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.inventory_2_rounded,
                    title: l10n.landingEstimationBucketTitle,
                    subtitle: l10n.landingEstimationBucketSubtitle,
                    description: l10n.landingEstimationBucketDesc,
                    values: ['0', '1', '2', '3', '4', '5', '8', '13+'],
                    color: Colors.indigo,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 48),

          // Features highlight
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.borderColor),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 32,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.landingEstimationFeaturesTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 32,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFeatureChip(Icons.visibility_off, l10n.landingEstimationChipHiddenVote),
                    _buildFeatureChip(Icons.timer, l10n.landingEstimationChipTimer),
                    _buildFeatureChip(Icons.bar_chart, l10n.landingEstimationChipStats),
                    _buildFeatureChip(Icons.people, l10n.landingEstimationChipParticipants),
                    _buildFeatureChip(Icons.history, l10n.landingEstimationChipHistory),
                    _buildFeatureChip(Icons.download, l10n.landingEstimationChipExport),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstimationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required List<String> values,
    required Color color,
    required bool isDark,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Values display
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: values.map((v) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Text(
                v,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: TIPI DI RETROSPETTIVA
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildRetrospectiveTypesSection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.surfaceColor,
            context.backgroundColor,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildSectionHeader(
            badge: l10n.landingRetroBadge, // 'Retrospective'
            title: l10n.landingRetroTitle, // 'Retrospettive Interattive'
            subtitle: l10n.landingRetroSubtitle, // 'Strumenti collaborativi...'
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Retrospective Templates
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;

              if (isWide) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildRetroCard(
                          title: l10n.landingRetroTemplateStartStopTitle,
                          emoji: '🚦',
                          description: l10n.landingRetroTemplateStartStopDesc,
                          columns: ['Start', 'Stop', 'Continue'],
                          columnColors: [Colors.green, Colors.red, Colors.blue],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: l10n.landingRetroTemplateMadSadTitle,
                          emoji: '😊',
                          description: l10n.landingRetroTemplateMadSadDesc,
                          columns: ['Mad', 'Sad', 'Glad'],
                          columnColors: [Colors.red, Colors.blue, Colors.green],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: l10n.landingRetroTemplate4LsTitle,
                          emoji: '📝',
                          description: l10n.landingRetroTemplate4LsDesc,
                          columns: ['Liked', 'Learned', 'Lacked', 'Longed'],
                          columnColors: [Colors.green, Colors.blue, Colors.orange, Colors.purple],
                          isDark: isDark,
                        )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildRetroCard(
                          title: l10n.landingRetroTemplateWentWellTitle,
                          emoji: '✨',
                          description: l10n.landingRetroTemplateWentWellDesc,
                          columns: ['Went Well', 'To Improve'],
                          columnColors: [Colors.green, Colors.orange],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: l10n.landingRetroTemplateDakiTitle,
                          emoji: '🎯',
                          description: l10n.landingRetroTemplateDakiDesc,
                          columns: ['Drop', 'Add', 'Keep', 'Improve'],
                          columnColors: [Colors.red, Colors.green, Colors.blue, Colors.purple],
                          isDark: isDark,
                        )),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildRetroCard(
                      title: l10n.landingRetroTemplateStartStopTitle,
                      emoji: '🚦',
                      description: l10n.landingRetroTemplateStartStopDesc,
                      columns: ['Start', 'Stop', 'Continue'],
                      columnColors: [Colors.green, Colors.red, Colors.blue],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: l10n.landingRetroTemplateMadSadTitle,
                      emoji: '😊',
                      description: l10n.landingRetroTemplateMadSadDesc,
                      columns: ['Mad', 'Sad', 'Glad'],
                      columnColors: [Colors.red, Colors.blue, Colors.green],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: l10n.landingRetroTemplate4LsTitle,
                      emoji: '📝',
                      description: l10n.landingRetroTemplate4LsDesc,
                      columns: ['Liked', 'Learned', 'Lacked', 'Longed'],
                      columnColors: [Colors.green, Colors.blue, Colors.orange, Colors.purple],
                      isDark: isDark,
                    ),
                    /* Removed Sailboat as requested
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: l10n.landingRetroTemplateSailboatTitle,
                      emoji: '⛵',
                      description: l10n.landingRetroTemplateSailboatDesc,
                      columns: ['Wind', 'Anchor', 'Rocks', 'Island'],
                      columnColors: [Colors.teal, Colors.grey, Colors.red, Colors.amber],
                      isDark: isDark,
                    ),
                    */
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 48),

          // Retrospective features
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.orange, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.landingRetroFeatureTrackingTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.landingRetroFeatureTrackingDesc,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetroCard({
    required String title,
    required String emoji,
    required String description,
    required List<String> columns,
    required List<Color> columnColors,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          // Column preview
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(columns.length, (i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: columnColors[i].withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                columns[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: columnColors[i],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: WORKFLOW
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildWorkflowSection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
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
          _buildSectionHeader(
            badge: l10n.landingWorkflowBadge, // 'Workflow'
            title: l10n.landingWorkflowTitle, // 'Come funziona'
            subtitle: l10n.landingWorkflowSubtitle, // 'Inizia in 3 semplici passi'
            isMobile: isMobile,
          ),
          const SizedBox(height: 60),

          // Steps
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;

              if (isWide) {
                return Row(
                  children: [
                    Expanded(child: _buildStepCard(
                      step: '1',
                      title: l10n.landingStep1Title, // 'Crea un progetto'
                      description: l10n.landingStep1Desc, // 'Crea il tuo progetto...'
                      icon: Icons.add_circle_outline,
                      color: AppColors.primary,
                      isDark: isDark,
                    )),
                    _buildStepConnector(isDark),
                    Expanded(child: _buildStepCard(
                      step: '2',
                      title: l10n.landingStep2Title, // 'Collabora'
                      description: l10n.landingStep2Desc, // 'Stima le user stories...'
                      icon: Icons.people_outline,
                      color: AppColors.secondary,
                      isDark: isDark,
                    )),
                    _buildStepConnector(isDark),
                    Expanded(child: _buildStepCard(
                      step: '3',
                      title: l10n.landingStep3Title, // 'Migliora'
                      description: l10n.landingStep3Desc, // 'Analizza le metriche...'
                      icon: Icons.trending_up,
                      color: AppColors.success,
                      isDark: isDark,
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildStepCard(
                      step: '1',
                      title: l10n.landingStep1Title,
                      description: l10n.landingStep1Desc,
                      icon: Icons.add_circle_outline,
                      color: AppColors.primary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildStepCard(
                      step: '2',
                      title: l10n.landingStep2Title,
                      description: l10n.landingStep2Desc,
                      icon: Icons.people_outline,
                      color: AppColors.secondary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildStepCard(
                      step: '3',
                      title: l10n.landingStep3Title,
                      description: l10n.landingStep3Desc,
                      icon: Icons.trending_up,
                      color: AppColors.success,
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

  Widget _buildStepCard({
    required String step,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      step,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isDark) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.borderColor,
            AppColors.primary.withValues(alpha: 0.5),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CTA SECTION
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildCTASection(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
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
            l10n.landingCtaTitle, // 'Ready to start?'
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
            l10n.landingCtaDesc, // 'Accedi gratuitamente...'
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
                    l10n.authSignInGoogle, // 'Accedi con Google' - REUSED
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

  // ═══════════════════════════════════════════════════════════════════════════
  // FOOTER COMPLETO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFullFooter(bool isMobile, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 48,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0D0D0F) : const Color(0xFFF8F9FA),
        border: Border(
          top: BorderSide(color: context.borderSubtleColor),
        ),
      ),
      child: Column(
        children: [
          // Footer content
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand column
                    Expanded(
                      flex: 2,
                      child: _buildFooterBrand(),
                    ),
                    const SizedBox(width: 48),
                    // Links columns
                    Expanded(child: _buildFooterColumn(l10n.landingFooterProduct, [
                      l10n.landingFooterFeatures,
                      l10n.landingFooterPricing,
                      l10n.landingFooterChangelog,
                      l10n.landingFooterRoadmap,
                    ])),
                    Expanded(child: _buildFooterColumn(l10n.landingFooterResources, [
                      l10n.landingFooterDocs,
                      l10n.landingFooterAgileGuides,
                      l10n.landingFooterBlog,
                      l10n.landingFooterCommunity,
                    ])),
                    Expanded(child: _buildFooterColumn(l10n.landingFooterCompany, [
                      l10n.landingFooterAbout,
                      l10n.landingFooterContact,
                      l10n.landingFooterJobs,
                      l10n.landingFooterPress,
                    ])),
                    Expanded(child: _buildFooterColumn(l10n.landingFooterLegal, [
                      l10n.landingFooterPrivacy,
                      l10n.landingFooterTerms,
                      l10n.landingFooterCookies,
                      l10n.landingFooterGdpr,
                    ])),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildFooterBrand(),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFooterColumn(l10n.landingFooterProduct, [
                          l10n.landingFooterFeatures,
                          l10n.landingFooterPricing,
                        ])),
                        Expanded(child: _buildFooterColumn(l10n.landingFooterLegal, [
                          l10n.landingFooterPrivacy,
                          l10n.landingFooterTerms,
                        ])),
                      ],
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 48),

          // Divider
          Container(
            height: 1,
            color: context.borderSubtleColor,
          ),

          const SizedBox(height: 24),

          // Bottom bar
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;

              if (isWide) {
                return Row(
                  children: [
                    Text(
                      l10n.landingCopyright, // '© 2025 Keisen...'
                      style: TextStyle(
                        color: context.textMutedColor,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    _buildSocialLinks(),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildSocialLinks(),
                    const SizedBox(height: 16),
                    Text(
                      l10n.landingCopyright,
                      style: TextStyle(
                        color: context.textMutedColor,
                        fontSize: 13,
                      ),
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

  Widget _buildFooterBrand() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/icons/app_icon.png',
                height: 32,
                filterQuality: FilterQuality.medium,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Keisen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.textPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        Text(
          l10n.landingFooterBrandDesc, // 'Strumenti collaborativi...'
          style: TextStyle(
            fontSize: 13,
            color: context.textSecondaryColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        // Contact email
        Row(
          children: [
            Icon(Icons.email_outlined, size: 16, color: context.textMutedColor),
            const SizedBox(width: 8),
            Text(
              'suppkesien@gmail.com',
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Support buttons
        _buildSupportLink(
          icon: Icons.bug_report_outlined,
          label: l10n.localeName == 'it' ? 'Segnala Bug' : 'Report Bug',
          onTap: () => _launchEmail(l10n.localeName == 'it' ? '[Segnalazione Bug] ' : '[Bug Report] '),
        ),
        const SizedBox(height: 8),
        _buildSupportLink(
          icon: Icons.lightbulb_outline,
          label: l10n.localeName == 'it' ? 'Richiedi Feature' : 'Request Feature',
          onTap: () => _launchEmail(l10n.localeName == 'it' ? '[Richiesta Feature] ' : '[Feature Request] '),
        ),
      ],
    );
  }

  Widget _buildSupportLink({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: context.textSecondaryColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _HoverButton(
            onTap: () => _onFooterLinkTap(link),
            child: Text(
              link,
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        )),
      ],
    );
  }

  void _onFooterLinkTap(String link) {
    final l10n = AppLocalizations.of(context)!;
    Widget? screen;
    
    if (link == l10n.landingFooterPrivacy) {
      screen = PrivacyPolicyScreen();
    } else if (link == l10n.landingFooterTerms) {
      screen = TermsOfServiceScreen();
    }
    else if (link == l10n.landingFooterCookies) {
      screen = CookiePolicyScreen();
    } else if (link == l10n.landingFooterGdpr) {
      screen = GdprScreen();
    } else {
      return;
    }

    if (screen != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => screen!),
      );
    }
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialButton(Icons.language, 'Website'),
        const SizedBox(width: 8),
        _buildSocialButton(Icons.code, 'GitHub'),
        const SizedBox(width: 8),
        _buildSocialButton(Icons.chat_bubble_outline, 'Twitter'),
        const SizedBox(width: 8),
        _buildSocialButton(Icons.work_outline, 'LinkedIn'),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String tooltip) {
    return _HoverButton(
      onTap: () {
        // TODO: Open social link
      },
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.borderColor),
          ),
          child: Icon(icon, size: 18, color: context.textSecondaryColor),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSectionHeader({
    required String badge,
    required String title,
    required String subtitle,
    required bool isMobile,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            badge,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: context.textTertiaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBlock({
    required bool isMobile,
    required bool isDark,
    required bool imageOnLeft,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required List<String> features,
  }) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: context.textSecondaryColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        ...features.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: iconColor, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  f,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );

    final illustration = Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            iconColor.withValues(alpha: 0.12),
            iconColor.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: iconColor.withValues(alpha: 0.25)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decorative elements
          Positioned(
            top: 10,
            right: 20,
            child: Icon(Icons.circle, color: iconColor.withValues(alpha: 0.1), size: 40),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            child: Icon(Icons.square_rounded, color: iconColor.withValues(alpha: 0.08), size: 30),
          ),
          // Main icon - large and visible
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main icon container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 20),
              // Secondary icons row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMiniIconBox(Icons.check_circle_outline, iconColor),
                  const SizedBox(width: 8),
                  _buildMiniIconBox(Icons.trending_up, iconColor),
                  const SizedBox(width: 8),
                  _buildMiniIconBox(Icons.group_outlined, iconColor),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    if (isMobile) {
      return Column(
        children: [
          illustration,
          const SizedBox(height: 32),
          content,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: imageOnLeft
          ? [
              Expanded(child: illustration),
              const SizedBox(width: 60),
              Expanded(child: content),
            ]
          : [
              Expanded(child: content),
              const SizedBox(width: 60),
              Expanded(child: illustration),
            ],
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMiniIconBox(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }


}


/// Widget per effetto hover con scale e glow colorato
class _HoverScaleCard extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder; // Changed to builder
  final double scale;
  final bool isDark;
  final Color? glowColor;

  const _HoverScaleCard({
    required this.builder,
    this.scale = 1.03,
    required this.isDark,
    this.glowColor,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        transform: Matrix4.identity()..scale(_isHovered ? widget.scale : 1.0),
        transformAlignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), // Match child radius
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: (widget.glowColor ?? AppColors.primary).withValues(alpha: widget.isDark ? 0.25 : 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: (widget.glowColor ?? AppColors.primary).withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: Offset.zero,
                    ),
                  ]
                : [],
          ),
          child: widget.builder(context, _isHovered), // Use builder
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

/// Pulse Animation for Logo
class _PulseLogo extends StatefulWidget {
  final Widget child;

  const _PulseLogo({required this.child});

  @override
  State<_PulseLogo> createState() => _PulseLogoState();
}

class _PulseLogoState extends State<_PulseLogo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); 

    // Scale: 1.0 -> 1.05
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Opacity: 1.0 -> 0.8
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

