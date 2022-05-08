import 'package:ski_slope/data/api/model/ski_lift_response.dart';
import 'package:ski_slope/data/api/ski_lift_api.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ski_lift_data.dart';
import 'package:ski_slope/utilities/extensions.dart';

class SkiLiftRepository {
  final SkiLiftApi _skiLiftApi;

  SkiLiftRepository(this._skiLiftApi);

  FutureDataResult<List<SkiLiftData>> loadSkiLifts() async {
    final response = await _skiLiftApi.getSkiLifts();
    if (response is SkiLiftListResponse) {
      final skiLiftData = response.skiLifts.mapToList((element) => element.toSkiLiftData());
      return SuccessfulDataResult.online(skiLiftData);
    } else {
      return UnsuccessfulDataResult(const []);
    }
  }
}

extension SkiLiftConverter on SkiLiftResponse {
  SkiLiftData toSkiLiftData() => SkiLiftData(
        id: id,
        name: name,
        maxHeight: maxHeight,
        skiRunLength: skiRunLength,
        description: description,
        isActive: isActive,
      );
}
