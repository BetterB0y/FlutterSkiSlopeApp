import 'package:flutter/material.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/widgets/menu_items_divider.dart';
import 'package:ski_slope/widgets/qr_item.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfItems = [
      QrItem(qrLink: "https://www.google.com"),
      QrItem(qrLink: "https://www.google.com"),
      QrItem(qrLink: "https://www.google.com"),
      QrItem(qrLink: "https://www.google.com"),
      QrItem(qrLink: "https://www.google.com"),
    ]
        .map<Widget>(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.menuItemsPadding),
            child: item,
          ),
        )
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.listVerticalPadding),
      itemCount: listOfItems.length,
      separatorBuilder: (context, index) => const MenuItemsDivider(),
      itemBuilder: (context, index) => listOfItems[index],
    );
  }
}
