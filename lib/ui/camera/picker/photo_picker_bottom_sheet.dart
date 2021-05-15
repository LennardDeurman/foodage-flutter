import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodage/ui/camera/main_camera_cubit/main_camera_cubit.dart';

import '../../fdg_theme.dart';
import '../../widgets/fdg_button.dart';
import '../../widgets/fdg_segmented_control.dart';
import 'gallery_picker_cubit/gallery_picker_cubit.dart';
import 'photo_picker_cubit/photo_picker_cubit.dart';
import 'photo_picker_cubit/photo_picker_states.dart';

class PhotoPickerBottomSheet extends StatelessWidget {
  final _borderSide = BorderSide(color: FDGTheme().colors.lightGrey2, width: 1);

  static const _minHeight = 250.0;

  static void show(BuildContext context) {
    final photoPickerCubit = BlocProvider.of<PhotoPickerCubit>(context);
    final galleryPickerCubit = BlocProvider.of<GalleryPickerCubit>(context);
    final mainCameraCubit = BlocProvider.of<MainCameraCubit>(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: photoPickerCubit),
                BlocProvider.value(value: galleryPickerCubit),
                BlocProvider.value(value: mainCameraCubit)
              ],
              child: PhotoPickerBottomSheet()
          );
        },
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<PhotoPickerCubit, PhotoPickerState>(builder: (context, state) {
        final photoPickerCubit = context.read<PhotoPickerCubit>();
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: state.selectedSegment.builder(context, state.selectedSegment),
                constraints: BoxConstraints(
                  minHeight: _minHeight,
                ),
              ),
              Visibility(
                visible: photoPickerCubit.segments.length > 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      top: _borderSide,
                    ),
                  ),
                  child: FDGSegmentedControl<FDGSegmentItem>(
                    value: state.selectedSegment,
                    segments: photoPickerCubit.segments,
                    segmentWidgetBuilder: (BuildContext context, FDGSegmentItem segmentItem) {
                      return Container(
                        child: FDGPrimaryButton(
                          segmentItem.title,
                          onTap: (BuildContext context) => photoPickerCubit.changeSegment(segmentItem),
                          borderRadius: 12,
                          padding: EdgeInsets.all(6),
                          textPadding: EdgeInsets.symmetric(horizontal: 10),
                          icon: segmentItem.iconBuilder(context),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
