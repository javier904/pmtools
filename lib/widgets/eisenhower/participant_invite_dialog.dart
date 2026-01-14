import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;
import '../../models/eisenhower_invite_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../services/eisenhower_invite_service.dart';
import '../../services/auth_service.dart';

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
  final List<EisenhowerInviteModel> pendingInvites;

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
    List<EisenhowerInviteModel> pendingInvites = const [],
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
  final _inviteService = EisenhowerInviteService();
  final _authService = AuthService();

  EisenhowerParticipantRole _selectedRole = EisenhowerParticipantRole.voter;
  bool _isLoading = false;
  bool _sendEmailWithInvite = true; // Toggle per invio email
  String? _generatedLink;
  List<EisenhowerInviteModel> _invites = [];

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
    final invites = await _inviteService.getInvitesForMatrix(widget.matrixId);
    if (mounted) {
      setState(() => _invites = invites);
    }
  }

  Future<void> _sendInvite() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final invite = await _inviteService.createInvite(
        matrixId: widget.matrixId,
        email: _emailController.text.trim(),
        role: _selectedRole,
      );

      if (invite != null) {
        final link = _inviteService.generateInviteLink(invite.token);
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
  Future<bool> _sendEmailInvite(EisenhowerInviteModel invite) async {
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
          matrixTitle: widget.matrixTitle,
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
          matrixTitle: widget.matrixTitle,
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
        final link = _inviteService.generateInviteLink(invite.token);
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
          const Icon(Icons.person_add, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Invita Partecipanti', style: TextStyle(fontSize: 18)),
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
                    const Text(
                      'NUOVO INVITO',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
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
                    const SizedBox(height: 12),

                    // Ruolo
                    Row(
                      children: [
                        const Text('Ruolo: '),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Votante'),
                          selected: _selectedRole == EisenhowerParticipantRole.voter,
                          onSelected: (_) => setState(
                              () => _selectedRole = EisenhowerParticipantRole.voter),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('Osservatore'),
                          selected: _selectedRole == EisenhowerParticipantRole.observer,
                          onSelected: (_) => setState(
                              () => _selectedRole = EisenhowerParticipantRole.observer),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Toggle invio email
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _sendEmailWithInvite
                            ? Colors.green.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _sendEmailWithInvite
                              ? Colors.green.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.3),
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
                              'Invia email di notifica',
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
                          backgroundColor: Colors.blue,
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
                const Text(
                  'INVITI',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
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
          onPressed: () => Navigator.pop(context, _invites.any((i) => i.isAccepted)),
          child: const Text('Chiudi'),
        ),
      ],
    );
  }

  Widget _buildInviteRow(EisenhowerInviteModel invite) {
    final statusInfo = _getStatusInfo(invite.status);

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
                      invite.role.displayName,
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
          if (invite.isPending) ...[
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
    );
  }

  _InviteStatusInfo _getStatusInfo(EisenhowerInviteStatus status) {
    switch (status) {
      case EisenhowerInviteStatus.pending:
        return _InviteStatusInfo(
          label: 'In attesa',
          color: Colors.orange,
          icon: Icons.hourglass_empty,
        );
      case EisenhowerInviteStatus.accepted:
        return _InviteStatusInfo(
          label: 'Accettato',
          color: Colors.green,
          icon: Icons.check_circle,
        );
      case EisenhowerInviteStatus.declined:
        return _InviteStatusInfo(
          label: 'Rifiutato',
          color: Colors.red,
          icon: Icons.cancel,
        );
      case EisenhowerInviteStatus.expired:
        return _InviteStatusInfo(
          label: 'Scaduto',
          color: Colors.grey,
          icon: Icons.timer_off,
        );
      case EisenhowerInviteStatus.revoked:
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
