import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/widgets/profile_icon.dart';

class SkiAppBar extends StatelessWidget with PreferredSizeWidget {
  const SkiAppBar({Key? key, this.title = "", this.isProfileVisible = false, this.onTap}) : super(key: key);
  final String title;
  final bool isProfileVisible;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          if (isProfileVisible) ProfileIcon(onTap: onTap),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Dimensions.appBarSize;
}
