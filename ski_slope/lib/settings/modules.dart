import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:event_bus/event_bus.dart';
import 'package:ski_slope/app/app_bloc.dart';
import 'package:ski_slope/data/api/auth_api.dart';
import 'package:ski_slope/data/api/ski_lift_api.dart';
import 'package:ski_slope/data/api/ticket_api.dart';
import 'package:ski_slope/data/api/usecase/refresh.dart';
import 'package:ski_slope/data/api/user_api.dart';
import 'package:ski_slope/data/api/voucher_api.dart';
import 'package:ski_slope/data/repository/ski_lift_repository.dart';
import 'package:ski_slope/data/repository/ticket_repository.dart';
import 'package:ski_slope/data/repository/user_repository.dart';
import 'package:ski_slope/data/repository/voucher_repository.dart';
import 'package:ski_slope/pages/login/login_bloc.dart';
import 'package:ski_slope/pages/login/usecase/login_usecase.dart';
import 'package:ski_slope/pages/profile/profile_bloc.dart';
import 'package:ski_slope/pages/profile/usecase/logout.dart';
import 'package:ski_slope/pages/profile/usecase/user_data.dart';
import 'package:ski_slope/pages/register/register_bloc.dart';
import 'package:ski_slope/pages/register/usecase/register.dart';
import 'package:ski_slope/pages/ski_lifts/ski_lifts_bloc.dart';
import 'package:ski_slope/pages/ski_lifts/usecase/load_ski_lifts.dart';
import 'package:ski_slope/pages/tickets/tickets_bloc.dart';
import 'package:ski_slope/pages/tickets/usecase/load_tickets.dart';
import 'package:ski_slope/pages/vouchers/usecase/load_vouchers.dart';
import 'package:ski_slope/pages/vouchers/vouchers_bloc.dart';

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
  Dependency(
    (inject) => VoucherRepository(
      inject.getDependency(),
    ),
  ),
  Dependency(
    (inject) => TicketRepository(
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
  ),
  Dependency(
    (inject) => VoucherApi(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
  Dependency(
    (inject) => TicketApi(
      inject.getDependency(),
      inject.getDependency(),
    ),
  ),
];

final services = [
  Dependency(
    (_) => EventBus(),
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
  Dependency<UserDataUseCase>(
    (inject) => UserDataImpl(
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
  Dependency<LoadVouchersUseCase>(
    (inject) => LoadVouchersImpl(
      inject.getDependency(),
    ),
  ),
  Dependency<LoadTicketsUseCase>(
    (inject) => LoadTicketsImpl(
      inject.getDependency(),
    ),
  ),
  Dependency<RegisterUseCase>(
    (inject) => RegisterImpl(
      inject.getDependency(),
    ),
  ),
];

List<Bloc> get blocs => [
      Bloc(
        (inject) => LoginBloc(
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
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => SkiLiftsBloc(
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => VouchersBloc(
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => TicketsBloc(
          inject.getDependency(),
        ),
      ),
      Bloc(
        (inject) => RegisterBloc(
          inject.getDependency(),
        ),
      ),
    ];
