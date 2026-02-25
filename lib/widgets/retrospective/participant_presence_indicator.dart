import 'package:flutter/material.dart';
import '../../models/retrospective_model.dart';
import '../../services/user_profile_service.dart';
import '../user_display_name_widget.dart';

/// Widget indicatore di presenza online per i partecipanti della retrospettiva.
///
/// Mostra un pallino colorato:
/// - Verde: partecipante online
/// - Grigio: partecipante offline
class ParticipantPresenceIndicator extends StatelessWidget {
  final bool isOnline;
  final double size;

  const ParticipantPresenceIndicator({
    super.key,
    required this.isOnline,
    this.size = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isOnline ? 'Online' : 'Offline',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isOnline ? Colors.green : Colors.grey,
          boxShadow: isOnline
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  /// Factory per calcolare lo stato online da ParticipantPresence
  ///
  /// Considera il threshold di 45 secondi per determinare
  /// se il partecipante è effettivamente online.
  static bool isParticipantOnline(
    String email,
    Map<String, ParticipantPresence>? presence,
  ) {
    if (presence == null || !presence.containsKey(email)) {
      return false;
    }

    final p = presence[email]!;
    return p.isEffectivelyOnline;
  }
}

/// Widget con avatar e indicatore di presenza combinati
class ParticipantAvatarWithPresence extends StatefulWidget {
  final String email;
  final String? displayName;
  final bool isOnline;
  final double avatarRadius;

  const ParticipantAvatarWithPresence({
    super.key,
    required this.email,
    this.displayName,
    required this.isOnline,
    this.avatarRadius = 16,
  });

  @override
  State<ParticipantAvatarWithPresence> createState() => _ParticipantAvatarWithPresenceState();
}

class _ParticipantAvatarWithPresenceState extends State<ParticipantAvatarWithPresence> {
  String? _resolvedName;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  @override
  void didUpdateWidget(ParticipantAvatarWithPresence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.email != widget.email) {
      _resolvedName = null;
      _loadName();
    }
  }

  Future<void> _loadName() async {
    final name = await UserProfileService().getNameByEmail(widget.email);
    if (mounted) {
      setState(() => _resolvedName = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _resolvedName ?? widget.displayName ?? widget.email.split('@').first;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Stack(
      children: [
        CircleAvatar(
          radius: widget.avatarRadius,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            initial,
            style: TextStyle(
              fontSize: widget.avatarRadius * 0.8,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        // Indicatore di presenza in basso a destra
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: ParticipantPresenceIndicator(
              isOnline: widget.isOnline,
              size: widget.avatarRadius * 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
