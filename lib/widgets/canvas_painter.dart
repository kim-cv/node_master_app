import 'package:flutter/material.dart';
import 'package:node_master_app/providers/canvas_state.dart';
import 'package:node_master_app/widgets/node/node_widget_style.dart';

class CanvasPainter extends CustomPainter {
  final CanvasState canvasState; // Keep this to easily access state in paint()
  // Use constants directly from styling or define here
  final double dotSpacing = 30.0; // Spacing in CANVAS coordinates
  final double dotRadius = 1.0; // Radius in CANVAS coordinates
  final Color dotColor =
      NodeWidgetStyle.labelColor.withOpacity(0.5); // Use a style color
  final Color backgroundColor = Colors.grey.shade900; // Or from style

  // Constructor:
  CanvasPainter({
    required this.canvasState,
  }) : super(repaint: canvasState);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Fill background
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // 2. Apply Transformations FOR DOTS
    canvas.save(); // Save state before transform

    // Apply the scaled offset interpretation for transformations
    Offset scaledPanOffset = canvasState.panOffset * canvasState.zoomLevel;
    canvas.translate(scaledPanOffset.dx, scaledPanOffset.dy);
    canvas.scale(canvasState.zoomLevel);

    // 3. Draw the Dot Grid
    final dotPaint = Paint()..color = dotColor;

    // Determine visible area in canvas coordinates (using updated helpers)
    Offset topLeftCanvas = canvasState.screenToCanvas(Offset.zero);
    Offset bottomRightCanvas =
        canvasState.screenToCanvas(Offset(size.width, size.height));

    // Calculate the start and end points for the loops, aligned to the grid
    // Ensure we use the LOCAL (constant) dotSpacing here
    double startX = (topLeftCanvas.dx / dotSpacing).floor() * dotSpacing;
    double startY = (topLeftCanvas.dy / dotSpacing).floor() * dotSpacing;
    double endX = bottomRightCanvas.dx;
    double endY = bottomRightCanvas.dy;

    // Add a buffer to ensure dots just outside the edge are drawn during panning
    // Use the LOCAL (constant) dotSpacing for buffer calculation
    double buffer = dotSpacing * 2;
    startX -= buffer;
    startY -= buffer;
    endX += buffer;
    endY += buffer;

    // Loop using the constant canvas dotSpacing
    for (double x = startX; x < endX; x += dotSpacing) {
      for (double y = startY; y < endY; y += dotSpacing) {
        // Draw dots using the constant canvas dotRadius
        canvas.drawCircle(Offset(x, y), dotRadius, dotPaint);
      }
    }

    canvas.restore(); // Restore state after drawing dots
  }

  @override
  bool shouldRepaint(covariant CanvasPainter oldDelegate) {
    // Repaint if zoom or pan changes
    return oldDelegate.canvasState.zoomLevel != canvasState.zoomLevel ||
        oldDelegate.canvasState.panOffset != canvasState.panOffset;
  }
}
