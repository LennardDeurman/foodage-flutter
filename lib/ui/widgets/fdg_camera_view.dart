import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
/*
class FDGCameraView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FDGCameraViewState();
  }

}

class _FDGCameraViewState extends State<FDGCameraView> {

  CameraController _controller;
  List<CameraDescription> _cameras;

  @override
  void initState() {
    _cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize();
    super.initState();

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: controller,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return _buildPreview();
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }



}


 */