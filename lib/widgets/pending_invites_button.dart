import 'package:flutter/material.dart';
import '../models/unified_invite_model.dart';
import '../services/invite_aggregator_service.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../themes/app_colors.dart';

/// Pulsante per mostrare gli inviti pendenti con badge contatore
class PendingInvitesButton extends StatefulWidget {
  final VoidCallback? onInviteAccepted;

  const PendingInvitesButton({
    super.key,
    this.onInviteAccepted,
  });

  @override
  State<PendingInvitesButton> createState() => _PendingInvitesButtonState();
}

class _PendingInvitesButtonState extends State<PendingInvitesButton> {
  final InviteAggregatorService _inviteService = InviteAggregatorService();
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return StreamBuilder<int>(
      stream: _inviteService.streamPendingInviteCount(),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;

        return Tooltip(
          message: l10n.pendingInvites,
          child: InkWell(
            onTap: () => _showInvitesDialog(context),
            onHover: (hovering) => setState(() => _isHovered = hovering),
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isHovered
                    ? context.surfaceVariantColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    count > 0 ? Icons.notifications_active : Icons.notifications_outlined,
                    color: _isHovered
                        ? context.textPrimaryColor
                        : context.textSecondaryColor,
                    size: 20,
                  ),
                  if (count > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          count > 9 ? '9+' : '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showInvitesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PendingInvitesDialog(
        onInviteAccepted: widget.onInviteAccepted,
      ),
    );
  }
}

/// Dialog che mostra la lista degli inviti pendenti
class PendingInvitesDialog extends StatefulWidget {
  final VoidCallback? onInviteAccepted;

  const PendingInvitesDialog({
    super.key,
    this.onInviteAccepted,
  });

  @override
  State<PendingInvitesDialog> createState() => _PendingInvitesDialogState();
}

class _PendingInvitesDialogState extends State<PendingInvitesDialog> {
  final InviteAggregatorService _inviteService = InviteAggregatorService();
  final Set<String> _processingInvites = {};
  // Track degli inviti accettati per mostrarli con pulsante verde "Apri"
  final Map<String, UnifiedInviteModel> _acceptedInvites = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.pendingInvites,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: l10n.close,
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: StreamBuilder<List<UnifiedInviteModel>>(
                stream: _inviteService.streamAllPendingInvites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting && _acceptedInvites.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final pendingInvites = snapshot.data ?? [];

                  // Combina inviti pending + inviti accettati (mostrati in cima)
                  final allInvites = <UnifiedInviteModel>[
                    ..._acceptedInvites.values,
                    ...pendingInvites.where((i) => !_acceptedInvites.containsKey(i.id)),
                  ];

                  if (allInvites.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: context.textMutedColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noPendingInvites,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: allInvites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final invite = allInvites[index];
                      final isAccepted = _acceptedInvites.containsKey(invite.id);
                      return _buildInviteCard(context, invite, l10n, isAccepted: isAccepted);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteCard(BuildContext context, UnifiedInviteModel invite, AppLocalizations l10n, {bool isAccepted = false}) {
    final isProcessing = _processingInvites.contains(invite.id);
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Se accettato, bordo verde
        color: isAccepted
            ? AppColors.success.withValues(alpha: 0.05)
            : (isDark ? Colors.grey[850] : Colors.grey[50]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAccepted
              ? AppColors.success
              : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
          width: isAccepted ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con tipo e nome
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSourceColor(invite.sourceType).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      invite.sourceIcon,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getSourceTypeLocalized(invite.sourceType, l10n),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: _getSourceColor(invite.sourceType),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Badge scadenza
              _buildExpirationBadge(invite, l10n),
            ],
          ),
          const SizedBox(height: 12),

          // Nome istanza
          Text(
            invite.sourceName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),

          // Info invito
          Row(
            children: [
              Icon(Icons.person_outline, size: 14, color: context.textMutedColor),
              const SizedBox(width: 4),
              Text(
                l10n.invitedBy(invite.invitedByName),
                style: TextStyle(
                  fontSize: 12,
                  color: context.textSecondaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.badge_outlined, size: 14, color: context.textMutedColor),
              const SizedBox(width: 4),
              Text(
                '${l10n.inviteRole} ${invite.role}',
                style: TextStyle(
                  fontSize: 12,
                  color: context.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Azioni - diverse se accettato o pending
          if (isAccepted)
            // Invito accettato: solo pulsante verde "Apri"
            ElevatedButton.icon(
              onPressed: () => _openInstance(context, invite, isAccepted: true),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text(l10n.inviteOpenInstance),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                minimumSize: const Size(double.infinity, 44),
              ),
            )
          else
            // Invito pending: pulsanti Apri, Rifiuta, Accetta
            Row(
              children: [
                // Apri istanza
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isProcessing ? null : () => _openInstance(context, invite, isAccepted: false),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: Text(l10n.inviteOpenInstance),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Rifiuta
                IconButton(
                  onPressed: isProcessing ? null : () => _declineInvite(invite, l10n),
                  icon: const Icon(Icons.close, size: 20),
                  tooltip: l10n.inviteDecline,
                  style: IconButton.styleFrom(
                    foregroundColor: AppColors.error,
                    backgroundColor: AppColors.error.withValues(alpha: 0.1),
                  ),
                ),
                const SizedBox(width: 8),
                // Accetta
                IconButton(
                  onPressed: isProcessing ? null : () => _acceptInvite(invite, l10n),
                  icon: isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check, size: 20),
                  tooltip: l10n.inviteAccept,
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.success,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildExpirationBadge(UnifiedInviteModel invite, AppLocalizations l10n) {
    final hours = invite.hoursUntilExpiration;
    final days = invite.daysUntilExpiration;

    Color color;
    String text;

    if (hours < 24) {
      color = AppColors.error;
      text = l10n.expiresInHours(hours);
    } else if (days < 3) {
      color = AppColors.warning;
      text = l10n.expiresInDays(days);
    } else {
      color = AppColors.success;
      text = l10n.expiresInDays(days);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSourceColor(InviteSourceType type) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return const Color(0xFF2196F3); // Blue
      case InviteSourceType.estimationRoom:
        return const Color(0xFF9C27B0); // Purple
      case InviteSourceType.agileProject:
        return const Color(0xFF4CAF50); // Green
      case InviteSourceType.smartTodo:
        return const Color(0xFFFF9800); // Orange
      case InviteSourceType.retroBoard:
        return const Color(0xFF00BCD4); // Cyan
    }
  }

  String _getSourceTypeLocalized(InviteSourceType type, AppLocalizations l10n) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return l10n.toolEisenhower;
      case InviteSourceType.estimationRoom:
        return l10n.toolEstimation;
      case InviteSourceType.agileProject:
        return l10n.toolAgileProcess;
      case InviteSourceType.smartTodo:
        return l10n.toolSmartTodo;
      case InviteSourceType.retroBoard:
        return l10n.toolRetro;
    }
  }

  Future<void> _acceptInvite(UnifiedInviteModel invite, AppLocalizations l10n) async {
    setState(() => _processingInvites.add(invite.id));

    try {
      final success = await _inviteService.acceptInvite(invite);
      if (success) {
        if (mounted) {
          // Aggiungi agli inviti accettati per mostrare pulsante verde
          setState(() {
            _acceptedInvites[invite.id] = invite;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.inviteAcceptedSuccess),
              backgroundColor: AppColors.success,
            ),
          );
        }
        widget.onInviteAccepted?.call();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.inviteAcceptedError),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _processingInvites.remove(invite.id));
      }
    }
  }

  Future<void> _declineInvite(UnifiedInviteModel invite, AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.inviteDeclineTitle),
        content: Text(l10n.inviteDeclineMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.inviteDecline),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _processingInvites.add(invite.id));

    try {
      final success = await _inviteService.declineInvite(invite);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.inviteDeclinedSuccess),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingInvites.remove(invite.id));
      }
    }
  }

  void _openInstance(BuildContext context, UnifiedInviteModel invite, {bool isAccepted = false}) {
    final l10n = AppLocalizations.of(context)!;

    if (isAccepted) {
      // Invito accettato - naviga all'istanza
      Navigator.of(context).pop(); // Chiudi dialog
      Navigator.of(context).pushNamed(
        invite.instanceRoute,
        arguments: invite.routeArguments,
      );
    } else {
      // Invito pending - mostra messaggio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.inviteAcceptFirst),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
