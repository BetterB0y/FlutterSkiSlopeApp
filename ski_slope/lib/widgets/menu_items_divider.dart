import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';

class MenuItemsDivider extends StatelessWidget {
  final double? height;

  const MenuItemsDivider({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? Dimensions.paddingBig,
    );
  }
}
