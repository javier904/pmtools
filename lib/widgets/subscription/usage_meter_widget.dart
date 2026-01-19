import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/subscription/subscription_limits_model.dart';
import '../../services/subscription/subscription_limits_service.dart';

/// Widget che mostra l'utilizzo corrente rispetto ai limiti del piano
/// Visualizza una barra di progresso per ogni tipo di limite
class UsageMeterWidget extends StatelessWidget {
  final int currentCount;
  final int limit;
  final String label;
  final IconData? icon;
  final bool showPercentage;
  final bool compact;

  const UsageMeterWidget({
    super.key,
    required this.currentCount,
    required this.limit,
    required this.label,
    this.icon,
    this.showPercentage = true,
    this.compact = false,
  });

  double get _percentage => limit == SubscriptionLimits.unlimited
      ? 0.0
      : (currentCount / limit).clamp(0.0, 1.0);

  Color get _color {
    if (limit == SubscriptionLimits.unlimited) return Colors.green;
    if (_percentage >= 1.0) return Colors.red;
    if (_percentage >= 0.8) return Colors.orange;
    if (_percentage >= 0.6) return Colors.amber;
    return Colors.green;
  }

  String get _displayValue {
    if (limit == SubscriptionLimits.unlimited) {
      return '$currentCount / ∞';
    }
    return '$currentCount / $limit';
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return _buildCompact(context);
    }
    return _buildFull(context);
  }

  Widget _buildCompact(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    _displayValue,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: limit == SubscriptionLimits.unlimited ? 0.0 : _percentage,
                  minHeight: 4,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(_color),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFull(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: _color),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              if (showPercentage && limit != SubscriptionLimits.unlimited)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(_percentage * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _color,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: limit == SubscriptionLimits.unlimited ? 0.0 : _percentage,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(_color),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.subscriptionUsed(currentCount),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                limit == SubscriptionLimits.unlimited
                    ? l10n.subscriptionUnlimited
                    : l10n.subscriptionLimit(limit),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget che mostra un riepilogo completo dell'utilizzo
class UsageSummaryWidget extends StatefulWidget {
  final String userEmail;
  final VoidCallback? onUpgrade;
  final bool showHeader;

  const UsageSummaryWidget({
    super.key,
    required this.userEmail,
    this.onUpgrade,
    this.showHeader = true,
  });

  @override
  State<UsageSummaryWidget> createState() => _UsageSummaryWidgetState();
}

class _UsageSummaryWidgetState extends State<UsageSummaryWidget> {
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();
  UsageSummary? _summary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    setState(() => _isLoading = true);
    try {
      final summary = await _limitsService.getUsageSummary(widget.userEmail);
      if (mounted) {
        setState(() {
          _summary = summary;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_summary == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.subscriptionLoadError,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeader) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.subscriptionPlanUsage,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadSummary,
                tooltip: l10n.subscriptionRefresh,
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],

        // Progetti
        UsageMeterWidget(
          currentCount: _summary!.projectsUsed,
          limit: _summary!.limits.maxActiveProjects,
          label: l10n.subscriptionActiveProjectsLabel,
          icon: Icons.folder_outlined,
        ),
        const SizedBox(height: 12),

        // Liste Smart Todo
        UsageMeterWidget(
          currentCount: _summary!.listsUsed,
          limit: _summary!.limits.maxActiveLists,
          label: l10n.subscriptionSmartTodoListsLabel,
          icon: Icons.checklist_outlined,
        ),
        const SizedBox(height: 12),

        // Indicatore ads
        if (_summary!.limits.showsAds) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.ads_click, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.subscriptionAdsActive,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.subscriptionRemoveAds,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onUpgrade != null)
                  TextButton(
                    onPressed: widget.onUpgrade,
                    child: Text(l10n.subscriptionUpgrade),
                  ),
              ],
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.block, color: Colors.green),
                const SizedBox(width: 12),
                Text(
                  l10n.subscriptionNoAds,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// Widget circolare per mostrare l'utilizzo in modo compatto
class CircularUsageMeter extends StatelessWidget {
  final int currentCount;
  final int limit;
  final String label;
  final double size;

  const CircularUsageMeter({
    super.key,
    required this.currentCount,
    required this.limit,
    required this.label,
    this.size = 80,
  });

  double get _percentage => limit == SubscriptionLimits.unlimited
      ? 0.0
      : (currentCount / limit).clamp(0.0, 1.0);

  Color get _color {
    if (limit == SubscriptionLimits.unlimited) return Colors.green;
    if (_percentage >= 1.0) return Colors.red;
    if (_percentage >= 0.8) return Colors.orange;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: limit == SubscriptionLimits.unlimited ? 1.0 : _percentage,
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(_color),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$currentCount',
                      style: TextStyle(
                        fontSize: size * 0.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (limit != SubscriptionLimits.unlimited)
                      Text(
                        '/$limit',
                        style: TextStyle(
                          fontSize: size * 0.15,
                          color: Colors.grey[600],
                        ),
                      )
                    else
                      Icon(
                        Icons.all_inclusive,
                        size: size * 0.15,
                        color: Colors.grey[600],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
