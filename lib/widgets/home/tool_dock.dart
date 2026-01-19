import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';
import '../../themes/app_colors.dart';
import '../../l10n/app_localizations.dart';

class ToolDock extends StatelessWidget {
  const ToolDock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = context.isDarkMode;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        border: Border(top: BorderSide(color: context.borderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: isMobile 
        ? _buildMobileDock(context, l10n, isDark)
        : _buildDesktopDock(context, l10n, isDark),
    );
  }

  Widget _buildDesktopDock(BuildContext context, AppLocalizations l10n, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _DockItem(
          title: l10n.toolSmartTodo,
          icon: Icons.check_circle_outline_rounded,
          color: Colors.blue,
          onTap: () => Navigator.pushNamed(context, '/smart-todo'),
        ),
        const SizedBox(width: 12),
        _DockItem(
          title: l10n.toolEisenhower,
          icon: Icons.grid_view_rounded,
          color: AppColors.success,
          onTap: () => Navigator.pushNamed(context, '/eisenhower'),
        ),
        const SizedBox(width: 12),
        _DockItem(
          title: l10n.toolAgileProcess,
          icon: Icons.rocket_launch_rounded,
          color: AppColors.primary,
          onTap: () => Navigator.pushNamed(context, '/agile-process'),
        ),
        const SizedBox(width: 12),
        _DockItem(
          title: l10n.toolEstimation,
          icon: Icons.casino_rounded,
          color: AppColors.secondary,
          onTap: () => Navigator.pushNamed(context, '/estimation-room'),
        ),
        const SizedBox(width: 12),
        _DockItem(
          title: l10n.toolRetro,
          icon: Icons.psychology_rounded,
          color: AppColors.pink,
          onTap: () => Navigator.pushNamed(context, '/agile-process', arguments: {'initialAction': 'retro'}),
        ),
      ],
    );
  }

  Widget _buildMobileDock(BuildContext context, AppLocalizations l10n, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _DockItem(
            title: 'Todo',
            icon: Icons.check_circle_outline_rounded,
            color: Colors.blue,
            compact: true,
            onTap: () => Navigator.pushNamed(context, '/smart-todo'),
          ),
          const SizedBox(width: 10),
          _DockItem(
            title: 'Matrix',
            icon: Icons.grid_view_rounded,
            color: AppColors.success,
            compact: true,
            onTap: () => Navigator.pushNamed(context, '/eisenhower'),
          ),
          const SizedBox(width: 10),
          _DockItem(
            title: 'Agile',
            icon: Icons.rocket_launch_rounded,
            color: AppColors.primary,
            compact: true,
            onTap: () => Navigator.pushNamed(context, '/agile-process'),
          ),
          const SizedBox(width: 10),
          _DockItem(
            title: 'Poker',
            icon: Icons.casino_rounded,
            color: AppColors.secondary,
            compact: true,
            onTap: () => Navigator.pushNamed(context, '/estimation-room'),
          ),
          const SizedBox(width: 10),
          _DockItem(
            title: 'Retro',
            icon: Icons.psychology_rounded,
            color: AppColors.pink,
            compact: true,
            onTap: () => Navigator.pushNamed(context, '/agile-process', arguments: {'initialAction': 'retro'}),
          ),
        ],
      ),
    );
  }
}

class _DockItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool compact;

  const _DockItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.compact = false,
  });

  @override
  State<_DockItem> createState() => _DockItemState();
}

class _DockItemState extends State<_DockItem> {
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
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 12 : 20, 
            vertical: 10
          ),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withValues(alpha: 0.1) : context.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? widget.color.withValues(alpha: 0.5) : context.borderColor,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: widget.color, size: 20),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: context.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
