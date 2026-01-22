import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;
import '../../models/unified_invite_model.dart';
import '../../models/agile_enums.dart';
import '../../services/invite_service.dart';
import '../../services/auth_service.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';

/// Dialog per invitare partecipanti a un Progetto Agile
///
/// Permette di:
/// - Inserire email del partecipante
/// - Selezionare il ruolo nel progetto (member/admin)
/// - Selezionare il ruolo nel team (developer/designer/qa/etc)
/// - Generare link di invito
/// - Visualizzare inviti pendenti
class AgileParticipantInviteDialog extends StatefulWidget {
  final String projectId;
  final String projectName;
  final List<UnifiedInviteModel> pendingInvites;

  const AgileParticipantInviteDialog({
    super.key,
    required this.projectId,
    required this.projectName,
    this.pendingInvites = const [],
  });

  static Future<bool?> show({
    required BuildContext context,
    required String projectId,
    required String projectName,
    List<UnifiedInviteModel> pendingInvites = const [],
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AgileParticipantInviteDialog(
        projectId: projectId,
        projectName: projectName,
        pendingInvites: pendingInvites,
      ),
    );
  }

  @override
  State<AgileParticipantInviteDialog> createState() => _AgileParticipantInviteDialogState();
}

class _AgileParticipantInviteDialogState extends State<AgileParticipantInviteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _inviteService = InviteService();
  final _authService = AuthService();

  AgileParticipantRole _selectedParticipantRole = AgileParticipantRole.member;
  TeamRole _selectedTeamRole = TeamRole.developer;
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
      InviteSourceType.agileProject,
      widget.projectId,
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
        sourceType: InviteSourceType.agileProject,
        sourceId: widget.projectId,
        sourceName: widget.projectName,
        email: _emailController.text.trim(),
        role: _selectedParticipantRole.name, // 'member', 'admin', 'viewer'
        teamRole: _selectedTeamRole.name, // 'developer', 'designer', etc.
      );

      if (invite != null) {
        final link = _inviteService.generateInviteLink(invite);
        bool emailSent = false;

        // Invia email se richiesto
        if (_sendEmailWithInvite) {
          emailSent = await _sendEmailInvite(invite);
        }

        setState(() {
          _generatedLink = link;
          _emailController.clear();
        });
        await _loadInvites();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_sendEmailWithInvite && emailSent
                  ? 'Invito inviato via email a ${invite.email}'
                  : 'Invito creato per ${invite.email}'),
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

  /// Invia email di invito usando Gmail API
  Future<bool> _sendEmailInvite(UnifiedInviteModel invite) async {
    try {
      print('📧 ============================================');
      print('📧 [EMAIL] INIZIO PROCESSO INVIO EMAIL');
      print('📧 [EMAIL] Destinatario: ${invite.email}');
      print('📧 [EMAIL] Piattaforma: ${kIsWeb ? "WEB" : "MOBILE"}');
      print('📧 ============================================');

      String? accessToken;
      String? senderEmail;

      if (kIsWeb) {
        // ===== WEB: usa il token OAuth memorizzato da Firebase Auth =====
        print('📧 [EMAIL] [WEB] Uso token OAuth da Firebase Auth...');

        accessToken = _authService.webAccessToken;
        senderEmail = _authService.currentUserEmail;

        print('📧 [EMAIL] [WEB] Token presente: ${accessToken != null}');
        print('📧 [EMAIL] [WEB] Email utente: $senderEmail');

        if (accessToken == null) {
          // Token non presente, richiedi re-auth
          print('📧 [EMAIL] [WEB] Token assente - richiedo re-autenticazione...');

          if (mounted) {
            final shouldReauth = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Autorizzazione Gmail'),
                content: const Text(
                  'Per inviare email di invito, è necessario ri-autenticarsi con Google.\n\n'
                  'Vuoi procedere?'
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('No, solo link'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Autorizza'),
                  ),
                ],
              ),
            );

            if (shouldReauth == true) {
              accessToken = await _authService.refreshWebAccessToken();
              print('📧 [EMAIL] [WEB] Nuovo token ottenuto: ${accessToken != null}');
            }
          }
        }

        if (accessToken == null || senderEmail == null) {
          print('⚠️ [EMAIL] [WEB] FALLITO: Token o email non disponibili');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Autorizzazione Gmail non disponibile. Prova a fare logout e login.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return false;
        }

        // Crea client con token OAuth
        final authHeaders = {'Authorization': 'Bearer $accessToken'};
        final authClient = _GoogleAuthClient(authHeaders);
        final gmailApi = gmail.GmailApi(authClient);
        final baseUrl = Uri.base.origin;

        print('📧 [EMAIL] [WEB] Invio email via Gmail API...');
        print('📧 [EMAIL] [WEB] Da: $senderEmail');
        print('📧 [EMAIL] [WEB] A: ${invite.email}');

        final result = await _inviteService.sendInviteEmail(
          invite: invite,
          baseUrl: baseUrl,
          senderEmail: senderEmail,
          gmailApi: gmailApi,
        );

        print('📧 ============================================');
        print('📧 [EMAIL] [WEB] RISULTATO: ${result ? "SUCCESSO" : "FALLITO"}');
        print('📧 ============================================');
        return result;

      } else {
        // ===== MOBILE: usa GoogleSignIn =====
        print('📧 [EMAIL] [MOBILE] Uso GoogleSignIn...');

        var googleAccount = _authService.googleSignIn.currentUser;
        print('📧 [EMAIL] [MOBILE] Account corrente: ${googleAccount?.email ?? "NULL"}');

        if (googleAccount == null) {
          googleAccount = await _authService.googleSignIn.signInSilently();
          print('📧 [EMAIL] [MOBILE] Dopo signInSilently: ${googleAccount?.email ?? "NULL"}');
        }

        if (googleAccount == null) {
          googleAccount = await _authService.googleSignIn.signIn();
          print('📧 [EMAIL] [MOBILE] Dopo signIn: ${googleAccount?.email ?? "NULL"}');
        }

        if (googleAccount == null) {
          print('⚠️ [EMAIL] [MOBILE] FALLITO: Nessun account Google');
          return false;
        }

        // Verifica scope Gmail
        final hasGmailScope = await _authService.googleSignIn.requestScopes([
          'https://www.googleapis.com/auth/gmail.send',
        ]);

        if (!hasGmailScope) {
          print('⚠️ [EMAIL] [MOBILE] FALLITO: Scope Gmail non autorizzato');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Permesso Gmail non concesso.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
          return false;
        }

        final authHeaders = await googleAccount.authHeaders;
        final authClient = _GoogleAuthClient(authHeaders);
        final gmailApi = gmail.GmailApi(authClient);
        final baseUrl = 'https://pm-agile-tools-app.web.app';
        senderEmail = googleAccount.email;

        print('📧 [EMAIL] [MOBILE] Invio email via Gmail API...');

        final result = await _inviteService.sendInviteEmail(
          invite: invite,
          baseUrl: baseUrl,
          senderEmail: senderEmail,
          gmailApi: gmailApi,
        );

        print('📧 ============================================');
        print('📧 [EMAIL] [MOBILE] RISULTATO: ${result ? "SUCCESSO" : "FALLITO"}');
        print('📧 ============================================');
        return result;
      }
    } catch (e, stack) {
      print('❌ ============================================');
      print('❌ [EMAIL] ECCEZIONE NON GESTITA');
      print('❌ [EMAIL] Errore: $e');
      print('❌ [EMAIL] Stack: $stack');
      print('❌ ============================================');
      return false;
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
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.person_add, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Invita al Team', style: TextStyle(fontSize: 18)),
                Text(
                  widget.projectName,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
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
                      'NUOVO INVITO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: context.textMutedColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'nome@esempio.com',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci un\'email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Email non valida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ruolo Progetto
                    const Text(
                      'Ruolo nel Progetto',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Member'),
                          selected: _selectedParticipantRole == AgileParticipantRole.member,
                          onSelected: (_) => setState(
                              () => _selectedParticipantRole = AgileParticipantRole.member),
                          avatar: Icon(AgileParticipantRole.member.icon, size: 16),
                        ),
                        ChoiceChip(
                          label: const Text('Admin'),
                          selected: _selectedParticipantRole == AgileParticipantRole.admin,
                          onSelected: (_) => setState(
                              () => _selectedParticipantRole = AgileParticipantRole.admin),
                          avatar: Icon(AgileParticipantRole.admin.icon, size: 16),
                        ),
                        ChoiceChip(
                          label: const Text('Viewer'),
                          selected: _selectedParticipantRole == AgileParticipantRole.viewer,
                          onSelected: (_) => setState(
                              () => _selectedParticipantRole = AgileParticipantRole.viewer),
                          avatar: Icon(AgileParticipantRole.viewer.icon, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Ruolo Team
                    const Text(
                      'Ruolo nel Team',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: TeamRole.values.map((role) => ChoiceChip(
                        label: Text(role.displayName),
                        selected: _selectedTeamRole == role,
                        onSelected: (_) => setState(() => _selectedTeamRole = role),
                        avatar: Icon(role.icon, size: 16),
                      )).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Toggle invio email
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _sendEmailWithInvite
                            ? Colors.green.withOpacity(0.1)
                            : context.textMutedColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _sendEmailWithInvite
                              ? Colors.green.withOpacity(0.3)
                              : context.textMutedColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _sendEmailWithInvite ? Icons.email : Icons.email_outlined,
                            size: 20,
                            color: _sendEmailWithInvite ? Colors.green : context.textMutedColor,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Invia email di notifica',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _sendEmailWithInvite ? Colors.green[700] : context.textSecondaryColor,
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
                        label: const Text('Invia Invito'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
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
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.link, color: Colors.green, size: 18),
                          const SizedBox(width: 8),
                          const Text(
                            'Link di invito:',
                            style: TextStyle(
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
                                const SnackBar(content: Text('Link copiato!')),
                              );
                            },
                            tooltip: 'Copia link',
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        _generatedLink!,
                        style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
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
                  'INVITI',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: context.textMutedColor,
                  ),
                ),
                const SizedBox(height: 8),
                ..._invites.map((invite) => _buildInviteRow(invite)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _invites.any((i) => i.status == UnifiedInviteStatus.accepted)),
          child: const Text('Chiudi'),
        ),
      ],
    );
  }

  Widget _buildInviteRow(UnifiedInviteModel invite) {
    final statusInfo = _getStatusInfo(invite.status);
    final roleDisplay = _getRoleDisplay(invite);

    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.surfaceVariantColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.borderColor),
        ),
        child: Row(
          children: [
            // Status icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: statusInfo.color.withOpacity(0.2),
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
                        roleDisplay,
                        style: TextStyle(fontSize: 11, color: context.textSecondaryColor),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: statusInfo.color.withOpacity(0.15),
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
                tooltip: 'Reinvia',
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18, color: Colors.red),
                onPressed: () => _revokeInvite(invite.id),
                tooltip: 'Revoca',
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getRoleDisplay(UnifiedInviteModel invite) {
    final participantRole = _getParticipantRoleName(invite.role);
    final teamRole = _getTeamRoleName(invite.teamRole);
    return '$participantRole / $teamRole';
  }

  String _getParticipantRoleName(String role) {
    switch (role.toLowerCase()) {
      case 'member':
        return 'Member';
      case 'admin':
        return 'Admin';
      case 'viewer':
        return 'Viewer';
      default:
        return role;
    }
  }

  String _getTeamRoleName(String? teamRole) {
    if (teamRole == null) return 'Developer';
    switch (teamRole.toLowerCase()) {
      case 'developer':
        return 'Developer';
      case 'designer':
        return 'Designer';
      case 'qa':
        return 'QA';
      case 'productowner':
        return 'Product Owner';
      case 'scrummaster':
        return 'Scrum Master';
      case 'stakeholder':
        return 'Stakeholder';
      default:
        return teamRole;
    }
  }

  _InviteStatusInfo _getStatusInfo(UnifiedInviteStatus status) {
    switch (status) {
      case UnifiedInviteStatus.pending:
        return _InviteStatusInfo(
          label: 'In attesa',
          color: Colors.orange,
          icon: Icons.hourglass_empty,
        );
      case UnifiedInviteStatus.accepted:
        return _InviteStatusInfo(
          label: 'Accettato',
          color: Colors.green,
          icon: Icons.check_circle,
        );
      case UnifiedInviteStatus.declined:
        return _InviteStatusInfo(
          label: 'Rifiutato',
          color: Colors.red,
          icon: Icons.cancel,
        );
      case UnifiedInviteStatus.expired:
        return _InviteStatusInfo(
          label: 'Scaduto',
          color: Colors.grey,
          icon: Icons.timer_off,
        );
      case UnifiedInviteStatus.revoked:
        return _InviteStatusInfo(
          label: 'Revocato',
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
