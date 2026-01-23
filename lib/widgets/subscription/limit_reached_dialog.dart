import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/subscription/subscription_limits_model.dart';
import '../../models/user_profile/subscription_model.dart';

/// Dialog che mostra quando l'utente raggiunge un limite del suo piano
/// Offre CTA per upgrade al piano superiore
class LimitReachedDialog extends StatelessWidget {
  final LimitCheckResult limitResult;
  final String entityType;
  final VoidCallback? onUpgrade;
  final VoidCallback? onDismiss;

  const LimitReachedDialog({
    super.key,
    required this.limitResult,
    required this.entityType,
    this.onUpgrade,
    this.onDismiss,
  });

  /// Mostra il dialog in modo statico
  static Future<bool?> show({
    required BuildContext context,
    required LimitCheckResult limitResult,
    required String entityType,
    VoidCallback? onUpgrade,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LimitReachedDialog(
        limitResult: limitResult,
        entityType: entityType,
        onUpgrade: onUpgrade,
        onDismiss: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline,
                size: 48,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              l10n.subscriptionLimitReached,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Message
            Text(
              _getMessageForEntityType(l10n),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Usage indicator
            if (limitResult.currentCount != null && limitResult.limit != null)
              _buildUsageIndicator(context, l10n),

            const SizedBox(height: 24),

            // Upgrade benefits
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.rocket_launch, color: Colors.blue[700], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        l10n.subscriptionUpgradeToPremium,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildBenefitRow(l10n.subscriptionBenefitProjects),
                  _buildBenefitRow(l10n.subscriptionBenefitLists),
                  _buildBenefitRow(l10n.subscriptionBenefitTasks),
                  _buildBenefitRow(l10n.subscriptionBenefitNoAds),
                  const SizedBox(height: 8),
                  Text(
                    l10n.subscriptionStartingFrom,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDismiss ?? () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.subscriptionLater),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      onUpgrade?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.subscriptionViewPlans,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageIndicator(BuildContext context, AppLocalizations l10n) {
    final current = limitResult.currentCount!;
    final limit = limitResult.limit!;
    final percentage = (current / limit).clamp(0.0, 1.0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.subscriptionCurrentUsage,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '$current / $limit',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage >= 1.0 ? Colors.red : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  String _getMessageForEntityType(AppLocalizations l10n) {
    switch (entityType) {
      case 'project':
      case 'eisenhower':
        return l10n.subscriptionLimitProjects;
      case 'list':
      case 'smart_todo':
        return l10n.subscriptionLimitLists;
      case 'task':
        return l10n.subscriptionLimitTasks;
      case 'invite':
        return l10n.subscriptionLimitInvites;
      case 'estimation':
        return l10n.subscriptionLimitEstimations;
      case 'retrospective':
        return l10n.subscriptionLimitRetrospectives;
      case 'agile_project':
        return l10n.subscriptionLimitAgileProjects;
      default:
        return limitResult.reason ?? l10n.subscriptionLimitDefault;
    }
  }
}

/// Wrapper per gestire LimitExceededException e mostrare il dialog
class LimitExceptionHandler {
  /// Esegue un'azione e mostra il dialog se viene lanciata LimitExceededException
  static Future<T?> executeWithLimitCheck<T>({
    required BuildContext context,
    required Future<T> Function() action,
    required String entityType,
    VoidCallback? onUpgrade,
  }) async {
    try {
      return await action();
    } on LimitExceededException catch (e) {
      final result = LimitCheckResult.denied(
        reason: e.message,
        currentCount: e.currentCount,
        limit: e.limit,
        upgradeRequired: true,
      );

      await LimitReachedDialog.show(
        context: context,
        limitResult: result,
        entityType: entityType,
        onUpgrade: onUpgrade,
      );
      return null;
    }
  }
}

/// Snackbar per limiti quasi raggiunti (warning)
class LimitWarningSnackbar {
  static void show({
    required BuildContext context,
    required int currentCount,
    required int limit,
    required String entityName,
    VoidCallback? onUpgrade,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final remaining = limit - currentCount;
    if (remaining > 3) return; // Mostra solo se rimangono 3 o meno

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                remaining == 1
                    ? l10n.subscriptionCanCreateOne(entityName)
                    : l10n.subscriptionCanCreateMany(remaining, entityName),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange[700],
        duration: const Duration(seconds: 4),
        action: onUpgrade != null
            ? SnackBarAction(
                label: l10n.subscriptionUpgrade,
                textColor: Colors.white,
                onPressed: onUpgrade,
              )
            : null,
      ),
    );
  }
}
