# Piano: Sistema Feedback Utente (Stelline)

## Concetto
Al 3° login, compare un popup non invadente che chiede una valutazione in stelline (1-5) con commento opzionale. Se l'utente valuta, non si chiede più. Se declina ("Non ora"), si ripropone al login successivo.

## Storage: `moduleSettings` (zero modifiche ai modelli)

Usa il campo `moduleSettings` già esistente in `UserSettingsModel` per salvare lo stato feedback:

```
users/{uid}/settings/preferences.moduleSettings.feedback = {
  "loginCount": 5,           // contatore login
  "rating": 4,               // stelline (1-5), null se non ancora votato
  "comment": "Ottima app",   // commento opzionale
  "ratedAt": "2026-02-23T...", // quando ha votato
  "dismissed": false          // true se ha cliccato "Non ora" nell'ultimo prompt
}
```

## File da modificare

### 1. `lib/services/user_profile_service.dart`
- In `createOrUpdateProfileFromAuth()`: incrementare `moduleSettings.feedback.loginCount` ad ogni login

### 2. `lib/screens/home_screen.dart`
- In `_initUserLocale()` (post-login): aggiungere `_checkFeedbackPrompt()` che legge `moduleSettings.feedback`, verifica condizioni (loginCount >= 3, nessun rating, non dismissed), e mostra il dialog

### 3. `lib/widgets/feedback_dialog.dart` (NUOVO - unico file nuovo)
- Dialog con:
  - Icona stellina in cerchio (stile LimitReachedDialog)
  - Titolo localizzato "Come ti trovi con Keisen?"
  - 5 stelline tappabili (gialle)
  - TextField commento opzionale
  - Bottone "Invia" (salva su Firestore) + "Non ora" (setta dismissed=true)
  - Design coerente con `LimitReachedDialog` (BorderRadius 20, contentPadding zero, width 400)

### 4. `lib/l10n/app_it.arb`, `app_en.arb`, `app_fr.arb`, `app_es.arb`
- Aggiungere ~6 chiavi di traduzione: titolo, sottotitolo, placeholder commento, bottone invia, bottone non ora, messaggio ringraziamento

## Logica trigger

```
loginCount >= 3
AND rating == null (non ha mai votato)
AND dismissed == false (non ha cliccato "Non ora" in questa sessione)
→ mostra dialog dopo 2 secondi di delay (non invadente)
```

Se "Non ora" → `dismissed = true`. Al login successivo `dismissed` viene resettato a `false` e il contatore incrementato, quindi si ripropone.

Se vota → `rating` salvato, non si chiede mai più.

## Flusso

1. Login → `createOrUpdateProfileFromAuth()` → incrementa `loginCount`, resetta `dismissed = false`
2. HomeScreen init → `_checkFeedbackPrompt()` → legge settings
3. Se condizioni soddisfatte → delay 2s → `FeedbackDialog.show(context)`
4. Utente vota → salva `rating`, `comment`, `ratedAt` in moduleSettings → SnackBar ringraziamento
5. Utente declina → salva `dismissed = true` → si ripropone al prossimo login
