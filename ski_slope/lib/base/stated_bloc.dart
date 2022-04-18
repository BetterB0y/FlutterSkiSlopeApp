import 'package:bloc_pattern/bloc_pattern.dart';

abstract class StatedBloc<State> extends BlocBase {
  State? _state;

  State get state => _state ?? defaultState;

  State get defaultState;

  void setState(State state, {bool notify = true}) {
    _state = state;
    if (notify) {
      notifyListeners();
    }
  }
}
