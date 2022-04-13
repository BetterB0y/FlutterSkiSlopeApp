import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ski_slope/resources/dimensions.dart';

class ProfileIcon extends StatelessWidget {
  final GestureTapCallback? onTap;
  final EdgeInsets padding;

  const ProfileIcon({
    Key? key,
    required this.onTap,
    this.padding = const EdgeInsets.all(Dimensions.profileIconPadding),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: padding,
        child: const Icon(FontAwesomeIcons.personSkiing),
      ),
    );
  }
}
