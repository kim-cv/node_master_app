import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:node_master_app/data/node_data.dart';
import 'package:node_master_app/providers/canvas_state.dart';
import 'package:node_master_app/widgets/canvas_painter.dart';
import 'package:node_master_app/widgets/node/node_container_widget.dart';
import 'package:provider/provider.dart';

class NodeEditorCanvas extends StatelessWidget {
  const NodeEditorCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    final canvasState = context.watch<CanvasState>();
    final nodes = canvasState.nodes; // Get the list of nodes

    return Listener(
      onPointerSignal: (PointerSignalEvent event) {
        if (event is PointerScrollEvent) {
          context
              .read<CanvasState>()
              .zoom(-event.scrollDelta.dy, event.localPosition);
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Capture taps/drags on background
        onPanUpdate: (DragUpdateDetails details) {
          // This pans the background IF a node is NOT being dragged
          context.read<CanvasState>().pan(details.delta);
        },
        // Use a Stack to layer background and nodes
        child: Stack(
          clipBehavior: Clip.none, // Allow nodes/connections near edge
          children: [
            // --- Background Painter ---
            Positioned.fill(
              // Ensure painter fills the area
              child: CustomPaint(
                painter: CanvasPainter(canvasState: canvasState),
                child: Container(), // Required child for CustomPaint
              ),
            ),

            // --- Node Widgets ---
            // Loop through nodes and create Positioned/Transformed widgets
            ...nodes.map(
              (NodeData nodeData) {
                // Convert node's canvas position to screen position
                Offset screenPosition =
                    canvasState.canvasToScreen(nodeData.position);

                return Positioned(
                  // Position using screen coordinates
                  left: screenPosition.dx,
                  top: screenPosition.dy,
                  // Use GestureDetector ON EACH NODE for dragging
                  child: GestureDetector(
                    // Prevent background panning when dragging a node starts
                    onPanStart: (details) {
                      context.read<CanvasState>().startNodeDrag(nodeData.id);
                    },
                    onPanUpdate: (details) {
                      // Pass the SCREEN delta to the state update method
                      context
                          .read<CanvasState>()
                          .updateNodeDrag(nodeData.id, details.delta);
                    },
                    onPanEnd: (details) {
                      context.read<CanvasState>().stopNodeDrag();
                    },
                    // Apply scaling based on canvas zoom
                    child: Transform.scale(
                      scale: canvasState.zoomLevel,
                      // Scale from the top-left corner
                      alignment: Alignment.topLeft,
                      child: NodeContainerWidget(
                        nodeData: nodeData,
                        // Pass callbacks if needed later
                      ),
                    ),
                  ),
                );
              },
            ),
            // --- (Optional) Connection Lines Layer ---
            // TODO: Add another Positioned.fill with a CustomPaint for connections later
          ],
        ),
      ),
    );
  }
}
