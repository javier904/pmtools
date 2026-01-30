import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Un widget avatar robusto che gestisce errori di caricamento immagini
/// e fornisce fallback eleganti (iniziali o icona).
class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name; // Usato per le iniziali
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? email; // Usato per generare colore se backgroundColor è null

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.name,
    this.radius = 20,
    this.backgroundColor,
    this.foregroundColor,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? _getAvatarColor(email ?? name ?? ''),
        backgroundImage: CachedNetworkImageProvider(imageUrl!),
        onBackgroundImageError: (exception, stackTrace) {
          // Fallback gestito silenziosamente - mostrerà il child
          debugPrint('Error loading avatar image: $exception');
        },
        child: _buildFallback(),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? _getAvatarColor(email ?? name ?? ''),
      child: _buildFallback(),
    );
  }

  Widget _buildFallback() {
    if (name != null && name!.isNotEmpty) {
      return Text(
        _getInitials(name!),
        style: TextStyle(
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
          color: foregroundColor ?? Colors.white,
        ),
      );
    }
    return Icon(
      Icons.person,
      size: radius * 1.2,
      color: foregroundColor ?? Colors.white,
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '?';
  }

  Color _getAvatarColor(String key) {
    if (key.isEmpty) return Colors.blue;
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.orange,
    ];
    return colors[key.hashCode.abs() % colors.length];
  }
}
