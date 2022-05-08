import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_slope/data/api/model/auth_response.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/user_response.dart';
import 'package:ski_slope/data/model/auth_data.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/user_data.dart';
import 'package:ski_slope/data/repository/user_repository.dart';

import '../mock.mocks.dart';

void main() {
  late MockAuthApi _authApi;
  late MockUserApi _userApi;
  late MockSettings _settings;
  late UserRepository _repository;

  setUpAll(() {
    _authApi = MockAuthApi();
    _userApi = MockUserApi();
    _settings = MockSettings();
    _repository = UserRepository(_authApi, _settings, _userApi);
  });

  setUp(() {
    clearInteractions(_authApi);
    clearInteractions(_userApi);
    clearInteractions(_settings);
  });

  group('login', () {
    test('should return successful when email, password are correct and internet connection is acquired', () async {
      final authResponse = AuthResponse.fromJson(jsonDecode("""{
              "access_token": "accessToken",
              "refresh_token": "refreshToken"
              }"""));
      when(_authApi.login(any, any)).thenAnswer((_) async => authResponse);

      await expectLater(
        _repository.login("username", "password"),
        completion(isA<SuccessfulResult>()),
      );

      verify(_settings.authResponseData = AuthData.fromResponse(authResponse)).called(1);
      verify(_settings.username = "username").called(1);
      verifyNoMoreInteractions(_settings);
      verify(_authApi.login(any, any)).called(1);
      verifyNoMoreInteractions(_authApi);
      verifyZeroInteractions(_userApi);
    });

    test('should return NoInternetConnection when there is no internet connection', () async {
      when(_authApi.login(any, any)).thenAnswer((_) async => NoInternetResponse());

      await expectLater(
        _repository.login("username", "password"),
        completion(isA<NoInternetConnectionResult>()),
      );

      verify(_authApi.login(any, any)).called(1);
      verifyNoMoreInteractions(_authApi);
      verifyZeroInteractions(_settings);
      verifyZeroInteractions(_userApi);
    });

    test('should return UnSuccessful when there is some exception', () async {
      when(_authApi.login(any, any)).thenAnswer((_) async => GeneralErrorResponse(Exception()));

      await expectLater(
        _repository.login("username", "password"),
        completion(isA<UnsuccessfulResult>()),
      );

      verify(_authApi.login(any, any)).called(1);
      verifyNoMoreInteractions(_authApi);
      verifyZeroInteractions(_settings);
      verifyZeroInteractions(_userApi);
    });
  });

  group('get user data', () {
    test('should return user data from settings', () async {
      const userData = UserData(username: "", email: "", firstName: "", lastName: "");
      when(_settings.userData).thenReturn(userData);

      await expectLater(
        _repository.getUserData(),
        completion(SuccessfulDataResult.offline(userData)),
      );

      verify(_settings.userData).called(1);
      verifyNoMoreInteractions(_settings);
      verifyZeroInteractions(_authApi);
      verifyZeroInteractions(_userApi);
    });

    test('should return user data downloaded from api and save in settings', () async {
      when(_settings.userData).thenReturn(null);
      final response = UserResponse.fromJson(jsonDecode("""{
              "id": "id",
              "username": "username",
              "email": "email",
              "firstName": "firstName",
              "lastName": "lastName"
              }"""));
      when(_userApi.getUserInfo()).thenAnswer((_) async => response);

      await expectLater(
        _repository.getUserData(),
        completion(SuccessfulDataResult.online(response.toUserData())),
      );

      verify(_settings.userData).called(1);
      verify(_settings.userData = response.toUserData()).called(1);
      verifyNoMoreInteractions(_settings);
      verify(_userApi.getUserInfo()).called(1);
      verifyNoMoreInteractions(_userApi);
      verifyZeroInteractions(_authApi);
    });

    test('should return null when no data is saved and result from api is not successful', () async {
      when(_settings.userData).thenReturn(null);
      when(_settings.email).thenReturn(null);
      when(_settings.username).thenReturn(null);
      when(_settings.firstName).thenReturn(null);
      when(_settings.lastName).thenReturn(null);
      when(_userApi.getUserInfo()).thenAnswer((_) async => GeneralErrorResponse(Exception()));

      await expectLater(
        _repository.getUserData(),
        completion(UnsuccessfulDataResult(const UserData(username: "", email: "", firstName: "", lastName: ""))),
      );

      verify(_settings.userData).called(1);
      verify(_settings.username).called(1);
      verify(_settings.email).called(1);
      verify(_settings.firstName).called(1);
      verify(_settings.lastName).called(1);
      verifyNoMoreInteractions(_settings);
      verify(_userApi.getUserInfo()).called(1);
      verifyNoMoreInteractions(_userApi);
      verifyZeroInteractions(_authApi);
    });
  });
}
