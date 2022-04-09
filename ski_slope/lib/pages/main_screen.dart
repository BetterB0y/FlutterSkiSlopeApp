import 'package:flutter/material.dart';
import 'package:ski_slope/pages/lift_screen.dart';
import 'package:ski_slope/pages/vouchers_screen.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/ticket_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SkiColors.mainColor,
          title: Text(context.text.appName),
        ),
        body: currentIndex == 0 ? LiftScreen() : VouchersScreen(),
        bottomNavigationBar: TicketBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
        ));
  }
}
