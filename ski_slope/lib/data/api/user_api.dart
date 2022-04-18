import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/data/api/mixin_api.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/user_response.dart';
import 'package:ski_slope/settings/settings.dart';

class UserApi with Api {
  UserApi(Settings settings, EventBus eventBus) {
    init(settings, eventBus);
  }

  Future<Response> getUserInfo() => get(
        url: "${Api.baseUrl}user/info",
        mapper: (response) => UserResponse.fromJson(jsonDecode(response)),
        shouldAuthorize: true,
        shouldRefresh: true,
      );
}
