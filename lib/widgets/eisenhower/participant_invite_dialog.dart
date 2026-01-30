import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../models/unified_invite_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../services/invite_service.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per invitare partecipanti a una matrice Eisenhower
///
/// Permette di:
/// - Inserire email del partecipante
/// - Selezionare il ruolo (votante/osservatore)
/// - Generare link di invito
/// - Visualizzare inviti pendenti
class ParticipantInviteDialog extends StatefulWidget {
  final String matrixId;
  final String matrixTitle;
  final List<UnifiedInviteModel> pendingInvites;

  const ParticipantInviteDialog({
    super.key,
    required this.matrixId,
    required this.matrixTitle,
    this.pendingInvites = const [],
  });

  static Future<bool?> show({
    required BuildContext context,
    required String matrixId,
    required String matrixTitle,
    List<UnifiedInviteModel> pendingInvites = const [],
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ParticipantInviteDialog(
        matrixId: matrixId,
        matrixTitle: matrixTitle,
        pendingInvites: pendingInvites,
      ),
    );
  }

  @override
  State<ParticipantInviteDialog> createState() => _ParticipantInviteDialogState();
}

class _ParticipantInviteDialogState extends State<ParticipantInviteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _inviteService = InviteService();
  final _authService = AuthService();

  EisenhowerParticipantRole _selectedRole = EisenhowerParticipantRole.voter;
  bool _isLoading = false;
  String? _generatedLink;
  List<UnifiedInviteModel> _invites = [];

  @override
  void initState() {
    super.initState();
    _invites = List.from(widget.pendingInvites);
    _loadInvites();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadInvites() async {
    final invites = await _inviteService.getInvitesForSource(
      InviteSourceType.eisenhower,
      widget.matrixId,
    );
    if (mounted) {
      setState(() => _invites = invites);
    }
  }

  Future<void> _sendInvite() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final invite = await _inviteService.createInvite(
        sourceType: InviteSourceType.eisenhower,
        sourceId: widget.matrixId,
        sourceName: widget.matrixTitle,
        email: _emailController.text.trim(),
        role: _selectedRole.name, // 'voter' or 'observer'
      );

      if (invite != null) {
        final link = _inviteService.generateInviteLink(invite);

        setState(() {
          _generatedLink = link;
          _emailController.clear();
        });
        await _loadInvites();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invito creato per ${invite.email}. Email in arrivo...'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
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

  Future<void> _revokeInvite(String inviteId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revocare invito?'),
        content: const Text('L\'invito non sara\' piu\' valido.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Revoca'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _inviteService.revokeInvite(inviteId);
      await _loadInvites();
    }
  }

  Future<void> _resendInvite(String inviteId) async {
    setState(() => _isLoading = true);
    try {
      final invite = await _inviteService.resendInvite(inviteId);
      if (invite != null) {
        final link = _inviteService.generateInviteLink(invite);
        setState(() => _generatedLink = link);
        await _loadInvites();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invito reinviato'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.person_add, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.eisenhowerInviteParticipants, style: const TextStyle(fontSize: 18)),
                Text(
                  widget.matrixTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 450,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form nuovo invito
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.inviteNewInvite,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.participantEmailHint.split('@').first.replaceAll('.', ' '),
                        hintText: l10n.participantEmailHint,
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      ),
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

                    // Ruolo
                    Row(
                      children: [
                        Text(l10n.inviteRole),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n.participantVoter),
                          selected: _selectedRole == EisenhowerParticipantRole.voter,
                          onSelected: (_) => setState(
                              () => _selectedRole = EisenhowerParticipantRole.voter),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n.participantObserver),
                          selected: _selectedRole == EisenhowerParticipantRole.observer,
                          onSelected: (_) => setState(
                              () => _selectedRole = EisenhowerParticipantRole.observer),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),



                    // Bottone invita
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _sendInvite,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.send),
                        label: Text(l10n.inviteSendInvite),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Link generato
              if (_generatedLink != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.link, color: Colors.green, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            l10n.inviteLink,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.copy, size: 18),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: _generatedLink!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(l10n.inviteLinkCopied)),
                              );
                            },
                            tooltip: l10n.inviteCopyLink,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        _generatedLink!,
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],

              // Lista inviti esistenti
              if (_invites.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  l10n.inviteList,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                ..._invites.map((invite) => _buildInviteRow(invite, l10n)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _invites.any((i) => i.status == UnifiedInviteStatus.accepted)),
          child: Text(l10n.actionClose),
        ),
      ],
    );
  }

  Widget _buildInviteRow(UnifiedInviteModel invite, AppLocalizations l10n) {
    final statusInfo = _getStatusInfo(invite.status, l10n);
    final roleDisplayName = _getRoleDisplayName(invite.role);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Status icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: statusInfo.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(statusInfo.icon, size: 18, color: statusInfo.color),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invite.email,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      roleDisplayName,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: statusInfo.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusInfo.label,
                        style: TextStyle(
                          fontSize: 10,
                          color: statusInfo.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Azioni
          if (invite.status == UnifiedInviteStatus.pending) ...[
            IconButton(
              icon: const Icon(Icons.refresh, size: 18),
              onPressed: () => _resendInvite(invite.id),
              tooltip: l10n.inviteResend,
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.red),
              onPressed: () => _revokeInvite(invite.id),
              tooltip: l10n.inviteRevoke,
            ),
          ],
        ],
      ),
    );
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'voter':
        return 'Votante';
      case 'observer':
        return 'Osservatore';
      default:
        return role;
    }
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
          color: Colors.green,
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

/// Client HTTP autenticato per le API Google (Gmail)

