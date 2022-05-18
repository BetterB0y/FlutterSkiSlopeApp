import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/tickets/tickets_bloc.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
import 'package:ski_slope/widgets/empty_page.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/qr_screen.dart';
import 'package:ski_slope/widgets/ski_app_bar.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({Key? key, required this.id, required this.title}) : super(key: key) {
    BlocProvider.getBloc<TicketsBloc>().load(id);
  }

  final int id;
  final String title;
  final SnackBarViewer _snackBarViewer = SnackBarViewer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkiAppBar(title: title),
      body: BlocListener<TicketsBloc>(
        onChanged: (state) {
          if (state is NoInternetState) {
            _snackBarViewer.showSnackBar(context, context.text.noInternetConnection);
          } else if (state is ErrorState) {
            _snackBarViewer.showSnackBar(context, context.text.otherError);
          }
        },
        builder: (context) => Consumer<TicketsBloc>(
          builder: (context, bloc) {
            final state = bloc.state;
            final tickets = state.tickets;

            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (tickets.isEmpty) {
              return EmptyPage(
                title: context.text.emptyHere,
                subtitle: context.text.emptyTicketsSubtitle,
              );
            }

            return QrScreen.tickets(
              listOfQrs: tickets.mapToList(
                (e) => QrItem.ticket(
                  ownerName: e.ownerName,
                  qrCode: e.code,
                  isActive: e.isActive,
                  entryAmount: e.entryAmount,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
