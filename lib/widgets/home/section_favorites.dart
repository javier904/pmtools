import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/favorite_service.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

class SectionFavorites extends StatefulWidget {
  const SectionFavorites({super.key});

  @override
  State<SectionFavorites> createState() => _SectionFavoritesState();
}

class _SectionFavoritesState extends State<SectionFavorites> {
  String _selectedFilter = 'all';
  late final FavoriteService _service;
  late final Stream<List<FavoriteModel>> _favoritesStream;

  @override
  void initState() {
    super.initState();
    _service = FavoriteService();
    _favoritesStream = _service.streamFavoritesExcludingArchived();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 12,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      l10n.favTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                _buildFilterDropdown(l10n),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<FavoriteModel>>(
              stream: _favoritesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allFavorites = snapshot.data ?? [];
                final filtered = _selectedFilter == 'all'
                    ? allFavorites
                    : allFavorites.where((f) => f.type == _selectedFilter).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.favNoFavorites,
                      style: TextStyle(color: context.textMutedColor),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return _FavoriteItemTile(item: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(AppLocalizations l10n) {
    // Definizione dei filtri e delle icone
    final filters = [
      {'value': 'all', 'icon': Icons.filter_list_rounded, 'tooltip': l10n.favFilterAll},
      {'value': 'todo_list', 'icon': Icons.check_circle_outline_rounded, 'tooltip': l10n.favFilterTodo},
      {'value': 'eisenhower_matrix', 'icon': Icons.grid_view_rounded, 'tooltip': l10n.favFilterMatrix},
      {'value': 'agile_project', 'icon': Icons.rocket_launch_rounded, 'tooltip': l10n.favFilterProject},
      {'value': 'poker', 'icon': Icons.casino_rounded, 'tooltip': l10n.favFilterPoker},
      {'value': 'retro', 'icon': Icons.psychology_rounded, 'tooltip': l10n.favFilterRetro},
    ];

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.end,
      children: filters.map((f) {
        final isSelected = _selectedFilter == f['value'];
        return Tooltip(
          message: f['tooltip'] as String,
          child: InkWell(
            onTap: () => setState(() => _selectedFilter = f['value'] as String),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber.withValues(alpha: 0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected ? Border.all(color: Colors.amber.withValues(alpha: 0.5), width: 1) : null,
              ),
              child: Icon(
                f['icon'] as IconData,
                size: 18,
                color: isSelected ? Colors.amber[700] : context.textTertiaryColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FavoriteItemTile extends StatelessWidget {
  final FavoriteModel item;

  const _FavoriteItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Color color = _getSectionColor(item.type) ?? 
        (item.colorHex != null ? Color(int.parse(item.colorHex!.replaceFirst('#', '0xFF'))) : AppColors.primary);

    return InkWell(
      onTap: () => _navigateToResource(context),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Reduced padding
        decoration: BoxDecoration(
          color: context.surfaceVariantColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 6, // Marginally thinner accent line
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8), // Reduced spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                      fontSize: 13, // Slightly smaller
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _getTypeName(item.type, l10n),
                    style: TextStyle(
                      color: context.textMutedColor,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.star, size: 18, color: Colors.amber), // Smaller icon
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              splashRadius: 20,
              onPressed: () {
                FavoriteService().toggleFavorite(
                  resourceId: item.resourceId,
                  type: item.type,
                  title: item.title,
                );
              },
              tooltip: l10n.actionRemoveFromFavorites,
            ),
            Icon(Icons.chevron_right_rounded, size: 18, color: context.textTertiaryColor),
          ],
        ),
      ),
    );
  }

  Color? _getSectionColor(String type) {
    switch (type) {
      case 'eisenhower_matrix': return AppColors.success;
      case 'agile_project': return AppColors.primary;
      case 'todo_list': return AppColors.secondary; 
      case 'retro': 
      case 'retrospective': 
        return AppColors.pink;
      case 'poker':
      case 'planning_poker':
        return Colors.amber;
      default: return null;
    }
  }

  String _getTypeName(String type, AppLocalizations l10n) {
    switch (type) {
      case 'todo_list': return l10n.favTypeTodo;
      case 'eisenhower_matrix': return l10n.favTypeMatrix;
      case 'agile_project': return l10n.favTypeProject;
      case 'retro': 
      case 'retrospective': 
        return l10n.favTypeRetro;
      case 'poker': 
      case 'planning_poker': 
        return 'Estimation'; // Simplified label
      default: return l10n.favTypeTool; // Fallback
    }
  }

  void _navigateToResource(BuildContext context) async {
    // 🛡️ Verifica che la risorsa esista ancora prima di navigare
    // Questo gestisce il caso in cui la risorsa sia stata eliminata da un altro utente
    // e lo stream non l'abbia ancora rimossa localmente (o per sicurezza extra)
    final doc = await FirebaseFirestore.instance
        .collection(_getCollectionName(item.type))
        .doc(item.resourceId)
        .get();

    if (!doc.exists) {
      if (!context.mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Questa risorsa non è più disponibile o è stata eliminata.'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Rimuovi dai preferiti
      await FavoriteService().removeFavorite(item.resourceId);
      return;
    }

    if (!context.mounted) return;

    switch (item.type) {
      case 'todo_list':
        Navigator.pushNamed(context, '/smart-todo/${item.resourceId}');
        break;
      case 'eisenhower_matrix':
        Navigator.pushNamed(context, '/eisenhower/${item.resourceId}');
        break;
      case 'agile_project':
        Navigator.pushNamed(context, '/agile-project/${item.resourceId}');
        break;
      case 'retro':
      case 'retrospective':
        Navigator.pushNamed(context, '/retrospective-board/${item.resourceId}');
        break;
      case 'poker':
      case 'planning_poker':
        Navigator.pushNamed(context, '/estimation-room/${item.resourceId}');
        break;
    }
  }

  String _getCollectionName(String type) {
    switch (type) {
      case 'todo_list':
        return 'smart_todo_lists';
      case 'eisenhower_matrix':
        return 'eisenhower_matrices';
      case 'agile_project':
        return 'agile_projects';
      case 'poker':
      case 'planning_poker':
        return 'planning_poker_sessions';
      case 'retro':
      case 'retrospective':
        return 'retrospectives';
      default:
        return 'unknown';
    }
  }
}
