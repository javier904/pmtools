# CFD Analytics - Documentazione Tecnica

## Panoramica

La pagina **CFD Analytics** fornisce una suite completa di metriche Kanban/Lean per analizzare il flusso di lavoro delle liste Smart Todo. È accessibile solo all'owner della lista tramite l'icona grafico nella toolbar.

---

## Architettura

### Componenti Principali

```
lib/
├── screens/smart_todo/
│   └── smart_todo_cfd_screen.dart    # UI principale (~650 righe)
├── services/
│   └── cfd_data_service.dart         # Logica di calcolo (~1000 righe)
└── models/smart_todo/
    └── cfd_metrics_model.dart        # Modelli dati
```

### Flusso Dati

```
Firestore (audit_logs + tasks)
         ↓
   CfdDataService.calculateAnalytics()
         ↓
   CfdAnalyticsData (chartData + metrics)
         ↓
   SmartTodoCfdScreen (UI rendering)
```

---

## Fonte Dati

### Collection Firestore

**Audit Logs**: `smart_todo_lists/{listId}/audit_logs`
```json
{
  "entityType": "task",
  "entityId": "task-uuid",
  "entityName": "Task Title",
  "action": "create | update | move | delete",
  "timestamp": "Timestamp",
  "changes": [
    { "field": "statusId", "previousValue": "todo", "newValue": "in-progress" }
  ]
}
```

**Tasks**: `smart_todo_lists/{listId}/smart_todo_tasks`
```json
{
  "title": "Task Title",
  "statusId": "column-uuid",
  "createdAt": "Timestamp",
  "assignedTo": ["user@email.com"],
  "isArchived": false
}
```

---

## Metriche Calcolate

### 1. Cumulative Flow Diagram (CFD)

**Scopo**: Visualizzare la distribuzione dei task tra le colonne nel tempo.

**Algoritmo**:
1. Per ogni giorno del periodo, ricostruisce lo stato storico
2. Parte dallo stato attuale dei task
3. Applica in reverse gli audit log successivi alla data target
4. Conta i task per colonna

**Codice chiave** (`_calculateTaskCountsAtDate`):
```dart
// Reverse dei log dopo la data target
for (final log in logsAfterTarget.reversed) {
  if (log.action == 'create') {
    taskStates.remove(taskId);  // Task non esisteva ancora
  } else if (log.action == 'move') {
    taskStates[taskId] = previousStatus;  // Ripristina stato precedente
  }
}
```

**Output**: `CfdDataPoint` per ogni giorno con `Map<columnId, count>`

---

### 2. Lead Time

**Definizione**: Tempo totale dalla creazione del task al completamento.

**Formula**:
```
Lead Time = Data Completamento - Data Creazione
```

**Significato per il PM**:
- Rappresenta il tempo che il cliente attende per la consegna
- Include tempo di attesa in backlog + tempo di lavorazione
- Usare P85 per stime conservative verso il cliente

**Metriche derivate**:
| Metrica | Formula | Uso |
|---------|---------|-----|
| Average | Σ(lead_times) / n | Tendenza generale |
| Median | Valore centrale | Meno sensibile a outlier |
| P85 | 85° percentile | Stime realistiche |
| P95 | 95° percentile | Worst case |

**Calcolo Percentile**:
```dart
double _calculatePercentile(List<double> sortedList, int percentile) {
  final index = ((percentile / 100) * (sortedList.length - 1)).round();
  return sortedList[index];
}
```

---

### 3. Cycle Time

**Definizione**: Tempo dalla prima lavorazione al completamento.

**Formula**:
```
Cycle Time = Data Completamento - Data Inizio Lavorazione
```

**Differenza da Lead Time**:
- **Lead Time** = Prospettiva cliente (include attesa)
- **Cycle Time** = Prospettiva team (solo lavoro attivo)

**Identificazione "Inizio Lavorazione"**:
```dart
// Prima volta che il task lascia la colonna To Do
if (previousStatus == todoColumnId && newStatus != todoColumnId) {
  if (!taskStartTimes.containsKey(taskId)) {
    taskStartTimes[taskId] = log.timestamp;  // Solo prima occorrenza
  }
}
```

---

### 4. Throughput

**Definizione**: Velocità di completamento task.

**Formule**:
```
Daily Throughput = Task Completati / Giorni Periodo
Weekly Throughput = Daily Throughput × 7
```

**Uso pratico**:
- Previsione capacità futura
- Stima date di consegna: `Remaining Tasks / Weekly Throughput = Settimane`

---

### 5. WIP (Work In Progress)

**Definizione**: Task attualmente in lavorazione.

**Formula**:
```
WIP = Totale Task - Task in "To Do" - Task in "Done"
```

**WIP Limit suggerito**:
```dart
wipLimit = teamSize × 2;  // Regola empirica Kanban
```

**Legge di Little**:
```
Lead Time = WIP / Throughput
```
Ridurre il WIP riduce il Lead Time!

**Stati WIP**:
| Stato | Condizione | Azione |
|-------|------------|--------|
| Healthy | WIP ≤ Limit | OK |
| Warning | WIP > Limit × 1.25 | Attenzione |
| Critical | WIP > Limit × 1.5 | Bloccare nuovi task |

---

### 6. Flow Metrics

**Definizione**: Confronto tra ritmo di arrivo e completamento.

**Formule**:
```
Arrival Rate = Task Creati / Giorni
Completion Rate = Task Completati / Giorni
Net Flow = Completed - Arrived
```

**Stati flusso**:
| Stato | Condizione | Significato |
|-------|------------|-------------|
| Draining | Completion > Arrival | WIP diminuisce (positivo) |
| Balanced | ±10% | Flusso stabile |
| Filling | Completion < Arrival | WIP aumenta (negativo) |

---

### 7. Bottleneck Detection

**Definizione**: Identifica colonne con accumulo anomalo.

**Algoritmo**:
```dart
// Score basato su conteggio e età
countScore = tasksInColumn / 10.0;  // Normalizzato
ageScore = averageAgeDays / 7.0;    // Normalizzato a settimana
severity = (countScore + ageScore) / 2;  // Range 0-1
```

**Criteri di segnalazione**:
- Task nella colonna ≥ 2, OPPURE
- Età media > 2 giorni

**Livelli severità**:
| Severità | Valore | Azione |
|----------|--------|--------|
| Low | < 0.3 | Monitorare |
| Medium | 0.3-0.6 | Investigare |
| High | > 0.6 | Intervenire |

---

### 8. Aging WIP

**Definizione**: Task in lavorazione ordinati per età.

**Formula età**:
```
Age = Now - Data Inizio Lavorazione (giorni)
```

**Stati età**:
| Stato | Età | Rischio |
|-------|-----|---------|
| Fresh | < 3 giorni | Basso |
| Warning | 3-7 giorni | Medio |
| Critical | > 7 giorni | Alto - possibile blocco |

---

### 9. Trend Calculation

**Definizione**: Confronto con periodo precedente equivalente.

**Formula**:
```
Trend % = ((Valore Corrente - Valore Precedente) / Valore Precedente) × 100
```

**Periodo precedente**:
```dart
// Se periodo corrente = 30 giorni
previousStart = startDate - 30 giorni
previousEnd = startDate - 1 giorno
```

**Interpretazione**:
- **Lead/Cycle Time**: Trend ↓ = miglioramento
- **Throughput**: Trend ↑ = miglioramento

---

## Performance

### Ottimizzazioni implementate

1. **Single query audit logs**: Una sola query Firestore ordinata per timestamp
2. **Reverse reconstruction**: Evita N query per N giorni
3. **In-memory processing**: Tutti i calcoli lato client dopo fetch iniziale

### Complessità

| Operazione | Complessità |
|------------|-------------|
| Fetch audit logs | O(1) query |
| CFD reconstruction | O(days × logs) |
| Lead/Cycle time | O(logs) |
| Bottleneck detection | O(tasks × columns) |

---

## Localizzazione

Supporto completo per 4 lingue:
- English (EN)
- Italiano (IT)
- Français (FR)
- Español (ES)

Chiavi in `lib/l10n/app_*.arb` con prefisso `smartTodoCfd*`

---

## Sicurezza

**Accesso**: Solo owner della lista può vedere la pagina CFD Analytics.

```dart
// In smart_todo_detail_screen.dart
if (currentList.isOwner(_currentUserEmail ?? ''))
  IconButton(
    icon: const Icon(Icons.insights),
    onPressed: () => Navigator.push(...SmartTodoCfdScreen...),
  ),
```

---

## Riferimenti

- **Kanban Metrics**: [Kanban University](https://kanban.university)
- **Little's Law**: `L = λW` (Lead Time = WIP / Throughput)
- **CFD Interpretation**: [ActionableAgile](https://actionableagile.com)

---

## Changelog

### v1.0.0 (Gennaio 2025)
- Implementazione iniziale CFD chart
- Metriche complete: Lead Time, Cycle Time, Throughput, WIP, Flow, Bottlenecks
- Supporto 4 lingue
- Info tooltips con formule e spiegazioni
