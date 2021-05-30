library fdg_camera;

import 'package:fdg_camera/src/camera_screen.dart';
import 'package:fdg_camera/src/data/photo_gallery_repository.dart';
import 'package:fdg_camera/src/image_details.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:flutter/material.dart';

export 'src/photo_container.dart';

class FDGCamera {
  static void initialize() async {
    sl.registerSingleton(PhotoGalleryRepository());
  }

  static Future<List<ImageDetails>?> show(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute<List<ImageDetails>>(
        builder: (context) => Camera(),
      ),
    );
  }
}
