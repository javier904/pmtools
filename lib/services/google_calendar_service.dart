import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;
import '../models/smart_todo/todo_task_model.dart';
import 'auth_service.dart';

/// Extension to create an authenticated HTTP client from GoogleSignInAuthentication
class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;
  final http.Client _client = http.Client();

  GoogleHttpClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}

class GoogleCalendarService {
  static const String calendarScope = 'https://www.googleapis.com/auth/calendar.events';
  
  // Scopes requires incremental authorization
  Future<bool> _ensureCalendarPermissions() async {
    final googleSignIn = AuthService().googleSignIn;
    var currentUser = googleSignIn.currentUser;
    
    if (currentUser == null) {
      try {
        currentUser = await googleSignIn.signInSilently();
      } catch (_) {}
    }

    if (currentUser == null) {
      try {
        currentUser = await googleSignIn.signIn();
      } catch (e) {
        if (kDebugMode) print('❌ Login utente Google annullato o fallito: $e');
        return false;
      }
    }

    if (currentUser == null) {
      if (kDebugMode) print('❌ Nessun utente Google loggato per il Calendario.');
      return false;
    }

    try {
      final canAccess = await googleSignIn.requestScopes([calendarScope]);
      return canAccess;
    } catch (e) {
      if (kDebugMode) print('❌ Errore richiesta permessi calendar: $e');
      return false;
    }
  }

  /// Crea o aggiorna un evento in Google Calendar basato su un TodoTaskModel
  Future<String?> syncTaskToCalendar(TodoTaskModel task, String listTitle) async {
    final hasPermission = await _ensureCalendarPermissions();
    if (!hasPermission) return null;

    try {
      final googleSignIn = AuthService().googleSignIn;
      final currentUser = googleSignIn.currentUser;
      if (currentUser == null) return null;

      final authHeaders = await currentUser.authHeaders;
      final authClient = GoogleHttpClient(authHeaders);
      
      final calendarApi = calendar.CalendarApi(authClient);
      
      // Crea l'evento
      final event = calendar.Event();
      event.summary = task.title;
      event.description = '${task.description}\n\n[Synchronized from Keisen - $listTitle]';
      
      // Imposta le date e la durata
      final start = task.dueDate ?? DateTime.now();
      
      if (task.effort == null) {
        // All Day Event
        final end = start.add(const Duration(days: 1)); // End is exclusive for all-day
        // For all day events, use dateTime with UTC to avoid timezone shifts
        final startUtc = DateTime.utc(start.year, start.month, start.day);
        final endUtc = DateTime.utc(end.year, end.month, end.day);
        
        event.start = calendar.EventDateTime(date: startUtc);
        event.end = calendar.EventDateTime(date: endUtc);
      } else {
        // Orario Specifico
        final effort = task.effort!;
        final durationHours = effort < 1 ? 1 : (effort > 8 ? 8 : effort); 
        final end = start.add(Duration(hours: durationHours.toInt(), minutes: ((durationHours % 1) * 60).toInt()));

        event.start = calendar.EventDateTime(dateTime: start.toUtc());
        event.end = calendar.EventDateTime(dateTime: end.toUtc());
      }

      String? eventId = task.calendarEventId;

      if (eventId != null && eventId.isNotEmpty) {
        // Aggiorna l'evento esistente
        final updatedEvent = await calendarApi.events.update(event, 'primary', eventId);
        if (kDebugMode) print('✅ Calendario aggiornato: ${updatedEvent.htmlLink}');
        return updatedEvent.id;
      } else {
        // Crea nuovo evento
        final createdEvent = await calendarApi.events.insert(event, 'primary');
        if (kDebugMode) print('✅ Aggiunto al Calendario: ${createdEvent.htmlLink}');
        return createdEvent.id;
      }
    } catch (e) {
      if (kDebugMode) print('❌ Errore Sync Calendario: $e');
      return null;
    }
  }

  /// Elimina un evento da Google Calendar
  Future<bool> deleteEventFromCalendar(String eventId) async {
    final hasPermission = await _ensureCalendarPermissions();
    if (!hasPermission) return false;

    try {
      final googleSignIn = AuthService().googleSignIn;
      final currentUser = googleSignIn.currentUser;
      if (currentUser == null) return false;

      final authHeaders = await currentUser.authHeaders;
      final authClient = GoogleHttpClient(authHeaders);
      
      final calendarApi = calendar.CalendarApi(authClient);
      
      await calendarApi.events.delete('primary', eventId);
      if (kDebugMode) print('✅ Calendario eliminato: $eventId');
      return true;
    } catch (e) {
      if (kDebugMode) print('❌ Errore eliminazione Calendario: $e');
      return false;
    }
  }
  /// Controlla se l'evento esiste ancora su Calendar (es. se non è stato eliminato dall'utente)
  Future<bool> checkCalendarEventExists(String eventId) async {
    final hasPermission = await _ensureCalendarPermissions();
    if (!hasPermission) return false;

    try {
      final googleSignIn = AuthService().googleSignIn;
      final currentUser = googleSignIn.currentUser;
      if (currentUser == null) return false;

      final authHeaders = await currentUser.authHeaders;
      final authClient = GoogleHttpClient(authHeaders);
      
      final calendarApi = calendar.CalendarApi(authClient);
      
      final event = await calendarApi.events.get('primary', eventId);
      // If it has status cancelled, it was deleted in some Google Calendar configurations (soft delete)
      if (event.status == 'cancelled') return false; 
      
      return true;
    } on calendar.DetailedApiRequestError catch (e) {
      if (e.status == 404 || e.status == 410) {
        return false; // Non trovato o eliminato 
      }
      return false; // Assumiamo falso per precauzione
    } catch (e) {
      if (kDebugMode) print('❌ Errore check esistenza Calendario: $e');
      return true; // Se c'e' un errore di rete o altro, non disconnettiamo per errore
    }
  }
}
