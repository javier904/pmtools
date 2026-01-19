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
    if (args is! Map<String, dynamic> || !args.containsKey('id')) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Retrospective ID missing')),
      );
    }

    final retroId = args['id'] as String;

    return RetroBoardScreen(
      retroId: retroId,
      currentUserEmail: email,
      currentUserName: name,
    );
  }
}
