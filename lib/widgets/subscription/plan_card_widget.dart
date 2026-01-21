import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_profile/subscription_model.dart';
import '../../models/subscription/subscription_limits_model.dart';

/// Widget per visualizzare un singolo piano di abbonamento
/// Mostra features, prezzo e CTA per upgrade/downgrade
class PlanCardWidget extends StatelessWidget {
  final SubscriptionPlan plan;
  final SubscriptionPlan? currentPlan;
  final bool isYearly;
  final VoidCallback? onSelect;
  final bool isLoading;
  final bool isRecommended;

  const PlanCardWidget({
    super.key,
    required this.plan,
    this.currentPlan,
    this.isYearly = false,
    this.onSelect,
    this.isLoading = false,
    this.isRecommended = false,
  });

  bool get _isCurrentPlan => currentPlan == plan;
  bool get _isUpgrade => currentPlan != null && plan.index > currentPlan!.index;
  bool get _isDowngrade => currentPlan != null && plan.index < currentPlan!.index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final limits = SubscriptionLimits.forPlan(plan);
    final theme = Theme.of(context);
    final price = isYearly ? plan.yearlyPrice : plan.monthlyPrice;
    final period = isYearly ? l10n.subscriptionPerYear : l10n.subscriptionPerMonth;

    return Card(
      elevation: _isCurrentPlan ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: _isCurrentPlan
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : isRecommended
                ? BorderSide(color: Colors.amber, width: 2)
                : BorderSide.none,
      ),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: _isCurrentPlan
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.05),
                    theme.colorScheme.primary.withOpacity(0.1),
                  ],
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header con badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.getDisplayName(l10n),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getPlanColor(plan),
                  ),
                ),
                if (_isCurrentPlan)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l10n.subscriptionCurrent,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else if (isRecommended)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l10n.subscriptionRecommended,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Prezzo
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price == 0 ? l10n.subscriptionFree : '€${price.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (price > 0) ...[
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      period,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ],
            ),

            // Risparmio annuale
            if (isYearly && plan != SubscriptionPlan.free) ...[
              const SizedBox(height: 4),
              Text(
                l10n.subscriptionSaveYearly(((plan.monthlyPrice * 12) - plan.yearlyPrice).toStringAsFixed(2)),
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],

            // Trial info
            if (plan.trialDays > 0 && !_isCurrentPlan) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.subscriptionTrialDays(plan.trialDays),
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Features
            _buildFeatureItem(
              icon: Icons.folder_outlined,
              text: limits.maxActiveProjects == SubscriptionLimits.unlimited
                  ? l10n.subscriptionUnlimitedProjects
                  : l10n.subscriptionProjectsActive(limits.maxActiveProjects),
              isUnlimited: limits.maxActiveProjects == SubscriptionLimits.unlimited,
            ),
            _buildFeatureItem(
              icon: Icons.checklist_outlined,
              text: limits.maxActiveLists == SubscriptionLimits.unlimited
                  ? l10n.subscriptionUnlimitedLists
                  : l10n.subscriptionSmartTodoLists(limits.maxActiveLists),
              isUnlimited: limits.maxActiveLists == SubscriptionLimits.unlimited,
            ),
            _buildFeatureItem(
              icon: Icons.task_alt_outlined,
              text: limits.maxTasksPerEntity == SubscriptionLimits.unlimited
                  ? l10n.subscriptionUnlimitedTasks
                  : l10n.subscriptionTasksPerProject(limits.maxTasksPerEntity),
              isUnlimited: limits.maxTasksPerEntity == SubscriptionLimits.unlimited,
            ),
            _buildFeatureItem(
              icon: Icons.person_add_outlined,
              text: limits.maxInvitesPerEntity == SubscriptionLimits.unlimited
                  ? l10n.subscriptionUnlimitedInvites
                  : l10n.subscriptionInvitesPerProject(limits.maxInvitesPerEntity),
              isUnlimited: limits.maxInvitesPerEntity == SubscriptionLimits.unlimited,
            ),
            _buildFeatureItem(
              icon: limits.showsAds ? Icons.ads_click : Icons.block,
              text: limits.showsAds ? l10n.subscriptionWithAds : l10n.subscriptionWithoutAds,
              isPositive: !limits.showsAds,
              isNegative: limits.showsAds,
            ),

            const SizedBox(height: 24),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCurrentPlan || isLoading ? null : onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCurrentPlan
                      ? Colors.grey[300]
                      : _getPlanColor(plan),
                  foregroundColor: _isCurrentPlan ? Colors.grey[600] : Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        _getButtonText(l10n),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
    bool isUnlimited = false,
    bool isPositive = false,
    bool isNegative = false,
  }) {
    Color iconColor = Colors.grey[600]!;
    if (isUnlimited || isPositive) {
      iconColor = Colors.green[600]!;
    } else if (isNegative) {
      iconColor = Colors.orange[600]!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: isUnlimited ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText(AppLocalizations l10n) {
    if (_isCurrentPlan) return l10n.subscriptionCurrentPlan;
    if (_isUpgrade) return l10n.subscriptionUpgradeTo(plan.getDisplayName(l10n));
    if (_isDowngrade) return l10n.subscriptionDowngradeTo(plan.getDisplayName(l10n));
    return l10n.subscriptionChoose(plan.getDisplayName(l10n));
  }

  Color _getPlanColor(SubscriptionPlan plan) {
    switch (plan) {
      case SubscriptionPlan.free:
        return Colors.grey[700]!;
      case SubscriptionPlan.premium:
        return Colors.blue[700]!;
      case SubscriptionPlan.elite:
        return Colors.purple[700]!;
    }
  }
}

/// Widget per visualizzare tutti i piani affiancati
class PlansComparisonWidget extends StatefulWidget {
  final SubscriptionPlan? currentPlan;
  final Function(SubscriptionPlan plan, bool isYearly)? onPlanSelected;
  final bool isLoading;
  final SubscriptionPlan? loadingPlan;

  const PlansComparisonWidget({
    super.key,
    this.currentPlan,
    this.onPlanSelected,
    this.isLoading = false,
    this.loadingPlan,
  });

  @override
  State<PlansComparisonWidget> createState() => _PlansComparisonWidgetState();
}

class _PlansComparisonWidgetState extends State<PlansComparisonWidget> {
  bool _isYearly = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Toggle mensile/annuale
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton(l10n.subscriptionMonthly, !_isYearly, () {
                setState(() => _isYearly = false);
              }),
              _buildToggleButton(l10n.subscriptionYearly, _isYearly, () {
                setState(() => _isYearly = true);
              }),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Cards dei piani
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            PlanCardWidget(
              plan: SubscriptionPlan.free,
              currentPlan: widget.currentPlan,
              isYearly: _isYearly,
              isLoading: widget.isLoading && widget.loadingPlan == SubscriptionPlan.free,
              onSelect: () => widget.onPlanSelected?.call(SubscriptionPlan.free, _isYearly),
            ),
            PlanCardWidget(
              plan: SubscriptionPlan.premium,
              currentPlan: widget.currentPlan,
              isYearly: _isYearly,
              isRecommended: widget.currentPlan == SubscriptionPlan.free,
              isLoading: widget.isLoading && widget.loadingPlan == SubscriptionPlan.premium,
              onSelect: () => widget.onPlanSelected?.call(SubscriptionPlan.premium, _isYearly),
            ),
            PlanCardWidget(
              plan: SubscriptionPlan.elite,
              currentPlan: widget.currentPlan,
              isYearly: _isYearly,
              isLoading: widget.isLoading && widget.loadingPlan == SubscriptionPlan.elite,
              onSelect: () => widget.onPlanSelected?.call(SubscriptionPlan.elite, _isYearly),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
