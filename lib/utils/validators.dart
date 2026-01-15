/// Validatori centralizzati per form e input dell'applicazione.
///
/// Uso con TextFormField:
/// ```dart
/// TextFormField(
///   validator: Validators.email,
///   // oppure
///   validator: (v) => Validators.title(v, fieldName: 'Nome sessione'),
/// )
/// ```
class Validators {
  // ══════════════════════════════════════════════════════════════════════════
  // COSTANTI - Lunghezze massime
  // ══════════════════════════════════════════════════════════════════════════

  /// Lunghezza massima per titoli brevi (sessioni, matrici, etc.)
  static const int maxTitleLength = 100;

  /// Lunghezza massima per descrizioni
  static const int maxDescriptionLength = 1000;

  /// Lunghezza massima per email (RFC 5321)
  static const int maxEmailLength = 254;

  /// Lunghezza massima per nomi di persone
  static const int maxNameLength = 50;

  /// Lunghezza massima per tag singoli
  static const int maxTagLength = 30;

  /// Lunghezza minima password
  static const int minPasswordLength = 8;

  /// Lunghezza massima password
  static const int maxPasswordLength = 128;

  // ══════════════════════════════════════════════════════════════════════════
  // VALIDATORI
  // ══════════════════════════════════════════════════════════════════════════

  /// Valida indirizzo email
  ///
  /// Ritorna null se valido, altrimenti messaggio di errore.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email obbligatoria';
    }
    final trimmed = value.trim();
    if (trimmed.length > maxEmailLength) {
      return 'Email troppo lunga (max $maxEmailLength caratteri)';
    }
    // RFC 5322 simplified regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Formato email non valido';
    }
    return null;
  }

  /// Valida password
  ///
  /// Requisiti minimi:
  /// - Almeno 8 caratteri
  /// - Massimo 128 caratteri
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password obbligatoria';
    }
    if (value.length < minPasswordLength) {
      return 'Minimo $minPasswordLength caratteri';
    }
    if (value.length > maxPasswordLength) {
      return 'Password troppo lunga';
    }
    return null;
  }

  /// Valida password con conferma
  ///
  /// [value] Password di conferma
  /// [originalPassword] Password originale da confrontare
  static String? confirmPassword(String? value, String originalPassword) {
    final passwordError = password(value);
    if (passwordError != null) return passwordError;
    if (value != originalPassword) {
      return 'Le password non coincidono';
    }
    return null;
  }

  /// Valida password con requisiti di complessità
  ///
  /// Richiede almeno:
  /// - 8 caratteri
  /// - Una lettera maiuscola
  /// - Una lettera minuscola
  /// - Un numero
  static String? strongPassword(String? value) {
    final basicError = password(value);
    if (basicError != null) return basicError;

    if (!RegExp(r'[A-Z]').hasMatch(value!)) {
      return 'Richiede almeno una maiuscola';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Richiede almeno una minuscola';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Richiede almeno un numero';
    }
    return null;
  }

  /// Valida titolo generico (sessione, matrice, progetto, etc.)
  ///
  /// [value] Valore da validare
  /// [fieldName] Nome campo per messaggi di errore
  /// [required] Se il campo è obbligatorio (default: true)
  static String? title(
    String? value, {
    String fieldName = 'Titolo',
    bool required = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return required ? '$fieldName obbligatorio' : null;
    }
    final trimmed = value.trim();
    if (trimmed.length > maxTitleLength) {
      return '$fieldName troppo lungo (max $maxTitleLength caratteri)';
    }
    return null;
  }

  /// Valida descrizione o testo lungo
  ///
  /// [value] Valore da validare
  /// [required] Se il campo è obbligatorio (default: false)
  /// [maxLength] Lunghezza massima personalizzata
  static String? description(
    String? value, {
    bool required = false,
    int? maxLength,
  }) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'Descrizione obbligatoria' : null;
    }
    final max = maxLength ?? maxDescriptionLength;
    if (value.length > max) {
      return 'Testo troppo lungo (max $max caratteri)';
    }
    return null;
  }

  /// Valida nome di persona
  ///
  /// Permette lettere (incluse accentate), spazi, trattini e punti.
  static String? name(String? value, {String fieldName = 'Nome'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName obbligatorio';
    }
    final trimmed = value.trim();
    if (trimmed.length > maxNameLength) {
      return '$fieldName troppo lungo (max $maxNameLength caratteri)';
    }
    // Permette lettere Unicode, spazi, trattini, punti
    if (!RegExp(r'^[\p{L}\s\-\.]+$', unicode: true).hasMatch(trimmed)) {
      return '$fieldName contiene caratteri non validi';
    }
    return null;
  }

  /// Valida singolo tag
  static String? tag(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tag obbligatorio';
    }
    final trimmed = value.trim();
    if (trimmed.length > maxTagLength) {
      return 'Tag troppo lungo (max $maxTagLength caratteri)';
    }
    // Solo lettere, numeri, trattini
    if (!RegExp(r'^[\w\-]+$', unicode: true).hasMatch(trimmed)) {
      return 'Tag: solo lettere, numeri e trattini';
    }
    return null;
  }

  /// Valida numero intero positivo
  ///
  /// [value] Valore stringa da validare
  /// [fieldName] Nome campo per messaggi
  /// [min] Valore minimo (default: 0)
  /// [max] Valore massimo (opzionale)
  static String? positiveInteger(
    String? value, {
    String fieldName = 'Valore',
    int min = 0,
    int? max,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName obbligatorio';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null) {
      return '$fieldName deve essere un numero intero';
    }
    if (parsed < min) {
      return '$fieldName deve essere almeno $min';
    }
    if (max != null && parsed > max) {
      return '$fieldName deve essere massimo $max';
    }
    return null;
  }

  /// Valida numero decimale positivo
  static String? positiveDouble(
    String? value, {
    String fieldName = 'Valore',
    double min = 0,
    double? max,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName obbligatorio';
    }
    // Supporta sia , che . come separatore decimale
    final normalized = value.trim().replaceAll(',', '.');
    final parsed = double.tryParse(normalized);
    if (parsed == null) {
      return '$fieldName deve essere un numero';
    }
    if (parsed < min) {
      return '$fieldName deve essere almeno $min';
    }
    if (max != null && parsed > max) {
      return '$fieldName deve essere massimo $max';
    }
    return null;
  }

  /// Valida URL
  static String? url(String? value, {bool required = false}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'URL obbligatorio' : null;
    }
    final trimmed = value.trim();
    try {
      final uri = Uri.parse(trimmed);
      if (!uri.hasScheme || (!uri.isScheme('http') && !uri.isScheme('https'))) {
        return 'URL deve iniziare con http:// o https://';
      }
      if (uri.host.isEmpty) {
        return 'URL non valido';
      }
    } catch (_) {
      return 'URL non valido';
    }
    return null;
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SANITIZZAZIONE
  // ══════════════════════════════════════════════════════════════════════════

  /// Sanitizza input per prevenire XSS
  ///
  /// Escapa i caratteri HTML potenzialmente pericolosi.
  static String sanitizeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .trim();
  }

  /// Rimuove spazi multipli e trim
  static String normalizeWhitespace(String input) {
    return input.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Sanitizza e normalizza input testuale
  static String sanitize(String input) {
    return normalizeWhitespace(sanitizeHtml(input));
  }

  /// Valida e pulisce lista email (per inviti multipli)
  ///
  /// Ritorna lista di email valide oppure null se ci sono errori.
  /// [errorCallback] viene chiamata con il messaggio di errore se presente.
  static List<String>? validateEmailList(
    String input, {
    void Function(String error)? errorCallback,
    int maxEmails = 50,
  }) {
    if (input.trim().isEmpty) {
      errorCallback?.call('Inserisci almeno un indirizzo email');
      return null;
    }

    // Split per virgola, punto e virgola, o newline
    final parts = input.split(RegExp(r'[,;\n]'));
    final emails = <String>[];
    final errors = <String>[];

    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;

      final error = email(trimmed);
      if (error != null) {
        errors.add('$trimmed: $error');
      } else {
        emails.add(trimmed.toLowerCase());
      }
    }

    if (errors.isNotEmpty) {
      errorCallback?.call(errors.join('\n'));
      return null;
    }

    if (emails.isEmpty) {
      errorCallback?.call('Nessuna email valida trovata');
      return null;
    }

    if (emails.length > maxEmails) {
      errorCallback?.call('Massimo $maxEmails email alla volta');
      return null;
    }

    // Rimuove duplicati
    return emails.toSet().toList();
  }
}
