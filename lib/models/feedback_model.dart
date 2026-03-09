import 'package:cloud_firestore/cloud_firestore.dart';

enum FeedbackType {
  bug,
  feature,
}

extension FeedbackTypeExtension on FeedbackType {
  String get name {
    switch (this) {
      case FeedbackType.bug:
        return 'bug';
      case FeedbackType.feature:
        return 'feature';
    }
  }

  static FeedbackType fromString(String str) {
    if (str == 'feature') return FeedbackType.feature;
    return FeedbackType.bug;
  }
}

enum FeedbackStatus {
  newRequest,
  inProgress,
  resolved,
  closed,
}

extension FeedbackStatusExtension on FeedbackStatus {
  String get name {
    switch (this) {
      case FeedbackStatus.newRequest:
        return 'new';
      case FeedbackStatus.inProgress:
        return 'in_progress';
      case FeedbackStatus.resolved:
        return 'resolved';
      case FeedbackStatus.closed:
        return 'closed';
    }
  }

  static FeedbackStatus fromString(String str) {
    if (str == 'in_progress') return FeedbackStatus.inProgress;
    if (str == 'resolved') return FeedbackStatus.resolved;
    if (str == 'closed') return FeedbackStatus.closed;
    return FeedbackStatus.newRequest; // default
  }
}

class FeedbackModel {
  final String id;
  final FeedbackType type;
  final String subject;
  final String description;
  final String userEmail;
  final DateTime createdAt;
  final FeedbackStatus status;
  final bool consentGiven;

  FeedbackModel({
    required this.id,
    required this.type,
    required this.subject,
    required this.description,
    required this.userEmail,
    required this.createdAt,
    this.status = FeedbackStatus.newRequest,
    this.consentGiven = true,
  });

  factory FeedbackModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FeedbackModel(
      id: doc.id,
      type: FeedbackTypeExtension.fromString(data['type'] ?? 'bug'),
      subject: data['subject'] ?? '',
      description: data['description'] ?? '',
      userEmail: data['userEmail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: FeedbackStatusExtension.fromString(data['status'] ?? 'new'),
      consentGiven: data['consentGiven'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'type': type.name,
      'subject': subject,
      'description': description,
      // Store userEmail securely. Firestore rules will restrict read/write access based on this.
      'userEmail': userEmail.toLowerCase(), 
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name,
      'consentGiven': consentGiven,
    };
  }

  FeedbackModel copyWith({
    String? id,
    FeedbackType? type,
    String? subject,
    String? description,
    String? userEmail,
    DateTime? createdAt,
    FeedbackStatus? status,
    bool? consentGiven,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      type: type ?? this.type,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      consentGiven: consentGiven ?? this.consentGiven,
    );
  }
}
