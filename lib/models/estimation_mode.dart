/// Modalità di stima per Planning Poker
/// Ogni modalità ha caratteristiche specifiche per la votazione
enum EstimationMode {
  /// Fibonacci classico con carte predefinite (0, 1, 2, 3, 5, 8, 13, 20, 40, 100, ?, ☕)
  fibonacci,

  /// T-shirt sizes (XS, S, M, L, XL, XXL)
  tshirt,

  /// Input decimale libero (1.25, 1.5, 2.75, ecc.)
  decimal,

  /// Three-point estimation (PERT): (O + 4M + P) / 6
  threePoint,

  /// Dot Voting / Silent Brainstorming - allocazione punti
  dotVoting,

  /// Bucket System - stima per affinità
  bucketSystem,

  /// Five Fingers - votazione rapida 1-5
  fiveFingers,
}

/// Extension per EstimationMode con proprietà e metodi utili
extension EstimationModeExtension on EstimationMode {
  /// Nome visualizzato della modalità
  String get displayName {
    switch (this) {
      case EstimationMode.fibonacci:
        return 'Fibonacci';
      case EstimationMode.tshirt:
        return 'T-Shirt Sizes';
      case EstimationMode.decimal:
        return 'Decimale';
      case EstimationMode.threePoint:
        return 'Three-Point (PERT)';
      case EstimationMode.dotVoting:
        return 'Dot Voting';
      case EstimationMode.bucketSystem:
        return 'Bucket System';
      case EstimationMode.fiveFingers:
        return 'Five Fingers';
    }
  }

  /// Descrizione della modalità
  String get description {
    switch (this) {
      case EstimationMode.fibonacci:
        return 'Sequenza Fibonacci classica con carte predefinite';
      case EstimationMode.tshirt:
        return 'Stima con taglie: XS, S, M, L, XL, XXL';
      case EstimationMode.decimal:
        return 'Inserimento libero di valori decimali (es: 1.5, 2.75)';
      case EstimationMode.threePoint:
        return 'Stima PERT: (Ottimistica + 4×Realistica + Pessimistica) / 6';
      case EstimationMode.dotVoting:
        return 'Allocazione punti per votazione silenziosa';
      case EstimationMode.bucketSystem:
        return 'Raggruppamento per affinità di complessità';
      case EstimationMode.fiveFingers:
        return 'Votazione rapida con le dita (1-5)';
    }
  }

  /// Icona Material per la modalità (nome stringa)
  String get iconName {
    switch (this) {
      case EstimationMode.fibonacci:
        return 'style';
      case EstimationMode.tshirt:
        return 'checkroom';
      case EstimationMode.decimal:
        return 'calculate';
      case EstimationMode.threePoint:
        return 'functions_rounded'; // Sigma/PERT formula
      case EstimationMode.dotVoting:
        return 'radio_button_checked';
      case EstimationMode.bucketSystem:
        return 'inventory_2_rounded'; // Bucket/box icon
      case EstimationMode.fiveFingers:
        return 'pan_tool';
    }
  }


  /// Indica se questa modalità produce valori sincronizzabili con Gantt
  /// Solo le modalità che producono valori numerici possono essere sincronizzate
  bool get isSyncable {
    switch (this) {
      case EstimationMode.fibonacci:
        return true; // Produce numeri interi
      case EstimationMode.tshirt:
        return false; // Non numerico
      case EstimationMode.decimal:
        return true; // Produce numeri decimali
      case EstimationMode.threePoint:
        return true; // Produce valore PERT numerico
      case EstimationMode.dotVoting:
        return false; // Produce ranking, non stime
      case EstimationMode.bucketSystem:
        return false; // Produce gruppi, non stime individuali
      case EstimationMode.fiveFingers:
        return true; // Produce numeri 1-5
    }
  }

  /// Indica se supporta valori decimali
  bool get supportsDecimals {
    switch (this) {
      case EstimationMode.decimal:
        return true;
      case EstimationMode.threePoint:
        return true; // Il risultato PERT può essere decimale
      default:
        return false;
    }
  }

  /// Indica se è una votazione con carte
  bool get usesCards {
    switch (this) {
      case EstimationMode.fibonacci:
      case EstimationMode.tshirt:
      case EstimationMode.fiveFingers:
        return true;
      default:
        return false;
    }
  }

  /// Indica se richiede input multipli (come three-point)
  bool get requiresMultipleInputs {
    return this == EstimationMode.threePoint;
  }

  /// Indica se è una modalità di gruppo (tutti vedono le stesse opzioni)
  bool get isGroupMode {
    switch (this) {
      case EstimationMode.dotVoting:
      case EstimationMode.bucketSystem:
        return true;
      default:
        return false;
    }
  }

  /// Restituisce le carte/opzioni per questa modalità
  List<String> get defaultCards {
    switch (this) {
      case EstimationMode.fibonacci:
        return ['0', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?', '☕'];
      case EstimationMode.tshirt:
        return ['XS', 'S', 'M', 'L', 'XL', 'XXL', '?', '☕'];
      case EstimationMode.fiveFingers:
        return ['1', '2', '3', '4', '5'];
      case EstimationMode.decimal:
        return []; // Input libero
      case EstimationMode.threePoint:
        return []; // Input multipli O, M, P
      case EstimationMode.dotVoting:
        return []; // Dipende dalle opzioni
      case EstimationMode.bucketSystem:
        return ['XS', 'S', 'M', 'L', 'XL']; // Bucket predefiniti
    }
  }

  /// Nome per serializzazione
  String get name {
    switch (this) {
      case EstimationMode.fibonacci:
        return 'fibonacci';
      case EstimationMode.tshirt:
        return 'tshirt';
      case EstimationMode.decimal:
        return 'decimal';
      case EstimationMode.threePoint:
        return 'threePoint';
      case EstimationMode.dotVoting:
        return 'dotVoting';
      case EstimationMode.bucketSystem:
        return 'bucketSystem';
      case EstimationMode.fiveFingers:
        return 'fiveFingers';
    }
  }

  /// Crea da stringa
  static EstimationMode fromString(String? value) {
    switch (value) {
      case 'fibonacci':
        return EstimationMode.fibonacci;
      case 'tshirt':
        return EstimationMode.tshirt;
      case 'decimal':
        return EstimationMode.decimal;
      case 'threePoint':
        return EstimationMode.threePoint;
      case 'dotVoting':
        return EstimationMode.dotVoting;
      case 'bucketSystem':
        return EstimationMode.bucketSystem;
      case 'fiveFingers':
        return EstimationMode.fiveFingers;
      default:
        return EstimationMode.fibonacci; // Default
    }
  }
}

/// Bucket predefiniti per Bucket System
class BucketSystemConfig {
  static const List<String> defaultBuckets = ['XS', 'S', 'M', 'L', 'XL'];

  /// Mappa bucket a valori numerici (per eventuale sincronizzazione)
  static const Map<String, double> bucketValues = {
    'XS': 0.5,
    'S': 1,
    'M': 2,
    'L': 3,
    'XL': 5,
  };
}

/// Configurazione per Dot Voting
class DotVotingConfig {
  /// Numero default di punti per partecipante
  static const int defaultPointsPerUser = 5;

  /// Range punti allocabili
  static const int minPoints = 1;
  static const int maxPoints = 10;
}

/// Configurazione per Three-Point Estimation
class ThreePointConfig {
  /// Calcola il valore PERT: (O + 4M + P) / 6
  static double calculatePERT(double optimistic, double mostLikely, double pessimistic) {
    return (optimistic + (4 * mostLikely) + pessimistic) / 6;
  }

  /// Calcola la deviazione standard: (P - O) / 6
  static double calculateStandardDeviation(double optimistic, double pessimistic) {
    return (pessimistic - optimistic) / 6;
  }

  /// Calcola la varianza
  static double calculateVariance(double optimistic, double pessimistic) {
    final sd = calculateStandardDeviation(optimistic, pessimistic);
    return sd * sd;
  }
}
