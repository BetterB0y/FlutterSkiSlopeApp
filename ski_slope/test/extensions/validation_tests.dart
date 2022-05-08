import 'package:flutter_test/flutter_test.dart';
import 'package:ski_slope/utilities/validation.dart';

void main() {
  group('Username validator', () {
    void check(String username, bool result) {
      test('for: $username, expected: $result', () {
        expect(username.isUserNameValid, result);
      });
    }

    final usernames = {
      "": false,
      "12345": true,
      "1234": false,
      "12345678901234567890": true,
      "123456789012345678901": false,
      "@asd21D@": true,
    };

    usernames.forEach(check);
  });

  group('Password validator', () {
    void check(String password, bool result) {
      test('for: $password, expected: $result', () {
        expect(password.isPasswordValid, result);
      });
    }

    final passwords = {
      "": false,
      "12345": true,
      "1234": false,
      "12345678901234567890": true,
      "123456789012345678901": false,
      "@asd21D@": true,
    };

    passwords.forEach(check);
  });
}
