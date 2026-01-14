import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import 'poker_card_widget.dart';

/// Widget che mostra il mazzo completo di carte per votare
class CardDeckWidget extends StatelessWidget {
  final List<String> cardSet;
  final String? selectedCard;
  final Function(String) onCardSelected;
  final bool enabled;

  const CardDeckWidget({
    super.key,
    required this.cardSet,
    this.selectedCard,
    required this.onCardSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.style, color: AppColors.success, size: 26),
              const SizedBox(width: 10),
              Text(
                'Il tuo voto',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: context.textPrimaryColor,
                ),
              ),
              const Spacer(),
              if (selectedCard != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.success.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check, size: 18, color: AppColors.success),
                      const SizedBox(width: 6),
                      Text(
                        'Selezionato: $selectedCard',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Carte
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cardSet.map((value) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: PokerCardWidget(
                    value: value,
                    isSelected: selectedCard == value,
                    isRevealed: true,
                    enabled: enabled,
                    onTap: () => onCardSelected(value),
                    width: 70,
                    height: 100,
                  ),
                );
              }).toList(),
            ),
          ),
          if (!enabled)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Solo i votanti possono selezionare le carte',
                style: TextStyle(
                  fontSize: 13,
                  color: context.textTertiaryColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
