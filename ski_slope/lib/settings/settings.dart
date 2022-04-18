import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_slope/data/model/auth_data.dart';
import 'package:ski_slope/data/model/user_data.dart';
import 'package:ski_slope/settings/shared_preferences_wrapper.dart';

class Settings {
  final SharedPreferencesWrapper _preferences;

  Settings(SharedPreferences sharedPreferences) : _preferences = SharedPreferencesWrapper(sharedPreferences);

  static const _accessToken = "accessToken";
  static const _refreshToken = "refreshToken";
  static const _tokenExpiry = "tokenExpiry";
  static const _refreshExpiry = "refreshExpiry";
  static const _username = "username";
  static const _email = "email";
  static const _fistName = "fistName";
  static const _lastName = "lastName";

  ///User

  String? get username => _preferences.getString(_username);

  set username(value) => _preferences.setString(_username, value);

  String? get email => _preferences.getString(_email);

  set email(value) => _preferences.setString(_email, value);

  String? get firstName => _preferences.getString(_fistName);

  set firstName(String? value) => _preferences.setString(_fistName, value);

  String? get lastName => _preferences.getString(_lastName);

  set lastName(String? value) => _preferences.setString(_lastName, value);

  set userData(UserData? user) {
    username = user?.username;
    email = user?.email;
    firstName = user?.firstName;
    lastName = user?.lastName;
  }

  UserData? get userData {
    if (username == null || email == null || firstName == null || lastName == null) {
      return null;
    }
    return UserData(
      username: username!,
      email: email!,
      firstName: firstName!,
      lastName: lastName!,
    );
  }

  ///Tokens

  String? get accessToken => _preferences.getString(_accessToken);

  set accessToken(value) => _preferences.setString(_accessToken, value);

  String? get refreshToken => _preferences.getString(_refreshToken);

  set refreshToken(value) => _preferences.setString(_refreshToken, value);

  int? get tokenExpiryDate => _preferences.getInt(_tokenExpiry);

  set tokenExpiryDate(int? value) => _preferences.setInt(_tokenExpiry, value);

  int? get refreshExpiryDate => _preferences.getInt(_refreshExpiry);

  set refreshExpiryDate(int? value) => _preferences.setInt(_refreshExpiry, value);

  bool get isTokenExpired =>
      tokenExpiryDate == null || DateTime.fromMillisecondsSinceEpoch(tokenExpiryDate!).isBefore(DateTime.now());

  bool get isRefreshTokenExpired =>
      refreshExpiryDate == null || DateTime.fromMillisecondsSinceEpoch(refreshExpiryDate!).isBefore(DateTime.now());

  set authResponseData(AuthData auth) {
    accessToken = auth.accessToken;
    refreshToken = auth.refreshToken;
    tokenExpiryDate = DateTime.now().millisecondsSinceEpoch + (auth.expiresIn * 1000);
    refreshExpiryDate = DateTime.now().millisecondsSinceEpoch + (auth.refreshExpiresIn * 1000);
  }
}
