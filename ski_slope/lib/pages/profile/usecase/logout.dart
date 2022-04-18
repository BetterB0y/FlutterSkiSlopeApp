import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/app/app_events.dart';
import 'package:ski_slope/data/model/auth_data.dart';
import 'package:ski_slope/settings/settings.dart';

abstract class LogOutUseCase {
  void execute();
}

class LogOutImpl extends LogOutUseCase {
  final EventBus _eventBus;
  final Settings _settings;

  LogOutImpl(this._eventBus, this._settings);

  @override
  void execute() async {
    _settings.authResponseData = AuthData.empty();
    _eventBus.fire(LogOutEvent());
  }
}
