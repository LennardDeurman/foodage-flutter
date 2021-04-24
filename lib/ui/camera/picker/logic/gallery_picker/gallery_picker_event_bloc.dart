import 'package:photo_gallery/photo_gallery.dart';

import '../../../../../data/photos/photo_gallery_repository.dart';
import '../../../../architecture.dart';
import 'gallery_picker_states.dart';
import 'gallery_picker_events.dart';


class GalleryPickerEventBloc extends EventBloc<GalleryPickerEvent, GalleryPickerState> {

  final PhotoGalleryRepository _photoGalleryRepository;

  GalleryPickerEventBloc (this._photoGalleryRepository);


  Stream<AlbumState> _loadAlbumData({ List<Album> albums, Album selectedAlbum }) async* {
    try {
      yield AlbumLoadingState(albums: albums, selectedAlbum: selectedAlbum);
      yield AlbumLoadedState(albums: albums, selectedAlbum: selectedAlbum, selectedMedia: await selectedAlbum.listMedia());
    } catch (e) {
      yield AlbumFailedToLoadState(albums: albums, selectedAlbum: selectedAlbum);
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
        final currentAlbumState = ensureInCurrentState<AlbumState>();
        yield* _loadAlbumData(
            albums: currentAlbumState.albums,
            selectedAlbum: event.album
        );
      }
    } catch (e) {
      yield GalleryPickerErrorState();
    }

  }

}