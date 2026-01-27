import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import 'dart:async';
import '../../l10n/app_localizations.dart';
import '../../models/eisenhower_matrix_model.dart';

/// Widget per cercare e filtrare le matrici di Eisenhower
class MatrixSearchWidget extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final TextEditingController? controller;

  const MatrixSearchWidget({
    super.key,
    required this.onSearchChanged,
    this.controller,
  });

  @override
  State<MatrixSearchWidget> createState() => _MatrixSearchWidgetState();
}

class _MatrixSearchWidgetState extends State<MatrixSearchWidget> {
  late TextEditingController _searchController;
  final bool _useInternalController = false; // logic handled in initState
  
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
  }

  @override
  void didUpdateWidget(MatrixSearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller && widget.controller != null) {
       _searchController = widget.controller!;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) {
      _searchController.dispose();
    }
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
        hintText: l10n?.eisenhowerSearchHint ?? 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  widget.onSearchChanged('');
                  // Force rebuild to hide clear button if needed, although text change listener handles it via controller? 
                  // In Flutter TextField, suffixIcon update usually needs setState unless AnimatedBuilder is used.
                  // Since we are in local state, we should setState to trigger rebuild of suffixIcon visibility
                  setState(() {}); 
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.success, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: (val) {
        // Trigger setState to show/hide clear icon
        setState(() {});
        _onSearchChanged(val);
      },
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
