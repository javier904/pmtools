import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_invite_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_invite_service.dart';
import '../../services/auth_service.dart';

class SmartTodoParticipantsDialog extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoParticipantsDialog({super.key, required this.list});

  @override
  State<SmartTodoParticipantsDialog> createState() => _SmartTodoParticipantsDialogState();
}

class _SmartTodoParticipantsDialogState extends State<SmartTodoParticipantsDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SmartTodoInviteService _inviteService = SmartTodoInviteService();
  final AuthService _authService = AuthService();
  
  // Invito form
  final _emailController = TextEditingController();
  TodoParticipantRole _role = TodoParticipantRole.editor;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E2633) : Colors.white;
    final dialogInputBg = isDark ? const Color(0xFF2D3748) : Colors.white;
    final dialogHeaderBg = isDark ? const Color(0xFF2D3748) : Colors.grey[50];
    final dialogBorder = isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200]!;
    final dialogTextColor = isDark ? Colors.white : Colors.black87;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: dialogBg,
      child: Container(
        width: 600,
        height: 700,
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Header con Tabs
            Container(
              decoration: BoxDecoration(
                color: dialogHeaderBg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(bottom: BorderSide(color: dialogBorder)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.people_alt_rounded, color: Colors.blue),
                        const SizedBox(width: 12),
                        Text(
                          'Gestione Partecipanti',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: dialogTextColor),
                        ),
                        const Spacer(),
                        IconButton(
                           icon: Icon(Icons.close, color: isDark ? Colors.grey[400] : null), 
                           onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.blue,
                    unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: const [
                       Tab(text: 'Partecipanti', icon: Icon(Icons.person)),
                       Tab(text: 'Inviti', icon: Icon(Icons.mail_outline)),
                    ],
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildParticipantsTab(isDark, dialogInputBg, dialogBorder, dialogTextColor),
                  _buildInvitesTab(isDark, dialogInputBg, dialogBorder, dialogTextColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantsTab(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
         // Add Section (Quick Add)
         _buildInviteForm(isDark, inputBg, borderColor, textColor),
         Divider(height: 32, color: borderColor),
         
         Text('Membri (${widget.list.participants.length})', style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.grey[400] : Colors.grey)),
         const SizedBox(height: 16),
         
         ...widget.list.participants.entries.map((entry) {
            final p = entry.value;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(p.email[0].toUpperCase(), style: const TextStyle(color: Colors.blue)),
              ),
              title: Text(p.displayName ?? p.email.split('@')[0], style: TextStyle(color: textColor)),
              subtitle: Text(p.email, style: TextStyle(color: isDark ? Colors.grey[400] : null)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  p.role.name.toUpperCase(), 
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isDark ? Colors.grey[300] : null),
                ),
              ),
            );
         }),
      ],
    );
  }

  Widget _buildInvitesTab(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    return StreamBuilder<List<TodoInviteModel>>(
      stream: _inviteService.streamInvites(widget.list.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        
        final invites = snapshot.data!;
        final pending = invites.where((i) => i.status == TodoInviteStatus.pending).toList();
        
        if (pending.isEmpty) {
           return Center(child: Text('Nessun invito in sospeso', style: TextStyle(color: isDark ? Colors.grey[400] : null)));
        }
        
        return ListView.builder(
           padding: const EdgeInsets.all(16),
           itemCount: pending.length,
           itemBuilder: (context, index) {
              final invite = pending[index];
              final isExpired = DateTime.now().isAfter(invite.expiresAt);
              
              return Card(
                elevation: 0,
                color: isDark ? const Color(0xFF2D3748) : null,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12), 
                   side: BorderSide(color: borderColor),
                ),
                child: ListTile(
                   leading: const Icon(Icons.mail, color: Colors.orange),
                   title: Text(invite.email, style: TextStyle(color: textColor)),
                   subtitle: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text('Ruolo: ${invite.role.name}', style: TextStyle(color: isDark ? Colors.grey[400] : null)),
                        if (isExpired) 
                          const Text('SCADUTO', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold))
                        else
                          Text('Inviato da ${invite.invitedByName}', style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[500] : Colors.grey)),
                     ],
                   ),
                   trailing: PopupMenuButton<String>(
                     icon: Icon(Icons.more_vert, color: isDark ? Colors.grey[400] : null),
                     onSelected: (action) async {
                        if (action == 'revoke') {
                           await _inviteService.revokeInvite(widget.list.id, invite.id);
                        } else if (action == 'resend') {
                          final currentUser = _authService.currentUser;
                          if (currentUser != null && currentUser.email != null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invio email in corso...')));
                            final success = await _sendEmailForInvite(invite, currentUser.email!);
                            if (mounted) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(success ? 'Email reinviata!' : 'Errore durante l\'invio.'),
                                  backgroundColor: success ? Colors.green : Colors.red,
                                )
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sessione non valida per inviare email.')));
                          }
                        }
                     },
                     itemBuilder: (context) => [
                        const PopupMenuItem(value: 'resend', child: Text('Reinvia Email')),
                        const PopupMenuItem(value: 'revoke', child: Text('Revoca', style: TextStyle(color: Colors.red))),
                     ],
                   ),
                ),
              );
           }
        );
      },
    );
  }

  Widget _buildInviteForm(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.withOpacity(0.1) : Colors.blue[50]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Aggiungi Partecipante', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
           const SizedBox(height: 12),
           Row(
             children: [
               Expanded(
                 flex: 2,
                 child: TextField(
                   controller: _emailController,
                   style: TextStyle(color: textColor),
                   decoration: InputDecoration(
                     labelText: 'Email',
                     labelStyle: TextStyle(color: isDark ? Colors.grey[400] : null),
                     isDense: true,
                     border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     filled: true,
                     fillColor: inputBg,
                   ),
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 flex: 1,
                 child: DropdownButtonFormField<TodoParticipantRole>(
                   value: _role,
                   dropdownColor: isDark ? const Color(0xFF2D3748) : null,
                   style: TextStyle(color: textColor, fontSize: 12),
                   decoration: InputDecoration(
                     labelText: 'Ruolo',
                     labelStyle: TextStyle(color: isDark ? Colors.grey[400] : null),
                     isDense: true,
                     border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     filled: true,
                     fillColor: inputBg,
                   ),
                   items: TodoParticipantRole.values.map((r) => DropdownMenuItem(
                      value: r, 
                      child: Text(r.name),
                   )).toList(),
                   onChanged: (v) => setState(() => _role = v!),
                 ),
               ),
               const SizedBox(width: 12),
               IconButton.filled(
                 icon: _isLoading 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                    : const Icon(Icons.add),
                 onPressed: _isLoading ? null : _sendInvite,
               ),
             ],
           ),
        ],
      ),
    );
  }

  Future<void> _sendInvite() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) return;

    setState(() => _isLoading = true);
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null || currentUser.email == null) return;
      
      final invite = await _inviteService.createInvite(
        listId: widget.list.id,
        email: email,
        role: _role,
        invitedBy: currentUser.email!,
        invitedByName: currentUser.displayName ?? 'Utente',
      );
      
      final emailSent = await _sendEmailForInvite(invite, currentUser.email!);
      
      String feedbackMessage = 'Invito creato e inviato con successo!';
      if (!emailSent) {
          feedbackMessage = 'Invito creato, ma email non inviata (controlla login/permessi Google).';
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(feedbackMessage),
            backgroundColor: emailSent ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 4),
          )
        );
        _emailController.clear();
        _tabController.animateTo(1);
      }
      
    } catch (e) {
      if (mounted) {
         String msg = 'Errore: $e';
         if (e.toString().contains('Esiste già')) msg = 'Utente già invitato.';
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<bool> _sendEmailForInvite(TodoInviteModel invite, String senderEmail) async {
      try {
        var googleUser = _authService.googleSignIn.currentUser;
        if (googleUser == null) {
          try {
            googleUser = await _authService.googleSignIn.signInSilently();
          } catch (e) {
            debugPrint('Error signing in silently: $e');
          }
        }
        
        if (googleUser == null) {
          googleUser = await _authService.googleSignIn.signIn();
        }

        if (googleUser != null) {
          final authHeaders = await googleUser.authHeaders;
          final httpClient = _GoogleAuthClient(authHeaders);
          final gmailApi = gmail.GmailApi(httpClient);

          return await _inviteService.sendInviteEmail(
            invite: invite,
            listName: widget.list.title,
            senderEmail: senderEmail,
            gmailApi: gmailApi,
          );
        } else {
          print('Google User null after login attempt');
          return false;
        }
      } catch (e) {
        print('Errore invio email helper: $e');
        return false;
      }
  }
}

class _GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  _GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
