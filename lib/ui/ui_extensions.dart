import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef WidgetTapCallback = void Function(BuildContext context);

class InvalidStateFailure implements Exception {}

extension CubitExtension on Cubit {

  T ensureInCurrentState<T>() {
    assert(
    this.state is T,
    "The state class was expected to be of class ${T.toString()} but was of type ${this.state.runtimeType}",
    );
    final castedState = this.state as T;
    return castedState;
  }

}