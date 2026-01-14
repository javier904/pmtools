# Piano: Differenziazione Reale dei Framework Agile

## Executive Summary

Questo piano trasforma la selezione del framework Agile (Scrum/Kanban/Hybrid) da una scelta puramente cosmetica a un sistema che **modifica realmente** l'esperienza utente, le viste disponibili, le metriche mostrate e fornisce documentazione contestuale.

---

## Analisi Stato Attuale

### Cosa Esiste Già
| Componente | Stato | Note |
|------------|-------|------|
| Selezione Framework | ✅ Esiste | Solo cosmetico, non cambia nulla |
| Tab Backlog | ✅ Funziona | Uguale per tutti |
| Tab Sprint | ✅ Funziona | Mostrato anche per Kanban (sbagliato) |
| Tab Kanban | ✅ Funziona | Senza WIP limits |
| Tab Team | ✅ Funziona | Uguale per tutti (corretto) |
| Tab Metrics | ✅ Funziona | Mostra TUTTE le metriche sempre |
| Tab Retro | ✅ Funziona | Mostrato anche per Kanban (sbagliato) |
| Velocity Chart | ✅ Esiste | Sempre visibile |
| Cumulative Flow | ✅ Esiste | Sempre visibile |
| Cycle Time | ✅ Esiste | Sempre visibile |
| Burndown Chart | ✅ Esiste | Sempre visibile |
| WIP Limits | ❌ Non esiste | Da implementare |
| Lead Time | ❌ Non esiste | Da implementare |
| Documentazione | ❌ Non esiste | Da implementare |

### Gap Critico
Il framework selezionato viene usato SOLO per:
1. Mostrare un'icona nell'header
2. Testo descrittivo nel tooltip

**NON** viene usato per:
- Filtrare tab visibili
- Adattare metriche
- Configurare board Kanban
- Guidare l'utente nel processo

---

## Architettura Proposta

### 1. Sistema di Feature Flags per Framework

```dart
/// lib/models/framework_features.dart

class FrameworkFeatures {
  final AgileFramework framework;

  const FrameworkFeatures(this.framework);

  // ═══════════════════════════════════════════════════════════════
  // TABS VISIBILITY
  // ═══════════════════════════════════════════════════════════════

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

  /// Retrospective solo per Scrum e Hybrid
  bool get showRetroTab => framework != AgileFramework.kanban;

  // ═══════════════════════════════════════════════════════════════
  // FEATURES CONFIGURATION
  // ═══════════════════════════════════════════════════════════════

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

  /// Cumulative Flow Diagram per Kanban e Hybrid
  bool get hasCFD => framework != AgileFramework.scrum;

  /// Lead/Cycle Time per Kanban e Hybrid
  bool get hasLeadCycleTime => framework != AgileFramework.scrum;

  // ═══════════════════════════════════════════════════════════════
  // UI CONFIGURATION
  // ═══════════════════════════════════════════════════════════════

  /// Numero di tab visibili
  int get visibleTabCount {
    int count = 4; // Backlog, Kanban, Team, Metrics (sempre)
    if (showSprintTab) count++;
    if (showRetroTab) count++;
    return count;
  }

  /// Lista tab da mostrare
  List<AgileTab> get visibleTabs {
    final tabs = <AgileTab>[AgileTab.backlog];
    if (showSprintTab) tabs.add(AgileTab.sprint);
    tabs.add(AgileTab.kanban);
    tabs.add(AgileTab.team);
    tabs.add(AgileTab.metrics);
    if (showRetroTab) tabs.add(AgileTab.retro);
    return tabs;
  }

  /// Colonne Kanban predefinite
  List<KanbanColumnConfig> get defaultKanbanColumns {
    switch (framework) {
      case AgileFramework.scrum:
        return [
          KanbanColumnConfig('backlog', 'Sprint Backlog', null),
          KanbanColumnConfig('inProgress', 'In Progress', null),
          KanbanColumnConfig('review', 'Review', null),
          KanbanColumnConfig('done', 'Done', null),
        ];
      case AgileFramework.kanban:
        return [
          KanbanColumnConfig('backlog', 'To Do', 5),
          KanbanColumnConfig('inProgress', 'In Progress', 3),
          KanbanColumnConfig('review', 'Review', 2),
          KanbanColumnConfig('done', 'Done', null),
        ];
      case AgileFramework.hybrid:
        return [
          KanbanColumnConfig('backlog', 'Backlog', 8),
          KanbanColumnConfig('ready', 'Ready', 3),
          KanbanColumnConfig('inProgress', 'In Progress', 4),
          KanbanColumnConfig('review', 'Review', 2),
          KanbanColumnConfig('done', 'Done', null),
        ];
    }
  }
}

enum AgileTab { backlog, sprint, kanban, team, metrics, retro }

class KanbanColumnConfig {
  final String id;
  final String name;
  final int? wipLimit; // null = no limit

  KanbanColumnConfig(this.id, this.name, this.wipLimit);
}
```

---

## Piano di Implementazione Dettagliato

### FASE 1: Infrastruttura Base (Framework Features)
**Obiettivo**: Creare il sistema che determina cosa mostrare in base al framework

#### 1.1 Creare `lib/models/framework_features.dart`
- Classe FrameworkFeatures come descritto sopra
- Enum AgileTab per i tab
- KanbanColumnConfig per le colonne

#### 1.2 Creare `lib/models/kanban_column_model.dart`
```dart
class KanbanColumnModel {
  final String id;
  final String name;
  final int? wipLimit;
  final List<StoryStatus> statuses; // Status mappati a questa colonna
  final int order;
  final Color? color;

  // WIP violation check
  bool isWipExceeded(int currentCount) =>
    wipLimit != null && currentCount > wipLimit!;
}
```

#### 1.3 Aggiornare `AgileProjectModel`
```dart
// Aggiungere campi:
List<KanbanColumnModel> kanbanColumns;
Map<String, int> wipLimits; // columnId -> limit
```

---

### FASE 2: Tabs Dinamici
**Obiettivo**: Mostrare/nascondere tab in base al framework

#### 2.1 Modificare `AgileProjectDetailScreen`
```dart
// PRIMA:
_tabController = TabController(length: 6, vsync: this);

// DOPO:
late FrameworkFeatures _features;

@override
void initState() {
  super.initState();
  _features = FrameworkFeatures(widget.project.framework);
  _tabController = TabController(length: _features.visibleTabCount, vsync: this);
}

// Tab dinamici
TabBar(
  controller: _tabController,
  tabs: _features.visibleTabs.map((tab) => _buildTab(tab)).toList(),
)

// TabBarView dinamico
TabBarView(
  controller: _tabController,
  children: _features.visibleTabs.map((tab) => _buildTabContent(tab)).toList(),
)
```

---

### FASE 3: Kanban Board con WIP Limits
**Obiettivo**: Implementare WIP limits per Kanban e Hybrid

#### 3.1 Aggiornare `KanbanBoardWidget`
```dart
class KanbanBoardWidget extends StatelessWidget {
  final List<UserStoryModel> stories;
  final List<KanbanColumnModel> columns;
  final AgileFramework framework;
  final Function(UserStoryModel, StoryStatus) onStatusChange;
  final Function(String, int) onWipLimitChange; // Per configurare limiti

  Widget _buildColumnHeader(KanbanColumnModel column, int itemCount) {
    final isExceeded = column.isWipExceeded(itemCount);

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isExceeded ? Colors.red.withOpacity(0.1) : Colors.grey[100],
        border: isExceeded ? Border.all(color: Colors.red, width: 2) : null,
      ),
      child: Row(
        children: [
          Text(column.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          // Contatore con WIP limit
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isExceeded ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              column.wipLimit != null
                ? '$itemCount / ${column.wipLimit}'
                : '$itemCount',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
```

#### 3.2 Aggiungere configurazione WIP limits
- Dialog per modificare WIP limits per colonna
- Salvataggio in Firestore
- Warning visivo quando limite superato

---

### FASE 4: Metriche Framework-Specific
**Obiettivo**: Mostrare solo le metriche rilevanti per il framework

#### 4.1 Aggiornare `MetricsDashboardWidget`
```dart
class MetricsDashboardWidget extends StatelessWidget {
  final AgileFramework framework;
  // ... altri parametri

  @override
  Widget build(BuildContext context) {
    final features = FrameworkFeatures(framework);

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSummaryRow(features),

          // Velocity (Scrum/Hybrid)
          if (features.hasVelocityTracking)
            VelocityTrendWidget(sprints: sprints),

          // Burndown (Scrum/Hybrid)
          if (features.hasBurndownChart && activeSprint != null)
            BurndownChartWidget(sprint: activeSprint),

          // CFD (Kanban/Hybrid)
          if (features.hasCFD)
            CumulativeFlowWidget(stories: stories),

          // Lead/Cycle Time (Kanban/Hybrid)
          if (features.hasLeadCycleTime)
            LeadCycleTimeWidget(stories: stories),

          // Throughput (Kanban/Hybrid)
          if (features.hasFlowMetrics)
            ThroughputWidget(stories: stories),
        ],
      ),
    );
  }
}
```

#### 4.2 Creare nuovi widget metriche
- `LeadTimeWidget` - Tempo da richiesta a completamento
- `ThroughputWidget` - Items completati per periodo
- `WorkItemAgeWidget` - Età degli item in progress

---

### FASE 5: Sistema Documentazione

#### 5.1 Struttura Documentazione

```
lib/
├── docs/
│   ├── methodology_docs.dart      # Contenuti documentazione
│   ├── docs_screen.dart           # Screen documentazione pre-progetto
│   └── contextual_help.dart       # Help contestuale in-progetto
```

#### 5.2 Creare `lib/docs/methodology_docs.dart`
```dart
class MethodologyDocs {
  static const scrumOverview = MethodologyContent(
    title: 'SCRUM',
    subtitle: 'Framework iterativo per progetti complessi',
    sections: [
      DocSection(
        title: 'Cos\'è Scrum?',
        content: '''
Scrum è un framework Agile per gestire progetti complessi, caratterizzato da:
- **Iterazioni fisse** chiamate Sprint (1-4 settimane)
- **Ruoli definiti**: Product Owner, Scrum Master, Team
- **Cerimonie regolari** per sincronizzazione e miglioramento
- **Artefatti** per trasparenza e tracciabilità
        ''',
      ),
      DocSection(
        title: 'I 3 Ruoli Scrum',
        content: '''
**Product Owner**
- Gestisce il Product Backlog
- Definisce le priorità
- Rappresenta gli stakeholder
- Massimizza il valore del prodotto

**Scrum Master**
- Facilita le cerimonie
- Rimuove gli impedimenti
- Protegge il team
- Coach del processo Scrum

**Development Team**
- Cross-funzionale
- Auto-organizzato
- 3-9 membri ideali
- Responsabile della delivery
        ''',
      ),
      DocSection(
        title: 'Le 4 Cerimonie',
        content: '''
**Sprint Planning** (Inizio Sprint)
- Durata: 2h per settimana di sprint
- Obiettivo: Definire Sprint Goal e Sprint Backlog
- Partecipanti: Tutto il team

**Daily Standup** (Ogni giorno)
- Durata: 15 minuti max
- 3 domande: Ieri? Oggi? Blocchi?
- In piedi, stesso orario

**Sprint Review** (Fine Sprint)
- Durata: 1h per settimana di sprint
- Demo del lavoro completato
- Feedback degli stakeholder

**Sprint Retrospective** (Dopo Review)
- Durata: 45min per settimana di sprint
- Cosa ha funzionato? Cosa migliorare?
- Action items per prossimo sprint
        ''',
      ),
      DocSection(
        title: 'Gli Artefatti',
        content: '''
**Product Backlog**
- Lista ordinata di tutto il lavoro
- Gestito dal Product Owner
- Sempre in evoluzione

**Sprint Backlog**
- Subset del Product Backlog per lo sprint
- Commitment del team
- Tracciato con burndown

**Increment**
- Somma di tutti gli item completati
- Potenzialmente rilasciabile
- Deve soddisfare Definition of Done
        ''',
      ),
      DocSection(
        title: 'Metriche Scrum',
        content: '''
**Velocity**
- Story Points completati per sprint
- Media degli ultimi 3-5 sprint
- Usata per planning futuri

**Burndown Chart**
- Lavoro rimanente vs tempo
- Aggiornato giornalmente
- Previsione completamento sprint

**Sprint Commitment vs Completion**
- % di story completate vs pianificate
- Target: 80-100%
        ''',
      ),
      DocSection(
        title: 'Quando usare Scrum?',
        content: '''
✅ **Ideale per:**
- Progetti con requisiti che evolvono
- Team dedicato al progetto
- Stakeholder disponibili per feedback
- Progetti di 3+ mesi

❌ **Meno adatto per:**
- Supporto/manutenzione continua
- Team frammentati su più progetti
- Requisiti rigidi e definiti
- Progetti brevissimi
        ''',
      ),
    ],
  );

  static const kanbanOverview = MethodologyContent(
    title: 'KANBAN',
    subtitle: 'Sistema di flusso continuo con gestione visuale',
    sections: [
      DocSection(
        title: 'Cos\'è Kanban?',
        content: '''
Kanban è un metodo Agile per gestire il lavoro con:
- **Flusso continuo** senza iterazioni fisse
- **Visualizzazione** del lavoro su board
- **Limiti WIP** per evitare sovraccarico
- **Sistema Pull** invece che Push
        ''',
      ),
      DocSection(
        title: 'I 4 Principi Kanban',
        content: '''
**1. Visualizza il Lavoro**
- Board con colonne per ogni fase
- Card per ogni item di lavoro
- Stato sempre visibile a tutti

**2. Limita il Work In Progress (WIP)**
- Massimo N item per colonna
- Evita multitasking eccessivo
- Forza completamento prima di iniziare nuovo lavoro

**3. Gestisci il Flusso**
- Monitora il movimento degli item
- Identifica blocchi e colli di bottiglia
- Ottimizza per throughput costante

**4. Migliora Continuamente**
- Analizza metriche regolarmente
- Esperimenta con limiti WIP
- Adatta il processo ai dati
        ''',
      ),
      DocSection(
        title: 'WIP Limits Spiegati',
        content: '''
**Cosa sono?**
Numero massimo di item permessi in una colonna.

**Perché usarli?**
- Riducono il context switching
- Evidenziano i colli di bottiglia
- Migliorano il focus del team
- Accelerano il throughput

**Come configurarli?**
- Inizia con: Numero membri team × 1.5
- Osserva: Colonne sempre piene? Troppo alto
- Osserva: Colonne spesso vuote? Troppo basso
- Aggiusta iterativamente

**Esempio:**
| Colonna | WIP Limit |
|---------|-----------|
| To Do | 5 |
| In Progress | 3 |
| Review | 2 |
| Done | ∞ |
        ''',
      ),
      DocSection(
        title: 'Metriche Kanban',
        content: '''
**Lead Time**
- Tempo da richiesta a consegna
- Include tempo in attesa
- Prospettiva del cliente

**Cycle Time**
- Tempo da inizio lavoro a completamento
- Esclude tempo in attesa
- Prospettiva del team

**Throughput**
- Items completati per periodo
- Misura la capacità del sistema
- Base per previsioni

**Cumulative Flow Diagram (CFD)**
- Visualizza item per stato nel tempo
- Identifica trend e problemi
- Area = Work In Progress
        ''',
      ),
      DocSection(
        title: 'Quando usare Kanban?',
        content: '''
✅ **Ideale per:**
- Supporto e manutenzione
- Lavoro con priorità variabili
- Team con interruzioni frequenti
- Flussi operativi continui

❌ **Meno adatto per:**
- Progetti con deadline fisse
- Team che necessitano struttura
- Progetti greenfield complessi
- Stakeholder che vogliono sprint
        ''',
      ),
    ],
  );

  static const hybridOverview = MethodologyContent(
    title: 'HYBRID (Scrumban)',
    subtitle: 'Il meglio di Scrum e Kanban combinati',
    sections: [
      DocSection(
        title: 'Cos\'è Hybrid/Scrumban?',
        content: '''
Hybrid combina elementi di Scrum e Kanban:
- **Sprint opzionali** per cadenza di planning
- **Board Kanban** con WIP limits sempre attivi
- **Cerimonie semplificate**
- **Metriche sia di velocity che di flow**
        ''',
      ),
      DocSection(
        title: 'Caratteristiche Principali',
        content: '''
**Da Scrum prende:**
- Sprint (opzionali, per pianificazione)
- Backlog prioritizzato
- Retrospettive regolari
- Story Points (opzionali)

**Da Kanban prende:**
- Board visuale con WIP limits
- Flusso continuo
- Metriche di flow
- Sistema Pull

**Aggiunge:**
- Flessibilità nella struttura
- Planning on-demand
- Transizione graduale
        ''',
      ),
      DocSection(
        title: 'Quando usare Hybrid?',
        content: '''
✅ **Ideale per:**
- Team in transizione Scrum → Kanban
- Mix di feature e manutenzione
- Team che vogliono sperimentare
- Progetti con requisiti misti

❌ **Meno adatto per:**
- Team che preferiscono struttura rigida
- Progetti puramente operativi
- Team junior che necessitano guida
        ''',
      ),
    ],
  );
}

class MethodologyContent {
  final String title;
  final String subtitle;
  final List<DocSection> sections;

  const MethodologyContent({
    required this.title,
    required this.subtitle,
    required this.sections,
  });
}

class DocSection {
  final String title;
  final String content;
  final String? imagePath;

  const DocSection({
    required this.title,
    required this.content,
    this.imagePath,
  });
}
```

#### 5.3 Creare Screen Documentazione Pre-Progetto
Accessibile dalla Home, prima di creare un progetto.

```dart
/// lib/docs/methodology_docs_screen.dart

class MethodologyDocsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Guida Metodologie Agile'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Confronto'),
              Tab(text: 'Scrum'),
              Tab(text: 'Kanban'),
              Tab(text: 'Hybrid'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ComparisonTab(),
            _MethodologyDetailTab(docs: MethodologyDocs.scrumOverview),
            _MethodologyDetailTab(docs: MethodologyDocs.kanbanOverview),
            _MethodologyDetailTab(docs: MethodologyDocs.hybridOverview),
          ],
        ),
      ),
    );
  }
}

class _ComparisonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quale metodologia scegliere?',
            style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 24),
          _buildComparisonTable(),
          SizedBox(height: 24),
          _buildDecisionTree(),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          children: [
            _cell('Aspetto', isHeader: true),
            _cell('SCRUM', isHeader: true),
            _cell('KANBAN', isHeader: true),
            _cell('HYBRID', isHeader: true),
          ],
        ),
        _tableRow('Iterazioni', 'Sprint fissi', 'Flusso continuo', 'Sprint opzionali'),
        _tableRow('Planning', 'Sprint Planning', 'On-demand', 'Entrambi'),
        _tableRow('Ruoli', 'PO, SM, Team', 'Flessibili', 'Flessibili'),
        _tableRow('Metriche', 'Velocity', 'Lead/Cycle Time', 'Entrambe'),
        _tableRow('WIP Limits', 'No', 'Sì (core)', 'Sì'),
        _tableRow('Cerimonie', '4 definite', 'Nessuna', 'Semplificate'),
        _tableRow('Cambiamenti', 'Fine sprint', 'Sempre', 'Sempre'),
        _tableRow('Ideale per', 'Progetti nuovi', 'Supporto/Ops', 'Transizione'),
      ],
    );
  }
}
```

#### 5.4 Creare Help Contestuale In-Progetto
Widget che mostra tips e guide basate su:
- Framework selezionato
- Tab corrente
- Azioni in corso

```dart
/// lib/docs/contextual_help.dart

class ContextualHelp {
  static String getTabHelp(AgileTab tab, AgileFramework framework) {
    switch (tab) {
      case AgileTab.backlog:
        return _getBacklogHelp(framework);
      case AgileTab.sprint:
        return _getSprintHelp(framework);
      case AgileTab.kanban:
        return _getKanbanHelp(framework);
      // ... etc
    }
  }

  static String _getBacklogHelp(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return '''
📋 **Backlog Scrum**

Il Product Backlog è la lista ordinata di tutto il lavoro da fare.

**Suggerimenti:**
• Ordina per valore di business (MoSCoW)
• Stima in Story Points (Fibonacci)
• Mantieni le top 10 stories "Ready"
• Fai Backlog Grooming settimanale
        ''';
      case AgileFramework.kanban:
        return '''
📋 **Backlog Kanban**

Il backlog è la coda di lavoro pronta per essere tirata nel flusso.

**Suggerimenti:**
• Ordina per priorità/urgenza
• Non stimare tutto - stima JIT
• Limita la dimensione del backlog
• Usa Classes of Service per urgenze
        ''';
      // ... etc
    }
  }
}

/// Widget per mostrare help contestuale
class ContextualHelpButton extends StatelessWidget {
  final AgileTab currentTab;
  final AgileFramework framework;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help_outline),
      tooltip: 'Guida',
      onPressed: () => _showHelpDialog(context),
    );
  }

  void _showHelpDialog(BuildContext context) {
    final helpText = ContextualHelp.getTabHelp(currentTab, framework);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber),
            SizedBox(width: 8),
            Text('Guida ${currentTab.displayName}'),
          ],
        ),
        content: SingleChildScrollView(
          child: MarkdownBody(data: helpText),
        ),
        actions: [
          TextButton(
            child: Text('Chiudi'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Documentazione Completa'),
            onPressed: () {
              Navigator.pop(context);
              // Apri documentazione completa
            },
          ),
        ],
      ),
    );
  }
}
```

---

### FASE 6: Guide Step-by-Step nel Progetto

#### 6.1 Onboarding Wizard Post-Creazione
Quando si crea un nuovo progetto, mostrare wizard guidato.

```dart
class ProjectOnboardingWizard extends StatefulWidget {
  final AgileProjectModel project;

  @override
  _ProjectOnboardingWizardState createState() => _ProjectOnboardingWizardState();
}

class _ProjectOnboardingWizardState extends State<ProjectOnboardingWizard> {
  int _currentStep = 0;

  List<OnboardingStep> get _steps {
    final features = FrameworkFeatures(widget.project.framework);

    return [
      OnboardingStep(
        title: 'Benvenuto in ${widget.project.name}!',
        content: _buildWelcomeContent(),
      ),
      OnboardingStep(
        title: 'Configura il Team',
        content: _buildTeamSetupContent(),
      ),
      OnboardingStep(
        title: 'Crea il Backlog',
        content: _buildBacklogContent(),
      ),
      if (features.showSprintTab)
        OnboardingStep(
          title: 'Pianifica il Primo Sprint',
          content: _buildSprintContent(),
        ),
      if (features.hasWipLimits)
        OnboardingStep(
          title: 'Configura i WIP Limits',
          content: _buildWipContent(),
        ),
      OnboardingStep(
        title: 'Tutto Pronto!',
        content: _buildReadyContent(),
      ),
    ];
  }

  Widget _buildWelcomeContent() {
    final framework = widget.project.framework;
    return Column(
      children: [
        Icon(framework.icon, size: 64, color: Colors.blue),
        SizedBox(height: 16),
        Text(
          'Hai scelto ${framework.displayName}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(framework.detailedDescription),
        SizedBox(height: 24),
        _buildFrameworkHighlights(framework),
      ],
    );
  }
}
```

#### 6.2 Progress Checklist per Nuovo Progetto
Widget che mostra progressi setup iniziale.

```dart
class ProjectSetupChecklist extends StatelessWidget {
  final AgileProjectModel project;
  final List<UserStoryModel> stories;
  final List<SprintModel> sprints;

  @override
  Widget build(BuildContext context) {
    final items = _getChecklistItems();
    final completedCount = items.where((i) => i.isCompleted).length;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.checklist, color: Colors.blue),
                SizedBox(width: 8),
                Text('Setup Progetto',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Text('$completedCount / ${items.length}',
                  style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: completedCount / items.length,
            ),
            SizedBox(height: 12),
            ...items.map((item) => _buildChecklistItem(item)),
          ],
        ),
      ),
    );
  }

  List<ChecklistItem> _getChecklistItems() {
    final features = FrameworkFeatures(project.framework);

    return [
      ChecklistItem(
        title: 'Aggiungi almeno 1 membro al team',
        isCompleted: project.participants.length > 1,
        action: 'Vai a Team',
        tab: AgileTab.team,
      ),
      ChecklistItem(
        title: 'Crea almeno 5 user stories',
        isCompleted: stories.length >= 5,
        action: 'Crea Story',
        tab: AgileTab.backlog,
      ),
      if (features.hasStoryPoints)
        ChecklistItem(
          title: 'Stima le stories nel backlog',
          isCompleted: stories.where((s) => s.storyPoints > 0).length >= 3,
          action: 'Stima Stories',
          tab: AgileTab.backlog,
        ),
      if (features.showSprintTab)
        ChecklistItem(
          title: 'Crea il primo sprint',
          isCompleted: sprints.isNotEmpty,
          action: 'Crea Sprint',
          tab: AgileTab.sprint,
        ),
      if (features.hasWipLimits)
        ChecklistItem(
          title: 'Configura i WIP limits',
          isCompleted: project.wipLimits.isNotEmpty,
          action: 'Configura WIP',
          tab: AgileTab.kanban,
        ),
    ];
  }
}
```

---

### FASE 7: Integrazione Finale

#### 7.1 Aggiungere Pulsante Documentazione in Home
```dart
// In home_screen.dart, aggiungere card per documentazione

Widget _buildDocsCard() {
  return Card(
    child: InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MethodologyDocsScreen()),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.menu_book, size: 48, color: Colors.teal),
            SizedBox(height: 8),
            Text('Guida Metodologie',
              style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Scrum, Kanban, Hybrid',
              style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    ),
  );
}
```

#### 7.2 Help Button in AppBar
```dart
// In agile_project_detail_screen.dart

AppBar(
  actions: [
    ContextualHelpButton(
      currentTab: _features.visibleTabs[_tabController.index],
      framework: widget.project.framework,
    ),
    // ... altri action
  ],
)
```

---

## Riepilogo Fasi

| Fase | Descrizione | File Principali | Complessità |
|------|-------------|-----------------|-------------|
| 1 | Infrastruttura Features | `framework_features.dart`, `kanban_column_model.dart` | Media |
| 2 | Tabs Dinamici | `agile_project_detail_screen.dart` | Media |
| 3 | WIP Limits Kanban | `kanban_board_widget.dart` | Alta |
| 4 | Metriche Framework-Specific | `metrics_dashboard_widget.dart`, nuovi widget | Alta |
| 5 | Sistema Documentazione | `methodology_docs.dart`, `docs_screen.dart` | Media |
| 6 | Guide Step-by-Step | `onboarding_wizard.dart`, `setup_checklist.dart` | Media |
| 7 | Integrazione | `home_screen.dart`, `agile_project_detail_screen.dart` | Bassa |

---

## Risultato Atteso

### SCRUM
- Tab: Backlog, **Sprint**, Kanban, Team, Metrics, **Retro**
- Metriche: Velocity, Burndown, Sprint Completion
- Board: Sprint Backlog view, no WIP
- Documentazione: Focus su cerimonie e ruoli

### KANBAN
- Tab: Backlog, Kanban, Team, Metrics (no Sprint, no Retro)
- Metriche: Lead Time, Cycle Time, CFD, Throughput
- Board: **Con WIP limits visibili e configurabili**
- Documentazione: Focus su flow e WIP management

### HYBRID
- Tab: Tutti (Backlog, Sprint, Kanban, Team, Metrics, Retro)
- Metriche: Tutte (Velocity + Flow)
- Board: Con WIP limits
- Documentazione: Mix di entrambi

---

## Note Implementazione

1. **Backwards Compatibility**: I progetti esistenti devono funzionare - default a mostrare tutto se `kanbanColumns` è vuoto
2. **Migration**: Script per aggiungere `kanbanColumns` ai progetti esistenti basandosi sul framework
3. **Testing**: Test su tutti e 3 i framework per ogni feature
4. **Performance**: Lazy loading delle sezioni documentazione
