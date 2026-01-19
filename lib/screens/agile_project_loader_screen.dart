import 'package:flutter/material.dart';
import 'package:agile_tools/models/agile_project_model.dart';
import 'package:agile_tools/services/agile_firestore_service.dart';
import 'package:agile_tools/screens/agile_project_detail_screen.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class AgileProjectLoaderScreen extends StatefulWidget {
  const AgileProjectLoaderScreen({super.key});

  @override
  State<AgileProjectLoaderScreen> createState() => _AgileProjectLoaderScreenState();
}

class _AgileProjectLoaderScreenState extends State<AgileProjectLoaderScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  AgileProjectModel? _project;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProject();
  }

  Future<void> _loadProject() async {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Map<String, dynamic> || !args.containsKey('id')) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'ID progetto mancante';
      });
      return;
    }

    final projectId = args['id'] as String;

    try {
      final project = await AgileFirestoreService().getProject(projectId);
      if (mounted) {
        setState(() {
          _project = project;
          _isLoading = false;
          if (project == null) {
            _errorMessage = 'Progetto non trovato';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Errore caricamento: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null || _project == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Errore')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(_errorMessage ?? 'Errore sconosciuto'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Torna indietro'),
              ),
            ],
          ),
        ),
      );
    }

    return AgileProjectDetailScreen(
      project: _project!,
      onBack: () => Navigator.of(context).pop(),
    );
  }
}
