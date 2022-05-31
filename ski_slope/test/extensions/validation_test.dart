import 'package:flutter_test/flutter_test.dart';
import 'package:ski_slope/utilities/validation.dart';

void main() {
  group('First name validator', () {
    void check(String firstName, bool result) {
      test('for: $firstName, expected: $result', () {
        expect(firstName.isFirstNameValid, result);
      });
    }

    final firstNames = {
      "": false,
      "Daniel": true,
    };

    firstNames.forEach(check);
  });

  group('Last name validator', () {
    void check(String lastName, bool result) {
      test('for: $lastName, expected: $result', () {
        expect(lastName.isLastNameValid, result);
      });
    }

    final lastNames = {
      "": false,
      "Pakosz": true,
    };

    lastNames.forEach(check);
  });

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

  group('Email validator', () {
    void check(String email, bool result) {
      test('for: $email, expected: $result', () {
        expect(email.isEmail, result);
      });
    }

    final emails = {
      "": false,
      "niepoprawny@mail": false,
      "poprawny@mail.com": true,
      "poPrawny@mail.com": true,
      "POPRAWNY@MAIL.COM": true,
      "niepoprawny@mail@it.com": false,
    };

    emails.forEach(check);
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
