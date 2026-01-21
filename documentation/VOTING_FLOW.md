# Flusso di Votazione Collettiva - Matrice di Eisenhower

## Panoramica

Il sistema di votazione della Matrice di Eisenhower segue un flusso controllato a **3 stati** gestito dal facilitatore. Questo garantisce che i voti siano indipendenti e non influenzati dagli altri partecipanti fino al reveal.

## Ruoli

| Ruolo | Descrizione | Può Votare | Può Modificare | Può Avviare | Può Rivelare |
|-------|-------------|------------|----------------|-------------|--------------|
| **Facilitator** | Gestisce la sessione | ✅ | ✅ | ✅ | ✅ |
| **Voter** | Partecipa alla votazione | ✅ (1 volta) | ❌ | ❌ | ❌ |
| **Observer** | Solo visualizzazione | ❌ | ❌ | ❌ | ❌ |

## Schema dei 3 Stati

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    STATO 1: IN ATTESA (isWaitingForVoting)                  │
│                                                                             │
│  isVotingActive = false                                                     │
│  isRevealed = false                                                         │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   FACILITATOR   │  │     VOTER       │  │    OBSERVER     │             │
│  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤             │
│  │ • Vede: "In     │  │ • Vede: "In     │  │ • Vede: "In     │             │
│  │   attesa"       │  │   attesa"       │  │   attesa"       │             │
│  │ • Può: Pre-vota │  │ • Può: Pre-vota │  │ • Non può votare│             │
│  │ • Azione: AVVIA │  │ • Nessuna       │  │ • Nessuna       │             │
│  │   VOTAZIONE     │  │   azione extra  │  │   azione        │             │
│  └────────┬────────┘  └─────────────────┘  └─────────────────┘             │
│           │                                                                 │
│           │  [Facilitatore clicca "Avvia Votazione"]                       │
│           ▼                                                                 │
└─────────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                STATO 2: VOTAZIONE IN CORSO (isVotingInProgress)             │
│                                                                             │
│  isVotingActive = true                                                      │
│  isRevealed = false                                                         │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   FACILITATOR   │  │     VOTER       │  │    OBSERVER     │             │
│  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤             │
│  │ • Vede: X/Y     │  │ • Vede: Solo il │  │ • Vede: X/Y     │             │
│  │   votato (NO    │  │   proprio voto  │  │   votato        │             │
│  │   valori!)      │  │   (U:X I:Y)     │  │ • Non può votare│             │
│  │ • Può: Votare   │  │ • Se non votato:│  │                 │             │
│  │ • Azione:       │  │   "VOTA"        │  │                 │             │
│  │   RIVELA (solo  │  │ • Se votato:    │  │                 │             │
│  │   se TUTTI      │  │   "Hai votato"  │  │                 │             │
│  │   hanno votato) │  │   + U:X I:Y     │  │                 │             │
│  └────────┬────────┘  └─────────────────┘  └─────────────────┘             │
│           │                                                                 │
│           │  [Tutti hanno votato → Facilitatore clicca "Rivela"]           │
│           ▼                                                                 │
└─────────────────────────────────────────────────────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                    STATO 3: RIVELATA (isVotingComplete)                     │
│                                                                             │
│  isRevealed = true                                                          │
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐             │
│  │   FACILITATOR   │  │     VOTER       │  │    OBSERVER     │             │
│  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤             │
│  │ • Vede: Tutti i │  │ • Vede: Tutti i │  │ • Vede: Tutti i │             │
│  │   voti + medie  │  │   voti + medie  │  │   voti + medie  │             │
│  │   + quadrante   │  │   + quadrante   │  │   + quadrante   │             │
│  │ • Azione:       │  │ • Nessuna       │  │ • Nessuna       │             │
│  │   - RESET       │  │   azione (voti  │  │   azione        │             │
│  │   - PROSSIMA    │  │   bloccati)     │  │                 │             │
│  │     ATTIVITÀ    │  │                 │  │                 │             │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Regole Importanti

### Votanti Attesi
Il bottone **"Rivela"** si attiva SOLO quando:
```
readyVoters.length >= voterCount
```

Dove `voterCount` include:
- Tutti i **Voter**
- Il **Facilitatore** stesso (che ha `canVote = true`)

> **NOTA**: `voterCount` include già il facilitatore, quindi NON bisogna aggiungere +1.

### Pre-Voti
- I partecipanti possono votare **prima** che il facilitatore avvii la sessione
- Quando il facilitatore avvia, i pre-voti vengono **preservati** e conteggiati
- I pre-votanti vengono automaticamente aggiunti a `readyVoters`

### Visualizzazione Voto Personale
Durante la votazione (Stato 2), ogni voter vede **solo il proprio voto** sotto forma di `U:X I:Y`.
Gli altri voti rimangono nascosti fino al reveal.

### Posizionamento Quadrante
L'attività viene posizionata nel quadrante **SOLO dopo il reveal** (`isRevealed = true`).
Prima del reveal, il getter `quadrant` ritorna `null` anche se ci sono voti.

### Blocco Voti
Una volta che l'attività è **rivelata** (`isRevealed = true`):
- **Nessuno** può più votare
- Per modificare, il facilitatore deve usare **"Reset"**

### Modifica Voti (SOLO Facilitatore)
- Un **Voter** può votare una sola volta su ogni attività
- Una volta votato, il Voter **NON** può modificare il proprio voto
- Solo il **Facilitatore** può modificare i voti (inclusi i propri)
- Nel menu a 3 puntini, l'opzione "Vota" scompare dopo che il voter ha votato
- Nel dialog sequenziale, il pulsante "Modifica" appare solo al facilitatore

## Flusso Votazione Sequenziale

Il facilitatore può avviare una **votazione sequenziale** su tutte le attività non votate:

```
┌────────────────────────────────────────────────────────────────────────────┐
│                      FLUSSO VOTAZIONE SEQUENZIALE                          │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                            │
│  1. Facilitatore clicca "Avvia Votazione" (vicino a "Aggiungi Attività")  │
│                              │                                             │
│                              ▼                                             │
│  2. Si apre Dialog per ATTIVITÀ 1/N                                       │
│     - Tutti votano                                                        │
│     - Il voter vede il proprio voto (U:X I:Y)                             │
│                              │                                             │
│                              ▼                                             │
│  3. Quando tutti hanno votato, Facilitatore clicca "Rivela"               │
│     - L'attività viene piazzata nel quadrante                             │
│                              │                                             │
│                              ▼                                             │
│  4. Automaticamente si passa a ATTIVITÀ 2/N                               │
│     - Ripete i passi 2-3                                                  │
│                              │                                             │
│                              ▼                                             │
│  5. Alla fine: "Tutte le attività sono state votate!"                     │
│                                                                            │
└────────────────────────────────────────────────────────────────────────────┘
```

Questo flusso evita di dover aprire/chiudere dialog e navigare tra le attività.

## Contatore Partecipanti Online

Nell'AppBar viene mostrato un badge con il conteggio dei partecipanti online nella stanza:

```
[🟢 2/3 👥]   ← 2 partecipanti online su 3 totali
```

- **Verde**: Almeno un partecipante online
- **Grigio**: Nessun partecipante online
- **Heartbeat**: Ogni 30 secondi viene aggiornato lo stato online
- **Timeout**: Un utente è considerato offline dopo 2 minuti di inattività

## Campi Firestore per Attività

```javascript
activities/{activityId}: {
  // Campi base
  title: string,
  description: string,
  createdAt: timestamp,
  tags: string[],

  // Voti (Map con email escapate)
  votes: {
    "user@example_DOT_com": {
      urgency: 7,
      importance: 9
    }
  },

  // Stato votazione
  isVotingActive: boolean,   // true = Stato 2
  isRevealed: boolean,       // true = Stato 3
  votingStartedAt: timestamp | null,
  revealedAt: timestamp | null,
  readyVoters: string[],     // Email di chi ha votato

  // Valori aggregati (calcolati SOLO al reveal)
  aggregatedUrgency: number,
  aggregatedImportance: number,
  quadrant: string | null,   // "q1", "q2", "q3", "q4" - solo dopo reveal
  voteCount: number
}
```

## Campi Firestore per Partecipanti (Presenza)

```javascript
matrices/{matrixId}: {
  participants: {
    "user@example_DOT_com": {
      name: string,
      role: "facilitator" | "voter" | "observer",
      isOnline: boolean,
      lastActivity: timestamp,
      joinedAt: timestamp
    }
  }
}
```

## Helper nel Model

```dart
/// STATO 1: In attesa che il facilitatore avvii la votazione
bool get isWaitingForVoting => !isVotingActive && !isRevealed;

/// STATO 2: Votazione in corso (facilitatore ha avviato)
bool get isVotingInProgress => isVotingActive && !isRevealed;

/// STATO 3: Votazione completata e rivelata
bool get isVotingComplete => isRevealed;

/// Quadrante - ritorna null se non rivelata (anche se ci sono voti)
EisenhowerQuadrant? get quadrant {
  if (!isRevealed) return null;  // 🔧 FIX: Solo dopo reveal
  if (!hasVotes) return null;
  return calculateQuadrant(aggregatedUrgency, aggregatedImportance);
}
```

## Metodi Firestore Service

| Metodo | Descrizione |
|--------|-------------|
| `startVotingSession()` | Stato 1 → 2, preserva pre-voti |
| `submitBlindedVote()` | Salva voto nascosto |
| `markVoterReady()` | Aggiunge email a readyVoters |
| `revealVotes()` | Stato 2 → 3, calcola aggregati e quadrante |
| `resetVotingSession()` | Stato 3 → 1, cancella tutto |
| `updateParticipantOnlineStatus()` | Aggiorna stato online/offline |
| `streamActivity()` | Stream real-time per singola attività |
| `streamActivities()` | Stream real-time per tutte le attività |
| `streamMatrix()` | Stream real-time per matrice/partecipanti |

## UI Feedback

### Stato 1 (In Attesa)
- Badge grigio "In attesa"
- Bottone "Pre-vota" (outline)
- Badge verde "Hai pre-votato" se votato
- Bottone blu "Avvia Votazione" (solo facilitatore)

### Stato 2 (Votazione In Corso)
- Badge blu "Votazione in corso"
- Progress bar X/Y
- Bottone "VOTA" se non hai votato
- Badge verde "Hai votato" + **U:X I:Y** se votato (solo il proprio voto visibile!)
- Bottone "RIVELA" (abilitato solo se tutti hanno votato)

### Stato 3 (Rivelata)
- Tutti i voti visibili con nome partecipante
- Media urgenza/importanza
- Quadrante finale con colore e icona
- Attività posizionata nella griglia del quadrante
- Bottone "Reset" e "Prossima Attività" (facilitatore)

## Traduzioni Chiave

| Chiave | IT | EN |
|--------|----|---|
| `eisenhowerWaitingForStart` | In attesa | Waiting |
| `eisenhowerPreVote` | Pre-vota | Pre-vote |
| `eisenhowerPreVoted` | Hai pre-votato | Pre-voted |
| `eisenhowerStartVoting` | Avvia Votazione | Start Voting |
| `eisenhowerVotedSuccess` | Hai votato | Voted |
| `eisenhowerRevealVotes` | RIVELA VOTI | REVEAL VOTES |
| `eisenhowerVotingLocked` | Votazione chiusa | Voting closed |
| `eisenhowerOnlineParticipants` | X di Y partecipanti online | X of Y participants online |
| `eisenhowerVoting` | Votazione | Voting |
| `eisenhowerAllActivitiesVoted` | Tutte le attività sono state votate! | All activities have been voted! |
