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

  void _nextQr() => setState(() => _qrIndex++);

  void _previousQr() => setState(() => _qrIndex--);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listOfItems[_qrIndex],
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingBig),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ],
          ),
        ),
      ],
    );
  }
}
