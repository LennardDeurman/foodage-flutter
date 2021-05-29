import '../image_details.dart';

enum MainCameraReadyState {
  ready,
  preparingOutput,
}

class MainCameraState {
  final List<ImageDetails> selectedImages;

  final MainCameraReadyState readyState;

  const MainCameraState({
    required this.selectedImages,
    this.readyState = MainCameraReadyState.preparingOutput,
  });

  MainCameraState copyWith({List<ImageDetails>? selectedImages}) {
    return MainCameraState(
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

class MainCameraDefaultState extends MainCameraState {
  const MainCameraDefaultState({
    required List<ImageDetails> selectedImages,
    MainCameraReadyState readyState = MainCameraReadyState.ready,
  }) : super(
          selectedImages: selectedImages,
          readyState: readyState,
        );

  MainCameraDefaultState copyWith({List<ImageDetails>? selectedImages}) {
    return MainCameraDefaultState(
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

