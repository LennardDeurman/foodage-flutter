import 'package:flutter_bloc/flutter_bloc.dart';

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

  void unSelectImage(ImageDetails image) => this.state.selectedImages.removeWhere((aImage) => aImage == image);

  bool isSelectedImage(ImageDetails image) => this.state.selectedImages.contains(image);

  void previewTakenPhoto(ImageDetails imageDetails) =>
      emit(MainCameraImagePreviewingState(selectedImages: this.state.selectedImages, previewImage: imageDetails));

  void cancelPreview() => emit(MainCameraDefaultState(selectedImages: this.state.selectedImages));

  void useTakenPhoto()  {
    final imagePreviewState = ensureInCurrentState<MainCameraImagePreviewingState>();
    final image = imagePreviewState.previewImage;
    final selectedImages = imagePreviewState.selectedImages;
    selectedImages.add(image);
    emit(MainCameraDefaultState(selectedImages: selectedImages));
  }
}
