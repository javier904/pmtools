# Analisi Completa: Centralizzazione Sistema Inviti

## Executive Summary

La centralizzazione del sistema inviti da 5 collection separate a 1 collection unificata `invitations` porterà:
- **-80% codice** (da ~2500 a ~500 righe)
- **-80% query Firestore** (da 5 listener a 1)
- **-67% indici** (da ~15 a ~5)
- **Estensibilità cross-app** senza modifiche strutturali

---

## 1. STATO ATTUALE

### 1.1 Collection Firestore Esistenti

| Collection | Tipo | Usata da | Regole Firestore |
|------------|------|----------|------------------|
| `eisenhower_invites` | Dedicata | EisenhowerInviteService | ✅ Definite |
| `estimation_room_invites` | Dedicata | PlanningPokerInviteService | ❌ **MANCANTI** |
| `agile_invites` | Dedicata | AgileInviteService | ✅ Definite |
| `retro_invites` | Dedicata | RetroInviteService | ❌ **MANCANTI** |
| `smart_todo_lists/{id}/invites` | Subcollection | SmartTodoInviteService | ✅ Definite |
| `planning_poker_sessions/{id}/invites` | Subcollection (legacy) | Legacy code | ✅ Definite |

### 1.2 Models Esistenti

| Model | Campi Specifici | Note |
|-------|-----------------|------|
| `EisenhowerInviteModel` | `matrixId` | Completo |
| `PlanningPokerInviteModel` | `sessionId` | Completo |
| `AgileInviteModel` | `projectId`, `teamRole` | Ha 2 ruoli |
| `TodoInviteModel` | `listId` | Incompleto (no declineReason) |
| `RetroInviteModel` | `boardId` | Completo |
| `UnifiedInviteModel` | `sourceType`, `sourceId`, `sourceName` | Già esistente! |

### 1.3 Services Esistenti

| Service | Pattern | Collection | Metodi |
|---------|---------|------------|--------|
| `EisenhowerInviteService` | Singleton | `eisenhower_invites` | 15+ |
| `PlanningPokerInviteService` | Singleton | `estimation_room_invites` | 18+ |
| `AgileInviteService` | Singleton | `agile_invites` | 15+ |
| `SmartTodoInviteService` | Constructor | `smart_todo_lists/{id}/invites` | 5 |
| `RetroInviteService` | Singleton | `retro_invites` | 15+ |
| `InviteAggregatorService` | Singleton | Tutte | 5 |

---

## 2. PROPOSTA: COLLECTION UNIFICATA

### 2.1 Struttura Firestore

```
invitations/{inviteId}
├── sourceType: String     // "eisenhower" | "estimation_room" | "agile_project" | "smart_todo" | "retrospective"
├── sourceId: String       // ID dell'istanza (matrixId, sessionId, projectId, listId, boardId)
├── sourceName: String     // Nome per display (cachato)
├── email: String          // Email invitato (lowercase)
├── role: String           // Ruolo assegnato
├── teamRole: String?      // Solo per Agile Project
├── status: String         // "pending" | "accepted" | "declined" | "expired" | "revoked"
├── token: String          // Token univoco 32 char
├── invitedBy: String      // Email di chi ha invitato
├── invitedByName: String  // Nome di chi ha invitato
├── invitedAt: Timestamp
├── expiresAt: Timestamp
├── acceptedAt: Timestamp?
├── declinedAt: Timestamp?
└── declineReason: String?
```

### 2.2 Indici Necessari

```json
[
  {
    "collectionGroup": "invitations",
    "fields": [
      { "fieldPath": "email", "order": "ASCENDING" },
      { "fieldPath": "status", "order": "ASCENDING" }
    ]
  },
  {
    "collectionGroup": "invitations",
    "fields": [
      { "fieldPath": "sourceType", "order": "ASCENDING" },
      { "fieldPath": "sourceId", "order": "ASCENDING" },
      { "fieldPath": "invitedAt", "order": "DESCENDING" }
    ]
  },
  {
    "collectionGroup": "invitations",
    "fields": [
      { "fieldPath": "sourceType", "order": "ASCENDING" },
      { "fieldPath": "sourceId", "order": "ASCENDING" },
      { "fieldPath": "email", "order": "ASCENDING" },
      { "fieldPath": "status", "order": "ASCENDING" }
    ]
  },
  {
    "collectionGroup": "invitations",
    "fields": [
      { "fieldPath": "status", "order": "ASCENDING" },
      { "fieldPath": "expiresAt", "order": "ASCENDING" }
    ]
  }
]
```

### 2.3 Regole Firestore

```javascript
match /invitations/{inviteId} {
  // Get: invitato o chi ha invitato
  allow get: if isAuthenticated() && (
    resource.data.email.lower() == userEmail() ||
    resource.data.invitedBy.lower() == userEmail()
  );

  // List: inviti propri (ricevuti o inviati)
  allow list: if isAuthenticated() && (
    resource.data.email.lower() == userEmail() ||
    resource.data.invitedBy.lower() == userEmail()
  );

  // Create: qualsiasi utente autenticato
  allow create: if isAuthenticated();

  // Update: chi ha invitato o chi accetta
  allow update: if isAuthenticated() && (
    resource.data.invitedBy.lower() == userEmail() ||
    (request.resource.data.status == 'accepted' &&
     resource.data.email.lower() == userEmail())
  );

  // Delete: chi ha invitato
  allow delete: if isAuthenticated() &&
    resource.data.invitedBy.lower() == userEmail();
}
```

---

## 3. IMPATTO SUI FILE

### 3.1 FILE DA ELIMINARE (dopo migrazione)

| File | Linee | Note |
|------|-------|------|
| `lib/models/eisenhower_invite_model.dart` | ~180 | Sostituito da UnifiedInviteModel |
| `lib/models/planning_poker_invite_model.dart` | ~240 | Sostituito da UnifiedInviteModel |
| `lib/models/agile_invite_model.dart` | ~200 | Sostituito da UnifiedInviteModel |
| `lib/models/smart_todo/todo_invite_model.dart` | ~120 | Sostituito da UnifiedInviteModel |
| `lib/models/retro_invite_model.dart` | ~200 | Sostituito da UnifiedInviteModel |
| `lib/services/eisenhower_invite_service.dart` | ~620 | Sostituito da InviteService |
| `lib/services/planning_poker_invite_service.dart` | ~570 | Sostituito da InviteService |
| `lib/services/agile_invite_service.dart` | ~500 | Sostituito da InviteService |
| `lib/services/smart_todo_invite_service.dart` | ~250 | Sostituito da InviteService |
| `lib/services/retro_invite_service.dart` | ~500 | Sostituito da InviteService |
| **TOTALE** | **~3380** | Linee eliminate |

### 3.2 FILE DA MODIFICARE

#### Models

| File | Modifiche |
|------|-----------|
| `lib/models/unified_invite_model.dart` | Aggiungere `fromFirestore()`, `toFirestore()`, `generateToken()` |

#### Services

| File | Modifiche |
|------|-----------|
| `lib/services/invite_aggregator_service.dart` | Semplificare drasticamente (1 query invece di 5) |
| **NUOVO** `lib/services/invite_service.dart` | Service unificato (~500 righe) |

#### Screens

| File | Modifiche |
|------|-----------|
| `lib/screens/eisenhower_screen.dart` | Cambiare import/uso service |
| `lib/screens/estimation_room_screen.dart` | Cambiare import/uso service |
| `lib/screens/agile_project_detail_screen.dart` | Cambiare import/uso service |
| `lib/screens/retrospective_board_screen.dart` | Cambiare import/uso service |
| `lib/screens/invite_landing_screen.dart` | Nessuna modifica (già usa UnifiedInviteModel) |
| `lib/screens/planning_poker_invite_screen.dart` | Cambiare import/uso service |

#### Widgets

| File | Modifiche |
|------|-----------|
| `lib/widgets/pending_invites_button.dart` | Nessuna modifica (già usa UnifiedInviteModel) |
| `lib/widgets/eisenhower/participant_invite_dialog.dart` | Cambiare service, usare UnifiedInviteModel |
| `lib/widgets/eisenhower/invite_tab_widget.dart` | Cambiare service, usare UnifiedInviteModel |
| `lib/widgets/agile/participant_invite_dialog.dart` | Cambiare service, usare UnifiedInviteModel |
| `lib/widgets/smart_todo/smart_todo_invite_dialog.dart` | Cambiare service, usare UnifiedInviteModel |
| `lib/widgets/smart_todo/smart_todo_participants_dialog.dart` | Cambiare service, usare UnifiedInviteModel |
| `lib/widgets/retrospective/retro_participant_invite_dialog.dart` | Cambiare service, usare UnifiedInviteModel |

#### Altri

| File | Modifiche |
|------|-----------|
| `lib/main.dart` | Nessuna modifica (routes invariati) |
| `firestore.rules` | Aggiungere regole per `invitations`, rimuovere vecchie |
| `firestore.indexes.json` | Aggiungere indici per `invitations`, rimuovere vecchi |

---

## 4. DETTAGLIO MODIFICHE PER FILE

### 4.1 UnifiedInviteModel (ESPANSIONE)

```dart
// AGGIUNGERE:

/// Factory da Firestore (per collection unificata)
factory UnifiedInviteModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  return UnifiedInviteModel(
    id: doc.id,
    sourceType: _parseSourceType(data['sourceType']),
    sourceId: data['sourceId'] ?? '',
    sourceName: data['sourceName'] ?? '',
    email: data['email'] ?? '',
    role: data['role'] ?? '',
    status: _parseStatus(data['status']),
    token: data['token'] ?? '',
    invitedBy: data['invitedBy'] ?? '',
    invitedByName: data['invitedByName'] ?? '',
    invitedAt: (data['invitedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    expiresAt: (data['expiresAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    acceptedAt: (data['acceptedAt'] as Timestamp?)?.toDate(),
    declinedAt: (data['declinedAt'] as Timestamp?)?.toDate(),
    declineReason: data['declineReason'],
  );
}

/// Converti a Firestore
Map<String, dynamic> toFirestore() {
  return {
    'sourceType': sourceType.name,
    'sourceId': sourceId,
    'sourceName': sourceName,
    'email': email.toLowerCase(),
    'role': role,
    'status': status.name,
    'token': token,
    'invitedBy': invitedBy,
    'invitedByName': invitedByName,
    'invitedAt': Timestamp.fromDate(invitedAt),
    'expiresAt': Timestamp.fromDate(expiresAt),
    if (acceptedAt != null) 'acceptedAt': Timestamp.fromDate(acceptedAt!),
    if (declinedAt != null) 'declinedAt': Timestamp.fromDate(declinedAt!),
    if (declineReason != null) 'declineReason': declineReason,
  };
}

/// Genera token univoco
static String generateToken() {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random.secure();
  return List.generate(32, (_) => chars[random.nextInt(chars.length)]).join();
}
```

### 4.2 InviteService (NUOVO)

```dart
/// Servizio unificato per la gestione di TUTTI gli inviti
///
/// Sostituisce: EisenhowerInviteService, PlanningPokerInviteService,
/// AgileInviteService, SmartTodoInviteService, RetroInviteService
class InviteService {
  static final InviteService _instance = InviteService._internal();
  factory InviteService() => _instance;
  InviteService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final SubscriptionLimitsService _limitsService = SubscriptionLimitsService();

  static const String _collection = 'invitations';

  CollectionReference<Map<String, dynamic>> get _invitesRef =>
      _firestore.collection(_collection);

  // ══════════════════════════════════════════════════════════════════════════
  // CRUD UNIFICATO
  // ══════════════════════════════════════════════════════════════════════════

  /// Crea un nuovo invito (funziona per tutti i tipi)
  Future<UnifiedInviteModel?> createInvite({
    required InviteSourceType sourceType,
    required String sourceId,
    required String sourceName,
    required String email,
    required String role,
    String? teamRole, // Solo per Agile
    int expirationDays = 7,
  }) async {
    // Check limite
    await _limitsService.enforceInviteLimit(
      entityType: sourceType.name,
      entityId: sourceId,
    );

    // Verifica duplicati
    final existing = await getActiveInviteForEmail(sourceType, sourceId, email);
    if (existing != null) return existing;

    final now = DateTime.now();
    final token = UnifiedInviteModel.generateToken();
    final inviterEmail = _authService.currentUserEmail ?? '';
    final inviterName = _authService.currentUser?.displayName ?? inviterEmail.split('@').first;

    final invite = UnifiedInviteModel(
      id: '',
      sourceType: sourceType,
      sourceId: sourceId,
      sourceName: sourceName,
      email: email.toLowerCase(),
      role: role,
      status: UnifiedInviteStatus.pending,
      token: token,
      invitedBy: inviterEmail,
      invitedByName: inviterName,
      invitedAt: now,
      expiresAt: now.add(Duration(days: expirationDays)),
    );

    final batch = _firestore.batch();

    // 1. Crea invito
    final inviteRef = _invitesRef.doc();
    batch.set(inviteRef, invite.toFirestore());

    // 2. Aggiungi a pendingEmails dell'entità sorgente
    final sourceRef = _getSourceRef(sourceType, sourceId);
    batch.update(sourceRef, {
      'pendingEmails': FieldValue.arrayUnion([email.toLowerCase()]),
      'updatedAt': Timestamp.fromDate(now),
    });

    await batch.commit();
    return invite.copyWith(id: inviteRef.id);
  }

  /// Ottieni riferimento all'entità sorgente
  DocumentReference _getSourceRef(InviteSourceType type, String id) {
    switch (type) {
      case InviteSourceType.eisenhower:
        return _firestore.collection('eisenhower_matrices').doc(id);
      case InviteSourceType.estimationRoom:
        return _firestore.collection('planning_poker_sessions').doc(id);
      case InviteSourceType.agileProject:
        return _firestore.collection('agile_projects').doc(id);
      case InviteSourceType.smartTodo:
        return _firestore.collection('smart_todo_lists').doc(id);
      case InviteSourceType.retroBoard:
        return _firestore.collection('retrospectives').doc(id);
    }
  }

  // ... altri metodi unificati
}
```

### 4.3 InviteAggregatorService (SEMPLIFICAZIONE)

```dart
// PRIMA: 5 stream combinati
CombineLatestStream.list([
  _streamEisenhowerInvites(email),
  _streamPlanningPokerInvites(email),
  _streamAgileInvites(email),
  _streamSmartTodoInvites(email),
  _streamRetroInvites(email),
])

// DOPO: 1 singolo stream
Stream<List<UnifiedInviteModel>> streamAllPendingInvites() {
  final email = _authService.currentUserEmail;
  if (email == null) return Stream.value([]);

  return _firestore
      .collection('invitations')
      .where('email', isEqualTo: email.toLowerCase())
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((snapshot) {
    final now = DateTime.now();
    return snapshot.docs
        .map((doc) => UnifiedInviteModel.fromFirestore(doc))
        .where((invite) => invite.expiresAt.isAfter(now))
        .toList()
      ..sort((a, b) => b.invitedAt.compareTo(a.invitedAt));
  });
}
```

### 4.4 Widgets (Pattern comune)

Tutti i dialog di invito cambieranno:

```dart
// PRIMA
import '../services/eisenhower_invite_service.dart';
import '../models/eisenhower_invite_model.dart';

final _inviteService = EisenhowerInviteService();
final invite = await _inviteService.createInvite(
  matrixId: matrixId,
  email: email,
  role: role,
);

// DOPO
import '../services/invite_service.dart';
import '../models/unified_invite_model.dart';

final _inviteService = InviteService();
final invite = await _inviteService.createInvite(
  sourceType: InviteSourceType.eisenhower,
  sourceId: matrixId,
  sourceName: matrixTitle,
  email: email,
  role: role.name,
);
```

---

## 5. CHECKLIST IMPLEMENTAZIONE

### Fase 1: Preparazione
- [ ] Aggiungere regole Firestore per `invitations`
- [ ] Aggiungere indici Firestore per `invitations`
- [ ] Espandere `UnifiedInviteModel` con `fromFirestore()`, `toFirestore()`, `generateToken()`

### Fase 2: Nuovo Service
- [ ] Creare `lib/services/invite_service.dart`
- [ ] Implementare tutti i metodi CRUD
- [ ] Implementare invio email (estrarre helper comune)
- [ ] Implementare gestione pendingEmails per ogni tipo sorgente

### Fase 3: Aggiornamento InviteAggregatorService
- [ ] Rimuovere 5 stream separati
- [ ] Implementare singolo stream unificato
- [ ] Aggiornare `acceptInvite()` e `declineInvite()`

### Fase 4: Aggiornamento Widget
- [ ] `eisenhower/participant_invite_dialog.dart`
- [ ] `eisenhower/invite_tab_widget.dart`
- [ ] `agile/participant_invite_dialog.dart`
- [ ] `smart_todo/smart_todo_invite_dialog.dart`
- [ ] `smart_todo/smart_todo_participants_dialog.dart`
- [ ] `retrospective/retro_participant_invite_dialog.dart`

### Fase 5: Aggiornamento Screen
- [ ] `estimation_room_screen.dart` (dialog inviti)
- [ ] `planning_poker_invite_screen.dart`

### Fase 6: Cleanup
- [ ] Rimuovere vecchi model di invito
- [ ] Rimuovere vecchi service di invito
- [ ] Rimuovere vecchie collection Firestore rules
- [ ] Rimuovere vecchi indici Firestore

### Fase 7: Test
- [ ] Test creazione invito per ogni tipo
- [ ] Test accettazione invito
- [ ] Test rifiuto invito
- [ ] Test inviti pendenti in PendingInvitesButton
- [ ] Test deep link per ogni tipo
- [ ] Test invio email

---

## 6. RISCHI E MITIGAZIONI

| Rischio | Impatto | Probabilità | Mitigazione |
|---------|---------|-------------|-------------|
| Breaking change API | Alto | Basso | Mantenere stessa signature pubblica |
| Perdita inviti esistenti | Alto | Nullo | Non facciamo migrazione dati |
| Performance query | Medio | Basso | Indici ottimizzati |
| TeamRole Agile | Basso | Medio | Campo opzionale in model |
| Regression UI | Medio | Medio | Test manuali approfonditi |

---

## 7. METRICHE ATTESE

| Metrica | Prima | Dopo | Miglioramento |
|---------|-------|------|---------------|
| File model | 5 | 1 | -80% |
| File service | 6 | 2 | -67% |
| Linee codice | ~3500 | ~700 | -80% |
| Query Firestore per lista inviti | 5 | 1 | -80% |
| Indici Firestore | ~15 | ~5 | -67% |
| Tempo aggiunta nuovo strumento | 1-2 ore | 5 min | -95% |

---

## 8. CASI LIMITE (EDGE CASES)

### 8.1 Gestione Scadenza Inviti

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Invito scade mentre utente lo sta accettando | Mostrare errore "Invito scaduto" | Check `expiresAt` in `acceptInvite()` prima di commit |
| Invito scade mentre dialog è aperto | Refresh automatico lista al focus | Listen su stream con filtro `expiresAt > now` |
| Batch inviti con alcuni scaduti | Processare solo validi, segnalare scaduti | Filtro pre-elaborazione |

### 8.2 Gestione Duplicati

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Stesso email invitato 2 volte | Ritornare invito esistente (idempotent) | Query `email + sourceType + sourceId + status=pending` |
| Utente già partecipante invitato | Mostrare errore "Già partecipante" | Check `participantEmails` sull'entità sorgente |
| Email con case diverso (A@x.com vs a@x.com) | Trattare come stesso utente | Lowercase in query e storage |
| Re-invito dopo declino | Permettere nuovo invito | Invito declinato non blocca nuovi inviti |
| Re-invito dopo revoca | Permettere nuovo invito | Invito revocato non blocca nuovi inviti |

### 8.3 Gestione Concorrenza

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Due utenti accettano stesso invito | Solo primo ha successo | Transaction con check status |
| Invito revocato mentre utente accetta | Mostrare errore "Invito revocato" | Check status in transaction |
| Entità sorgente eliminata | Invito diventa orfano, non accettabile | Check esistenza entità in `acceptInvite()` |
| Utente che ha invitato eliminato | Invito rimane valido | `invitedBy` solo per display |

### 8.4 Gestione Ruoli Specifici

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Agile Project: ruoli doppi | Salvare sia `role` che `teamRole` | Campo `teamRole` opzionale |
| Cambio ruolo dopo invito | Aggiornare invito pending | `updateInviteRole()` method |
| Ruolo non valido per sourceType | Validazione lato service | Enum validation per sourceType |

### 8.5 Gestione Email

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Email non inviata (errore SMTP) | Invito creato comunque, retry possibile | Catch error, log, allow manual retry |
| Email in spam | Non gestibile automaticamente | Istruzioni utente nel messaggio |
| Email bounce | Non notificato | Future: webhook per bounce tracking |
| Utente senza Gmail API | Fallback a mailto: link | Check `GmailApiService.isInitialized` |

### 8.6 Gestione Deep Link

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Deep link con sourceId non esistente | Errore "Risorsa non trovata" | Check esistenza in `InviteLandingScreen` |
| Deep link con sourceType errato | Errore "Tipo non valido" | Enum parsing con fallback |
| Utente non autenticato | Redirect a login, poi ritorna | Salva deep link in state, restore dopo login |
| Invito già accettato | Naviga direttamente all'istanza | Skip accettazione se già partecipante |

### 8.7 Gestione Limiti Subscription

| Scenario | Comportamento Atteso | Implementazione |
|----------|---------------------|-----------------|
| Limite inviti raggiunto | Mostrare dialog upgrade | `LimitExceededException` → `LimitReachedDialog` |
| Upgrade durante invio batch | Ricontrollare limite | Check per ogni invito |
| Downgrade con inviti pending | Inviti esistenti rimangono validi | Limiti solo su creazione |

---

## 9. NO REGRESSION - CASI DI TEST

### 9.1 Test Funzionali per Tipo

#### Eisenhower Matrix
- [ ] Creare invito da dialog partecipanti
- [ ] Visualizzare lista inviti nel tab inviti
- [ ] Accettare invito da PendingInvitesButton
- [ ] Rifiutare invito con motivo
- [ ] Revocare invito come owner
- [ ] Deep link `/invite/eisenhower/{matrixId}` funzionante
- [ ] Email inviata con link corretto
- [ ] Nuovo partecipante vede matrice dopo accettazione

#### Estimation Room
- [ ] Creare invito da dialog sessione
- [ ] Visualizzare partecipanti invitati nella sessione
- [ ] Accettare invito e partecipare a sessione
- [ ] Rifiutare invito
- [ ] Deep link `/invite/estimation_room/{sessionId}` funzionante
- [ ] Email inviata con dettagli sessione

#### Agile Project
- [ ] Creare invito con ruolo partecipante
- [ ] Creare invito con ruolo team (teamRole)
- [ ] Accettare invito come team member
- [ ] Verificare entrambi i ruoli salvati
- [ ] Deep link `/invite/agile_project/{projectId}` funzionante

#### Smart Todo
- [ ] Creare invito da lista
- [ ] Accettare invito e vedere lista
- [ ] Condividere task dopo accettazione
- [ ] Deep link `/invite/smart_todo/{listId}` funzionante

#### Retrospective
- [ ] Creare invito da board
- [ ] Accettare e partecipare alla retrospettiva
- [ ] Vedere card di altri partecipanti
- [ ] Deep link `/invite/retrospective/{boardId}` funzionante

### 9.2 Test Cross-Funzionali

- [ ] PendingInvitesButton mostra count corretto (tutti i tipi)
- [ ] Lista pending ordinata per data (più recente prima)
- [ ] Inviti scaduti non mostrati
- [ ] Filtro per email case-insensitive
- [ ] Aggiornamento real-time quando nuovo invito arriva
- [ ] Inviti rimossi da lista quando accettati/rifiutati/revocati

### 9.3 Test Permessi

- [ ] Solo invitato può vedere propri inviti ricevuti
- [ ] Solo chi ha invitato può vedere propri inviti inviati
- [ ] Solo chi ha invitato può revocare
- [ ] Solo invitato può accettare/rifiutare
- [ ] Owner entità può sempre invitare

### 9.4 Test Edge Cases

- [ ] Stesso email invitato 2 volte → ritorna invito esistente
- [ ] Email uppercase → normalizzato a lowercase
- [ ] Invito scaduto → non accettabile
- [ ] Invito già accettato → deep link naviga direttamente
- [ ] Entità eliminata → invito non accettabile
- [ ] Utente già partecipante → errore appropriato

### 9.5 Test Performance

- [ ] Lista 50+ inviti pending carica in < 2s
- [ ] Single query Firestore (verificare in console Firebase)
- [ ] Nessun listener leak (memory profiler)
- [ ] Stream si chiude correttamente su dispose

---

## 10. INTERNAZIONALIZZAZIONE (I18N)

### 10.1 Chiavi di Traduzione Richieste

#### Messaggi UI Esistenti da Mappare

```dart
// lib/l10n/app_en.arb - CHIAVI DA AGGIUNGERE O VERIFICARE

// Titoli Dialog
"inviteDialogTitle": "Invite Participant",
"inviteListTitle": "Pending Invites",
"inviteSentTitle": "Invite Sent",

// Azioni
"inviteSend": "Send Invite",
"inviteAccept": "Accept",
"inviteDecline": "Decline",
"inviteRevoke": "Revoke",
"inviteResend": "Resend",

// Stati
"inviteStatusPending": "Pending",
"inviteStatusAccepted": "Accepted",
"inviteStatusDeclined": "Declined",
"inviteStatusExpired": "Expired",
"inviteStatusRevoked": "Revoked",

// Messaggi
"inviteAlreadyExists": "An invite for this email already exists",
"inviteAlreadyParticipant": "{email} is already a participant",
"inviteExpired": "This invite has expired",
"inviteRevoked": "This invite has been revoked",
"inviteNotFound": "Invite not found",
"inviteSentSuccess": "Invite sent to {email}",
"inviteAcceptedSuccess": "You have joined {sourceName}",
"inviteDeclinedSuccess": "Invite declined",
"inviteRevokedSuccess": "Invite revoked",

// Errori
"inviteErrorGeneric": "Failed to process invite",
"inviteErrorNetwork": "Network error. Please try again",
"inviteErrorPermission": "You don't have permission to do this",
"inviteErrorLimitReached": "Invite limit reached. Upgrade to invite more participants",

// Email
"inviteEmailSubject": "You've been invited to {sourceName}",
"inviteEmailBody": "{inviterName} has invited you to collaborate on {sourceName}",

// Ruoli (già esistenti ma verificare)
"roleOwner": "Owner",
"roleAdmin": "Admin",
"roleEditor": "Editor",
"roleViewer": "Viewer",
"roleParticipant": "Participant",
"roleFacilitator": "Facilitator",
"roleObserver": "Observer",

// Tipi sorgente
"sourceTypeEisenhower": "Eisenhower Matrix",
"sourceTypeEstimationRoom": "Estimation Room",
"sourceTypeAgileProject": "Agile Project",
"sourceTypeSmartTodo": "Smart Todo List",
"sourceTypeRetrospective": "Retrospective Board",

// Conferme
"inviteConfirmRevoke": "Are you sure you want to revoke this invite?",
"inviteConfirmDecline": "Are you sure you want to decline this invite?",

// Placeholder
"inviteEmailPlaceholder": "Enter email address",
"inviteDeclineReasonPlaceholder": "Reason for declining (optional)",

// Tooltip
"invitePendingTooltip": "{count} pending invites",
"inviteExpiresAt": "Expires {date}",
"invitedBy": "Invited by {name}",
"invitedAt": "Invited on {date}"
```

### 10.2 Pattern di Utilizzo

```dart
// ❌ PRIMA (stringhe hardcoded)
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Invito inviato con successo!')),
);

// ✅ DOPO (con l10n)
final l10n = AppLocalizations.of(context)!;
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(l10n.inviteSentSuccess(email))),
);
```

### 10.3 File da Aggiornare

| File | Stringhe Hardcoded | Note |
|------|-------------------|------|
| `participant_invite_dialog.dart` (x4) | ~15 per file | Titoli, pulsanti, messaggi |
| `invite_tab_widget.dart` | ~10 | Colonne tabella, stati |
| `pending_invites_button.dart` | ~8 | Tooltip, stati |
| `invite_landing_screen.dart` | ~12 | Messaggi login, errori |
| `invite_service.dart` | ~5 | Messaggi errore throw |

### 10.4 Verifica Traduzioni Esistenti

Prima dell'implementazione, verificare che queste chiavi esistano già:
- [ ] `app_en.arb` ha tutte le chiavi invite*
- [ ] `app_it.arb` ha tutte le traduzioni italiane
- [ ] `app_fr.arb` ha tutte le traduzioni francesi
- [ ] `app_es.arb` ha tutte le traduzioni spagnole

---

## 11. CRITERI DI ACCETTAZIONE

### 11.1 Criteri Funzionali

| ID | Criterio | Verifica |
|----|----------|----------|
| FA-01 | Creazione invito funziona per tutti i 5 tipi | Test manuale per tipo |
| FA-02 | Accettazione invito aggiunge utente come partecipante | Verifica Firestore |
| FA-03 | Rifiuto invito con motivo salvato correttamente | Verifica campo `declineReason` |
| FA-04 | Revoca invito rimuove da lista pending | Check real-time |
| FA-05 | Deep link funziona per tutti i 5 tipi | Test URL diretti |
| FA-06 | Email inviata con contenuto corretto | Check inbox |
| FA-07 | PendingInvitesButton mostra count aggregato | Verifica UI |
| FA-08 | Inviti scaduti filtrati automaticamente | Check dopo 7 giorni |

### 11.2 Criteri Tecnici

| ID | Criterio | Verifica |
|----|----------|----------|
| TA-01 | Singola query Firestore per lista inviti | Firebase Console → Usage |
| TA-02 | Nessun import di vecchi model/service | `grep` su codebase |
| TA-03 | Tutte le stringhe UI tradotte | `grep` per stringhe hardcoded |
| TA-04 | Indici Firestore deployati | `firebase deploy --only firestore:indexes` |
| TA-05 | Regole Firestore aggiornate | `firebase deploy --only firestore:rules` |
| TA-06 | Nessun errore in `flutter analyze` | CI pipeline |
| TA-07 | Build web/mobile senza warning | `flutter build` |

### 11.3 Criteri di Performance

| ID | Criterio | Target | Verifica |
|----|----------|--------|----------|
| PA-01 | Caricamento lista inviti | < 500ms | Chrome DevTools |
| PA-02 | Creazione invito | < 1s | Stopwatch |
| PA-03 | Accettazione invito | < 1s | Stopwatch |
| PA-04 | Memory footprint stream | No leak | Flutter DevTools |

### 11.4 Criteri di Sicurezza

| ID | Criterio | Verifica |
|----|----------|----------|
| SA-01 | Utente non può vedere inviti altrui | Test con 2 account |
| SA-02 | Solo invitato può accettare | Test con account diverso |
| SA-03 | Solo chi ha invitato può revocare | Test permessi |
| SA-04 | Token univoco per ogni invito | Check unicità |
| SA-05 | Email normalizzata lowercase | Check Firestore |

### 11.5 Checklist Pre-Merge

- [ ] Tutti i test funzionali passano (sezione 9)
- [ ] Nessuna regressione su funzionalità esistenti
- [ ] Tutte le stringhe tradotte in 4 lingue
- [ ] Documentazione aggiornata
- [ ] Codice review completato
- [ ] Performance verificate
- [ ] Security rules testate

---

## 12. STRATEGIA IMPLEMENTAZIONE MINIMALE

### 12.1 Principi Guida

1. **Backward Compatibility First**: Mantenere API pubbliche identiche dove possibile
2. **Incremental Migration**: Non cambiare tutto in un PR
3. **Feature Flag Ready**: Poter tornare indietro facilmente
4. **Test-Driven**: Scrivere test prima di refactoring

### 12.2 Ordine di Implementazione Ottimale

```
FASE 1: Foundation (non breaking)
├── Creare collection `invitations` + regole + indici
├── Espandere UnifiedInviteModel
├── Creare InviteService (nuovo, non sostituisce)
└── Test InviteService isolato

FASE 2: Aggregator Switch (minimal change)
├── InviteAggregatorService usa InviteService
├── getAllPendingInvites() legge da nuova collection
├── acceptInvite() scrive in nuova collection
└── Test PendingInvitesButton funziona

FASE 3: Widget Migration (uno alla volta)
├── Eisenhower dialogs → InviteService
├── Test completo Eisenhower
├── Estimation Room → InviteService
├── Test completo Estimation Room
├── ... altri tool uno per volta
└── Test cross-tool

FASE 4: Cleanup (dopo conferma funzionante)
├── Rimuovere vecchi service
├── Rimuovere vecchi model
├── Rimuovere vecchie regole
└── Rimuovere vecchi indici
```

### 12.3 Rollback Strategy

```dart
// InviteAggregatorService con feature flag
class InviteAggregatorService {
  static const bool _useUnifiedCollection = true; // Toggle per rollback

  Stream<List<UnifiedInviteModel>> streamAllPendingInvites() {
    if (_useUnifiedCollection) {
      return _streamFromUnifiedCollection();
    } else {
      return _streamFromLegacyCollections(); // Vecchia implementazione
    }
  }
}
```

### 12.4 Impatto Minimo per File

| File | Linee Modificate | Tipo Modifica |
|------|-----------------|---------------|
| `unified_invite_model.dart` | +80 | Aggiunte (no breaking) |
| `invite_service.dart` | +500 | Nuovo file |
| `invite_aggregator_service.dart` | ~50 | Refactor interno |
| `participant_invite_dialog.dart` (x4) | ~30 per file | Import + service call |
| `firestore.rules` | +30, -0 | Aggiunte (no rimozioni iniziali) |
| `firestore.indexes.json` | +30, -0 | Aggiunte (no rimozioni iniziali) |

### 12.5 Compatibilità Dati

**Nessuna migrazione richiesta:**
- Vecchi inviti rimangono nelle vecchie collection
- Nuovi inviti vanno nella collection unificata
- Lettura: query entrambe collection (periodo transitorio)
- Scrittura: solo nuova collection

```dart
// Periodo transitorio in InviteAggregatorService
Stream<List<UnifiedInviteModel>> streamAllPendingInvites() {
  return CombineLatestStream.list([
    _streamFromUnifiedCollection(),    // Nuovi inviti
    _streamFromLegacyCollections(),    // Vecchi inviti (se esistono)
  ]).map((lists) => lists.expand((x) => x).toList()
    ..sort((a, b) => b.invitedAt.compareTo(a.invitedAt)));
}
```

---

## 13. AGGIORNAMENTO DOCUMENTAZIONE

### 13.1 File da Aggiornare

| File | Sezione | Contenuto |
|------|---------|-----------|
| `README.md` | Features | Aggiungere "Unified Invite System" |
| `CLAUDE.md` | Architecture | Documentare nuova struttura inviti |
| `TODO.md` | Completato | Marcare centralizzazione come done |
| `documentation/` | Nuovo file | `INVITE_SYSTEM.md` con API reference |

### 13.2 Contenuto INVITE_SYSTEM.md (da creare)

```markdown
# Sistema Inviti Unificato

## Struttura Collection
[Schema Firestore]

## API Reference
[Metodi InviteService]

## Esempi Utilizzo
[Code snippets per ogni operazione]

## Troubleshooting
[Errori comuni e soluzioni]
```

### 13.3 Commenti Inline

Ogni metodo pubblico di InviteService deve avere:
- Descrizione funzionalità
- Parametri documentati
- Return value documentato
- Throws documentati
- Esempio d'uso

```dart
/// Crea un nuovo invito per qualsiasi tipo di risorsa.
///
/// [sourceType] - Tipo della risorsa (eisenhower, estimation_room, etc.)
/// [sourceId] - ID univoco della risorsa
/// [sourceName] - Nome display della risorsa
/// [email] - Email dell'invitato (normalizzata a lowercase)
/// [role] - Ruolo assegnato all'invitato
/// [teamRole] - Ruolo team opzionale (solo per Agile Project)
/// [expirationDays] - Giorni prima della scadenza (default: 7)
///
/// Returns: [UnifiedInviteModel] se creato con successo, null se errore.
///
/// Throws:
/// - [LimitExceededException] se limite inviti raggiunto
/// - [FirebaseException] se errore database
///
/// Example:
/// ```dart
/// final invite = await inviteService.createInvite(
///   sourceType: InviteSourceType.eisenhower,
///   sourceId: 'abc123',
///   sourceName: 'My Matrix',
///   email: 'user@example.com',
///   role: 'editor',
/// );
/// ```
Future<UnifiedInviteModel?> createInvite({...})
```

---

## 14. DECISIONE

**RACCOMANDAZIONE: PROCEDERE CON CENTRALIZZAZIONE**

I benefici superano di gran lunga i costi:
- Codice più manutenibile
- Performance migliori
- Estensibilità garantita
- Consistenza tra strumenti

**Stima tempo implementazione:**
- Fase 1 (Foundation): ~2 ore
- Fase 2 (Aggregator): ~1 ora
- Fase 3 (Widgets): ~3 ore
- Fase 4 (Cleanup): ~1 ora
- Test & Fix: ~2 ore
- **Totale: ~9 ore**

**Rischio: BASSO** con strategia incrementale e feature flag.
