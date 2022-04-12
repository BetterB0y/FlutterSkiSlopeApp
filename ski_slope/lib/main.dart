import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ski_slope/pages/welcome_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return const WelcomeScreen();
  }
}
