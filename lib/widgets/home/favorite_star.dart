import 'package:flutter/material.dart';
import '../../services/favorite_service.dart';

class FavoriteStar extends StatelessWidget {
  final String resourceId;
  final String type;
  final String title;
  final String? colorHex;
  final double size;

  const FavoriteStar({
    super.key,
    required this.resourceId,
    required this.type,
    required this.title,
    this.colorHex,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final service = FavoriteService();

    return StreamBuilder<bool>(
      stream: service.isFavorite(resourceId),
      builder: (context, snapshot) {
        final isFav = snapshot.data ?? false;

        return IconButton(
          icon: Icon(
            isFav ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isFav ? Colors.amber : Colors.grey.withValues(alpha: 0.5),
            size: size,
          ),
          onPressed: () => service.toggleFavorite(
            resourceId: resourceId,
            type: type,
            title: title,
            colorHex: colorHex,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: size,
          tooltip: isFav ? 'Rimuovi dai preferiti' : 'Aggiungi ai preferiti',
        );
      },
    );
  }
}
