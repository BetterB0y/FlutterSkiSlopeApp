import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/vouchers/vouchers_bloc.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
import 'package:ski_slope/widgets/empty_page.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/qr_screen.dart';

class VouchersScreen extends StatelessWidget {
  VouchersScreen({Key? key}) : super(key: key) {
    BlocProvider.getBloc<VouchersBloc>().load();
  }

  final _showSnackBar = SnackBarViewer().showSnackBar;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VouchersBloc>(
      onChanged: (state) {
        if (state is NoInternetState) {
          _showSnackBar(context, context.text.noInternetConnection);
        } else if (state is ErrorState) {
          _showSnackBar(context, context.text.otherError);
        }
      },
      builder: (context) => Consumer<VouchersBloc>(
        builder: (context, bloc) {
          final state = bloc.state;
          final vouchers = state.vouchers;

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (vouchers.isEmpty) {
            return EmptyPage(
              title: context.text.emptyHere,
              subtitle: context.text.emptyVouchersSubtitle,
            );
          }

          return QrScreen.vouchers(
            listOfVouchers: vouchers,
            listOfQrs: vouchers.mapToList(
              (e) => QrItem.voucher(
                ownerName: e.ownerName,
                qrCode: e.code,
                startDate: e.startDate,
                expireDate: e.expireDate,
                isActive: e.isActive,
              ),
            ),
          );
        },
      ),
    );
  }
}
