import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:foodage/ui/bloc.dart';
import 'package:foodage/ui/widgets/fdg_segmented_control.dart';

class PhotoPickerBloc extends Bloc {

  BehaviorSubject<FDGSegmentItem> _selectedSegment;
  ValueStream<FDGSegmentItem> get selectedSegment => _selectedSegment.stream;
  Sink<FDGSegmentItem> get selectedSegmentUpdater => _selectedSegment.sink;

  PhotoPickerBloc ({ @required FDGSegmentItem initialSelectedSegment }) {
    _selectedSegment = BehaviorSubject.seeded(initialSelectedSegment);
  }

  @override
  void dispose() {
    _selectedSegment.close();
    super.dispose();
  }

}