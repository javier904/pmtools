import 'package:cloud_firestore/cloud_firestore.dart';

/// Modello profilo utente - Modulare e riutilizzabile
///
/// Campi standard per qualsiasi webapp:
/// - Dati anagrafici base
/// - Stato account
/// - Metadata (date creazione/modifica)
class UserProfileModel {
  final String id; // UID Firebase Auth
  final String email;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final String? phoneNumber;
  final String? company;
  final String? jobTitle;
  final String? bio;

  // Stato account
  final AccountStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;
  final String? deletionRequestedAt; // Data richiesta cancellazione (null = non richiesta)
  final String? deletionReason;

  // Metadata
  final String? locale; // it, en, etc.
  final String? timezone;
  final AuthProvider authProvider; // google, email, etc.

  const UserProfileModel({
    required this.id,
    required this.email,
    this.displayName,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.phoneNumber,
    this.company,
    this.jobTitle,
    this.bio,
    this.status = AccountStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.deletionRequestedAt,
    this.deletionReason,
    this.locale,
    this.timezone,
    this.authProvider = AuthProvider.email,
  });

  /// Nome completo calcolato
  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return displayName ?? email.split('@').first;
  }

  /// Iniziali per avatar
  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    }
    if (displayName != null && displayName!.isNotEmpty) {
      final parts = displayName!.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return displayName![0].toUpperCase();
    }
    return email[0].toUpperCase();
  }

  /// Verifica se l'account è attivo
  bool get isActive => status == AccountStatus.active;

  /// Verifica se è stata richiesta la cancellazione
  bool get hasDeletionRequest => deletionRequestedAt != null;

  // ═══════════════════════════════════════════════════════════════════════════
  // SERIALIZATION
  // ═══════════════════════════════════════════════════════════════════════════

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'company': company,
      'jobTitle': jobTitle,
      'bio': bio,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'lastLoginAt': lastLoginAt != null ? Timestamp.fromDate(lastLoginAt!) : null,
      'deletionRequestedAt': deletionRequestedAt,
      'deletionReason': deletionReason,
      'locale': locale,
      'timezone': timezone,
      'authProvider': authProvider.name,
    };
  }

  factory UserProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfileModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      photoUrl: data['photoUrl'],
      phoneNumber: data['phoneNumber'],
      company: data['company'],
      jobTitle: data['jobTitle'],
      bio: data['bio'],
      status: AccountStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => AccountStatus.active,
      ),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLoginAt: (data['lastLoginAt'] as Timestamp?)?.toDate(),
      deletionRequestedAt: data['deletionRequestedAt'],
      deletionReason: data['deletionReason'],
      locale: data['locale'],
      timezone: data['timezone'],
      authProvider: AuthProvider.values.firstWhere(
        (p) => p.name == data['authProvider'],
        orElse: () => AuthProvider.email,
      ),
    );
  }

  /// Crea profilo da Firebase Auth user
  factory UserProfileModel.fromAuthUser({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    AuthProvider provider = AuthProvider.email,
  }) {
    final now = DateTime.now();
    return UserProfileModel(
      id: uid,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      authProvider: provider,
      createdAt: now,
      updatedAt: now,
      lastLoginAt: now,
    );
  }

  UserProfileModel copyWith({
    String? email,
    String? displayName,
    String? firstName,
    String? lastName,
    String? photoUrl,
    String? phoneNumber,
    String? company,
    String? jobTitle,
    String? bio,
    AccountStatus? status,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    String? deletionRequestedAt,
    bool clearDeletionRequest = false,
    String? deletionReason,
    String? locale,
    String? timezone,
  }) {
    return UserProfileModel(
      id: id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      company: company ?? this.company,
      jobTitle: jobTitle ?? this.jobTitle,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      deletionRequestedAt: clearDeletionRequest ? null : (deletionRequestedAt ?? this.deletionRequestedAt),
      deletionReason: clearDeletionRequest ? null : (deletionReason ?? this.deletionReason),
      locale: locale ?? this.locale,
      timezone: timezone ?? this.timezone,
      authProvider: authProvider,
    );
  }
}

/// Stato dell'account utente
enum AccountStatus {
  active,
  suspended,
  pendingDeletion,
  deleted;

  String get displayName {
    switch (this) {
      case AccountStatus.active:
        return 'Attivo';
      case AccountStatus.suspended:
        return 'Sospeso';
      case AccountStatus.pendingDeletion:
        return 'In cancellazione';
      case AccountStatus.deleted:
        return 'Eliminato';
    }
  }
}

/// Provider di autenticazione
enum AuthProvider {
  email,
  google,
  apple,
  microsoft,
  github;

  String get displayName {
    switch (this) {
      case AuthProvider.email:
        return 'Email';
      case AuthProvider.google:
        return 'Google';
      case AuthProvider.apple:
        return 'Apple';
      case AuthProvider.microsoft:
        return 'Microsoft';
      case AuthProvider.github:
        return 'GitHub';
    }
  }
}
