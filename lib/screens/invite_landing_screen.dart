import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/invite_aggregator_service.dart';
import '../models/unified_invite_model.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_colors.dart';
import 'login_screen.dart';

/// Screen che gestisce i deep link per gli inviti
/// Flusso:
/// 1. Verifica autenticazione
/// 2. Se non autenticato, mostra login con redirect
/// 3. Se autenticato, valida l'invito e reindirizza all'istanza
class InviteLandingScreen extends StatefulWidget {
  final InviteSourceType sourceType;
  final String sourceId;
  final String? inviteId;

  const InviteLandingScreen({
    super.key,
    required this.sourceType,
    required this.sourceId,
    this.inviteId,
  });

  @override
  State<InviteLandingScreen> createState() => _InviteLandingScreenState();
}

class _InviteLandingScreenState extends State<InviteLandingScreen> {
  final AuthService _authService = AuthService();
  final InviteAggregatorService _inviteService = InviteAggregatorService();

  bool _isLoading = true;
  String? _errorMessage;
  UnifiedInviteModel? _invite;

  @override
  void initState() {
    super.initState();
    _processInvite();
  }

  Future<void> _processInvite() async {
    final user = _authService.currentUser;

    if (user == null) {
      // Utente non autenticato - mostrerà login
      setState(() => _isLoading = false);
      return;
    }

    // Utente autenticato - cerca e valida l'invito
    await _validateAndRedirect(user);
  }

  Future<void> _validateAndRedirect(User user) async {
    try {
      // Cerca l'invito per questo utente
      final invites = await _inviteService.getAllPendingInvites();

      // Filtra per source type e source id
      final matchingInvites = invites.where((invite) =>
        invite.sourceType == widget.sourceType &&
        invite.sourceId == widget.sourceId
      ).toList();

      if (matchingInvites.isEmpty) {
        // Potrebbe essere già accettato o non esiste - prova ad aprire direttamente
        _navigateToInstance();
        return;
      }

      // Trovato l'invito
      final invite = matchingInvites.first;

      if (invite.status == UnifiedInviteStatus.pending) {
        // Invito in attesa - chiedi se accettare
        setState(() {
          _invite = invite;
          _isLoading = false;
        });
      } else {
        // Invito già accettato o rifiutato - vai all'istanza
        _navigateToInstance();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _navigateToInstance() {
    final route = _getRouteForSourceType(widget.sourceType);
    final arguments = _getArgumentsForSourceType();

    Navigator.of(context).pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  String _getRouteForSourceType(InviteSourceType type) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return '/eisenhower';
      case InviteSourceType.estimationRoom:
        return '/estimation-room';
      case InviteSourceType.agileProject:
        return '/agile-project';
      case InviteSourceType.smartTodo:
        return '/smart-todo';
      case InviteSourceType.retroBoard:
        return '/retrospective-board';
    }
  }

  Map<String, dynamic> _getArgumentsForSourceType() {
    switch (widget.sourceType) {
      case InviteSourceType.eisenhower:
        return {'matrixId': widget.sourceId};
      case InviteSourceType.estimationRoom:
        return {'sessionId': widget.sourceId};
      case InviteSourceType.agileProject:
        return {'projectId': widget.sourceId};
      case InviteSourceType.smartTodo:
        return {'listId': widget.sourceId};
      case InviteSourceType.retroBoard:
        return {'boardId': widget.sourceId};
    }
  }

  Future<void> _acceptAndNavigate() async {
    if (_invite == null) return;

    setState(() => _isLoading = true);

    final success = await _inviteService.acceptInvite(_invite!);

    if (success) {
      _navigateToInstance();
    } else {
      setState(() {
        _errorMessage = 'Failed to accept invite';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLoginSuccess() async {
    setState(() => _isLoading = true);

    final user = _authService.currentUser;
    if (user != null) {
      await _validateAndRedirect(user);
    } else {
      setState(() {
        _errorMessage = 'Login failed';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = _authService.currentUser;

    // Loading state
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                l10n.stateLoading,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Error state
    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.errorGeneric(_errorMessage!)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                  child: Text(l10n.searchBackToDashboard),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Not authenticated - show login
    if (user == null) {
      return LoginScreen(
        onLoginSuccess: _handleLoginSuccess,
        showBackButton: true,
      );
    }

    // Show invite acceptance dialog
    if (_invite != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.pendingInvites),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIconForSourceType(_invite!.sourceType),
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _invite!.sourceName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.invitedBy(_invite!.invitedByName.isNotEmpty ? _invite!.invitedByName : _invite!.invitedBy),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _invite!.role,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                            child: Text(l10n.inviteDecline),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _acceptAndNavigate,
                            child: Text(l10n.inviteAccept),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Fallback - should not reach here
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  IconData _getIconForSourceType(InviteSourceType type) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return Icons.grid_4x4_rounded;
      case InviteSourceType.estimationRoom:
        return Icons.casino_rounded;
      case InviteSourceType.agileProject:
        return Icons.folder_rounded;
      case InviteSourceType.smartTodo:
        return Icons.check_circle_rounded;
      case InviteSourceType.retroBoard:
        return Icons.dashboard_rounded;
    }
  }
}
