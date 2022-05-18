import 'package:equatable/equatable.dart';

class TicketData extends Equatable {
  final int id;
  final String code;
  final String ownerName;
  final bool isActive;
  final int entryAmount;

  const TicketData({
    required this.id,
    required this.code,
    required this.ownerName,
    required this.isActive,
    required this.entryAmount,
  });

  @override
  List<Object?> get props => [id, code, ownerName, isActive, entryAmount];
}
