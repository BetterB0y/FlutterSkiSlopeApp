import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ski_slope/app/app_bloc.dart';
import 'package:ski_slope/app/app_events.dart';
import 'package:ski_slope/app/app_init_bloc.dart';
import 'package:ski_slope/pages/main_screen.dart';
import 'package:ski_slope/pages/welcome_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/settings/settings.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/bloc_builder.dart';

void main() {
  runApp(const SkiSlopeApp());
}

class SkiSlopeApp extends StatefulWidget {
  const SkiSlopeApp({Key? key}) : super(key: key);

  @override
  State<SkiSlopeApp> createState() => _SkiSlopeAppState();
}

class _SkiSlopeAppState extends State<SkiSlopeApp> {
  final AppInitBloc _appInitBloc = AppInitBloc();
  final GlobalKey appKey = GlobalKey();
  final GlobalKey providerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _appInitBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return BlocBuilder(
      bloc: _appInitBloc,
      builder: (context, bloc) {
        final state = bloc.state;
        if (state is ReadyState) {
          return BlocProvider(
            key: providerKey,
            blocs: state.blocs,
            dependencies: state.dependencies,
            child: Consumer<AppBloc>(
              builder: (context, bloc) => MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (BuildContext context) => context.text.appName,
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: SkiColors.backgroundColor,
                    errorColor: SkiColors.errorColor,
                    colorScheme: ThemeData().colorScheme.copyWith(
                          primary: SkiColors.mainColor,
                          background: SkiColors.backgroundColor,
                        )),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: const [
                  Locale('en'),
                  Locale('pl'),
                ],
                home: _AppPage(),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _getStartingPage(context);
  }

  Widget _getStartingPage(BuildContext context) {
    final bloc = BlocProvider.getBloc<AppBloc>();
    final settings = BlocProvider.getDependency<Settings>();
    final isLogged = settings.accessToken != null;
    final isRefreshValid = !settings.isRefreshTokenExpired;
    final userLoggedIn = isLogged && isRefreshValid && bloc.state is! LogOutState;
    if (userLoggedIn) {
      return const MainScreen();
    } else {
      BlocProvider.getDependency<EventBus>().fire(LogOutEvent());
      return const WelcomeScreen();
    }
  }
}
