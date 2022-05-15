import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/pages/profile/usecase/logout.dart';
import 'package:ski_slope/pages/profile/usecase/user_data.dart';

class ProfileBloc extends StatedBloc<ProfileState> {
  final LogOutUseCase _logOutUseCase;
  final UserDataUseCase _userDataUseCase;

  ProfileBloc(this._logOutUseCase, this._userDataUseCase);

  @override
  ProfileState get defaultState => InitState();

  void getUserData() {
    _userDataUseCase.execute();
  }

  void logOut() {
    _logOutUseCase.execute();
  }
}

abstract class ProfileState {}

class InitState extends ProfileState {}

class ReadyState extends ProfileState {}
