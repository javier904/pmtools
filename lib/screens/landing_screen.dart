import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../main.dart';

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
            _buildSmartTodoSection(isMobile, isDark),
            _buildEisenhowerSection(isMobile, isDark),
            _buildAgileMethodologySection(isMobile, isDark),
            _buildEstimationMethodsSection(isMobile, isDark),
            _buildRetrospectiveTypesSection(isMobile, isDark),
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
Image.asset(
                  'assets/icons/app_logo.png',
                  width: 36,
                  height: 36,
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

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: SMART TODO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSmartTodoSection(bool isMobile, bool isDark) {
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
            badge: 'Produttivita',
            title: 'Smart Todo List',
            subtitle: 'Gestione task intelligente e collaborativa per team moderni',
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
            title: 'Liste Task Collaborative',
            description: '''Smart Todo trasforma la gestione delle attivita quotidiane in un processo fluido e collaborativo. Crea liste, assegna task ai membri del team e monitora il progresso in tempo reale.

Ideale per team distribuiti che necessitano di sincronizzazione continua sulle attivita da completare.''',
            features: [
              'Creazione rapida task con descrizione',
              'Assegnazione a membri del team',
              'Priorita e deadline configurabili',
              'Notifiche di completamento',
            ],
          ),

          const SizedBox(height: 60),

          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: false,
            icon: Icons.upload_file_rounded,
            iconColor: Colors.teal,
            title: 'Import Flessibile',
            description: '''Importa le tue attivita da fonti esterne in pochi click. Supporto per file CSV, copia/incolla da Excel o testo libero. Il sistema riconosce automaticamente la struttura dei dati.

Migra facilmente da altri tool senza perdere informazioni o dover reinserire manualmente ogni task.''',
            features: [
              'Import da file CSV',
              'Copia/incolla da Excel',
              'Parsing testo intelligente',
              'Mapping campi automatico',
            ],
          ),

          const SizedBox(height: 60),

          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.people_outline_rounded,
            iconColor: Colors.purple,
            title: 'Condivisione e Inviti',
            description: '''Invita colleghi e collaboratori alle tue liste tramite email. Ogni partecipante puo visualizzare, commentare e aggiornare lo stato dei task assegnati.

Perfetto per gestire progetti trasversali con stakeholder esterni o team cross-funzionali.''',
            features: [
              'Inviti via email',
              'Permessi configurabili',
              'Commenti sui task',
              'Storico modifiche',
            ],
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
                  'Funzionalita Smart Todo',
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
                    _buildFeatureChip(Icons.filter_list, 'Filtri avanzati'),
                    _buildFeatureChip(Icons.search, 'Ricerca full-text'),
                    _buildFeatureChip(Icons.sort, 'Ordinamento'),
                    _buildFeatureChip(Icons.label_outline, 'Tag e categorie'),
                    _buildFeatureChip(Icons.archive_outlined, 'Archiviazione'),
                    _buildFeatureChip(Icons.download, 'Export dati'),
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
            badge: 'Prioritizzazione',
            title: 'Matrice di Eisenhower',
            subtitle: 'Il metodo decisionale usato dai leader per gestire il tempo',
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
            title: 'Urgente vs Importante',
            description: '''La Matrice di Eisenhower, ideata dal 34° Presidente degli Stati Uniti Dwight D. Eisenhower, divide le attivita in quattro quadranti basati su due criteri: urgenza e importanza.

Questo framework decisionale aiuta a distinguere cio che richiede attenzione immediata da cio che contribuisce agli obiettivi a lungo termine.''',
            features: [
              'Quadrante 1: Urgente + Importante → Fai subito',
              'Quadrante 2: Non urgente + Importante → Pianifica',
              'Quadrante 3: Urgente + Non importante → Delega',
              'Quadrante 4: Non urgente + Non importante → Elimina',
            ],
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
            title: 'Decisioni Migliori',
            description: '''Applicando costantemente la matrice, sviluppi un mindset orientato ai risultati. Impari a dire "no" alle distrazioni e a concentrarti su cio che genera valore reale.

Il nostro strumento digitale rende questo processo immediato: trascina le attivita nel quadrante corretto e ottieni una visione chiara delle tue priorita.''',
            features: [
              'Drag & drop intuitivo',
              'Collaborazione team in tempo reale',
              'Statistiche di distribuzione',
              'Export per reportistica',
            ],
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
                        'Perche usare la Matrice di Eisenhower?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Studi dimostrano che il 80% delle attivita quotidiane ricade nei quadranti 3 e 4 (non importanti). La matrice ti aiuta a identificarle e liberare tempo per cio che conta davvero.',
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
                      'URGENTE',
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
                      'NON URGENTE',
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
                              'IMPORTANTE',
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
                              'NON IMPORTANTE',
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
                            title: 'FAI',
                            subtitle: 'Crisi, deadline, emergenze',
                            color: Colors.red,
                            icon: Icons.bolt,
                          )),
                          const SizedBox(width: gap),
                          Expanded(child: _buildQuadrant(
                            title: 'PIANIFICA',
                            subtitle: 'Strategia, crescita, relazioni',
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
                            title: 'DELEGA',
                            subtitle: 'Interruzioni, meeting, email',
                            color: Colors.orange,
                            icon: Icons.person_add,
                          )),
                          const SizedBox(width: gap),
                          Expanded(child: _buildQuadrant(
                            title: 'ELIMINA',
                            subtitle: 'Distrazioni, perdite di tempo',
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
            badge: 'Metodologie',
            title: 'Agile & Scrum Framework',
            subtitle: 'Implementa le migliori pratiche di sviluppo software iterativo',
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
            title: 'Sviluppo Iterativo e Incrementale',
            description: '''L'approccio Agile divide il lavoro in cicli brevi chiamati Sprint, tipicamente di 1-4 settimane. Ogni iterazione produce un incremento funzionante del prodotto.

Con Agile Tools puoi gestire il tuo backlog, pianificare sprint e monitorare la velocity del team in tempo reale.''',
            features: [
              'Sprint Planning con capacita team',
              'Backlog prioritizzato con drag & drop',
              'Velocity tracking e burndown chart',
              'Daily standup facilitato',
            ],
          ),

          const SizedBox(height: 60),

          // Scrum Framework
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: false,
            icon: Icons.groups_rounded,
            iconColor: AppColors.secondary,
            title: 'Framework Scrum',
            description: '''Scrum e il framework Agile piu diffuso. Definisce ruoli (Product Owner, Scrum Master, Team), eventi (Sprint Planning, Daily, Review, Retrospective) e artefatti (Product Backlog, Sprint Backlog).

Agile Tools supporta tutti gli eventi Scrum con strumenti dedicati per ogni cerimonia.''',
            features: [
              'Product Backlog con story points',
              'Sprint Backlog con task breakdown',
              'Retrospective board integrata',
              'Metriche Scrum automatiche',
            ],
          ),

          const SizedBox(height: 60),

          // Kanban
          _buildInfoBlock(
            isMobile: isMobile,
            isDark: isDark,
            imageOnLeft: true,
            icon: Icons.view_kanban_rounded,
            iconColor: Colors.orange,
            title: 'Kanban Board',
            description: '''Il metodo Kanban visualizza il flusso di lavoro attraverso colonne che rappresentano gli stati del processo. Limita il Work In Progress (WIP) per massimizzare il throughput.

La nostra Kanban board supporta personalizzazione delle colonne, WIP limits e metriche di flusso.''',
            features: [
              'Colonne personalizzabili',
              'WIP limits per colonna',
              'Drag & drop intuitivo',
              'Lead time e cycle time',
            ],
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SEZIONE: METODI DI STIMA
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildEstimationMethodsSection(bool isMobile, bool isDark) {
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
            badge: 'Estimation',
            title: 'Tecniche di Stima Collaborative',
            subtitle: 'Scegli il metodo piu adatto al tuo team per stime accurate',
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
                    title: 'Planning Poker',
                    subtitle: 'Sequenza Fibonacci',
                    description: 'Il metodo classico: ogni membro sceglie una carta (1, 2, 3, 5, 8, 13, 21...). Le stime sono rivelate simultaneamente per evitare bias.',
                    values: ['1', '2', '3', '5', '8', '13', '21', '?'],
                    color: AppColors.secondary,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.checkroom_rounded,
                    title: 'T-Shirt Sizing',
                    subtitle: 'Taglie relative',
                    description: 'Stima rapida usando taglie: XS, S, M, L, XL, XXL. Ideale per backlog grooming iniziale o quando serve una stima approssimativa.',
                    values: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                    color: Colors.purple,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.functions_rounded,
                    title: 'Three-Point (PERT)',
                    subtitle: 'Ottimista / Probabile / Pessimista',
                    description: 'Tecnica statistica: ogni membro fornisce 3 stime (O, M, P). La formula PERT calcola la stima ponderata: (O + 4M + P) / 6.',
                    values: ['O', 'M', 'P', '=', 'PERT'],
                    color: Colors.teal,
                    isDark: isDark,
                    width: isWide ? (constraints.maxWidth - 48) / 2 : constraints.maxWidth,
                  ),
                  _buildEstimationCard(
                    icon: Icons.inventory_2_rounded,
                    title: 'Bucket System',
                    subtitle: 'Categorizzazione rapida',
                    description: 'Le user stories vengono assegnate a "bucket" predefiniti. Ottimo per stimare grandi quantita di item velocemente in sessioni di refinement.',
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
                  'Estimation Room Features',
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
                    _buildFeatureChip(Icons.visibility_off, 'Voto nascosto'),
                    _buildFeatureChip(Icons.timer, 'Timer configurabile'),
                    _buildFeatureChip(Icons.bar_chart, 'Statistiche real-time'),
                    _buildFeatureChip(Icons.people, 'Fino a 20 partecipanti'),
                    _buildFeatureChip(Icons.history, 'Storico stime'),
                    _buildFeatureChip(Icons.download, 'Export risultati'),
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
            badge: 'Retrospective',
            title: 'Template per Retrospettive',
            subtitle: 'Formati collaudati per sessioni di miglioramento continuo',
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
                          title: 'Start / Stop / Continue',
                          emoji: '🚦',
                          description: 'Il formato classico: cosa iniziare a fare, cosa smettere di fare, cosa continuare a fare.',
                          columns: ['Start', 'Stop', 'Continue'],
                          columnColors: [Colors.green, Colors.red, Colors.blue],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: 'Mad / Sad / Glad',
                          emoji: '😊',
                          description: 'Retrospettiva emotiva: cosa ci ha fatto arrabbiare, rattristare o rallegrare.',
                          columns: ['Mad', 'Sad', 'Glad'],
                          columnColors: [Colors.red, Colors.blue, Colors.green],
                          isDark: isDark,
                        )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildRetroCard(
                          title: '4L\'s',
                          emoji: '📝',
                          description: 'Liked, Learned, Lacked, Longed For - analisi completa dello sprint.',
                          columns: ['Liked', 'Learned', 'Lacked', 'Longed'],
                          columnColors: [Colors.green, Colors.blue, Colors.orange, Colors.purple],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: 'Sailboat',
                          emoji: '⛵',
                          description: 'Metafora visuale: vento (aiuti), ancora (ostacoli), rocce (rischi), isola (obiettivi).',
                          columns: ['Wind', 'Anchor', 'Rocks', 'Island'],
                          columnColors: [Colors.teal, Colors.grey, Colors.red, Colors.amber],
                          isDark: isDark,
                        )),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildRetroCard(
                          title: 'Went Well / To Improve',
                          emoji: '✨',
                          description: 'Formato semplice e diretto: cosa e andato bene e cosa migliorare.',
                          columns: ['Went Well', 'To Improve'],
                          columnColors: [Colors.green, Colors.orange],
                          isDark: isDark,
                        )),
                        const SizedBox(width: 24),
                        Expanded(child: _buildRetroCard(
                          title: 'DAKI',
                          emoji: '🎯',
                          description: 'Drop, Add, Keep, Improve - decisioni concrete per il prossimo sprint.',
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
                      title: 'Start / Stop / Continue',
                      emoji: '🚦',
                      description: 'Il formato classico per retrospettive efficaci.',
                      columns: ['Start', 'Stop', 'Continue'],
                      columnColors: [Colors.green, Colors.red, Colors.blue],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: 'Mad / Sad / Glad',
                      emoji: '😊',
                      description: 'Retrospettiva emotiva per il team.',
                      columns: ['Mad', 'Sad', 'Glad'],
                      columnColors: [Colors.red, Colors.blue, Colors.green],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: '4L\'s',
                      emoji: '📝',
                      description: 'Analisi completa dello sprint passato.',
                      columns: ['Liked', 'Learned', 'Lacked', 'Longed'],
                      columnColors: [Colors.green, Colors.blue, Colors.orange, Colors.purple],
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildRetroCard(
                      title: 'Sailboat',
                      emoji: '⛵',
                      description: 'Metafora visuale per analisi team.',
                      columns: ['Wind', 'Anchor', 'Rocks', 'Island'],
                      columnColors: [Colors.teal, Colors.grey, Colors.red, Colors.amber],
                      isDark: isDark,
                    ),
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
                        'Action Items Tracking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: context.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ogni retrospettiva genera action items tracciabili con owner, deadline e stato. Monitora il follow-up nel tempo.',
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
            badge: 'Workflow',
            title: 'Come funziona',
            subtitle: 'Inizia in 3 semplici passi',
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
                      title: 'Crea un progetto',
                      description: 'Crea il tuo progetto Agile e invita il team. Configura sprint, backlog e board.',
                      icon: Icons.add_circle_outline,
                      color: AppColors.primary,
                      isDark: isDark,
                    )),
                    _buildStepConnector(isDark),
                    Expanded(child: _buildStepCard(
                      step: '2',
                      title: 'Collabora',
                      description: 'Stima le user stories insieme, organizza sprint e traccia il progresso in real-time.',
                      icon: Icons.people_outline,
                      color: AppColors.secondary,
                      isDark: isDark,
                    )),
                    _buildStepConnector(isDark),
                    Expanded(child: _buildStepCard(
                      step: '3',
                      title: 'Migliora',
                      description: 'Analizza le metriche, conduci retrospettive e migliora continuamente il processo.',
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
                      title: 'Crea un progetto',
                      description: 'Crea il tuo progetto Agile e invita il team.',
                      icon: Icons.add_circle_outline,
                      color: AppColors.primary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildStepCard(
                      step: '2',
                      title: 'Collabora',
                      description: 'Stima le user stories insieme e traccia il progresso.',
                      icon: Icons.people_outline,
                      color: AppColors.secondary,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildStepCard(
                      step: '3',
                      title: 'Migliora',
                      description: 'Analizza metriche e conduci retrospettive.',
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

  // ═══════════════════════════════════════════════════════════════════════════
  // FOOTER COMPLETO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFullFooter(bool isMobile, bool isDark) {
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
                    Expanded(child: _buildFooterColumn('Prodotto', [
                      'Funzionalita',
                      'Pricing',
                      'Changelog',
                      'Roadmap',
                    ])),
                    Expanded(child: _buildFooterColumn('Risorse', [
                      'Documentazione',
                      'Guide Agile',
                      'Blog',
                      'Community',
                    ])),
                    Expanded(child: _buildFooterColumn('Azienda', [
                      'Chi siamo',
                      'Contatti',
                      'Lavora con noi',
                      'Press Kit',
                    ])),
                    Expanded(child: _buildFooterColumn('Legale', [
                      'Privacy Policy',
                      'Termini di Servizio',
                      'Cookie Policy',
                      'GDPR',
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
                        Expanded(child: _buildFooterColumn('Prodotto', [
                          'Funzionalita',
                          'Pricing',
                        ])),
                        Expanded(child: _buildFooterColumn('Legale', [
                          'Privacy Policy',
                          'Termini',
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
                      '© 2025 Agile Tools. Tutti i diritti riservati.',
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
                      '© 2025 Agile Tools. Tutti i diritti riservati.',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
Image.asset(
              'assets/icons/app_logo.png',
              width: 36,
              height: 36,
            ),
            const SizedBox(width: 12),
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
        const SizedBox(height: 16),
        Text(
          'Strumenti collaborativi per team agili.\nPianifica, stima e migliora insieme.',
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
              'support@agiletools.app',
              style: TextStyle(
                fontSize: 13,
                color: context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ],
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
            onTap: () {
              // TODO: Navigate to link
            },
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
