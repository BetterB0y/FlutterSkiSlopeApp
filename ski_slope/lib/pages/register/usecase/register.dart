import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/repository/user_repository.dart';

abstract class RegisterUseCase {
  FutureResult execute(Map<String, dynamic> newUserData);
}

class RegisterImpl extends RegisterUseCase {
  final UserRepository _repository;

  RegisterImpl(this._repository);

  @override
  FutureResult execute(Map<String, dynamic> newUserData) async => _repository.register(newUserData);
}
