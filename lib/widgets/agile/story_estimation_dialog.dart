import 'package:flutter/material.dart';
import '../../models/user_story_model.dart';
import '../../models/agile_enums.dart';

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
          const SnackBar(content: Text('Inserisci tutti e tre i valori')),
        );
        return;
      }
    } else {
      if (_selectedValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seleziona un valore')),
        );
        return;
      }
      finalValue = _selectedValue;
    }

    final estimate = StoryEstimate(
      participantEmail: widget.currentUserEmail,
      estimationType: _selectedMethod,
      value: finalValue!,
      timestamp: DateTime.now(),
    );

    Navigator.pop(context, estimate);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.calculate, color: Colors.purple),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Stima Story'),
                Text(
                  widget.story.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
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
              const Text(
                'Metodo di stima',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: EstimationType.values.map((method) => ChoiceChip(
                  label: Text(method.displayName),
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
                  'Stime esistenti (${widget.story.estimates.length})',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ...widget.story.estimates.entries.map((entry) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.purple.withOpacity(0.2),
                    child: Text(
                      entry.key[0].toUpperCase(),
                      style: const TextStyle(fontSize: 12, color: Colors.purple),
                    ),
                  ),
                  title: Text(entry.key),
                  subtitle: Text(
                    '${entry.value.estimationType.displayName}: ${entry.value.value}',
                  ),
                  trailing: entry.key == widget.currentUserEmail
                      ? const Chip(
                          label: Text('Tu', style: TextStyle(fontSize: 10)),
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
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: const Text('Conferma Stima'),
        ),
      ],
    );
  }

  Widget _buildEstimationInterface() {
    switch (_selectedMethod) {
      case EstimationType.planningPoker:
        return _buildPlanningPokerInterface();
      case EstimationType.tshirt:
        return _buildTShirtInterface();
      case EstimationType.threePoint:
        return _buildThreePointInterface();
      case EstimationType.bucket:
        return _buildBucketInterface();
    }
  }

  Widget _buildPlanningPokerInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Planning Poker (Fibonacci)',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          'Seleziona la complessità della story in story points',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: fibonacciValues.map((value) => _buildPokerCard(value)).toList(),
        ),
      ],
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

  Widget _buildTShirtInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'T-Shirt Sizing',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          'Seleziona la dimensione relativa della story',
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Riferimento:', style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              Text('XS = Poche ore', style: TextStyle(fontSize: 12)),
              Text('S = ~1 giorno', style: TextStyle(fontSize: 12)),
              Text('M = ~2-3 giorni', style: TextStyle(fontSize: 12)),
              Text('L = ~1 settimana', style: TextStyle(fontSize: 12)),
              Text('XL = ~2 settimane', style: TextStyle(fontSize: 12)),
              Text('XXL = Troppo grande, dividere', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreePointInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Three-Point Estimation (PERT)',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          'Inserisci tre valori per calcolare la stima PERT',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Ottimistica (O)',
                  hintText: 'Best case',
                  border: OutlineInputBorder(),
                  suffixText: 'pts',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _optimistic = double.tryParse(value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Più Probabile (M)',
                  hintText: 'Most likely',
                  border: OutlineInputBorder(),
                  suffixText: 'pts',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _mostLikely = double.tryParse(value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Pessimistica (P)',
                  hintText: 'Worst case',
                  border: OutlineInputBorder(),
                  suffixText: 'pts',
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
              const Text(
                'Formula PERT: (O + 4M + P) / 6',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              if (_optimistic != null && _mostLikely != null && _pessimistic != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Stima: ${((_optimistic! + 4 * _mostLikely! + _pessimistic!) / 6).toStringAsFixed(1)} punti',
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

  Widget _buildBucketInterface() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bucket System',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          'Posiziona la story nel bucket appropriato',
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
          'I bucket più grandi indicano story più complesse',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
