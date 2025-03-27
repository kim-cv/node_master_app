import 'package:flutter/material.dart';
import 'package:node_master_app/widgets/node/node_widget_style.dart';

class InputSocketWidget extends StatelessWidget {
  const InputSocketWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: NodeWidgetStyle.socketRadius * 2,
      height: NodeWidgetStyle.socketRadius * 2,
      decoration: BoxDecoration(
        color: NodeWidgetStyle.socketInnerColor, // Inner fill
        shape: BoxShape.circle,
        border: Border.all(
          color: NodeWidgetStyle.inputSocketColor,
          width: NodeWidgetStyle.socketStrokeWidth,
        ),
      ),
    );
  }
}
