import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/ui/fdg_theme.dart';
import 'package:foodage/ui/widgets/fdg_ratio.dart';
import 'package:foodage/extensions/list_extensions.dart';
import 'package:foodage/extensions/cubit_extensions.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as imgUtils;

import '../../../custom_errors.dart';
import '../image_details.dart';
import 'main_camera_states.dart';

class MainCameraCubit extends Cubit<MainCameraState> {
  MainCameraCubit()
      : super(
          MainCameraDefaultState(
            selectedImages: [],
          ),
        );

  void selectImage(ImageDetails image) {
    final selectedImages = state.selectedImages;
    if (!selectedImages.contains(image)) {
      selectedImages.add(image);
      emit(
        state.copyWith(
          selectedImages: selectedImages,
        ),
      );
    }
  }

  Future<File?> cropImage(File imageFile) async {
    final imgInfo = imgUtils.decodeImage(
      imageFile.readAsBytesSync(),
    );
    final size = Size(
      imgInfo!.width.toDouble(),
      imgInfo.width.toDouble() / FDGRatio.aspectRatio,
    );
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
        rectX: imgInfo.width / 2 - size.width / 2,
        rectY: imgInfo.height / 2 - size.height / 2,
        rectWidth: size.width,
        rectHeight: size.height,
        cancelButtonTitle: 'Annuleren',
        doneButtonTitle: 'Gereed',
      ),
    );
  }

  void editGalleryPickedImage(GalleryPickedImageDetails imageDetails) async {
    final originalFile = await imageDetails.representationObject.getFile();
    final newFile = await cropImage(originalFile);
    if (newFile != null) {
      final newImageDetails = imageDetails;
      imageDetails.updateWithCroppedFile(newFile);
      final newSelectedImages = state.selectedImages;
      newSelectedImages.replace(
        imageDetails,
        newImageDetails,
      );
      emit(
        state.copyWith(
          selectedImages: newSelectedImages,
        ),
      );
    }
  }

  void unSelectImage(ImageDetails image) {
    final selectedImages = this.state.selectedImages;
    selectedImages.removeWhere(
      (aImage) => aImage == image,
    );
    emit(
      this.state.copyWith(
            selectedImages: selectedImages,
          ),
    );
  }

  bool isSelectedImage(ImageDetails image) => this.state.selectedImages.contains(image);

  void handleImageCapture({required Future<File> Function() captureImageCallback}) async {
    emit(
      MainCameraDefaultState(
        selectedImages: state.selectedImages,
        readyState: MainCameraReadyState.preparingOutput,
      ),
    );
    try {
      final imageFile = await captureImageCallback().timeout(
        Duration(
          seconds: 3,
        ),
      );
      final croppedImageDetails = await cropImage(imageFile).then((croppedFile) {
        if (croppedFile == null) throw InvalidStateFailure();
        return CameraCapturedImageDetails(croppedFile);
      });
      emit(
        MainCameraDefaultState(
          selectedImages: state.selectedImages,
          readyState: MainCameraReadyState.ready,
        ),
      );
      selectImage(croppedImageDetails);
    } on Exception {
      emit(
        MainCameraDefaultState(
          selectedImages: state.selectedImages,
        ),
      );
    }
  }
}
