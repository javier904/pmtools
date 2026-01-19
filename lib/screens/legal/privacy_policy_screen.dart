import 'package:flutter/material.dart';
import 'legal_document_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalDocumentScreen(
      title: 'Privacy Policy',
      lastUpdated: '18 Gennaio 2026',
      mdContent: '''
## 1. Introduzione
Benvenuto su **Keisen** ("noi", "nostro", "la Piattaforma"). La tua privacy è importante per noi. Questa Informativa sulla Privacy spiega come raccogliamo, utilizziamo, divulghiamo e proteggiamo le tue informazioni quando utilizzi la nostra applicazione web.

## 2. Dati che raccogliamo
Raccogliamo due tipi di dati e informazioni:

### 2.1 Informazioni fornite dall'utente
- **Dati Account:** Quando accedi tramite Google Sign-In o crei un account, raccogliamo il tuo nome, indirizzo email e immagine del profilo.
- **Contenuti Utente:** Raccogliamo i dati che inserisci volontariamente nella piattaforma, inclusi task, stime, retrospettive, commenti e configurazioni dei team.

### 2.2 Informazioni raccolte automaticamente
- **Log di sistema:** Indirizzi IP, tipo di browser, pagine visitate e timestamp.
- **Cookies:** Utilizziamo cookie tecnici essenziali per mantenere la sessione attiva.

## 3. Come utilizziamo i tuoi dati
Utilizziamo le informazioni raccolte per:
- Fornire, gestire e mantenere i nostri Servizi.
- Migliorare, personalizzare ed espandere la nostra Piattaforma.
- Analizzare come utilizzi il sito web per migliorare l'esperienza utente.
- Inviarti email di servizio (es. inviti ai team, aggiornamenti importanti).

## 4. Condivisione dei dati
Non vendiamo i tuoi dati personali. Condividiamo le informazioni solo con:
- **Service Provider:** Utilizziamo **Google Firebase** (Google LLC) per l'hosting, l'autenticazione e il database. I dati sono trattati secondo la [Privacy Policy di Google](https://policies.google.com/privacy).
- **Obblighi Legali:** Se richiesto dalla legge o per proteggere i nostri diritti.

## 5. Sicurezza dei dati
Implementiamo misure di sicurezza tecniche e organizzative standard del settore (come la crittografia in transito) per proteggere i tuoi dati. Tuttavia, nessun metodo di trasmissione su Internet è sicuro al 100%.

## 6. I tuoi diritti
Hai il diritto di:
- Accedere ai tuoi dati personali.
- Richiedere la correzione di dati inesatti.
- Richiedere la cancellazione dei tuoi dati ("Diritto all'oblio").
- Opporti al trattamento dei tuoi dati.

Per esercitare questi diritti, contattaci a: support@agiletools.app.

## 7. Modifiche a questa Policy
Potremmo aggiornare questa Privacy Policy di volta in volta. Ti notificheremo di eventuali modifiche pubblicando la nuova Policy su questa pagina.
''',
    );
  }
}
