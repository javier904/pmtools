import 'package:flutter/material.dart';
import 'package:agile_tools/services/auth_service.dart';
import 'package:agile_tools/screens/retrospective_board_screen.dart';

class RetroBoardLoaderScreen extends StatelessWidget {
  const RetroBoardLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currentUser;
    final email = user?.email ?? '';
    final name = user?.displayName ?? 'User';

    if (email.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Authentication required')),
      );
    }

    final args = ModalRoute.of(context)?.settings.arguments;
    String? retroId;

    // Support both 'id' and 'retroId' keys for flexibility
    if (args is Map<String, dynamic>) {
      retroId = args['id'] as String? ?? args['retroId'] as String?;
    }

    if (retroId == null || retroId.isEmpty) {
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
              Text('Args received: $args', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
      retroId: retroId,
      currentUserEmail: email,
      currentUserName: name,
    );
  }
}
