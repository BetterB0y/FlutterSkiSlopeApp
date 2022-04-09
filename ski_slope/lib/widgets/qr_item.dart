import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/resources/themes.dart';

class QrItem extends StatelessWidget {
  const QrItem({Key? key, required this.qrLink}) : super(key: key);
  final String qrLink;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SkiColors.additionalColor,
      shape: SkiRadius.roundedRectangleBorder,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 50,
              child: QrImage(
                data: qrLink,
                version: QrVersions.auto,
              ),
            ),
            Expanded(
              flex: 50,
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
                        "name",
                        style: SkiTextStyle.headline1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "description",
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
