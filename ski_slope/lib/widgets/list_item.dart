import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/themes.dart';

class SlopeItem extends StatelessWidget {
  const SlopeItem({Key? key, required this.name, required this.description, required this.onTap}) : super(key: key);
  final String name;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.skiSlopeElementRadius),
      side: const BorderSide(color: SkiColors.mainColor),
    );
    return Material(
      color: Colors.white,
      shape: roundedRectangleBorder,
      child: InkWell(
        onTap: onTap,
        customBorder: roundedRectangleBorder,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 32,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.skiSlopeElementRadius),
                  bottomLeft: Radius.circular(Dimensions.skiSlopeElementRadius),
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 68,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingBig),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingBigPlus,
                      ),
                      child: Text(
                        name,
                        style: SkiTextStyle.headline1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      description,
                      style: SkiTextStyle.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
