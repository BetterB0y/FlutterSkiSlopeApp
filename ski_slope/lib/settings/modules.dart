import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:event_bus/event_bus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ski_slope/app/app_bloc.dart';
import 'package:ski_slope/data/api/auth_api.dart';
import 'package:ski_slope/data/api/ski_lift_api.dart';
import 'package:ski_slope/data/api/usecase/refresh.dart';
import 'package:ski_slope/data/api/user_api.dart';
import 'package:ski_slope/data/repository/ski_lift_repository.dart';
import 'package:ski_slope/data/repository/user_repository.dart';
import 'package:ski_slope/pages/login/login_bloc.dart';
import 'package:ski_slope/pages/login/usecase/login_usecase.dart';
import 'package:ski_slope/pages/profile/profile_bloc.dart';
import 'package:ski_slope/pages/profile/usecase/logout.dart';
import 'package:ski_slope/pages/ski_lifts/ski_lifts_bloc.dart';
import 'package:ski_slope/pages/ski_lifts/usecase/load_ski_lifts.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';

final repositories = [
  Dependency(
    (inject) => UserRepository(
      inject.getDependency(),
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency(
    (inject) => SkiLiftRepository(
      inject.getDependency(),
    ),
  ),
];

final apis = [
  Dependency(
    (inject) => AuthApi(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency(
    (inject) => UserApi(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency(
    (inject) => SkiLiftApi(
      inject.getDependency(),
      inject.getDependency(),
    ),
  )
];

final services = [
  Dependency(
    (_) => EventBus(),
  ),
  Dependency(
    (_) => GoogleSignIn(),
  ),
  Dependency(
    (_) => SnackBarViewer(),
  ),
];

final usecases = [
  Dependency<LoginUseCase>(
    (inject) => LoginImpl(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency<LogOutUseCase>(
    (inject) => LogOutImpl(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency<RefreshTokenUseCase>(
    (inject) => RefreshTokenImpl(
      inject.getDependency(),
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency<LoadSkiLiftsUseCase>(
    (inject) => LoadSkiLiftsImpl(
      inject.getDependency(),
    ),
  ),
];

List<Bloc> get blocs => [
      Bloc(
        (inject) => LoginBloc(
          inject.getDependency(),
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => AppBloc(
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => ProfileBloc(
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => SkiLiftsBloc(
          inject.getDependency(),
        ),
      )
    ];
