import 'package:flutter/material.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/empty_page.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/qr_screen.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final listOfItems = [
    const QrItem.ticket(
      qrCode: "https://www.google.com",
      ownerName: "Test1",
      isActive: true,
      numberOfEntries: 5,
    ),
    const QrItem.ticket(
      qrCode: "https://www.google.com",
      ownerName: "Test2",
      isActive: false,
      numberOfEntries: 5,
    ),
    const QrItem.ticket(
      qrCode: "https://www.google.com",
      ownerName: "Test3",
      isActive: true,
      numberOfEntries: 5,
    ),
    const QrItem.ticket(
      qrCode: "https://www.google.com",
      ownerName: "Test4",
      isActive: true,
      numberOfEntries: 5,
    ),
    const QrItem.ticket(
      qrCode: "https://www.google.com",
      ownerName: "Test5",
      isActive: true,
      numberOfEntries: 5,
    ),
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: widget.title),
      body: listOfItems.isEmpty
          ? EmptyPage(
              title: context.text.emptyHere,
              subtitle: context.text.emptyTicketsSubtitle,
            )
          : QrScreen.tickets(
              listOfQrs: listOfItems,
            ),
    );
  }
}
