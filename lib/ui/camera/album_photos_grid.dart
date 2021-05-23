import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/ui/camera/main_camera_cubit/main_camera_states.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../fdg_theme.dart';
import 'image_details.dart';
import 'main_camera_cubit/main_camera_cubit.dart';

class AlbumPhotosGrid extends StatelessWidget {
  final List<Medium> media;

  AlbumPhotosGrid(this.media);

  void _selectImage(BuildContext context, GalleryPickedImageDetails details) async {
    final mainCameraCubit = context.read<MainCameraCubit>();
    mainCameraCubit.selectImage(details);
  }

  @override
  Widget build(BuildContext context) {
    final mainCameraCubit = context.read<MainCameraCubit>();
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        ...media.map(
          (medium) => Container(
            color: Colors.grey[300],
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
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5)
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () => isSelected
                      ? mainCameraCubit.unSelectImage(imageDetails)
                      : _selectImage(context, imageDetails),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
