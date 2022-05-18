import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/ticket_response.dart';
import 'package:ski_slope/data/api/ticket_api.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ticket_data.dart';
import 'package:ski_slope/utilities/extensions.dart';

class TicketRepository {
  final TicketApi _ticketApi;

  TicketRepository(this._ticketApi);

  FutureDataResult<List<TicketData>> loadTicketsById(int id) async {
    final response = await _ticketApi.getTicketById(id);
    if (response is TicketListResponse) {
      final ticketData = response.tickets.mapToList((element) => element.toData());
      return SuccessfulDataResult.online(ticketData);
    } else if (response is NoInternetResponse) {
      return NoInternetConnectionDataResult(const []);
    } else {
      return UnsuccessfulDataResult(const []);
    }
  }
}

extension TicketConverter on TicketResponse {
  TicketData toData() => TicketData(
        id: id,
        code: code,
        ownerName: ownerName,
        isActive: isActive,
        entryAmount: entryAmount,
      );
}
