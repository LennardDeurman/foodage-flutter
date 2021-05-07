import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../fdg_theme.dart';
import 'image_details.dart';
import 'main_camera_cubit/main_camera_cubit.dart';

class AlbumPhotosGrid extends StatelessWidget {

  final List<Medium> media;

  AlbumPhotosGrid (this.media);

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
            child: Builder(
              builder: (context) {
                final imageDetails = GalleryPickedImageDetails(medium);
                return Stack(
                  children: [
                    Material(
                      child: InkWell(
                        child: imageDetails.toWidget(context),
                        onTap: () => mainCameraCubit.selectImage(imageDetails),
                      ),
                    ),
                    Visibility(
                      visible: mainCameraCubit.isSelectedImage(imageDetails),
                      child: Container(
                        child: Center(
                          child: Icon(Icons.done, size: 32, color: FDGTheme().colors.darkRed,),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

}