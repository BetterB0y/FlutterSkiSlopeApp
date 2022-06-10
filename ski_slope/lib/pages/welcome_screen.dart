import 'package:flutter/material.dart';
import 'package:ski_slope/pages/login/login_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/durations.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> _welcomeImages = [
    "assets/welcome_screen/welcomeScreenPhoto1.jpg",
    "assets/welcome_screen/welcomeScreenPhoto2.jpg",
    "assets/welcome_screen/welcomeScreenPhoto3.jpg",
  ];

  int _currentPage = 0;
  final PageController _controller = PageController(initialPage: 0);

  void _nextPage() => _controller.nextPage(
        duration: Durations.welcomePageImageChange,
        curve: Curves.ease,
      );

  void _previousPage() => _controller.previousPage(
        duration: Durations.welcomePageImageChange,
        curve: Curves.ease,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _headlineTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: SkiColors.buttonsColor,
    fontSize: 28,
    letterSpacing: 2,
  );

  @override
  Widget build(BuildContext context) {
    final _descriptionTextStyle = Theme.of(context).textTheme.headline2!.copyWith(
          color: SkiColors.mainColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );

    double screenHeight = MediaQuery.of(context).size.height;

    String headline = context.text.welcomeScreenHeadline1;
    String description = context.text.welcomeScreenDescription1;
    if (_currentPage == 1) {
      headline = context.text.welcomeScreenHeadline2;
      description = context.text.welcomeScreenDescription2;
    } else if (_currentPage == 2) {
      headline = context.text.welcomeScreenHeadline3;
      description = context.text.welcomeScreenDescription3;
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (page) => setState(() => _currentPage = page),
            controller: _controller,
            children: _welcomeImages.mapToList(
              (e) => Image.asset(
                e,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.40,
                maxHeight: screenHeight * 0.42,
                minWidth: double.infinity,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingBigPlus),
                decoration: BoxDecoration(
                  color: SkiColors.backgroundColor,
                  borderRadius: SkiRadius.welcomeScreenBorderRadius,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      headline,
                      textAlign: TextAlign.center,
                      style: _headlineTextStyle,
                    ),
                    Expanded(
                      flex: 90,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.menuItemsPadding),
                        child: Text(
                          description,
                          style: _descriptionTextStyle,
                          textAlign: TextAlign.center,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: SkiButton(
                                  child: Text(context.text.welcomePrevious),
                                  onPressed: _currentPage == 0 ? null : _previousPage,
                                ),
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
                            Flexible(
                              child: FractionallySizedBox(
                                widthFactor: 0.6,
                                child: SkiButton(
                                  child: Text(
                                    _currentPage == _welcomeImages.length - 1
                                        ? context.text.login
                                        : context.text.welcomeNext,
                                  ),
                                  onPressed: _currentPage == _welcomeImages.length - 1
                                      ? () => navigateToPage(
                                            context,
                                            builder: (context) => const LoginScreen(),
                                          )
                                      : _nextPage,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
