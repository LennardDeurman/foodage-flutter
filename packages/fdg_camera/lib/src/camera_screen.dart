import 'dart:io';
import 'package:fdg_camera/src/fdg_camera_locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_camera/src/image_details.dart';
import 'package:fdg_camera/src/photo_container.dart';
import 'package:fdg_camera/src/camera_preview_frame.dart';
import 'package:fdg_camera/src/main_camera_cubit/main_camera_cubit.dart';
import 'package:fdg_camera/src/bar/camera_capture_bar.dart';
import 'package:fdg_camera/src/picker/photo_picker_bottom_sheet.dart';
import 'package:fdg_camera/src/picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import 'package:fdg_camera/src/picker/photo_picker_cubit/photo_picker_cubit.dart';
import 'package:fdg_camera/src/picker/photo_picker_segments.dart';

class Camera extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CameraState();
  }
}

class _CameraScreenHeader extends StatelessWidget {
  final WidgetTapCallback onContinuePressed;
  final WidgetTapCallback onClosePressed;

  _CameraScreenHeader({
    required this.onContinuePressed,
    required this.onClosePressed,
  });

  Widget _buildSelectedMedia(BuildContext context) {
    final mainCameraCubit = context.read<MainCameraCubit>();
    final selectedImages = mainCameraCubit.state.selectedImages;
    return ListView.builder(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int position) {
        final selectedImage = selectedImages[position];
        final isGalleryImage = selectedImage is GalleryPickedImageDetails;
        return Container(
          margin: EdgeInsets.only(right: 5),
          child: PhotoContainer(
            content: selectedImage.toWidget(
              context,
            ),
            onRemovePressed: (context) => mainCameraCubit.unSelectImage(selectedImage),
            onEditPressed: () {
              if (isGalleryImage) {
                return (context) => mainCameraCubit.editGalleryPickedImage(
                      selectedImage as GalleryPickedImageDetails,
                    );
              }
            }(),
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
                  customBorder: CircleBorder(),
                  onTap: () => onClosePressed(context),
                  splashColor: Colors.grey,
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: FDGTheme().colors.darkRed,
                  ),
                ),
              ),
              Theme(
                data: contextThemeData.copyWith(
                  textTheme: contextThemeData.textTheme.copyWith(
                    button: contextThemeData.textTheme.button!.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
                child: FDGPrimaryButton(
                  FDGCameraLocaleKeys.continueButton.tr(),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  borderRadius: 8,
                  onTap: onContinuePressed,
                ),
              )
            ],
          ),
          Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                ),
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

class CameraState extends State<Camera> {
  final _cameraPreviewKey = GlobalKey<CameraPreviewFrameState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCameraCubit>(
          create: (context) => MainCameraCubit(),
        ),
        BlocProvider<GalleryPickerCubit>(
          create: (context) {
            final galleryPickerCubit = GalleryPickerCubit(
              sl.get(),
            );
            galleryPickerCubit.loadInitialAlbum();
            return galleryPickerCubit;
          },
        ),
        BlocProvider<PhotoPickerCubit>(
          create: (context) => PhotoPickerCubit(
            segments: getPhotoPickerSegments(context),
          ),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<MainCameraCubit, MainCameraState>(
          builder: (context, mainCameraState) {
            return Stack(
              children: [
                Positioned.fill(
                  child: CameraPreviewFrame(
                    key: _cameraPreviewKey,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: _CameraScreenHeader(
                      onContinuePressed: (context) => Navigator.pop(
                        context,
                        mainCameraState.selectedImages,
                      ),
                      onClosePressed: (context) => Navigator.pop(
                        context,
                      ),
                    ),
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
                          onCaptureTap: (BuildContext context) async {
                            final mainCameraCubit = context.read<MainCameraCubit>();
                            mainCameraCubit.handleImageCapture(
                              captureImageCallback: () {
                                Future<File> future = _cameraPreviewKey.currentState!.capture();
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
          },
        ),
      ),
    );
  }
}
