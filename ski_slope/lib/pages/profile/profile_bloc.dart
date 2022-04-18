import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/pages/profile/usecase/logout.dart';

class ProfileBloc extends StatedBloc<ProfileState> {
  final LogOutUseCase _logOutUseCase;

  ProfileBloc(
    this._logOutUseCase,
  );

  @override
  ProfileState get defaultState => InitState();

  void logOut() {
    _logOutUseCase.execute();
  }
}

abstract class ProfileState {}

class InitState extends ProfileState {}

class ReadyState extends ProfileState {}
