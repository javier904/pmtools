import 'package:flutter/material.dart';
import '../services/user_profile_service.dart';

/// Widget per visualizzare il nome di un utente partendo dall'email.
/// Risolve il nome reale tramite UserProfileService e cache.
class UserDisplayName extends StatefulWidget {
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
  State<UserDisplayName> createState() => _UserDisplayNameState();
}

class _UserDisplayNameState extends State<UserDisplayName> {
  String? _resolvedName;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  @override
  void didUpdateWidget(UserDisplayName oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.email != widget.email) {
      _resolvedName = null;
      _loadName();
    }
  }

  Future<void> _loadName() async {
    if (widget.email.isEmpty) return;
    final name = await UserProfileService().tryGetNameByEmail(widget.email);
    if (mounted) {
      setState(() {
        _resolvedName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.email.isEmpty) return Text('?', style: widget.style);

    final displayName = _resolvedName ?? widget.fallback ?? widget.email.split('@').first;
    return Text(
      displayName,
      style: widget.style,
      textAlign: widget.textAlign,
      overflow: widget.overflow ? TextOverflow.ellipsis : null,
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
