import 'package:collection/collection.dart';

typedef FutureResult = Future<Result>;

typedef FutureDataResult<T> = Future<DataResult<T>>;

/// Result of action
abstract class Result {
  @override
  bool operator ==(Object other) => identical(this, other) || other is Result && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class UnsuccessfulResult extends Result {
  UnsuccessfulResult() : super();
}

class SuccessfulResult extends Result {
  SuccessfulResult();

  factory SuccessfulResult.online() => OnlineSuccessfulResult._();

  factory SuccessfulResult.offline() => OfflineSuccessfulResult._();
}

/// Result of action with data
abstract class DataResult<T> extends Result {
  final T data;

  DataResult._(this.data);

  @override
  bool operator ==(Object other) {
    final eq = const UnorderedIterableEquality().equals;
    return identical(this, other) ||
        other is DataResult &&
            runtimeType == other.runtimeType &&
            ((data is List && other.data is List && eq((data as List), (other.data as List))) || data == other.data);
  }

  @override
  int get hashCode => data.hashCode;
}

class SuccessfulDataResult<T> extends DataResult<T> {
  SuccessfulDataResult(T data) : super._(data);

  factory SuccessfulDataResult.online(T data) => OnlineSuccessfulDataResult._(data);

  factory SuccessfulDataResult.offline(T data) => OfflineSuccessfulDataResult._(data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || super == other && other is SuccessfulDataResult && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;
}

class UnsuccessfulDataResult<T> extends DataResult<T> {
  UnsuccessfulDataResult(T data) : super._(data);
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is OnlineSuccessfulDataResult && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'OnlineSuccessfulDataResult{$data}';
  }
}

class OfflineSuccessfulDataResult<T> extends SuccessfulDataResult<T> implements Offline {
  OfflineSuccessfulDataResult._(T data) : super(data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other && other is OfflineSuccessfulDataResult && runtimeType == other.runtimeType;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return 'OfflineSuccessfulDataResult{$data}';
  }
}

///Errors
abstract class ErrorResult extends Result {
  ErrorResult._();

  factory ErrorResult.noInternet() => NoInternetConnectionResult._();
}

class NoInternetConnectionResult extends ErrorResult {
  NoInternetConnectionResult._() : super._();
}
