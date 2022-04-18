import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/app/app_events.dart';
import 'package:ski_slope/base/stated_bloc.dart';

class AppBloc extends StatedBloc<AppState> {
  final EventBus _eventBus;
  late StreamSubscription _eventSubscription;

  @override
  AppState get defaultState => InitState();

  AppBloc(this._eventBus) {
    _eventSubscription = _eventBus.on<AppEvent>().listen(
      (event) {
        if (event is LogOutEvent) {
          setState(LogOutState());
        }
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    _eventSubscription.cancel();
    super.dispose();
  }
}

abstract class AppState {}

class InitState extends AppState {}

class LogOutState extends AppState {}
