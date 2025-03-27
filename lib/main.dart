import 'package:flutter/material.dart';
import 'package:node_master_app/providers/canvas_state.dart';
import 'package:node_master_app/widgets/node_editor_canvas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Provide the CanvasState to the widget tree
    return ChangeNotifierProvider(
      create: (context) => CanvasState(),
      child: MaterialApp(
        title: 'Node Editor MVP',
        theme: ThemeData.dark(), // Dark theme often suits node editors
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Node Editor - Canvas MVP'),
          ),
          // Use the canvas widget as the body
          body: const NodeEditorCanvas(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
