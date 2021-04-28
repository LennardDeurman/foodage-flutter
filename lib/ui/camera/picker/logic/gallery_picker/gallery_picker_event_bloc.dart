import 'package:photo_gallery/photo_gallery.dart';

import '../../../../../data/photos/photo_gallery_repository.dart';
import '../../../../architecture.dart';
import 'gallery_picker_states.dart';
import 'gallery_picker_events.dart';

class AlbumData {

  final List<Album> albums;
  final Album selectedAlbum;

  AlbumData ({ this.albums, this.selectedAlbum });

  AlbumData copyWith({ List<Album> albums, Album selectedAlbum }) {
    return AlbumData(
      albums: albums ?? this.albums,
      selectedAlbum: selectedAlbum ?? this.selectedAlbum
    );
  }

}


class GalleryPickerEventBloc extends EventBloc<GalleryPickerEvent, GalleryPickerState> {

  final PhotoGalleryRepository _photoGalleryRepository;

  GalleryPickerEventBloc (this._photoGalleryRepository);


  Stream<AlbumState> _loadAlbumData({ List<Album> albums, Album selectedAlbum }) async* {
    var albumData = state is AlbumState ? (state as AlbumState).albumData : AlbumData();
    try {
      albumData = albumData.copyWith(
        albums: albums,
        selectedAlbum: selectedAlbum,
      );
      yield AlbumLoadingState(albumData: albumData);
      yield AlbumLoadedState(albumData: albumData, selectedMedia: await selectedAlbum.listMedia());
    } catch (e) {
      yield AlbumFailedToLoadState(albumData: albumData);
    }
  }

  Stream<GalleryPickerState> _init() async* {
    yield GalleryDataLoadingState();
    final permissionGranted = await  _photoGalleryRepository.checkPermission();
    if (permissionGranted) {
      final albums = await _photoGalleryRepository.getPhotoAlbums();
      yield* _loadAlbumData(
          albums: albums,
          selectedAlbum: albums[0]
      );
    } else {
      yield GalleryPickerForbiddenState();
    }
  }

  @override
  Stream<GalleryPickerState> mapEventToState(GalleryPickerEvent event) async* {
    try {
      if (event is GalleryPickerInitEvent) {
        yield* _init();
      } else if (event is GalleryPickerAlbumChangeEvent) {
        yield* _loadAlbumData(
            selectedAlbum: event.album
        );
      }
    } catch (e) {
      yield GalleryPickerErrorState();
    }

  }

}