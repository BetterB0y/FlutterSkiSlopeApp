import 'package:ski_slope/data/api/model/response.dart';

class SkiLiftListResponse extends SuccessfulResponse {
  final List<SkiLiftResponse> skiLifts;

  SkiLiftListResponse(List<dynamic> json) : skiLifts = json.map((e) => SkiLiftResponse.fromJson(e)).toList();
}

class SkiLiftResponse {
  final int id;
  final String name;
  final double maxHeight;
  final double skiRunLength;
  final String? description;
  final bool isActive;

  SkiLiftResponse({
    required this.id,
    required this.name,
    required this.maxHeight,
    required this.skiRunLength,
    required this.description,
    required this.isActive,
  });

  SkiLiftResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        maxHeight = json['maxHeight'],
        skiRunLength = json['skiRunLength'],
        description = json['description'],
        isActive = json['active'];
}
