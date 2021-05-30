import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

class PhotoGalleryRepository {

  Future<bool> checkPermission() async {
    if (Platform.isIOS) {
      return await Permission.storage.request().isGranted && await Permission.photos.request().isGranted;
    } else if (Platform.isAndroid) {
      return await Permission.storage.request().isGranted;
    }
    return false;
  }

  Future<List<Album>> getPhotoAlbums() {
    return PhotoGallery.listAlbums(mediumType: MediumType.image);
  }

}