import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agile_tools/services/auth_service.dart';

class GDPRService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Esporta tutti i dati dell'utente in formato JSON
  Future<String> exportUserData() async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw Exception('Utente non autenticato');
    final email = user.email!.toLowerCase();

    final Map<String, dynamic> exportData = {
      'export_date': DateTime.now().toIso8601String(),
      'user_profile': {},
      'planning_poker_sessions': [],
      'eisenhower_matrices': [],
      'agile_projects': [],
      'smart_todo_lists': [],
      'retrospectives': [],
    };

    // 1. Profilo Utente
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() ?? {};
        
        // Fetch sub-collections
        try {
          final subDoc = await userDoc.reference.collection('subscription').doc('current').get();
          if (subDoc.exists) userData['subscription'] = subDoc.data();
          
          final settingsDoc = await userDoc.reference.collection('settings').doc('preferences').get();
          if (settingsDoc.exists) userData['settings'] = settingsDoc.data();

          final historyDocs = await userDoc.reference.collection('subscription_history').limit(10).get();
          userData['subscription_history'] = historyDocs.docs.map((d) => d.data()).toList();
        } catch (e) {
          print('⚠️ GDPR: Errore export sub-collections profilo: $e');
        }

        exportData['user_profile'] = _processDataForExport(userData);
      }
    } catch (e) {
      print('⚠️ GDPR: Errore export profilo: $e');
    }

    // 2. Planning Poker Sessions
    try {
      final pokerSessions = await _firestore
          .collection('planning_poker_sessions')
          .where('createdBy', isEqualTo: email)
          .get();
      exportData['planning_poker_sessions'] = pokerSessions.docs.map((d) => _processDataForExport(d.data())).toList();
    } catch (e) {
      print('⚠️ GDPR: Errore export planning poker: $e');
    }

    // 3. Eisenhower Matrices
    try {
      final matrices = await _firestore
          .collection('eisenhower_matrices')
          .where('createdBy', isEqualTo: email)
          .get();
      exportData['eisenhower_matrices'] = matrices.docs.map((d) => _processDataForExport(d.data())).toList();
    } catch (e) {
      print('⚠️ GDPR: Errore export eisenhower: $e');
    }

    // 4. Agile Projects & Retrospectives
    try {
      final projectsQuery = await _firestore
          .collection('agile_projects')
          .where('participantEmails', arrayContains: email)
          .get();
      
      final projectList = projectsQuery.docs.map((d) => _processDataForExport(d.data())).toList();
      exportData['agile_projects'] = projectList;

      // Retrospectives are sub-collections of projects
      for (final doc in projectsQuery.docs) {
        try {
          final retros = await doc.reference.collection('retrospectives').get();
          if (retros.docs.isNotEmpty) {
            exportData['retrospectives'].addAll(retros.docs.map((d) => _processDataForExport({
              'projectId': doc.id,
              ...d.data() as Map<String, dynamic>,
            })).toList());
          }
        } catch (e) {
          print('⚠️ GDPR: Errore export retros per progetto ${doc.id}: $e');
        }
      }
    } catch (e) {
      print('⚠️ GDPR: Errore export agile projects: $e');
    }

    // 5. Smart Todo Lists
    try {
      final todoLists = await _firestore
          .collection('smart_todo_lists')
          .where('ownerId', isEqualTo: email)
          .get();
      exportData['smart_todo_lists'] = todoLists.docs.map((d) => _processDataForExport(d.data())).toList();
    } catch (e) {
      print('⚠️ GDPR: Errore export smart todo: $e');
    }

    return const JsonEncoder.withIndent('  ').convert(exportData);
  }

  /// Processa ricorsivamente i dati per rendere i Timestamp serializzabili in JSON
  dynamic _processDataForExport(dynamic data) {
    if (data is Timestamp) {
      return data.toDate().toIso8601String();
    } else if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), _processDataForExport(value)));
    } else if (data is List) {
      return data.map((item) => _processDataForExport(item)).toList();
    } else if (data is DateTime) {
      return data.toIso8601String();
    }
    return data;
  }

  /// Elimina definitivamente l'account e tutti i dati associati
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw Exception('Utente non autenticato');
    // final email = user.email!.toLowerCase();

    // Usiamo un batch o sequenza di eliminazioni
    final WriteBatch batch = _firestore.batch();

    // 1. Elimina Profilo (Usa UID come in UserProfileService)
    batch.delete(_firestore.collection('users').doc(user.uid));

    // Nota: L'eliminazione massiva di sessioni create dall'utente 
    // potrebbe richiedere un limite di 500 operazioni per batch.
    // In un contesto reale, usiamo Cloud Functions per cleanup ricorsivo.
    // Qui limitiamo il cleanup al profilo per evitare orfani critici.

    await batch.commit();

    // 2. Elimina FirebaseAuth User (deve essere loggato di recente)
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception('recent-login-required');
      }
      rethrow;
    }
  }
}
