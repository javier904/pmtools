# Piano Implementazione: Sistema Archiviazione Completo

## Decisioni Architetturali

### 1. Gestione Agile Projects
- **Solo flag su AgileProjectModel** (`isArchived`)
- Sprint e Stories **NON hanno** `isArchived` proprio
- Ereditano lo stato dal progetto padre
- Query: controllare `project.isArchived` per filtrare sprint/stories

### 2. UI Pattern
- **Toggle "Mostra archiviati"** su tutte le pagine lista/dettaglio
- Toggle nella Global Search
- Consistenza visiva: icona `Icons.archive` / `Icons.unarchive`

### 3. Esclusioni Automatiche
- **Favorites**: Esclusi elementi archiviati
- **Scadenze/Deadlines**: Esclusi elementi archiviati
- **Global Search**: Esclusi di default, visibili con toggle

---

## FASE 1: Modelli (isCompleted + isArchived)

### 1.1 EisenhowerActivityModel - AGGIUNGERE `isCompleted` + `isArchived`
**File**: `lib/models/eisenhower_activity_model.dart`

```dart
// Aggiungere campi:
final bool isCompleted;
final bool isArchived;

// Constructor: aggiungere parametri con default
this.isCompleted = false,
this.isArchived = false,

// toFirestore(): aggiungere
'isCompleted': isCompleted,
'isArchived': isArchived,

// fromFirestore(): aggiungere
isCompleted: (data['isCompleted'] ?? false) as bool,
isArchived: (data['isArchived'] ?? false) as bool,

// copyWith(): aggiungere parametri
bool? isCompleted,
bool? isArchived,
```

### 1.2 EisenhowerMatrixModel - AGGIUNGERE `isArchived`
**File**: `lib/models/eisenhower_matrix_model.dart`

```dart
final bool isArchived;
// default false, stesse modifiche
```

### 1.3 TodoListModel - AGGIUNGERE `isArchived`
**File**: `lib/models/smart_todo/todo_list_model.dart`

```dart
final bool isArchived;
```

### 1.4 TodoTaskModel - AGGIUNGERE `isArchived`
**File**: `lib/models/smart_todo/todo_task_model.dart`

```dart
final bool isArchived;
// Nota: isCompleted già esiste come getter
```

### 1.5 PlanningPokerSessionModel - AGGIUNGERE `isArchived`
**File**: `lib/models/planning_poker_session_model.dart`

```dart
final bool isArchived;
// Nota: isCompleted già esiste come getter su status
```

### 1.6 AgileProjectModel - AGGIUNGERE `isArchived`
**File**: `lib/models/agile_project_model.dart`

```dart
final bool isArchived;
// Sprint e Stories ereditano questo stato
```

### 1.7 RetrospectiveModel - GIÀ COMPLETO
- `isCompleted` ✅ esiste
- `isArchived` ✅ da aggiungere (verificare se esiste)

---

## FASE 2: SubscriptionLimitsService

**File**: `lib/services/subscription/subscription_limits_service.dart`

### Query da Aggiornare:

| Metodo | Filtro da Aggiungere |
|--------|---------------------|
| `countEisenhowerMatrices()` | `.where('isArchived', isEqualTo: false)` |
| `countEstimationSessions()` | `.where('isArchived', isEqualTo: false)` |
| `countSmartTodoLists()` | `.where('isArchived', isEqualTo: false)` |
| `countTasksInEntity()` | `.where('isArchived', isEqualTo: false)` per Eisenhower activities |
| `_countAgileProjects()` | `.where('isArchived', isEqualTo: false)` |
| `countRetrospectives()` | Verificare se già filtrato |

### Logica Conteggio Aggiornata:

```dart
// Smart Todo: escludere liste archiviate E task completati/archiviati
// Eisenhower: escludere matrici archiviate E attività completate/archiviate
// Estimation: escludere sessioni archiviate E completed
// Agile: escludere progetti archiviati
// Retro: escludere retro archiviate E completed
```

---

## FASE 3: Servizi Firestore

### 3.1 EisenhowerFirestoreService
**File**: `lib/services/eisenhower_firestore_service.dart`

**Query da aggiornare**:
- `streamMatrices()` - aggiungere filtro isArchived
- `getActivities()` - aggiungere filtro isArchived (opzionale isCompleted)

**Metodi da aggiungere**:
```dart
Future<void> archiveMatrix(String matrixId);
Future<void> restoreMatrix(String matrixId);
Future<void> completeActivity(String matrixId, String activityId);
Future<void> archiveActivity(String matrixId, String activityId);
Stream<List<EisenhowerMatrixModel>> streamArchivedMatrices(String userEmail);
```

### 3.2 SmartTodoService
**File**: `lib/services/smart_todo_service.dart`

**Metodi da aggiungere**:
```dart
Future<void> archiveList(String listId);
Future<void> restoreList(String listId);
Future<void> archiveTask(String listId, String taskId);
Stream<List<TodoListModel>> streamArchivedLists(String userEmail);
```

### 3.3 PlanningPokerFirestoreService
**File**: `lib/services/planning_poker_firestore_service.dart`

**Metodi da aggiungere**:
```dart
Future<void> archiveSession(String sessionId);
Future<void> restoreSession(String sessionId);
Stream<List<PlanningPokerSessionModel>> streamArchivedSessions(String userEmail);
```

### 3.4 AgileFirestoreService
**File**: `lib/services/agile_firestore_service.dart`

**Metodi da aggiungere**:
```dart
Future<void> archiveProject(String projectId);
Future<void> restoreProject(String projectId);
Stream<List<AgileProjectModel>> streamArchivedProjects(String userEmail);

// Per sprint/stories: query deve controllare project.isArchived
// Aggiungere helper method:
Future<bool> isProjectArchived(String projectId);
```

### 3.5 RetrospectiveFirestoreService
**File**: `lib/services/retrospective_firestore_service.dart`

**Metodi da aggiungere**:
```dart
Future<void> archiveRetrospective(String retroId);
Future<void> restoreRetrospective(String retroId);
```

---

## FASE 4: UI - Toggle e Azioni

### 4.1 Pattern Toggle Riutilizzabile

```dart
// Widget riutilizzabile per toggle archivio
class ArchiveToggle extends StatelessWidget {
  final bool showArchived;
  final ValueChanged<bool> onChanged;

  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(showArchived ? Icons.unarchive : Icons.archive),
        Switch(value: showArchived, onChanged: onChanged),
        Text(showArchived ? 'Nascondi archiviati' : 'Mostra archiviati'),
      ],
    );
  }
}
```

### 4.2 Schermate da Aggiornare

| Schermata | File | Modifiche |
|-----------|------|-----------|
| Eisenhower | `eisenhower_screen.dart` | Toggle + azioni archive su matrici e attività |
| Smart Todo Dashboard | `smart_todo_dashboard.dart` | Toggle + azioni archive su liste |
| Smart Todo List | `smart_todo_list_screen.dart` | Toggle + azioni archive su task |
| Estimation Room | `estimation_room_screen.dart` | Toggle + azioni archive su sessioni |
| Agile Process | `agile_process_screen.dart` | Toggle + azioni archive su progetti |
| Agile Project Detail | `agile_project_detail_screen.dart` | Indicatore se progetto archiviato |
| Retrospective | `retrospective_screen.dart` | Toggle + azioni archive |
| Global Search | `global_search_screen.dart` | Toggle per includere archiviati |

### 4.3 Azioni Context Menu

```dart
// Per ogni elemento archiviabile:
PopupMenuItem(
  value: item.isArchived ? 'restore' : 'archive',
  child: ListTile(
    leading: Icon(item.isArchived ? Icons.unarchive : Icons.archive),
    title: Text(item.isArchived ? 'Ripristina' : 'Archivia'),
  ),
),
```

### 4.4 Stile Visivo Elementi Archiviati

```dart
// Quando mostrati con toggle attivo:
Container(
  decoration: BoxDecoration(
    color: Colors.grey.withOpacity(0.1),
    border: Border.all(color: Colors.grey),
  ),
  child: Opacity(
    opacity: 0.6,
    child: itemWidget,
  ),
),
// Badge "Archiviato"
Chip(label: Text('Archiviato'), backgroundColor: Colors.grey),
```

---

## FASE 5: Esclusioni Specifiche

### 5.1 Favorites (Home Dashboard)
**File**: `lib/screens/home_screen.dart` o `favorites_widget.dart`

```dart
// Escludere elementi archiviati dai preferiti
final activeFavorites = favorites.where((f) => !f.isArchived).toList();
```

### 5.2 Scadenze/Deadlines
**File**: `lib/widgets/deadlines_widget.dart` o simile

```dart
// Escludere task/attività archiviate dalle scadenze
final activeDeadlines = deadlines.where((d) => !d.isArchived).toList();
```

### 5.3 Global Search
**File**: `lib/screens/global_search_screen.dart`

```dart
// Stato per toggle
bool _includeArchived = false;

// Filtrare risultati
final results = allResults.where((r) =>
  _includeArchived || !r.isArchived
).toList();
```

---

## FASE 6: Localizzazione

### Stringhe da Aggiungere (app_it.arb)

```json
"archive": "Archivia",
"restore": "Ripristina",
"archived": "Archiviato",
"showArchived": "Mostra archiviati",
"hideArchived": "Nascondi archiviati",
"archiveConfirmTitle": "Archiviare {itemType}?",
"archiveConfirmMessage": "L'elemento sarà spostato nell'archivio e non apparirà più nelle liste principali.",
"restoreConfirmTitle": "Ripristinare {itemType}?",
"restoreConfirmMessage": "L'elemento sarà ripristinato e visibile nelle liste principali.",
"itemArchived": "{itemType} archiviato",
"itemRestored": "{itemType} ripristinato",
"noArchivedItems": "Nessun elemento archiviato",
"markAsCompleted": "Segna come completato",
"markAsIncomplete": "Segna come non completato",
"completed": "Completato"
```

---

## Ordine di Implementazione

### Step 1: Modelli (30 min)
1. EisenhowerActivityModel - isCompleted + isArchived
2. EisenhowerMatrixModel - isArchived
3. TodoListModel - isArchived
4. TodoTaskModel - isArchived
5. PlanningPokerSessionModel - isArchived
6. AgileProjectModel - isArchived
7. RetrospectiveModel - isArchived (verificare)

### Step 2: SubscriptionLimitsService (20 min)
1. Aggiornare tutte le query di conteggio

### Step 3: Servizi Firestore (45 min)
1. Aggiungere filtri query
2. Aggiungere metodi archive/restore

### Step 4: Localizzazione (10 min)
1. Aggiungere stringhe ARB

### Step 5: UI Schermate (60 min)
1. Eisenhower screen
2. Smart Todo screens
3. Estimation Room screen
4. Agile Process screen
5. Retrospective screen
6. Global Search screen

### Step 6: Esclusioni (15 min)
1. Favorites
2. Deadlines

### Step 7: Test e Build (20 min)
1. flutter analyze
2. flutter build web --release

---

## Note Backward Compatibility

- Tutti i nuovi campi hanno default `false`
- Documenti esistenti funzioneranno senza migrazione
- `fromFirestore()` usa `?? false` per campi mancanti
- Nessun breaking change per utenti esistenti
