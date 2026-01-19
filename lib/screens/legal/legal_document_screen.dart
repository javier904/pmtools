import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LegalDocumentScreen extends StatefulWidget {
  final String title;
  final String mdContent;
  final String lastUpdated;

  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.mdContent,
    required this.lastUpdated,
  });

  @override
  State<LegalDocumentScreen> createState() => _LegalDocumentScreenState();
}

class _LegalDocumentScreenState extends State<LegalDocumentScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is active
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: isDark ? const Color(0xFF0D0D0F) : Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: isDark ? const Color(0xFF0D0D0F) : Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ultimo aggiornamento: ${widget.lastUpdated}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Content
                    MarkdownBody(
                      data: widget.mdContent,
                      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                        h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                        h2: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.8,
                        ),
                        p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                        listBullet: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
