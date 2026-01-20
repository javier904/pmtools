import 'package:cloud_firestore/cloud_firestore.dart';

/// Modello impostazioni utente - Modulare e riutilizzabile
///
/// Gestisce:
/// - Preferenze UI (tema, lingua, notifiche)
/// - Feature flags per abilitare/disabilitare funzionalità
/// - Impostazioni per modulo specifico (Agile, Eisenhower, etc.)
class UserSettingsModel {
  final String userId;

  // Preferenze UI generali
  final ThemePreference themeMode;
  final String locale; // it, en, etc.
  final bool enableAnimations;

  // Cookie consent (true = accepted all, false = necessary only, null = not yet decided)
  final bool? cookieConsent;

  // Notifiche
  final NotificationSettings notifications;

  // Feature flags - abilitazione funzionalità
  final FeatureFlags featureFlags;

  // Impostazioni specifiche per modulo
  final Map<String, dynamic> moduleSettings;

  // Metadata
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserSettingsModel({
    required this.userId,
    this.themeMode = ThemePreference.system,
    this.locale = '',  // Empty = use app's locale (SharedPreferences)
    this.enableAnimations = true,
    this.cookieConsent,
    this.notifications = const NotificationSettings(),
    this.featureFlags = const FeatureFlags(),
    this.moduleSettings = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  /// Crea impostazioni di default per un nuovo utente
  factory UserSettingsModel.defaultSettings(String userId) {
    final now = DateTime.now();
    return UserSettingsModel(
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SERIALIZATION
  // ═══════════════════════════════════════════════════════════════════════════

  Map<String, dynamic> toFirestore() {
    return {
      'themeMode': themeMode.name,
      'locale': locale,
      'enableAnimations': enableAnimations,
      'cookieConsent': cookieConsent,
      'notifications': notifications.toMap(),
      'featureFlags': featureFlags.toMap(),
      'moduleSettings': moduleSettings,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory UserSettingsModel.fromFirestore(String odIndex, Map<String, dynamic> data) {
    return UserSettingsModel(
      userId: odIndex,
      themeMode: ThemePreference.values.firstWhere(
        (t) => t.name == data['themeMode'],
        orElse: () => ThemePreference.system,
      ),
      locale: data['locale'] ?? '',  // Empty = use app's locale (SharedPreferences)
      enableAnimations: data['enableAnimations'] ?? true,
      cookieConsent: data['cookieConsent'],
      notifications: NotificationSettings.fromMap(
        data['notifications'] as Map<String, dynamic>? ?? {},
      ),
      featureFlags: FeatureFlags.fromMap(
        data['featureFlags'] as Map<String, dynamic>? ?? {},
      ),
      moduleSettings: Map<String, dynamic>.from(data['moduleSettings'] ?? {}),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  UserSettingsModel copyWith({
    ThemePreference? themeMode,
    String? locale,
    bool? enableAnimations,
    bool? cookieConsent,
    NotificationSettings? notifications,
    FeatureFlags? featureFlags,
    Map<String, dynamic>? moduleSettings,
    DateTime? updatedAt,
  }) {
    return UserSettingsModel(
      userId: userId,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      enableAnimations: enableAnimations ?? this.enableAnimations,
      cookieConsent: cookieConsent ?? this.cookieConsent,
      notifications: notifications ?? this.notifications,
      featureFlags: featureFlags ?? this.featureFlags,
      moduleSettings: moduleSettings ?? this.moduleSettings,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  /// Aggiorna un'impostazione specifica di un modulo
  UserSettingsModel updateModuleSetting(String moduleKey, String settingKey, dynamic value) {
    final newModuleSettings = Map<String, dynamic>.from(moduleSettings);
    if (!newModuleSettings.containsKey(moduleKey)) {
      newModuleSettings[moduleKey] = <String, dynamic>{};
    }
    (newModuleSettings[moduleKey] as Map<String, dynamic>)[settingKey] = value;
    return copyWith(moduleSettings: newModuleSettings);
  }

  /// Ottiene un'impostazione specifica di un modulo
  T? getModuleSetting<T>(String moduleKey, String settingKey, {T? defaultValue}) {
    final module = moduleSettings[moduleKey] as Map<String, dynamic>?;
    if (module == null) return defaultValue;
    return module[settingKey] as T? ?? defaultValue;
  }
}

/// Preferenza tema
enum ThemePreference {
  light,
  dark,
  system;

  String get displayName {
    switch (this) {
      case ThemePreference.light:
        return 'Chiaro';
      case ThemePreference.dark:
        return 'Scuro';
      case ThemePreference.system:
        return 'Sistema';
    }
  }

  String get icon {
    switch (this) {
      case ThemePreference.light:
        return '☀️';
      case ThemePreference.dark:
        return '🌙';
      case ThemePreference.system:
        return '⚙️';
    }
  }
}

/// Impostazioni notifiche
class NotificationSettings {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool sprintReminders;
  final bool sessionInvites;
  final bool weeklyDigest;
  final bool marketingEmails;

  const NotificationSettings({
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.sprintReminders = true,
    this.sessionInvites = true,
    this.weeklyDigest = false,
    this.marketingEmails = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'sprintReminders': sprintReminders,
      'sessionInvites': sessionInvites,
      'weeklyDigest': weeklyDigest,
      'marketingEmails': marketingEmails,
    };
  }

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      emailNotifications: map['emailNotifications'] ?? true,
      pushNotifications: map['pushNotifications'] ?? true,
      sprintReminders: map['sprintReminders'] ?? true,
      sessionInvites: map['sessionInvites'] ?? true,
      weeklyDigest: map['weeklyDigest'] ?? false,
      marketingEmails: map['marketingEmails'] ?? false,
    );
  }

  NotificationSettings copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? sprintReminders,
    bool? sessionInvites,
    bool? weeklyDigest,
    bool? marketingEmails,
  }) {
    return NotificationSettings(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      sprintReminders: sprintReminders ?? this.sprintReminders,
      sessionInvites: sessionInvites ?? this.sessionInvites,
      weeklyDigest: weeklyDigest ?? this.weeklyDigest,
      marketingEmails: marketingEmails ?? this.marketingEmails,
    );
  }
}

/// Feature flags per abilitare/disabilitare funzionalità
class FeatureFlags {
  // Integrazioni
  final bool calendarIntegration;
  final bool googleSheetsExport;
  final bool slackIntegration;

  // Funzionalità beta
  final bool betaFeatures;
  final bool advancedMetrics;
  final bool aiSuggestions;

  // Moduli specifici
  final bool agileModule;
  final bool eisenhowerModule;
  final bool estimationModule;

  const FeatureFlags({
    this.calendarIntegration = false,
    this.googleSheetsExport = true,
    this.slackIntegration = false,
    this.betaFeatures = false,
    this.advancedMetrics = false,
    this.aiSuggestions = false,
    this.agileModule = true,
    this.eisenhowerModule = true,
    this.estimationModule = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'calendarIntegration': calendarIntegration,
      'googleSheetsExport': googleSheetsExport,
      'slackIntegration': slackIntegration,
      'betaFeatures': betaFeatures,
      'advancedMetrics': advancedMetrics,
      'aiSuggestions': aiSuggestions,
      'agileModule': agileModule,
      'eisenhowerModule': eisenhowerModule,
      'estimationModule': estimationModule,
    };
  }

  factory FeatureFlags.fromMap(Map<String, dynamic> map) {
    return FeatureFlags(
      calendarIntegration: map['calendarIntegration'] ?? false,
      googleSheetsExport: map['googleSheetsExport'] ?? true,
      slackIntegration: map['slackIntegration'] ?? false,
      betaFeatures: map['betaFeatures'] ?? false,
      advancedMetrics: map['advancedMetrics'] ?? false,
      aiSuggestions: map['aiSuggestions'] ?? false,
      agileModule: map['agileModule'] ?? true,
      eisenhowerModule: map['eisenhowerModule'] ?? true,
      estimationModule: map['estimationModule'] ?? true,
    );
  }

  FeatureFlags copyWith({
    bool? calendarIntegration,
    bool? googleSheetsExport,
    bool? slackIntegration,
    bool? betaFeatures,
    bool? advancedMetrics,
    bool? aiSuggestions,
    bool? agileModule,
    bool? eisenhowerModule,
    bool? estimationModule,
  }) {
    return FeatureFlags(
      calendarIntegration: calendarIntegration ?? this.calendarIntegration,
      googleSheetsExport: googleSheetsExport ?? this.googleSheetsExport,
      slackIntegration: slackIntegration ?? this.slackIntegration,
      betaFeatures: betaFeatures ?? this.betaFeatures,
      advancedMetrics: advancedMetrics ?? this.advancedMetrics,
      aiSuggestions: aiSuggestions ?? this.aiSuggestions,
      agileModule: agileModule ?? this.agileModule,
      eisenhowerModule: eisenhowerModule ?? this.eisenhowerModule,
      estimationModule: estimationModule ?? this.estimationModule,
    );
  }

  /// Verifica se una feature è abilitata
  bool isEnabled(String featureName) {
    final map = toMap();
    return map[featureName] ?? false;
  }
}
