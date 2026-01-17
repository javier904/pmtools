import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis_auth/auth_io.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_invite_service.dart';
import '../../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class SmartTodoInviteDialog extends StatefulWidget {
  final String listId;
  final String listName;

  const SmartTodoInviteDialog({
    super.key,
    required this.listId,
    required this.listName,
  });

  @override
  State<SmartTodoInviteDialog> createState() => _SmartTodoInviteDialogState();
}

class _SmartTodoInviteDialogState extends State<SmartTodoInviteDialog> {
  final _emailController = TextEditingController();
  final _inviteService = SmartTodoInviteService();
  final _authService = AuthService();
  
  TodoParticipantRole _role = TodoParticipantRole.editor;
  bool _sendEmail = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Invita Collaboratore'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<TodoParticipantRole>(
            value: _role,
            decoration: const InputDecoration(
              labelText: 'Ruolo',
              icon: Icon(Icons.security),
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: TodoParticipantRole.editor, child: Text('Editor (Può modificare)')),
              DropdownMenuItem(value: TodoParticipantRole.viewer, child: Text('Viewer (Solo visualizzazione)')),
            ],
            onChanged: (v) => setState(() => _role = v!),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _sendEmail,
            onChanged: (v) => setState(() => _sendEmail = v ?? true),
            title: const Text('Invia notifica email'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('Annulla'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _sendInvite,
          child: _isLoading 
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
            : const Text('Invia'),
        ),
      ],
    );
  }

  Future<void> _sendInvite() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Email non valida'), backgroundColor: Colors.red),
       );
       return;
    }

    setState(() => _isLoading = true);

    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null || currentUser.email == null) throw Exception('Utente non autenticato o email mancante');

      // 1. Create Invite
      final invite = await _inviteService.createInvite(
        listId: widget.listId,
        email: email,
        role: _role,
        invitedBy: currentUser.email!,
        invitedByName: currentUser.displayName ?? currentUser.email ?? 'Utente',
      );

      // 2. Send Email if requested
      if (_sendEmail) {
        // Use GoogleSignIn account to get headers
        final googleUser = _authService.googleSignIn.currentUser;
        if (googleUser == null) {
          throw Exception('Necessario login Google per inviare email');
        }
        
        final authHeaders = await googleUser.authHeaders;
        final httpClient = _GoogleAuthClient(authHeaders);
        final gmailApi = gmail.GmailApi(httpClient);

        await _inviteService.sendInviteEmail(
          invite: invite,
          listName: widget.listName,
          senderEmail: currentUser.email!,
          gmailApi: gmailApi,
        );
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invito inviato a $email')),
        );
      }
    } catch (e) {
      if (mounted) {
        String msg = 'Errore: $e';
        if (e.toString().contains('Esiste già') || e.toString().contains('already exists')) {
          msg = 'Utente già invitato o invito in attesa.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

// Simple Client wrapper (copied pattern)


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
