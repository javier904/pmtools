import 'package:flutter/foundation.dart';

/// Logger centralizzato per l'applicazione Agile Tools.
///
/// In production mode (kReleaseMode), i log debug/info sono disabilitati.
/// Solo warning e errori vengono sempre loggati.
///
/// Uso:
/// ```dart
/// AppLogger.debug('Sessione creata', 'PlanningPoker');
/// AppLogger.info('Utente loggato');
/// AppLogger.warning('Token scaduto');
/// AppLogger.error('Errore salvataggio', error, stackTrace);
/// ```
class AppLogger {
  static const String _tag = 'AgileTools';

  /// Log per debug (solo in development mode)
  ///
  /// [message] Messaggio da loggare
  /// [tag] Tag opzionale per identificare il modulo (es. 'Auth', 'Firestore')
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$_tag:$tag]' : '[$_tag]';
      debugPrint('$prefix $message');
    }
  }

  /// Log informativo (solo in development mode)
  ///
  /// [message] Messaggio da loggare
  /// [tag] Tag opzionale per identificare il modulo
  static void info(String message, [String? tag]) {
    if (kDebugMode) {
      final prefix = tag != null ? '[INFO:$_tag:$tag]' : '[INFO:$_tag]';
      debugPrint('$prefix $message');
    }
  }

  /// Log warning (sempre attivo, anche in production)
  ///
  /// [message] Messaggio da loggare
  /// [tag] Tag opzionale per identificare il modulo
  static void warning(String message, [String? tag]) {
    final prefix = tag != null ? '[WARN:$_tag:$tag]' : '[WARN:$_tag]';
    debugPrint('$prefix $message');
  }

  /// Log errore (sempre attivo)
  ///
  /// In production, gli errori verranno inviati a Firebase Crashlytics
  /// (quando configurato).
  ///
  /// [message] Descrizione dell'errore
  /// [error] Oggetto errore (opzionale)
  /// [stackTrace] Stack trace (opzionale)
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[ERROR:$_tag] $message');
    if (error != null) {
      debugPrint('Error: $error');
    }
    if (stackTrace != null && kDebugMode) {
      debugPrint('Stack: $stackTrace');
    }

    // TODO: In production, inviare a Firebase Crashlytics
    // if (!kDebugMode && error != null) {
    //   FirebaseCrashlytics.instance.recordError(
    //     error,
    //     stackTrace ?? StackTrace.current,
    //     reason: message,
    //   );
    // }
  }

  /// Log per operazioni Firestore (solo in development)
  static void firestore(String operation, String collection, [String? docId]) {
    if (kDebugMode) {
      final docInfo = docId != null ? '/$docId' : '';
      debugPrint('[$_tag:Firestore] $operation $collection$docInfo');
    }
  }

  /// Log per operazioni di autenticazione (solo in development)
  static void auth(String message) {
    debug(message, 'Auth');
  }

  /// Log per operazioni di navigazione (solo in development)
  static void navigation(String route) {
    debug('Navigating to $route', 'Navigation');
  }

  /// Log per operazioni di rete (solo in development)
  static void network(String message, [int? statusCode]) {
    if (kDebugMode) {
      final status = statusCode != null ? ' (Status: $statusCode)' : '';
      debugPrint('[$_tag:Network] $message$status');
    }
  }
}
