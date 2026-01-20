import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final service = FavoriteService();
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
            child: Row(
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
                const Spacer(),
                _buildFilterDropdown(l10n),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<FavoriteModel>>(
              stream: service.streamFavoritesExcludingArchived(),
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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: filters.map((f) {
        final isSelected = _selectedFilter == f['value'];
        return Tooltip(
          message: f['tooltip'] as String,
          child: InkWell(
            onTap: () => setState(() => _selectedFilter = f['value'] as String),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber.withValues(alpha: 0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: isSelected ? Border.all(color: Colors.amber.withValues(alpha: 0.5), width: 1) : null,
              ),
              child: Icon(
                f['icon'] as IconData,
                size: 20,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: context.surfaceVariantColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 32,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                      fontSize: 14,
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
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.star, size: 20, color: Colors.amber), // Classic yellow
              onPressed: () {
                FavoriteService().toggleFavorite(
                  resourceId: item.resourceId,
                  type: item.type,
                  title: item.title,
                );
              },
              tooltip: l10n.actionRemoveFromFavorites,
            ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, size: 20, color: context.textTertiaryColor),
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

  void _navigateToResource(BuildContext context) {
    switch (item.type) {
      case 'todo_list':
        Navigator.pushNamed(context, '/smart-todo', arguments: {'id': item.resourceId});
        break;
      case 'eisenhower_matrix':
        Navigator.pushNamed(context, '/eisenhower', arguments: {'id': item.resourceId});
        break;
      case 'agile_project':
        Navigator.pushNamed(context, '/agile-project', arguments: {'id': item.resourceId});
        break;
      case 'retro':
      case 'retrospective':
        Navigator.pushNamed(context, '/retrospective-board', arguments: {'id': item.resourceId});
        break;
      case 'poker':
      case 'planning_poker':
        Navigator.pushNamed(context, '/estimation-room', arguments: {'id': item.resourceId});
        break;
    }
  }
}
