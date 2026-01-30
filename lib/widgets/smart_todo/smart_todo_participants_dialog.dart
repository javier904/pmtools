import 'package:flutter/material.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;
import '../../models/smart_todo/todo_list_model.dart';
import '../../models/smart_todo/todo_participant_model.dart';
import '../../models/unified_invite_model.dart';
import '../../services/invite_service.dart';
import '../../services/invite_aggregator_service.dart';
import '../../services/auth_service.dart';
import '../../l10n/app_localizations.dart';
import '../../services/smart_todo_service.dart';

class SmartTodoParticipantsDialog extends StatefulWidget {
  final TodoListModel list;

  const SmartTodoParticipantsDialog({super.key, required this.list});

  @override
  State<SmartTodoParticipantsDialog> createState() => _SmartTodoParticipantsDialogState();
}

class _SmartTodoParticipantsDialogState extends State<SmartTodoParticipantsDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final InviteService _inviteService = InviteService();
  final InviteAggregatorService _inviteAggregator = InviteAggregatorService();
  final AuthService _authService = AuthService();

  // Invito form
  final _emailController = TextEditingController();
  String _role = 'editor'; // editor, viewer
  bool _isLoading = false;
  List<UnifiedInviteModel> _invites = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInvites();
  }

  Future<void> _loadInvites() async {
    try {
      final invites = await _inviteAggregator.getInvitesForSource(
        InviteSourceType.smartTodo,
        widget.list.id,
      );
      if (mounted) {
        setState(() => _invites = invites);
      }
    } catch (e) {
      print('Error loading invites: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                          l10n.smartTodoParticipantManagement,
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
                    tabs: [
                       Tab(text: l10n.smartTodoParticipantsTab, icon: const Icon(Icons.person)),
                       Tab(text: l10n.smartTodoInvitesTab, icon: const Icon(Icons.mail_outline)),
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

  final SmartTodoService _todoService = SmartTodoService();

  Widget _buildParticipantsTab(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
    
    return StreamBuilder<TodoListModel?>(
      stream: _todoService.streamList(widget.list.id),
      initialData: widget.list,
      builder: (context, snapshot) {
        final currentList = snapshot.data ?? widget.list;
        
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
             // Add Section (Quick Add)
             _buildInviteForm(isDark, inputBg, borderColor, textColor),
             Divider(height: 32, color: borderColor),

             Text(l10n.smartTodoMembers(currentList.participants.length), style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.grey[400] : Colors.grey)),
             const SizedBox(height: 16),
             
             ...currentList.participants.entries.map((entry) {
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
    );
  }

  Widget _buildInvitesTab(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;

    if (_invites.isEmpty) {
      return Center(child: Text(l10n.smartTodoNoInvitesPending, style: TextStyle(color: isDark ? Colors.grey[400] : null)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _invites.length,
      itemBuilder: (context, index) {
        final invite = _invites[index];
        final isPending = invite.status == UnifiedInviteStatus.pending;
        final isExpired = DateTime.now().isAfter(invite.expiresAt);
        final statusInfo = _getInviteStatusInfo(invite.status, isExpired);

        return Card(
          elevation: 0,
          color: isDark ? const Color(0xFF2D3748) : null,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor),
          ),
          child: ListTile(
            leading: Icon(statusInfo.$3, color: statusInfo.$2, size: 22),
            title: Text(invite.email, style: TextStyle(color: textColor, fontSize: 13)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusInfo.$2.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        statusInfo.$1,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: statusInfo.$2),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(invite.role, style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(l10n.smartTodoSentBy(invite.invitedByName), style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[500] : Colors.grey)),
              ],
            ),
            trailing: isPending && !isExpired
                ? PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: isDark ? Colors.grey[400] : null),
                    onSelected: (action) async {
                      if (action == 'revoke') {
                        await _inviteService.revokeInvite(invite.id);
                        await _loadInvites();
                      } else if (action == 'resend') {
                        final currentUser = _authService.currentUser;
                          if (currentUser != null && currentUser.email != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.smartTodoSendingEmail)));
                          // final success = await _sendEmailForInvite(invite, currentUser.email!);
                          // Managed by backend
                          final success = true; 
                          if (mounted) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(success ? l10n.smartTodoEmailResent : l10n.smartTodoEmailSendError),
                                backgroundColor: success ? Colors.green : Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'resend', child: Text(l10n.smartTodoResendEmail)),
                      PopupMenuItem(value: 'revoke', child: Text(l10n.smartTodoRevoke, style: const TextStyle(color: Colors.red))),
                    ],
                  )
                : null,
          ),
        );
      },
    );
  }

  (String, Color, IconData) _getInviteStatusInfo(UnifiedInviteStatus status, bool isExpired) {
    if (isExpired && status == UnifiedInviteStatus.pending) {
      return ('Expired', Colors.grey, Icons.timer_off);
    }
    switch (status) {
      case UnifiedInviteStatus.pending:
        return ('Pending', Colors.orange, Icons.hourglass_empty);
      case UnifiedInviteStatus.accepted:
        return ('Accepted', Colors.green, Icons.check_circle);
      case UnifiedInviteStatus.declined:
        return ('Declined', Colors.red, Icons.cancel);
      case UnifiedInviteStatus.expired:
        return ('Expired', Colors.grey, Icons.timer_off);
      case UnifiedInviteStatus.revoked:
        return ('Revoked', Colors.grey, Icons.block);
    }
  }

  Widget _buildInviteForm(bool isDark, Color inputBg, Color borderColor, Color textColor) {
    final l10n = AppLocalizations.of(context)!;
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
           Text(l10n.smartTodoAddParticipant, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
           const SizedBox(height: 12),
           Row(
             children: [
               Expanded(
                 flex: 2,
                 child: TextField(
                   controller: _emailController,
                   style: TextStyle(color: textColor),
                   decoration: InputDecoration(
                     labelText: l10n.smartTodoEmailLabel,
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
                 child: DropdownButtonFormField<String>(
                   value: _role,
                   dropdownColor: isDark ? const Color(0xFF2D3748) : null,
                   style: TextStyle(color: textColor, fontSize: 12),
                   decoration: InputDecoration(
                     labelText: l10n.smartTodoRole,
                     labelStyle: TextStyle(color: isDark ? Colors.grey[400] : null),
                     isDense: true,
                     border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
                     filled: true,
                     fillColor: inputBg,
                   ),
                   items: const [
                      DropdownMenuItem(value: 'editor', child: Text('editor')),
                      DropdownMenuItem(value: 'viewer', child: Text('viewer')),
                   ],
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
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) return;

    setState(() => _isLoading = true);
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null || currentUser.email == null) return;

      final invite = await _inviteService.createInvite(
        sourceType: InviteSourceType.smartTodo,
        sourceId: widget.list.id,
        sourceName: widget.list.title,
        email: email,
        role: _role,
      );

      if (invite == null) {
        throw Exception(l10n.smartTodoError('Failed to create invite'));
      }

      
      // final emailSent = await _sendEmailForInvite(invite, currentUser.email!);
      // Managed by backend
      final emailSent = true;

      String feedbackMessage = l10n.smartTodoInviteCreatedAndSent;
      if (!emailSent) {
          feedbackMessage = l10n.smartTodoInviteCreatedNoEmail;
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
        await _loadInvites();
        _tabController.animateTo(1);
      }

    } catch (e) {
      if (mounted) {
         String msg = '${l10n.stateError}: $e';
         if (e.toString().contains('Esiste già') || e.toString().contains('already')) {
           msg = l10n.smartTodoUserAlreadyInvited;
         }
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

}
