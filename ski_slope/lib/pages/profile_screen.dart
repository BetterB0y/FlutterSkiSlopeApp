import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ski_slope/pages/welcome_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: context.text.userProfile),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.5,
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
                Text(context.text.username + ": "),
                Text(context.text.email + ": "),
                Text(context.text.name + ": "),
                Text(context.text.surname + ": "),
                SkiButton(
                  onPressed: () {
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
        (_) => false);
  }
}
