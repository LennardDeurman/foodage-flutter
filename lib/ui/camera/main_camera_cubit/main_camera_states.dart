import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/image_details.dart';

class MainCameraState {
  List<ImageDetails> selectedImages;

  MainCameraState({required this.selectedImages});

  MainCameraState copyWith({List<ImageDetails>? selectedImages}) {
    return MainCameraState(
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

class MainCameraDefaultState extends MainCameraState {
  MainCameraDefaultState({required List<ImageDetails> selectedImages}) : super(selectedImages: selectedImages);
}

class MainCameraImagePreviewingState extends MainCameraState {
  final ImageDetails previewImage;

  MainCameraImagePreviewingState({required List<ImageDetails> selectedImages, required this.previewImage})
      : super(selectedImages: selectedImages);
}
