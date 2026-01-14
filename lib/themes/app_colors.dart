import 'package:flutter/material.dart';

/// Colori centralizzati per l'app Agile Tools
/// Supporta Dark Mode e Light Mode
class AppColors {
  // ══════════════════════════════════════════════════════════════════════════
  // DARK MODE COLORS (Stile Appwrite - leggermente più chiaro)
  // ══════════════════════════════════════════════════════════════════════════

  static const darkBackground = Color(0xFF1A1A1F);        // Sfondo principale (più chiaro)
  static const darkSurface = Color(0xFF242429);           // Card, dialogs
  static const darkSurfaceVariant = Color(0xFF2D2D33);    // Elementi elevati
  static const darkBorder = Color(0xFF3A3A42);            // Bordi
  static const darkBorderSubtle = Color(0xFF2F2F37);      // Bordi sottili

  static const darkTextPrimary = Color(0xFFFFFFFF);       // Testo principale
  static const darkTextSecondary = Color(0xFFB0B0B8);     // Testo secondario
  static const darkTextTertiary = Color(0xFF75757F);      // Testo terziario
  static const darkTextMuted = Color(0xFF55555F);         // Testo muted

  // ══════════════════════════════════════════════════════════════════════════
  // LIGHT MODE COLORS
  // ══════════════════════════════════════════════════════════════════════════

  static const lightBackground = Color(0xFFF8F9FA);       // Sfondo principale
  static const lightSurface = Color(0xFFFFFFFF);          // Card, dialogs
  static const lightSurfaceVariant = Color(0xFFF1F3F5);   // Elementi elevati
  static const lightBorder = Color(0xFFE1E4E8);           // Bordi
  static const lightBorderSubtle = Color(0xFFEEF0F2);     // Bordi sottili

  static const lightTextPrimary = Color(0xFF1A1A1F);      // Testo principale
  static const lightTextSecondary = Color(0xFF5A5A65);    // Testo secondario
  static const lightTextTertiary = Color(0xFF8A8A95);     // Testo terziario
  static const lightTextMuted = Color(0xFFAAAAAF);        // Testo muted

  // ══════════════════════════════════════════════════════════════════════════
  // ACCENT COLORS (Uguali per entrambi i temi)
  // ══════════════════════════════════════════════════════════════════════════

  // Primary - Viola
  static const primary = Color(0xFF6C5CE7);
  static const primaryLight = Color(0xFFA29BFE);
  static const primaryDark = Color(0xFF5849C2);

  // Secondary - Blu
  static const secondary = Color(0xFF0984E3);
  static const secondaryLight = Color(0xFF74B9FF);
  static const secondaryDark = Color(0xFF0767B3);

  // Success - Verde
  static const success = Color(0xFF00B894);
  static const successLight = Color(0xFF55EFC4);
  static const successDark = Color(0xFF009975);

  // Warning - Arancione
  static const warning = Color(0xFFFDAA5A);
  static const warningLight = Color(0xFFFECE8A);
  static const warningDark = Color(0xFFE09040);

  // Error - Rosso
  static const error = Color(0xFFE74C3C);
  static const errorLight = Color(0xFFFF7675);
  static const errorDark = Color(0xFFC0392B);

  // Info - Teal
  static const info = Color(0xFF00CEC9);
  static const infoLight = Color(0xFF81ECEC);
  static const infoDark = Color(0xFF00A8A3);

  // Pink
  static const pink = Color(0xFFFD79A8);
  static const pinkLight = Color(0xFFFFB8D1);
  static const pinkDark = Color(0xFFE84393);

  // ══════════════════════════════════════════════════════════════════════════
  // EISENHOWER QUADRANT COLORS
  // ══════════════════════════════════════════════════════════════════════════

  // Q1 - Urgente e Importante (Rosso)
  static const q1Color = Color(0xFFE74C3C);
  static const q1ColorLight = Color(0xFFFFEBEE);
  static const q1ColorDark = Color(0xFF3D1A16);

  // Q2 - Non Urgente ma Importante (Verde)
  static const q2Color = Color(0xFF00B894);
  static const q2ColorLight = Color(0xFFE8F8F5);
  static const q2ColorDark = Color(0xFF0D2E27);

  // Q3 - Urgente ma Non Importante (Giallo/Arancio)
  static const q3Color = Color(0xFFF39C12);
  static const q3ColorLight = Color(0xFFFFF8E1);
  static const q3ColorDark = Color(0xFF3D2F0D);

  // Q4 - Non Urgente e Non Importante (Grigio)
  static const q4Color = Color(0xFF95A5A6);
  static const q4ColorLight = Color(0xFFF5F5F5);
  static const q4ColorDark = Color(0xFF2D2D33);

  // ══════════════════════════════════════════════════════════════════════════
  // FRAMEWORK COLORS (Agile Process)
  // ══════════════════════════════════════════════════════════════════════════

  static const scrumColor = Color(0xFF0984E3);     // Blu
  static const kanbanColor = Color(0xFF00B894);    // Verde
  static const hybridColor = Color(0xFF6C5CE7);    // Viola

  // ══════════════════════════════════════════════════════════════════════════
  // STATUS COLORS
  // ══════════════════════════════════════════════════════════════════════════

  static const statusTodo = Color(0xFF95A5A6);
  static const statusInProgress = Color(0xFF0984E3);
  static const statusInReview = Color(0xFFF39C12);
  static const statusDone = Color(0xFF00B894);
  static const statusBlocked = Color(0xFFE74C3C);

  // ══════════════════════════════════════════════════════════════════════════
  // GRADIENT DEFINITIONS
  // ══════════════════════════════════════════════════════════════════════════

  static const primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
