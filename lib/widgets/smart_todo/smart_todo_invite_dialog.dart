import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis_auth/auth_io.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../services/smart_todo_invite_service.dart';
import '../../services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import '../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n?.smartTodoInviteCollaborator ?? 'Invite Collaborator'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: l10n?.smartTodoEmailLabel ?? 'Email',
              icon: const Icon(Icons.email),
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<TodoParticipantRole>(
            value: _role,
            decoration: InputDecoration(
              labelText: l10n?.smartTodoRole ?? 'Role',
              icon: const Icon(Icons.security),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(value: TodoParticipantRole.editor, child: Text(l10n?.smartTodoEditorRole ?? 'Editor (Can edit)')),
              DropdownMenuItem(value: TodoParticipantRole.viewer, child: Text(l10n?.smartTodoViewerRole ?? 'Viewer (View only)')),
            ],
            onChanged: (v) => setState(() => _role = v!),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _sendEmail,
            onChanged: (v) => setState(() => _sendEmail = v ?? true),
            title: Text(l10n?.smartTodoSendEmailNotification ?? 'Send email notification'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text(l10n?.smartTodoCancel ?? 'Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _sendInvite,
          child: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(l10n?.smartTodoSend ?? 'Send'),
        ),
      ],
    );
  }

  Future<void> _sendInvite() async {
    final l10n = AppLocalizations.of(context);
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(l10n?.smartTodoInvalidEmail ?? 'Invalid email'), backgroundColor: Colors.red),
       );
       return;
    }

    setState(() => _isLoading = true);

    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null || currentUser.email == null) throw Exception(l10n?.smartTodoUserNotAuthenticated ?? 'User not authenticated or email missing');

      // 1. Create Invite
      final invite = await _inviteService.createInvite(
        listId: widget.listId,
        email: email,
        role: _role,
        invitedBy: currentUser.email!,
        invitedByName: currentUser.displayName ?? currentUser.email ?? (l10n?.smartTodoUser ?? 'User'),
      );

      // 2. Send Email if requested
      if (_sendEmail) {
        // Use GoogleSignIn account to get headers
        final googleUser = _authService.googleSignIn.currentUser;
        if (googleUser == null) {
          throw Exception(l10n?.smartTodoGoogleLoginRequired ?? 'Google login required to send email');
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
          SnackBar(content: Text(l10n?.smartTodoInviteSent(email) ?? 'Invite sent to $email')),
        );
      }
    } catch (e) {
      if (mounted) {
        String msg = l10n?.smartTodoError(e.toString()) ?? 'Error: $e';
        if (e.toString().contains('Esiste già') || e.toString().contains('already exists')) {
          msg = l10n?.smartTodoUserAlreadyInvitedOrPending ?? 'User already invited or invite pending.';
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
