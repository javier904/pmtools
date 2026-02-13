import 'package:flutter/material.dart';
import '../../services/smart_todo_service.dart';
import '../../models/smart_todo/todo_list_model.dart';
import 'smart_todo_detail_screen.dart';

/// Loader screen that fetches a TodoList by ID and navigates to the detail screen.
/// Used for URL-based deep linking so that /smart-todo-detail?listId=xxx
/// survives page refreshes in Flutter web.
class SmartTodoDetailLoader extends StatelessWidget {
  final String listId;

  const SmartTodoDetailLoader({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    final todoService = SmartTodoService();

    return StreamBuilder<TodoListModel?>(
      stream: todoService.streamList(listId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final list = snapshot.data;
        if (list == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Smart Todo')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('List not found or access denied'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/smart-todo'),
                    child: const Text('Back to Smart Todo'),
                  ),
                ],
              ),
            ),
          );
        }

        return SmartTodoDetailScreen(list: list);
      },
    );
  }
}
