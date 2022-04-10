import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/qr_item.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  int qrIndex = 0;

  final listOfItems = [
    const QrItem(
      qrLink: "https://www.google.com",
      title: "Test1",
      description:
          "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
    ),
    const QrItem(
      qrLink: "https://www.google.com",
      title: "Test2",
      description: "test2",
    ),
    const QrItem(
      qrLink: "https://www.google.com",
      title: "Test3",
      description: "test3",
    ),
    const QrItem(
      qrLink: "https://www.google.com",
      title: "Test4",
      description: "test4",
    ),
    const QrItem(
      qrLink: "https://www.google.com",
      title: "Test5",
      description: "test5",
    ),
  ]
      .map<Widget>(
        (item) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.menuItemsPadding),
          child: item,
        ),
      )
      .toList();

  void _nextQr() => setState(() => qrIndex++);

  void _previousQr() => setState(() => qrIndex--);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listOfItems[qrIndex],
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingBig),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: SkiColors.buttonsColor, onPrimary: SkiColors.additionalColor),
                    onPressed: qrIndex == 0 ? null : _previousQr,
                    child: Text(context.text.previous),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: SkiColors.buttonsColor, onPrimary: SkiColors.additionalColor),
                    onPressed: qrIndex == listOfItems.length - 1 ? null : _nextQr,
                    child: Text(context.text.next),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
