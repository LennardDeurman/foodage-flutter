import 'package:flutter/material.dart';
import 'package:foodage/ui/architecture.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_events.dart';
import 'package:foodage/ui/camera/picker/logic/photo_picker_bloc.dart';
import 'package:foodage/ui/fdg_theme.dart';
import 'package:foodage/ui/widgets/dialogs/fdg_options.dart';
import 'package:foodage/ui/widgets/fdg_segmented_control.dart';
import 'package:foodage/ui/background_builder.dart';
import 'package:foodage/ui/camera/album_photos_grid.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_event_bloc.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_states.dart';
import 'package:provider/provider.dart';

List<FDGSegmentItem> getPhotoPickerSegments(BuildContext context) {
  return [
    _GalleryBody.segmentItem(context),
    //_InspirationBody.segmentItem(context), We hide the inspiration body for now, as this still needs to be implemented
  ];
}


class _InspirationBody extends StatelessWidget {

  final FDGSegmentItem _sender;

  _InspirationBody (this._sender);

  static FDGSegmentItem segmentItem(BuildContext context) {
    return FDGSegmentItem(
        "Inspiratie",
        iconBuilder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 6),
            child: Icon(Icons.lightbulb, color: Theme.of(context).textTheme.button.color),
          );
        },
        builder: (context, sender) {
          return _InspirationBody(sender);
        }
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

  _GalleryBody (this._sender);

  PhotoPickerManagingBloc _photoPickerManagingBloc(BuildContext context) =>
      Provider.of<PhotoPickerManagingBloc>(context, listen: false);

  GalleryPickerEventBloc _galleryPickerEventBloc(BuildContext context) =>
      _photoPickerManagingBloc(context).galleryPickerEventBloc;

  static FDGSegmentItem segmentItem(BuildContext context) {
    return FDGSegmentItem(
        "Gallerij",
        iconBuilder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 6),
            child: Icon(Icons.image, color: Theme.of(context).textTheme.button.color),
          );
        },
        builder: (context, sender) {
          return _GalleryBody(sender);
        }
    );
  }

  Widget _mapAlbumStateToWidget(BuildContext context, AlbumState state) {
    Widget contentWidget;
    if (state is AlbumLoadedState) {
      contentWidget = AlbumPhotosGrid(state.selectedMedia);
    } else if (state is AlbumFailedToLoadState) {
      contentWidget = _backgroundBuilder.failed(
        title: _backgroundBuilder.labels.title(context, "Oeps..."),
        subtitle: _backgroundBuilder.labels.subtitle(context, "Kon de fotos van dit album niet ophalen"),
      );
    } else if (state is AlbumLoadingState) {
      contentWidget = _backgroundBuilder.loading(
        title: _backgroundBuilder.labels.title(context, "Bezig met laden..."),
      );
    }

    final titleWidget = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          state.albumData.selectedAlbum.name,
          style: Theme.of(context).textTheme.headline2,
        ),
        SizedBox(width: 5,),
        Icon(Icons.keyboard_arrow_down, color: Theme.of(context).textTheme.headline2.color,)
      ],
    );



    return _PickerBody(
      titleWidget: GestureDetector(
        child: titleWidget,
        onTap: () {
          final photoPickerManagingBloc = _photoPickerManagingBloc(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Provider.value(
                  value: photoPickerManagingBloc,
                  builder: (context, widget) {
                    final galleryPickerEventBloc = _galleryPickerEventBloc(context);
                    return EventBlocBuilder<GalleryPickerEventBloc, GalleryPickerState>(
                      bloc: galleryPickerEventBloc,
                      builder: (context, state) {
                        final albumState = galleryPickerEventBloc.ensureInCurrentState<AlbumState>();
                        return FDGOptionsDialog(
                            options: albumState.albumData.albums,
                            value: albumState.albumData.selectedAlbum,
                            label: (album) => album.name,
                            updateValue: (album) => galleryPickerEventBloc.add(GalleryPickerAlbumChangeEvent(album))
                        );
                      },
                    );
                  },
                );
              }
          );
        },
      ),
      contentWidget: contentWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EventBlocBuilder<GalleryPickerEventBloc, GalleryPickerState>(
        bloc: _galleryPickerEventBloc(context), // provide the local bloc instance
        builder: (context, state) {
          if (state is GalleryDataLoadingState) {
            return _PickerBody.background(
                child: _backgroundBuilder.loading(
                    title: _backgroundBuilder.labels.title(context, "Bezig met laden")
                )
            );
          } else if (state is GalleryPickerErrorState) {
            return _backgroundBuilder.failed(
                title: _backgroundBuilder.labels.title(context, "Oeps.."),
                subtitle: _backgroundBuilder.labels.subtitle(context, "Fout bij het ophalen van gallerij photos")
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
        }
    );
  }

}

class _PickerBody extends StatelessWidget {

  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  final Widget titleWidget;
  final Widget contentWidget;

  static const double _minHeight = 250;

  _PickerBody ({ this.titleWidget, this.contentWidget });

  static Widget background({ @required Widget child }) {
    return Container(
      constraints: BoxConstraints(
          minHeight: _minHeight
      ),
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