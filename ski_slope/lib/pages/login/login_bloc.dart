import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/pages/login/usecase/login_usecase.dart';

class LoginBloc extends StatedBloc<LoginState> {
  final LoginUseCase _login;
  String _username = "";

  set username(String username) => _username = username.trim();
  String _password = "";

  set password(String password) => _password = password.trim();

  LoginBloc(this._login);

  @override
  LoginState get defaultState => InitState();

  Future login() async {
    setState(LoadingState());
    final loginResult = await _login.execute(_username, _password);

    if (loginResult is LoginSuccess) {
      setState(SuccessState());
      _username = _password = "";
    } else if (loginResult is LoginFailedByInternet) {
      setState(NoInternetState());
    } else if (loginResult is LoginFailed) {
      setState(IncorrectDataState());
    }
  }
}

abstract class LoginState {}

class InitState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class NoInternetState extends LoginState {}

class IncorrectDataState extends LoginState {}
