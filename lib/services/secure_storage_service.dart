import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'user_profile_service.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  static const _keyJiraDomain = 'jira_domain';
  static const _keyJiraEmail = 'jira_email';
  static const _keyJiraApiToken = 'jira_api_token';
  static const _keyJiraProjectId = 'jira_project_id';

  // Singleton pattern (opzionale, ma utile per accesso globale facile se non usi DI)
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  // Jira Credentials
  Future<void> saveJiraCredentials({
    required String domain,
    required String email,
    required String apiToken,
    String? projectId,
  }) async {
    // 1. Salva in locale (Secure Storage)
    await _storage.write(key: _keyJiraDomain, value: domain);
    await _storage.write(key: _keyJiraEmail, value: email);
    await _storage.write(key: _keyJiraApiToken, value: apiToken);
    if (projectId != null) {
      await _storage.write(key: _keyJiraProjectId, value: projectId);
    }

    // 2. Sincronizza su Firestore (se c'è un utente loggato)
    try {
      final userProfileService = UserProfileService();
      if (userProfileService.currentUserId != null) {
        final settings = await userProfileService.getCurrentSettings();
        if (settings != null) {
          final jiraSettings = {
            'domain': domain,
            'email': email,
            'apiToken': apiToken,
            'projectId': projectId,
          };
          
          final updatedSettings = settings.updateModuleSetting('jira', 'credentials', jiraSettings);
          await userProfileService.updateSettings(updatedSettings);
        }
      }
    } catch (e) {
      // Ignoriamo errori di sync silenziosamente, l'importante è che funzioni localmente
      print('Errore sync Jira credentials su Firestore: $e');
    }
  }

  Future<Map<String, String?>> getJiraCredentials() async {
    // 1. Prova a leggere da locale
    String? domain = await _storage.read(key: _keyJiraDomain);
    String? email = await _storage.read(key: _keyJiraEmail);
    String? apiToken = await _storage.read(key: _keyJiraApiToken);
    String? projectId = await _storage.read(key: _keyJiraProjectId);

    // 2. Se manca qualcosa in locale, prova a recuperare da Firestore (Sync)
    if (domain == null || email == null || apiToken == null) {
       try {
        final userProfileService = UserProfileService();
        if (userProfileService.currentUserId != null) {
          final settings = await userProfileService.getCurrentSettings();
          if (settings != null) {
             final jiraSettings = settings.getModuleSetting<Map<String, dynamic>>('jira', 'credentials');
             
             if (jiraSettings != null) {
               domain = jiraSettings['domain'] as String?;
               email = jiraSettings['email'] as String?;
               apiToken = jiraSettings['apiToken'] as String?;
               projectId = jiraSettings['projectId'] as String?;

               // Salva localmente per la prossima volta (Cache)
               if (domain != null) await _storage.write(key: _keyJiraDomain, value: domain);
               if (email != null) await _storage.write(key: _keyJiraEmail, value: email);
               if (apiToken != null) await _storage.write(key: _keyJiraApiToken, value: apiToken);
               if (projectId != null) await _storage.write(key: _keyJiraProjectId, value: projectId);
             }
          }
        }
       } catch (e) {
         print('Errore recupero Jira credentials da Firestore: $e');
       }
    }

    return {
      'domain': domain,
      'email': email,
      'apiToken': apiToken,
      'projectId': projectId,
    };
  }

  Future<String?> getJiraApiToken() async {
    return await _storage.read(key: _keyJiraApiToken);
  }

  Future<void> clearJiraCredentials() async {
    await _storage.delete(key: _keyJiraDomain);
    await _storage.delete(key: _keyJiraEmail);
    await _storage.delete(key: _keyJiraApiToken);
    await _storage.delete(key: _keyJiraProjectId);
  }

  // Generic helpers
  Future<void> write(String key, String value) async =>
      await _storage.write(key: key, value: value);

  Future<String?> read(String key) async => await _storage.read(key: key);

  Future<void> delete(String key) async => await _storage.delete(key: key);
}
