import 'package:flutter/foundation.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_event_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../architecture.dart';
import '../../../widgets/fdg_segmented_control.dart';

class PhotoPickerManagingBloc extends ManagingBloc {

  BehaviorSubject<FDGSegmentItem> _selectedSegment;
  ValueStream<FDGSegmentItem> get selectedSegment => _selectedSegment.stream;
  Sink<FDGSegmentItem> get selectedSegmentUpdater => _selectedSegment.sink;

  final GalleryPickerEventBloc galleryPickerEventBloc;

  PhotoPickerManagingBloc (this.galleryPickerEventBloc, { @required FDGSegmentItem initialSelectedSegment }) {
    _selectedSegment = BehaviorSubject.seeded(initialSelectedSegment);
  }

  @override
  void dispose() {
    _selectedSegment.close();
    super.dispose();
  }

}