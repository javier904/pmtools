import 'package:flutter/material.dart';
import '../../models/eisenhower_activity_model.dart';
import '../../models/eisenhower_matrix_model.dart';
import '../../models/eisenhower_participant_model.dart';
import '../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import 'voting_status_widget.dart';

/// Card per visualizzare una singola attività nella matrice
///
/// Supporta il flusso di votazione collettiva a 3 stati:
/// - STATO 1 (isWaitingForVoting): In attesa che il facilitatore avvii
/// - STATO 2 (isVotingInProgress): Votazione in corso, voti nascosti
/// - STATO 3 (isVotingComplete): Voti rivelati, risultati visibili
class ActivityCardWidget extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final Color? quadrantColor;
  final VoidCallback onTap;
  final VoidCallback? onVoteTap;
  final VoidCallback? onDeleteTap;
  final bool showActions;
  final bool compact;

  // Parametri per votazione collettiva
  final String? currentUserEmail;
  final bool isFacilitator;
  final bool isObserver;
  final int totalVoters; // Include solo i VOTER (non facilitatore/observer)
  final VoidCallback? onStartIndependentVoting;
  final VoidCallback? onSubmitIndependentVote;
  final VoidCallback? onRevealVotes;
  final VoidCallback? onResetVoting;

  const ActivityCardWidget({
    super.key,
    required this.activity,
    this.quadrantColor,
    required this.onTap,
    this.onVoteTap,
    this.onDeleteTap,
    this.showActions = true,
    this.compact = false,
    // Parametri votazione collettiva
    this.currentUserEmail,
    this.isFacilitator = false,
    this.isObserver = false,
    this.totalVoters = 0,
    this.onStartIndependentVoting,
    this.onSubmitIndependentVote,
    this.onRevealVotes,
    this.onResetVoting,
  });

  /// Numero totale di votanti attesi
  /// NOTA: totalVoters già include il facilitatore (voterCount include chi ha canVote=true)
  int get _totalExpectedVoters => totalVoters;

  /// Verifica se l'utente corrente ha già votato su questa attività
  /// Usa email escapata per cercare nel map dei voti
  bool get _hasCurrentUserVoted {
    if (currentUserEmail == null) return false;
    final escapedEmail = EisenhowerParticipantModel.escapeEmail(currentUserEmail!);
    // Cerca sia con email normale che escapata
    return activity.votes.containsKey(escapedEmail) ||
           activity.votes.containsKey(currentUserEmail!);
  }

  /// Ottiene il voto dell'utente corrente (se esiste)
  EisenhowerVote? get _currentUserVote {
    if (currentUserEmail == null) return null;
    final escapedEmail = EisenhowerParticipantModel.escapeEmail(currentUserEmail!);
    // Cerca sia con email normale che escapata
    return activity.votes[escapedEmail] ?? activity.votes[currentUserEmail!];
  }

  /// Verifica se tutti i votanti attesi hanno votato
  /// Include: tutti i voters + il facilitatore
  bool get _areAllVotersReady {
    // Il count di readyVoters deve essere >= totalVoters + 1 (facilitatore)
    return activity.readyVoters.length >= _totalExpectedVoters;
  }

  /// L'utente corrente può votare?
  /// - Non è observer
  /// - L'attività non è già rivelata
  bool get _canVote {
    if (isObserver) return false;
    if (activity.isVotingComplete) return false; // Non si può votare se rivelata
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Il colore del quadrante viene mostrato solo se l'attività è stata rivelata
    final color = quadrantColor ??
        (activity.isRevealed && activity.quadrant != null
            ? Color(activity.quadrant!.colorValue)
            : Colors.grey);

    if (compact) {
      return _buildCompactCard(context, color, l10n);
    }
    return _buildFullCard(context, color, l10n);
  }

  Widget _buildCompactCard(BuildContext context, Color color, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? const Color(0xFF2D3748) : Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // Indicatore colore
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              // Titolo
              Expanded(
                child: Text(
                  activity.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : null,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Punteggio se votato E rivelato
              if (activity.isRevealed && activity.hasVotes) ...[
                const SizedBox(width: 4),
                _buildScoreBadge(color),
              ]
              // Indicatore "Hai votato" se l'utente ha votato ma non è ancora rivelato
              else if (_hasCurrentUserVoted && !activity.isRevealed) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check, size: 12, color: Colors.green),
                      const SizedBox(width: 2),
                      const Text(
                        'Votato',
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
              // Azioni
              if (showActions) ...[
                if (onVoteTap != null)
                  IconButton(
                    icon: Icon(
                      activity.hasVotes ? Icons.edit : Icons.how_to_vote,
                      size: 16,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    onPressed: onVoteTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    tooltip: activity.hasVotes ? l10n.eisenhowerModifyVotes : l10n.eisenhowerVote,
                  ),
                if (onDeleteTap != null)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16,
                      color: isDark ? Colors.grey[500] : Colors.grey[400],
                    ),
                    onPressed: onDeleteTap,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 28,
                    ),
                    tooltip: l10n.actionDelete,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullCard(BuildContext context, Color color, AppLocalizations l10n) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con titolo e azioni
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Indicatore quadrante (solo se rivelato)
                  if (activity.isRevealed && activity.quadrant != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        activity.quadrant!.name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  if (activity.isRevealed && activity.quadrant != null) const SizedBox(width: 8),
                  // Titolo
                  Expanded(
                    child: Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Menu azioni (mostra solo se ci sono azioni disponibili)
                  if (showActions && (onVoteTap != null || onDeleteTap != null))
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 20),
                      padding: EdgeInsets.zero,
                      onSelected: (value) {
                        switch (value) {
                          case 'vote':
                            onVoteTap?.call();
                            break;
                          case 'delete':
                            onDeleteTap?.call();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        // Voto (solo se onVoteTap e' disponibile)
                        if (onVoteTap != null)
                          PopupMenuItem(
                            value: 'vote',
                            child: Row(
                              children: [
                                Icon(
                                  _hasCurrentUserVoted ? Icons.edit : Icons.how_to_vote,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Text(_hasCurrentUserVoted ? l10n.eisenhowerModifyVotes : l10n.eisenhowerVote),
                              ],
                            ),
                          ),
                        // Delete (solo se onDeleteTap e' disponibile - facilitatore)
                        if (onDeleteTap != null)
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(l10n.actionDelete, style: const TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              // Descrizione
              if (activity.description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              // Tags
              if (activity.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: activity.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              // Footer con punteggi - mostra risultati aggregati SOLO se rivelato
              if (activity.isRevealed && activity.hasVotes) ...[
                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Urgenza
                    _buildScoreIndicator(
                      l10n.eisenhowerUrgency,
                      activity.aggregatedUrgency,
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    // Importanza
                    _buildScoreIndicator(
                      l10n.eisenhowerImportance,
                      activity.aggregatedImportance,
                      Colors.green,
                    ),
                    const Spacer(),
                    // Numero voti
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.how_to_vote, size: 12, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${activity.voteCount}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
              // Se l'utente ha votato ma non è ancora rivelato: mostra il proprio voto
              else if (_hasCurrentUserVoted && !activity.isRevealed) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, size: 14, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        'Il tuo voto: U=${_currentUserVote!.urgency}, I=${_currentUserVote!.importance}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
              // Nessun voto ancora
              else if (!activity.hasVotes) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber, size: 14, color: Colors.amber[700]),
                      const SizedBox(width: 6),
                      Text(
                        l10n.eisenhowerWaitingForVotes,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.amber[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // === SEZIONE VOTAZIONE COLLETTIVA (3 STATI) ===
              // STATO 1: In attesa - facilitatore può avviare, voter può pre-votare
              if (activity.isWaitingForVoting && _totalExpectedVoters > 1) ...[
                const SizedBox(height: 12),
                _buildWaitingForVotingSection(l10n),
              ]
              // STATO 2: Votazione in corso - voti nascosti fino al reveal
              else if (activity.isVotingInProgress) ...[
                const SizedBox(height: 12),
                _buildVotingInProgressSection(l10n),
              ],
              // STATO 3: Rivelata - i risultati sono già mostrati sopra nel footer
            ],
          ),
        ),
      ),
    );
  }

  /// STATO 1: In attesa che il facilitatore avvii la votazione
  ///
  /// - Facilitatore: vede "Avvia Votazione" e può pre-votare
  /// - Voter: può pre-votare (voto nascosto a tutti)
  /// - Observer: vede solo messaggio "In attesa"
  Widget _buildWaitingForVotingSection(AppLocalizations l10n) {
    // Conta i pre-voti esistenti
    final preVoteCount = activity.votes.length;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header stato
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.hourglass_empty, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      l10n.eisenhowerWaitingForStart,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Mostra se ci sono pre-voti
              if (preVoteCount > 0)
                Tooltip(
                  message: l10n.eisenhowerPreVotesTooltip,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$preVoteCount pre-voti',
                      style: TextStyle(fontSize: 10, color: Colors.green[700]),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Azioni basate sul ruolo
          if (isObserver) ...[
            // Observer: solo messaggio
            Text(
              l10n.eisenhowerObserverWaiting,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ] else ...[
            // Facilitatore o Voter: possono pre-votare e facilitatore può avviare
            Row(
              children: [
                  // Pre-voto (voter e facilitatore)
                if (_canVote && !_hasCurrentUserVoted && onSubmitIndependentVote != null)
                  Expanded(
                    child: Tooltip(
                      message: l10n.eisenhowerPreVoteTooltip,
                      child: OutlinedButton.icon(
                        onPressed: onSubmitIndependentVote,
                        icon: const Icon(Icons.how_to_vote_outlined, size: 16),
                        label: Text(l10n.eisenhowerPreVote),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.success,
                          side: BorderSide(color: AppColors.success),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                // Badge "Hai pre-votato"
                if (_hasCurrentUserVoted)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 16, color: AppColors.success),
                          const SizedBox(width: 6),
                          Text(
                            l10n.eisenhowerPreVoted,
                            style: TextStyle(
                              color: AppColors.successDark,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Avvia Votazione (solo facilitatore)
                if (isFacilitator && onStartIndependentVoting != null) ...[
                  const SizedBox(width: 8),
                  Tooltip(
                    message: l10n.eisenhowerStartVotingTooltip,
                    child: ElevatedButton.icon(
                      onPressed: onStartIndependentVoting,
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label: Text(l10n.eisenhowerStartVoting),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// STATO 2: Votazione in corso - voti nascosti fino al reveal
  ///
  /// - Facilitatore: vede progresso (X/Y), NON i valori voti, può rivelare quando tutti pronti
  /// - Voter: vede solo il proprio voto, può votare se non ha ancora votato
  /// - Observer: vede solo il progresso, nessun voto
  Widget _buildVotingInProgressSection(AppLocalizations l10n) {
    final readyCount = activity.readyVoters.length;
    final allReady = _areAllVotersReady;
    final hasCurrentUserVoted = currentUserEmail != null &&
        (activity.readyVoters.contains(currentUserEmail!) ||
         activity.readyVoters.contains(EisenhowerParticipantModel.escapeEmail(currentUserEmail!)));

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con badge stato
          Row(
            children: [
              VotingStatusBadge(activity: activity, totalVoters: _totalExpectedVoters),
              const Spacer(),
              if (isFacilitator && onResetVoting != null)
                Tooltip(
                  message: l10n.eisenhowerResetVotingTooltip,
                  child: IconButton(
                    icon: const Icon(Icons.refresh, size: 18),
                    onPressed: onResetVoting,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _totalExpectedVoters > 0 ? readyCount / _totalExpectedVoters : 0.0,
              minHeight: 6,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(
                allReady ? Colors.green : Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Testo progresso (NON mostra i valori dei voti!)
          Row(
            children: [
              Text(
                l10n.eisenhowerVotedParticipants(readyCount, _totalExpectedVoters),
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
              const Spacer(),
              // Tooltip con lista chi manca
              if (!allReady)
                Tooltip(
                  message: l10n.eisenhowerWaitingForAllVotes,
                  child: Icon(Icons.info_outline, size: 14, color: Colors.grey[500]),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Bottoni azione
          if (isObserver) ...[
            // Observer: solo messaggio
            Center(
              child: Text(
                l10n.eisenhowerObserverWaitingVotes,
                style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
              ),
            ),
          ] else ...[
            Row(
              children: [
                // Bottone per votare (se l'utente non ha ancora votato)
                if (!hasCurrentUserVoted && _canVote && onSubmitIndependentVote != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onSubmitIndependentVote,
                      icon: const Icon(Icons.how_to_vote, size: 16),
                      label: Text(l10n.eisenhowerVoteSubmit),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                // Badge "Hai votato" con visualizzazione del proprio voto
                if (hasCurrentUserVoted)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, size: 16, color: Colors.green),
                              const SizedBox(width: 6),
                              Text(
                                l10n.eisenhowerVotedSuccess,
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // Mostra il voto dell'utente (solo a lui)
                          if (_currentUserVote != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              'U:${_currentUserVote!.urgency} I:${_currentUserVote!.importance}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                // Bottone Rivela (solo facilitatore, solo se TUTTI pronti)
                if (isFacilitator && onRevealVotes != null) ...[
                  const SizedBox(width: 8),
                  Tooltip(
                    message: allReady
                        ? l10n.eisenhowerRevealTooltipReady
                        : l10n.eisenhowerRevealTooltipNotReady(_totalExpectedVoters - readyCount),
                    child: ElevatedButton.icon(
                      onPressed: allReady ? onRevealVotes : null,
                      icon: const Icon(Icons.visibility, size: 16),
                      label: Text(l10n.eisenhowerRevealVotes),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allReady ? Colors.green : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'U:${activity.aggregatedUrgency.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'I:${activity.aggregatedImportance.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(String label, double value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

/// Card per attività non ancora votata (da mostrare in lista separata)
class UnvotedActivityCard extends StatelessWidget {
  final EisenhowerActivityModel activity;
  final VoidCallback? onVoteTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const UnvotedActivityCard({
    super.key,
    required this.activity,
    this.onVoteTap,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isDark ? const Color(0xFF2D3748) : null,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.help_outline,
            color: isDark ? Colors.grey[400] : Colors.grey[500],
          ),
        ),
        title: Text(
          activity.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : null,
          ),
        ),
        subtitle: activity.description.isNotEmpty
            ? Text(
                activity.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: isDark ? Colors.grey[400] : null),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pulsante voto solo se l'utente puo' votare
            if (onVoteTap != null)
              ElevatedButton.icon(
                onPressed: onVoteTap,
                icon: const Icon(Icons.how_to_vote, size: 16),
                label: Text(l10n.eisenhowerVote),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            if (onDeleteTap != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDeleteTap,
                tooltip: l10n.actionDelete,
              ),
          ],
        ),
      ),
    );
  }
}
