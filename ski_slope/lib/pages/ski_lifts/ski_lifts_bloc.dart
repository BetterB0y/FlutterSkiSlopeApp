import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ski_lift_data.dart';
import 'package:ski_slope/pages/ski_lifts/usecase/load_ski_lifts.dart';

class SkiLiftsBloc extends StatedBloc<SkiLiftsState> {
  final LoadSkiLiftsUseCase _loadSkiLifts;

  SkiLiftsBloc(this._loadSkiLifts);

  @override
  SkiLiftsState get defaultState => LoadingState();

  void load() async {
    setState(LoadingState());
    var result = await _loadSkiLifts.execute();
    if (result is SuccessfulDataResult) {
      setState(ReadyState(result.data));
    } else {
      setState(ErrorState());
    }
  }
}

abstract class SkiLiftsState {
  List<SkiLiftData> skiLifts;

  SkiLiftsState(this.skiLifts);
}

class LoadingState extends SkiLiftsState {
  LoadingState() : super([]);
}

class ReadyState extends SkiLiftsState {
  ReadyState(List<SkiLiftData> skiLifts) : super(skiLifts);
}

class ErrorState extends SkiLiftsState {
  ErrorState() : super([]);
}
