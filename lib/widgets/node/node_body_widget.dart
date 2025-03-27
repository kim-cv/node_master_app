import 'package:flutter/material.dart';
import 'package:node_master_app/widgets/node/node_widget_style.dart';

class NodeBodyWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const NodeBodyWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: NodeWidgetStyle.contentPaddingHorizontal),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Crucial for width calculation
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: NodeWidgetStyle.iconColor,
            size: NodeWidgetStyle.iconSize,
          ),
          const SizedBox(width: NodeWidgetStyle.iconTitleSpacing),
          Text(
            title,
            style: NodeWidgetStyle.titleStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
