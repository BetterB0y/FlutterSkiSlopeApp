import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:ski_slope/app/app_events.dart';
import 'package:ski_slope/data/api/auth_api.dart';
import 'package:ski_slope/data/api/model/auth_response.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/model/auth_data.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/settings/settings.dart';

abstract class RefreshTokenUseCase {
  FutureResult execute();
}

class RefreshTokenImpl extends RefreshTokenUseCase {
  final Settings _settings;
  final AuthApi _authApi;
  final EventBus _eventBus;

  RefreshTokenImpl(this._settings, this._authApi, this._eventBus);

  @override
  FutureResult execute() async {
    try {
      debugPrint(
          "RefreshTokenImpl:execute - rt: ${DateTime.fromMillisecondsSinceEpoch(_settings.refreshExpiryDate ?? 0)}, ${_settings.isRefreshTokenExpired}");
      debugPrint(
          "RefreshTokenImpl:execute - at: ${DateTime.fromMillisecondsSinceEpoch(_settings.tokenExpiryDate ?? 0)}, ${_settings.isTokenExpired}");
      if (_settings.refreshToken == null) {
        return UnsuccessfulResult();
      } else {
        final authResponse = await _authApi.refresh(_settings.refreshToken!);
        if (authResponse is AuthResponse && authResponse.accessToken == null) {
          throw Exception("Authorization failure");
        } else if (authResponse is AuthResponse) {
          _settings.authResponseData = AuthData.fromResponse(authResponse);
          return SuccessfulResult.online();
        } else if (authResponse is NoInternetResponse && !_settings.isRefreshTokenExpired) {
          return SuccessfulResult.offline();
        } else if (authResponse is StatusCodeNotHandledResponse && authResponse.statusCode == 403) {
          _eventBus.fire(LogOutEvent());
          return UnsuccessfulResult();
        }
        return UnsuccessfulResult();
      }
    } catch (ex) {
      if (_settings.isRefreshTokenExpired) {
        _settings.authResponseData = AuthData.empty();
        _eventBus.fire(LogOutEvent());
        return UnsuccessfulResult();
      }
      return SuccessfulResult.offline();
    }
  }
}
