import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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

  /// Factory per ottenere la guida di una metodologia (localizzata)
  factory MethodologyGuide.forFramework(AgileFramework framework, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (framework) {
      case AgileFramework.scrum:
        return _buildScrumGuide(l10n);
      case AgileFramework.kanban:
        return _buildKanbanGuide(l10n);
      case AgileFramework.hybrid:
        return _buildHybridGuide(l10n);
    }
  }

  /// Lista di tutte le guide disponibili (localizzate)
  static List<MethodologyGuide> getAllGuides(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _buildScrumGuide(l10n),
      _buildKanbanGuide(l10n),
      _buildHybridGuide(l10n),
    ];
  }

  /// Getter legacy per compatibilità (usa lingua default, preferire getAllGuides)
  static List<MethodologyGuide> get allGuides => [
    _buildScrumGuideFallback(),
    _buildKanbanGuideFallback(),
    _buildHybridGuideFallback(),
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
// SCRUM GUIDE (LOCALIZED)
// ═══════════════════════════════════════════════════════════════════════════

MethodologyGuide _buildScrumGuide(AppLocalizations l10n) {
  return MethodologyGuide(
    framework: AgileFramework.scrum,
    title: 'Scrum',
    overview: l10n.scrumOverview,
    sections: [
      MethodologySection(
        title: l10n.scrumRolesTitle,
        content: l10n.scrumRolesContent,
        icon: Icons.people,
        bulletPoints: [
          l10n.scrumRolesPO,
          l10n.scrumRolesSM,
          l10n.scrumRolesDev,
        ],
      ),
      MethodologySection(
        title: l10n.scrumEventsTitle,
        content: l10n.scrumEventsContent,
        icon: Icons.event,
        bulletPoints: [
          l10n.scrumEventsPlanning,
          l10n.scrumEventsDaily,
          l10n.scrumEventsReview,
          l10n.scrumEventsRetro,
        ],
      ),
      MethodologySection(
        title: l10n.scrumArtifactsTitle,
        content: l10n.scrumArtifactsContent,
        icon: Icons.description,
        bulletPoints: [
          l10n.scrumArtifactsPB,
          l10n.scrumArtifactsSB,
          l10n.scrumArtifactsIncrement,
        ],
      ),
      MethodologySection(
        title: l10n.scrumStoryPointsTitle,
        content: l10n.scrumStoryPointsContent,
        icon: Icons.speed,
      ),
    ],
    bestPractices: [
      l10n.scrumBP1,
      l10n.scrumBP2,
      l10n.scrumBP3,
      l10n.scrumBP4,
      l10n.scrumBP5,
      l10n.scrumBP6,
      l10n.scrumBP7,
      l10n.scrumBP8,
    ],
    antiPatterns: [
      l10n.scrumAP1,
      l10n.scrumAP2,
      l10n.scrumAP3,
      l10n.scrumAP4,
      l10n.scrumAP5,
      l10n.scrumAP6,
      l10n.scrumAP7,
      l10n.scrumAP8,
    ],
    faqs: [
      FAQ(question: l10n.scrumFAQ1Q, answer: l10n.scrumFAQ1A),
      FAQ(question: l10n.scrumFAQ2Q, answer: l10n.scrumFAQ2A),
      FAQ(question: l10n.scrumFAQ3Q, answer: l10n.scrumFAQ3A),
      FAQ(question: l10n.scrumFAQ4Q, answer: l10n.scrumFAQ4A),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// KANBAN GUIDE (LOCALIZED)
// ═══════════════════════════════════════════════════════════════════════════

MethodologyGuide _buildKanbanGuide(AppLocalizations l10n) {
  return MethodologyGuide(
    framework: AgileFramework.kanban,
    title: 'Kanban',
    overview: l10n.kanbanOverview,
    sections: [
      MethodologySection(
        title: l10n.kanbanPrinciplesTitle,
        content: l10n.kanbanPrinciplesContent,
        icon: Icons.lightbulb,
        bulletPoints: [
          l10n.kanbanPrinciple1,
          l10n.kanbanPrinciple2,
          l10n.kanbanPrinciple3,
          l10n.kanbanPrinciple4,
          l10n.kanbanPrinciple5,
          l10n.kanbanPrinciple6,
        ],
      ),
      MethodologySection(
        title: l10n.kanbanBoardTitle,
        content: l10n.kanbanBoardContent,
        icon: Icons.view_kanban,
      ),
      MethodologySection(
        title: l10n.kanbanWIPTitle,
        content: l10n.kanbanWIPContent,
        icon: Icons.speed,
      ),
      MethodologySection(
        title: l10n.kanbanMetricsTitle,
        content: l10n.kanbanMetricsContent,
        icon: Icons.analytics,
        bulletPoints: [
          l10n.kanbanMetric1,
          l10n.kanbanMetric2,
          l10n.kanbanMetric3,
          l10n.kanbanMetric4,
          l10n.kanbanMetric5,
        ],
      ),
      MethodologySection(
        title: l10n.kanbanCadencesTitle,
        content: l10n.kanbanCadencesContent,
        icon: Icons.event_repeat,
      ),
      MethodologySection(
        title: l10n.kanbanSwimlanesTitle,
        content: l10n.kanbanSwimlanesContent,
        icon: Icons.view_stream,
      ),
      MethodologySection(
        title: l10n.kanbanGuidePoliciesTitle,
        content: l10n.kanbanPoliciesContent,
        icon: Icons.policy,
      ),
    ],
    bestPractices: [
      l10n.kanbanBP1,
      l10n.kanbanBP2,
      l10n.kanbanBP3,
      l10n.kanbanBP4,
      l10n.kanbanBP5,
      l10n.kanbanBP6,
      l10n.kanbanBP7,
      l10n.kanbanBP8,
    ],
    antiPatterns: [
      l10n.kanbanAP1,
      l10n.kanbanAP2,
      l10n.kanbanAP3,
      l10n.kanbanAP4,
      l10n.kanbanAP5,
      l10n.kanbanAP6,
      l10n.kanbanAP7,
      l10n.kanbanAP8,
    ],
    faqs: [
      FAQ(question: l10n.kanbanFAQ1Q, answer: l10n.kanbanFAQ1A),
      FAQ(question: l10n.kanbanFAQ2Q, answer: l10n.kanbanFAQ2A),
      FAQ(question: l10n.kanbanFAQ3Q, answer: l10n.kanbanFAQ3A),
      FAQ(question: l10n.kanbanFAQ4Q, answer: l10n.kanbanFAQ4A),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HYBRID GUIDE (LOCALIZED)
// ═══════════════════════════════════════════════════════════════════════════

MethodologyGuide _buildHybridGuide(AppLocalizations l10n) {
  return MethodologyGuide(
    framework: AgileFramework.hybrid,
    title: 'Scrumban (Hybrid)',
    overview: l10n.hybridOverview,
    sections: [
      MethodologySection(
        title: l10n.hybridFromScrumTitle,
        content: l10n.hybridFromScrumContent,
        icon: Icons.calendar_today,
        bulletPoints: [
          l10n.hybridFromScrum1,
          l10n.hybridFromScrum2,
          l10n.hybridFromScrum3,
          l10n.hybridFromScrum4,
          l10n.hybridFromScrum5,
        ],
      ),
      MethodologySection(
        title: l10n.hybridFromKanbanTitle,
        content: l10n.hybridFromKanbanContent,
        icon: Icons.waterfall_chart,
        bulletPoints: [
          l10n.hybridFromKanban1,
          l10n.hybridFromKanban2,
          l10n.hybridFromKanban3,
          l10n.hybridFromKanban4,
          l10n.hybridFromKanban5,
        ],
      ),
      MethodologySection(
        title: l10n.hybridOnDemandTitle,
        content: l10n.hybridOnDemandContent,
        icon: Icons.sync,
      ),
      MethodologySection(
        title: l10n.hybridWhenTitle,
        content: l10n.hybridWhenContent,
        icon: Icons.balance,
      ),
    ],
    bestPractices: [
      l10n.hybridBP1,
      l10n.hybridBP2,
      l10n.hybridBP3,
      l10n.hybridBP4,
      l10n.hybridBP5,
      l10n.hybridBP6,
      l10n.hybridBP7,
      l10n.hybridBP8,
    ],
    antiPatterns: [
      l10n.hybridAP1,
      l10n.hybridAP2,
      l10n.hybridAP3,
      l10n.hybridAP4,
      l10n.hybridAP5,
      l10n.hybridAP6,
      l10n.hybridAP7,
      l10n.hybridAP8,
    ],
    faqs: [
      FAQ(question: l10n.hybridFAQ1Q, answer: l10n.hybridFAQ1A),
      FAQ(question: l10n.hybridFAQ2Q, answer: l10n.hybridFAQ2A),
      FAQ(question: l10n.hybridFAQ3Q, answer: l10n.hybridFAQ3A),
      FAQ(question: l10n.hybridFAQ4Q, answer: l10n.hybridFAQ4A),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// FALLBACK GUIDES (Italian hardcoded for legacy compatibility)
// ═══════════════════════════════════════════════════════════════════════════

MethodologyGuide _buildScrumGuideFallback() {
  return const MethodologyGuide(
    framework: AgileFramework.scrum,
    title: 'Scrum',
    overview: '''Scrum è un framework Agile iterativo e incrementale per la gestione dello sviluppo prodotto.
Si basa su cicli di lavoro a tempo fisso chiamati Sprint, tipicamente di 2-4 settimane.

Scrum è ideale per:
• Team che lavorano su prodotti con requisiti che evolvono
• Progetti che beneficiano di feedback regolare
• Organizzazioni che vogliono migliorare prevedibilità e trasparenza''',
    sections: [],
    bestPractices: [],
    antiPatterns: [],
    faqs: [],
  );
}

MethodologyGuide _buildKanbanGuideFallback() {
  return const MethodologyGuide(
    framework: AgileFramework.kanban,
    title: 'Kanban',
    overview: '''Kanban è un metodo per gestire il lavoro che enfatizza la visualizzazione del flusso,
la limitazione del Work In Progress (WIP) e il miglioramento continuo del processo.

Kanban è ideale per:
• Team di supporto/manutenzione con richieste continue
• Ambienti dove le priorità cambiano frequentemente
• Quando non è possibile pianificare in iterazioni fisse
• Transizione graduale verso l'Agile''',
    sections: [],
    bestPractices: [],
    antiPatterns: [],
    faqs: [],
  );
}

MethodologyGuide _buildHybridGuideFallback() {
  return const MethodologyGuide(
    framework: AgileFramework.hybrid,
    title: 'Scrumban (Hybrid)',
    overview: '''Scrumban combina elementi di Scrum e Kanban per creare un approccio flessibile
che si adatta al contesto del team. Mantiene la struttura degli Sprint con
la flessibilità del flusso continuo e i WIP limits.

Scrumban è ideale per:
• Team che vogliono transire da Scrum a Kanban (o viceversa)
• Progetti con mix di feature development e manutenzione
• Team che vogliono Sprint ma con più flessibilità
• Quando Scrum "puro" è troppo rigido per il contesto''',
    sections: [],
    bestPractices: [],
    antiPatterns: [],
    faqs: [],
  );
}
