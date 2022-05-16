import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  int _qrIndex = 0;

  final listOfItems = [
    QrItem(
      qrCode: "https://www.google.com",
      ownerName: "Test1",
      startDate: DateTime.now(),
      expireDate: DateTime.now(),
      isActive: true,
    ),
    QrItem(
      qrCode: "https://www.google.com",
      ownerName: "Test2",
      startDate: DateTime.now(),
      expireDate: DateTime.now(),
      isActive: true,
    ),
    QrItem(
      qrCode: "https://www.google.com",
      ownerName: "Test3",
      startDate: DateTime.now(),
      expireDate: DateTime.now(),
      isActive: false,
    ),
    QrItem(
      qrCode: "https://www.google.com",
      ownerName: "Test4",
      startDate: DateTime.now(),
      expireDate: DateTime.now(),
      isActive: true,
    ),
    QrItem(
      qrCode: "https://www.google.com",
      ownerName: "Test5",
      startDate: DateTime.now(),
      expireDate: DateTime.now(),
      isActive: true,
    ),
  ].toList();

  void _nextQr() => setState(() => _qrIndex++);

  void _previousQr() => setState(() => _qrIndex--);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingBig),
      child: Column(
        children: [
          listOfItems[_qrIndex],
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SkiButton(
                  onPressed: _qrIndex == 0 ? null : _previousQr,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSmall),
                    child: Text(context.text.previous),
                  ),
                ),
                SkiButton(
                  onPressed: _qrIndex == listOfItems.length - 1 ? null : _nextQr,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSmall),
                    child: Text(context.text.next),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
