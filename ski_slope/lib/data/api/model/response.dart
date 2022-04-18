import 'package:equatable/equatable.dart';

abstract class Response extends Equatable {}

abstract class SuccessfulResponse extends Response {}

abstract class ErrorResponse extends Response {}

class GeneralErrorResponse extends ErrorResponse {
  final dynamic exception;

  GeneralErrorResponse(this.exception);

  @override
  List<Object?> get props => [exception];
}

class StatusCodeNotHandledResponse extends ErrorResponse {
  final String url;
  final int statusCode;

  StatusCodeNotHandledResponse(this.url, this.statusCode);

  @override
  List<Object?> get props => [url, statusCode];
}

class NoInternetResponse extends ErrorResponse {
  @override
  List<Object?> get props => [];
}

class UnauthorizedResponse extends ErrorResponse {
  @override
  List<Object?> get props => [];
}
