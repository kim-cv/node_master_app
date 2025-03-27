import 'package:flutter/material.dart';
import 'package:node_master_app/data/node_data.dart';
import 'package:node_master_app/widgets/node/output_socket_widget.dart';

class OutputSocketsContainerWidget extends StatelessWidget {
  final List<OutputData> outputs;

  const OutputSocketsContainerWidget({
    super.key,
    required this.outputs,
  });

  @override
  Widget build(BuildContext context) {
    if (outputs.isEmpty) {
      return const SizedBox.shrink(); // Return empty if no outputs
    }

    return Row(
      mainAxisSize: MainAxisSize.max, // Occupy the width provided by Positioned
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribute space
      children: List.generate(outputs.length, (index) {
        return OutputSocketWidget(outputData: outputs[index]);
      }),
    );
  }
}
