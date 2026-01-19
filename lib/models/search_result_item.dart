import 'package:flutter/material.dart';

enum SearchResultType {
  project,
  todo,
  retro,
  eisenhower,
  estimation
}

class SearchResultItem {
  final String id;
  final String title;
  final String subtitle;
  final SearchResultType type;
  final String route;
  final Map<String, dynamic>? arguments;
  final DateTime? updatedAt;
  /// Optional HEX color string for the card background/accent
  final String? colorHex;
  /// Optional IconData for the card
  final IconData? iconOverride;

  SearchResultItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.route,
    this.arguments,
    this.updatedAt,
    this.colorHex,
    this.iconOverride,
  });
}
