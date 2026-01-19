import 'package:flutter/material.dart';
import 'package:animations/animations.dart'; 
import '../services/auth_service.dart';
import '../services/global_search_service.dart';
import '../models/search_result_item.dart';
import '../main.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/profile_menu_widget.dart';
import '../widgets/language_selector_widget.dart';
import '../widgets/home/section_favorites.dart';
import '../widgets/home/section_deadlines.dart';
import '../widgets/home/section_tools.dart';
import '../widgets/home/search_result_card.dart';
import 'agile_project_loader_screen.dart';
import 'smart_todo/smart_todo_dashboard.dart';
import 'retro_board_loader_screen.dart';
import 'estimation_room_screen.dart';
import 'eisenhower_screen.dart';

/// Home Screen - Dashboard stile Appwrite con supporto Dark/Light Theme
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalSearchService _searchService = GlobalSearchService();
  final AuthService _authService = AuthService();
  
  String _searchQuery = '';
  List<SearchResultItem> _searchResults = [];
  bool _isSearching = false;
  bool _isLoading = false;

  void _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchQuery = '';
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchQuery = query;
      _isLoading = true;
      _isSearching = true;
    });

    final user = _authService.currentUser;
    if (user != null) {
      final results = await _searchService.search(query, user.email ?? '');
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _isSearching = false;
      _searchResults = [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isDark = context.isDarkMode;
    final themeController = ThemeControllerProvider.maybeOf(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        surfaceTintColor: context.backgroundColor,
        leadingWidth: isMobile ? null : 250,
        leading: isMobile 
            ? (_isSearching 
                ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: _clearSearch) 
                : null) // Or Menu icon
            : Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  onTap: _clearSearch, // Reset search and show main dashboard
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
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
                      Expanded(
                        child: Text(
                          l10n.appTitle,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: context.textPrimaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        title: Container(
          constraints: const BoxConstraints(maxWidth: 300), // Increased width to 300
          height: 36, // Slightly clearer
          child: TextField(
            controller: _searchController,
            onSubmitted: _performSearch,
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: l10n.searchPlaceholder,
              hintStyle: TextStyle(color: context.textMutedColor, fontSize: 12),
              prefixIcon: Icon(Icons.search, size: 18, color: context.textSecondaryColor),
              suffixIcon: _searchController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                         _performSearch(_searchController.text);
                      },
                      child: const Icon(Icons.arrow_forward_rounded, size: 16),
                    ) 
                  : null, 
              filled: true,
              fillColor: context.surfaceVariantColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
            style: TextStyle(fontSize: 13, color: context.textPrimaryColor),
          ),
        ),
        centerTitle: true,
        actions: [
          // Language Selector
          if (!isMobile) const LanguageSelectorWidget(),
          const SizedBox(width: 4),
          // Theme Toggle Button
          if (themeController != null)
            _HoverIconButton(
              icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              tooltip: isDark ? l10n.themeLightMode : l10n.themeDarkMode,
              onTap: () => themeController.toggleTheme(),
            ),
          // Profile Menu
          if (user != null)
            ProfileMenuWidget(
              onProfileTap: () => Navigator.pushNamed(context, '/profile'),
              onLogout: () => _authService.signOut(),
              showSubscriptionBadge: true,
              avatarSize: 32,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Material( // Wrap in Material to avoid potential layer issues
        color: context.backgroundColor,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
             return FadeTransition(opacity: animation, child: SlideTransition(
               position: Tween<Offset>(
                 begin: const Offset(0, 0.05),
                 end: Offset.zero
               ).animate(animation),
               child: child,
             ));
          },
          child: _isSearching
              ? _buildSearchResults(context, l10n, isMobile)
              : Container(
                  key: const ValueKey('dashboard'), // Key for AnimatedSwitcher
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 32, vertical: 16),
                  // Use LayoutBuilder to constrain height if needed, or Expanded in Column logic
                  child: isMobile 
                      ? _buildMobileLayout(context, l10n)
                      : _buildDesktopLayout(context, l10n),
                ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, AppLocalizations l10n, bool isMobile) {
    if (_isLoading) {
      return Center(key: const ValueKey('loading'), child: const CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: context.textMutedColor),
            const SizedBox(height: 16),
            Text(
              l10n.searchNoResults(_searchQuery),
              style: TextStyle(fontSize: 16, color: context.textSecondaryColor),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _clearSearch,
              icon: const Icon(Icons.arrow_back),
              label: Text(l10n.searchBackToDashboard),
            )
          ],
        ),
      );
    }

    return SingleChildScrollView(
      key: const ValueKey('results'),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 32, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: _clearSearch,
                tooltip: l10n.searchBackToDashboard,
              ),
              const SizedBox(width: 8),
              Text(
                '${l10n.searchResultsTitle} (${_searchResults.length})',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: context.textPrimaryColor
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              // Responsive grid matching SectionTools/Estimation logic more or less
              // Adapting to full width search
              final crossAxisCount = width > 1400 ? 6 : width > 1100 ? 5 : width > 800 ? 4 : width > 550 ? 3 : 2;
              
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Scroll managed by SingleChildScrollView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0, 
                ),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  
                  return OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: const Duration(milliseconds: 500),
                    openBuilder: (context, action) {
                       // Return destination page
                      switch (item.route) {
                        case '/agile-project':
                          return const AgileProjectLoaderScreen();
                        case '/smart-todo':
                          return const SmartTodoDashboard();
                        case '/retrospective-board':
                          return const RetroBoardLoaderScreen();
                        case '/estimation-room':
                          return const EstimationRoomScreen();
                        case '/eisenhower':
                          return const EisenhowerScreen();
                        default:
                          // Fallback for unknown routes or if default nav preferred
                          // OpenContainer expects a widget to return. 
                          // If route is unknown, we might return a Scaffold error or just the home for now.
                          return Scaffold(body: Center(child: Text('Unknown route: ${item.route}')));
                      }
                    },
                    closedElevation: 0,
                    closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    closedColor: Colors.transparent,
                    closedBuilder: (context, action) {
                      return SearchResultCard(
                        item: item,
                        onTap: action, // OpenContainer action opens the container
                      );
                    },
                    routeSettings: RouteSettings(name: item.route, arguments: item.arguments),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(flex: 1, child: SectionFavorites()),
              const SizedBox(width: 24),
              const Expanded(flex: 1, child: SectionDeadlines()),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Expanded(flex: 1, child: SectionTools()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 400, child: SectionFavorites()),
          const SizedBox(height: 16),
          const SizedBox(height: 400, child: SectionDeadlines()),
          const SizedBox(height: 16),
          const SizedBox(height: 400, child: SectionTools()),
        ],
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
    return Tooltip(
      message: widget.tooltip,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hovering) => setState(() => _isHovered = hovering),
        borderRadius: BorderRadius.circular(8),
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
    );
  }
}
