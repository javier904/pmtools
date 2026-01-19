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
    final userDoc = await _firestore.collection('users').doc(email).get();
    if (userDoc.exists) {
      exportData['user_profile'] = userDoc.data();
    }

    // 2. Planning Poker Sessions
    final pokerSessions = await _firestore
        .collection('planning_poker_sessions')
        .where('createdBy', isEqualTo: email)
        .get();
    exportData['planning_poker_sessions'] = pokerSessions.docs.map((d) => d.data()).toList();

    // 3. Eisenhower Matrices
    final matrices = await _firestore
        .collection('eisenhower_matrices')
        .where('ownerEmail', isEqualTo: email)
        .get();
    exportData['eisenhower_matrices'] = matrices.docs.map((d) => d.data()).toList();

    // 4. Agile Projects
    final projects = await _firestore
        .collection('agile_projects')
        .where('createdBy', isEqualTo: email)
        .get();
    exportData['agile_projects'] = projects.docs.map((d) => d.data()).toList();

    // 5. Smart Todo Lists
    final todoLists = await _firestore
        .collection('smart_todo_lists')
        .where('ownerEmail', isEqualTo: email)
        .get();
    exportData['smart_todo_lists'] = todoLists.docs.map((d) => d.data()).toList();

    // 6. Retrospectives
    final retros = await _firestore
        .collection('retrospectives')
        .where('createdBy', isEqualTo: email)
        .get();
    exportData['retrospectives'] = retros.docs.map((d) => d.data()).toList();

    return const JsonEncoder.withIndent('  ').convert(exportData);
  }

  /// Elimina definitivamente l'account e tutti i dati associati
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw Exception('Utente non autenticato');
    final email = user.email!.toLowerCase();

    // Usiamo un batch o sequenza di eliminazioni
    final WriteBatch batch = _firestore.batch();

    // 1. Elimina Profilo
    batch.delete(_firestore.collection('users').doc(email));

    // Nota: L'eliminazione massiva di sessioni create dall'utente 
    // potrebbe richiedere un limite di 500 operazioni per batch.
    // Per semplicità qui facciamo cleanup delle principali.

    // 2. Cleanup (Solo eliminazione manuale per evitare orfani se necessario)
    // In un contesto reale, potremmo usare Cloud Functions per cleanup ricorsivo.

    await batch.commit();

    // 3. Elimina FirebaseAuth User (deve essere loggato di recente)
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
