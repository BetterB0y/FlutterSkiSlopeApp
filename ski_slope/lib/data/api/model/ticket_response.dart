import 'package:ski_slope/data/api/model/response.dart';

class TicketListResponse extends SuccessfulResponse {
  final List<TicketResponse> tickets;

  TicketListResponse(List<dynamic> json) : tickets = json.map((e) => TicketResponse.fromJson(e)).toList();
}

class TicketResponse {
  final int id;
  final String code;
  final String ownerName;
  final bool isActive;
  final int entryAmount;

  TicketResponse({
    required this.id,
    required this.code,
    required this.ownerName,
    required this.isActive,
    required this.entryAmount,
  });

  TicketResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        ownerName = json['ownerName'],
        isActive = json['active'],
        entryAmount = json['entryAmount'];
}
