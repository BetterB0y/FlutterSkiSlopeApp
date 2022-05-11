import 'package:equatable/equatable.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/repository/user_repository.dart';
import 'package:ski_slope/settings/settings.dart';

abstract class LoginUseCase {
  Future<LoginResult> login(String username, String password);

  Future<LoginResult> loginWithGoogle(String url);
}

class LoginImpl extends LoginUseCase {
  final Settings _settings;
  final UserRepository _userRepository;

  LoginImpl(
    this._settings,
    this._userRepository,
  );

  @override
  Future<LoginResult> login(String username, String password) async {
    final authResult = await _userRepository.login(username, password);

    if (authResult is SuccessfulResult) {
      _settings.userData = null;
      await _userRepository.getUserData();
      return LoginSuccess();
    } else if (authResult is NoInternetConnectionResult) {
      return LoginFailedByInternet();
    } else if (authResult is WrongUserDataResult) {
      return IncorrectLoginData();
    }
    return LoginFailed();
  }

  @override
  Future<LoginResult> loginWithGoogle(String url) async {
    final authResult = await _userRepository.loginWithGoogle(url);
    if (authResult is SuccessfulResult) {
      await _userRepository.getUserData();
      return LoginSuccess();
    } else {
      return LoginFailed();
    }
  }
}

abstract class LoginResult extends Equatable {}

class LoginSuccess extends LoginResult {
  @override
  List<Object?> get props => [];
}

class LoginFailed extends LoginResult {
  @override
  List<Object?> get props => [];
}

class LoginFailedByInternet extends LoginResult {
  @override
  List<Object?> get props => [];
}

class IncorrectLoginData extends LoginResult {
  @override
  List<Object?> get props => [];
}
