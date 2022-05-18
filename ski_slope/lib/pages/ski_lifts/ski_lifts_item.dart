import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/resources/themes.dart';
import 'package:ski_slope/utilities/extensions.dart';

class SkiLiftsItem extends StatelessWidget {
  const SkiLiftsItem(
      {Key? key, required this.name, required this.description, required this.skiRunLength, required this.onTap})
      : super(key: key);
  final String name;
  final String? description;
  final double skiRunLength;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: SkiRadius.roundedRectangleBorder,
      child: InkWell(
        onTap: onTap,
        customBorder: SkiRadius.roundedRectangleBorder,
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
                      context.text.skiRunLength + skiRunLength.toString(),
                      style: SkiTextStyle.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null)
                      Text(
                        description!,
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
