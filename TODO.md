# Agile Tools - TODO

## Stato Attuale
- [x] Progetto Flutter creato
- [x] Firebase project creato (`pm-agile-tools-app`)
- [x] Authentication abilitato (Google + Email/Password)
- [x] Firestore creato
- [x] Hosting attivo
- [x] File copiati dal PMO Dashboard
- [x] pubspec.yaml configurato
- [x] auth_service.dart creato
- [x] main.dart creato
- [x] home_screen.dart creato
- [x] login_screen.dart creato
- [x] flutter pub get eseguito
- [x] firebase_options.dart generato
- [x] estimation_room_screen.dart pulito
- [x] session_form_dialog.dart pulito
- [x] eisenhower_screen.dart pulito
- [x] eisenhower_firestore_service.dart creato
- [x] Build web completato
- [x] Deploy su Firebase Hosting completato

---

## ATTIVITA' COMPLETATE

### 1. Configurazione Firebase
- [x] Eseguire `flutter pub get`
- [x] Generare firebase_options.dart con `flutterfire configure`
- [x] Configurare firebase.json per hosting

### 2. Pulizia estimation_room_screen.dart
- [x] Rinominare PlanningPokerScreen -> EstimationRoomScreen
- [x] Aggiornare import widget path da planning_poker/ a estimation_room/
- [x] Rimuovere import audit_log_service.dart e audit_log_model.dart
- [x] Rimuovere import googleapis/gmail e http
- [x] Rimuovere riferimenti a ImportTasksDialog
- [x] Rimuovere metodo _showImportTasksDialog()

### 3. Pulizia session_form_dialog.dart
- [x] Rimuovere import team_model, business_unit_model, project_model
- [x] Rimuovere variabili teams, businessUnits, projects
- [x] Rimuovere metodo _loadIntegrationData()
- [x] Rimuovere sezione UI "Integrazioni (opzionali)"
- [x] Rimuovere dal risultato _save() riferimenti a team, BU, project

### 4. Pulizia eisenhower_screen.dart
- [x] Rimuovere import non esistenti
- [x] Rimuovere riferimenti a servizi PMO
- [x] Rimuovere export Google Sheets

### 5. Creazione eisenhower_firestore_service.dart
- [x] Creare servizio standalone per matrici Eisenhower
- [x] Implementare metodi CRUD per matrici e attivita'
- [x] Implementare metodi per voti e partecipanti
- [x] Correggere firme metodi per compatibilita' con screen

### 6. Widget estimation_room/
- [x] Eliminare import_tasks_dialog.dart (non applicabile)
- [x] Verificare altri widget

### 7. Build & Deploy
- [x] flutter analyze - nessun errore
- [x] flutter build web --release
- [x] firebase deploy --only hosting

---

## URL Produzione

**Hosting URL**: https://pm-agile-tools-app.web.app

---

## Funzionalita' Future (PRIORITA' BASSA)

- [ ] Implementare import attivita' da CSV
- [ ] Implementare import attivita' da testo (copia/incolla)
- [ ] Implementare export risultati (CSV/PDF)
- [ ] Creare landing page pubblica (pre-login)
- [ ] Aggiungere test automatici
- [ ] Configurare Firestore Security Rules

---

## Comandi Rapidi

```bash
# Dalla cartella agile_tools:

# Dipendenze
flutter pub get

# Analizza errori
flutter analyze

# Test locale
flutter run -d chrome

# Build
flutter build web --release

# Deploy
firebase deploy --only hosting
```

---

## Note

- Il progetto Firebase si chiama `pm-agile-tools-app`
- Hosting URL: https://pm-agile-tools-app.web.app/
- I file sono stati puliti da tutti i riferimenti al PMO Dashboard
- L'app e' completamente standalone
