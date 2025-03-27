import 'package:flutter/material.dart';
import 'package:node_master_app/data/node_data.dart';

class CanvasState with ChangeNotifier {
  Offset _panOffset = Offset.zero;
  double _zoomLevel = 1.0;
  final List<NodeData> _nodes = []; // List to hold our nodes
  String? _draggingNodeId; // Track which node is being dragged, if any

  // --- Getters ---
  Offset get panOffset => _panOffset;
  double get zoomLevel => _zoomLevel;
  List<NodeData> get nodes => _nodes; // Getter for the nodes list

  // --- Constants ---
  final double _minZoom = 0.2;
  final double _maxZoom = 3.0;
  final double _zoomSensitivity = 0.005;

  // --- Methods ---

  // Method to add a node (you'll call this to populate the canvas)
  void addNode(NodeData node) {
    _nodes.add(node);
    notifyListeners();
  }

  // Helper method to find a node's index by ID
  int _findNodeIndex(String nodeId) {
    return _nodes.indexWhere((node) => node.id == nodeId);
  }

  // Panning the canvas background
  void pan(Offset delta) {
    // Only pan background if NOT dragging a node
    if (_draggingNodeId == null) {
      _panOffset += delta / _zoomLevel;
      notifyListeners();
    }
  }

  // Zooming the canvas
  void zoom(double deltaZoom, Offset focalPoint) {
    // Store old values
    double oldZoomLevel = _zoomLevel;
    Offset oldPanOffset = _panOffset;

    // Calculate new zoom
    double newZoomLevel =
        oldZoomLevel + deltaZoom * _zoomSensitivity * oldZoomLevel;
    newZoomLevel = newZoomLevel.clamp(_minZoom, _maxZoom);
    if (newZoomLevel == oldZoomLevel) return;

    // --- Scaled Offset Calculation ---
    // 1. Calculate the scaled offset before zoom
    Offset oldScaledPanOffset = oldPanOffset * oldZoomLevel;

    // 2. Find the canvas point under the cursor using the OLD state and scaled offset
    // screen = canvas * zoom + scaledOffset => canvas = (screen - scaledOffset) / zoom
    Offset focalPointInCanvas =
        (focalPoint - oldScaledPanOffset) / oldZoomLevel;

    // 3. Calculate the NEW scaled offset needed to keep that canvas point at the same screen focalPoint
    // screen = canvas * zoom + scaledOffset => scaledOffset = screen - (canvas * zoom)
    Offset newScaledPanOffset =
        focalPoint - (focalPointInCanvas * newZoomLevel);

    // 4. Update the state: new zoom level and UNscaled pan offset
    _zoomLevel = newZoomLevel;
    _panOffset = newScaledPanOffset /
        newZoomLevel; // Convert back to unscaled offset for storage

    notifyListeners();
  }

  // --- Node Dragging Methods ---

  // Call this when a drag starts on a node
  void startNodeDrag(String nodeId) {
    if (_findNodeIndex(nodeId) != -1) {
      _draggingNodeId = nodeId;
      // TODO: Optional: Bring dragged node to front visually later if needed
      notifyListeners(); // May not be strictly needed here, but safe
    }
  }

  // Call this while a node is being dragged
  void updateNodeDrag(String nodeId, Offset screenDelta) {
    if (_draggingNodeId == nodeId) {
      int index = _findNodeIndex(nodeId);
      if (index != -1) {
        // Convert screen drag delta to canvas delta based on zoom
        Offset canvasDelta = screenDelta / _zoomLevel;
        // Update the node's position
        Offset newPosition = _nodes[index].position + canvasDelta;

        // Create a new NodeData object with updated position
        // (assuming NodeData is immutable or treating it as such)
        _nodes[index] = NodeData(
          id: _nodes[index].id,
          title: _nodes[index].title,
          icon: _nodes[index].icon,
          position: newPosition, // The updated position
          outputs: _nodes[index].outputs,
        );
        notifyListeners();
      }
    }
  }

  // Call this when the drag on a node ends
  void stopNodeDrag() {
    _draggingNodeId = null;
    notifyListeners();
  }

  // --- Coordinate Conversion Helpers (MUST match scaled offset interpretation) ---
  Offset screenToCanvas(Offset screenCoord) {
    // screen = canvas * zoom + scaledOffset => canvas = (screen - scaledOffset) / zoom
    Offset scaledPanOffset = _panOffset * _zoomLevel;
    // Add safety check for zoom level being zero or near-zero if needed
    if (_zoomLevel.abs() < 1e-6) return Offset.zero; // Avoid division by zero
    return (screenCoord - scaledPanOffset) / _zoomLevel;
  }

  Offset canvasToScreen(Offset canvasCoord) {
    // screen = canvas * zoom + scaledOffset
    Offset scaledPanOffset = _panOffset * _zoomLevel;
    return canvasCoord * _zoomLevel + scaledPanOffset;
  }

  // --- Constructor (Optional: Add initial nodes for testing) ---
  CanvasState() {
    // Add some sample nodes
    addNode(NodeData(
      id: 'node-1',
      title: 'First Node',
      icon: Icons.star,
      position: const Offset(100, 150),
      outputs: [
        OutputData(id: 'out-1a', label: 'Success'),
        OutputData(id: 'out-1b', label: 'Failure', status: OutputStatus.error),
      ],
    ));
    addNode(NodeData(
      id: 'node-2',
      title: 'Another Longer Node Title',
      icon: Icons.cloud_upload,
      position: const Offset(400, 250),
      outputs: [
        OutputData(id: 'out-2a', label: 'Done'),
      ],
    ));
  }
}
