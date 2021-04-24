import 'package:foodage/data/photos/photo_gallery_repository.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {

  static Future<void> init() async {
    await _registerRepositories();
  }

  static Future<void> _registerRepositories() async {
    sl.registerSingleton(PhotoGalleryRepository());
  }

}