import 'package:flutter/material.dart';
import 'package:node_master_app/data/node_data.dart';
import 'package:node_master_app/widgets/node/node_widget_style.dart';

class OutputSocketWidget extends StatelessWidget {
  final OutputData outputData;

  const OutputSocketWidget({
    super.key,
    required this.outputData,
  });

  @override
  Widget build(BuildContext context) {
    final color = outputData.status == OutputStatus.success
        ? NodeWidgetStyle.outputSuccessColor
        : NodeWidgetStyle.outputErrorColor;
    const double radius = NodeWidgetStyle.socketRadius;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- Socket Circle ---
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
            color: color, // Outer color based on status
            shape: BoxShape.circle,
            border:
                Border.all(color: Colors.black.withOpacity(0.1), width: 1.0),
          ),
          child: Center(
            // Inner white circle
            child: Container(
              width: radius, // Inner circle radius is half the outer
              height: radius,
              decoration: const BoxDecoration(
                color: NodeWidgetStyle.socketInnerColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        // --- Label ---
        const SizedBox(height: NodeWidgetStyle.labelSpacing),
        Text(
          outputData.label,
          style: NodeWidgetStyle.labelStyle,
        ),
      ],
    );
  }
}
