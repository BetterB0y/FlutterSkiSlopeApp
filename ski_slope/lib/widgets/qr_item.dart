import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/ski_radius.dart';
import 'package:ski_slope/resources/themes.dart';
import 'package:ski_slope/utilities/date_extensions.dart';
import 'package:ski_slope/utilities/extensions.dart';

class QrItem extends StatelessWidget {
  const QrItem({
    Key? key,
    required this.ownerName,
    required this.qrCode,
    required this.startDate,
    required this.expireDate,
    required this.isActive,
  }) : super(key: key);

  final String qrCode;
  final String ownerName;
  final DateTime? startDate;
  final DateTime? expireDate;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    List<Widget> startAndExpireDates = [];
    if (startDate != null && expireDate != null) {
      startAndExpireDates = [
        Text(
          context.text.startDate,
          style: SkiTextStyle.headline3,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          startDate!.asFullDateText,
          style: SkiTextStyle.bodyText2,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          context.text.expireDate,
          style: SkiTextStyle.headline3,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          expireDate!.asFullDateText,
          style: SkiTextStyle.bodyText2,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ];
    }
    return FractionallySizedBox(
      widthFactor: MediaQuery.of(context).size.height * 0.00105,
      child: Material(
        color: isActive ? SkiColors.additionalColor : SkiColors.disabledColor,
        shape: SkiRadius.roundedRectangleBorder,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              QrImage(
                data: qrCode,
                version: QrVersions.auto,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingBig),
                child: Divider(),
              ),
              Text(
                ownerName,
                style: SkiTextStyle.headline1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              ...startAndExpireDates,
            ],
          ),
        ),
      ),
    );
  }
}
