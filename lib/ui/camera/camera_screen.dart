import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/data/service_locator.dart';
import 'package:foodage/ui/camera/bar/camera_preview_bar.dart';
import 'package:foodage/ui/camera/camera_preview_frame/camera_preview_frame.dart';
import 'package:foodage/ui/camera/camera_preview_frame/camera_preview_frame_cubit/camera_preview_frame_cubit.dart';
import 'package:foodage/ui/camera/image_details.dart';
import 'package:foodage/ui/camera/image_preview_frame.dart';
import 'package:foodage/ui/camera/main_camera_cubit/main_camera_cubit.dart';
import 'package:foodage/ui/camera/main_camera_cubit/main_camera_states.dart';
import 'package:foodage/ui/camera/picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import 'package:foodage/ui/camera/picker/photo_picker_cubit/photo_picker_cubit.dart';
import 'package:foodage/ui/camera/picker/photo_picker_segments.dart';
import 'package:foodage/ui/ui_extensions.dart';

import '../../data/service_locator.dart';
import '../widgets/fdg_button.dart';
import '../widgets/fdg_ratio.dart';
import 'photo_container.dart';
import 'bar/camera_capture_bar.dart';
import 'picker/photo_picker_bottom_sheet.dart';

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
                      color: Colors.black,
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
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Text("Media", style: Theme.of(context).textTheme.caption),
                  margin: EdgeInsets.only(bottom: 3),
                ),
                Text(
                  "${context.read<MainCameraCubit>().state.selectedImages.length} geselecteerd",
                  style: Theme.of(context).textTheme.subtitle1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FoodCameraState extends State<FoodCamera> {
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
        BlocProvider<CameraPreviewFrameCubit>(create: (context) {
          final cameraPreviewCubit = CameraPreviewFrameCubit(sl.get());
          cameraPreviewCubit.init();
          return cameraPreviewCubit;
        }),
      ],
      child: Scaffold(
        body: BlocBuilder<MainCameraCubit, MainCameraState>(builder: (context, mainCameraState) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Column(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          FDGRatio(),
                        ],
                      )),
                      Positioned.fill(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ]),
                              child: SafeArea(
                                bottom: false,
                                child: _CameraScreenHeader(
                                  onContinuePressed: (context) {},
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Builder(builder: (context) {
                                  if (mainCameraState is MainCameraDefaultState) {
                                    return CameraPreviewFrame();
                                  } else if (mainCameraState is MainCameraImagePreviewingState) {
                                    final previewState = mainCameraState;
                                    return ImagePreviewFrame(
                                      child: previewState.previewImage.toWidget(context),
                                    );
                                  }
                                  throw InvalidStateFailure();
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  if (mainCameraState is MainCameraDefaultState) {
                    return CameraCaptureBar(
                      onCaptureTap: (BuildContext context) async {
                        final previewFrameCubit = context.read<CameraPreviewFrameCubit>();
                        final mainCubit = context.read<MainCameraCubit>();
                        final xFile = await previewFrameCubit.takePicture();
                        if (xFile != null) mainCubit.previewTakenPhoto(CameraCapturedImageDetails(xFile));
                      },
                      onSelectFromGalleryTap: (BuildContext context) => PhotoPickerBottomSheet.show(context),
                    );
                  } else if (mainCameraState is MainCameraImagePreviewingState) {
                    return CameraPreviewBar(
                      onCancelPressed: (context) => context.read<MainCameraCubit>().cancelPreview(),
                      onUsePhotoPressed: (context) => context.read<MainCameraCubit>().useTakenPhoto(),
                    );
                  }
                  throw InvalidStateFailure();
                })
              ],
            ),
          );
        }),
      ),
    );
  }
}
