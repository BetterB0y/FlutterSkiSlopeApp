import 'package:ski_slope/data/api/model/response.dart';

class AuthResponse extends SuccessfulResponse {
  final String? accessToken;
  final String? refreshToken;

  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'];

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
