import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Widget per una singola carta del Planning Poker
class PokerCardWidget extends StatefulWidget {
  final String value;
  final bool isSelected;
  final bool isRevealed;
  final bool enabled;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const PokerCardWidget({
    super.key,
    required this.value,
    this.isSelected = false,
    this.isRevealed = true,
    this.enabled = true,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<PokerCardWidget> createState() => _PokerCardWidgetState();
}

class _PokerCardWidgetState extends State<PokerCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _showFront = widget.isRevealed;

    // Logica animazione: 0 = front visibile, 1 = back visibile
    // Se NON rivelato, mostra il back (carta coperta)
    if (!widget.isRevealed) {
      _controller.value = 1.0;
    }
    // Se già rivelato, lascia a 0 per mostrare il front
  }

  @override
  void didUpdateWidget(PokerCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isRevealed != widget.isRevealed) {
      if (widget.isRevealed) {
        // Rivela: anima da back (1) a front (0)
        _controller.reverse();
      } else {
        // Copri: anima da front (0) a back (1)
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getCardColor() {
    if (widget.value == '?') return AppColors.warning;
    if (widget.value == '\u2615') return Colors.brown; // Coffee emoji
    if (widget.value.startsWith('X') || widget.value == 'S' || widget.value == 'M' || widget.value == 'L') {
      return AppColors.primary; // T-shirt sizes
    }
    // Numeri: gradiente dal verde (basso) al rosso (alto)
    final numValue = int.tryParse(widget.value);
    if (numValue != null) {
      if (numValue <= 3) return AppColors.success;
      if (numValue <= 8) return AppColors.secondary;
      if (numValue <= 20) return AppColors.warning;
      return AppColors.error;
    }
    return AppColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = widget.width ?? 60.0;
    final cardHeight = widget.height ?? 90.0;
    final cardColor = _getCardColor();

    return GestureDetector(
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * math.pi;
          final showFront = angle <= math.pi / 2;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: showFront ? _buildFrontCard(context, cardWidth, cardHeight, cardColor) : _buildBackCard(context, cardWidth, cardHeight),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard(BuildContext context, double width, double height, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      transform: widget.isSelected
          ? (Matrix4.identity()..translate(0.0, -8.0))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        color: widget.isSelected ? color : context.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.isSelected ? color : context.borderColor,
          width: widget.isSelected ? 3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isSelected
                ? color.withOpacity(0.4)
                : Colors.black.withOpacity(0.1),
            blurRadius: widget.isSelected ? 12 : 4,
            offset: Offset(0, widget.isSelected ? 4 : 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Valore centrale
          Center(
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: widget.value.length > 2 ? 26 : 32,
                fontWeight: FontWeight.bold,
                color: widget.isSelected ? Colors.white : color,
              ),
            ),
          ),
          // Valore angolo alto sinistro
          Positioned(
            top: 6,
            left: 8,
            child: Text(
              widget.value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: widget.isSelected ? Colors.white70 : color.withOpacity(0.6),
              ),
            ),
          ),
          // Valore angolo basso destro (ruotato)
          Positioned(
            bottom: 6,
            right: 8,
            child: Transform.rotate(
              angle: math.pi,
              child: Text(
                widget.value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: widget.isSelected ? Colors.white70 : color.withOpacity(0.6),
                ),
              ),
            ),
          ),
          // Overlay disabled
          if (!widget.enabled)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.black.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBackCard(BuildContext context, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: width * 0.7,
          height: height * 0.7,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryLight, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Icon(
              Icons.style,
              color: AppColors.secondaryLight,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}

/// Builder per animazioni
class AnimatedBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?) builder;

  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder2(
      animation: animation,
      builder: builder,
    );
  }
}

class AnimatedBuilder2 extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;

  const AnimatedBuilder2({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}
