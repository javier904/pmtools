import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_profile/subscription_model.dart';
import '../../services/subscription/stripe_payment_service.dart';
import '../../services/subscription/subscription_limits_service.dart';
import '../../services/auth_service.dart';
import '../../services/user_profile_service.dart';
import '../../widgets/subscription/plan_card_widget.dart';
import '../../widgets/subscription/usage_meter_widget.dart';

/// Schermata principale per la gestione dell'abbonamento
/// Mostra piani disponibili, utilizzo corrente e gestione pagamenti
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  final StripePaymentService _stripeService = StripePaymentService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();
  final AuthService _authService = AuthService();

  late TabController _tabController;

  SubscriptionModel? _currentSubscription;
  StripeSubscription? _stripeSubscription;
  bool _isLoading = true;
  bool _isProcessing = false;
  SubscriptionPlan? _processingPlan;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final subscription = await UserProfileService().getCurrentSubscription();
      final stripeSubscription = await _stripeService.getActiveSubscription();

      if (mounted) {
        setState(() {
          _currentSubscription = subscription;
          _stripeSubscription = stripeSubscription;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Errore nel caricamento: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handlePlanSelection(SubscriptionPlan plan, bool isYearly) async {
    final l10n = AppLocalizations.of(context)!;
    // Se è già il piano corrente, non fare nulla
    if (_currentSubscription?.plan == plan) return;

    // Se è Free, gestisci il downgrade
    if (plan == SubscriptionPlan.free) {
      await _handleDowngradeToFree();
      return;
    }

    setState(() {
      _isProcessing = true;
      _processingPlan = plan;
    });

    try {
      // Determina il priceId basato su piano e billing cycle
      final priceId = _getPriceId(plan, isYearly);

      // Crea sessione checkout Stripe
      final checkoutUrl = await _stripeService.createCheckoutSession(
        priceId: priceId,
        includeTrial: _currentSubscription?.plan == SubscriptionPlan.free,
      );

      if (checkoutUrl != null) {
        // Apri URL checkout in nuova finestra
        if (mounted) {
          await _stripeService.openCheckoutUrl(checkoutUrl);
        }

        // Mostra messaggio
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.subscriptionCompletePayment),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.subscriptionError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _processingPlan = null;
        });
      }
    }
  }

  Future<void> _handleDowngradeToFree() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.subscriptionConfirmDowngrade),
        content: Text(l10n.subscriptionDowngradeMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.subscriptionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.subscriptionConfirmDowngradeButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _isProcessing = true);
      try {
        // Cancella abbonamento a fine periodo
        await _stripeService.cancelSubscriptionAtPeriodEnd();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.subscriptionCancelled),
            ),
          );
          _loadData();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.subscriptionError(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isProcessing = false);
        }
      }
    }
  }

  Future<void> _openBillingPortal() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isProcessing = true);

    try {
      final portalUrl = await _stripeService.createPortalSession();

      if (portalUrl != null) {
        await _stripeService.openCheckoutUrl(portalUrl);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.subscriptionPortalError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  String _getPriceId(SubscriptionPlan plan, bool isYearly) {
    // Questi IDs devono corrispondere a quelli configurati in Stripe
    switch (plan) {
      case SubscriptionPlan.premium:
        return isYearly ? 'price_premium_yearly' : 'price_premium_monthly';
      case SubscriptionPlan.elite:
        return isYearly ? 'price_elite_yearly' : 'price_elite_monthly';
      case SubscriptionPlan.free:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.subscriptionTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.subscriptionTabPlans, icon: const Icon(Icons.view_carousel)),
            Tab(text: l10n.subscriptionTabUsage, icon: const Icon(Icons.pie_chart)),
            Tab(text: l10n.subscriptionTabBilling, icon: const Icon(Icons.receipt_long)),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorState()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPlansTab(),
                    _buildUsageTab(),
                    _buildBillingTab(),
                  ],
                ),
    );
  }

  Widget _buildErrorState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(_errorMessage!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadData,
            child: Text(l10n.subscriptionRetry),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansTab() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Text(
            l10n.subscriptionChooseRightPlan,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.subscriptionStartFree,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Piano corrente banner
          if (_currentSubscription != null)
            _buildCurrentPlanBanner(),

          const SizedBox(height: 32),

          // Cards dei piani
          PlansComparisonWidget(
            currentPlan: _currentSubscription?.plan,
            isLoading: _isProcessing,
            loadingPlan: _processingPlan,
            onPlanSelected: _handlePlanSelection,
          ),

          const SizedBox(height: 48),

          // FAQ / Info
          _buildInfoSection(),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanBanner() {
    final l10n = AppLocalizations.of(context)!;
    final plan = _currentSubscription!.plan;
    final isTrialing = _currentSubscription!.status == SubscriptionStatus.trialing;
    final endDate = _currentSubscription!.endDate;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: plan == SubscriptionPlan.elite
              ? [Colors.purple.shade400, Colors.purple.shade700]
              : plan == SubscriptionPlan.premium
                  ? [Colors.blue.shade400, Colors.blue.shade700]
                  : [Colors.grey.shade400, Colors.grey.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            plan == SubscriptionPlan.elite
                ? Icons.diamond
                : plan == SubscriptionPlan.premium
                    ? Icons.star
                    : Icons.person,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.subscriptionPlan(plan.getDisplayName(l10n)),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isTrialing && _currentSubscription!.trialEndDate != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.subscriptionTrialUntil(_formatDate(_currentSubscription!.trialEndDate!)),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ] else if (endDate != null && plan != SubscriptionPlan.free) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.subscriptionRenewal(_formatDate(endDate)),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (plan != SubscriptionPlan.free)
            ElevatedButton(
              onPressed: _isProcessing ? null : _openBillingPortal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade700,
              ),
              child: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.subscriptionManage),
            ),
        ],
      ),
    );
  }

  Widget _buildUsageTab() {
    final l10n = AppLocalizations.of(context)!;
    final userEmail = _authService.currentUser?.email;

    if (userEmail == null) {
      return Center(
        child: Text(l10n.subscriptionLoginRequired),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Piano corrente
          if (_currentSubscription != null) ...[
            Text(
              l10n.subscriptionPlanName(_currentSubscription!.plan.getDisplayName(l10n)),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
          ],

          // Usage summary
          UsageSummaryWidget(
            userEmail: userEmail,
            onUpgrade: () {
              _tabController.animateTo(0);
            },
          ),

          const SizedBox(height: 32),

          // Suggerimenti
          if (_currentSubscription?.plan == SubscriptionPlan.free)
            _buildUpgradeSuggestion(),
        ],
      ),
    );
  }

  Widget _buildUpgradeSuggestion() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                l10n.subscriptionSuggestion,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(l10n.subscriptionSuggestionText),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _tabController.animateTo(0),
            child: Text(l10n.subscriptionViewPlans),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingTab() {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Abbonamento attivo
          _buildSubscriptionDetails(),

          const SizedBox(height: 32),

          // Metodo di pagamento
          if (_stripeSubscription != null) ...[
            Text(
              l10n.subscriptionPaymentManagement,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildBillingActions(),
          ],

          const SizedBox(height: 32),

          // Storico pagamenti
          _buildPaymentHistory(),
        ],
      ),
    );
  }

  Widget _buildSubscriptionDetails() {
    final l10n = AppLocalizations.of(context)!;
    if (_currentSubscription == null ||
        _currentSubscription!.plan == SubscriptionPlan.free) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Icon(Icons.info_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              l10n.subscriptionNoActiveSubscription,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.subscriptionUsingFreePlan,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _tabController.animateTo(0),
              child: Text(l10n.subscriptionViewPaidPlans),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _currentSubscription!.plan == SubscriptionPlan.elite
                    ? Icons.diamond
                    : Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.subscriptionPlanName(_currentSubscription!.plan.getDisplayName(l10n)),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          _buildDetailRow(l10n.subscriptionStatus, _getStatusText(_currentSubscription!.status)),
          if (_currentSubscription!.startDate != null)
            _buildDetailRow(l10n.subscriptionStarted, _formatDate(_currentSubscription!.startDate!)),
          if (_currentSubscription!.endDate != null)
            _buildDetailRow(l10n.subscriptionNextRenewal, _formatDate(_currentSubscription!.endDate!)),
          if (_currentSubscription!.trialEndDate != null &&
              _currentSubscription!.status == SubscriptionStatus.trialing)
            _buildDetailRow(
              l10n.subscriptionTrialEnd,
              _formatDate(_currentSubscription!.trialEndDate!),
              highlight: true,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: highlight ? Colors.orange : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingActions() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: Text(l10n.subscriptionPaymentMethod),
          subtitle: Text(l10n.subscriptionEditPaymentMethod),
          trailing: const Icon(Icons.chevron_right),
          onTap: _openBillingPortal,
        ),
        ListTile(
          leading: const Icon(Icons.receipt_long),
          title: Text(l10n.subscriptionInvoices),
          subtitle: Text(l10n.subscriptionViewInvoices),
          trailing: const Icon(Icons.chevron_right),
          onTap: _openBillingPortal,
        ),
        ListTile(
          leading: Icon(Icons.cancel, color: Colors.red[400]),
          title: Text(
            l10n.subscriptionCancelSubscription,
            style: TextStyle(color: Colors.red[400]),
          ),
          subtitle: Text(l10n.subscriptionAccessUntilEnd),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _handleDowngradeToFree(),
        ),
      ],
    );
  }

  Widget _buildPaymentHistory() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.subscriptionPaymentHistory,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        StreamBuilder<List<StripePayment>>(
          stream: _stripeService.streamPaymentHistory(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(l10n.subscriptionNoPayments),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final payment = snapshot.data![index];
                return ListTile(
                  leading: Icon(
                    payment.status == 'succeeded'
                        ? Icons.check_circle
                        : Icons.error,
                    color: payment.status == 'succeeded'
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text('€${(payment.amount / 100).toStringAsFixed(2)}'),
                  subtitle: Text(payment.created != null ? _formatDate(payment.created!) : l10n.subscriptionDateNotAvailable),
                  trailing: Chip(
                    label: Text(
                      payment.status == 'succeeded' ? l10n.subscriptionCompleted : payment.status,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: payment.status == 'succeeded'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.subscriptionFaq,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            l10n.subscriptionFaqCancel,
            l10n.subscriptionFaqCancelAnswer,
          ),
          _buildFaqItem(
            l10n.subscriptionFaqTrial,
            l10n.subscriptionFaqTrialAnswer,
          ),
          _buildFaqItem(
            l10n.subscriptionFaqChange,
            l10n.subscriptionFaqChangeAnswer,
          ),
          _buildFaqItem(
            l10n.subscriptionFaqData,
            l10n.subscriptionFaqDataAnswer,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _getStatusText(SubscriptionStatus status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case SubscriptionStatus.active:
        return l10n.subscriptionStatusActive;
      case SubscriptionStatus.trialing:
        return l10n.subscriptionStatusTrialing;
      case SubscriptionStatus.pastDue:
        return l10n.subscriptionStatusPastDue;
      case SubscriptionStatus.cancelled:
        return l10n.subscriptionStatusCancelled;
      case SubscriptionStatus.expired:
        return l10n.subscriptionStatusExpired;
      case SubscriptionStatus.paused:
        return l10n.subscriptionStatusPaused;
    }
  }
}
