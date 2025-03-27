import 'package:flutter/material.dart';
import 'package:node_master_app/data/node_data.dart';
import 'package:node_master_app/widgets/node/input_socket_widget.dart';
import 'package:node_master_app/widgets/node/node_body_widget.dart';
import 'package:node_master_app/widgets/node/node_widget_style.dart';
import 'package:node_master_app/widgets/node/output_sockets_container_widget.dart';

// This is the main widget you will place on the canvas
class NodeContainerWidget extends StatelessWidget {
  final NodeData nodeData;
  // TODO: Add callbacks later:
  // final VoidCallback? onTap;
  // final Function(DragStartDetails)? onDragStart;

  const NodeContainerWidget({
    super.key,
    required this.nodeData,
    // this.onTap,
    // this.onDragStart,
  });

  @override
  Widget build(BuildContext context) {
    final double outputTotalHeight = NodeWidgetStyle.socketRadius +
        NodeWidgetStyle.socketMargin +
        NodeWidgetStyle.calculateLabelHeight();

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: NodeWidgetStyle.minNodeWidth,
      ),
      child: Container(
        height: NodeWidgetStyle.nodeHeight,
        decoration: BoxDecoration(
          color: NodeWidgetStyle.nodeBackgroundColor,
          borderRadius: BorderRadius.circular(NodeWidgetStyle.cornerRadius),
          boxShadow: NodeWidgetStyle.nodeShadow,
        ),
        child: Stack(
          clipBehavior: Clip.none, // Allow sockets outside
          alignment: Alignment.center,
          children: [
            // --- Main Body ---
            NodeBodyWidget(
              icon: nodeData.icon,
              title: nodeData.title,
            ),

            // --- Input Socket ---
            const Positioned(
              top: -(NodeWidgetStyle.socketRadius +
                  NodeWidgetStyle.socketMargin),
              left: 0,
              right: 0,
              child: Align(
                // Use Align to center the single socket
                alignment: Alignment.center,
                child: InputSocketWidget(),
              ),
            ),

            // --- Output Sockets ---
            if (nodeData
                .outputs.isNotEmpty) // Only position if there are outputs
              Positioned(
                bottom: -outputTotalHeight, // Position below node + labels
                left: 0,
                right: 0,
                child: OutputSocketsContainerWidget(
                  outputs: nodeData.outputs,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
