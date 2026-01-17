import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:flutter/material.dart';

class RetroCanvasWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final String currentUserEmail;
  final String currentUserName;

  const RetroCanvasWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (retro.columns.length < 4) return const Center(child: Text("Template requires at least 4 columns (Sailboat style)"));

    // Expected Sailboat Columns Order (mapped by template default)
    // 0: Wind, 1: Anchor, 2: Rocks, 3: Island
    // We'll rely on index or ID matching if standard. 
    // Assuming standard order from RetroTemplateExt.defaultColumns for Sailboat.
    final windCol = retro.columns[0];
    final anchorCol = retro.columns[1];
    final rockCol = retro.columns[2];
    final islandCol = retro.columns[3];

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        
        return Stack(
          children: [
            // 1. Background Painting
            Positioned.fill(
              child: CustomPaint(
                painter: SailboatPainter(
                    waterColor: Colors.blue.withOpacity(0.1),
                    boatColor: Colors.brown.shade300,
                    sailColor: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            
            // 2. Zones (Quadrants)
            // Top-Left: Island (Goal) - Wait, standard: Wind pushes, Anchor drags.
            // Let's map emotionally:
            // Top-Right: Island (Goal/Sun)
            // Top-Left: Wind (Propels)
            // Bottom-Left: Anchors (Deep)
            // Bottom-Right: Rocks (Danger)

            // Wind (Top-Left)
            Positioned(
                top: 0, left: 0, width: w/2, height: h/2 - 50, // Leave space for boat
                child: _buildZone(context, windCol, Alignment.topLeft),
            ),
            // Island (Top-Right)
            Positioned(
                top: 0, right: 0, width: w/2, height: h/2 - 50,
                child: _buildZone(context, islandCol, Alignment.topRight),
            ),
            // Anchor (Bottom-Left)
            Positioned(
                bottom: 0, left: 0, width: w/2, height: h/2,
                child: _buildZone(context, anchorCol, Alignment.bottomLeft),
            ),
             // Rocks (Bottom-Right)
            Positioned(
                bottom: 0, right: 0, width: w/2, height: h/2,
                child: _buildZone(context, rockCol, Alignment.bottomRight),
            ),
          ],
        );
      },
    );
  }

  Widget _buildZone(BuildContext context, RetroColumn column, Alignment alignment) {
      final items = retro.getItemsForColumn(column.id);

      return DragTarget<String>(
          onWillAccept: (data) => data != null,
          onAccept: (itemId) {
              // Move item to this column
              final item = retro.items.firstWhere((i) => i.id == itemId);
              final newItem = item.copyWith(columnId: column.id);
              RetrospectiveFirestoreService().updateRetroItem(retro.id, newItem); // Assumes we added this method
          },
          builder: (context, candidateData, rejectedData) {
              final isHovering = candidateData.isNotEmpty;
              
              return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: isHovering ? column.color.withOpacity(0.3) : Colors.transparent,
                      border: isHovering ? Border.all(color: column.color, width: 2) : null,
                      borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                      crossAxisAlignment: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft 
                          ? CrossAxisAlignment.start 
                          : CrossAxisAlignment.end,
                      children: [
                          // Label
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                  Icon(column.icon, size: 16, color: Colors.grey[700]),
                                  const SizedBox(width: 4),
                                  Text(column.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                  IconButton(
                                      icon: const Icon(Icons.add_circle, size: 18),
                                      onPressed: () => _showAddDialog(context, column),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                  )
                              ],
                          ),
                          const SizedBox(height: 8),
                          // Content (Wrap)
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      alignment: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft 
                                          ? WrapAlignment.start 
                                          : WrapAlignment.end,
                                      children: items.map((item) => _buildCanvasCard(context, item, column)).toList(),
                                  ),
                              ),
                          )
                      ],
                  ),
              );
          },
      );
  }

  Widget _buildCanvasCard(BuildContext context, RetroItem item, RetroColumn col) {
      // Privacy Logic
      final bool isMine = item.authorEmail == currentUserEmail;
      final bool isVisible = isMine || retro.areTeamCardsVisible || retro.currentPhase != RetroPhase.writing;
      
      final child = Container(
          width: 140,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: isVisible ? Colors.yellow[100] : Colors.grey[300], // Sticky Note look
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(2,2))],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(item.id.hashCode % 2 == 0 ? 0 : 12), // Random rotation visuals simulated
                  topRight: const Radius.circular(12),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
              )
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                      isVisible ? item.content : '???',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, height: 1.2),
                  ),
                  if (isVisible)
                   Align(
                       alignment: Alignment.bottomRight,
                       child: Text(item.authorName, style: const TextStyle(fontSize: 9, color: Colors.grey)),
                   )
              ],
          ),
      );

      return Draggable<String>(
          data: item.id,
          feedback: Material(
            elevation: 4, 
            color: Colors.transparent,
            child: Opacity(opacity: 0.8, child: child),
          ),
          childWhenDragging: Opacity(opacity: 0.3, child: child),
          child: child,
      );
  }

  // Reuse Add Dialog logic (copied for brevity, could be shared)
  void _showAddDialog(BuildContext context, RetroColumn column) {
      // ... same implementation as column widget ...
      // Just a stub for now or better, extract to a mixin/helper.
      // I'll inline a simple one.
      final controller = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add to ${column.title}'),
          content: TextField(controller: controller, autofocus: true, maxLines: 3),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(onPressed: () {
                if(controller.text.isNotEmpty) {
                    final newItem = RetroItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        columnId: column.id,
                        content: controller.text,
                        authorEmail: currentUserEmail,
                        authorName: currentUserName,
                        createdAt: DateTime.now(),
                    );
                    RetrospectiveFirestoreService().addRetroItem(retro.id, newItem);
                    Navigator.pop(context);
                }
            }, child: const Text('Add'))
          ],
        ),
      );
  }
}

class SailboatPainter extends CustomPainter {
    final Color waterColor;
    final Color boatColor;
    final Color sailColor;

    SailboatPainter({required this.waterColor, required this.boatColor, required this.sailColor});

    @override
    void paint(Canvas canvas, Size size) {
        final w = size.width;
        final h = size.height;
        final paint = Paint();

        // Water
        paint.color = waterColor;
        paint.style = PaintingStyle.fill;
        // Wave path
        final wavePath = Path();
        wavePath.moveTo(0, h * 0.6);
        wavePath.quadraticBezierTo(w * 0.25, h * 0.55, w * 0.5, h * 0.6);
        wavePath.quadraticBezierTo(w * 0.75, h * 0.65, w, h * 0.6);
        wavePath.lineTo(w, h);
        wavePath.lineTo(0, h);
        wavePath.close();
        canvas.drawPath(wavePath, paint);

        // Boat Hull (Trapezoid) centered
        paint.color = boatColor;
        final hullPath = Path();
        hullPath.moveTo(w * 0.35, h * 0.62);
        hullPath.lineTo(w * 0.65, h * 0.62);
        hullPath.quadraticBezierTo(w * 0.6, h * 0.75, w * 0.55, h * 0.75); // Bow
        hullPath.lineTo(w * 0.45, h * 0.75);
        hullPath.quadraticBezierTo(w * 0.4, h * 0.75, w * 0.35, h * 0.62); // Stern
        hullPath.close();
        canvas.drawPath(hullPath, paint);

        // Mast
        paint.color = Colors.brown.shade800;
        paint.strokeWidth = 4;
        canvas.drawLine(Offset(w * 0.5, h * 0.62), Offset(w * 0.5, h * 0.3), paint);

        // Sail
        paint.color = sailColor;
        paint.style = PaintingStyle.fill;
        paint.strokeWidth = 0;
        final sailPath = Path();
        sailPath.moveTo(w * 0.505, h * 0.32);
        sailPath.lineTo(w * 0.505, h * 0.58);
        sailPath.quadraticBezierTo(w * 0.6, h * 0.5, w * 0.65, h * 0.55);
        sailPath.close();
        canvas.drawPath(sailPath, paint);
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
