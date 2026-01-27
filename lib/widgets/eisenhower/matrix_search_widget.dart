import 'package:flutter/material.dart';
import 'dart:async';
import '../../l10n/app_localizations.dart';
import '../../models/eisenhower_matrix_model.dart';

/// Widget per cercare e filtrare le matrici di Eisenhower
class MatrixSearchWidget extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;

  const MatrixSearchWidget({
    super.key,
    required this.onSearchChanged,
  });

  @override
  State<MatrixSearchWidget> createState() => _MatrixSearchWidgetState();
}

class _MatrixSearchWidgetState extends State<MatrixSearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: l10n.eisenhowerSearchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  widget.onSearchChanged('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: _onSearchChanged,
    );
  }
}

/// Extension per filtrare le matrici
extension MatrixListFiltering on List<EisenhowerMatrixModel> {
  /// Filtra le matrici per testo di ricerca
  List<EisenhowerMatrixModel> searchByText(String query) {
    if (query.isEmpty) return this;
    final lowerQuery = query.toLowerCase();
    return where((matrix) {
      return matrix.title.toLowerCase().contains(lowerQuery) ||
          matrix.description.toLowerCase().contains(lowerQuery) ||
          (matrix.projectName?.toLowerCase().contains(lowerQuery) ?? false) ||
          (matrix.projectCode?.toLowerCase().contains(lowerQuery) ?? false) ||
          (matrix.teamName?.toLowerCase().contains(lowerQuery) ?? false) ||
          matrix.participants.values.any((p) =>
              p.name.toLowerCase().contains(lowerQuery) ||
              p.email.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  /// Applica tutti i filtri
  List<EisenhowerMatrixModel> applyFilters({
    String? searchQuery,
  }) {
    var result = this;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      result = result.searchByText(searchQuery);
    }
    return result;
  }
}
