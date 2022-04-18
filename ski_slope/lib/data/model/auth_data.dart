import 'package:equatable/equatable.dart';
import 'package:ski_slope/data/api/model/auth_response.dart';

class AuthData extends Equatable {
  final String? accessToken;
  final String? refreshToken;
  final int expiresIn = 600; // [s] - 10 minutes
  final int refreshExpiresIn = 1800; // [s] - 30 minutes

  const AuthData(this.accessToken, this.refreshToken);

  factory AuthData.empty() {
    return const AuthData(null, null);
  }

  factory AuthData.fromResponse(AuthResponse response) {
    return AuthData(response.accessToken, response.refreshToken);
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn, refreshExpiresIn];
}
