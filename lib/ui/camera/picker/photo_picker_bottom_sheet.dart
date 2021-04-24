import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_event_bloc.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_events.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_states.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'logic/photo_picker_bloc.dart';
import '../../../data/service_locator.dart';
import '../../fdg_theme.dart';
import '../../widgets/fdg_button.dart';
import '../../widgets/fdg_segmented_control.dart';

class PhotoPickerBottomSheet extends StatelessWidget {

  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
        builder: (BuildContext context) {
          return PhotoPickerBottomSheet();
        },
        context: context);
  }

  PhotoPickerManagingBloc _photoPickerManagingBloc(BuildContext context) => Provider.of<PhotoPickerManagingBloc>(context, listen: false);

  List<FDGSegmentItem> _segments(BuildContext context) {
    return [
      _GalleryBody.segmentItem(context),
      _InspirationBody.segmentItem(context)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final segments = _segments(context);
    return Provider(
      create: (_) {
        final bloc = PhotoPickerManagingBloc(
          GalleryPickerEventBloc(sl.get()),
          initialSelectedSegment: segments[0]
        );
        bloc.galleryPickerEventBloc.add(GalleryPickerInitEvent());
        return bloc;
      },
      builder: (context, widget) {
        final photoPickerManagingBloc = _photoPickerManagingBloc(context);
        return Container(
          child: StreamBuilder<FDGSegmentItem>(
            stream: photoPickerManagingBloc.selectedSegment,
            builder: (context, snapshot) {
              final selectedSegment = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (selectedSegment != null) selectedSegment.builder(context, selectedSegment),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: _borderSide,
                      ),
                    ),
                    child: Center(
                      child: FDGSegmentedControl<FDGSegmentItem>(
                        value: snapshot.data,
                        segments: segments,
                        segmentWidgetBuilder: (BuildContext context, FDGSegmentItem segmentItem) {
                          return Container(
                            child: FDGPrimaryButton(
                              segmentItem.title,
                              onTap: (BuildContext context) => photoPickerManagingBloc.selectedSegmentUpdater.add(segmentItem),
                              borderRadius: 12,
                              padding: EdgeInsets.all(6),
                              textPadding: EdgeInsets.symmetric(horizontal: 10),
                              icon: segmentItem?.iconBuilder(context),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
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

  Widget _mapStateToContentWidget(BuildContext context, GalleryPickerState state) {
    if (state is AlbumLoadedState) {
      return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          ...?state.selectedMedia.items.map(
                (medium) => Container(
              color: Colors.grey[300],
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image: ThumbnailProvider(
                  mediumId: medium.id,
                  mediumType: medium.mediumType,
                  highQuality: true,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _mapStateToTitleWidget(BuildContext context, GalleryPickerState state) {

    /*if (state is AlbumState) {
      final albumState = state;
      return DropdownButton<Album>(
        value: albumState.selectedAlbum,
        onChanged: (album) => _galleryPickerEventBloc(context).add(GalleryPickerAlbumChangeEvent(album)),
        items: albumState.albums.map((album) {
          return DropdownMenuItem<Album>(
            value: album,
            child: Text(
              album.name
            ),
          );
        }).toList(),
      );

    } */

    return Text(
      _sender.title,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GalleryPickerState>(
      stream: _galleryPickerEventBloc(context).stream,
      builder: (context, snapshot) {
        return _PickerBody(
          titleWidget: _mapStateToTitleWidget(context, snapshot.data),
          contentWidget: _mapStateToContentWidget(context, snapshot.data),
        );
      },
    );
  }

}

class _PickerBody extends StatelessWidget {

  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  final Widget titleWidget;
  final Widget contentWidget;

  _PickerBody ({ this.titleWidget, this.contentWidget });

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
            minHeight: 250,
          ),
          child: contentWidget,
        ),
      ],
    );
  }

}