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
                  final width = constraints.maxWidth;

                  final tools = [
                    _ToolData(l10n.toolSmartTodo, Icons.check_circle_outline_rounded, AppColors.secondary, '/smart-todo', l10n.toolSmartTodoDescShort),
                    _ToolData(l10n.toolEisenhower, Icons.grid_view_rounded, AppColors.success, '/eisenhower', l10n.toolEisenhowerDescShort),
                    _ToolData(l10n.toolEstimation, Icons.casino_rounded, Colors.amber, '/estimation-room', l10n.toolEstimationDescShort),
                    _ToolData(l10n.toolAgileProcess, Icons.rocket_launch_rounded, AppColors.primary, '/agile-process', l10n.toolAgileProcessDescShort),
                    _ToolData(l10n.toolRetro, Icons.psychology_rounded, AppColors.pink, '/retrospective-list', l10n.toolRetroDescShort),
                  ];

                  // ═══ MOBILE (<500px): lista orizzontale scrollabile ═══
                  if (width < 500) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: tools.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final t = tools[index];
                        return SizedBox(
                          width: 140,
                          child: _ToolCard(title: t.title, icon: t.icon, color: t.color, onTap: () => Navigator.pushNamed(context, t.route), description: t.description),
                        );
                      },
                    );
                  }

                  // ═══ DESKTOP: griglia originale ═══
                  final crossAxisCount = width > 1200 ? 5 : width > 900 ? 4 : width > 600 ? 3 : 2;

                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: tools.map((t) => _ToolCard(
                      title: t.title, icon: t.icon, color: t.color,
                      onTap: () => Navigator.pushNamed(context, t.route),
                      description: t.description,
                    )).toList(),
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

class _ToolData {
  final String title;
  final IconData icon;
  final Color color;
  final String route;
  final String description;
  const _ToolData(this.title, this.icon, this.color, this.route, this.description);
}
