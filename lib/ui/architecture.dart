/* Couples UI and logic */
import 'package:bloc/bloc.dart';

/* We use EventBloc as a way to handle all basic events, and use managingbloc as upper class, for rx-dart related stuff */

abstract class EventBloc<EventClass, StateClass> extends Bloc<EventClass, StateClass> {

  EventBloc() : super(null); //This is not the most elegant way, but only way

  CurrentStateClass ensureInCurrentState<CurrentStateClass>() {
    assert(
      this.state is CurrentStateClass,
      "The state class was expected to be of class ${CurrentStateClass.toString()} but was of type ${this.state.runtimeType}",
    );
    final castedState = this.state as CurrentStateClass;
    return castedState;
  }

}

class ManagingBloc {

  void dispose() {}

}