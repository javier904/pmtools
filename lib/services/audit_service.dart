import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuditAction {
  create,
  update,
  delete,
  export,
  auth,
  invite,
}

class AuditService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static final AuditService _instance = AuditService._internal();
  factory AuditService() => _instance;
  AuditService._internal();

  /// Logga un'azione nel sistema di audit
  Future<void> logAction({
    required String component,
    required AuditAction action,
    required String details,
    String? resourceId,
    Map<String, dynamic>? extraData,
  }) async {
    final user = _auth.currentUser;
    final email = user?.email?.toLowerCase() ?? 'anonymous';

    try {
      await _firestore.collection('audit_logs').add({
        'timestamp': FieldValue.serverTimestamp(),
        'user_email': email,
        'component': component,
        'action': action.name,
        'details': details,
        'resource_id': resourceId,
        'extra_data': extraData,
      });
    } catch (e) {
      // In produzione non vogliamo bloccare l'app se il log fallisce
      // ma potremmo volerlo stampare in console in dev
      print('Audit logging failed: $e');
    }
  }
}
