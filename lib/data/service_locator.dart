import 'package:foodage/data/photos/camera_repository.dart';
import 'package:get_it/get_it.dart';

import 'photos/photo_gallery_repository.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {

  static Future<void> init() async {
    await _registerRepositories();
  }

  static Future<void> _registerRepositories() async {
    sl.registerSingleton(PhotoGalleryRepository());
    sl.registerSingleton(CameraRepository());
  }

}