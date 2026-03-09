import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/estimation_mode.dart';
import '../../themes/app_theme.dart';
import '../../l10n/app_localizations.dart';

/// Widget per Three-Point Estimation (PERT)
/// Formula: (O + 4M + P) / 6
/// Dove: O = Ottimistico, M = Most Likely (Realistico), P = Pessimistico
class ThreePointInputWidget extends StatefulWidget {
  final double? initialOptimistic;
  final double? initialRealistic;
  final double? initialPessimistic;
  final void Function(double optimistic, double realistic, double pessimistic) onValuesSubmitted;
  final bool enabled;

  const ThreePointInputWidget({
    super.key,
    this.initialOptimistic,
    this.initialRealistic,
    this.initialPessimistic,
    required this.onValuesSubmitted,
    this.enabled = true,
  });

  @override
  State<ThreePointInputWidget> createState() => _ThreePointInputWidgetState();
}

class _ThreePointInputWidgetState extends State<ThreePointInputWidget> {
  late TextEditingController _optimisticController;
  late TextEditingController _realisticController;
  late TextEditingController _pessimisticController;

  String? _errorText;
  double? _pertValue;
  double? _standardDeviation;

  @override
  void initState() {
    super.initState();
    _optimisticController = TextEditingController(
      text: widget.initialOptimistic?.toString() ?? '',
    );
    _realisticController = TextEditingController(
      text: widget.initialRealistic?.toString() ?? '',
    );
    _pessimisticController = TextEditingController(
      text: widget.initialPessimistic?.toString() ?? '',
    );

    // Calcola PERT iniziale se ci sono valori
    _calculatePert();
  }

  @override
  void dispose() {
    _optimisticController.dispose();
    _realisticController.dispose();
    _pessimisticController.dispose();
    super.dispose();
  }

  void _calculatePert() {
    final o = double.tryParse(_optimisticController.text.replaceAll(',', '.'));
    final m = double.tryParse(_realisticController.text.replaceAll(',', '.'));
    final p = double.tryParse(_pessimisticController.text.replaceAll(',', '.'));

    if (o != null && m != null && p != null) {
      setState(() {
        _pertValue = ThreePointConfig.calculatePERT(o, m, p);
        _standardDeviation = ThreePointConfig.calculateStandardDeviation(o, p);
      });
    } else {
      setState(() {
        _pertValue = null;
        _standardDeviation = null;
      });
    }
  }

  void _validateAndSubmit(AppLocalizations l10n) {
    final oText = _optimisticController.text.trim().replaceAll(',', '.');
    final mText = _realisticController.text.trim().replaceAll(',', '.');
    final pText = _pessimisticController.text.trim().replaceAll(',', '.');

    if (oText.isEmpty || mText.isEmpty || pText.isEmpty) {
      setState(() => _errorText = l10n.estimationThreePointReqError);
      return;
    }

    final o = double.tryParse(oText);
    final m = double.tryParse(mText);
    final p = double.tryParse(pText);

    if (o == null || m == null || p == null) {
      setState(() => _errorText = l10n.estimationThreePointInvalidError);
      return;
    }

    // Validazione logica: O <= M <= P
    if (o > m) {
      setState(() => _errorText = l10n.estimationThreePointOptMustBeLteReal);
      return;
    }
    if (m > p) {
      setState(() => _errorText = l10n.estimationThreePointRealMustBeLtePess);
      return;
    }
    if (o > p) {
      setState(() => _errorText = l10n.estimationThreePointOptMustBeLtePess);
      return;
    }

    setState(() => _errorText = null);
    widget.onValuesSubmitted(o, m, p);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.3)
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
              const Icon(Icons.analytics, color: Colors.purple),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.estimationThreePointTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l10n.estimationThreePointFormula,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Colors.purple,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tre input fields
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  context,
                  controller: _optimisticController,
                  label: l10n.estimationThreePointOptimistic,
                  hint: l10n.estimationThreePointOptHint,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField(
                  context,
                  controller: _realisticController,
                  label: l10n.estimationThreePointRealistic,
                  hint: l10n.estimationThreePointRealHint,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInputField(
                  context,
                  controller: _pessimisticController,
                  label: l10n.estimationThreePointPessimistic,
                  hint: l10n.estimationThreePointPessHint,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          if (_errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],

          // PERT Preview
          if (_pertValue != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    label: l10n.estimationThreePointVarPERT,
                    value: _pertValue!.toStringAsFixed(2),
                    color: Colors.purple,
                    tooltip: '(O + 4M + P) / 6',
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.purple.withOpacity(0.3),
                  ),
                  _buildStatItem(
                    label: l10n.estimationThreePointVarDevStd,
                    value: _standardDeviation!.toStringAsFixed(2),
                    color: Colors.orange,
                    tooltip: '(P - O) / 6',
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.purple.withOpacity(0.3),
                  ),
                  _buildStatItem(
                    label: l10n.estimationThreePointVarRange,
                    value: '${(_pertValue! - _standardDeviation!).toStringAsFixed(1)} - ${(_pertValue! + _standardDeviation!).toStringAsFixed(1)}',
                    color: Colors.blue,
                    tooltip: 'PERT ± Dev.Std',
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: widget.enabled ? () => _validateAndSubmit(l10n) : null,
              icon: const Icon(Icons.send),
              label: Text(l10n.estimationDecimalVote),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),

          // Info box
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.surfaceVariantColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: context.textSecondaryColor),
                    const SizedBox(width: 6),
                    Text(
                      l10n.estimationThreePointGuideTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.estimationThreePointGuideText,
                  style: TextStyle(
                    fontSize: 11,
                    color: context.textTertiaryColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required Color color,
  }) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            enabled: widget.enabled,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
            ],
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 12, color: context.textMutedColor),
              fillColor: context.surfaceVariantColor,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: context.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: color, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              suffixText: 'gg',
              suffixStyle: TextStyle(fontSize: 11, color: context.textTertiaryColor),
            ),
            onChanged: (_) => _calculatePert(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color color,
    String? tooltip,
  }) {
    final content = Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color.withOpacity(0.8),
              ),
            ),
            if (tooltip != null) ...[
              const SizedBox(width: 2),
              Icon(
                Icons.info_outline,
                size: 10,
                color: color.withOpacity(0.5),
              ),
            ],
          ],
        ),
      ],
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip,
        triggerMode: TooltipTriggerMode.tap,
        child: content,
      );
    }
    return content;
  }
}

/// Widget per visualizzare un voto three-point
class ThreePointVoteDisplay extends StatelessWidget {
  final double optimistic;
  final double realistic;
  final double pessimistic;
  final bool isRevealed;
  final bool compact;

  const ThreePointVoteDisplay({
    super.key,
    required this.optimistic,
    required this.realistic,
    required this.pessimistic,
    this.isRevealed = true,
    this.compact = false,
  });

  double get pertValue => ThreePointConfig.calculatePERT(optimistic, realistic, pessimistic);
  double get standardDeviation => ThreePointConfig.calculateStandardDeviation(optimistic, pessimistic);

  @override
  Widget build(BuildContext context) {
    if (!isRevealed) {
      return Container(
        width: compact ? 60 : 80,
        height: compact ? 40 : 50,
        decoration: BoxDecoration(
          color: Colors.purple[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.analytics, color: Colors.white),
      );
    }

    if (compact) {
      return Tooltip(
        message: 'O: $optimistic | M: $realistic | P: $pessimistic\nDev. Std: ${standardDeviation.toStringAsFixed(2)}',
        triggerMode: TooltipTriggerMode.tap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.withOpacity(0.3)),
          ),
          child: Text(
            pertValue.toStringAsFixed(2),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple[700],
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            pertValue.toStringAsFixed(2),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple[700],
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'PERT',
            style: TextStyle(
              fontSize: 11,
              color: Colors.purple[400],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildValueChip('O', optimistic, Colors.green),
              const SizedBox(width: 4),
              _buildValueChip('M', realistic, Colors.blue),
              const SizedBox(width: 4),
              _buildValueChip('P', pessimistic, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueChip(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(1)}',
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
