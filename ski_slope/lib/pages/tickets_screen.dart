import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/utilities/extensions.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.text.tickets),
        backgroundColor: SkiColors.mainColor,
      ),
      body: Text("Ticket"),
    );
  }
}
