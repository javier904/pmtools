import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'secure_storage_service.dart';

class JiraService {
  final SecureStorageService _storage = SecureStorageService();

  // Singleton pattern
  static final JiraService _instance = JiraService._internal();
  factory JiraService() => _instance;
  JiraService._internal();

  /// Helper per ottenere gli headers di autenticazione (Basic Auth)
  Future<Map<String, String>> _getHeaders() async {
    final creds = await _storage.getJiraCredentials();
    final email = creds['email'];
    final token = creds['apiToken'];

    if (email == null || token == null || email.isEmpty || token.isEmpty) {
      throw JiraException('Jira credentials not found. Please configure them in Settings.');
    }

    final basicAuth = 'Basic ${base64Encode(utf8.encode('$email:$token'))}';
    return {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Helper per ottenere il dominio base
  Future<Uri> _getUri(String path, {Map<String, dynamic>? queryParameters}) async {
    final creds = await _storage.getJiraCredentials();
    String? domain = creds['domain'];

    if (domain == null || domain.isEmpty) {
      throw JiraException('Jira domain not configured.');
    }

    // Rimuove eventuale protocollo se presente erroneamente
    if (domain.startsWith('https://')) domain = domain.replaceFirst('https://', '');
    if (domain.startsWith('http://')) domain = domain.replaceFirst('http://', '');
    if (domain.endsWith('/')) domain = domain.substring(0, domain.length - 1);

    return Uri.https(domain, '/rest/api/3/$path', queryParameters);
  }

  /// Verifica la connessione ottenendo i dettagli dell'utente corrente
  Future<Map<String, dynamic>> getCurrentUser() async {
    if (kIsWeb) {
      final result = await _callFunction('verifyJiraLogin', {});
      return Map<String, dynamic>.from(result as Map);
    }

    try {
      final uri = await _getUri('myself');
      final headers = await _getHeaders();

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw JiraException('Connection failed. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }

  /// Ottiene i dettagli di una issue
  Future<Map<String, dynamic>> getIssue(String issueKey) async {
    if (kIsWeb) {
      final result = await _callFunction('jiraGetIssue', {'issueKey': issueKey});
      return Map<String, dynamic>.from(result as Map);
    }

    try {
      final uri = await _getUri('issue/$issueKey');
      final headers = await _getHeaders();

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw JiraException('Failed to load issue. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }

  /// Cerca issue tramite JQL
  Future<List<Map<String, dynamic>>> searchIssues(String jql, {int startAt = 0, int maxResults = 50}) async {
    if (kIsWeb) {
      final result = await _callFunction('jiraSearchIssues', {
        'jql': jql,
        'startAt': startAt,
        'maxResults': maxResults,
      });
      return List<Map<String, dynamic>>.from(result['issues'] ?? []);
    }

    try {
      final uri = await _getUri('search', queryParameters: {
        'jql': jql,
        'startAt': startAt.toString(),
        'maxResults': maxResults.toString(),
        'fields': 'summary,status,issuetype,priority,assignee,description,updated',
      });
      final headers = await _getHeaders();

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['issues']);
      } else {
        throw JiraException('Search failed. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }

  /// Ottiene le transizioni disponibili per una issue
  Future<List<Map<String, dynamic>>> getTransitions(String issueKey) async {
    if (kIsWeb) {
      final result = await _callFunction('jiraGetTransitions', {'issueKey': issueKey});
      return List<Map<String, dynamic>>.from(result['transitions'] ?? []);
    }

    try {
      final uri = await _getUri('issue/$issueKey/transitions', queryParameters: {
        'expand': 'transitions.fields',
      });
      final headers = await _getHeaders();

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['transitions']);
      } else {
        throw JiraException('Failed to get transitions. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }

  /// Esegue una transizione di stato
  Future<void> postTransition(String issueKey, String transitionId, {Map<String, dynamic>? fields}) async {
    if (kIsWeb) {
      await _callFunction('jiraUpdateStatus', {
        'issueKey': issueKey,
        'transitionId': transitionId,
        // Cloud Function doesn't support generic fields in updateStatus usually, check suite
        // The suite has jiraUpdateStatus taking issueKey, transitionId
        // If request has fields, strictly speaking current suite impl might ignore them or we need jiraUpdateIssue
        // But transition payload in suite is: { transition: { id: transitionId } }
        // If user needs fields during transition (screens), we might need to update suite
        // For now, simply calling status update
      });
      return;
    }

    try {
      final uri = await _getUri('issue/$issueKey/transitions');
      final headers = await _getHeaders();
      
      final Map<String, dynamic> data = {
        'transition': {'id': transitionId}
      };
      
      if (fields != null && fields.isNotEmpty) {
        data['fields'] = fields;
      }

      final body = jsonEncode(data);

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode != 204) {
        throw JiraException('Failed to transition issue. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }

  /// Aggiunge un commento
  Future<void> addComment(String issueKey, String body) async {
    if (kIsWeb) {
      await _callFunction('jiraAddComment', {
        'issueKey': issueKey,
        'body': body,
      });
      return;
    }

    try {
      final uri = await _getUri('issue/$issueKey/comment');
      final headers = await _getHeaders();
      // Jira Document Format (ADF) semplificato
      final adfBody = jsonEncode({
        'body': {
          'version': 1,
          'type': 'doc',
          'content': [
            {
              'type': 'paragraph',
              'content': [
                {'type': 'text', 'text': body}
              ]
            }
          ]
        }
      });

      final response = await http.post(uri, headers: headers, body: adfBody);

      if (response.statusCode != 201) {
        throw JiraException('Failed to add comment. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
      throw JiraException('Network error: $e');
    }
  }


  /// Aggiunge un worklog (tempo speso)
  ///
  /// [timeSpent] può essere int (secondi) o String (es. "1h 30m")
  Future<void> addWorklog(String issueKey, dynamic timeSpent, {String? comment, DateTime? date}) async {
    if (kIsWeb) {
      final seconds = timeSpent is int 
          ? timeSpent 
          : _parseDurationToSeconds(timeSpent.toString());

      await _callFunction('jiraLogWork', {
        'issueKey': issueKey,
        'timeSpentSeconds': seconds,
        'comment': comment,
        'started': date != null ? _formatDateForJira(date) : null,
      });
      return;
    }

    try {
      final uri = await _getUri('issue/$issueKey/worklog');
      final headers = await _getHeaders();
      
      final Map<String, dynamic> data = {};
      
      if (timeSpent is int) {
        data['timeSpentSeconds'] = timeSpent;
      } else {
        data['timeSpent'] = timeSpent.toString();
      }

      if (date != null) {
        data['started'] = _formatDateForJira(date);
      }

      if (comment != null && comment.isNotEmpty) {
          data['comment'] = {
            'version': 1,
            'type': 'doc',
            'content': [
              {
                'type': 'paragraph',
                'content': [
                  {'type': 'text', 'text': comment}
                ]
              }
            ]
          };
      }

      final body = jsonEncode(data);
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode != 201) {
        throw JiraException('Failed to add worklog. Status: ${response.statusCode}', response.body);
      }
    } catch (e) {
      if (e is JiraException) rethrow;
       throw JiraException('Network error: $e');
    }
  }

  /// Converte una stringa stile Jira (es. "1d 2h 30m") in secondi.
  /// Assume: 1w = 5d, 1d = 8h (Standard Jira)
  int _parseDurationToSeconds(String duration) {
    if (duration.trim().isEmpty) return 0;
    
    // Check if it's already just a number
    if (int.tryParse(duration) != null) return int.parse(duration);

    int totalSeconds = 0;
    
    // Regex per trovare coppie numero-unità (es. 1d, 30m)
    final regex = RegExp(r'(\d+)([wdhm])');
    final matches = regex.allMatches(duration.toLowerCase());

    for (final match in matches) {
      final value = int.parse(match.group(1)!);
      final unit = match.group(2);

      switch (unit) {
        case 'w': // week = 5 days = 40 hours
          totalSeconds += value * 5 * 8 * 3600;
          break;
        case 'd': // day = 8 hours
          totalSeconds += value * 8 * 3600;
          break;
        case 'h': // hour
          totalSeconds += value * 3600;
          break;
        case 'm': // minute
          totalSeconds += value * 60;
          break;
      }
    }

    return totalSeconds;
  }

  /// Formatta la data per Jira: yyyy-MM-dd'T'HH:mm:ss.SSSZ
  String _formatDateForJira(DateTime date) {
    final utc = date.toUtc();
    final y = utc.year.toString().padLeft(4, '0');
    final m = utc.month.toString().padLeft(2, '0');
    final d = utc.day.toString().padLeft(2, '0');
    final h = utc.hour.toString().padLeft(2, '0');
    final min = utc.minute.toString().padLeft(2, '0');
    final s = utc.second.toString().padLeft(2, '0');
    final ms = utc.millisecond.toString().padLeft(3, '0');
    
    // Jira expects: "2021-01-01T12:00:00.000+0000"
    // 'Z' literal is sometimes rejected if strict RFC822 is enforced by parser.
    return '$y-$m-${d}T$h:$min:$s.${ms}+0000';
  }

  // --- Helper for Cloud Functions ---

  Future<dynamic> _callFunction(String name, Map<String, dynamic> params) async {
    final creds = await _storage.getJiraCredentials();
    final domain = creds['domain'];
    final email = creds['email'];
    final apiToken = creds['apiToken'];

    if (domain == null || email == null || apiToken == null) {
      throw JiraException('Credenziali Jira mancanti.');
    }

    try {
      final callable = FirebaseFunctions.instance.httpsCallable(name);
      
      final response = await callable.call({
        ...params,
        'domain': domain,
        'email': email,
        'apiToken': apiToken,
      });

      return response.data;
    } on FirebaseFunctionsException catch (e) {
      throw JiraException('Cloud Function Error (${e.code}): ${e.message}');
    } catch (e) {
      throw JiraException('Errore sconosciuto Cloud Function: $e');
    }
  }
}

class JiraException implements Exception {
  final String message;
  final String? responseBody;

  JiraException(this.message, [this.responseBody]);

  @override
  String toString() => 'JiraException: $message ${responseBody != null ? '\nResponse: $responseBody' : ''}';
}
