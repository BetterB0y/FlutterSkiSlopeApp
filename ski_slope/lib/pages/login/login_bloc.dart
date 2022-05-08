import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/pages/login/usecase/login_usecase.dart';

class LoginBloc extends StatedBloc<LoginState> {
  final LoginUseCase _loginUseCase;

  String _username = "";

  set username(String username) => _username = username.trim();
  String _password = "";

  set password(String password) => _password = password.trim();

  LoginBloc(this._loginUseCase);

  @override
  LoginState get defaultState => InitState();

  Future login() async {
    setState(LoadingState());
    final loginResult = await _loginUseCase.login(_username, _password);

    if (loginResult is LoginSuccess) {
      setState(SuccessState());
      _username = _password = "";
    } else if (loginResult is LoginFailedByInternet) {
      setState(NoInternetState());
    } else if (loginResult is LoginFailed) {
      setState(ServerFailState());
    } else if (loginResult is IncorrectLoginData) {
      setState(IncorrectDataState());
    }
  }

  Future<bool> isConnected() async {
    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet();
    if (!isConnected) {
      setState(NoInternetState());
    }
    return isConnected;
  }

  Future loginWithGoogle(String url) async {
    final loginResult = await _loginUseCase.loginWithGoogle(url);

    if (loginResult is LoginSuccess) {
      debugPrint("GoogleAuth url: $url");
      setState(SuccessState());
      _username = _password = "";
    }
  }
}

abstract class LoginState {}

class InitState extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class NoInternetState extends LoginState {}

class IncorrectDataState extends LoginState {}

class ServerFailState extends LoginState {}
