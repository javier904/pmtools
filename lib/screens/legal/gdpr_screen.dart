import 'package:flutter/material.dart';
import 'legal_document_screen.dart';

class GdprScreen extends StatelessWidget {
  const GdprScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'GDPR Compliance',
      lastUpdated: '18 Gennaio 2026',
      mdContent: '''
## Impegno per la Protezione dei Dati (GDPR)
In conformità con il Regolamento Generale sulla Protezione dei Dati (GDPR) dell'Unione Europea, Agile Tools si impegna a proteggere i dati personali degli utenti e a garantire la trasparenza nel loro trattamento.

## Titolare del Trattamento
Il Titolare del Trattamento dei dati è:
**Agile Tools Team**
Email: support@agiletools.app

## Base Giuridica del Trattamento
Trattiamo i tuoi dati personali solo quando abbiamo una base giuridica per farlo. Questo include:
- **Consenso:** Ci hai dato il permesso di trattare i tuoi dati per uno scopo specifico.
- **Esecuzione di un contratto:** Il trattamento è necessario per fornire i Servizi che hai richiesto (es. utilizzo della piattaforma).
- **Interesse legittimo:** Il trattamento è necessario per i nostri legittimi interessi (es. sicurezza, miglioramento del servizio), a meno che non prevalgano i tuoi diritti e libertà fondamentali.

## Trasferimento dei Dati
I tuoi dati sono conservati su server sicuri forniti da Google Cloud Platform (Google Firebase). Google aderisce agli standard di sicurezza internazionali ed è conforme al GDPR attraverso le Clausole Contrattuali Tipo (SCC).

## I Tuoi Diritti GDPR
Come utente nell'UE, hai i seguenti diritti:
1.  **Diritto di accesso:** Hai il diritto di richiedere copie dei tuoi dati personali.
2.  **Diritto di rettifica:** Hai il diritto di richiedere la correzione di informazioni che ritieni inesatte.
3.  **Diritto alla cancellazione ("Diritto all'oblio"):** Hai il diritto di richiedere la cancellazione dei tuoi dati personali, a determinate condizioni.
4.  **Diritto alla limitazione del trattamento:** Hai il diritto di richiedere la limitazione del trattamento dei tuoi dati.
5.  **Diritto alla portabilità dei dati:** Hai il diritto di richiedere il trasferimento dei dati che abbiamo raccolto a un'altra organizzazione o direttamente a te.

## Esercizio dei Diritti
Se desideri esercitare uno di questi diritti, ti preghiamo di contattarci a: support@agiletools.app. Risponderemo alla tua richiesta entro un mese.
''',
    );
  }
}
