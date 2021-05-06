import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumPhotosGrid extends StatelessWidget {

  final List<Medium> media;

  AlbumPhotosGrid (this.media);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        ...media.map(
              (medium) => Container(
            color: Colors.grey[300],
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: ThumbnailProvider(
                mediumId: medium.id,
                mediumType: medium.mediumType,
                highQuality: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

}