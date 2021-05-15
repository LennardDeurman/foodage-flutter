import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../ui_extensions.dart';
import '../../fdg_theme.dart';
import '../camera_preview_frame/camera_preview_frame_cubit/camera_preview_frame_cubit.dart';
import '../camera_preview_frame/camera_preview_frame_cubit/camera_preview_frame_states.dart';
import '../picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import '../picker/gallery_picker_cubit/gallery_picker_states.dart';
import 'camera_bar.dart';

class _CaptureButton extends StatelessWidget {
  final double size;
  final double innerMargin;
  final Color buttonColor;
  final Color borderColor;
  final WidgetTapCallback onTap;

  const _CaptureButton({
    required this.onTap,
    required this.size,
    this.innerMargin = 2,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.grey,
  });

  double get _innerSize => size - innerMargin;

  double get _innerBorderRadius => _innerSize / 2;

  double get _borderRadius => size / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: buttonColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap(context),
            child: Container(
              width: size,
              height: size,
              child: Center(
                child: Container(
                  width: _innerSize,
                  height: _innerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_innerBorderRadius),
                    border: Border.all(color: borderColor, width: innerMargin),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectFromGalleryButton extends StatelessWidget {

  static const _width = 65.0;
  static const _imageHeight = 45.0;

  final WidgetTapCallback onTap;

  _SelectFromGalleryButton ({ required this.onTap });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: InkWell(
            onTap: () => onTap(context),
            child: SizedBox(
              width: _width,
              height: _imageHeight,
              child: _buildImage(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return BlocBuilder<GalleryPickerCubit, GalleryPickerState>(
      builder: (context, state) {
        if (state is AlbumState) {
          return Image(
            fit: BoxFit.cover,
            image: AlbumThumbnailProvider(
              albumId: state.albumData.selectedAlbum!.id,
              width: 128,
              height: 128,
            ),
          );
        }
        return Container(
          color: FDGTheme().colors.lightGrey1,
          child: Center(
            child: Icon(Icons.add_photo_alternate_outlined, color: FDGTheme().colors.darkGrey,),
          ),
        );
      },
    );
  }

}

class CameraCaptureBar extends StatelessWidget {

  static const _captureButtonSize = 50.0;

  final WidgetTapCallback onCaptureTap;
  final WidgetTapCallback onSelectFromGalleryTap;

  CameraCaptureBar ({ required this.onCaptureTap, required this.onSelectFromGalleryTap });

  @override
  Widget build(BuildContext context) {
    return CameraBarContainer(
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: _SelectFromGalleryButton(
                  onTap: onSelectFromGalleryTap,
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: 20
                ),
              )
          ),
          Align(
            alignment: Alignment.center,
            child: Builder(
              builder: (context) {
                final captureButton = _CaptureButton(
                  size: _captureButtonSize,
                  onTap: onCaptureTap,
                );
                final previewCubit = context.read<CameraPreviewFrameCubit>();
                final cameraState = previewCubit.state.cameraState;
                if (cameraState == CameraState.preparingOutput) {
                  return IgnorePointer( //disable when the cubit is processing photo
                    child: Opacity(
                      opacity: 0.7,
                      child: captureButton,
                    ),
                  );
                }
                return captureButton;
              }
            ),
          )
        ],
      ),
    );
  }

}
