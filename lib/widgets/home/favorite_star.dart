import 'package:flutter/material.dart';
import '../../services/favorite_service.dart';

class FavoriteStar extends StatefulWidget {
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
  State<FavoriteStar> createState() => _FavoriteStarState();
}

class _FavoriteStarState extends State<FavoriteStar> {
  late final FavoriteService _service;
  late Stream<bool> _isFavoriteStream;

  @override
  void initState() {
    super.initState();
    _service = FavoriteService();
    _isFavoriteStream = _service.isFavorite(widget.resourceId);
  }

  @override
  void didUpdateWidget(FavoriteStar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resourceId != widget.resourceId) {
      setState(() {
        _isFavoriteStream = _service.isFavorite(widget.resourceId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isFavoriteStream,
      builder: (context, snapshot) {
        final isFav = snapshot.data ?? false;

        return IconButton(
          icon: Icon(
            isFav ? Icons.star_rounded : Icons.star_outline_rounded,
            color: isFav ? Colors.amber : Colors.grey.withValues(alpha: 0.5),
            size: widget.size,
          ),
          onPressed: () => _service.toggleFavorite(
            resourceId: widget.resourceId,
            type: widget.type,
            title: widget.title,
            colorHex: widget.colorHex,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          splashRadius: widget.size,
          tooltip: isFav ? 'Rimuovi dai preferiti' : 'Aggiungi ai preferiti',
        );
      },
    );
  }
}
