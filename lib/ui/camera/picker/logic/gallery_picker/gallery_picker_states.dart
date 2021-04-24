import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryPickerState {}

class GalleryDataLoadingState extends GalleryPickerState {}

class GalleryPickerForbiddenState extends GalleryPickerState {}

class GalleryPickerErrorState extends GalleryPickerState {}

class AlbumState extends GalleryPickerState {
  final List<Album> albums;
  final Album selectedAlbum;

  AlbumState ({ this.albums, this.selectedAlbum });
}

class AlbumLoadingState extends AlbumState {

  AlbumLoadingState ({ List<Album> albums, Album selectedAlbum }) : super(
      albums: albums,
      selectedAlbum: selectedAlbum
  );

}
class AlbumLoadedState extends AlbumState {

  final MediaPage selectedMedia;

  AlbumLoadedState ({ List<Album> albums, Album selectedAlbum, this.selectedMedia }) : super(
      albums: albums,
      selectedAlbum: selectedAlbum
  );

}

class AlbumFailedToLoadState extends AlbumState {

  AlbumFailedToLoadState ({ List<Album> albums, Album selectedAlbum }) : super(
      albums: albums,
      selectedAlbum: selectedAlbum
  );

}