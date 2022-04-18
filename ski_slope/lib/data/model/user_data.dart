import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  const UserData({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [username, email, firstName, lastName];
}
