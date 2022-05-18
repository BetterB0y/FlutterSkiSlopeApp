import 'package:equatable/equatable.dart';

typedef FutureResult = Future<Result>;

typedef FutureDataResult<T> = Future<DataResult<T>>;

/// Result
abstract class Result extends Equatable {}

/// Successful result of action
class SuccessfulResult extends Result {
  SuccessfulResult();

  factory SuccessfulResult.online() => OnlineSuccessfulResult._();

  factory SuccessfulResult.offline() => OfflineSuccessfulResult._();

  @override
  List<Object?> get props => [];
}

/// Unsuccessful result of action
abstract class ErrorResult extends Result {
  ErrorResult();

  factory ErrorResult.noInternet() => NoInternetConnectionResult._();
}

class UnsuccessfulResult extends ErrorResult {
  UnsuccessfulResult() : super();

  @override
  List<Object?> get props => [];
}

class NoInternetConnectionResult extends ErrorResult {
  NoInternetConnectionResult._() : super();

  @override
  List<Object?> get props => [];
}

//====================================================================================

/// Result of action with data
abstract class DataResult<T> extends Result {
  final T data;

  DataResult._(this.data);
}

/// Successful result of action with data
class SuccessfulDataResult<T> extends DataResult<T> {
  SuccessfulDataResult(T data) : super._(data);

  factory SuccessfulDataResult.online(T data) => OnlineSuccessfulDataResult._(data);

  factory SuccessfulDataResult.offline(T data) => OfflineSuccessfulDataResult._(data);

  @override
  List<Object?> get props => [data];
}

/// Internet status
abstract class Online {}

abstract class Offline {}

/// Internet status for Result
class OnlineSuccessfulResult extends SuccessfulResult implements Online {
  OnlineSuccessfulResult._();
}

class OfflineSuccessfulResult extends SuccessfulResult implements Offline {
  OfflineSuccessfulResult._();
}

/// Internet status for ResultData
class OnlineSuccessfulDataResult<T> extends SuccessfulDataResult<T> implements Online {
  OnlineSuccessfulDataResult._(T data) : super(data);

  @override
  List<Object?> get props => [data];
}

class OfflineSuccessfulDataResult<T> extends SuccessfulDataResult<T> implements Offline {
  OfflineSuccessfulDataResult._(T data) : super(data);

  @override
  List<Object?> get props => [data];
}

/// Unsuccessful result of action with data
class ErrorDataResult<T> extends DataResult<T> {
  ErrorDataResult(T data) : super._(data);

  @override
  List<Object?> get props => [data];
}

class UnsuccessfulDataResult<T> extends ErrorDataResult<T> {
  UnsuccessfulDataResult(T data) : super(data);

  @override
  List<Object?> get props => [data];
}

class NoInternetConnectionDataResult<T> extends ErrorDataResult<T> {
  NoInternetConnectionDataResult(T data) : super(data);

  @override
  List<Object?> get props => [data];
}
