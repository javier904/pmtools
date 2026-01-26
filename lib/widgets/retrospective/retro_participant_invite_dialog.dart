import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;
import '../../models/unified_invite_model.dart';
import '../../services/invite_service.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';

/// Dialog per invitare partecipanti a una Retrospective
///
/// Permette di:
/// - Inserire email del partecipante
/// - Selezionare il ruolo (participant/observer)
/// - Generare link di invito
/// - Visualizzare inviti pendenti
class RetroParticipantInviteDialog extends StatefulWidget {
  final String boardId;
  final String boardTitle;
  final List<UnifiedInviteModel> pendingInvites;

  const RetroParticipantInviteDialog({
    super.key,
    required this.boardId,
    required this.boardTitle,
    this.pendingInvites = const [],
  });

  static Future<bool?> show({
    required BuildContext context,
    required String boardId,
    required String boardTitle,
    List<UnifiedInviteModel> pendingInvites = const [],
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => RetroParticipantInviteDialog(
        boardId: boardId,
        boardTitle: boardTitle,
        pendingInvites: pendingInvites,
      ),
    );
  }

  @override
  State<RetroParticipantInviteDialog> createState() => _RetroParticipantInviteDialogState();
}

class _RetroParticipantInviteDialogState extends State<RetroParticipantInviteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _inviteService = InviteService();
  final _authService = AuthService();

  String _selectedRole = 'participant'; // participant, observer
  bool _isLoading = false;
  bool _sendEmailWithInvite = true;
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
      InviteSourceType.retroBoard,
      widget.boardId,
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
        sourceType: InviteSourceType.retroBoard,
        sourceId: widget.boardId,
        sourceName: widget.boardTitle,
        email: _emailController.text.trim(),
        role: _selectedRole,
      );

      if (invite != null) {
        final link = _inviteService.generateInviteLink(invite);
        bool emailSent = false;

        if (_sendEmailWithInvite) {
          emailSent = await _sendEmailInvite(invite);
        }

        setState(() {
          _generatedLink = link;
          _emailController.clear();
        });
        await _loadInvites();
        if (mounted) {
          final l10n = AppLocalizations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_sendEmailWithInvite && emailSent
                  ? l10n?.inviteSentByEmail(invite.email) ?? 'Invito inviato via email a ${invite.email}'
                  : l10n?.inviteCreatedFor(invite.email) ?? 'Invito creato per ${invite.email}'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.errorGeneric(e.toString()) ?? 'Errore: $e'),
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

  Future<bool> _sendEmailInvite(UnifiedInviteModel invite) async {
    try {
      print('📧 [RETRO EMAIL] Inizio invio email a ${invite.email}');

      String? accessToken;
      String? senderEmail;

      if (kIsWeb) {
        accessToken = _authService.webAccessToken;
        senderEmail = _authService.currentUserEmail;

        if (accessToken == null) {
          if (mounted) {
            final l10n = AppLocalizations.of(context);
            final shouldReauth = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l10n?.inviteGmailAuthTitle ?? 'Autorizzazione Gmail'),
                content: Text(
                  l10n?.inviteGmailAuthMessage ??
                  'Per inviare email di invito, è necessario ri-autenticarsi con Google.\n\nVuoi procedere?'
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text(l10n?.inviteGmailAuthNo ?? 'No, solo link'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text(l10n?.inviteGmailAuthYes ?? 'Autorizza'),
                  ),
                ],
              ),
            );

            if (shouldReauth == true) {
              accessToken = await _authService.refreshWebAccessToken();
            }
          }
        }

        if (accessToken == null || senderEmail == null) {
          if (mounted) {
            final l10n = AppLocalizations.of(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n?.inviteGmailNotAvailable ?? 'Autorizzazione Gmail non disponibile. Prova a fare logout e login.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return false;
        }

        final authHeaders = {'Authorization': 'Bearer $accessToken'};
        final authClient = _GoogleAuthClient(authHeaders);
        final gmailApi = gmail.GmailApi(authClient);

        return await _inviteService.sendInviteEmail(
          invite: invite,
          senderEmail: senderEmail,
          gmailApi: gmailApi,
        );
      } else {
        var googleAccount = _authService.googleSignIn.currentUser;
        googleAccount ??= await _authService.googleSignIn.signInSilently();
        googleAccount ??= await _authService.googleSignIn.signIn();

        if (googleAccount == null) {
          return false;
        }

        final hasGmailScope = await _authService.googleSignIn.requestScopes([
          'https://www.googleapis.com/auth/gmail.send',
        ]);

        if (!hasGmailScope) {
          if (mounted) {
            final l10n = AppLocalizations.of(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n?.inviteGmailNoPermission ?? 'Permesso Gmail non concesso.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return false;
        }

        final authHeaders = await googleAccount.authHeaders;
        final authClient = _GoogleAuthClient(authHeaders);
        final gmailApi = gmail.GmailApi(authClient);
        senderEmail = googleAccount.email;

        return await _inviteService.sendInviteEmail(
          invite: invite,
          senderEmail: senderEmail,
          gmailApi: gmailApi,
        );
      }
    } catch (e) {
      print('❌ [RETRO EMAIL] Errore: $e');
      return false;
    }
  }

  Future<void> _revokeInvite(String inviteId) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.inviteRevokeTitle ?? 'Revocare invito?'),
        content: Text(l10n?.inviteRevokeMessage ?? 'L\'invito non sarà più valido.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n?.actionCancel ?? 'Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n?.inviteRevoke ?? 'Revoca'),
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
          final l10n = AppLocalizations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n?.inviteResent ?? 'Invito reinviato'),
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
          const Icon(Icons.person_add, color: Colors.purple),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n?.inviteSendNew ?? 'Invita partecipanti', style: const TextStyle(fontSize: 18)),
                Text(
                  widget.boardTitle,
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.inviteNewInvite ?? 'NUOVO INVITO',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n?.participantEmailHint?.split('@').first.replaceAll('.', ' ') ?? 'Email',
                        hintText: l10n?.participantEmailHint ?? 'esempio@email.com',
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n?.inviteEnterEmail ?? 'Inserisci una email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return l10n?.inviteInvalidEmail ?? 'Email non valida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Text(l10n?.inviteRole ?? 'Ruolo:'),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n?.participantRoleVoters ?? 'Partecipante'),
                          selected: _selectedRole == 'participant',
                          onSelected: (_) => setState(
                              () => _selectedRole = 'participant'),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Text(l10n?.participantObserver ?? 'Osservatore'),
                          selected: _selectedRole == 'observer',
                          onSelected: (_) => setState(
                              () => _selectedRole = 'observer'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _sendEmailWithInvite
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _sendEmailWithInvite
                              ? Colors.green.withValues(alpha: 0.3)
                              : Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _sendEmailWithInvite ? Icons.email : Icons.email_outlined,
                            size: 20,
                            color: _sendEmailWithInvite ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n?.inviteSendEmailNotification ?? 'Invia notifica email',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _sendEmailWithInvite ? Colors.green[700] : Colors.grey[600],
                              ),
                            ),
                          ),
                          Switch(
                            value: _sendEmailWithInvite,
                            onChanged: (value) => setState(() => _sendEmailWithInvite = value),
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

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
                        label: Text(l10n?.inviteSendInvite ?? 'Invia invito'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
                            l10n?.inviteLink ?? 'Link di invito',
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
                                SnackBar(content: Text(l10n?.inviteLinkCopied ?? 'Link copiato')),
                              );
                            },
                            tooltip: l10n?.inviteCopyLink ?? 'Copia link',
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

              if (_invites.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  l10n?.inviteList ?? 'INVITI ESISTENTI',
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
          child: Text(l10n?.actionClose ?? 'Chiudi'),
        ),
      ],
    );
  }

  Widget _buildInviteRow(UnifiedInviteModel invite, AppLocalizations? l10n) {
    final statusInfo = _getStatusInfo(invite.status, l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[800]
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[700]!
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
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
                      _getRoleLabel(invite.role),
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[600],
                      ),
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

          if (invite.status == UnifiedInviteStatus.pending) ...[
            IconButton(
              icon: const Icon(Icons.refresh, size: 18),
              onPressed: () => _resendInvite(invite.id),
              tooltip: l10n?.inviteResend ?? 'Reinvia',
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.red),
              onPressed: () => _revokeInvite(invite.id),
              tooltip: l10n?.inviteRevoke ?? 'Revoca',
            ),
          ],
        ],
      ),
    );
  }

  String _getRoleLabel(String role) {
    final l10n = AppLocalizations.of(context);
    switch (role.toLowerCase()) {
      case 'participant':
        return l10n?.participantRoleVoters ?? 'Partecipante';
      case 'observer':
        return l10n?.participantObserver ?? 'Osservatore';
      default:
        return role;
    }
  }

  _InviteStatusInfo _getStatusInfo(UnifiedInviteStatus status, AppLocalizations? l10n) {
    switch (status) {
      case UnifiedInviteStatus.pending:
        return _InviteStatusInfo(
          label: l10n?.inviteStatusPending ?? 'In attesa',
          color: Colors.orange,
          icon: Icons.hourglass_empty,
        );
      case UnifiedInviteStatus.accepted:
        return _InviteStatusInfo(
          label: l10n?.inviteStatusAccepted ?? 'Accettato',
          color: Colors.green,
          icon: Icons.check_circle,
        );
      case UnifiedInviteStatus.declined:
        return _InviteStatusInfo(
          label: l10n?.inviteStatusDeclined ?? 'Rifiutato',
          color: Colors.red,
          icon: Icons.cancel,
        );
      case UnifiedInviteStatus.expired:
        return _InviteStatusInfo(
          label: l10n?.inviteStatusExpired ?? 'Scaduto',
          color: Colors.grey,
          icon: Icons.timer_off,
        );
      case UnifiedInviteStatus.revoked:
        return _InviteStatusInfo(
          label: l10n?.inviteStatusRevoked ?? 'Revocato',
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

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }

  @override
  void close() {
    _client.close();
  }
}
