import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraRepository {
  Future<bool> checkPermission() async => await Permission.camera.request().isGranted;

  Future<List<CameraDescription>> getCameras() async => await getCameras();

  CameraDescription getMainCamera(List<CameraDescription> availableCameras) =>
      availableCameras.firstWhere((cameraDesc) => cameraDesc.lensDirection == CameraLensDirection.back);

}
