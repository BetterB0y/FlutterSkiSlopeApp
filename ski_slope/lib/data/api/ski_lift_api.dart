import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/data/api/mixin_api.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/ski_lift_response.dart';
import 'package:ski_slope/settings/settings.dart';

class SkiLiftApi with Api {
  SkiLiftApi(Settings settings, EventBus eventBus) {
    init(settings, eventBus);
  }

  Future<Response> getSkiLifts() => get(
        url: "${Api.baseUrl}skiLift",
        mapper: (response) => SkiLiftListResponse(jsonDecode(response)),
        shouldAuthorize: false,
        shouldRefresh: false,
      );
}
