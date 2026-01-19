import 'package:flutter/material.dart';
import 'legal_document_screen.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'Termini di Servizio',
      lastUpdated: '18 Gennaio 2026',
      mdContent: '''
## 1. Accettazione dei Termini
Accedendo o utilizzando **Keisen**, accetti di essere vincolato da questi Termini di Servizio ("Termini"). Se non accetti questi Termini, non devi utilizzare i nostri Servizi.

## 2. Descrizione del Servizio
Keisen è una piattaforma di collaborazione per team agili che offre strumenti come Smart Todo, Matrice di Eisenhower, Estimation Room e Gestione Processi Agili. Ci riserviamo il diritto di modificare o interrompere il servizio in qualsiasi momento.

## 3. Account Utente
Sei responsabile di mantenere la riservatezza delle credenziali del tuo account e di tutte le attività che avvengono sotto il tuo account. Ci riserviamo il diritto di sospendere o cancellare account che violano questi Termini.

## 4. Comportamento dell'Utente
Accetti di non utilizzare il Servizio per:
- Violare leggi locali, nazionali o internazionali.
- Caricare contenuti offensivi, diffamatori o illegali.
- Tentare di accedere non autorizzato ai sistemi della Piattaforma.

## 5. Proprietà Intellettuale
Tutti i diritti di proprietà intellettuale relativi alla Piattaforma e ai suoi contenuti originali (esclusi i contenuti forniti dagli utenti) sono di proprietà esclusiva di Leonardo Torella.

## 6. Limitazione di Responsabilità
Nella misura massima consentita dalla legge, Keisen viene fornito "così com'è" e "come disponibile". Non garantiamo che il servizio sarà ininterrotto o privo di errori. Non saremo responsabili per danni indiretti, incidentali o consequenziali derivanti dall'uso del servizio.

## 7. Legge Applicabile
Questi Termini sono regolati dalle leggi dello Stato Italiano.

## 8. Contatti
Per domande su questi Termini, contattaci a: support@agiletools.app.
''',
    );
  }
}
