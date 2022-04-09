import 'package:flutter/material.dart';
import 'package:ski_slope/pages/ticket_screen.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/widgets/list_item.dart';
import 'package:ski_slope/widgets/menu_items_divider.dart';

class SlopeScreen extends StatelessWidget {
  const SlopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfItems = [
      SlopeItem(
        name: "Wyciąg 1",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () => navigateToPage(
          context,
          builder: (context) => TicketScreen(),
        ),
      ),
      SlopeItem(
        name: "Wyciąg 2",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () => navigateToPage(
          context,
          builder: (context) => TicketScreen(),
        ),
      ),
      SlopeItem(
        name: "Wyciąg 3",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () {},
      ),
      SlopeItem(
        name: "Wyciąg 4",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () {},
      ),
      SlopeItem(
        name: "Wyciąg 5",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () {},
      ),
      SlopeItem(
        name: "Wyciąg 6",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () {},
      ),
      SlopeItem(
        name: "Wyciąg 7",
        description:
            "Ośrodek narciarski położony w Wiśle Jaworniku na tyłach czterogwiazdkowego hotelu „Stok”, w Beskidzie Śląskim",
        onTap: () {},
      ),
    ]
        .map<Widget>(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.menuItemsPadding),
            child: item,
          ),
        )
        .toList();

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.listVerticalPadding),
        itemCount: listOfItems.length,
        separatorBuilder: (context, index) => const MenuItemsDivider(),
        itemBuilder: (context, index) => listOfItems[index],
      ),
    );
  }
}
