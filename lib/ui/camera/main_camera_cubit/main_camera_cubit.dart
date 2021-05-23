import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/ui/fdg_theme.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../ui_extensions.dart';
import '../image_details.dart';
import 'main_camera_states.dart';

class MainCameraCubit extends Cubit<MainCameraState> {
  MainCameraCubit() : super(MainCameraDefaultState(selectedImages: []));

  void selectImage(ImageDetails image) {
    final selectedImages = this.state.selectedImages;
    if (!selectedImages.contains(image)) {
      selectedImages.add(image);
      emit(this.state.copyWith(selectedImages: selectedImages));
    }
  }

  Future<File?> cropImage(File imageFile) async {
    return ImageCropper.cropImage(
        sourcePath: imageFile.path,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: '',
          toolbarWidgetColor: FDGTheme().colors.darkRed,
          showCropGrid: false,
          dimmedLayerColor: Colors.white.withOpacity(0.5),
          backgroundColor: Colors.black45,
          hideBottomControls: true,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          aspectRatioLockEnabled: true,
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
          rectX: 0,
          cancelButtonTitle: 'Annuleren',
          doneButtonTitle: 'Gereed',
        )
    );
  }

  void unSelectImage(ImageDetails image) {
    final selectedImages = this.state.selectedImages;
    selectedImages.removeWhere((aImage) => aImage == image);
    emit(this.state.copyWith(
      selectedImages: selectedImages
    ));
  }

  bool isSelectedImage(ImageDetails image) => this.state.selectedImages.contains(image);

  void useTakenPhoto() {
    final imagePreviewState = ensureInCurrentState<MainCameraImagePreviewingState>();
    final image = imagePreviewState.previewImage;
    final selectedImages = imagePreviewState.selectedImages;
    selectedImages.add(image);
    emit(MainCameraDefaultState(selectedImages: selectedImages));
  }

  void handleImageCapture({required Future<File> Function() captureImageCallback}) async {
    emit(
      MainCameraDefaultState(
        selectedImages: state.selectedImages,
        readyState: MainCameraReadyState.preparingOutput,
      ),
    );
    try {
      final imageFile = await captureImageCallback();
      final croppedImageDetails = await cropImage(imageFile).then((croppedFile) {
        if (croppedFile == null) throw InvalidStateFailure();
        return CameraCapturedImageDetails(croppedFile);
      });
      emit(MainCameraDefaultState(selectedImages: state.selectedImages, readyState: MainCameraReadyState.ready));
      selectImage(croppedImageDetails);
    } on Exception {
      emit(MainCameraDefaultState(selectedImages: state.selectedImages));
    }
  }
}
