import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/data/api/mixin_api.dart';
import 'package:ski_slope/data/api/model/auth_response.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/settings/settings.dart';

class AuthApi with Api {
  static const username = "username";
  static const _password = "password";
  static const _authorization = "Authorization";
  static const _bearer = "Bearer ";

  AuthApi(Settings settings, EventBus eventBus) {
    init(settings, eventBus);
  }

  Future<Response> login(String userName, String password) {
    return post(
      url: "${Api.baseUrl}login",
      body: {
        username: userName,
        _password: password,
      },
      shouldRefresh: false,
      shouldAuthorize: false,
      mapper: (response) => AuthResponse.fromJson(jsonDecode(response)),
    );
  }

  Future<Response> refresh(String refreshToken) {
    return get(
      url: "${Api.baseUrl}auth/refreshToken",
      headers: {
        _authorization: _bearer + refreshToken,
      },
      shouldRefresh: false,
      shouldAuthorize: false,
      mapper: (response) => AuthResponse.fromJson(jsonDecode(response)),
    );
  }
}
