import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/ticket_bottom_nav_bar.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SkiColors.mainColor,
          title: currentIndex == 0 ? Text(context.text.tickets) : Text(context.text.vouchers),
        ),
        body: Text("Placeholder"),
        bottomNavigationBar: TicketBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
        ));
  }
}
