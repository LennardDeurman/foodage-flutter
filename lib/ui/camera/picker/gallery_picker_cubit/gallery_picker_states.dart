import 'package:photo_gallery/photo_gallery.dart';

import 'gallery_picker_cubit.dart';

abstract class GalleryPickerState {}

class GalleryPickerIdleState extends GalleryPickerState {}

class GalleryDataLoadingState extends GalleryPickerState {}

class GalleryPickerForbiddenState extends GalleryPickerState {}

class GalleryPickerErrorState extends GalleryPickerState {}

class AlbumState extends GalleryPickerState {

  final AlbumData albumData;

  AlbumState ({ required this.albumData });

}

class AlbumLoadingState extends AlbumState {

  AlbumLoadingState ({ required AlbumData albumData }) : super(
      albumData: albumData
  );

}
class AlbumLoadedState extends AlbumState {

  final MediaPage selectedMedia;

  AlbumLoadedState ({ required AlbumData albumData, required this.selectedMedia }) : super(
      albumData: albumData
  );

}

class AlbumFailedToLoadState extends AlbumState {

  AlbumFailedToLoadState ({ required AlbumData albumData }) : super(
      albumData: albumData
  );

}