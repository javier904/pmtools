import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/models/retro_methodology_guide.dart';
import 'package:agile_tools/widgets/retrospective/retro_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class RetroLinearBoardWidget extends StatefulWidget {
  final RetrospectiveModel retro;
  final String currentUserEmail;
  final String currentUserName;
  final bool showAuthorNames;

  const RetroLinearBoardWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
    this.showAuthorNames = true,
  }) : super(key: key);

  @override
  State<RetroLinearBoardWidget> createState() => _RetroLinearBoardWidgetState();
}

class _RetroLinearBoardWidgetState extends State<RetroLinearBoardWidget> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (widget.retro.columns.isEmpty) {
      return Center(child: Text(l10n.retroNoColumnsConfigured));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 1000;
        final isSquashed = !isMobile && (constraints.maxWidth / widget.retro.columns.length < 320);

        // DEBUG PRINT
        print('RetroLinearBoardWidget Layout: maxWidth=${constraints.maxWidth}, isMobile=$isMobile, isSquashed=$isSquashed, columns=${widget.retro.columns.length}');

        if (isMobile) {
          // Mobile: Single column with PageView and custom BottomBar
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.retro.columns.length,
                  itemBuilder: (context, index) {
                    final col = widget.retro.columns[index];
                    return RetroColumnWidget(
                      retro: widget.retro,
                      column: col,
                      currentUserEmail: widget.currentUserEmail,
                      currentUserName: widget.currentUserName,
                      showAuthorNames: widget.showAuthorNames,
                    );
                  },
                ),
              ),
              // Custom Bottom Bar for Column Navigation
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.2))),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
                  ],
                ),
                child: SafeArea(
                    child: widget.retro.columns.length <= 4
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            children: widget.retro.columns.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final col = entry.value;
                              final isSelected = _currentIndex == idx;
                              final title = RetroMethodologyGuide.getColumnTitle(l10n, widget.retro.template, col.id, col.title);
                              
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () => _onBottomNavTapped(idx),
                                    borderRadius: BorderRadius.circular(20),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: isSelected ? col.color.withValues(alpha: 0.15) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected ? col.color : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            isSelected ? Icons.view_sidebar : Icons.view_sidebar_outlined, 
                                            size: 16, 
                                            color: isSelected ? col.color : Theme.of(context).unselectedWidgetColor
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              title,
                                              style: TextStyle(
                                                color: isSelected ? col.color : Theme.of(context).textTheme.bodyMedium?.color,
                                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.retro.columns.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final col = entry.value;
                              final isSelected = _currentIndex == idx;
                              final title = RetroMethodologyGuide.getColumnTitle(l10n, widget.retro.template, col.id, col.title);
                              
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: InkWell(
                                  onTap: () => _onBottomNavTapped(idx),
                                  borderRadius: BorderRadius.circular(20),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected ? col.color.withValues(alpha: 0.15) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected ? col.color : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isSelected ? Icons.view_sidebar : Icons.view_sidebar_outlined, 
                                          size: 16, 
                                          color: isSelected ? col.color : Theme.of(context).unselectedWidgetColor
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          title,
                                          style: TextStyle(
                                            color: isSelected ? col.color : Theme.of(context).textTheme.bodyMedium?.color,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                  ),
                ),
            ],
          );
        }

        if (isSquashed) {
          // Mid-sized screens: Scroll gracefully horizontally
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.retro.columns.map((col) {
                return Container(
                  width: 320, // Fixed comfortable width
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: RetroColumnWidget(
                    retro: widget.retro,
                    column: col,
                    currentUserEmail: widget.currentUserEmail,
                    currentUserName: widget.currentUserName,
                    showAuthorNames: widget.showAuthorNames,
                  ),
                );
              }).toList(),
            ),
          );
        }

        // Desktop: Columns expand to fill available width dynamically
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: widget.retro.columns.map((col) {
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: RetroColumnWidget(
                  retro: widget.retro,
                  column: col,
                  currentUserEmail: widget.currentUserEmail,
                  currentUserName: widget.currentUserName,
                  showAuthorNames: widget.showAuthorNames,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
