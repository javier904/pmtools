import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

class SectionTools extends StatelessWidget {
  const SectionTools({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.apps_rounded, color: context.textPrimaryColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  l10n.toolSectionTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Responsive grid logic
                  final width = constraints.maxWidth;
                  final crossAxisCount = width > 1200 ? 5 : width > 900 ? 4 : width > 600 ? 3 : 2;
                  
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _ToolCard(
                        title: l10n.toolSmartTodo,
                        icon: Icons.check_circle_outline_rounded,
                        color: AppColors.secondary,
                        onTap: () => Navigator.pushNamed(context, '/smart-todo'),
                        description: l10n.toolSmartTodoDescShort,
                      ),
                      _ToolCard(
                        title: l10n.toolEisenhower,
                        icon: Icons.grid_view_rounded,
                        color: AppColors.success,
                        onTap: () => Navigator.pushNamed(context, '/eisenhower'),
                        description: l10n.toolEisenhowerDescShort,
                      ),
                      _ToolCard(
                        title: l10n.toolEstimation,
                        icon: Icons.casino_rounded,
                        color: Colors.amber,
                        onTap: () => Navigator.pushNamed(context, '/estimation-room'),
                        description: l10n.toolEstimationDescShort,
                      ),
                      _ToolCard(
                        title: l10n.toolAgileProcess,
                        icon: Icons.rocket_launch_rounded,
                        color: AppColors.primary,
                        onTap: () => Navigator.pushNamed(context, '/agile-process'),
                        description: l10n.toolAgileProcessDescShort,
                      ),
                      _ToolCard(
                        title: l10n.toolRetro,
                        icon: Icons.psychology_rounded,
                        color: AppColors.pink,
                        onTap: () => Navigator.pushNamed(context, '/retrospective-list'),
                        description: l10n.toolRetroDescShort,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? description;

  const _ToolCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.description,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withValues(alpha: 0.1) : context.surfaceVariantColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? widget.color.withValues(alpha: 0.5) : Colors.transparent,
              width: 1.5,
            ),
             boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: widget.color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: context.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.description != null) ...[
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.description!,
                    style: TextStyle(
                      color: context.textMutedColor,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
