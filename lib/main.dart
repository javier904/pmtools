import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kIsWeb;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/eisenhower_screen.dart';
import 'screens/estimation_room_screen.dart';
import 'screens/agile_process_screen.dart';
import 'screens/agile_project_loader_screen.dart';
import 'screens/retrospective/retro_global_dashboard.dart';
import 'screens/retro_board_loader_screen.dart';
import 'screens/smart_todo/smart_todo_dashboard.dart';
import 'screens/profile_screen.dart';
import 'themes/app_theme.dart';
import 'controllers/locale_controller.dart';
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/legal/terms_of_service_screen.dart';
import 'screens/legal/cookie_policy_screen.dart';
import 'screens/legal/gdpr_screen.dart';
import 'screens/invite_landing_screen.dart';
import 'widgets/legal/cookie_consent_banner.dart';
import 'models/unified_invite_model.dart';

void main() async {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Carica preferenze salvate
  final prefs = await SharedPreferences.getInstance();
  final savedThemeMode = prefs.getString('themeMode') ?? 'dark';
  
  // Rilevamento lingua: 1. Preferenza salvata, 2. Lingua sistema (solo se loggato), 3. Default 'en'
  String initialLocale = prefs.getString('locale') ?? '';
  if (initialLocale.isEmpty) {
    final currentUser = FirebaseAuth.instance.currentUser;
    // Se non loggato, default 'en'. Se loggato, prova lingua di sistema.
    if (currentUser == null) {
      initialLocale = 'en';
    } else {
      final systemLocale = PlatformDispatcher.instance.locale.languageCode;
      // Verifica se la lingua di sistema è supportata, altrimenti 'en'
      if (['it', 'en', 'fr', 'es'].contains(systemLocale)) {
        initialLocale = systemLocale;
      } else {
        initialLocale = 'en';
      }
    }
  }

  // Carica stato cookie
  final initialCookieConsent = prefs.getBool('cookie_consent_accepted');

  runApp(AgileToolsApp(
    initialThemeMode: savedThemeMode,
    initialLocale: initialLocale,
    initialCookieConsent: initialCookieConsent,
  ));
}

/// Controller globale per il tema
class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeController(String initialMode)
      : _themeMode = _stringToThemeMode(initialMode);

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark ||
      (_themeMode == ThemeMode.system &&
       WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  static ThemeMode _stringToThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
      default:
        return 'dark';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    // Salva preferenza
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeModeToString(mode));
  }

  /// Toggle tra dark e light mode
  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }
}

/// InheritedWidget per accesso al ThemeController
class ThemeControllerProvider extends InheritedNotifier<ThemeController> {
  const ThemeControllerProvider({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>();
    return provider!.notifier!;
  }

  static ThemeController? maybeOf(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>();
    return provider?.notifier;
  }
}

class AgileToolsApp extends StatefulWidget {
  final String initialThemeMode;
  final String initialLocale;
  final bool? initialCookieConsent;

  const AgileToolsApp({
    super.key,
    required this.initialThemeMode,
    required this.initialLocale,
    this.initialCookieConsent,
  });

  @override
  State<AgileToolsApp> createState() => _AgileToolsAppState();
}

class _AgileToolsAppState extends State<AgileToolsApp> {
  late final ThemeController _themeController;
  late final LocaleController _localeController;

  @override
  void initState() {
    super.initState();
    _themeController = ThemeController(widget.initialThemeMode);
    _localeController = LocaleController(widget.initialLocale);
  }

  @override
  void dispose() {
    _themeController.dispose();
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeControllerProvider(
      controller: _themeController,
      child: LocaleControllerProvider(
        controller: _localeController,
        child: ListenableBuilder(
          listenable: Listenable.merge([_themeController, _localeController]),
          builder: (context, child) {
            return MaterialApp(
              title: 'Keisen',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: _themeController.themeMode,
              // Localizzazione
              locale: _localeController.locale,
              supportedLocales: LocaleController.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const AuthWrapper(),
              routes: {
                '/login': (context) => const LoginScreen(),
                '/home': (context) => const _AuthGuard(child: HomeScreen()),
                '/profile': (context) => const _AuthGuard(child: ProfileScreen()),
                // '/eisenhower' gestito in onGenerateRoute per supportare arguments
                // '/estimation-room' gestito in onGenerateRoute per supportare arguments
                '/agile-process': (context) => const _AuthGuard(child: AgileProcessScreen()),
                '/agile-project': (context) => const _AuthGuard(child: AgileProjectLoaderScreen()),
                '/retrospective-list': (context) => const _AuthGuard(child: RetroGlobalDashboard()),
                '/retrospective-board': (context) => const _AuthGuard(child: RetroBoardLoaderScreen()),
                '/smart-todo': (context) => const _AuthGuard(child: SmartTodoDashboard()),
                '/privacy': (context) => const PrivacyPolicyScreen(),
                '/terms': (context) => const TermsOfServiceScreen(),
                '/cookies': (context) => const CookiePolicyScreen(),
                '/gdpr': (context) => const GdprScreen(),
              },
              onGenerateRoute: (settings) {
                // Gestione route con arguments
                final args = settings.arguments as Map<String, dynamic>?;

                // Route /eisenhower (con o senza matrixId)
                if (settings.name == '/eisenhower') {
                  final matrixId = args?['matrixId'] as String?;
                  return MaterialPageRoute(
                    builder: (context) => _AuthGuard(
                      child: EisenhowerScreen(
                        initialMatrixId: matrixId,
                      ),
                    ),
                    settings: settings,
                  );
                }

                // Route /estimation-room (con o senza sessionId)
                if (settings.name == '/estimation-room') {
                  final sessionId = args?['sessionId'] as String?;
                  return MaterialPageRoute(
                    builder: (context) => _AuthGuard(
                      child: EstimationRoomScreen(
                        initialSessionId: sessionId,
                      ),
                    ),
                    settings: settings,
                  );
                }

                // Deep link per inviti: /invite/{type}/{sourceId}
                final uri = Uri.parse(settings.name ?? '');
                final segments = uri.pathSegments;

                if (segments.length >= 3 && segments[0] == 'invite') {
                  final typeStr = segments[1];
                  final sourceId = segments[2];
                  final inviteId = segments.length > 3 ? segments[3] : null;

                  InviteSourceType? sourceType;
                  switch (typeStr) {
                    case 'eisenhower':
                      sourceType = InviteSourceType.eisenhower;
                      break;
                    case 'estimation-room':
                      sourceType = InviteSourceType.estimationRoom;
                      break;
                    case 'agile-project':
                      sourceType = InviteSourceType.agileProject;
                      break;
                    case 'smart-todo':
                      sourceType = InviteSourceType.smartTodo;
                      break;
                    case 'retro-board':
                      sourceType = InviteSourceType.retroBoard;
                      break;
                  }

                  if (sourceType != null) {
                    final type = sourceType;
                    return MaterialPageRoute(
                      builder: (context) => InviteLandingScreen(
                        sourceType: type,
                        sourceId: sourceId,
                        inviteId: inviteId,
                      ),
                      settings: settings,
                    );
                  }
                }

                // Fallback per route non trovate
                return null;
              },
              builder: (context, child) {
                return Stack(
                  children: [
                    child!,
                    CookieConsentBanner(
                      initialConsent: widget.initialCookieConsent,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Guard che reindirizza alla LandingScreen se non autenticato
class _AuthGuard extends StatelessWidget {
  final Widget child;

  const _AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return child;
        }
        return const LandingScreen();
      },
    );
  }
}

/// Wrapper che gestisce lo stato di autenticazione
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          final l10n = AppLocalizations.of(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  if (l10n != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      l10n.stateLoading,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        // Autenticato → Home
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // Non autenticato → Landing Page
        return const LandingScreen();
      },
    );
  }
}
