import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/bloc_listener.dart';
import 'package:ski_slope/pages/vouchers/vouchers_bloc.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/durations.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/utilities/snackbar_viewer.dart';
import 'package:ski_slope/widgets/qr_item.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({Key? key}) : super(key: key);

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  final VouchersBloc _bloc = BlocProvider.getBloc();
  int _qrIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc.load();
  }

  final PageController _controller = PageController(initialPage: 0);

  void _nextQr() => _controller.nextPage(duration: Durations.welcomePageImageChange, curve: Curves.ease);

  void _previousQr() => _controller.previousPage(duration: Durations.welcomePageImageChange, curve: Curves.ease);

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
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            //TODO
            return const SizedBox();
          }

          final vouchers = bloc.state.vouchers;
          final heightFactor = vouchers[_qrIndex].startDate != null
              ? MediaQuery.of(context).size.height * 0.65
              : MediaQuery.of(context).size.height * 0.5;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingBig),
            child: Column(
              children: [
                SizedBox(
                  height: heightFactor,
                  child: PageView(
                      onPageChanged: (page) => setState(() => _qrIndex = page),
                      controller: _controller,
                      children: [
                        ...vouchers.map((e) => QrItem(
                              ownerName: e.ownerName,
                              qrCode: e.code,
                              startDate: e.startDate,
                              expireDate: e.expireDate,
                              isActive: e.isActive,
                            ))
                      ]),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SkiButton(
                        onPressed: _qrIndex == 0 ? null : _previousQr,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSmall),
                          child: Text(context.text.previous),
                        ),
                      ),
                      SkiButton(
                        onPressed: _qrIndex == vouchers.length - 1 ? null : _nextQr,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSmall),
                          child: Text(context.text.next),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
