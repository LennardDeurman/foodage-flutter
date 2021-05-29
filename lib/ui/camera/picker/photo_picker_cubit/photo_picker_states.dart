import '../../../widgets/fdg_segmented_control.dart';

class PhotoPickerState {
  final FDGSegmentItem selectedSegment;

  const PhotoPickerState({
    required this.selectedSegment,
  });

  PhotoPickerState copyWith({FDGSegmentItem? selectedSegment}) {
    return PhotoPickerState(
      selectedSegment: selectedSegment ?? this.selectedSegment,
    );
  }
}
