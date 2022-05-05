import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ski_lift_data.dart';
import 'package:ski_slope/data/repository/ski_lift_repository.dart';

abstract class LoadSkiLiftsUseCase {
  FutureDataResult<List<SkiLiftData>> execute();
}

class LoadSkiLiftsImpl extends LoadSkiLiftsUseCase {
  final SkiLiftRepository _repository;

  LoadSkiLiftsImpl(this._repository);

  @override
  FutureDataResult<List<SkiLiftData>> execute() => _repository.loadSkiLifts();
}
