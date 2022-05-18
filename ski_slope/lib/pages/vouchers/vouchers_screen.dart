import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/pages/vouchers/vouchers_bloc.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/empty_page.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/qr_screen.dart';

class VouchersScreen extends StatelessWidget {
  VouchersScreen({Key? key}) : super(key: key) {
    BlocProvider.getBloc<VouchersBloc>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VouchersBloc>(
      builder: (context, bloc) {
        final state = bloc.state;
        final vouchers = state.vouchers;

        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return EmptyPage(
            title: context.text.emptyHere,
            subtitle: context.text.loadingFail,
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
    );
  }
}
