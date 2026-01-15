# Piano di Produzione - Agile Tools

## Executive Summary

Questo documento definisce il piano completo per portare Agile Tools in produzione. L'analisi del codebase ha identificato **3 blockers critici** e diverse aree di miglioramento organizzate per priorità.

**Stato attuale**: MVP funzionante, NON pronto per produzione pubblica
**Target**: Produzione enterprise-ready con compliance GDPR

---

# FASE 1: BLOCKERS CRITICI

---

## 1.1 FIRESTORE SECURITY RULES

### Descrizione
Il database Firestore è attualmente **completamente aperto**. Non esistono regole di sicurezza, il che significa che chiunque con l'URL del progetto Firebase può leggere, modificare o cancellare TUTTI i dati di TUTTI gli utenti. Questo è il rischio di sicurezza più grave dell'applicazione.

### Rischio Attuale
- **Severità**: CRITICA
- **Impatto**: Violazione dati completa, perdita dati, manipolazione dati
- **Probabilità**: Alta (basta conoscere il project ID)

### Effort Stimato
4-6 ore

### Checklist Dettagliata

#### 1.1.1 Analisi Collections Esistenti
- [ ] **Mappare tutte le collections Firestore**
  - **Cosa fare**: Elencare ogni collection/subcollection usata nell'app
  - **Come**: Cercare tutti i `.collection()` nel codice
  - **Dettaglio**:
    - `planning_poker_sessions` + subcollections `stories`, `votes`
    - `eisenhower_matrices` + subcollection `activities`
    - `agile_projects` + subcollections `stories`, `sprints`, `retrospectives`
    - `users`
    - `invites` (eisenhower_invites, planning_poker_invites, agile_invites)
  - **Criterio completamento**: Documento con lista completa collections e loro struttura

#### 1.1.2 Definire Modello di Accesso
- [ ] **Documentare chi può accedere a cosa**
  - **Cosa fare**: Per ogni collection, definire regole CRUD
  - **Dettaglio**:
    | Collection | Create | Read | Update | Delete |
    |------------|--------|------|--------|--------|
    | users | Auth user (self) | Self only | Self only | Self only |
    | planning_poker_sessions | Any auth user | Owner + participants | Owner only | Owner only |
    | eisenhower_matrices | Any auth user | Owner + participants | Owner + participants | Owner only |
    | agile_projects | Any auth user | Owner + team | Owner + team | Owner only |
    | invites | Any auth user | Anyone (for token validation) | Inviter only | Inviter only |
  - **Criterio completamento**: Tabella completa approvata

#### 1.1.3 Creare File firestore.rules
- [ ] **Creare file `firestore.rules` nella root del progetto**
  - **Cosa fare**: Scrivere le regole di sicurezza
  - **Dettaglio implementativo**:
  ```javascript
  rules_version = '2';
  service cloud.firestore {
    match /databases/{database}/documents {

      // ========== HELPER FUNCTIONS ==========

      // Verifica che l'utente sia autenticato
      function isAuthenticated() {
        return request.auth != null;
      }

      // Ottiene l'email dell'utente autenticato
      function userEmail() {
        return request.auth.token.email;
      }

      // Verifica che l'utente sia il proprietario (campo ownerEmail o createdBy)
      function isOwner(resource) {
        return userEmail() == resource.data.ownerEmail ||
               userEmail() == resource.data.createdBy;
      }

      // Verifica che l'utente sia un partecipante
      function isParticipant(resource) {
        return userEmail() in resource.data.participants.keys();
      }

      // Verifica owner o partecipante
      function isOwnerOrParticipant(resource) {
        return isOwner(resource) || isParticipant(resource);
      }

      // ========== USER PROFILES ==========

      match /users/{odataId} {
        // Gli utenti possono solo leggere/scrivere il proprio profilo
        allow read: if isAuthenticated() && userEmail() == odataId;
        allow create: if isAuthenticated() && userEmail() == odataId;
        allow update: if isAuthenticated() && userEmail() == odataId;
        allow delete: if isAuthenticated() && userEmail() == odataId;
      }

      // ========== PLANNING POKER ==========

      match /planning_poker_sessions/{sessionId} {
        // Lettura: owner o partecipanti
        allow read: if isAuthenticated() && isOwnerOrParticipant(resource);

        // Creazione: qualsiasi utente autenticato
        allow create: if isAuthenticated() &&
                        request.resource.data.createdBy == userEmail();

        // Aggiornamento: owner o partecipanti (per votare)
        allow update: if isAuthenticated() && isOwnerOrParticipant(resource);

        // Cancellazione: solo owner
        allow delete: if isAuthenticated() && isOwner(resource);

        // Subcollection: stories
        match /stories/{storyId} {
          allow read: if isAuthenticated() &&
                        isOwnerOrParticipant(get(/databases/$(database)/documents/planning_poker_sessions/$(sessionId)));
          allow write: if isAuthenticated() &&
                         isOwnerOrParticipant(get(/databases/$(database)/documents/planning_poker_sessions/$(sessionId)));
        }
      }

      // ========== EISENHOWER MATRICES ==========

      match /eisenhower_matrices/{matrixId} {
        allow read: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow create: if isAuthenticated() &&
                        request.resource.data.ownerEmail == userEmail();
        allow update: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow delete: if isAuthenticated() && isOwner(resource);

        // Subcollection: activities
        match /activities/{activityId} {
          allow read, write: if isAuthenticated() &&
                               isOwnerOrParticipant(get(/databases/$(database)/documents/eisenhower_matrices/$(matrixId)));
        }
      }

      // ========== AGILE PROJECTS ==========

      match /agile_projects/{projectId} {
        allow read: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow create: if isAuthenticated() &&
                        request.resource.data.createdBy == userEmail();
        allow update: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow delete: if isAuthenticated() && isOwner(resource);

        // Subcollections
        match /{subcollection}/{docId} {
          allow read, write: if isAuthenticated() &&
                               isOwnerOrParticipant(get(/databases/$(database)/documents/agile_projects/$(projectId)));
        }
      }

      // ========== INVITES ==========

      // Planning Poker Invites
      match /planning_poker_invites/{inviteId} {
        // Lettura pubblica per validazione token
        allow read: if true;
        allow create: if isAuthenticated();
        allow update, delete: if isAuthenticated() &&
                                resource.data.invitedBy == userEmail();
      }

      // Eisenhower Invites
      match /eisenhower_invites/{inviteId} {
        allow read: if true;
        allow create: if isAuthenticated();
        allow update, delete: if isAuthenticated() &&
                                resource.data.invitedBy == userEmail();
      }

      // Agile Invites
      match /agile_invites/{inviteId} {
        allow read: if true;
        allow create: if isAuthenticated();
        allow update, delete: if isAuthenticated() &&
                                resource.data.invitedBy == userEmail();
      }

      // ========== SMART TODO ==========

      match /smart_todo_lists/{listId} {
        allow read: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow create: if isAuthenticated() &&
                        request.resource.data.ownerEmail == userEmail();
        allow update: if isAuthenticated() && isOwnerOrParticipant(resource);
        allow delete: if isAuthenticated() && isOwner(resource);

        match /items/{itemId} {
          allow read, write: if isAuthenticated() &&
                               isOwnerOrParticipant(get(/databases/$(database)/documents/smart_todo_lists/$(listId)));
        }
      }
    }
  }
  ```
  - **Criterio completamento**: File creato e sintatticamente valido

#### 1.1.4 Configurare firebase.json
- [ ] **Aggiungere riferimento alle rules in firebase.json**
  - **Cosa fare**: Aggiungere sezione firestore al file
  - **Dettaglio**:
  ```json
  {
    "firestore": {
      "rules": "firestore.rules",
      "indexes": "firestore.indexes.json"
    },
    "hosting": { ... }
  }
  ```
  - **Criterio completamento**: firebase.json aggiornato

#### 1.1.5 Test con Firebase Emulator
- [ ] **Testare le regole localmente**
  - **Cosa fare**: Usare Firebase Emulator per testare le regole
  - **Comandi**:
  ```bash
  firebase emulators:start --only firestore
  ```
  - **Test da eseguire**:
    - [ ] Utente non autenticato NON può leggere nulla (eccetto invites)
    - [ ] Utente A NON può leggere sessioni di Utente B
    - [ ] Utente A PUO' leggere sessioni dove è partecipante
    - [ ] Solo owner può cancellare
    - [ ] Inviti sono leggibili pubblicamente
  - **Criterio completamento**: Tutti i test passano

#### 1.1.6 Test con Rules Playground
- [ ] **Testare le regole nella Firebase Console**
  - **Cosa fare**: Usare Rules Playground per simulare accessi
  - **Come**: Firebase Console → Firestore → Rules → Rules Playground
  - **Scenari da testare**:
    - GET /users/user@example.com con auth user@example.com → ALLOW
    - GET /users/other@example.com con auth user@example.com → DENY
    - GET /planning_poker_sessions/xxx senza auth → DENY
  - **Criterio completamento**: Screenshot di test passati

#### 1.1.7 Deploy Rules
- [ ] **Deployare le regole in produzione**
  - **Comando**:
  ```bash
  firebase deploy --only firestore:rules
  ```
  - **Verifica post-deploy**:
    - Controllare in Firebase Console che le regole siano attive
    - Testare l'app (login, creare sessione, invitare)
  - **Criterio completamento**: Rules deployate e app funzionante

#### 1.1.8 Documentazione
- [ ] **Documentare le regole implementate**
  - **Cosa fare**: Creare documento con spiegazione regole
  - **Contenuto**: Tabella permessi, eccezioni, note per futuri sviluppatori
  - **Criterio completamento**: Documento SECURITY_RULES.md creato

### Criteri di Completamento Fase 1.1
- [x] File `firestore.rules` creato e deployato
- [x] Tutti i test manuali passati
- [x] App funzionante con regole attive
- [x] Nessun utente può accedere a dati di altri utenti
- [x] Documentazione completata

---

## 1.2 LEGAL COMPLIANCE (Privacy & Terms)

### Descrizione
L'applicazione raccoglie e processa dati personali (email, nomi, dati di sessioni) ma non ha alcuna informativa legale. Questo viola il GDPR e altre normative sulla privacy, esponendo a rischi legali significativi.

### Rischio Attuale
- **Severità**: CRITICA
- **Impatto**: Sanzioni GDPR fino a 20M€ o 4% fatturato, cause legali
- **Probabilità**: Media-Alta (compliance check sempre più frequenti)

### Effort Stimato
6-8 ore

### Checklist Dettagliata

#### 1.2.1 Privacy Policy
- [ ] **Creare pagina Privacy Policy**
  - **Cosa fare**: Creare screen Flutter con testo completo privacy policy
  - **File da creare**: `lib/screens/legal/privacy_policy_screen.dart`
  - **Contenuto obbligatorio**:

    **Sezione 1: Titolare del Trattamento**
    - Nome/ragione sociale
    - Indirizzo
    - Email contatto
    - PEC (se azienda italiana)

    **Sezione 2: Dati Raccolti**
    - Email (per autenticazione)
    - Nome visualizzato (opzionale)
    - Foto profilo (da Google)
    - Dati sessioni (matrici, stime, progetti)
    - Log di accesso (timestamp, IP)
    - Preferenze app (tema, lingua)

    **Sezione 3: Finalità del Trattamento**
    - Erogazione del servizio
    - Autenticazione utente
    - Comunicazioni di servizio
    - Miglioramento del servizio
    - (Se previsto) Marketing

    **Sezione 4: Base Giuridica**
    - Consenso (art. 6.1.a GDPR)
    - Esecuzione contratto (art. 6.1.b GDPR)
    - Legittimo interesse (art. 6.1.f GDPR)

    **Sezione 5: Destinatari dei Dati**
    - Google (Firebase, Authentication)
    - Nessuna vendita a terzi

    **Sezione 6: Trasferimento Extra-UE**
    - Firebase servers (USA) - Standard Contractual Clauses

    **Sezione 7: Periodo di Conservazione**
    - Dati account: fino a cancellazione
    - Dati sessioni: fino a cancellazione sessione
    - Log: 12 mesi

    **Sezione 8: Diritti dell'Interessato**
    - Accesso (art. 15)
    - Rettifica (art. 16)
    - Cancellazione (art. 17)
    - Limitazione (art. 18)
    - Portabilità (art. 20)
    - Opposizione (art. 21)
    - Revoca consenso
    - Reclamo al Garante

    **Sezione 9: Contatti**
    - Email per richieste privacy
    - Tempo di risposta (30 giorni)

  - **Criterio completamento**: Pagina creata, raggiungibile da `/privacy`, testo completo

#### 1.2.2 Terms of Service
- [ ] **Creare pagina Termini di Servizio**
  - **Cosa fare**: Creare screen Flutter con termini completi
  - **File da creare**: `lib/screens/legal/terms_of_service_screen.dart`
  - **Contenuto obbligatorio**:

    **Sezione 1: Accettazione**
    - Uso del servizio implica accettazione
    - Modifiche ai termini (con preavviso)

    **Sezione 2: Descrizione del Servizio**
    - Cosa offre Agile Tools
    - Funzionalità disponibili

    **Sezione 3: Account Utente**
    - Requisiti (età minima 16 anni per GDPR)
    - Responsabilità credenziali
    - Un account per persona

    **Sezione 4: Uso Accettabile**
    - Usi consentiti
    - Usi vietati (spam, abuso, contenuti illegali)

    **Sezione 5: Proprietà Intellettuale**
    - Il servizio è di proprietà del titolare
    - I dati utente restano dell'utente
    - Licenza d'uso limitata

    **Sezione 6: Contenuti Utente**
    - L'utente è responsabile dei propri contenuti
    - Diritto di rimozione contenuti inappropriati

    **Sezione 7: Disponibilità del Servizio**
    - "As is" - nessuna garanzia uptime
    - Manutenzione programmata

    **Sezione 8: Limitazione Responsabilità**
    - Esclusione danni indiretti
    - Limite massimo responsabilità

    **Sezione 9: Risoluzione**
    - Diritto di terminare account
    - Effetti della terminazione

    **Sezione 10: Legge Applicabile**
    - Legge italiana
    - Foro competente (es. Milano)

    **Sezione 11: Contatti**
    - Email supporto

  - **Criterio completamento**: Pagina creata, raggiungibile da `/terms`, testo completo

#### 1.2.3 Cookie Policy
- [ ] **Creare pagina Cookie Policy**
  - **Cosa fare**: Creare screen con dettaglio cookie utilizzati
  - **File da creare**: `lib/screens/legal/cookie_policy_screen.dart`
  - **Contenuto**:

    **Cookie Tecnici (sempre attivi)**
    - `firebase-auth-token`: autenticazione (sessione)
    - `theme_preference`: preferenza tema (persistente)
    - `locale`: preferenza lingua (persistente)

    **Cookie Analytics (se implementati)**
    - Google Analytics: _ga, _gid, etc.
    - Finalità: statistiche anonime
    - Durata: varia

    **Come disabilitare**
    - Istruzioni per browser principali
    - Conseguenze disabilitazione

  - **Criterio completamento**: Pagina creata, raggiungibile da `/cookies`

#### 1.2.4 Creare Routing Legal
- [ ] **Aggiungere routes per pagine legali**
  - **Cosa fare**: Configurare routes in main.dart
  - **Dettaglio**:
  ```dart
  '/privacy': (context) => const PrivacyPolicyScreen(),
  '/terms': (context) => const TermsOfServiceScreen(),
  '/cookies': (context) => const CookiePolicyScreen(),
  ```
  - **Criterio completamento**: Routes funzionanti

#### 1.2.5 Link nel Footer/Menu
- [ ] **Aggiungere link alle pagine legali**
  - **Cosa fare**: Aggiungere link in posizioni accessibili
  - **Posizioni**:
    - Login screen (sotto il form)
    - Home screen (footer o menu)
    - Drawer/Settings
  - **Criterio completamento**: Link visibili e funzionanti da ogni punto dell'app

#### 1.2.6 Cookie Consent Banner
- [ ] **Implementare banner consenso cookie**
  - **Cosa fare**: Creare widget banner che appare al primo accesso
  - **File da creare**: `lib/widgets/cookie_consent_banner.dart`
  - **Comportamento**:
    - Mostrare al primo accesso (controllare SharedPreferences)
    - Opzioni: "Accetta tutti", "Solo necessari", "Personalizza"
    - Salvare scelta in SharedPreferences
    - Non mostrare più dopo scelta
  - **Dettaglio implementativo**:
  ```dart
  class CookieConsentBanner extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        // Banner fisso in basso
        // Testo: "Utilizziamo cookie per migliorare l'esperienza..."
        // Bottoni: Accetta / Rifiuta / Personalizza
        // Link a Cookie Policy
      );
    }
  }
  ```
  - **Criterio completamento**: Banner funzionante, scelta salvata, non riappare

#### 1.2.7 Consenso in Registrazione
- [ ] **Aggiungere checkbox consenso nel form registrazione**
  - **Cosa fare**: Modificare login_screen.dart per aggiungere checkbox
  - **Dettaglio**:
    - Checkbox: "Ho letto e accetto la Privacy Policy e i Termini di Servizio"
    - Link cliccabili a Privacy Policy e Terms
    - Registrazione bloccata se non spuntato
    - Salvare timestamp consenso in Firestore (`users/{email}/consentTimestamp`)
  - **Criterio completamento**: Checkbox presente, obbligatorio, timestamp salvato

#### 1.2.8 Funzionalità "Elimina Account"
- [ ] **Implementare cancellazione account GDPR-compliant**
  - **Cosa fare**: Creare funzionalità per eliminare tutti i dati utente
  - **File da creare/modificare**: `lib/services/gdpr_service.dart`
  - **Dati da eliminare**:
    - Documento utente in `users`
    - Sessioni create dall'utente (o trasferire ownership)
    - Partecipazioni (rimuovere da participants)
    - Matrici Eisenhower create
    - Progetti Agile creati
    - Inviti inviati
  - **Flusso**:
    1. Utente clicca "Elimina account" in Settings
    2. Conferma con password o re-autenticazione
    3. Mostrare avviso: "Questa azione è irreversibile"
    4. Seconda conferma
    5. Eseguire cancellazione
    6. Logout automatico
  - **Criterio completamento**: Funzionalità completa, tutti i dati eliminati

#### 1.2.9 Funzionalità "Esporta Dati"
- [ ] **Implementare export dati (portabilità)**
  - **Cosa fare**: Permettere download di tutti i dati utente
  - **Formato**: JSON
  - **Dati da includere**:
    - Profilo utente
    - Sessioni create
    - Voti espressi
    - Matrici create
    - Attività create
  - **Criterio completamento**: Download JSON funzionante con tutti i dati

### Criteri di Completamento Fase 1.2
- [x] Privacy Policy pubblicata e accessibile
- [x] Terms of Service pubblicati e accessibili
- [x] Cookie Policy pubblicata
- [x] Cookie consent banner funzionante
- [x] Checkbox consenso in registrazione
- [x] Funzionalità elimina account
- [x] Funzionalità esporta dati
- [x] Link legali visibili in tutta l'app

---

## 1.3 RIMOZIONE DEBUG LOGGING

### Descrizione
Il codice contiene **630 istruzioni `print()`** usate per debug durante lo sviluppo. In produzione, questi log appaiono nella console del browser, esponendo informazioni interne dell'applicazione e potenzialmente dati sensibili.

### Rischio Attuale
- **Severità**: ALTA
- **Impatto**: Esposizione informazioni interne, aiuto per attaccanti
- **Probabilità**: Certa (chiunque può aprire DevTools)

### Effort Stimato
2-3 ore

### Checklist Dettagliata

#### 1.3.1 Creare Logger Utility
- [ ] **Creare classe logger centralizzata**
  - **Cosa fare**: Creare utility che logga solo in debug mode
  - **File da creare**: `lib/utils/app_logger.dart`
  - **Implementazione**:
  ```dart
  import 'package:flutter/foundation.dart';

  /// Logger centralizzato per l'applicazione.
  /// In production mode, i log debug/info sono disabilitati.
  class AppLogger {
    static const String _tag = 'AgileTools';

    /// Log per debug (solo in development)
    static void debug(String message, [String? tag]) {
      if (kDebugMode) {
        debugPrint('[$_tag${tag != null ? ':$tag' : ''}] $message');
      }
    }

    /// Log informativo (solo in development)
    static void info(String message, [String? tag]) {
      if (kDebugMode) {
        debugPrint('[INFO:$_tag${tag != null ? ':$tag' : ''}] $message');
      }
    }

    /// Log warning (sempre attivo)
    static void warning(String message, [String? tag]) {
      debugPrint('[WARN:$_tag${tag != null ? ':$tag' : ''}] $message');
    }

    /// Log errore (sempre attivo, da inviare a Crashlytics)
    static void error(String message, [Object? error, StackTrace? stackTrace]) {
      debugPrint('[ERROR:$_tag] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null && kDebugMode) {
        debugPrint('Stack: $stackTrace');
      }
      // TODO: In production, inviare a Firebase Crashlytics
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }
  ```
  - **Criterio completamento**: File creato, importabile

#### 1.3.2 Inventario Print Statements
- [ ] **Identificare tutti i print() nel codice**
  - **Cosa fare**: Cercare tutte le occorrenze di print
  - **Comando**:
  ```bash
  grep -rn "print(" lib/ --include="*.dart" | wc -l
  ```
  - **Output atteso**: ~630 occorrenze
  - **Categorizzare per tipo**:
    - Debug temporaneo (da rimuovere)
    - Info utile (da convertire in AppLogger.debug)
    - Errori (da convertire in AppLogger.error)
  - **Criterio completamento**: Lista completa con categorizzazione

#### 1.3.3 Sostituire Print in Services
- [ ] **Convertire print() in AppLogger nei services**
  - **File da modificare**:
    - `lib/services/auth_service.dart`
    - `lib/services/planning_poker_firestore_service.dart`
    - `lib/services/eisenhower_firestore_service.dart`
    - `lib/services/agile_firestore_service.dart`
    - Altri services...
  - **Pattern di sostituzione**:
  ```dart
  // PRIMA
  print('🎯 [Auth] Login successful');

  // DOPO
  AppLogger.debug('Login successful', 'Auth');
  ```
  - **Criterio completamento**: Zero print() nei services

#### 1.3.4 Sostituire Print negli Screens
- [ ] **Convertire print() in AppLogger negli screens**
  - **File da modificare**:
    - `lib/screens/estimation_room_screen.dart`
    - `lib/screens/eisenhower_screen.dart`
    - `lib/screens/agile_process_screen.dart`
    - Altri screens...
  - **Criterio completamento**: Zero print() negli screens

#### 1.3.5 Sostituire Print nei Widgets
- [ ] **Convertire print() in AppLogger nei widgets**
  - **Directories**:
    - `lib/widgets/estimation_room/`
    - `lib/widgets/eisenhower/`
    - `lib/widgets/agile/`
  - **Criterio completamento**: Zero print() nei widgets

#### 1.3.6 Rimuovere Emoji dai Log
- [ ] **Rimuovere emoji decorative dai messaggi di log**
  - **Cosa fare**: Rimuovere 🎯, ✅, ❌, 🔄, etc. dai messaggi
  - **Motivo**: Professionalità, compatibilità log aggregator
  - **Pattern**:
  ```dart
  // PRIMA
  print('🎯 [Session] Creating new session...');

  // DOPO
  AppLogger.debug('Creating new session', 'Session');
  ```
  - **Criterio completamento**: Zero emoji nei log

#### 1.3.7 Verifica Finale
- [ ] **Verificare che non ci siano più print() diretti**
  - **Comando**:
  ```bash
  grep -rn "print(" lib/ --include="*.dart"
  ```
  - **Output atteso**: 0 risultati (o solo in AppLogger stesso)
  - **Criterio completamento**: Nessun print() diretto nel codice

#### 1.3.8 Test in Release Mode
- [ ] **Testare che i log non appaiano in release**
  - **Cosa fare**: Build in release e verificare console browser
  - **Comandi**:
  ```bash
  flutter build web --release
  firebase serve --only hosting
  ```
  - **Verifica**: Aprire DevTools → Console → Nessun log debug visibile
  - **Criterio completamento**: Console pulita in production

### Criteri di Completamento Fase 1.3
- [x] AppLogger utility creato
- [x] Zero print() diretti nel codice (escluso AppLogger)
- [x] Zero emoji nei messaggi di log
- [x] Console pulita in release mode
- [x] Errori ancora loggati (per debugging futuro)

---

# FASE 2: SICUREZZA AVANZATA

---

## 2.1 SECURE HEADERS

### Descrizione
Le response HTTP dell'applicazione non includono header di sicurezza standard. Questo espone a rischi come clickjacking, XSS, MIME sniffing e altri attacchi comuni.

### Rischio Attuale
- **Severità**: MEDIA-ALTA
- **Impatto**: Vulnerabilità a attacchi comuni
- **Probabilità**: Media

### Effort Stimato
1-2 ore

### Checklist Dettagliata

#### 2.1.1 Configurare X-Frame-Options
- [ ] **Aggiungere header anti-clickjacking**
  - **Cosa fare**: Impedire embedding in iframe esterni
  - **Header**: `X-Frame-Options: DENY`
  - **Criterio completamento**: Header presente in response

#### 2.1.2 Configurare X-Content-Type-Options
- [ ] **Aggiungere header anti-MIME sniffing**
  - **Header**: `X-Content-Type-Options: nosniff`
  - **Criterio completamento**: Header presente

#### 2.1.3 Configurare X-XSS-Protection
- [ ] **Aggiungere protezione XSS browser**
  - **Header**: `X-XSS-Protection: 1; mode=block`
  - **Criterio completamento**: Header presente

#### 2.1.4 Configurare Referrer-Policy
- [ ] **Controllare informazioni referrer**
  - **Header**: `Referrer-Policy: strict-origin-when-cross-origin`
  - **Criterio completamento**: Header presente

#### 2.1.5 Configurare Permissions-Policy
- [ ] **Disabilitare API non necessarie**
  - **Header**: `Permissions-Policy: geolocation=(), microphone=(), camera=()`
  - **Criterio completamento**: Header presente

#### 2.1.6 Configurare Content-Security-Policy
- [ ] **Implementare CSP completa**
  - **Cosa fare**: Definire policy per risorse caricabili
  - **Header**:
  ```
  Content-Security-Policy:
    default-src 'self';
    script-src 'self' 'unsafe-inline' 'unsafe-eval' https://apis.google.com https://www.gstatic.com;
    style-src 'self' 'unsafe-inline' https://fonts.googleapis.com;
    font-src 'self' https://fonts.gstatic.com;
    img-src 'self' data: https:;
    connect-src 'self' https://*.googleapis.com https://*.firebaseio.com https://*.cloudfunctions.net wss://*.firebaseio.com;
  ```
  - **Criterio completamento**: Header presente, app funzionante

#### 2.1.7 Aggiornare firebase.json
- [ ] **Aggiungere tutti gli headers a firebase.json**
  - **File da modificare**: `firebase.json`
  - **Configurazione completa**:
  ```json
  {
    "hosting": {
      "public": "build/web",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "headers": [
        {
          "source": "**",
          "headers": [
            {"key": "X-Frame-Options", "value": "DENY"},
            {"key": "X-Content-Type-Options", "value": "nosniff"},
            {"key": "X-XSS-Protection", "value": "1; mode=block"},
            {"key": "Referrer-Policy", "value": "strict-origin-when-cross-origin"},
            {"key": "Permissions-Policy", "value": "geolocation=(), microphone=(), camera=()"}
          ]
        },
        {
          "source": "**/*.js",
          "headers": [
            {"key": "Cache-Control", "value": "no-cache, no-store, must-revalidate"}
          ]
        },
        {
          "source": "index.html",
          "headers": [
            {"key": "Cache-Control", "value": "no-cache, no-store, must-revalidate"}
          ]
        }
      ],
      "rewrites": [
        {"source": "**", "destination": "/index.html"}
      ]
    }
  }
  ```
  - **Criterio completamento**: firebase.json aggiornato

#### 2.1.8 Verificare Headers
- [ ] **Testare che gli headers siano presenti**
  - **Cosa fare**: Deployare e verificare con DevTools o curl
  - **Comando test**:
  ```bash
  curl -I https://pm-agile-tools-app.web.app
  ```
  - **Criterio completamento**: Tutti gli headers visibili in response

### Criteri di Completamento Fase 2.1
- [x] Tutti i 6 security headers configurati
- [x] firebase.json aggiornato e deployato
- [x] Headers verificati in produzione
- [x] App funzionante con headers attivi

---

## 2.2 CRASH REPORTING

### Descrizione
L'applicazione non ha un sistema di crash reporting. Gli errori in produzione vanno persi, rendendo impossibile identificare e risolvere problemi che affliggono gli utenti reali.

### Rischio Attuale
- **Severità**: MEDIA
- **Impatto**: Impossibilità di debugging in produzione
- **Probabilità**: Certa (errori avverranno)

### Effort Stimato
2-3 ore

### Checklist Dettagliata

#### 2.2.1 Aggiungere Dipendenza Firebase Crashlytics
- [ ] **Aggiungere package a pubspec.yaml**
  - **Cosa fare**: Aggiungere firebase_crashlytics
  - **Dettaglio**:
  ```yaml
  dependencies:
    firebase_crashlytics: ^3.5.0
  ```
  - **Comando**: `flutter pub get`
  - **Criterio completamento**: Package installato senza errori

#### 2.2.2 Configurare Crashlytics in main.dart
- [ ] **Inizializzare Crashlytics all'avvio**
  - **Cosa fare**: Configurare handler globali per errori
  - **Codice da aggiungere in main()**:
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Configurare Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Errori async non catturati
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    runApp(const MyApp());
  }
  ```
  - **Criterio completamento**: Crashlytics inizializzato

#### 2.2.3 Aggiungere User Context
- [ ] **Inviare informazioni utente con i crash**
  - **Cosa fare**: Settare user ID quando l'utente fa login
  - **Codice in AuthService dopo login**:
  ```dart
  FirebaseCrashlytics.instance.setUserIdentifier(user.email ?? 'anonymous');
  ```
  - **Criterio completamento**: User ID presente nei crash reports

#### 2.2.4 Test Crash Report
- [ ] **Verificare che i crash vengano inviati**
  - **Cosa fare**: Forzare un crash di test
  - **Codice test** (da rimuovere dopo):
  ```dart
  ElevatedButton(
    onPressed: () => FirebaseCrashlytics.instance.crash(),
    child: Text('Test Crash'),
  )
  ```
  - **Verifica**: Controllare Firebase Console → Crashlytics
  - **Criterio completamento**: Crash visibile in console

#### 2.2.5 Configurare Alert
- [ ] **Configurare notifiche per crash critici**
  - **Cosa fare**: In Firebase Console, configurare alert email
  - **Dove**: Firebase Console → Crashlytics → Settings → Alerts
  - **Configurare**: Email quando crash rate supera soglia
  - **Criterio completamento**: Alert configurato

#### 2.2.6 Integrare con AppLogger
- [ ] **Collegare AppLogger.error() a Crashlytics**
  - **Cosa fare**: Modificare AppLogger per inviare errori a Crashlytics
  - **Codice**:
  ```dart
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message');
    if (!kDebugMode && error != null) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace ?? StackTrace.current,
        reason: message,
      );
    }
  }
  ```
  - **Criterio completamento**: Errori loggati arrivano a Crashlytics

### Criteri di Completamento Fase 2.2
- [x] Firebase Crashlytics configurato
- [x] Errori Flutter catturati automaticamente
- [x] User ID incluso nei report
- [x] Test crash verificato in console
- [x] Alert email configurato

---

## 2.3 INPUT VALIDATION AVANZATA

### Descrizione
La validazione input attuale è basilare (controlli isEmpty, trim). Manca validazione per lunghezza massima, caratteri speciali, e sanitizzazione per prevenire injection.

### Rischio Attuale
- **Severità**: MEDIA
- **Impatto**: Potenziale injection, DoS via input lunghi
- **Probabilità**: Bassa-Media

### Effort Stimato
3-4 ore

### Checklist Dettagliata

#### 2.3.1 Creare Validatori Centralizzati
- [ ] **Creare classe con validatori riutilizzabili**
  - **File da creare**: `lib/utils/validators.dart`
  - **Implementazione**:
  ```dart
  class Validators {
    // Lunghezze massime
    static const int maxTitleLength = 100;
    static const int maxDescriptionLength = 1000;
    static const int maxEmailLength = 254;
    static const int maxNameLength = 50;

    /// Valida email
    static String? email(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email obbligatoria';
      }
      if (value.length > maxEmailLength) {
        return 'Email troppo lunga';
      }
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) {
        return 'Email non valida';
      }
      return null;
    }

    /// Valida password
    static String? password(String? value) {
      if (value == null || value.isEmpty) {
        return 'Password obbligatoria';
      }
      if (value.length < 8) {
        return 'Minimo 8 caratteri';
      }
      if (value.length > 128) {
        return 'Password troppo lunga';
      }
      // Opzionale: richiedere complessità
      // if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Richiesta maiuscola';
      // if (!RegExp(r'[0-9]').hasMatch(value)) return 'Richiesto numero';
      return null;
    }

    /// Valida titolo generico
    static String? title(String? value, {String fieldName = 'Titolo'}) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldName obbligatorio';
      }
      if (value.length > maxTitleLength) {
        return '$fieldName troppo lungo (max $maxTitleLength caratteri)';
      }
      return null;
    }

    /// Valida descrizione/testo lungo
    static String? description(String? value, {bool required = false}) {
      if (required && (value == null || value.trim().isEmpty)) {
        return 'Descrizione obbligatoria';
      }
      if (value != null && value.length > maxDescriptionLength) {
        return 'Testo troppo lungo (max $maxDescriptionLength caratteri)';
      }
      return null;
    }

    /// Valida nome persona
    static String? name(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Nome obbligatorio';
      }
      if (value.length > maxNameLength) {
        return 'Nome troppo lungo';
      }
      // No numeri o caratteri speciali
      if (!RegExp(r'^[\p{L}\s\-\.]+$', unicode: true).hasMatch(value)) {
        return 'Nome non valido';
      }
      return null;
    }

    /// Sanitizza HTML/script
    static String sanitize(String input) {
      return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .trim();
    }
  }
  ```
  - **Criterio completamento**: Classe creata con tutti i validatori

#### 2.3.2 Applicare Validatori ai Form di Login
- [ ] **Aggiornare login_screen.dart**
  - **Campi da validare**: email, password
  - **Criterio completamento**: Validazione attiva in form login

#### 2.3.3 Applicare Validatori ai Form Sessioni
- [ ] **Aggiornare session_form_dialog.dart**
  - **Campi da validare**: nome sessione, descrizione
  - **Criterio completamento**: Validazione attiva

#### 2.3.4 Applicare Validatori ai Form Story
- [ ] **Aggiornare story_form_dialog.dart**
  - **Campi da validare**: titolo, descrizione, acceptance criteria
  - **Criterio completamento**: Validazione attiva

#### 2.3.5 Applicare Validatori ai Form Matrice
- [ ] **Aggiornare form creazione matrice Eisenhower**
  - **Campi da validare**: nome, descrizione, attività
  - **Criterio completamento**: Validazione attiva

#### 2.3.6 Applicare Validatori ai Form Progetto Agile
- [ ] **Aggiornare form creazione progetto**
  - **Campi da validare**: nome, descrizione, sprint goal
  - **Criterio completamento**: Validazione attiva

#### 2.3.7 Test Validazione
- [ ] **Testare tutti i form con input limite**
  - **Test da eseguire**:
    - Input vuoti → messaggio errore
    - Input troppo lunghi → messaggio errore
    - Email invalide → messaggio errore
    - Caratteri speciali → sanitizzati o rifiutati
  - **Criterio completamento**: Tutti i test passati

### Criteri di Completamento Fase 2.3
- [x] Classe Validators creata
- [x] Tutti i form usano validatori centralizzati
- [x] Lunghezze massime rispettate
- [x] Input sanitizzati prima di salvare
- [x] Test manuali completati

---

# FASE 3: INTERNAZIONALIZZAZIONE (i18n)

---

## 3.1 SETUP INFRASTRUTTURA i18n

### Descrizione
L'applicazione contiene circa 789 stringhe hardcoded in italiano. Per supportare più lingue e facilitare future traduzioni, è necessario estrarre tutte le stringhe in file di risorse localizzati.

### Effort Stimato
8-12 ore totali per questa fase

### Checklist Dettagliata

#### 3.1.1 Creare Configurazione l10n
- [ ] **Creare file l10n.yaml nella root**
  - **File da creare**: `l10n.yaml`
  - **Contenuto**:
  ```yaml
  arb-dir: lib/l10n
  template-arb-file: app_it.arb
  output-localization-file: app_localizations.dart
  output-class: AppLocalizations
  preferred-supported-locales: [it]
  ```
  - **Criterio completamento**: File creato

#### 3.1.2 Creare Directory l10n
- [ ] **Creare struttura directory per traduzioni**
  - **Struttura**:
  ```
  lib/l10n/
  ├── app_it.arb  (italiano - template)
  └── app_en.arb  (inglese)
  ```
  - **Criterio completamento**: Directory e file creati

#### 3.1.3 Creare Template ARB Italiano
- [ ] **Creare file app_it.arb con struttura base**
  - **File**: `lib/l10n/app_it.arb`
  - **Struttura iniziale**:
  ```json
  {
    "@@locale": "it",
    "@@last_modified": "2026-01-15",

    "appTitle": "Agile Tools",
    "@appTitle": {
      "description": "Titolo dell'applicazione"
    },

    "login": "Accedi",
    "logout": "Esci",
    "email": "Email",
    "password": "Password",

    "// Aggiungere tutte le stringhe qui..."
  }
  ```
  - **Criterio completamento**: File template creato

#### 3.1.4 Creare File ARB Inglese
- [ ] **Creare file app_en.arb con traduzioni**
  - **File**: `lib/l10n/app_en.arb`
  - **Contenuto**: Traduzioni inglesi di tutte le stringhe
  - **Criterio completamento**: File con tutte le traduzioni

#### 3.1.5 Abilitare Generazione in pubspec.yaml
- [ ] **Aggiungere configurazione Flutter**
  - **Aggiungere in pubspec.yaml**:
  ```yaml
  flutter:
    generate: true
    uses-material-design: true
  ```
  - **Criterio completamento**: pubspec.yaml aggiornato

#### 3.1.6 Aggiungere Dipendenza flutter_localizations
- [ ] **Aggiungere package per localizzazione**
  - **In pubspec.yaml**:
  ```yaml
  dependencies:
    flutter_localizations:
      sdk: flutter
  ```
  - **Criterio completamento**: Dipendenza aggiunta

#### 3.1.7 Configurare MaterialApp
- [ ] **Aggiungere supporto localizzazione in main.dart**
  - **Codice da aggiungere**:
  ```dart
  import 'package:flutter_gen/gen_l10n/app_localizations.dart';

  MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: _currentLocale, // Gestire con provider/state
    // ...
  )
  ```
  - **Criterio completamento**: App supporta cambio lingua

#### 3.1.8 Generare File Localizzazione
- [ ] **Eseguire generazione**
  - **Comando**: `flutter gen-l10n`
  - **Verifica**: File `.dart_tool/flutter_gen/gen_l10n/` generati
  - **Criterio completamento**: AppLocalizations disponibile

### Criteri di Completamento Fase 3.1
- [x] Infrastruttura i18n configurata
- [x] File ARB italiano creato (template)
- [x] File ARB inglese creato
- [x] AppLocalizations generato
- [x] MaterialApp configurato

---

## 3.2 ESTRAZIONE STRINGHE

### Checklist per File

#### 3.2.1 home_screen.dart (~30 stringhe)
- [ ] **Estrarre stringhe da home_screen.dart**
  - **Stringhe da estrarre**:
    - Titoli tool cards
    - Descrizioni
    - Feature labels
    - "Coming Soon"
    - Messaggi snackbar
  - **Pattern**:
  ```dart
  // PRIMA
  Text('Matrice Eisenhower')

  // DOPO
  Text(AppLocalizations.of(context)!.eisenhowerMatrix)
  ```
  - **Criterio completamento**: Zero stringhe hardcoded in italiano

#### 3.2.2 login_screen.dart (~40 stringhe)
- [ ] **Estrarre stringhe da login_screen.dart**
  - **Stringhe**: labels form, errori, bottoni, link
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.3 estimation_room_screen.dart (~150 stringhe)
- [ ] **Estrarre stringhe da estimation_room_screen.dart**
  - **Stringhe**: header, labels, messaggi, tooltip, dialogs
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.4 eisenhower_screen.dart (~120 stringhe)
- [ ] **Estrarre stringhe da eisenhower_screen.dart**
  - **Stringhe**: quadranti, labels, azioni, dialogs
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.5 agile_process_screen.dart (~100 stringhe)
- [ ] **Estrarre stringhe da agile_process_screen.dart**
  - **Stringhe**: tabs, labels, form, status
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.6 Widgets estimation_room/ (~100 stringhe)
- [ ] **Estrarre stringhe dai widget estimation room**
  - **File**: voting_board, card_deck, results_panel, etc.
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.7 Widgets eisenhower/ (~80 stringhe)
- [ ] **Estrarre stringhe dai widget eisenhower**
  - **File**: scatter_chart, raci_matrix, quadrant, etc.
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.8 Widgets agile/ (~100 stringhe)
- [ ] **Estrarre stringhe dai widget agile**
  - **File**: backlog, sprint, kanban, etc.
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.9 Dialogs e Form (~70 stringhe)
- [ ] **Estrarre stringhe dai dialog**
  - **File**: tutti i *_dialog.dart, *_form.dart
  - **Criterio completamento**: Zero stringhe hardcoded

#### 3.2.10 Services/Models (messaggi errore)
- [ ] **Estrarre messaggi di errore dai services**
  - **Cosa**: Messaggi mostrati all'utente
  - **Criterio completamento**: Errori localizzati

---

## 3.3 SELECTOR LINGUA

### Checklist Dettagliata

#### 3.3.1 Creare State Management Lingua
- [ ] **Implementare gestione stato lingua**
  - **Opzioni**: Provider, Riverpod, o semplice ValueNotifier
  - **Funzionalità**:
    - Leggere preferenza da SharedPreferences
    - Salvare preferenza quando cambiata
    - Notificare app per rebuild
  - **Criterio completamento**: Cambio lingua funzionante

#### 3.3.2 Creare Widget Selector
- [ ] **Creare dropdown/toggle per cambio lingua**
  - **File da creare**: `lib/widgets/language_selector.dart`
  - **Posizione**: AppBar o Settings
  - **Design**: Dropdown con bandiere o codici (IT/EN)
  - **Criterio completamento**: Widget funzionante

#### 3.3.3 Integrare in AppBar
- [ ] **Aggiungere selector in posizione accessibile**
  - **Dove**: Home screen AppBar o drawer
  - **Criterio completamento**: Selector sempre raggiungibile

#### 3.3.4 Persistere Preferenza
- [ ] **Salvare lingua in SharedPreferences**
  - **Chiave**: `app_locale`
  - **Valori**: `it`, `en`
  - **Criterio completamento**: Lingua ricordata al riavvio

### Criteri di Completamento Fase 3
- [x] Tutte le ~789 stringhe estratte in ARB
- [x] Traduzioni inglesi complete
- [x] Selector lingua funzionante
- [x] Preferenza persistita
- [x] App completamente usabile in entrambe le lingue

---

# FASE 4: SEO & PWA

---

## 4.1 SEO BASE

### Checklist Dettagliata

#### 4.1.1 Creare robots.txt
- [ ] **Creare file robots.txt in web/**
  - **File**: `web/robots.txt`
  - **Contenuto**:
  ```
  User-agent: *
  Allow: /
  Disallow: /api/

  Sitemap: https://pm-agile-tools-app.web.app/sitemap.xml
  ```
  - **Criterio completamento**: File creato e servito correttamente

#### 4.1.2 Creare sitemap.xml
- [ ] **Creare sitemap per search engine**
  - **File**: `web/sitemap.xml`
  - **Contenuto**:
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
      <loc>https://pm-agile-tools-app.web.app/</loc>
      <lastmod>2026-01-15</lastmod>
      <changefreq>weekly</changefreq>
      <priority>1.0</priority>
    </url>
    <url>
      <loc>https://pm-agile-tools-app.web.app/privacy</loc>
      <lastmod>2026-01-15</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    <url>
      <loc>https://pm-agile-tools-app.web.app/terms</loc>
      <lastmod>2026-01-15</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
  </urlset>
  ```
  - **Criterio completamento**: Sitemap accessibile

#### 4.1.3 Aggiungere Meta Tags Open Graph
- [ ] **Aggiornare index.html con OG tags**
  - **File**: `web/index.html`
  - **Aggiungere nell'head**:
  ```html
  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://pm-agile-tools-app.web.app/">
  <meta property="og:title" content="Agile Tools - Strumenti per Team Agili">
  <meta property="og:description" content="Planning Poker, Matrice Eisenhower, Gestione Progetti Agili. Collabora in tempo reale con il tuo team.">
  <meta property="og:image" content="https://pm-agile-tools-app.web.app/og-image.png">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:locale" content="it_IT">
  <meta property="og:locale:alternate" content="en_US">
  ```
  - **Criterio completamento**: Tags presenti

#### 4.1.4 Aggiungere Twitter Card Tags
- [ ] **Aggiungere meta tags per Twitter**
  - **Aggiungere nell'head**:
  ```html
  <!-- Twitter -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:url" content="https://pm-agile-tools-app.web.app/">
  <meta name="twitter:title" content="Agile Tools">
  <meta name="twitter:description" content="Strumenti collaborativi per team agili">
  <meta name="twitter:image" content="https://pm-agile-tools-app.web.app/og-image.png">
  ```
  - **Criterio completamento**: Tags presenti

#### 4.1.5 Creare Immagine OG
- [ ] **Creare immagine per condivisione social**
  - **Dimensioni**: 1200x630px
  - **Contenuto**: Logo, nome app, tagline
  - **File**: `web/og-image.png`
  - **Criterio completamento**: Immagine creata e accessibile

#### 4.1.6 Migliorare Meta Description
- [ ] **Aggiornare description esistente**
  - **Attuale**: Generica
  - **Nuova**: Descrittiva con keyword
  - **Esempio**:
  ```html
  <meta name="description" content="Agile Tools: Planning Poker per stime collaborative, Matrice Eisenhower per prioritizzazione, Gestione Sprint e Backlog. Strumenti gratuiti per team Scrum e Kanban.">
  ```
  - **Criterio completamento**: Description aggiornata

#### 4.1.7 Aggiungere Canonical URL
- [ ] **Aggiungere link canonical**
  - **Tag**:
  ```html
  <link rel="canonical" href="https://pm-agile-tools-app.web.app/">
  ```
  - **Criterio completamento**: Tag presente

#### 4.1.8 Verificare con Tool SEO
- [ ] **Testare SEO con strumenti**
  - **Tool**:
    - Google Rich Results Test
    - Facebook Sharing Debugger
    - Twitter Card Validator
  - **Criterio completamento**: Tutti i test passati

### Criteri di Completamento Fase 4
- [x] robots.txt presente e corretto
- [x] sitemap.xml presente e valido
- [x] Meta tags OG completi
- [x] Twitter Card configurato
- [x] Immagine social creata
- [x] Test strumenti SEO passati

---

# FASE 5: TESTING

---

## 5.1 UNIT TESTS

### Checklist Dettagliata

#### 5.1.1 Test AuthService
- [ ] **Creare test per AuthService**
  - **File**: `test/services/auth_service_test.dart`
  - **Test cases**:
    - Login con credenziali valide
    - Login con credenziali invalide
    - Logout
    - Refresh token
    - getCurrentUser
  - **Criterio completamento**: Tutti i test passano

#### 5.1.2 Test Validators
- [ ] **Creare test per Validators**
  - **File**: `test/utils/validators_test.dart`
  - **Test cases**:
    - Email valide/invalide
    - Password requirements
    - Title length limits
    - Sanitization
  - **Criterio completamento**: 100% coverage su Validators

#### 5.1.3 Test Models
- [ ] **Creare test per modelli**
  - **File**: `test/models/*_test.dart`
  - **Test cases**:
    - Serializzazione toJson
    - Deserializzazione fromJson
    - copyWith
    - Computed properties
  - **Criterio completamento**: Test per ogni model

---

## 5.2 WIDGET TESTS

### Checklist Dettagliata

#### 5.2.1 Test LoginScreen
- [ ] **Creare widget test per login**
  - **File**: `test/screens/login_screen_test.dart`
  - **Test cases**:
    - Form renderizza correttamente
    - Validazione mostra errori
    - Submit con dati validi
  - **Criterio completamento**: Test passano

#### 5.2.2 Test HomeScreen
- [ ] **Creare widget test per home**
  - **File**: `test/screens/home_screen_test.dart`
  - **Test cases**:
    - Tutte le card visibili
    - Navigazione funziona
    - Theme toggle funziona
  - **Criterio completamento**: Test passano

---

## 5.3 INTEGRATION TESTS

### Checklist Dettagliata

#### 5.3.1 Test Flusso Estimation Room
- [ ] **Creare integration test per Planning Poker**
  - **File**: `integration_test/estimation_room_test.dart`
  - **Flusso testato**:
    1. Login
    2. Crea sessione
    3. Aggiungi story
    4. Vota
    5. Rivela voti
    6. Conferma stima
  - **Criterio completamento**: Flusso completo funziona

#### 5.3.2 Test Flusso Eisenhower
- [ ] **Creare integration test per Matrice**
  - **Flusso testato**:
    1. Login
    2. Crea matrice
    3. Aggiungi attività
    4. Sposta tra quadranti
    5. Invita partecipante
  - **Criterio completamento**: Flusso completo funziona

### Criteri di Completamento Fase 5
- [x] Unit test per services core
- [x] Unit test per validators
- [x] Widget test per schermate principali
- [x] Integration test per flussi critici
- [x] Coverage report generato

---

# FASE 6: MONITORING & ANALYTICS

---

## 6.1 FIREBASE ANALYTICS

### Checklist Dettagliata

#### 6.1.1 Aggiungere Dipendenza
- [ ] **Aggiungere firebase_analytics**
  - **pubspec.yaml**:
  ```yaml
  firebase_analytics: ^10.8.0
  ```
  - **Criterio completamento**: Package installato

#### 6.1.2 Inizializzare Analytics
- [ ] **Configurare in main.dart**
  - **Codice**:
  ```dart
  final analytics = FirebaseAnalytics.instance;
  ```
  - **Criterio completamento**: Analytics inizializzato

#### 6.1.3 Definire Eventi Custom
- [ ] **Identificare eventi chiave da tracciare**
  - **Eventi**:
    - `session_created` - Nuova sessione Planning Poker
    - `story_estimated` - Story stimata
    - `matrix_created` - Nuova matrice Eisenhower
    - `activity_created` - Nuova attività
    - `user_invited` - Invito inviato
    - `project_created` - Nuovo progetto Agile
  - **Criterio completamento**: Lista eventi definita

#### 6.1.4 Implementare Tracking
- [ ] **Aggiungere log eventi nel codice**
  - **Pattern**:
  ```dart
  FirebaseAnalytics.instance.logEvent(
    name: 'session_created',
    parameters: {
      'estimation_mode': session.estimationMode.name,
      'participant_count': session.participantCount,
    },
  );
  ```
  - **Criterio completamento**: Eventi tracciati

#### 6.1.5 Configurare Dashboard
- [ ] **Creare dashboard in Firebase Console**
  - **Metriche da monitorare**:
    - Utenti attivi giornalieri/mensili
    - Sessioni create per giorno
    - Conversion rate (registrazione → prima sessione)
    - Feature più usate
  - **Criterio completamento**: Dashboard configurata

### Criteri di Completamento Fase 6
- [x] Firebase Analytics configurato
- [x] Eventi custom definiti e tracciati
- [x] Dashboard creata
- [x] Alert per metriche anomale

---

# CHECKLIST PRE-LANCIO FINALE

## Blockers (MUST HAVE)
- [x] Firestore Security Rules deployate e testate ✅ **FILE CREATO** - da deployare
- [ ] Privacy Policy pubblicata
- [ ] Terms of Service pubblicati
- [ ] Cookie Consent funzionante
- [ ] Debug logging rimosso
- [ ] Consenso in registrazione

## Alta Priorità (SHOULD HAVE)
- [x] Secure headers configurati ✅ **CONFIGURATO in firebase.json**
- [ ] Crash reporting attivo
- [x] Input validation completa ✅ **UTILITY CREATA** - da integrare nei form
- [ ] Elimina account funzionante
- [ ] Export dati funzionante

## Media Priorità (NICE TO HAVE per lancio)
- [ ] i18n almeno IT completo
- [x] robots.txt e sitemap ✅ **CREATI** in web/
- [x] Meta tags SEO ✅ **CONFIGURATI** in index.html (OG, Twitter, canonical)
- [x] Landing page con tool preview ✅ **CREATA** loading screen
- [ ] Test suite base

## Post-Lancio
- [ ] Analytics configurato
- [ ] i18n EN completo
- [ ] Test coverage > 60%
- [ ] Documentation

---

# REGISTRO COMPLETAMENTO

| Fase | Data Inizio | Data Fine | Responsabile | Note |
|------|-------------|-----------|--------------|------|
| 1.1 Firestore Rules | 15/01/2026 | 15/01/2026 | Claude | File creato, da deployare |
| 1.2 Legal | | | | |
| 1.3 Debug Logging | 15/01/2026 | 15/01/2026 | Claude | AppLogger creato, da integrare |
| 2.1 Secure Headers | 15/01/2026 | 15/01/2026 | Claude | Configurati in firebase.json |
| 2.2 Crash Reporting | | | | |
| 2.3 Input Validation | 15/01/2026 | 15/01/2026 | Claude | Validators creato, da integrare |
| 3.x i18n | | | | |
| 4.x SEO | 15/01/2026 | 15/01/2026 | Claude | Landing page, meta tags, robots, sitemap |
| 5.x Testing | | | | |
| 6.x Analytics | | | | |

---

# FILE CREATI (15/01/2026)

## Security & Infrastructure

### 1. `firestore.rules`
Regole di sicurezza Firestore per tutte le collection:
- `planning_poker_sessions` + subcollection `stories`
- `planning_poker_invites`
- `eisenhower_matrices` + subcollection `activities`
- `eisenhower_invites`
- `agile_projects` + subcollections `stories`, `sprints`, `retrospectives`, `audit_logs`
- `agile_invites`
- `smart_todo_lists` + subcollection `smart_todo_tasks`
- `smart_todo_invites`
- `users`

**Deploy**: `firebase deploy --only firestore:rules`

### 2. `firestore.indexes.json`
9 indici compositi per query efficienti su:
- participantEmails + updatedAt/createdAt
- createdBy + createdAt
- status + date fields

**Deploy**: `firebase deploy --only firestore:indexes`

### 3. `firebase.json` (aggiornato)
- Riferimento a firestore.rules
- Riferimento a firestore.indexes.json
- 5 Security Headers:
  - X-Frame-Options: DENY
  - X-Content-Type-Options: nosniff
  - X-XSS-Protection: 1; mode=block
  - Referrer-Policy: strict-origin-when-cross-origin
  - Permissions-Policy: geolocation=(), microphone=(), camera=()

## Utilities

### 4. `lib/utils/app_logger.dart`
Logger centralizzato production-safe:
- `AppLogger.debug(message, tag)` - solo in development
- `AppLogger.info(message, tag)` - solo in development
- `AppLogger.warning(message, tag)` - sempre attivo
- `AppLogger.error(message, error, stackTrace)` - sempre attivo
- Metodi specializzati: `firestore()`, `auth()`, `navigation()`, `network()`

**Uso**: Sostituire tutti i `print()` con `AppLogger.debug()`

### 5. `lib/utils/validators.dart`
Validatori per form input:
- `Validators.email(value)`
- `Validators.password(value)`
- `Validators.strongPassword(value)`
- `Validators.title(value, fieldName: 'Nome')`
- `Validators.description(value)`
- `Validators.name(value)`
- `Validators.url(value)`
- `Validators.positiveInteger(value)`
- `Validators.sanitize(input)` - previene XSS
- `Validators.validateEmailList(input)` - per inviti multipli

**Uso**: `TextFormField(validator: Validators.email)`

## SEO & Landing Page

### 6. `web/index.html` (aggiornato)
Landing page completa con:
- **Meta tags SEO**: description, keywords, author, robots
- **Open Graph**: og:title, og:description, og:image, og:locale
- **Twitter Card**: summary_large_image
- **Canonical URL**: link rel="canonical"
- **Loading screen**: Preview dei 4 tool durante caricamento Flutter
- **Dark/Light mode**: Supporto automatico prefers-color-scheme
- **PWA ready**: apple-mobile-web-app tags

### 7. `web/manifest.json` (aggiornato)
PWA manifest completo con:
- Nome e descrizione aggiornati
- Categorie: productivity, business, utilities
- **Shortcuts**: Accesso rapido ai 4 tool principali
  - Smart Todo → `/smart-todo`
  - Matrice Eisenhower → `/eisenhower`
  - Estimation Room → `/estimation-room`
  - Agile Process Manager → `/agile-process`

### 8. `web/robots.txt`
Configurazione crawler:
- Allow all
- Sitemap reference
- Crawl delay: 1s

### 9. `web/sitemap.xml`
Mappa sito per search engines:
- Home page (priority 1.0)
- 4 tool pages (priority 0.9)
- Legal pages (priority 0.3)

### 10. `web/icons/og-image.png` + `og-image.svg`
Immagine per condivisione social (1200x630px):
- Sfondo gradiente scuro con griglia
- Logo "AT" centrale
- Titolo e tagline
- 4 card con icone per ogni tool
- URL in basso
- Convertito da SVG a PNG con sharp-cli

---

## COMANDI DEPLOY

```bash
# 1. Deploy regole Firestore
firebase deploy --only firestore:rules

# 2. Deploy indici Firestore
firebase deploy --only firestore:indexes

# 3. Build e deploy hosting (con secure headers)
flutter build web --release
firebase deploy --only hosting

# Oppure tutto insieme:
flutter build web --release && firebase deploy
```

---

*Documento generato: Gennaio 2026*
*Versione: 2.1 - Con registro implementazioni*
*Ultimo aggiornamento: 15/01/2026*
