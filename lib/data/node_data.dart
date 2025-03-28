import 'package:flutter/widgets.dart';

enum OutputStatus { success, error }

class OutputData {
  final String id;
  final String label;
  final OutputStatus status;

  OutputData({
    required this.id,
    required this.label,
    this.status = OutputStatus.success,
  });
}

class NodeData {
  final String id;
  final String title;
  final IconData icon;
  final Offset position; // Canvas position
  final List<OutputData> outputs;

  NodeData({
    required this.id,
    required this.title,
    required this.icon,
    required this.position,
    required this.outputs,
  });
}
