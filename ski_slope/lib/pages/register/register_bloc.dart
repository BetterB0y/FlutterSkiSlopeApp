import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/pages/register/usecase/register.dart';

class RegisterBloc extends StatedBloc<RegisterState> {
  final RegisterUseCase _registerUseCase;

  String _firstName = "";
  String _lastName = "";
  String _username = "";
  String _email = "";
  String _password = "";
  String _repeatedPassword = "";

  set firstName(String firstName) => _firstName = firstName.trim();

  set lastName(String lastName) => _lastName = lastName.trim();

  set username(String username) => _username = username.trim();

  set email(String email) => _email = email.trim();

  set repeatedPassword(String repeatedPassword) => _repeatedPassword = repeatedPassword.trim();

  set password(String password) => _password = password.trim();

  RegisterBloc(this._registerUseCase);

  @override
  RegisterState get defaultState => InitState();

  void validatePasswordAndRegister() {
    if (_password != _repeatedPassword) {
      setState(InvalidPasswordState());
      return;
    }
    _register();
  }

  Future<void> _register() async {
    var result = await _registerUseCase.execute(newUserDataToJson());
    if (result is SuccessfulResult) {
      setState(SuccessState());
    } else if (result is UserExistsResult) {
      setState(UserExistsState());
    } else if (result is NoInternetConnectionResult) {
      setState(NoInternetState());
    } else {
      setState(ErrorState());
    }
  }

  Map<String, dynamic> newUserDataToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = _username;
    data['password'] = _password;
    data['email'] = _email;
    data['firstName'] = _firstName;
    data['lastName'] = _lastName;
    return data;
  }
}

abstract class RegisterState {}

class InitState extends RegisterState {}

class SuccessState extends RegisterState {}

class NoInternetState extends RegisterState {}

class InvalidPasswordState extends RegisterState {}

class UserExistsState extends RegisterState {}

class ErrorState extends RegisterState {}
