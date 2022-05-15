import 'package:ski_slope/data/repository/user_repository.dart';

abstract class UserDataUseCase {
  void execute();
}

class UserDataImpl extends UserDataUseCase {
  final UserRepository _userRepository;

  UserDataImpl(this._userRepository);

  @override
  void execute() async {
    _userRepository.getUserData();
  }
}
