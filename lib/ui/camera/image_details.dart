import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

abstract class ImageDetails<T> {

  final T representationObject;

  ImageDetails (this.representationObject);

  Widget toWidget(BuildContext context);

}

class GalleryPickedImageDetails extends ImageDetails<Medium> {

  GalleryPickedImageDetails (Medium medium) : super(medium);

  @override
  Widget toWidget(BuildContext context) => FadeInImage(
    fit: BoxFit.cover,
    placeholder: MemoryImage(kTransparentImage),
    image: ThumbnailProvider(
      mediumId: representationObject.id,
      mediumType: representationObject.mediumType,
      highQuality: true,
    ),
  );

}

class CameraCapturedImageDetails extends ImageDetails<XFile> {

  CameraCapturedImageDetails (XFile xFile) : super(xFile);

  @override
  Widget toWidget(BuildContext context) => Image.file(File(this.representationObject.path));
}