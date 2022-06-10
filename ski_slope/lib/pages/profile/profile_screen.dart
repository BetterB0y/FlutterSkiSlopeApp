import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ski_slope/pages/profile/profile_bloc.dart';
import 'package:ski_slope/pages/welcome_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/settings/settings.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key) {
    _bloc.getUserData();
  }

  final ProfileBloc _bloc = BlocProvider.getBloc();
  final Settings _settings = BlocProvider.getDependency();

  final headlineStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: SkiColors.buttonsColor,
    fontSize: 19,
  );

  final valueStyle = const TextStyle(
    fontWeight: FontWeight.w300,
    color: SkiColors.mainColor,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: context.text.userProfile),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: MediaQuery.of(context).size.width * 0.0017,
          child: Material(
            color: SkiColors.additionalColor,
            shape: SkiRadius.roundedRectangleBorder,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  FontAwesomeIcons.personSkiing,
                  size: Dimensions.profileIconSize,
                  color: SkiColors.buttonsColor,
                ),
                Text(
                  context.text.username + ":",
                  style: headlineStyle,
                ),
                Text(
                  _settings.username ?? "",
                  style: valueStyle,
                ),
                Text(
                  context.text.email + ":",
                  style: headlineStyle,
                ),
                Text(
                  _settings.email ?? "",
                  style: valueStyle,
                ),
                Text(
                  context.text.firstName + ":",
                  style: headlineStyle,
                ),
                Text(
                  _settings.firstName ?? "",
                  style: valueStyle,
                ),
                Text(
                  context.text.lastName + ":",
                  style: headlineStyle,
                ),
                Text(
                  _settings.lastName ?? "",
                  style: valueStyle,
                ),
                SkiButton(
                  onPressed: () {
                    _bloc.logOut();
                    _navigateToWelcomeScreen(context);
                  },
                  child: Text(context.text.logout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
      (_) => false,
    );
  }
}
