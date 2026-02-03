/// Rappresenta il collegamento a un tool esterno (es. Jira)
class ExternalIntegration {
  final String provider; // 'jira'
  final String externalId; // 'PROJ-123'
  final String externalUrl; // 'https://domain.atlassian.net/browse/PROJ-123'
  final String? iconUrl; // URL icona issue type
  final DateTime? lastSync;
  final Map<String, dynamic> metadata; // Estensioni future

  const ExternalIntegration({
    required this.provider,
    required this.externalId,
    required this.externalUrl,
    this.iconUrl,
    this.lastSync,
    this.metadata = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'provider': provider,
      'externalId': externalId,
      'externalUrl': externalUrl,
      'iconUrl': iconUrl,
      'lastSync': lastSync?.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory ExternalIntegration.fromMap(Map<String, dynamic> map) {
    return ExternalIntegration(
      provider: map['provider'] as String,
      externalId: map['externalId'] as String,
      externalUrl: map['externalUrl'] as String,
      iconUrl: map['iconUrl'] as String?,
      lastSync: map['lastSync'] != null ? DateTime.parse(map['lastSync']) : null,
      metadata: map['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  ExternalIntegration copyWith({
    String? provider,
    String? externalId,
    String? externalUrl,
    String? iconUrl,
    DateTime? lastSync,
    Map<String, dynamic>? metadata,
  }) {
    return ExternalIntegration(
      provider: provider ?? this.provider,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      lastSync: lastSync ?? this.lastSync,
      metadata: metadata ?? this.metadata,
    );
  }
}
