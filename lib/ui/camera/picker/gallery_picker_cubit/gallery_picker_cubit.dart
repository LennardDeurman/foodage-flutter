import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../../data/photos/photo_gallery_repository.dart';
import 'gallery_picker_states.dart';

class AlbumData {
  final List<Album> albums;
  final Album selectedAlbum;

  AlbumData({this.albums, this.selectedAlbum});

  AlbumData copyWith({List<Album> albums, Album selectedAlbum}) {
    return AlbumData(
      albums: albums ?? this.albums,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum,
    );
  }
}

class GalleryPickerCubit extends Cubit<GalleryPickerState> {
  final PhotoGalleryRepository _photoGalleryRepository;

  GalleryPickerCubit(this._photoGalleryRepository) : super(GalleryPickerIdleState());

  void _loadAlbumData({List<Album> albums, Album selectedAlbum}) async {
    var albumData = state is AlbumState ? (state as AlbumState).albumData : AlbumData();
    try {
      albumData = albumData.copyWith(
        albums: albums,
        selectedAlbum: selectedAlbum,
      );
      emit(AlbumLoadingState(albumData: albumData));
      emit(AlbumLoadedState(albumData: albumData, selectedMedia: await selectedAlbum.listMedia()));
    } catch (e) {
      emit(AlbumFailedToLoadState(albumData: albumData));
    }
  }

  void loadInitialAlbum() async {
    emit(GalleryDataLoadingState());
    final permissionGranted = await _photoGalleryRepository.checkPermission();
    if (permissionGranted) {
      final albums = await _photoGalleryRepository.getPhotoAlbums();
      _loadAlbumData(albums: albums, selectedAlbum: albums[0]);
    } else {
      emit(GalleryPickerForbiddenState());
    }
  }

  void changeAlbumAndLoadData(Album album) {
    _loadAlbumData(selectedAlbum: album);
  }
}
