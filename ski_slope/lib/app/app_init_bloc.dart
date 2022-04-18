import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/settings/modules.dart' as modules;
import 'package:ski_slope/settings/settings.dart';

class AppInitBloc extends StatedBloc<AppInitState> {
  @override
  AppInitState get defaultState => InitializingState();

  void init() async {
    setState(InitializingState());
    try {
      final preinit = await _getRequiringPreInit();
      setState(ReadyState(
        blocs: modules.blocs,
        dependencies: [
          Dependency<Settings>((_) => preinit.settings),
          ...modules.apis,
          ...modules.repositories,
          ...modules.usecases,
          ...modules.services,
        ],
      ));
    } catch (e) {
      setState(ErrorState(e));
    }
  }

  Future<RequirePreInit> _getRequiringPreInit() async {
    final prefs = await SharedPreferences.getInstance();
    final settings = Settings(prefs);
    return RequirePreInit(settings);
  }
}

abstract class AppInitState {}

class InitializingState extends AppInitState {}

class ReadyState extends AppInitState {
  final List<Dependency> dependencies;
  final List<Bloc> blocs;

  ReadyState({
    required this.dependencies,
    required this.blocs,
  });
}

class ErrorState extends AppInitState {
  final dynamic error;

  ErrorState(this.error);
}

class RequirePreInit {
  final Settings settings;

  RequirePreInit(this.settings);
}
