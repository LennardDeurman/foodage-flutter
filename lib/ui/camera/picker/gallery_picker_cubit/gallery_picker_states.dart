import 'package:photo_gallery/photo_gallery.dart';

import 'gallery_picker_cubit.dart';

abstract class GalleryPickerState {
  const GalleryPickerState();
}

class GalleryPickerIdleState extends GalleryPickerState {}

class GalleryDataLoadingState extends GalleryPickerState {}

class GalleryPickerForbiddenState extends GalleryPickerState {}

class GalleryPickerErrorState extends GalleryPickerState {}

class AlbumState extends GalleryPickerState {
  final AlbumData albumData;

  const AlbumState({
    required this.albumData,
  });
}

class AlbumLoadingState extends AlbumState {
  const AlbumLoadingState({
    required AlbumData albumData,
  }) : super(albumData: albumData);
}

class AlbumLoadedState extends AlbumState {
  final List<Medium> media;

  const AlbumLoadedState({
    required AlbumData albumData,
    required this.media,
  }) : super(albumData: albumData);

  AlbumLoadedState copyWith({
    AlbumData? albumData,
    List<Medium>? media,
  }) {
    return AlbumLoadedState(
      albumData: albumData ?? this.albumData,
      media: media ?? this.media,
    );
  }
}

//Album is already loaded, but data is expanding / extending
class AlbumExtendingState extends AlbumLoadedState {
  const AlbumExtendingState({
    required AlbumData albumData,
    required List<Medium> media,
  }) : super(albumData: albumData, media: media);
}

class AlbumFailedToLoadState extends AlbumState {
  const AlbumFailedToLoadState({
    required AlbumData albumData,
  }) : super(albumData: albumData);
}
