abstract class Response {}

abstract class SuccessfulResponse extends Response {}

abstract class ErrorResponse extends Response {}

class GeneralErrorResponse extends ErrorResponse {
  final dynamic exception;

  GeneralErrorResponse(this.exception);
}

class StatusCodeNotHandledResponse extends ErrorResponse {
  final String url;
  final int statusCode;

  StatusCodeNotHandledResponse(this.url, this.statusCode);
}

class NoInternetResponse extends ErrorResponse {}

class UnauthorizedResponse extends ErrorResponse {}
