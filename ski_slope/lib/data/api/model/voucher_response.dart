import 'package:ski_slope/data/api/model/response.dart';

class VoucherListResponse extends SuccessfulResponse {
  final List<VoucherResponse> vouchers;

  VoucherListResponse(List<dynamic> json) : vouchers = json.map((e) => VoucherResponse.fromJson(e)).toList();
}

class VoucherResponse {
  final int id;
  final String code;
  final String ownerName;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? expireDate;

  VoucherResponse({
    required this.id,
    required this.code,
    required this.ownerName,
    required this.isActive,
    required this.startDate,
    required this.expireDate,
  });

  VoucherResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        ownerName = json['ownerName'],
        isActive = json['active'],
        startDate = json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
        expireDate = json['expireDate'] != null ? DateTime.parse(json['expireDate']) : null;
}
