import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agile_tools/services/auth_service.dart';
import 'package:agile_tools/screens/retrospective_board_screen.dart';

class RetroBoardLoaderScreen extends StatefulWidget {
  const RetroBoardLoaderScreen({super.key});

  @override
  State<RetroBoardLoaderScreen> createState() => _RetroBoardLoaderScreenState();
}

class _RetroBoardLoaderScreenState extends State<RetroBoardLoaderScreen> {
  String? _retroId;
  String? _email;
  String? _name;
  bool _urlSynced = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final authService = AuthService();
    final user = authService.currentUser;
    _email = user?.email ?? '';
    _name = user?.displayName ?? 'User';

    if (_email!.isNotEmpty && !_urlSynced) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, dynamic>) {
        _retroId = args['id'] as String? ?? args['retroId'] as String?;
        if (_retroId != null && _retroId!.isNotEmpty) {
          // Aggiorna l'URL del browser con il retroId
          SystemNavigator.routeInformationUpdated(
            uri: Uri.parse('/retrospective-board/$_retroId'),
          );
          _urlSynced = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_email == null || _email!.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Authentication required')),
      );
    }

    if (_retroId == null || _retroId!.isEmpty) {
      final args = ModalRoute.of(context)?.settings.arguments;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              const Text('Retrospective ID missing'),
              const SizedBox(height: 8),
              Text('Args received: $args', 
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/retrospective-list'),
                child: const Text('Go to Retrospectives'),
              ),
            ],
          ),
        ),
      );
    }

    return RetroBoardScreen(
      retroId: _retroId!,
      currentUserEmail: _email!,
      currentUserName: _name!,
    );
  }
}
