import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';

class SkiAppBar extends StatelessWidget with PreferredSizeWidget {
  const SkiAppBar({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Dimensions.appBarSize;
}
