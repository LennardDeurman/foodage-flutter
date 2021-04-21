import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/picker/photo_picker_bloc.dart';
import 'package:foodage/ui/fdg_theme.dart';
import 'package:foodage/ui/widgets/fdg_button.dart';
import 'package:foodage/ui/widgets/fdg_segmented_control.dart';
import 'package:provider/provider.dart';

class PhotoPickerBottomSheet extends StatelessWidget {
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
        builder: (BuildContext context) {
          return PhotoPickerBottomSheet();
        },
        context: context);
  }

  PhotoPickerBloc _photoPickerBloc(BuildContext context) => Provider.of<PhotoPickerBloc>(context, listen: false);

  List<FDGSegmentItem> _segments(BuildContext context) {
    return [
      FDGSegmentItem(
        "Gallerij",
        iconBuilder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(left: 6),
            child: Icon(Icons.image, color: Theme.of(context).textTheme.button.color),
          );
        },
      ),
      FDGSegmentItem(
        "Inspiratie",
        iconBuilder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.only(left: 6),
            child: Icon(Icons.lightbulb, color: Theme.of(context).textTheme.button.color),
          );
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);
    final currentThemeData = Theme.of(context);
    final segments = _segments(context);
    return Provider(
      create: (_) => PhotoPickerBloc(initialSelectedSegment: segments[0]),
      builder: (context, widget) {
        final photoPickerBloc = _photoPickerBloc(context);
        return Container(
          child: StreamBuilder<FDGSegmentItem>(
            stream: photoPickerBloc.selectedSegment,
            builder: (context, snapshot) {
              final selectedSegment = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      selectedSegment.title,
                      style: currentThemeData.textTheme.headline2,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: borderSide,
                    )),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 250,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border(
                      top: borderSide,
                    )),
                    child: Center(
                      child: FDGSegmentedControl<FDGSegmentItem>(
                        value: snapshot.data,
                        segments: segments,
                        segmentWidgetBuilder: (BuildContext context, FDGSegmentItem segmentItem) {
                          return Container(
                            child: FDGPrimaryButton(
                              segmentItem.title,
                              onTap: (BuildContext context) => photoPickerBloc.selectedSegmentUpdater.add(segmentItem),
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
