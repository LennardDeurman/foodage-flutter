import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../../data/photos/photo_gallery_repository.dart';
import 'gallery_picker_states.dart';
import '../../../../custom_errors.dart';
import 'package:foodage/extensions/cubit_extensions.dart';

class AlbumData {
  final List<Album>? albums;
  final Album? selectedAlbum;

  AlbumData({this.albums, this.selectedAlbum});

  AlbumData copyWith({List<Album>? albums, Album? selectedAlbum}) {
    return AlbumData(
      albums: albums ?? this.albums,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum,
    );
  }
}

class GalleryPickerCubit extends Cubit<GalleryPickerState> {
  static const _galleryLoadLimit = 30;

  final PhotoGalleryRepository _photoGalleryRepository;

  GalleryPickerCubit(this._photoGalleryRepository) : super(GalleryPickerIdleState());

  void _loadAlbumData({required Album selectedAlbum, List<Album>? albums}) async {
    var albumData = state is AlbumState ? (state as AlbumState).albumData : AlbumData();
    try {
      albumData = albumData.copyWith(
        albums: albums,
        selectedAlbum: selectedAlbum,
      );
      emit(
        AlbumLoadingState(albumData: albumData),
      );
      final mediaPage = await selectedAlbum.listMedia(take: _galleryLoadLimit);
      emit(
        AlbumLoadedState(albumData: albumData, media: mediaPage.items),
      );
    } catch (e) {
      emit(
        AlbumFailedToLoadState(albumData: albumData),
      );
    }
  }

  void loadMoreOfAlbum() async {
    if (state is AlbumExtendingState) {
      //If data is already loading then do not request more
      return;
    }
    final currentState = ensureInCurrentState<AlbumLoadedState>();
    final currentMedia = currentState.media;
    final newOffset = currentMedia.length;
    emit(
      AlbumExtendingState(
        albumData: currentState.albumData,
        media: currentMedia,
      ),
    );
    final newMediaPage = await currentState.albumData.selectedAlbum!.listMedia(
      skip: newOffset,
      take: _galleryLoadLimit,
    );
    emit(
      currentState.copyWith(
        media: currentMedia + newMediaPage.items,
      ),
    );
  }

  Future verifyPermissionsAndReload() async {
    final permissionGranted = await _photoGalleryRepository.checkPermission();
    if (permissionGranted && state is! AlbumState) {
      final albums = await _photoGalleryRepository.getPhotoAlbums();
      _loadAlbumData(
        albums: albums,
        selectedAlbum: albums[0],
      );
    }
  }

  void loadInitialAlbum() async {
    emit(GalleryDataLoadingState());
    final permissionGranted = await _photoGalleryRepository.checkPermission();
    if (permissionGranted) {
      final albums = await _photoGalleryRepository.getPhotoAlbums();
      _loadAlbumData(
        albums: albums,
        selectedAlbum: albums[0],
      );
    } else {
      emit(GalleryPickerForbiddenState());
    }
  }

  void changeAlbumAndLoadData(Album album) {
    _loadAlbumData(selectedAlbum: album);
  }
}
