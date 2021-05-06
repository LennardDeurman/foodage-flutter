import 'package:camera/camera.dart';

enum CameraState {
  idle,
  ready,
  permissionsDenied,
  noCameraAvailable,
}

class CameraPreviewFrameState {
  final CameraState cameraState;

  final CameraController? controller;

  CameraPreviewFrameState({required this.cameraState, this.controller});

  CameraPreviewFrameState copyWith({CameraState? cameraState, CameraController? controller}) {
    return CameraPreviewFrameState(cameraState: cameraState ?? this.cameraState, controller: controller ?? this.controller);
  }
}
