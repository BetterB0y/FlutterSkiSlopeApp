import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/pages/profile/profile_screen.dart';
import 'package:ski_slope/pages/ski_lifts/ski_lifts_screen.dart';
import 'package:ski_slope/pages/vouchers/vouchers_screen.dart';
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
  final Settings _setting = BlocProvider.getDependency();

  @override
  Widget build(BuildContext context) {
    printError(_setting.accessToken);
    return Scaffold(
      appBar: SkiAppBar(
        title: context.text.appName,
        isProfileVisible: true,
        onTap: () => navigateToPage(
          context,
          builder: (context) => const ProfileScreen(),
        ),
      ),
      body: _currentPage == 0 ? SkiLiftsScreen() : VouchersScreen(),
      bottomNavigationBar: TicketBottomNavBar(
        currentIndex: _currentPage,
        onTap: (index) => setState(() => _currentPage = index),
      ),
    );
  }
}
