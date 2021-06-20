part of 'resource_cubit.dart';

abstract class ResourceState<T> {

  final T? data;

  const ResourceState({ this.data,});

}

class ResourceIdleState<T> extends ResourceState<T> {
  const ResourceIdleState({ T? data,}) : super(data: data);
}

class ResourceErrorState<T> extends ResourceState<T> {

  final Exception? exception;

  const ResourceErrorState({ T? data, this.exception,}) : super(data: data);
}

class ResourceLoadingState<T> extends ResourceState<T> {
  const ResourceLoadingState({ T? data,}) : super(data: data);
}

class ResourceSuccessState<T> extends ResourceState<T> {
  const ResourceSuccessState({ T? data,}) : super(data: data);
}
