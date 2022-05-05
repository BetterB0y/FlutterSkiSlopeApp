import 'package:ski_slope/data/api/model/response.dart';

class UserResponse extends SuccessfulResponse {
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  UserResponse({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  UserResponse.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'];
}
