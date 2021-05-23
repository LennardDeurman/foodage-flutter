import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/ui/camera/camera_option_button.dart';
import 'package:foodage/ui/camera/image_details.dart';
import '../../data/service_locator.dart';
import '../widgets/fdg_button.dart';
import '../ui_extensions.dart';
import '../fdg_theme.dart';
import 'photo_container.dart';
import 'image_preview_frame.dart';
import 'camera_preview_frame.dart';
import 'main_camera_cubit/main_camera_cubit.dart';
import 'main_camera_cubit/main_camera_states.dart';
import 'bar/camera_capture_bar.dart';
import 'bar/camera_preview_bar.dart';
import 'picker/photo_picker_bottom_sheet.dart';
import 'picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import 'picker/photo_picker_cubit/photo_picker_cubit.dart';
import 'picker/photo_picker_segments.dart';

class FoodCamera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FoodCameraState();
  }
}

class _CameraScreenHeader extends StatelessWidget {
  final WidgetTapCallback onContinuePressed;

  _CameraScreenHeader({required this.onContinuePressed});

  Widget _buildSelectedMedia(BuildContext context) {
    final mainCameraCubit = context.read<MainCameraCubit>();
    final selectedImages = mainCameraCubit.state.selectedImages;
    return ListView.builder(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int position) {
        final selectedImage = selectedImages[position];
        return Container(
          margin: EdgeInsets.only(right: 5),
          child: PhotoContainer(
            content: selectedImage.toWidget(
              context,
            ),
            onRemovePressed: (context) => mainCameraCubit.unSelectImage(selectedImage),
          ),
        );
      },
      itemCount: selectedImages.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final contextThemeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: new CircleBorder(),
                    onTap: () {},
                    splashColor: Colors.grey,
                    child: new Icon(
                      Icons.close,
                      size: 24,
                      color: FDGTheme().colors.darkRed,
                    ),
                  )),
              Theme(
                data: contextThemeData.copyWith(
                    textTheme: contextThemeData.textTheme
                        .copyWith(button: contextThemeData.textTheme.button!.copyWith(fontSize: 13))),
                child: FDGPrimaryButton(
                  "Doorgaan",
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  borderRadius: 8,
                  onTap: onContinuePressed,
                ),
              )
            ],
          ),
          Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                constraints: BoxConstraints(
                  maxHeight: 100,
                ),
                child: _buildSelectedMedia(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FoodCameraState extends State<FoodCamera> {

  final cameraPreviewKey = GlobalKey<CameraPreviewFrameState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCameraCubit>(create: (context) => MainCameraCubit()),
        BlocProvider<GalleryPickerCubit>(create: (context) {
          final galleryPickerCubit = GalleryPickerCubit(sl.get());
          galleryPickerCubit.loadInitialAlbum();
          return galleryPickerCubit;
        }),
        BlocProvider<PhotoPickerCubit>(
            create: (context) => PhotoPickerCubit(segments: getPhotoPickerSegments(context))),
      ],
      child: Scaffold(
        body: BlocBuilder<MainCameraCubit, MainCameraState>(builder: (context, mainCameraState) {
          return Stack(
            children: [
              Positioned.fill(
                child: Builder(
                  builder: (context) {
                    if (mainCameraState is MainCameraImagePreviewingState) {
                      final previewState = mainCameraState;
                      return ImagePreviewFrame(
                        child: previewState.previewImage.toWidget(context),
                      );
                    }
                    return CameraPreviewFrame(key: cameraPreviewKey);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: _CameraScreenHeader(onContinuePressed: (context) {}),
                  top: true,
                  bottom: false,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Builder(
                  builder: (context) {
                    if (mainCameraState is MainCameraDefaultState) {
                      return CameraCaptureBar(
                        isEnabled: mainCameraState.readyState == MainCameraReadyState.ready,
                        isLoading: mainCameraState.readyState == MainCameraReadyState.preparingOutput,
                        actions: Column(
                          children: [
                            cameraPreviewKey.currentState!.changeFlashButton(),
                            SizedBox(height: 8,),
                            cameraPreviewKey.currentState!.changeFlashButton(),
                          ],
                        ),
                        onCaptureTap: (BuildContext context) async {
                          final mainCameraCubit = context.read<MainCameraCubit>();
                          mainCameraCubit.handleImageCapture(
                            captureImageCallback: () {
                              Future<File> future = cameraPreviewKey.currentState!.capture();
                              return future;
                            },
                          );
                        },
                        onSelectFromGalleryTap: (BuildContext context) {
                          final galleryPickerCubit = context.read<GalleryPickerCubit>();
                          galleryPickerCubit.verifyPermissionsAndReload().then(
                                (_) => PhotoPickerBottomSheet.show(context),
                          );
                        },
                      );
                    }
                    throw InvalidStateFailure();
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
