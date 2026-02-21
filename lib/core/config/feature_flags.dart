// lib/core/config/feature_flags.dart

/// Classe per la gestione globale dei Feature Flags.
/// Permette di attivare o disattivare selettivamente funzionalità
/// in via di sviluppo (Stealth Mode) per evitare problemi burocratici
/// o regressioni in produzione.
class FeatureFlags {
  /// Abilita la vista del Calendario Interno e l'integrazione con Google Calendar.
  /// 
  /// MANTENERE `false` in produzione finché l'app non è verificata da Google.
  /// Impostare a `true` in locale per sviluppare e testare.
  static const bool enableCalendarSync = true;
}
