import 'package:cloud_firestore/cloud_firestore.dart';

/// Configurazione per il sistema di presenza di un tool specifico.
///
/// Definisce i path Firestore dove scrivere i dati di heartbeat.
/// Ogni tool ha il proprio [PresenceConfig] per mantenere la
/// compatibilità con i dati Firestore esistenti.
class PresenceConfig {
  /// Collection Firestore (es. 'retrospectives', 'eisenhower_matrices', 'planning_poker_sessions')
  final String collection;

  /// ID del documento (es. retroId, matrixId, sessionId)
  final String documentId;

  /// Prefisso del campo presenza nel documento.
  /// Es. 'participantPresence' per Retro, 'participants' per Eisenhower/Estimation.
  final String presenceFieldPrefix;

  const PresenceConfig({
    required this.collection,
    required this.documentId,
    required this.presenceFieldPrefix,
  });
}

/// Servizio centralizzato per la gestione della presenza online.
///
/// Gestisce le scritture Firestore per segnalare la presenza/assenza
/// degli utenti in sessioni collaborative. Supporta configurazioni
/// diverse per ogni tool mantenendo la backward-compatibility.
class PresenceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Costanti del sistema di presenza
  static const int heartbeatIntervalSeconds = 15;
  static const int offlineThresholdSeconds = 45;
  static const Duration heartbeatInterval = Duration(seconds: heartbeatIntervalSeconds);
  static const Duration offlineThreshold = Duration(seconds: offlineThresholdSeconds);

  /// Escapa l'email per uso come chiave Firestore (`.` → `_DOT_`)
  static String escapeEmail(String email) => email.toLowerCase().trim().replaceAll('.', '_DOT_');

  /// Invia un heartbeat per segnalare che l'utente è online.
  ///
  /// Scrive `isOnline: true` e `lastActivity: serverTimestamp` al path
  /// configurato. Usa `FieldValue.serverTimestamp()` per coerenza cross-client.
  ///
  /// Non lancia eccezioni — un heartbeat fallito non deve bloccare l'app.
  Future<void> sendHeartbeat(PresenceConfig config, String userEmail) async {
    try {
      final escapedEmail = escapeEmail(userEmail);
      await _firestore.collection(config.collection).doc(config.documentId).update({
        '${config.presenceFieldPrefix}.$escapedEmail.isOnline': true,
        '${config.presenceFieldPrefix}.$escapedEmail.lastActivity': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Non rilanciare — heartbeat fallito non deve bloccare l'app
      print('⚠️ [Presence] Heartbeat failed for $userEmail: $e');
    }
  }

  /// Segna l'utente come offline.
  ///
  /// Scrive solo `isOnline: false`, lasciando `lastActivity` invariato
  /// per permettere la verifica tramite threshold.
  ///
  /// Non lancia eccezioni — può fallire se il documento non esiste più.
  Future<void> markOffline(PresenceConfig config, String userEmail) async {
    try {
      final escapedEmail = escapeEmail(userEmail);
      await _firestore.collection(config.collection).doc(config.documentId).update({
        '${config.presenceFieldPrefix}.$escapedEmail.isOnline': false,
      });
    } catch (e) {
      // Non rilanciare — può fallire se il doc non esiste più
      print('⚠️ [Presence] Mark offline failed for $userEmail: $e');
    }
  }

  /// Verifica se un partecipante è effettivamente online.
  ///
  /// Considera il threshold di [offlineThresholdSeconds] secondi:
  /// se l'ultimo heartbeat è più vecchio del threshold, l'utente
  /// è considerato offline indipendentemente dal flag `isOnline`.
  static bool isEffectivelyOnline({
    required bool isOnlineFlag,
    required DateTime? lastActivity,
  }) {
    if (!isOnlineFlag) return false;
    if (lastActivity == null) return isOnlineFlag;
    return DateTime.now().difference(lastActivity).inSeconds < offlineThresholdSeconds;
  }
}
