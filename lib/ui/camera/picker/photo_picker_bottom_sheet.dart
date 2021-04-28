import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/photo_picker_bloc.dart';
import '../../fdg_theme.dart';
import '../../widgets/fdg_button.dart';
import '../../widgets/fdg_segmented_control.dart';

class PhotoPickerBottomSheet extends StatelessWidget {

  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  static const _minHeight = 250.0;

  static void show(BuildContext context) {
    final bloc = Provider.of<PhotoPickerManagingBloc>(context, listen: false);
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Provider.value(value: bloc, child:
      PhotoPickerBottomSheet(),);
    }, isScrollControlled: true);
  }

  PhotoPickerManagingBloc _photoPickerManagingBloc(BuildContext context) => Provider.of<PhotoPickerManagingBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
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
              Container(
                child: selectedSegment?.builder(context, selectedSegment),
                constraints: BoxConstraints(
                    minHeight: _minHeight
                ),
              ),
              StreamBuilder<List<FDGSegmentItem>>(
                  stream: photoPickerManagingBloc.segments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 1) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            top: _borderSide,
                          ),
                        ),
                        child: FDGSegmentedControl<FDGSegmentItem>(
                          value: selectedSegment,
                          segments: snapshot.data,
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
                      );
                    }
                    return Container();
                  }
              ),
            ],
          );
        },
      ),
    );
  }
}

