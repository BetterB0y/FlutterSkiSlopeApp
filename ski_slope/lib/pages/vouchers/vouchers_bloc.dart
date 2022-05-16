import 'package:ski_slope/base/stated_bloc.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/pages/vouchers/usecase/load_vouchers.dart';

class VouchersBloc extends StatedBloc<VouchersState> {
  final LoadVouchersUseCase _loadVouchers;

  VouchersBloc(this._loadVouchers);

  @override
  VouchersState get defaultState => LoadingState();

  void load() async {
    setState(LoadingState());
    var result = await _loadVouchers.execute();
    if (result is SuccessfulDataResult) {
      setState(ReadyState(result.data));
    } else {
      setState(ErrorState());
    }
  }
}

abstract class VouchersState {
  List<VoucherData> vouchers;

  VouchersState(this.vouchers);
}

class LoadingState extends VouchersState {
  LoadingState() : super([]);
}

class ReadyState extends VouchersState {
  ReadyState(List<VoucherData> vouchers) : super(vouchers);
}

class ErrorState extends VouchersState {
  ErrorState() : super([]);
}
