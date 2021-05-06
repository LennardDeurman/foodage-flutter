import 'package:photo_gallery/photo_gallery.dart';

import 'gallery_picker_cubit.dart';

abstract class GalleryPickerState {}

class GalleryPickerIdleState extends GalleryPickerState {}

class GalleryDataLoadingState extends GalleryPickerState {}

class GalleryPickerForbiddenState extends GalleryPickerState {}

class GalleryPickerErrorState extends GalleryPickerState {}

class AlbumState extends GalleryPickerState {

  final AlbumData albumData;

  AlbumState ({ this.albumData });

}

class AlbumLoadingState extends AlbumState {

  AlbumLoadingState ({ AlbumData albumData }) : super(
      albumData: albumData
  );

}
class AlbumLoadedState extends AlbumState {

  final MediaPage selectedMedia;

  AlbumLoadedState ({ AlbumData albumData, this.selectedMedia }) : super(
      albumData: albumData
  );

}

class AlbumFailedToLoadState extends AlbumState {

  AlbumFailedToLoadState ({ AlbumData albumData }) : super(
      albumData: albumData
  );

}