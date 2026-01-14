import 'package:flutter/material.dart';
import '../../models/estimation_mode.dart';

/// Widget per selezionare la modalità di stima
/// Mostra una griglia di opzioni con icone e descrizioni
class EstimationModeSelector extends StatelessWidget {
  final EstimationMode selectedMode;
  final ValueChanged<EstimationMode> onModeSelected;
  final bool showDescriptions;
  final bool showSyncBadge;

  const EstimationModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
    this.showDescriptions = true,
    this.showSyncBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Modalità di Stima',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: EstimationMode.values.map((mode) {
            return _EstimationModeCard(
              mode: mode,
              isSelected: mode == selectedMode,
              onTap: () => onModeSelected(mode),
              showDescription: showDescriptions,
              showSyncBadge: showSyncBadge,
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Card singola per una modalità di stima
class _EstimationModeCard extends StatelessWidget {
  final EstimationMode mode;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showDescription;
  final bool showSyncBadge;

  const _EstimationModeCard({
    required this.mode,
    required this.isSelected,
    required this.onTap,
    required this.showDescription,
    required this.showSyncBadge,
  });

  IconData _getIcon() {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.analytics;
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.view_column;
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Theme.of(context).primaryColor : Colors.grey[400]!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: showDescription ? 160 : 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Icon(
                  _getIcon(),
                  size: 32,
                  color: color,
                ),
                if (showSyncBadge && mode.isSyncable)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.sync,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              mode.displayName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            if (showDescription) ...[
              const SizedBox(height: 4),
              Text(
                mode.description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Widget compatto per mostrare la modalità selezionata (read-only)
class EstimationModeBadge extends StatelessWidget {
  final EstimationMode mode;
  final bool showSyncIndicator;

  const EstimationModeBadge({
    super.key,
    required this.mode,
    this.showSyncIndicator = true,
  });

  IconData _getIcon() {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.analytics;
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.view_column;
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: 16,
            color: Colors.blue[700],
          ),
          const SizedBox(width: 6),
          Text(
            mode.displayName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
          if (showSyncIndicator && mode.isSyncable) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.sync,
              size: 12,
              color: Colors.green[600],
            ),
          ],
        ],
      ),
    );
  }
}

/// Dropdown compatto per selezione rapida della modalità
class EstimationModeDropdown extends StatelessWidget {
  final EstimationMode value;
  final ValueChanged<EstimationMode> onChanged;
  final bool onlyShowSyncable;

  const EstimationModeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.onlyShowSyncable = false,
  });

  IconData _getIcon(EstimationMode mode) {
    switch (mode) {
      case EstimationMode.fibonacci:
        return Icons.style;
      case EstimationMode.tshirt:
        return Icons.checkroom;
      case EstimationMode.decimal:
        return Icons.calculate;
      case EstimationMode.threePoint:
        return Icons.analytics;
      case EstimationMode.dotVoting:
        return Icons.radio_button_checked;
      case EstimationMode.bucketSystem:
        return Icons.view_column;
      case EstimationMode.fiveFingers:
        return Icons.pan_tool;
    }
  }

  @override
  Widget build(BuildContext context) {
    final modes = onlyShowSyncable
        ? EstimationMode.values.where((m) => m.isSyncable).toList()
        : EstimationMode.values;

    return DropdownButton<EstimationMode>(
      value: value,
      onChanged: (mode) {
        if (mode != null) onChanged(mode);
      },
      underline: const SizedBox(),
      items: modes.map((mode) {
        return DropdownMenuItem(
          value: mode,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getIcon(mode), size: 18),
              const SizedBox(width: 8),
              Text(mode.displayName),
              if (mode.isSyncable)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.sync,
                    size: 12,
                    color: Colors.green[600],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
