import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/pages/vouchers/usecase/load_vouchers.dart';

class VouchersBloc extends StatedBloc<VouchersState> {
  final LoadVouchersUseCase _loadVouchers;
  List<VoucherData> _vouchers = [];

  VouchersBloc(this._loadVouchers);

  @override
  VouchersState get defaultState => LoadingState([]);

  void load() async {
    setState(LoadingState(_vouchers));
    var result = await _loadVouchers.execute();
    if (result is SuccessfulDataResult) {
      _vouchers = result.data;
      setState(ReadyState(_vouchers));
    } else if (result is NoInternetConnectionDataResult) {
      setState(NoInternetState(_vouchers));
    } else {
      setState(ErrorState(_vouchers));
    }
  }
}

abstract class VouchersState {
  List<VoucherData> vouchers;

  VouchersState(this.vouchers);
}

class LoadingState extends VouchersState {
  LoadingState(List<VoucherData> vouchers) : super(vouchers);
}

class ReadyState extends VouchersState {
  ReadyState(List<VoucherData> vouchers) : super(vouchers);
}

class ErrorState extends VouchersState {
  ErrorState(List<VoucherData> vouchers) : super(vouchers);
}

class NoInternetState extends VouchersState {
  NoInternetState(List<VoucherData> vouchers) : super(vouchers);
}
