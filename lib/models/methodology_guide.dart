import 'package:flutter/material.dart';
import 'agile_enums.dart';

/// Guida dettagliata per ogni metodologia Agile
///
/// Contiene documentazione completa consultabile prima e durante il progetto.
class MethodologyGuide {
  final AgileFramework framework;
  final String title;
  final String overview;
  final List<MethodologySection> sections;
  final List<String> bestPractices;
  final List<String> antiPatterns;
  final List<FAQ> faqs;

  const MethodologyGuide({
    required this.framework,
    required this.title,
    required this.overview,
    required this.sections,
    required this.bestPractices,
    required this.antiPatterns,
    required this.faqs,
  });

  IconData get icon => framework.icon;
  Color get color => framework == AgileFramework.scrum
      ? const Color(0xFF1976D2)
      : framework == AgileFramework.kanban
          ? const Color(0xFF388E3C)
          : const Color(0xFF7B1FA2);

  /// Factory per ottenere la guida di una metodologia
  factory MethodologyGuide.forFramework(AgileFramework framework) {
    switch (framework) {
      case AgileFramework.scrum:
        return _scrumGuide;
      case AgileFramework.kanban:
        return _kanbanGuide;
      case AgileFramework.hybrid:
        return _hybridGuide;
    }
  }

  /// Lista di tutte le guide disponibili
  static List<MethodologyGuide> get allGuides => [
    _scrumGuide,
    _kanbanGuide,
    _hybridGuide,
  ];
}

/// Sezione della guida con titolo e contenuto
class MethodologySection {
  final String title;
  final String content;
  final IconData? icon;
  final List<String>? bulletPoints;

  const MethodologySection({
    required this.title,
    required this.content,
    this.icon,
    this.bulletPoints,
  });
}

/// Domanda frequente
class FAQ {
  final String question;
  final String answer;

  const FAQ({
    required this.question,
    required this.answer,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// SCRUM GUIDE
// ═══════════════════════════════════════════════════════════════════════════

const _scrumGuide = MethodologyGuide(
  framework: AgileFramework.scrum,
  title: 'Scrum',
  overview: '''
Scrum è un framework Agile iterativo e incrementale per la gestione dello sviluppo prodotto.
Si basa su cicli di lavoro a tempo fisso chiamati Sprint, tipicamente di 2-4 settimane.

Scrum è ideale per:
• Team che lavorano su prodotti con requisiti che evolvono
• Progetti che beneficiano di feedback regolare
• Organizzazioni che vogliono migliorare prevedibilità e trasparenza
''',
  sections: [
    MethodologySection(
      title: 'I Ruoli Scrum',
      content: 'Scrum definisce tre ruoli chiave che collaborano per il successo del progetto.',
      icon: Icons.people,
      bulletPoints: [
        'Product Owner: Rappresenta gli stakeholder, gestisce il Product Backlog e massimizza il valore del prodotto',
        'Scrum Master: Facilita il processo Scrum, rimuove impedimenti e aiuta il team a migliorare',
        'Development Team: Team cross-funzionale e auto-organizzato che consegna l\'incremento di prodotto',
      ],
    ),
    MethodologySection(
      title: 'Gli Eventi Scrum',
      content: 'Scrum prevede eventi regolari per creare regolarità e minimizzare riunioni non pianificate.',
      icon: Icons.event,
      bulletPoints: [
        'Sprint Planning: Pianificazione del lavoro dello Sprint (max 8h per Sprint di 4 settimane)',
        'Daily Scrum: Sincronizzazione giornaliera del team (15 minuti)',
        'Sprint Review: Demo del lavoro completato agli stakeholder (max 4h)',
        'Sprint Retrospective: Riflessione del team per miglioramento continuo (max 3h)',
      ],
    ),
    MethodologySection(
      title: 'Gli Artefatti Scrum',
      content: 'Gli artefatti rappresentano lavoro o valore e sono progettati per massimizzare la trasparenza.',
      icon: Icons.description,
      bulletPoints: [
        'Product Backlog: Lista ordinata di tutto ciò che potrebbe servire nel prodotto',
        'Sprint Backlog: Items selezionati per lo Sprint + piano per consegnare l\'incremento',
        'Incremento: Somma di tutti gli items completati durante lo Sprint, potenzialmente rilasciabile',
      ],
    ),
    MethodologySection(
      title: 'Story Points e Velocity',
      content: '''
Gli Story Points sono un\'unità di misura relativa della complessità delle User Stories.
Non misurano il tempo, ma lo sforzo, la complessità e l\'incertezza.

La sequenza di Fibonacci (1, 2, 3, 5, 8, 13, 21) è comunemente usata perché:
• Riflette l\'incertezza crescente per items più grandi
• Rende difficile la falsa precisione
• Facilita le discussioni durante la stima

La Velocity è la media degli Story Points completati negli ultimi sprint e serve per:
• Prevedere quanto lavoro può essere incluso nei prossimi sprint
• Identificare trend di produttività del team
• Non confrontare team diversi (ogni team ha la propria scala)
''',
      icon: Icons.speed,
    ),
  ],
  bestPractices: [
    'Mantieni gli Sprint a durata fissa e rispetta il timebox',
    'Il Product Backlog deve essere sempre prioritizzato e raffinato',
    'Le User Stories devono rispettare i criteri INVEST',
    'La Definition of Done deve essere chiara e condivisa',
    'Non modificare lo Sprint Goal durante lo Sprint',
    'Celebra i successi nella Sprint Review',
    'La Retrospettiva deve produrre azioni concrete di miglioramento',
    'Il team deve essere cross-funzionale e auto-organizzato',
  ],
  antiPatterns: [
    'Sprint senza Sprint Goal chiaro',
    'Daily Scrum trasformato in report meeting',
    'Saltare la Retrospettiva quando si è "troppo occupati"',
    'Product Owner assente o non disponibile',
    'Aggiungere lavoro durante lo Sprint senza rimuovere altro',
    'Story Points convertiti in ore (perde il senso)',
    'Team troppo grande (ideale 5-9 persone)',
    'Scrum Master che "assegna" compiti al team',
  ],
  faqs: [
    FAQ(
      question: 'Quanto deve durare uno Sprint?',
      answer: 'La durata tipica è 2 settimane, ma può variare da 1 a 4 settimane. '
          'Sprint più brevi permettono feedback più frequenti e correzioni di rotta rapide. '
          'Sprint più lunghi danno più tempo per completare items complessi. '
          'L\'importante è mantenere la durata costante.',
    ),
    FAQ(
      question: 'Come gestire lavoro non completato a fine Sprint?',
      answer: 'Le User Stories non completate tornano nel Product Backlog e vengono ri-prioritizzate. '
          'Mai estendere lo Sprint o ridurre la Definition of Done. '
          'Usare la Retrospettiva per capire perché è successo e come prevenirlo.',
    ),
    FAQ(
      question: 'Posso cambiare lo Sprint Backlog durante lo Sprint?',
      answer: 'Lo Sprint Goal non dovrebbe cambiare, ma lo Sprint Backlog può evolversi. '
          'Il team può negoziare con il PO la sostituzione di items di pari valore. '
          'Se lo Sprint Goal diventa obsoleto, il PO può cancellare lo Sprint.',
    ),
    FAQ(
      question: 'Come calcolare la Velocity iniziale?',
      answer: 'Per i primi 3 Sprint, fai stime conservative. '
          'Dopo 3 Sprint avrai una Velocity affidabile. '
          'Non usare la Velocity di altri team come riferimento.',
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════════════════
// KANBAN GUIDE
// ═══════════════════════════════════════════════════════════════════════════

const _kanbanGuide = MethodologyGuide(
  framework: AgileFramework.kanban,
  title: 'Kanban',
  overview: '''
Kanban è un metodo per gestire il lavoro che enfatizza la visualizzazione del flusso,
la limitazione del Work In Progress (WIP) e il miglioramento continuo del processo.

Kanban è ideale per:
• Team di supporto/manutenzione con richieste continue
• Ambienti dove le priorità cambiano frequentemente
• Quando non è possibile pianificare in iterazioni fisse
• Transizione graduale verso l\'Agile
''',
  sections: [
    MethodologySection(
      title: 'I Principi Kanban',
      content: 'Kanban si basa su principi di cambiamento incrementale e rispetto per i ruoli esistenti.',
      icon: Icons.lightbulb,
      bulletPoints: [
        'Visualizza il flusso di lavoro: Rendi visibile tutto il lavoro',
        'Limita il WIP: Completa il lavoro prima di iniziarne di nuovo',
        'Gestisci il flusso: Ottimizza per massimizzare il throughput',
        'Rendi esplicite le policy: Definisci regole chiare',
        'Implementa feedback loops: Migliora continuamente',
        'Migliora collaborativamente: Evolvi sperimentando',
      ],
    ),
    MethodologySection(
      title: 'La Board Kanban',
      content: '''
La board visualizza il flusso di lavoro attraverso le sue fasi.
Ogni colonna rappresenta uno stato del lavoro (es. To Do, In Progress, Done).

Elementi chiave della board:
• Colonne: Stati del workflow
• Card/Ticket: Unità di lavoro
• WIP Limits: Limiti per colonna
• Swimlanes: Raggruppamenti orizzontali (opzionale)
''',
      icon: Icons.view_kanban,
    ),
    MethodologySection(
      title: 'WIP Limits',
      content: '''
I limiti di Work In Progress (WIP) sono il cuore di Kanban.
Limitare il WIP:

• Riduce il context switching
• Evidenzia i colli di bottiglia
• Accelera il throughput
• Migliora la qualità (meno errori da multitasking)
• Aumenta la prevedibilità

Come impostare i WIP limits:
• Inizia con numero membri team × 2 per colonna
• Osserva il flusso e aggiusta
• Il limite "giusto" crea una leggera tensione
''',
      icon: Icons.speed,
    ),
    MethodologySection(
      title: 'Metriche Kanban',
      content: 'Kanban utilizza metriche di flusso per misurare e migliorare il processo.',
      icon: Icons.analytics,
      bulletPoints: [
        'Lead Time: Tempo dalla richiesta al completamento (include attesa)',
        'Cycle Time: Tempo dall\'inizio lavoro al completamento',
        'Throughput: Items completati per unità di tempo',
        'WIP: Quantità di lavoro in corso in ogni momento',
        'Cumulative Flow Diagram (CFD): Visualizza l\'accumulo di lavoro nel tempo',
      ],
    ),
    MethodologySection(
      title: 'Cadenze Kanban',
      content: '''
A differenza di Scrum, Kanban non prescrive eventi fissi.
Tuttavia, cadenze regolari aiutano il miglioramento continuo:

• Standup Meeting: Sincronizzazione quotidiana davanti alla board
• Replenishment Meeting: Prioritizzazione del backlog
• Delivery Planning: Pianificazione delle release
• Service Delivery Review: Review delle metriche
• Risk Review: Analisi dei rischi e impedimenti
• Operations Review: Miglioramento del processo
''',
      icon: Icons.event_repeat,
    ),
  ],
  bestPractices: [
    'Visualizza TUTTO il lavoro, incluso il lavoro nascosto',
    'Rispetta rigorosamente i WIP limits',
    'Focalizzati sul completare, non sull\'iniziare',
    'Usa le metriche per decisioni, non per giudicare le persone',
    'Migliora un passo alla volta',
    'Blocca il nuovo lavoro se il WIP è al limite',
    'Analizza i blocchi e rimuovili rapidamente',
    'Usa swimlanes per priorità o tipologie di lavoro',
  ],
  antiPatterns: [
    'WIP limits troppo alti (o assenti)',
    'Ignorare i blocchi sulla board',
    'Non rispettare i limiti quando "è urgente"',
    'Columns troppo generiche (es. solo To Do/Done)',
    'Non tracciare quando gli items entrano/escono',
    'Usare Kanban solo come task board senza principi',
    'Non analizzare mai il Cumulative Flow Diagram',
    'Troppi swimlanes che complicano la visualizzazione',
  ],
  faqs: [
    FAQ(
      question: 'Come gestire le urgenze in Kanban?',
      answer: 'Crea una swimlane "Expedite" con WIP limit di 1. '
          'Gli items expedite saltano la coda ma devono essere rari. '
          'Se tutto è urgente, niente è urgente.',
    ),
    FAQ(
      question: 'Kanban funziona per lo sviluppo software?',
      answer: 'Assolutamente sì. Kanban è nato in Toyota ma è ampiamente usato nello sviluppo software. '
          'È particolarmente adatto per team di manutenzione, DevOps, e support.',
    ),
    FAQ(
      question: 'Come impostare i WIP limits iniziali?',
      answer: 'Formula di partenza: (membri del team + 1) per colonna. '
          'Osserva per 2 settimane e riduci gradualmente fino a creare una leggera tensione. '
          'Il limite ottimale varia per ogni team e contesto.',
    ),
    FAQ(
      question: 'Quanto tempo serve per vedere risultati con Kanban?',
      answer: 'I primi miglioramenti (visibilità) sono immediati. '
          'Riduzione del Lead Time si vede in 2-4 settimane. '
          'Miglioramenti significativi del processo richiedono 2-3 mesi.',
    ),
  ],
);

// ═══════════════════════════════════════════════════════════════════════════
// HYBRID GUIDE
// ═══════════════════════════════════════════════════════════════════════════

const _hybridGuide = MethodologyGuide(
  framework: AgileFramework.hybrid,
  title: 'Scrumban (Hybrid)',
  overview: '''
Scrumban combina elementi di Scrum e Kanban per creare un approccio flessibile
che si adatta al contesto del team. Mantiene la struttura degli Sprint con
la flessibilità del flusso continuo e i WIP limits.

Scrumban è ideale per:
• Team che vogliono transire da Scrum a Kanban (o viceversa)
• Progetti con mix di feature development e manutenzione
• Team che vogliono Sprint ma con più flessibilità
• Quando Scrum "puro" è troppo rigido per il contesto
''',
  sections: [
    MethodologySection(
      title: 'Da Scrum: Struttura',
      content: 'Scrumban mantiene alcuni elementi strutturati di Scrum per prevedibilità.',
      icon: Icons.calendar_today,
      bulletPoints: [
        'Sprint (opzionale): Iterazioni a tempo fisso per cadenza',
        'Sprint Planning: Selezione del lavoro per il periodo',
        'Retrospettiva: Riflessione e miglioramento',
        'Demo/Review: Condivisione del valore prodotto',
        'Story Points: Per stime e previsioni (opzionale)',
      ],
    ),
    MethodologySection(
      title: 'Da Kanban: Flusso',
      content: 'Scrumban adotta i principi di flusso Kanban per efficienza.',
      icon: Icons.waterfall_chart,
      bulletPoints: [
        'WIP Limits: Limitazione del lavoro in corso',
        'Pull System: Il team "tira" lavoro quando ha capacità',
        'Visualizzazione: Board condivisa e trasparente',
        'Metriche di flusso: Lead Time, Cycle Time, Throughput',
        'Miglioramento continuo: Policy esplicite e sperimentazione',
      ],
    ),
    MethodologySection(
      title: 'Planning su Richiesta',
      content: '''
In Scrumban, il planning può essere "on-demand" invece che a intervalli fissi.

Il planning si attiva quando:
• Il backlog "Ready" scende sotto una soglia
• Serve prioritizzare nuove richieste urgenti
• Un milestone si avvicina

Questo riduce le sessioni di planning quando non necessarie
e permette di reagire più velocemente ai cambiamenti.
''',
      icon: Icons.sync,
    ),
    MethodologySection(
      title: 'Quando Usare Cosa',
      content: '''
Scrumban non è "fare tutto". È scegliere gli elementi giusti per il contesto.

Usa elementi Scrum quando:
• Serve prevedibilità nelle consegne
• Gli stakeholder vogliono demo regolari
• Il team beneficia di ritmo fisso

Usa elementi Kanban quando:
• Il lavoro è imprevedibile (support, bug fixing)
• Serve reattività alle urgenze
• Il focus è sul throughput continuo
''',
      icon: Icons.balance,
    ),
  ],
  bestPractices: [
    'Inizia con ciò che conosci e aggiungi elementi gradualmente',
    'I WIP limits sono non negoziabili, anche con Sprint',
    'Usa Sprint per cadenza, non come commitment rigido',
    'Mantieni la Retrospettiva, è il motore del miglioramento',
    'Le metriche di flusso aiutano più della Velocity pura',
    'Sperimenta con una cosa alla volta',
    'Documenta le policy del team e rivedile regolarmente',
    'Considera swimlanes per separare feature da manutenzione',
  ],
  antiPatterns: [
    'Prendere il peggio di entrambi (rigidità Scrum + caos Kanban)',
    'Eliminare le Retrospettive perché "siamo flessibili"',
    'WIP limits ignorati perché "abbiamo gli Sprint"',
    'Cambiare framework ad ogni Sprint',
    'Non avere nessuna cadenza (né Sprint né altro)',
    'Confondere flessibilità con assenza di regole',
    'Non misurare niente',
    'Troppa complessità per il contesto',
  ],
  faqs: [
    FAQ(
      question: 'Scrumban ha Sprint o no?',
      answer: 'Dipende dal team. Puoi avere Sprint per cadenza (review, planning) '
          'ma permettere flusso continuo di lavoro dentro lo Sprint. '
          'Oppure puoi eliminare gli Sprint e avere solo cadenze Kanban.',
    ),
    FAQ(
      question: 'Come misuro la performance in Scrumban?',
      answer: 'Usa sia metriche Scrum (Velocity se usi Sprint e Story Points) '
          'che metriche Kanban (Lead Time, Cycle Time, Throughput). '
          'Le metriche di flusso sono spesso più utili per il miglioramento.',
    ),
    FAQ(
      question: 'Da dove partire con Scrumban?',
      answer: 'Se vieni da Scrum: aggiungi WIP limits e visualizza il flusso. '
          'Se vieni da Kanban: aggiungi cadenze regolari per review e planning. '
          'Parti da ciò che il team conosce e aggiungi incrementalmente.',
    ),
    FAQ(
      question: 'Scrumban è "meno Agile" di Scrum puro?',
      answer: 'No. Agile non significa seguire un framework specifico. '
          'Scrumban può essere più Agile perché si adatta al contesto. '
          'L\'importante è ispezionare e adattare continuamente.',
    ),
  ],
);
