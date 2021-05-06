import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../photo_picker_cubit/photo_picker_states.dart';
import '../../../widgets/fdg_segmented_control.dart';

class PhotoPickerCubit extends Cubit<PhotoPickerState> {
  List<FDGSegmentItem> segments;

  PhotoPickerCubit({@required List<FDGSegmentItem> segments}) : super(PhotoPickerState(selectedSegment: segments[0])) {
    this.segments = segments;
  }

  void changeSegment(FDGSegmentItem segment) => emit(state.copyWith(selectedSegment: segment));

}
