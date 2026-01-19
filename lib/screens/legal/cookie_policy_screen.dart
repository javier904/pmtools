import 'package:flutter/material.dart';
import 'legal_document_screen.dart';

class CookiePolicyScreen extends StatelessWidget {
  const CookiePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'Cookie Policy',
      lastUpdated: '18 Gennaio 2026',
      mdContent: '''
## 1. Cosa sono i Cookie?
I cookie sono piccoli file di testo che vengono salvati sul tuo dispositivo quando visiti un sito web. Sono ampiamente utilizzati per far funzionare i siti web in modo più efficiente e fornire informazioni ai proprietari del sito.

## 2. Come utilizziamo i Cookie
Utilizziamo i cookie per diversi scopi:

### 2.1 Cookie Tecnici (Essenziali)
Questi cookie sono necessari per il funzionamento del sito web e non possono essere disattivati nei nostri sistemi. Di solito vengono impostati solo in risposta alle azioni da te effettuate che costituiscono una richiesta di servizi, come l'impostazione delle preferenze di privacy, l'accesso (Login) o la compilazione di moduli.
*Esempio:* Cookie di sessione Firebase Auth per mantenere l'utente loggato.

### 2.2 Cookie di Analisi
Questi cookie ci permettono di contare le visite e le fonti di traffico, in modo da poter misurare e migliorare le prestazioni del nostro sito. Tutte le informazioni raccolte da questi cookie sono aggregate e quindi anonime.

## 3. Gestione dei Cookie
La maggior parte dei browser web consente di controllare la maggior parte dei cookie attraverso le impostazioni del browser. Tuttavia, se disabiliti i cookie essenziali, alcune parti del nostro Servizio potrebbero non funzionare correttamente (ad esempio, non potrai effettuare il login).

## 4. Cookie di Terze Parti
Utilizziamo servizi di terze parti come **Google Firebase** che potrebbero impostare i propri cookie. Ti invitiamo a consultare le rispettive informative sulla privacy per maggiori dettagli.
''',
    );
  }
}
