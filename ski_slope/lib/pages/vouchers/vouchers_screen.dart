import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/vouchers/vouchers_bloc.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/qr_screen.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  final VouchersBloc _bloc = BlocProvider.getBloc();

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VouchersBloc>(
      onChanged: (state) {
        if (state is ErrorState) {
          SnackBarViewer().showSnackBar(context, context.text.loadingFail);
        }
      },
      builder: (context) => Consumer<VouchersBloc>(
        builder: (context, bloc) {
          final state = _bloc.state;
          final vouchers = bloc.state.vouchers;

          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            //TODO
            return const SizedBox();
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
