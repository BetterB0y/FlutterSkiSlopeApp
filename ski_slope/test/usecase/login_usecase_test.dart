import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/user_data.dart';
import 'package:ski_slope/pages/login/usecase/login_usecase.dart';

import '../mock.mocks.dart';

void main() {
  late LoginUseCase useCase;
  final _settings = MockSettings();
  final _userRepository = MockUserRepository();

  setUpAll(() {
    useCase = LoginImpl(
      _settings,
      _userRepository,
    );
  });

  setUp(() {
    when(_settings.username).thenReturn("oldUsername");
    clearInteractions(_settings);
    clearInteractions(_userRepository);
  });

  group('login user from form', () {
    test('should return LoginFailedByInternet when there is no internet connection', () async {
      when(_userRepository.login(any, any)).thenAnswer((_) async => ErrorResult.noInternet());

      await expectLater(
        useCase.login("username", "password"),
        completion(LoginFailedByInternet()),
      );

      verify(_settings.username).called(1);
      verifyNoMoreInteractions(_settings);
      verify(_userRepository.login(any, any)).called(1);
      verifyNoMoreInteractions(_userRepository);
    });

    test('should clear user data and return LoginSuccess when logging in with different username then previously',
        () async {
      when(_userRepository.login(any, any)).thenAnswer((_) async => SuccessfulResult());
      when(_userRepository.getUserData(false)).thenAnswer((_) async => SuccessfulDataResult.online(const UserData(
            username: "username",
            email: "test.email@gmail.com",
            firstName: "firstName",
            lastName: "lastName",
          )));

      await expectLater(
        useCase.login("username", "password"),
        completion(LoginSuccess()),
      );

      verify(_settings.username).called(1);
      verify(_settings.userData = null).called(1);
      verifyNoMoreInteractions(_settings);
      verify(_userRepository.login(any, any)).called(1);
      verify(_userRepository.getUserData(false)).called(1);
      verifyNoMoreInteractions(_userRepository);
    });

    test('should not clear user data and return LoginSuccess when logging in with the same username as previously',
        () async {
      when(_userRepository.login(any, any)).thenAnswer((_) async => SuccessfulResult());
      when(_userRepository.getUserData(false)).thenAnswer((_) async => SuccessfulDataResult.online(const UserData(
            username: "username",
            email: "test.email@gmail.com",
            firstName: "firstName",
            lastName: "lastName",
          )));
      when(_settings.username).thenReturn("username");

      await expectLater(
        useCase.login("username", "password"),
        completion(LoginSuccess()),
      );

      verify(_settings.username).called(1);
      verifyNever(_settings.userData = null);
      verifyNoMoreInteractions(_settings);
      verify(_userRepository.login(any, any)).called(1);
      verify(_userRepository.getUserData(false)).called(1);
      verifyNoMoreInteractions(_userRepository);
    });

    test('should return LoginFailed when not expected result came from api', () async {
      when(_userRepository.login(any, any)).thenAnswer((_) async => UnsuccessfulResult());

      await expectLater(
        useCase.login("username", "password"),
        completion(LoginFailed()),
      );

      verify(_settings.username).called(1);
      verifyNoMoreInteractions(_settings);
      verify(_userRepository.login(any, any)).called(1);
      verifyNoMoreInteractions(_userRepository);
    });
  });
}
