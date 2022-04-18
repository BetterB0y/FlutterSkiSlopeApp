import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ski_slope/data/api/usecase/refresh.dart';
import 'package:ski_slope/settings/settings.dart';

class TokenRefresher {
  static TokenRefresher? _instance;

  static TokenRefresher get instance {
    _instance ??= TokenRefresher._();
    return _instance!;
  }

  final RefreshTokenUseCase _refreshToken = BlocProvider.getDependency();
  final Settings _settings = BlocProvider.getDependency();
  StreamController<bool>? _busyController;

  TokenRefresher._();

  String? get accessToken => _settings.accessToken;

  Future<String?> refreshToken() async {
    if (_isTokenValidForLessThanMinute()) {
      if (_busyController == null) {
        _emitBusy(true);
        await _refreshToken.execute();
        _emitBusy(false);
      } else {
        await _busyController?.stream.where((event) => !event).first;
      }
    }
    return accessToken;
  }

  void _emitBusy(bool isBusy) {
    if (isBusy) {
      _busyController = StreamController.broadcast();
    }
    _busyController?.sink.add(isBusy);
    if (!isBusy) {
      _busyController?.close();
      _busyController = null;
    }
  }

  bool _isTokenValidForLessThanMinute() {
    return _settings.tokenExpiryDate != null
        ? DateTime.fromMillisecondsSinceEpoch(_settings.tokenExpiryDate!).difference(DateTime.now()).inMinutes <= 1
        : true;
  }
}
