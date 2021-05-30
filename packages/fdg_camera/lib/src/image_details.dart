import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

Image _imageWidgetFromFile(File file) => Image.file(file);

abstract class ImageDetails<T> {

  final T representationObject;

  ImageDetails (this.representationObject);

  Widget toWidget(BuildContext context);

}

class GalleryPickedImageDetails extends ImageDetails<Medium> {

  File? _croppedFile;

  GalleryPickedImageDetails (Medium medium) : super(medium);

  @override
  Widget toWidget(BuildContext context) {
    if (_croppedFile != null) {
      return _imageWidgetFromFile(_croppedFile!);
    } else {
      return FadeInImage(
        fit: BoxFit.cover,
        placeholder: MemoryImage(kTransparentImage),
        image: ThumbnailProvider(
          mediumId: representationObject.id,
          mediumType: representationObject.mediumType,
          highQuality: true,
        ),
      );
    }
  }

  void updateWithCroppedFile(File file) => _croppedFile = file;

  @override
  bool operator ==(other) {
    if (other is! GalleryPickedImageDetails) return false;
    return this.representationObject.id == other.representationObject.id;
  }

  @override
  int get hashCode => representationObject.id.hashCode;

}

class CameraCapturedImageDetails extends ImageDetails<File> {

  CameraCapturedImageDetails (File file) : super(file);

  @override
  Widget toWidget(BuildContext context) => _imageWidgetFromFile(representationObject);

  @override
  bool operator ==(other) {
    if (other is! CameraCapturedImageDetails) return false;
    return this.representationObject.path == other.representationObject.path;
  }

  @override
  int get hashCode => representationObject.path.hashCode;
}