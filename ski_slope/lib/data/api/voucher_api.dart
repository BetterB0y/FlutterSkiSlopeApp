import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/data/api/mixin_api.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/voucher_response.dart';
import 'package:ski_slope/settings/settings.dart';

class VoucherApi with Api {
  VoucherApi(Settings settings, EventBus eventBus) {
    init(settings, eventBus);
  }

  Future<Response> getVouchers() => get(
        url: "${Api.baseUrl}card/voucher/myVouchers",
        mapper: (response) => VoucherListResponse(jsonDecode(response)),
        shouldAuthorize: true,
        shouldRefresh: true,
      );
}
