import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/data/repository/voucher_repository.dart';

abstract class LoadVouchersUseCase {
  FutureDataResult<List<VoucherData>> execute();
}

class LoadVouchersImpl extends LoadVouchersUseCase {
  final VoucherRepository _repository;

  LoadVouchersImpl(this._repository);

  @override
  FutureDataResult<List<VoucherData>> execute() => _repository.loadVouchers();
}
