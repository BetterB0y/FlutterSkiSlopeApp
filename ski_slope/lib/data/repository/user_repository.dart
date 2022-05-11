import 'package:ski_slope/data/api/auth_api.dart';
import 'package:ski_slope/data/api/model/auth_response.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/user_response.dart';
import 'package:ski_slope/data/api/user_api.dart';
import 'package:ski_slope/data/model/auth_data.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/user_data.dart';
import 'package:ski_slope/settings/settings.dart';

class UserRepository {
  final AuthApi _api;
  final UserApi _userApi;
  final Settings _settings;

  UserRepository(
    this._api,
    this._settings,
    this._userApi,
  );

  FutureResult login(String username, String password) {
    username = username.trim();
    password = password.trim();
    return _api.login(username, password).then((response) {
      if (response is NoInternetResponse) {
        return ErrorResult.noInternet();
      } else if (response is AuthResponse) {
        final authData = AuthData.fromResponse(response);
        _settings.authResponseData = authData;
        _settings.username = username;
        return SuccessfulResult();
      } else if (response is UnauthorizedResponse) {
        return WrongUserDataResult();
      }
      return UnsuccessfulResult();
    });
  }

  FutureResult loginWithGoogle(String url) async {
    final accessToken = Uri.parse(url).queryParameters['accessToken'];
    final refreshToken = Uri.parse(url).queryParameters['refreshToken'];
    if (accessToken != null && refreshToken != null) {
      _settings.authResponseData = AuthData(accessToken, refreshToken);
      return SuccessfulResult();
    }
    return UnsuccessfulResult();
  }

  FutureDataResult<UserData> getUserData() async {
    final user = _settings.userData;
    if (user == null) {
      final response = await _userApi.getUserInfo();
      if (response is UserResponse) {
        final userData = response.toUserData();
        _settings.userData = userData;
        return SuccessfulDataResult.online(userData);
      }
      return UnsuccessfulDataResult(
        UserData(
          username: _settings.username ?? "",
          email: _settings.email ?? "",
          firstName: _settings.firstName ?? "",
          lastName: _settings.lastName ?? "",
        ),
      );
    } else {
      return SuccessfulDataResult.offline(user);
    }
  }
}

extension UserConverter on UserResponse {
  UserData toUserData() => UserData(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
}

class WrongUserDataResult extends ErrorResult {
  @override
  List<Object?> get props => [];
}
