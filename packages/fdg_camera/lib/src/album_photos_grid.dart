import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_camera/src/picker/gallery_picker_cubit/gallery_picker_cubit.dart';
import 'package:fdg_camera/src/image_details.dart';
import 'package:fdg_camera/src/main_camera_cubit/main_camera_cubit.dart';

class AlbumPhotosGrid extends StatelessWidget {
  static const _scrollLoadOffset = 100;

  final List<Medium> media;

  AlbumPhotosGrid(this.media);

  void _selectImage(BuildContext context, GalleryPickedImageDetails details) async {
    final mainCameraCubit = context.read<MainCameraCubit>();
    mainCameraCubit.selectImage(details);
  }

  bool _handleScrollNotification(BuildContext context, ScrollNotification scrollNotification) {
    final bottomReached =
        scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent - _scrollLoadOffset;
    if (bottomReached) {
      final galleryPickerCubit = context.read<GalleryPickerCubit>();
      galleryPickerCubit.loadMoreOfAlbum();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mainCameraCubit = context.read<MainCameraCubit>();
    return NotificationListener<ScrollNotification>(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          ...media.map(
            (medium) => Container(
              color: FDGTheme().colors.lightGrey1,
              child: BlocBuilder<MainCameraCubit, MainCameraState>(builder: (context, state) {
                final imageDetails = GalleryPickedImageDetails(medium);
                final isSelected = mainCameraCubit.isSelectedImage(imageDetails);
                return Material(
                  child: InkWell(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: imageDetails.toWidget(context),
                        ),
                        Visibility(
                          visible: isSelected,
                          child: Container(
                            child: Center(
                              child: Icon(
                                Icons.done,
                                size: 32,
                                color: FDGTheme().colors.darkRed,
                              ),
                            ),
                            decoration: BoxDecoration(color: Colors.white60),
                          ),
                        )
                      ],
                    ),
                    onTap: () => isSelected
                        ? mainCameraCubit.unSelectImage(imageDetails)
                        : _selectImage(
                            context,
                            imageDetails,
                          ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      onNotification: (scrollNotification) => _handleScrollNotification(
        context,
        scrollNotification,
      ),
    );
  }
}
