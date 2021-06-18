import 'package:flutter_bloc/flutter_bloc.dart';

part 'resource_state.dart';

typedef ResourceFutureCallback<T> = Future<T> Function();

abstract class ResourceCubit<T> extends Cubit<ResourceState<T>> {
  ResourceCubit() : super(ResourceLoadingState<T>()) {
    loadData(
      getData: () => getInitialData(),
    );
  }

  Future<T> getInitialData();

  void loadData({
    required ResourceFutureCallback<T> getData,
  }) async {
    final previousData = state.data;
    try {
      emit(
        ResourceLoadingState(
          data: previousData,
        ),
      );
      final data = await getData();
      emit(
        ResourceSuccessState(data: data),
      );
    } on Exception catch (e) {
      emit(
        ResourceErrorState<T>(
          data: previousData,
          exception: e,
        ),
      );
    }
  }
}

abstract class ResourceListCubit<T> extends ResourceCubit<List<T>> {}