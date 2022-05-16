import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const EmptyPage({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -80,
          right: 0,
          child: Icon(
            FontAwesomeIcons.personSkiing,
            color: SkiColors.mainColor,
            size: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.emptyPageHorizontalPadding,
              vertical: Dimensions.emptyPageVerticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(color: SkiColors.mainColor),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(color: SkiColors.buttonsColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
