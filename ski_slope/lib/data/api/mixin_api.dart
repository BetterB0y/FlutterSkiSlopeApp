import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ski_slope/app/app_events.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/settings/settings.dart';
import 'package:ski_slope/utilities/token_refresher.dart';

// ignore_for_file: prefer_function_declarations_over_variables

mixin Api {
  static String get baseUrl => "https://projekt-pp-tab-2022.herokuapp.com/api/";

  static const _authorizationHeader = "Authorization";
  static const _bearer = "Bearer ";
  static const contentType = "Content-Type";
  static const contentJson = "application/json";

  late Settings _settings;
  EventBus? _eventBus;
  static bool isDebug = kDebugMode;

  String get bearerToken => _settings.accessToken ?? "";

  @protected
  void init(Settings settings, EventBus? eventBus) {
    _settings = settings;
    _eventBus = eventBus;
  }

  @protected
  Future<Response> get({
    required String url,
    required ResponseMapper mapper,
    bool shouldAuthorize = true,
    Map<String, String>? headers,
    bool shouldRefresh = true,
  }) {
    final getRequest = () {
      headers = _obtainHeaders(shouldAuthorize, headers);
      return http.get(Uri.parse(url), headers: headers);
    };
    final request = _obtainRequest(shouldRefresh, getRequest);
    return _performRequest(request, mapper, url);
  }

  @protected
  Future<Response> post({
    required String url,
    required ResponseMapper mapper,
    bool shouldAuthorize = true,
    Map<String, String>? headers,
    body,
    bool shouldRefresh = true,
  }) {
    final postRequest = () {
      headers = _obtainHeaders(shouldAuthorize, headers);
      return http.post(Uri.parse(url), headers: headers, body: body);
    };
    final request = _obtainRequest(shouldRefresh, postRequest);
    return _performRequest(request, mapper, url);
  }

  Future<Response> _performRequest(Future<http.Response> request, ResponseMapper mapper, String url) {
    return request.then(
      (response) {
        final result = _handleStatusCodeFromResponse(response);
        final data = utf8.decode(response.bodyBytes);
        _printRequest(response, data);
        return result ?? mapper(data);
      },
      onError: (e, st) => _handleErrors(e, st, url),
    );
  }

  Future<http.Response> _obtainRequest(
    bool shouldRefresh,
    RequestBuilder request,
  ) {
    return shouldRefresh ? _refresh().then((_) => request()) : request();
  }

  Map<String, String> _obtainHeaders(bool shouldAuthorize, Map<String, String>? headers) {
    final header = headers ?? <String, String>{};
    if (shouldAuthorize) {
      header[_authorizationHeader] = _bearer + bearerToken;
    }
    return header;
  }

  Future _refresh() {
    if (_settings.isTokenExpired) {
      return TokenRefresher.instance.refreshToken();
    }
    return Future.value();
  }

  ErrorResponse? _handleStatusCode(int statusCode, [String url = ""]) {
    if (statusCode == 401) {
      _eventBus!.fire(LogOutEvent());
      return UnauthorizedResponse();
    } else if (statusCode == 409) {
      return UserExistsResponse();
    } else if (statusCode >= 200 && statusCode < 300) {
      return null;
    }
    return StatusCodeNotHandledResponse(url, statusCode);
  }

  ErrorResponse? _handleStatusCodeFromResponse(http.Response response) {
    return _handleStatusCode(
      response.statusCode,
      response.request?.url.path ?? "",
    );
  }

  _printRequest(response, data) {
    if (isDebug) {
      debugPrint("Request ${response.request.method} ${response.request.url}");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: $data");
    }
  }

  ErrorResponse _handleErrors(e, StackTrace st, String url) {
    if (e is SocketException || e is TimeoutException) {
      return NoInternetResponse();
    } else {
      return GeneralErrorResponse(e);
    }
  }
}

typedef ResponseMapper = SuccessfulResponse Function(String);

typedef RequestBuilder = Future<http.Response> Function();
