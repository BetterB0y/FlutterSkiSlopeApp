import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';

class TicketBottomNavBar extends StatelessWidget {
  TicketBottomNavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  int currentIndex;
  Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: SkiColors.additionalColor,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: context.text.tickets),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: context.text.vouchers),
      ],
    );
  }
}
