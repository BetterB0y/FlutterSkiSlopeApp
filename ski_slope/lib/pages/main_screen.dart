import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/pages/lift_screen.dart';
import 'package:ski_slope/pages/profile/profile_screen.dart';
import 'package:ski_slope/pages/qr_screen.dart';
import 'package:ski_slope/settings/settings.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/navigation.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';
import 'package:ski_slope/widgets/ticket_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPage = 0;
  final Settings _settings = BlocProvider.getDependency();

  @override
  Widget build(BuildContext context) {
    log(DateTime.fromMillisecondsSinceEpoch(_settings.refreshExpiryDate!).toString());
    return Scaffold(
        appBar: SkiAppBar(
          title: context.text.appName,
          isProfileVisible: true,
          onTap: () => navigateToPage(
            context,
            builder: (context) => ProfileScreen(),
          ),
        ),
        // appBar: AppBar(),
        body: _currentPage == 0 ? const LiftScreen() : const QrScreen(),
        bottomNavigationBar: TicketBottomNavBar(
          currentIndex: _currentPage,
          onTap: (index) => setState(() => _currentPage = index),
        ));
  }
}
