import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/resources/themes.dart';

class QrItem extends StatelessWidget {
  const QrItem({Key? key, required this.qrLink, required this.title, required this.description}) : super(key: key);
  final String qrLink;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SkiColors.additionalColor,
      shape: SkiRadius.roundedRectangleBorder,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(Dimensions.paddingMedium),
        child: Column(
          children: [
            QrImage(
              data: qrLink,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.height * 0.45,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingBig),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSmall,
                horizontal: Dimensions.paddingBig,
              ),
              child: Text(
                title,
                style: SkiTextStyle.headline1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSmall,
                horizontal: Dimensions.paddingBig,
              ),
              child: Text(
                description,
                style: SkiTextStyle.bodyText1,
                textAlign: TextAlign.justify,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
