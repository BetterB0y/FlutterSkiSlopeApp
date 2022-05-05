import 'package:equatable/equatable.dart';

class SkiLiftData extends Equatable {
  final int id;
  final String name;
  final double maxHeight;
  final double skiRunLength;
  final String? description;
  final bool isActive;

  const SkiLiftData({
    required this.id,
    required this.name,
    required this.maxHeight,
    required this.skiRunLength,
    required this.description,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, maxHeight, skiRunLength, description, isActive];
}
