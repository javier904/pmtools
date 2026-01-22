import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';
import '../models/unified_invite_model.dart';
import '../models/planning_poker_session_model.dart';
import '../models/planning_poker_participant_model.dart';
import '../services/invite_service.dart';
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
  final _inviteService = InviteService();
  final _firestoreService = PlanningPokerFirestoreService();
  final _authService = AuthService();

  bool _isLoading = true;
  bool _isProcessing = false;
  String? _errorMessage;
  UnifiedInviteModel? _invite;
  PlanningPokerSessionModel? _session;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInvite());
  }

  Future<void> _loadInvite() async {
    // L10n requires context, ensured by addPostFrameCallback
    final l10n = AppLocalizations.of(context);
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Verifica autenticazione
      if (_authService.currentUser == null) {
        setState(() {
          _errorMessage = l10n?.exceptionUserNotAuthenticated ?? 'Devi effettuare il login per accettare l\'invito';
          _isLoading = false;
        });
        return;
      }

      // Carica invito
      final invite = await _inviteService.getInviteByToken(widget.token);

      if (invite == null) {
        setState(() {
          _errorMessage = l10n?.exceptionInviteInvalid ?? 'Invito non trovato o non valido';
          _isLoading = false;
        });
        return;
      }

      // Verifica stato invito
      if (invite.status != UnifiedInviteStatus.pending) {
        setState(() {
          _errorMessage = 'Questo invito ${_getStatusMessage(invite.status)}'; // Keeping partial hardcode or need composite
          _isLoading = false;
        });
        return;
      }

      // Verifica scadenza (usando isValid che controlla sia pending che non scaduto)
      if (!invite.isValid) {
        setState(() {
          _errorMessage = l10n?.exceptionInviteCalculated ?? 'Questo invito è scaduto';
          _isLoading = false;
        });
        return;
      }

      // Verifica email
      final currentEmail = _authService.currentUser?.email?.toLowerCase();
      if (currentEmail != invite.email.toLowerCase()) {
        setState(() {
          _errorMessage = l10n?.exceptionInviteWrongUser ?? 'Questo invito è destinato a un altro utente (${invite.email}).';
          _isLoading = false;
        });
        return;
      }

      // Carica sessione per mostrare dettagli
      final session = await _firestoreService.getSession(invite.sourceId);

      setState(() {
        _invite = invite;
        _session = session;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '${l10n?.errorLoading ?? "Errore"}: $e';
        _isLoading = false;
      });
    }
  }

  String _getStatusMessage(UnifiedInviteStatus status) {
    switch (status) {
      case UnifiedInviteStatus.accepted:
        return 'è già stato accettato';
      case UnifiedInviteStatus.declined:
        return 'è stato rifiutato';
      case UnifiedInviteStatus.expired:
        return 'è scaduto';
      case UnifiedInviteStatus.revoked:
        return 'è stato revocato';
      case UnifiedInviteStatus.pending:
        return 'è in attesa';
    }
  }

  Future<void> _acceptInvite() async {
    if (_invite == null) return;

    setState(() => _isProcessing = true);

    try {
      final success = await _inviteService.acceptInvite(
        _invite!,
        accepterName: _authService.currentUser?.displayName ??
            _authService.currentUser!.email!.split('@').first,
      );

      if (!success) {
        throw Exception('Impossibile accettare l\'invito');
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        // Mostra messaggio di successo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n?.pokerInviteAccepted ?? 'Invito accettato! Verrai reindirizzato alla sessione.'),
            backgroundColor: Colors.green,
          ),
        );

        // Redirect alla sessione
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            '/planning-poker',
            arguments: {'session': _invite!.sourceId},
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
    // Chiedi conferma (Dialog needs context, check async gap or just use context)
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.pokerConfirmRefuseTitle ?? 'Rifiuta Invito'),
        content: Text(l10n?.pokerConfirmRefuseContent ?? 'Sei sicuro di voler rifiutare questo invito?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n?.actionCancel ?? 'Annulla'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n?.actionDelete ?? 'Rifiuta'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isProcessing = true);

    try {
      final success = await _inviteService.declineInvite(_invite!.id);

      if (!success) {
        throw Exception('Impossibile rifiutare l\'invito');
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(l10n?.pokerInviteRefused ?? 'Invito rifiutato'),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)?.pokerVerifyingInvite ?? 'Verifica invito in corso...'),
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
            Text(
              AppLocalizations.of(context)?.exceptionInviteInvalid ?? 'Invito Non Valido',
              style: const TextStyle(
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
                  label: Text(AppLocalizations.of(context)?.actionBackHome ?? 'Torna alla Home'),
                ),
                const SizedBox(width: 16),
                if (_authService.currentUser == null)
                  ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                    icon: const Icon(Icons.login),
                    label: Text(AppLocalizations.of(context)?.actionSignin ?? 'Accedi'),
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

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'facilitator':
        return Colors.amber;
      case 'voter':
        return Colors.green;
      case 'observer':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'facilitator':
        return Icons.star;
      case 'voter':
        return Icons.how_to_vote;
      case 'observer':
        return Icons.visibility;
      default:
        return Icons.person;
    }
  }

  String _getRoleName(String role) {
    final l10n = AppLocalizations.of(context);
    switch (role.toLowerCase()) {
      case 'facilitator':
        return l10n?.participantFacilitator ?? 'Facilitatore';
      case 'voter':
        return l10n?.participantVoter ?? 'Votante';
      case 'observer':
        return l10n?.participantObserver ?? 'Osservatore';
      default:
        return role;
    }
  }
}
