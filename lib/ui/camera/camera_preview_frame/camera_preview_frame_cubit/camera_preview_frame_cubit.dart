import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/photos/camera_repository.dart';
import 'camera_preview_frame_states.dart';

class CameraPreviewFrameCubit extends Cubit<CameraPreviewFrameState> {
  List<CameraDescription>? _availableCameras;

  final CameraRepository _cameraRepository;

  CameraPreviewFrameCubit(this._cameraRepository) : super(CameraPreviewFrameState(cameraState: CameraState.idle));

  CameraController _cameraController(CameraDescription cameraDescription) =>
      CameraController(cameraDescription, ResolutionPreset.medium);

  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final hasPermissionForCamera = await _cameraRepository.checkPermission();
    if (!hasPermissionForCamera) {
      emit(state.copyWith(cameraState: CameraState.permissionsDenied));
      return;
    }
    _availableCameras = await _cameraRepository.getCameras();
    var selectedCameraDescription = _cameraRepository.getMainCamera(_availableCameras!);
    if (selectedCameraDescription == null && _availableCameras!.length > 0)
      selectedCameraDescription = _availableCameras!.first;
    if (selectedCameraDescription != null) {
      final newController = _cameraController(selectedCameraDescription);
      emit(state.copyWith(cameraState: CameraState.ready, controller: newController));
    } else {
      emit(state.copyWith(cameraState: CameraState.noCameraAvailable));
    }
  }

  void changeCamera(CameraDescription cameraDescription) {
    final newController = _cameraController(cameraDescription);
    emit(state.copyWith(cameraState: CameraState.ready, controller: newController));
  }


}
