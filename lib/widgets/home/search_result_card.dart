import 'package:flutter/material.dart';
import '../../models/search_result_item.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import 'favorite_star.dart';

class SearchResultCard extends StatelessWidget {
  final SearchResultItem item;
  final VoidCallback onTap;

  const SearchResultCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = item.colorHex != null 
        ? Color(int.parse(item.colorHex!.replaceFirst('#', '0xFF'))) 
        : AppColors.primary;
    
    // Determine icon based on type if not overridden
    final iconData = item.iconOverride ?? _getIconForType(item.type);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // Opacità ridotta se archiviato
      child: Opacity(
        opacity: item.isArchived ? 0.7 : 1.0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon with background circle
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: bgColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(iconData, color: bgColor, size: 28),
                    ),
                    const SizedBox(height: 12),

                    // Title
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.textSecondaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Footer: Type label + Favorite
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.surfaceVariantColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _getTypeLabel(context, item.type).toUpperCase(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ),
                        FavoriteStar(
                          resourceId: item.id,
                          type: _getFavoriteType(item.type),
                          title: item.title,
                          colorHex: item.colorHex ?? '#000000',
                          size: 16,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Badge "Archiviato" in alto a destra
              if (item.isArchived)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inventory_2, size: 10, color: Colors.white),
                        SizedBox(width: 3),
                        Text(
                          'ARCHIVIO',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(SearchResultType type) {
    switch (type) {
      case SearchResultType.project: return Icons.rocket_launch_rounded;
      case SearchResultType.todo: return Icons.check_circle_outline_rounded;
      case SearchResultType.retro: return Icons.psychology_rounded;
      case SearchResultType.eisenhower: return Icons.grid_view_rounded;
      case SearchResultType.estimation: return Icons.casino_rounded;
    }
  }

  String _getTypeLabel(BuildContext context, SearchResultType type) {
    // For now returning generic labels, ideally localized
    // But since we are inside a widget, we can access l10n if we passed it or imported it.
    // Let's use simple strings for now or add localization logic
    switch (type) {
      case SearchResultType.project: return 'Project';
      case SearchResultType.todo: return 'Todo';
      case SearchResultType.retro: return 'Retro';
      case SearchResultType.eisenhower: return 'Matrix';
      case SearchResultType.estimation: return 'Poker';
    }
  }

  String _getFavoriteType(SearchResultType type) {
    switch (type) {
      case SearchResultType.project: return 'agile_project';
      case SearchResultType.todo: return 'smart_todo_list';
      case SearchResultType.retro: return 'retrospective';
      case SearchResultType.eisenhower: return 'eisenhower'; // Might not be supported yet
      case SearchResultType.estimation: return 'poker_session'; // Might not be supported yet
    }
  }
}
