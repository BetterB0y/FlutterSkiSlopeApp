import 'package:equatable/equatable.dart';

class VoucherData extends Equatable {
  final int id;
  final String code;
  final String ownerName;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? expireDate;

  const VoucherData({
    required this.id,
    required this.code,
    required this.ownerName,
    required this.isActive,
    required this.startDate,
    required this.expireDate,
  });

  @override
  List<Object?> get props => [id, code, ownerName, isActive, startDate, expireDate];
}
