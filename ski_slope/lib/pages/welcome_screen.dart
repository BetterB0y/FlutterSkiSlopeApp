import 'package:flutter/material.dart';
import 'package:ski_slope/pages/main_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/durations.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final List<String> _welcomeImages = [
    "assets/welcome_screen/welcomeScreenPhoto1.jpg",
    "assets/welcome_screen/welcomeScreenPhoto2.jpg",
    "assets/welcome_screen/welcomeScreenPhoto3.jpg",
  ];

  void _nextPage() => setState(() => _currentPage++);

  void _previousPage() => setState(() => _currentPage--);

  @override
  Widget build(BuildContext context) {
    final _descriptionTextStyle = Theme.of(context).textTheme.headline2!.copyWith(
          color: SkiColors.mainColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        );

    String headline = "";
    String description = "";
    if (_currentPage == 0) {
      headline = "test1";
      description = "opis1";
    }
    if (_currentPage == 1) {
      headline = "test2";
      description = "opis2";
    }
    if (_currentPage == 2) {
      headline = "test3";
      description = "opis3";
    }

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      _welcomeImages[_currentPage],
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.65,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: SkiColors.backgroundColor,
                  borderRadius: SkiRadius.welcomeScreenBorderRadius,
                ),
              ),
            ],
          ),
          Text(
            headline,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: SkiColors.buttonsColor,
              fontSize: 30,
              letterSpacing: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.appBarIconStartPadding, vertical: Dimensions.paddingBig),
            child: Text(
              description,
              style: _descriptionTextStyle,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingDoubleBig),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: SkiColors.buttonsColor, onPrimary: SkiColors.additionalColor),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSmall),
                        child: Text(context.text.welcomePrevious),
                      ),
                      onPressed: _currentPage == 0 ? null : _previousPage,
                    ),
                  ),
                  for (int i = 0; i < _welcomeImages.length; i++)
                    AnimatedContainer(
                      width: Dimensions.welcomePageButtonPadding / 10,
                      height: Dimensions.welcomePageButtonPadding / 4,
                      duration: Durations.welcomePage,
                      margin: const EdgeInsets.all(Dimensions.paddingSmall),
                      decoration: BoxDecoration(
                        color: i == _currentPage ? SkiColors.mainColor : SkiColors.buttonsColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: SkiColors.buttonsColor, onPrimary: SkiColors.additionalColor),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSmall),
                        child: Text(
                            _currentPage == _welcomeImages.length - 1 ? context.text.login : context.text.welcomeNext),
                      ),
                      onPressed: _currentPage == _welcomeImages.length - 1
                          ? () => navigateToPage(
                                context,
                                builder: (context) => const MainScreen(),
                              )
                          : _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
