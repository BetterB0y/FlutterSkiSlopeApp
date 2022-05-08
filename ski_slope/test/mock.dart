import 'package:mockito/annotations.dart';
import 'package:ski_slope/data/api/auth_api.dart';
import 'package:ski_slope/data/api/ski_lift_api.dart';
import 'package:ski_slope/data/api/user_api.dart';
import 'package:ski_slope/data/repository/ski_lift_repository.dart';
import 'package:ski_slope/data/repository/user_repository.dart';
import 'package:ski_slope/settings/settings.dart';

@GenerateMocks([
  Settings,
  AuthApi,
  UserApi,
  SkiLiftApi,
  UserRepository,
  SkiLiftRepository,
])
class Mocks {}
