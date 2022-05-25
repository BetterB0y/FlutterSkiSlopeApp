import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';

class TicketBottomNavBar extends StatelessWidget {
  const TicketBottomNavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  final int currentIndex;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: SkiColors.additionalColor,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.ticketSimple),
          label: context.text.tickets,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.ticket),
          label: context.text.vouchers,
        ),
      ],
    );
  }
}
