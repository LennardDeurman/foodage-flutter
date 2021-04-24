import 'package:photo_gallery/photo_gallery.dart';

abstract class GalleryPickerEvent {}

class GalleryPickerInitEvent extends GalleryPickerEvent {}

class GalleryPickerAlbumChangeEvent extends GalleryPickerEvent {

  final Album album;

  GalleryPickerAlbumChangeEvent (this.album);

}