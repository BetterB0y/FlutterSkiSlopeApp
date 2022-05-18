import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ski_lift_data.dart';
import 'package:ski_slope/pages/ski_lifts/usecase/load_ski_lifts.dart';

class SkiLiftsBloc extends StatedBloc<SkiLiftsState> {
  final LoadSkiLiftsUseCase _loadSkiLifts;
  List<SkiLiftData> _skiLifts = [];

  SkiLiftsBloc(this._loadSkiLifts);

  @override
  SkiLiftsState get defaultState => LoadingState([]);

  void load() async {
    setState(LoadingState(_skiLifts));
    var result = await _loadSkiLifts.execute();
    if (result is SuccessfulDataResult) {
      _skiLifts = result.data;
      setState(ReadyState(_skiLifts));
    } else if (result is NoInternetConnectionDataResult) {
      setState(NoInternetState(_skiLifts));
    } else {
      setState(ErrorState(_skiLifts));
    }
  }
}

abstract class SkiLiftsState {
  List<SkiLiftData> skiLifts;

  SkiLiftsState(this.skiLifts);
}

class LoadingState extends SkiLiftsState {
  LoadingState(List<SkiLiftData> skiLifts) : super(skiLifts);
}

class ReadyState extends SkiLiftsState {
  ReadyState(List<SkiLiftData> skiLifts) : super(skiLifts);
}

class ErrorState extends SkiLiftsState {
  ErrorState(List<SkiLiftData> skiLifts) : super(skiLifts);
}

class NoInternetState extends SkiLiftsState {
  NoInternetState(List<SkiLiftData> skiLifts) : super(skiLifts);
}
