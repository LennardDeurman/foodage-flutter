import 'package:fdg_camera/src/fdg_camera_locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_camera/src/album_photos_grid.dart';
import 'package:fdg_camera/src/picker/gallery_picker_cubit/gallery_picker_cubit.dart';

List<FDGSegmentItem> getPhotoPickerSegments(BuildContext context) {
  return [
    _GalleryBody.segmentItem(context),
    //_InspirationBody.segmentItem(context), We hide the inspiration body for now, as this still needs to be implemented
  ];
}

class _InspirationBody extends StatelessWidget {
  final FDGSegmentItem _sender;

  _InspirationBody(this._sender);

  static FDGSegmentItem segmentItem(BuildContext context) {
    return FDGSegmentItem(
      FDGCameraLocaleKeys.pickerTabInspiration.tr(),
      iconBuilder: (context) {
        return Container(
          margin: EdgeInsets.only(left: 6),
          child: Icon(
            Icons.lightbulb,
            color: Theme.of(context).textTheme.button!.color,
          ),
        );
      },
      builder: (context, sender) {
        return _InspirationBody(sender);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _PickerBody(
      titleWidget: Text(
        _sender.title,
        style: Theme.of(context).textTheme.headline2,
      ),
      contentWidget: Container(
        color: Colors.black,
      ),
    );
  }
}

class _GalleryBody extends StatelessWidget {
  final FDGSegmentItem _sender;

  final FDGBackgroundBuilder _backgroundBuilder = FDGBackgroundBuilder();

  _GalleryBody(this._sender);

  static FDGSegmentItem segmentItem(BuildContext context) {
    return FDGSegmentItem(FDGCameraLocaleKeys.pickerTabGallery.tr(), iconBuilder: (context) {
      return Container(
        margin: EdgeInsets.only(left: 6),
        child: Icon(
          Icons.image,
          color: Theme.of(context).textTheme.button!.color,
        ),
      );
    }, builder: (context, sender) {
      return _GalleryBody(sender);
    });
  }

  Future<void> _showAlbumPicker(BuildContext context) async {
    final galleryPickerCubit = context.read<GalleryPickerCubit>();
    final selectedAlbum = await showDialog<Album>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: galleryPickerCubit,
          child: BlocBuilder<GalleryPickerCubit, GalleryPickerState>(
            builder: (context, state) {
              final galleryPickerCubit = context.read<GalleryPickerCubit>();
              final albumState = galleryPickerCubit.ensureInCurrentState<AlbumState>();
              return FDGOptionsDialog<Album>(
                options: albumState.albumData.albums!,
                value: albumState.albumData.selectedAlbum!,
                label: (album) => album.name,
              );
            },
          ),
        );
      },
    );
    if (selectedAlbum != null) {
      galleryPickerCubit.changeAlbumAndLoadData(selectedAlbum);
    }
  }

  Widget _mapAlbumStateToWidget(BuildContext context, AlbumState state) {
    Widget? contentWidget;
    if (state is AlbumLoadedState) {
      contentWidget = AlbumPhotosGrid(state.media);
    } else if (state is AlbumFailedToLoadState) {
      contentWidget = _backgroundBuilder.failed(
        title: _backgroundBuilder.labels.title(
          context,
          FDGCameraLocaleKeys.errorBackgroundTitle.tr(),
        ),
        subtitle: _backgroundBuilder.labels.subtitle(
          context,
          FDGCameraLocaleKeys.errorBackgroundAlbumLoadMessage.tr(),
        ),
      );
    } else if (state is AlbumLoadingState) {
      contentWidget = _backgroundBuilder.loading(
        title: _backgroundBuilder.labels.title(
          context,
          FDGCameraLocaleKeys.loadingBackgroundMessage.tr(),
        ),
      );
    }

    final titleWidget = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          state.albumData.selectedAlbum!.name,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Theme.of(context).textTheme.headline2!.color,
        )
      ],
    );

    return _PickerBody(
      titleWidget: GestureDetector(
        child: titleWidget,
        onTap: () => _showAlbumPicker(context),
      ),
      contentWidget: contentWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryPickerCubit, GalleryPickerState>(builder: (context, state) {
      if (state is GalleryDataLoadingState) {
        return _PickerBody.background(
          child: _backgroundBuilder.loading(
            title: _backgroundBuilder.labels.title(
              context,
              FDGCameraLocaleKeys.loadingBackgroundMessage.tr(),
            ),
          ),
        );
      } else if (state is GalleryPickerErrorState) {
        return _backgroundBuilder.failed(
          title: _backgroundBuilder.labels.title(
            context,
            FDGCameraLocaleKeys.errorBackgroundTitle.tr(),
          ),
          subtitle: _backgroundBuilder.labels.subtitle(
            context,
            FDGCameraLocaleKeys.errorBackgroundGalleryLoadMessage.tr(),
          ),
        );
      } else if (state is GalleryPickerForbiddenState) {
        return _backgroundBuilder.failed(
          title: _backgroundBuilder.labels.title(context, FDGCameraLocaleKeys.errorBackgroundTitle.tr(),),
          subtitle: _backgroundBuilder.labels.subtitle(
            context,
            FDGCameraLocaleKeys.errorBackgroundPermissionsMessage.tr(),
          ),
        );
      } else if (state is AlbumState) {
        return _mapAlbumStateToWidget(
          context,
          state,
        );
      }
      return Container();
    });
  }
}

class _PickerBody extends StatelessWidget {
  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  final Widget? titleWidget;
  final Widget? contentWidget;

  static const double _minHeight = 250;

  _PickerBody({this.titleWidget, this.contentWidget});

  static Widget background({required Widget child}) {
    return Container(
      constraints: BoxConstraints(minHeight: _minHeight),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: titleWidget,
          decoration: BoxDecoration(
            border: Border(
              bottom: _borderSide,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: _minHeight,
          ),
          child: Container(
            height: _minHeight,
            child: contentWidget,
          ),
        ),
      ],
    );
  }
}
