import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per stimare una User Story
///
/// Supporta diversi metodi di stima:
/// - Planning Poker (Fibonacci)
/// - T-Shirt sizing
/// - Three-Point (PERT)
/// - Bucket System
class StoryEstimationDialog extends StatefulWidget {
  final UserStoryModel story;
  final String currentUserEmail;
  final EstimationType initialMethod;

  const StoryEstimationDialog({
    super.key,
    required this.story,
    required this.currentUserEmail,
    this.initialMethod = EstimationType.planningPoker,
  });

  static Future<StoryEstimate?> show({
    required BuildContext context,
    required UserStoryModel story,
    required String currentUserEmail,
    EstimationType initialMethod = EstimationType.planningPoker,
  }) {
    return showDialog<StoryEstimate>(
      context: context,
      builder: (context) => StoryEstimationDialog(
        story: story,
        currentUserEmail: currentUserEmail,
        initialMethod: initialMethod,
      ),
    );
  }

  @override
  State<StoryEstimationDialog> createState() => _StoryEstimationDialogState();
}

class _StoryEstimationDialogState extends State<StoryEstimationDialog> {
  late EstimationType _selectedMethod;
  String? _selectedValue;

  // Three-point values
  double? _optimistic;
  double? _mostLikely;
  double? _pessimistic;

  // Fibonacci values for Planning Poker
  static const fibonacciValues = ['0', '1', '2', '3', '5', '8', '13', '21', '?', '☕'];

  // T-Shirt sizes
  static const tshirtValues = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  // Bucket values
  static const bucketValues = ['0', '1', '2', '3', '4', '5', '8', '13', '20', '40', '100'];

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialMethod;

    // Load existing estimate if any
    final existingEstimate = widget.story.estimates[widget.currentUserEmail];
    if (existingEstimate != null) {
      _selectedValue = existingEstimate.value;
    }
  }

  void _submit() {
    String? finalValue;

    if (_selectedMethod == EstimationType.threePoint) {
      if (_optimistic != null && _mostLikely != null && _pessimistic != null) {
        // PERT formula: (O + 4M + P) / 6
        final pertEstimate = (_optimistic! + 4 * _mostLikely! + _pessimistic!) / 6;
        finalValue = pertEstimate.toStringAsFixed(1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.agileEstErrorThreePoint)),
        );
        return;
      }
    } else {
      if (_selectedValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.agileEstErrorSelect)),
        );
        return;
      }
      finalValue = _selectedValue;
    }

    final estimate = StoryEstimate(
      voterEmail: widget.currentUserEmail,
      voterName: widget.currentUserEmail.split('@').first,
      value: finalValue!,
      votedAt: DateTime.now(),
      type: _selectedMethod,
    );

    Navigator.pop(context, estimate);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.calculate, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.agileEstTitle),
                Text(
                  widget.story.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Method selector
              Text(
                l10n.agileEstMethod,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: EstimationType.values.map((method) => ChoiceChip(
                  label: Text(_getMethodDisplayName(method, l10n)),
                  selected: _selectedMethod == method,
                  onSelected: (_) => setState(() {
                    _selectedMethod = method;
                    _selectedValue = null;
                  }),
                  avatar: Icon(method.icon, size: 16),
                )).toList(),
              ),
              const SizedBox(height: 24),

              // Estimation interface based on method
              _buildEstimationInterface(),

              // Existing estimates
              if (widget.story.estimates.isNotEmpty) ...[
                const Divider(height: 32),
                Text(
                  l10n.agileEstExisting(widget.story.estimates.length),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ...widget.story.estimates.entries.map((entry) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    child: Text(
                      entry.key[0].toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: AppColors.primary),
                    ),
                  ),
                  title: Text(entry.key),
                  subtitle: Text(
                    '${entry.value.type.displayName}: ${entry.value.value}',
                  ),
                  trailing: entry.key == widget.currentUserEmail
                      ? Chip(
                          label: Text(l10n.agileEstYou, style: const TextStyle(fontSize: 10)),
                          padding: EdgeInsets.zero,
                        )
                      : null,
                )),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.agileEstCancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.agileEstSubmit),
        ),
      ],
    );
  }

  Widget _buildEstimationInterface() {
    final l10n = AppLocalizations.of(context)!;
    switch (_selectedMethod) {
      case EstimationType.planningPoker:
        return _buildPlanningPokerInterface(l10n);
      case EstimationType.tshirt:
        return _buildTShirtInterface(l10n);
      case EstimationType.threePoint:
        return _buildThreePointInterface(l10n);
      case EstimationType.bucket:
        return _buildBucketInterface(l10n);
    }
  }

  Widget _buildPlanningPokerInterface(AppLocalizations l10n) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.agileEstPokerTitle,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.agileEstPokerDesc,
            style: TextStyle(fontSize: 12, color: context.textSecondaryColor),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: fibonacciValues.map((value) => _buildPokerCard(value)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPokerCard(String value) {
    final isSelected = _selectedValue == value;
    final isSpecial = value == '?' || value == '☕';

    return InkWell(
      onTap: () => setState(() => _selectedValue = value),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.purple
              : isSpecial
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Colors.purple
                : isSpecial
                    ? Colors.orange
                    : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? Colors.white
                  : isSpecial
                      ? Colors.orange
                      : Colors.purple,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTShirtInterface(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agileEstTShirtTitle,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.agileEstTShirtDesc,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: tshirtValues.map((size) {
            final isSelected = _selectedValue == size;
            return ChoiceChip(
              label: Text(
                size,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : null,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedValue = size),
              selectedColor: Colors.purple,
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.agileEstReference, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(l10n.agileEstRefXS, style: const TextStyle(fontSize: 12)),
              Text(l10n.agileEstRefS, style: const TextStyle(fontSize: 12)),
              Text(l10n.agileEstRefM, style: const TextStyle(fontSize: 12)),
              Text(l10n.agileEstRefL, style: const TextStyle(fontSize: 12)),
              Text(l10n.agileEstRefXL, style: const TextStyle(fontSize: 12)),
              Text(l10n.agileEstRefXXL, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreePointInterface(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agileEstThreePointTitle,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.agileEstThreePointDesc,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.agileEstOptimistic,
                  hintText: l10n.agileEstOptimisticHint,
                  border: const OutlineInputBorder(),
                  suffixText: l10n.agileEstPointsSuffix,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _optimistic = double.tryParse(value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.agileEstMostLikely,
                  hintText: l10n.agileEstMostLikelyHint,
                  border: const OutlineInputBorder(),
                  suffixText: l10n.agileEstPointsSuffix,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _mostLikely = double.tryParse(value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: l10n.agileEstPessimistic,
                  hintText: l10n.agileEstPessimisticHint,
                  border: const OutlineInputBorder(),
                  suffixText: l10n.agileEstPointsSuffix,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _pessimistic = double.tryParse(value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.agileEstFormula,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              if (_optimistic != null && _mostLikely != null && _pessimistic != null) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.agileEstResult(((_optimistic! + 4 * _mostLikely! + _pessimistic!) / 6).toStringAsFixed(1)),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBucketInterface(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agileEstBucketTitle,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.agileEstBucketDesc,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: bucketValues.map((value) {
              final isSelected = _selectedValue == value;
              final numValue = int.tryParse(value) ?? 0;
              final height = 50.0 + (numValue * 1.5);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedValue = value),
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 50,
                    height: height.clamp(50.0, 200.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? Colors.purple : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.purple,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.agileEstBucketHint,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  String _getMethodDisplayName(EstimationType method, AppLocalizations l10n) {
    switch (method) {
      case EstimationType.planningPoker:
        return 'Planning Poker'; // Usually kept in English or localized if needed
      case EstimationType.tshirt:
        return 'T-Shirt';
      case EstimationType.threePoint:
        return 'PERT (3-Point)';
      case EstimationType.bucket:
        return 'Bucket System';
    }
  }
}
