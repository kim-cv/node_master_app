import 'package:flutter/material.dart';

class NodeWidgetStyle {
  // Dimensions
  static const double minNodeWidth = 150.0;
  static const double nodeHeight = 80.0;
  static const double cornerRadius = 15.0;
  static const double socketRadius = 10.0;
  static const double socketMargin =
      5.0; // Space between socket edge and node edge
  static const double socketStrokeWidth = 2.0;
  static const double labelSpacing = 5.0; // Space between socket and label
  static const double contentPaddingHorizontal = 16.0;
  static const double iconTitleSpacing = 10.0;
  static const double iconSize = 28.0;

  // Colors
  static const Color nodeBackgroundColor = Colors.white;
  static const Color shadowColor = Colors.black54;
  static const Color inputSocketColor = Colors.blue;
  static const Color outputSuccessColor = Colors.blue; // Blue outer for success
  static const Color outputErrorColor = Colors.redAccent; // Red outer for error
  static const Color socketInnerColor = Colors.white;
  static const Color titleColor = Colors.black87;
  static const Color labelColor = Colors.grey; // Color for output labels
  static const Color iconColor = Colors.blue; // Match image

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    color: titleColor,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  // Define label style explicitly or derive from theme later
  static const TextStyle labelStyle = TextStyle(
    fontSize: 10,
    color: labelColor,
  );

  // Shadow
  static final List<BoxShadow> nodeShadow = [
    BoxShadow(
      color: shadowColor.withOpacity(0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // Helper to estimate label height for positioning output sockets
  static double calculateLabelHeight() {
    // Basic estimation, refine if needed using TextPainter if more accuracy is required
    return (labelStyle.fontSize ?? 10.0) + labelSpacing;
  }
}
