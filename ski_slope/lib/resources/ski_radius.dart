import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';

class SkiRadius {
  SkiRadius._();

  static RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.skiSlopeElementRadius),
    side: const BorderSide(color: SkiColors.mainColor),
  );
}
