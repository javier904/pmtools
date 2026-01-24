import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/unified_invite_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../services/invite_service.dart';
import '../../services/invite_aggregator_service.dart';
import '../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

/// Widget per la tab degli inviti nella schermata Eisenhower
///
/// Mostra:
/// - Form per inviare nuovi inviti
/// - Lista degli inviti inviati con stato (tutti gli stati: pending, accepted, declined, etc.)
class EisenhowerInviteTabWidget extends StatefulWidget {
  final String matrixId;
  final String matrixTitle;
  final bool isFacilitator;
  final VoidCallback? onInviteAccepted;
  final Map<String, EisenhowerParticipantModel> participants;
  final String? currentUserEmail;

  const EisenhowerInviteTabWidget({
    super.key,
    required this.matrixId,
    required this.matrixTitle,
    required this.isFacilitator,
    this.onInviteAccepted,
    this.participants = const {},
    this.currentUserEmail,
  });

  @override
  State<EisenhowerInviteTabWidget> createState() => _EisenhowerInviteTabWidgetState();
}

class _EisenhowerInviteTabWidgetState extends State<EisenhowerInviteTabWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _inviteService = InviteService();
  final _inviteAggregator = InviteAggregatorService();

  String _selectedRole = 'voter'; // voter, observer
  bool _isLoading = false;
  List<UnifiedInviteModel> _invites = [];

  @override
  void initState() {
    super.initState();
    _loadInvites();
  }

  @override
  void didUpdateWidget(EisenhowerInviteTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.matrixId != widget.matrixId) {
      _loadInvites();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadInvites() async {
    try {
      // Usa l'aggregator per cercare in unified + legacy collections
      final invites = await _inviteAggregator.getInvitesForSource(
        InviteSourceType.eisenhower,
        widget.matrixId,
      );
      if (mounted) {
        setState(() => _invites = invites);
      }
    } catch (e) {
      print('Error loading invites: $e');
    }
  }

  Future<void> _sendInvite() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      final invite = await _inviteService.createInvite(
        sourceType: InviteSourceType.eisenhower,
        sourceId: widget.matrixId,
        sourceName: widget.matrixTitle,
        email: _emailController.text.trim(),
        role: _selectedRole,
      );

      if (invite != null) {
        setState(() => _emailController.clear());
        await _loadInvites();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.inviteCreatedFor(invite.email)),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _copyInviteLink(UnifiedInviteModel invite) async {
    final link = _inviteService.generateInviteLink(invite);
    await Clipboard.setData(ClipboardData(text: link));
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.inviteLinkCopied),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _revokeInvite(UnifiedInviteModel invite) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.inviteRevokeTitle),
        content: Text(l10n.inviteRevokeConfirm(invite.email)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.inviteRevoke),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _inviteService.revokeInvite(invite.id);
      await _loadInvites();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.inviteRevokedFor(invite.email)),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Form nuovo invito (solo facilitatore)
        if (widget.isFacilitator) ...[
          _buildNewInviteForm(l10n),
          const SizedBox(height: 16),
          Divider(color: context.borderColor),
          const SizedBox(height: 12),
        ],

        // Lista inviti
        _buildInvitesList(l10n),
      ],
    );
  }

  Widget _buildNewInviteForm(AppLocalizations l10n) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.inviteSendNew.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: context.textMutedColor,
            ),
          ),
          const SizedBox(height: 8),

          // Email input
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: l10n.inviteRecipientEmail,
              hintText: l10n.participantEmailHint,
              prefixIcon: const Icon(Icons.email, size: 20),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              isDense: true,
            ),
            style: const TextStyle(fontSize: 13),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.inviteEnterEmail;
              }
              if (!value.contains('@') || !value.contains('.')) {
                return l10n.inviteInvalidEmail;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),

          // Role selection
          Text(
            l10n.inviteRole,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildRoleChip(
                  l10n.participantVoter,
                  'voter',
                  Icons.how_to_vote,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildRoleChip(
                  l10n.participantObserver,
                  'observer',
                  Icons.visibility,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Create button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _sendInvite,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send, size: 18),
              label: Text(l10n.inviteCreate),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(String label, String role, IconData icon) {
    final isSelected = _selectedRole == role;
    return InkWell(
      onTap: () => setState(() => _selectedRole = role),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green.withOpacity(0.15)
              : context.surfaceVariantColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : context.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.green : context.textSecondaryColor,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.green : context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvitesList(AppLocalizations l10n) {
    // Find participants that don't have a matching invite record
    final invitedEmails = _invites.map((i) => i.email.toLowerCase()).toSet();
    final membersWithoutInvites = widget.participants.entries
        .where((entry) {
          final email = entry.key.toLowerCase();
          // Skip current user (the facilitator viewing this tab)
          if (widget.currentUserEmail != null &&
              email == widget.currentUserEmail!.toLowerCase()) {
            return false;
          }
          return !invitedEmails.contains(email);
        })
        .toList();

    final hasContent = _invites.isNotEmpty || membersWithoutInvites.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.invitesSent.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: context.textMutedColor,
          ),
        ),
        const SizedBox(height: 8),

        if (!hasContent)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.surfaceVariantColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.mail_outline, color: context.textMutedColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  l10n.inviteNoInvites,
                  style: TextStyle(color: context.textMutedColor),
                ),
              ],
            ),
          )
        else ...[
          // Show invite records
          ..._invites.map((invite) => _buildInviteRow(invite, l10n)),
          // Show participants without invite records as "Members"
          ...membersWithoutInvites.map((entry) => _buildMemberRow(entry.value, l10n)),
        ],
      ],
    );
  }

  Widget _buildMemberRow(EisenhowerParticipantModel participant, AppLocalizations l10n) {
    final roleLabel = participant.role == EisenhowerParticipantRole.voter
        ? l10n.participantVoter
        : participant.role == EisenhowerParticipantRole.observer
            ? l10n.participantObserver
            : 'Facilitator';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email and role badge
          Row(
            children: [
              Expanded(
                child: Text(
                  participant.email,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  roleLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Status: Member (joined directly)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 12, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      'Member',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              if (participant.name.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  participant.name,
                  style: TextStyle(fontSize: 11, color: context.textMutedColor),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInviteRow(UnifiedInviteModel invite, AppLocalizations l10n) {
    final statusInfo = _getStatusInfo(invite.status, l10n);
    final roleLabel = invite.role.toLowerCase() == 'voter'
        ? l10n.participantVoter
        : l10n.participantObserver;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.surfaceVariantColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email e badge ruolo
          Row(
            children: [
              Expanded(
                child: Text(
                  invite.email,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Role badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  roleLabel,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Status e scadenza
          Row(
            children: [
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusInfo.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusInfo.icon, size: 12, color: statusInfo.color),
                    const SizedBox(width: 4),
                    Text(
                      statusInfo.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: statusInfo.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Expiry
              if (invite.status == UnifiedInviteStatus.pending && invite.daysUntilExpiration >= 0) ...[
                Icon(Icons.schedule, size: 12, color: context.textMutedColor),
                const SizedBox(width: 4),
                Text(
                  l10n.inviteExpiresIn(invite.daysUntilExpiration),
                  style: TextStyle(fontSize: 10, color: context.textMutedColor),
                ),
              ],

              const Spacer(),

              // Actions
              if (invite.status == UnifiedInviteStatus.pending && widget.isFacilitator) ...[
                InkWell(
                  onTap: () => _copyInviteLink(invite),
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.link, size: 18, color: context.textSecondaryColor),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _revokeInvite(invite),
                  borderRadius: BorderRadius.circular(4),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.delete_outline, size: 18, color: Colors.red),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  _InviteStatusInfo _getStatusInfo(UnifiedInviteStatus status, AppLocalizations l10n) {
    switch (status) {
      case UnifiedInviteStatus.pending:
        return _InviteStatusInfo(
          label: l10n.inviteStatusPending,
          color: Colors.orange,
          icon: Icons.hourglass_empty,
        );
      case UnifiedInviteStatus.accepted:
        return _InviteStatusInfo(
          label: l10n.inviteStatusAccepted,
          color: AppColors.success,
          icon: Icons.check_circle,
        );
      case UnifiedInviteStatus.declined:
        return _InviteStatusInfo(
          label: l10n.inviteStatusDeclined,
          color: Colors.red,
          icon: Icons.cancel,
        );
      case UnifiedInviteStatus.expired:
        return _InviteStatusInfo(
          label: l10n.inviteStatusExpired,
          color: Colors.grey,
          icon: Icons.timer_off,
        );
      case UnifiedInviteStatus.revoked:
        return _InviteStatusInfo(
          label: l10n.inviteStatusRevoked,
          color: Colors.grey,
          icon: Icons.block,
        );
    }
  }
}

class _InviteStatusInfo {
  final String label;
  final Color color;
  final IconData icon;

  _InviteStatusInfo({
    required this.label,
    required this.color,
    required this.icon,
  });
}
