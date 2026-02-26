import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:agile_tools/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class WeatherIcebreakerWidget extends StatelessWidget {
  final String retroId;
  final String currentUserEmail;
  final Map<String, String> currentWeather; // email -> weather type
  final bool isFacilitator;
  final VoidCallback onPhaseComplete;

  const WeatherIcebreakerWidget({
    Key? key,
    required this.retroId,
    required this.currentUserEmail,
    required this.currentWeather,
    this.isFacilitator = false,
    required this.onPhaseComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String? myWeather = currentWeather[currentUserEmail];

    // Weather options with icons and labels
    final weatherOptions = [
      ('sunny', '☀️', l10n.retroWeatherSunny),
      ('partly_cloudy', '🌤️', l10n.retroWeatherPartlyCloudy),
      ('cloudy', '☁️', l10n.retroWeatherCloudy),
      ('rainy', '🌧️', l10n.retroWeatherRainy),
      ('stormy', '⛈️', l10n.retroWeatherStormy),
    ];

    // Count votes per weather type
    final Map<String, int> weatherCounts = {};
    for (final weather in currentWeather.values) {
      weatherCounts[weather] = (weatherCounts[weather] ?? 0) + 1;
    }

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Center(
      child: Card(
        margin: EdgeInsets.all(isMobile ? 8 : 24),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 12 : 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.retroIcebreakerWeatherTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 18 : null,
                  ),
                ),
                SizedBox(height: isMobile ? 8 : 16),
                Text(
                  l10n.retroIcebreakerWeatherQuestion,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.textSecondaryColor,
                    fontSize: isMobile ? 12 : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isMobile ? 12 : 32),

              // Weather Options
              // Weather Options
              Wrap(
                alignment: WrapAlignment.center,
                spacing: isMobile ? 8 : 16,
                runSpacing: isMobile ? 8 : 16,
                children: weatherOptions.map((option) {
                  final (type, emoji, label) = option;
                  final isSelected = myWeather == type;
                  final count = weatherCounts[type] ?? 0;

                  return _buildWeatherOption(
                    context,
                    type,
                    emoji,
                    label,
                    isSelected,
                    count,
                  );
                }).toList(),
              ),

              SizedBox(height: isMobile ? 16 : 48),

              // Progress
              Text(
                l10n.retroParticipantsVoted(currentWeather.length),
                style: isMobile 
                    ? Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12) 
                    : Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: isMobile ? 12 : 24),

              if (isFacilitator)
                ElevatedButton.icon(
                  onPressed: onPhaseComplete,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(l10n.retroEndIcebreakerStartWriting),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildWeatherOption(
    BuildContext context,
    String type,
    String emoji,
    String label,
    bool isSelected,
    int count,
  ) {
    final selectedColor = Colors.blue;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return InkWell(
      onTap: () {
        RetrospectiveFirestoreService().submitWeather(retroId, currentUserEmail, type);
      },
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isMobile ? 80 : 120, // Constrain width based on screen
        padding: EdgeInsets.all(isMobile ? 8 : 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withValues(alpha: 0.25) : Colors.transparent,
          border: Border.all(
            color: isSelected ? selectedColor : Colors.grey.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected ? [
            BoxShadow(color: selectedColor.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 2)
          ] : null,
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: isMobile ? 28 : 48)),
            SizedBox(height: isMobile ? 4 : 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 10 : 12,
                color: isSelected ? selectedColor : context.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (count > 0) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: selectedColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: selectedColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
