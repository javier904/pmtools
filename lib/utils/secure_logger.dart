import 'package:flutter/foundation.dart';

/// Logger sicuro che stampa solo in debug mode.
///
/// Uso:
/// ```dart
/// SecureLogger.debug('Messaggio debug');
/// SecureLogger.info('Info');
/// SecureLogger.warning('Warning');
/// SecureLogger.error('Errore', error: e);
/// ```
class SecureLogger {
  SecureLogger._();

  /// Log di debug - solo in debug mode
  static void debug(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      print('$prefix$message');
    }
  }

  /// Log informativo - solo in debug mode
  static void info(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '[$tag] ' : '';
      print('$prefix$message');
    }
  }

  /// Log di warning - solo in debug mode
  static void warning(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '⚠️ [$tag] ' : '⚠️ ';
      print('$prefix$message');
    }
  }

  /// Log di errore - sempre stampato (utile per crash reporting)
  static void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    final prefix = tag != null ? '❌ [$tag] ' : '❌ ';
    print('$prefix$message');
    if (error != null && kDebugMode) {
      print('Error: $error');
    }
    if (stackTrace != null && kDebugMode) {
      print('StackTrace: $stackTrace');
    }
  }

  /// Log per email/dati personali - MAI in produzione
  static void sensitive(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '🔒 [$tag] ' : '🔒 ';
      print('$prefix$message');
    }
  }

  /// Log per operazioni OAuth/Token - MAI in produzione
  static void auth(String message, {String? tag}) {
    if (kDebugMode) {
      final prefix = tag != null ? '🔐 [$tag] ' : '🔐 ';
      print('$prefix$message');
    }
  }
}
