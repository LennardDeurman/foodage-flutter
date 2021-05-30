import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_camera/src/picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import 'package:fdg_camera/src/bar/camera_bar.dart';

class _CaptureButton extends StatelessWidget {
  final double size;
  final double innerMargin;

  final bool isLoading;
  final bool isEnabled;

  final Color buttonColor;
  final Color borderColor;

  final WidgetTapCallback onTap;

  const _CaptureButton({
    required this.onTap,
    required this.size,
    this.isEnabled = true,
    this.isLoading = false,
    this.innerMargin = 2,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.grey,
    Key? key
  }) : super(key: key);

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
            child: SizedBox.fromSize(
              size: Size.square(size),
              child: Center(
                child: Container(
                  width: _innerSize,
                  height: _innerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_innerBorderRadius),
                    border: Border.all(color: borderColor, width: innerMargin),
                  ),
                  child: isLoading
                      ? Center(
                          child: SizedBox.fromSize(
                            size: Size.square(20),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : null,
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
  static const _thumbnailSize = 128;

  final WidgetTapCallback onTap;

  const _SelectFromGalleryButton({
    required this.onTap,
    Key? key
  }) : super(key: key);

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
              width: _thumbnailSize,
              height: _thumbnailSize,
            ),
          );
        }
        return Container(
          color: FDGTheme().colors.lightGrey1,
          child: Center(
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: FDGTheme().colors.darkGrey,
            ),
          ),
        );
      },
    );
  }
}

class CameraCaptureBar extends StatelessWidget {
  static const _captureButtonSize = 50.0;
  static const _opacityWhenProcessing = 0.7;

  final WidgetTapCallback onCaptureTap;
  final WidgetTapCallback onSelectFromGalleryTap;

  final bool isLoading;
  final bool isEnabled;

  const CameraCaptureBar({
    required this.onCaptureTap,
    required this.onSelectFromGalleryTap,
    this.isLoading = false,
    this.isEnabled = true,
    Key? key
  }) : super(key: key);

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
                horizontal: 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Builder(builder: (context) {
              final captureButton = _CaptureButton(
                size: _captureButtonSize,
                onTap: onCaptureTap,
                isLoading: isLoading,
              );
              if (!isEnabled) {
                return IgnorePointer(
                  //disable when the cubit is processing photo
                  child: Opacity(
                    opacity: _opacityWhenProcessing,
                    child: captureButton,
                  ),
                );
              }
              return captureButton;
            }),
          ),
        ],
      ),
    );
  }
}
