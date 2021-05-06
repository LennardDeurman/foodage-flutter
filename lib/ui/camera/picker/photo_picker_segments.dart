import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';

import '../../background_builder.dart';
import '../../ui_extensions.dart';
import '../../fdg_theme.dart';
import '../../widgets/dialogs/fdg_options.dart';
import '../../widgets/fdg_segmented_control.dart';
import '../album_photos_grid.dart';
import 'gallery_picker_cubit/gallery_picker_cubit.dart';
import 'gallery_picker_cubit/gallery_picker_states.dart';

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
      "Inspiratie",
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

  final BackgroundBuilder _backgroundBuilder = BackgroundBuilder();

  _GalleryBody(this._sender);

  static FDGSegmentItem segmentItem(BuildContext context) {
    return FDGSegmentItem("Gallerij", iconBuilder: (context) {
      return Container(
        margin: EdgeInsets.only(left: 6),
        child: Icon(Icons.image, color: Theme.of(context).textTheme.button!.color),
      );
    }, builder: (context, sender) {
      return _GalleryBody(sender);
    });
  }

  Future<void> _showAlbumPicker(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<GalleryPickerCubit, GalleryPickerState>(
          builder: (context, state) {
            final galleryPickerCubit = context.read<GalleryPickerCubit>();
            final albumState = galleryPickerCubit.ensureInCurrentState<AlbumState>();
            return FDGOptionsDialog<Album>(
              options: albumState.albumData.albums!,
              value: albumState.albumData.selectedAlbum!,
              label: (album) => album.name,
              updateValue: (album) => galleryPickerCubit.changeAlbumAndLoadData(album),
            );
          },
        );
      },
    );
  }

  Widget _mapAlbumStateToWidget(BuildContext context, AlbumState state) {
    Widget? contentWidget;
    if (state is AlbumLoadedState) {
      contentWidget = AlbumPhotosGrid(state.selectedMedia);
    } else if (state is AlbumFailedToLoadState) {
      contentWidget = _backgroundBuilder.failed(
        title: _backgroundBuilder.labels.title(
          context,
          "Oeps...",
        ),
        subtitle: _backgroundBuilder.labels.subtitle(
          context,
          "Kon de fotos van dit album niet ophalen",
        ),
      );
    } else if (state is AlbumLoadingState) {
      contentWidget = _backgroundBuilder.loading(
        title: _backgroundBuilder.labels.title(
          context,
          "Bezig met laden...",
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
              "Bezig met laden",
            ),
          ),
        );
      } else if (state is GalleryPickerErrorState) {
        return _backgroundBuilder.failed(
          title: _backgroundBuilder.labels.title(
            context,
            "Oeps..",
          ),
          subtitle: _backgroundBuilder.labels.subtitle(
            context,
            "Fout bij het ophalen van gallerij photos",
          ),
        );
      } else if (state is GalleryPickerForbiddenState) {
        return _backgroundBuilder.failed(
          title: _backgroundBuilder.labels.title(context, "Oeps.."),
          subtitle: _backgroundBuilder.labels.subtitle(
            context,
            "De app heeft niet de juiste machtigingen. Sta het gebruik van je foto gallerij toe in het instellingenscherm van je telefoon.",
          ),
        );
      } else if (state is AlbumState) {
        return _mapAlbumStateToWidget(context, state);
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
