import 'package:flutter/material.dart';
import '../services/user_profile_service.dart';

/// Widget per visualizzare il nome di un utente partendo dall'email.
/// Risolve il nome reale tramite UserProfileService e cache.
class UserDisplayName extends StatelessWidget {
  final String email;
  final String? fallback;
  final TextStyle? style;
  final bool overflow;
  final TextAlign? textAlign;

  const UserDisplayName({
    super.key,
    required this.email,
    this.fallback,
    this.style,
    this.overflow = true,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    if (email.isEmpty) return Text('?', style: style);

    return FutureBuilder<String>(
      future: UserProfileService().getNameByEmail(email),
      builder: (context, snapshot) {
        // Se abbiamo i dati, usiamoli
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: style,
            textAlign: textAlign,
            overflow: overflow ? TextOverflow.ellipsis : null,
          );
        }
        
        // Fallback immediato mentre carichiamo (o se errore)
        final displayName = fallback ?? email.split('@').first;
        return Text(
          displayName,
          style: style,
          textAlign: textAlign,
          overflow: overflow ? TextOverflow.ellipsis : null,
        );
      },
    );
  }
}

/// Helper per ottenere il nome in modo sincrono se possibile (fallback se no)
class UserDisplayNameHelper {
  static String getInitialDisplayName(String email, {String? displayName}) {
    if (displayName != null && displayName.isNotEmpty) return displayName;
    if (email.isEmpty) return 'User';
    return email.split('@').first;
  }
}
