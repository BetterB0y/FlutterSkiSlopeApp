import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/data/api/mixin_api.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/ticket_response.dart';
import 'package:ski_slope/settings/settings.dart';

class TicketApi with Api {
  TicketApi(Settings settings, EventBus eventBus) {
    init(settings, eventBus);
  }

  Future<Response> getTicketById(int id) => get(
        url: "${Api.baseUrl}card/ticket/myTickets/skiLiftId/$id",
        mapper: (response) => TicketListResponse(jsonDecode(response)),
        shouldAuthorize: true,
        shouldRefresh: true,
      );
}
