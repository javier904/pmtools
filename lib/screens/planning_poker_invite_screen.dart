import 'package:flutter/material.dart';
import '../models/planning_poker_invite_model.dart';
import '../models/planning_poker_session_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../services/planning_poker_invite_service.dart';
import '../services/planning_poker_firestore_service.dart';
import '../services/auth_service.dart';

/// Screen per accettare o rifiutare un invito a una sessione Planning Poker
///
/// Gestisce:
/// - Validazione del token invito
/// - Visualizzazione dettagli invito
/// - Accettazione/Rifiuto invito
/// - Redirect alla sessione dopo accettazione
class PlanningPokerInviteScreen extends StatefulWidget {
  final String token;

  const PlanningPokerInviteScreen({
    super.key,
    required this.token,
  });

  @override
  State<PlanningPokerInviteScreen> createState() => _PlanningPokerInviteScreenState();
}

class _PlanningPokerInviteScreenState extends State<PlanningPokerInviteScreen> {
  final _inviteService = PlanningPokerInviteService();
  final _firestoreService = PlanningPokerFirestoreService();
  final _authService = AuthService();

  bool _isLoading = true;
  bool _isProcessing = false;
  String? _errorMessage;
  PlanningPokerInviteModel? _invite;
  PlanningPokerSessionModel? _session;

  @override
  void initState() {
    super.initState();
    _loadInvite();
  }

  Future<void> _loadInvite() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Verifica autenticazione
      if (_authService.currentUser == null) {
        setState(() {
          _errorMessage = 'Devi effettuare il login per accettare l\'invito';
          _isLoading = false;
        });
        return;
      }

      // Carica invito
      final invite = await _inviteService.getInviteByToken(widget.token);

      if (invite == null) {
        setState(() {
          _errorMessage = 'Invito non trovato o non valido';
          _isLoading = false;
        });
        return;
      }

      // Verifica stato invito
      if (invite.status != InviteStatus.pending) {
        setState(() {
          _errorMessage = 'Questo invito ${_getStatusMessage(invite.status)}';
          _isLoading = false;
        });
        return;
      }

      // Verifica scadenza
      if (invite.isExpired) {
        setState(() {
          _errorMessage = 'Questo invito è scaduto';
          _isLoading = false;
        });
        return;
      }

      // Verifica email
      final currentEmail = _authService.currentUser?.email?.toLowerCase();
      if (currentEmail != invite.email.toLowerCase()) {
        setState(() {
          _errorMessage = 'Questo invito è destinato a un altro utente (${invite.email}).\n\nSei loggato come: $currentEmail';
          _isLoading = false;
        });
        return;
      }

      // Carica sessione per mostrare dettagli
      final session = await _firestoreService.getSession(invite.sessionId);

      setState(() {
        _invite = invite;
        _session = session;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Errore nel caricamento dell\'invito: $e';
        _isLoading = false;
      });
    }
  }

  String _getStatusMessage(InviteStatus status) {
    switch (status) {
      case InviteStatus.accepted:
        return 'è già stato accettato';
      case InviteStatus.declined:
        return 'è stato rifiutato';
      case InviteStatus.expired:
        return 'è scaduto';
      case InviteStatus.revoked:
        return 'è stato revocato';
      case InviteStatus.pending:
        return 'è in attesa';
    }
  }

  Future<void> _acceptInvite() async {
    if (_invite == null) return;

    setState(() => _isProcessing = true);

    try {
      await _inviteService.acceptInvite(
        token: widget.token,
        acceptingUserEmail: _authService.currentUser!.email!,
        acceptingUserName: _authService.currentUser?.displayName ??
            _authService.currentUser!.email!.split('@').first,
      );

      if (mounted) {
        // Mostra messaggio di successo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invito accettato! Verrai reindirizzato alla sessione.'),
            backgroundColor: Colors.green,
          ),
        );

        // Redirect alla sessione
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            '/planning-poker',
            arguments: {'session': _invite!.sessionId},
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
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _declineInvite() async {
    if (_invite == null) return;

    // Chiedi conferma
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rifiuta Invito'),
        content: const Text('Sei sicuro di voler rifiutare questo invito?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Rifiuta'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isProcessing = true);

    try {
      await _inviteService.declineInvite(token: widget.token);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invito rifiutato'),
            backgroundColor: Colors.orange,
          ),
        );

        // Torna alla home
        Navigator.of(context).pushReplacementNamed('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Errore: $e'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Verifica invito in corso...'),
        ],
      );
    }

    if (_errorMessage != null) {
      return _buildErrorView();
    }

    if (_invite != null) {
      return _buildInviteView();
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorView() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Invito Non Valido',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
                  icon: const Icon(Icons.home),
                  label: const Text('Torna alla Home'),
                ),
                const SizedBox(width: 16),
                if (_authService.currentUser == null)
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                    icon: const Icon(Icons.login),
                    label: const Text('Accedi'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteView() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mail_outline,
                size: 40,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sei Stato Invitato!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${_invite!.invitedByName} ti ha invitato a partecipare',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Dettagli sessione
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.casino,
                    label: 'Sessione',
                    value: _session?.name ?? 'Planning Poker',
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    icon: Icons.folder,
                    label: 'Progetto',
                    value: _session?.projectName ?? '-',
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    icon: _getRoleIcon(_invite!.role),
                    label: 'Ruolo Assegnato',
                    value: _getRoleName(_invite!.role),
                    valueColor: _getRoleColor(_invite!.role),
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    icon: Icons.timer,
                    label: 'Scadenza Invito',
                    value: 'Tra ${_invite!.daysUntilExpiration} giorni',
                    valueColor: _invite!.daysUntilExpiration <= 2 ? Colors.orange : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Bottoni azione
            if (_isProcessing)
              const CircularProgressIndicator()
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _declineInvite,
                      icon: const Icon(Icons.close),
                      label: const Text('Rifiuta'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: _acceptInvite,
                      icon: const Icon(Icons.check),
                      label: const Text('Accetta Invito'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRoleColor(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return Colors.amber;
      case ParticipantRole.voter:
        return Colors.green;
      case ParticipantRole.observer:
        return Colors.blue;
    }
  }

  IconData _getRoleIcon(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return Icons.star;
      case ParticipantRole.voter:
        return Icons.how_to_vote;
      case ParticipantRole.observer:
        return Icons.visibility;
    }
  }

  String _getRoleName(ParticipantRole role) {
    switch (role) {
      case ParticipantRole.facilitator:
        return 'Facilitatore';
      case ParticipantRole.voter:
        return 'Votante';
      case ParticipantRole.observer:
        return 'Osservatore';
    }
  }
}
