import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget per inserimento di stime decimali
/// Permette input libero di numeri con virgola (es: 1.5, 2.75, 0.5)
class DecimalInputWidget extends StatefulWidget {
  final double? initialValue;
  final ValueChanged<double> onValueSubmitted;
  final bool enabled;
  final double? minValue;
  final double? maxValue;
  final String? hintText;

  const DecimalInputWidget({
    super.key,
    this.initialValue,
    required this.onValueSubmitted,
    this.enabled = true,
    this.minValue,
    this.maxValue,
    this.hintText,
  });

  @override
  State<DecimalInputWidget> createState() => _DecimalInputWidgetState();
}

class _DecimalInputWidgetState extends State<DecimalInputWidget> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  String? _errorText;
  double? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _controller = TextEditingController(
      text: widget.initialValue?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    final text = _controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) {
      setState(() => _errorText = 'Inserisci un valore');
      return;
    }

    final value = double.tryParse(text);
    if (value == null) {
      setState(() => _errorText = 'Valore non valido');
      return;
    }

    if (widget.minValue != null && value < widget.minValue!) {
      setState(() => _errorText = 'Min: ${widget.minValue}');
      return;
    }

    if (widget.maxValue != null && value > widget.maxValue!) {
      setState(() => _errorText = 'Max: ${widget.maxValue}');
      return;
    }

    setState(() {
      _errorText = null;
      _currentValue = value;
    });
    widget.onValueSubmitted(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.calculate, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text(
                'Stima Decimale',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Inserisci la tua stima in giorni (es: 1.5, 2.25)',
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                  ],
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Es: 2.5',
                    errorText: _errorText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    suffixText: 'giorni',
                  ),
                  onSubmitted: (_) => _validateAndSubmit(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: widget.enabled ? _validateAndSubmit : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
                child: const Text('Vota'),
              ),
            ],
          ),
          if (_currentValue != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Voto: ${_currentValue!.toStringAsFixed(2)} giorni',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Quick select buttons
          const SizedBox(height: 16),
          Text(
            'Selezione rapida:',
            style: TextStyle(
              fontSize: 12,
              color: context.textTertiaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0].map((value) {
              final isSelected = _currentValue == value;
              return ActionChip(
                label: Text(
                  value.toStringAsFixed(1),
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : null,
                  ),
                ),
                backgroundColor: isSelected ? AppColors.secondary : null,
                onPressed: widget.enabled
                    ? () {
                        _controller.text = value.toStringAsFixed(1);
                        _validateAndSubmit();
                      }
                    : null,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Widget compatto per visualizzare un voto decimale
class DecimalVoteDisplay extends StatelessWidget {
  final double value;
  final bool isRevealed;

  const DecimalVoteDisplay({
    super.key,
    required this.value,
    this.isRevealed = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRevealed) {
      return Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.help_outline, color: Colors.white),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
      ),
      child: Text(
        value.toStringAsFixed(2),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
          fontSize: 16,
        ),
      ),
    );
  }
}
