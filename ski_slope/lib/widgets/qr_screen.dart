import 'package:flutter/material.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/resources/durations.dart';
import 'package:ski_slope/utilities/extensions.dart';
import 'package:ski_slope/widgets/ski_button.dart';

class QrScreen extends StatefulWidget {
  const QrScreen.tickets({
    Key? key,
    required this.listOfQrs,
  })  : isTicket = true,
        listOfVouchers = const [],
        super(key: key);

  const QrScreen.vouchers({
    Key? key,
    required this.listOfVouchers,
    required this.listOfQrs,
  })  : isTicket = false,
        super(key: key);

  final List<Widget> listOfQrs;
  final bool isTicket;
  final List<VoucherData> listOfVouchers;

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  int _qrIndex = 0;

  final PageController _controller = PageController(initialPage: 0);

  void _nextQr() => _controller.nextPage(duration: Durations.welcomePageImageChange, curve: Curves.ease);

  void _previousQr() => _controller.previousPage(duration: Durations.welcomePageImageChange, curve: Curves.ease);

  @override
  Widget build(BuildContext context) {
    final heightFactor = widget.isTicket
        ? MediaQuery.of(context).size.height * 0.55
        : widget.listOfVouchers[_qrIndex].startDate != null
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
                ...widget.listOfQrs,
              ],
            ),
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
                  onPressed: _qrIndex == widget.listOfQrs.length - 1 ? null : _nextQr,
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
  }
}
