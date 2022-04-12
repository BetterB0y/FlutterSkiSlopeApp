import 'package:flutter/material.dart';
import 'package:ski_slope/pages/qr_screen.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: title),
      body: const QrScreen(),
    );
  }
}
