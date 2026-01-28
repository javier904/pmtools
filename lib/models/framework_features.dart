import 'package:flutter/material.dart';
import 'agile_enums.dart';

/// Enum per identificare i tab dell'applicazione Agile
enum AgileTab {
  backlog,
  sprint,
  kanban,
  team,
  metrics,
  retro;

  String get displayName {
    switch (this) {
      case AgileTab.backlog:
        return 'Backlog';
      case AgileTab.sprint:
        return 'Sprint';
      case AgileTab.kanban:
        return 'Kanban';
      case AgileTab.team:
        return 'Team';
      case AgileTab.metrics:
        return 'Metrics';
      case AgileTab.retro:
        return 'Retro';
    }
  }

  IconData get icon {
    switch (this) {
      case AgileTab.backlog:
        return Icons.list_alt;
      case AgileTab.sprint:
        return Icons.flag;
      case AgileTab.kanban:
        return Icons.view_kanban;
      case AgileTab.team:
        return Icons.people;
      case AgileTab.metrics:
        return Icons.analytics;
      case AgileTab.retro:
        return Icons.history;
    }
  }
}

/// Classe che determina quali feature sono disponibili per ogni framework
///
/// Questa classe è il cuore del sistema di differenziazione tra Scrum, Kanban e Hybrid.
/// Viene usata per:
/// - Determinare quali tab mostrare
/// - Abilitare/disabilitare funzionalità specifiche
/// - Configurare metriche e visualizzazioni
class FrameworkFeatures {
  final AgileFramework framework;

  const FrameworkFeatures(this.framework);

  // ═══════════════════════════════════════════════════════════════════════════
  // TABS VISIBILITY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Backlog sempre visibile (tutti i framework)
  bool get showBacklogTab => true;

  /// Sprint Planning solo per Scrum e Hybrid
  bool get showSprintTab => framework != AgileFramework.kanban;

  /// Kanban Board per tutti (ma con configurazioni diverse)
  bool get showKanbanTab => true;

  /// Team sempre visibile
  bool get showTeamTab => true;

  /// Metrics sempre visibile (ma contenuto diverso)
  bool get showMetricsTab => true;

  /// Retrospective per TUTTI i framework
  /// - Scrum: Sprint Retrospective (Scrum Guide 2020)
  /// - Kanban: Operations Review / Service Delivery Review (feedback loops practice - David Anderson)
  /// - Hybrid: Entrambi gli approcci
  bool get showRetroTab => true;

  // ═══════════════════════════════════════════════════════════════════════════
  // FEATURES CONFIGURATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// WIP Limits per Kanban e Hybrid
  bool get hasWipLimits => framework != AgileFramework.scrum;

  /// Story Points per Scrum e Hybrid
  bool get hasStoryPoints => framework != AgileFramework.kanban;

  /// Velocity tracking per Scrum e Hybrid
  bool get hasVelocityTracking => framework != AgileFramework.kanban;

  /// Flow metrics per Kanban e Hybrid
  bool get hasFlowMetrics => framework != AgileFramework.scrum;

  /// Sprint ceremonies per Scrum
  bool get hasSprintCeremonies => framework == AgileFramework.scrum;

  /// Burndown chart per Scrum e Hybrid
  bool get hasBurndownChart => framework != AgileFramework.kanban;

  /// Burnup chart per Scrum e Hybrid
  bool get hasBurnupChart => framework != AgileFramework.kanban;

  /// Cumulative Flow Diagram per Kanban e Hybrid
  bool get hasCFD => framework != AgileFramework.scrum;

  /// Lead/Cycle Time per TUTTI i framework
  /// - Scrum: Utile per predictability e continuous improvement (Scrum Guide 2020)
  /// - Kanban: Core practice - "Manage Flow" (David Anderson)
  /// - Hybrid: Entrambi gli approcci
  bool get hasLeadCycleTime => true;

  /// Throughput metrics per TUTTI i framework
  /// - Scrum: Utile per forecasting e sprint planning
  /// - Kanban: Core metric per flow management
  /// - Hybrid: Entrambi gli approcci
  bool get hasThroughput => true;

  /// Daily Standup/Meeting per TUTTI i framework
  /// - Scrum: Daily Scrum (Scrum Guide 2020 - 15 min max)
  /// - Kanban: Daily Meeting/Standup (common practice, non obbligatorio ma consigliato)
  /// - Hybrid: Entrambi gli approcci
  bool get hasDailyStandup => true;

  /// Estimation sessions (tutti, ma con focus diverso)
  bool get hasEstimation => true;

  /// Focus su Story Points (Scrum) vs stime generiche (Kanban)
  bool get estimationUsesStoryPoints => framework != AgileFramework.kanban;

  // ═══════════════════════════════════════════════════════════════════════════
  // UI CONFIGURATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Numero di tab visibili
  int get visibleTabCount {
    int count = 4; // Backlog, Kanban, Team, Metrics (sempre)
    if (showSprintTab) count++;
    if (showRetroTab) count++;
    return count;
  }

  /// Lista tab da mostrare in ordine
  List<AgileTab> get visibleTabs {
    final tabs = <AgileTab>[AgileTab.backlog];
    if (showSprintTab) tabs.add(AgileTab.sprint);
    tabs.add(AgileTab.kanban);
    tabs.add(AgileTab.team);
    tabs.add(AgileTab.metrics);
    if (showRetroTab) tabs.add(AgileTab.retro);
    return tabs;
  }

  /// Colonne Kanban predefinite per il framework
  List<KanbanColumnConfig> get defaultKanbanColumns {
    switch (framework) {
      case AgileFramework.scrum:
        // Scrum: focus su Sprint Backlog, no WIP limits
        // NOTA: inSprint è lo status delle stories aggiunte allo sprint attivo
        return [
          KanbanColumnConfig(
            id: 'todo',
            name: 'Sprint Backlog',
            wipLimit: null,
            statuses: [StoryStatus.ready, StoryStatus.inSprint],
          ),
          KanbanColumnConfig(
            id: 'inProgress',
            name: 'In Progress',
            wipLimit: null,
            statuses: [StoryStatus.inProgress],
          ),
          KanbanColumnConfig(
            id: 'review',
            name: 'In Review',
            wipLimit: null,
            statuses: [StoryStatus.inReview],
          ),
          KanbanColumnConfig(
            id: 'done',
            name: 'Done',
            wipLimit: null,
            statuses: [StoryStatus.done],
          ),
        ];

      case AgileFramework.kanban:
        // Kanban: WIP limits sono fondamentali, include Refinement
        // Policy esplicite per ogni colonna (Kanban Practice #4)
        return [
          KanbanColumnConfig(
            id: 'backlog',
            name: 'Backlog',
            wipLimit: null, // Backlog non ha WIP limit
            statuses: [StoryStatus.backlog],
            policies: ['Ordina per priorità business'],
          ),
          KanbanColumnConfig(
            id: 'refinement',
            name: 'Refinement',
            wipLimit: 5, // Limita item in analisi parallela
            statuses: [StoryStatus.refinement],
            policies: [
              'Max 2 giorni in questa colonna',
              'Richiede criteri di accettazione definiti',
            ],
          ),
          KanbanColumnConfig(
            id: 'ready',
            name: 'Ready',
            wipLimit: 5,
            statuses: [StoryStatus.ready],
            policies: [
              'Item pronto per essere lavorato',
              'Stima completata (se richiesta)',
            ],
          ),
          KanbanColumnConfig(
            id: 'inProgress',
            name: 'In Progress',
            wipLimit: 3,
            statuses: [StoryStatus.inProgress],
            policies: [
              'Max 1 item per persona',
              'Daily update obbligatorio',
            ],
          ),
          KanbanColumnConfig(
            id: 'review',
            name: 'Review',
            wipLimit: 2,
            statuses: [StoryStatus.inReview],
            policies: [
              'Max 24h in questa colonna',
              'Richiede code review approvata',
            ],
          ),
          KanbanColumnConfig(
            id: 'done',
            name: 'Done',
            wipLimit: null,
            statuses: [StoryStatus.done],
            policies: [
              'Tutti i criteri di accettazione soddisfatti',
              'Test superati',
            ],
          ),
        ];

      case AgileFramework.hybrid:
        // Hybrid: Colonne più granulari con WIP limits, include Refinement
        // NOTA: inSprint incluso in Ready per compatibilità con sprint opzionali
        // Policy esplicite per ogni colonna (Kanban Practice #4)
        return [
          KanbanColumnConfig(
            id: 'backlog',
            name: 'Backlog',
            wipLimit: null,
            statuses: [StoryStatus.backlog],
          ),
          KanbanColumnConfig(
            id: 'refinement',
            name: 'Refinement',
            wipLimit: 5,
            statuses: [StoryStatus.refinement],
            policies: ['Richiede criteri di accettazione'],
          ),
          KanbanColumnConfig(
            id: 'ready',
            name: 'Ready',
            wipLimit: 5,
            statuses: [StoryStatus.ready, StoryStatus.inSprint],
            policies: ['Item pronto per sviluppo'],
          ),
          KanbanColumnConfig(
            id: 'inProgress',
            name: 'In Progress',
            wipLimit: 4,
            statuses: [StoryStatus.inProgress],
            policies: ['Max 1 item per persona'],
          ),
          KanbanColumnConfig(
            id: 'review',
            name: 'Review',
            wipLimit: 2,
            statuses: [StoryStatus.inReview],
            policies: ['Code review obbligatoria'],
          ),
          KanbanColumnConfig(
            id: 'done',
            name: 'Done',
            wipLimit: null,
            statuses: [StoryStatus.done],
          ),
        ];
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LABELS E TERMINOLOGIA
  // ═══════════════════════════════════════════════════════════════════════════

  /// Label per il backlog
  String get backlogLabel {
    switch (framework) {
      case AgileFramework.scrum:
        return 'Product Backlog';
      case AgileFramework.kanban:
        return 'Backlog';
      case AgileFramework.hybrid:
        return 'Backlog';
    }
  }

  /// Label per gli item di lavoro
  String get workItemLabel {
    switch (framework) {
      case AgileFramework.scrum:
        return 'User Story';
      case AgileFramework.kanban:
        return 'Work Item';
      case AgileFramework.hybrid:
        return 'Item';
    }
  }

  /// Label plurale per gli item di lavoro
  String get workItemLabelPlural {
    switch (framework) {
      case AgileFramework.scrum:
        return 'User Stories';
      case AgileFramework.kanban:
        return 'Work Items';
      case AgileFramework.hybrid:
        return 'Items';
    }
  }

  /// Label per la stima
  String get estimationLabel {
    switch (framework) {
      case AgileFramework.scrum:
        return 'Story Points';
      case AgileFramework.kanban:
        return 'Size';
      case AgileFramework.hybrid:
        return 'Estimate';
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Restituisce il colore principale del framework
  Color get primaryColor {
    switch (framework) {
      case AgileFramework.scrum:
        return const Color(0xFF1976D2); // Blue
      case AgileFramework.kanban:
        return const Color(0xFF388E3C); // Green
      case AgileFramework.hybrid:
        return const Color(0xFF7B1FA2); // Purple
    }
  }

  /// Restituisce una descrizione breve del focus del framework
  String get focusDescription {
    switch (framework) {
      case AgileFramework.scrum:
        return 'Focus su Sprint e Velocity';
      case AgileFramework.kanban:
        return 'Focus su Flow e WIP';
      case AgileFramework.hybrid:
        return 'Mix di Sprint e Flow';
    }
  }
}

/// Configurazione di una colonna Kanban
class KanbanColumnConfig {
  final String id;
  final String name;
  final int? wipLimit;
  final List<StoryStatus> statuses;
  final Color? color;
  final int order;

  /// Policy esplicite per questa colonna (Kanban Practice #4 - Make Policies Explicit)
  /// Esempi: "Max 24h in questa colonna", "Richiede code review approvata"
  final List<String> policies;

  const KanbanColumnConfig({
    required this.id,
    required this.name,
    this.wipLimit,
    required this.statuses,
    this.color,
    this.order = 0,
    this.policies = const [],
  });

  /// Verifica se il WIP limit è superato
  bool isWipExceeded(int currentCount) {
    if (wipLimit == null) return false;
    return currentCount > wipLimit!;
  }

  /// Verifica se il WIP limit è al limite
  bool isWipAtLimit(int currentCount) {
    if (wipLimit == null) return false;
    return currentCount == wipLimit;
  }

  /// Verifica se aggiungere un item supererebbe il WIP limit
  bool wouldExceedWip(int currentCount) {
    if (wipLimit == null) return false;
    return (currentCount + 1) > wipLimit!;
  }

  /// Restituisce il colore in base allo stato WIP
  Color getWipStatusColor(int currentCount) {
    if (wipLimit == null) return Colors.grey;
    if (isWipExceeded(currentCount)) return Colors.red;
    if (isWipAtLimit(currentCount)) return Colors.orange;
    return Colors.green;
  }

  /// Verifica se la colonna ha policy definite
  bool get hasPolicies => policies.isNotEmpty;

  /// Crea una copia con modifiche
  KanbanColumnConfig copyWith({
    String? id,
    String? name,
    int? wipLimit,
    bool clearWipLimit = false,
    List<StoryStatus>? statuses,
    Color? color,
    int? order,
    List<String>? policies,
  }) {
    return KanbanColumnConfig(
      id: id ?? this.id,
      name: name ?? this.name,
      wipLimit: clearWipLimit ? null : (wipLimit ?? this.wipLimit),
      statuses: statuses ?? this.statuses,
      color: color ?? this.color,
      order: order ?? this.order,
      policies: policies ?? this.policies,
    );
  }

  /// Converte in Map per Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'wipLimit': wipLimit,
      'statuses': statuses.map((s) => s.name).toList(),
      'color': color?.value,
      'order': order,
      'policies': policies,
    };
  }

  /// Crea da Firestore
  factory KanbanColumnConfig.fromFirestore(Map<String, dynamic> data) {
    return KanbanColumnConfig(
      id: data['id'] as String,
      name: data['name'] as String,
      wipLimit: data['wipLimit'] as int?,
      statuses: (data['statuses'] as List<dynamic>?)
              ?.map((s) => StoryStatus.values.firstWhere(
                    (status) => status.name == s,
                    orElse: () => StoryStatus.backlog,
                  ))
              .toList() ??
          [],
      color: data['color'] != null ? Color(data['color'] as int) : null,
      order: data['order'] as int? ?? 0,
      policies: List<String>.from(data['policies'] ?? []),
    );
  }
}
