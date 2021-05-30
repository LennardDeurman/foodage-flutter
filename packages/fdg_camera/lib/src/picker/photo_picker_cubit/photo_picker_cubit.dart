import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fdg_ui/fdg_ui.dart';

part 'photo_picker_states.dart';

class PhotoPickerCubit extends Cubit<PhotoPickerState> {
  late final List<FDGSegmentItem> segments;

  PhotoPickerCubit({
    required List<FDGSegmentItem> segments,
  }) : super(
          PhotoPickerState(
            selectedSegment: segments[0],
          ),
        ) {
    this.segments = segments;
  }

  void changeSegment(FDGSegmentItem segment) => emit(
        state.copyWith(
          selectedSegment: segment,
        ),
      );
}
