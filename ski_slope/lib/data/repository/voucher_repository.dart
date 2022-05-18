import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/voucher_response.dart';
import 'package:ski_slope/data/api/voucher_api.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/utilities/extensions.dart';

class VoucherRepository {
  final VoucherApi _voucherApi;

  VoucherRepository(this._voucherApi);

  FutureDataResult<List<VoucherData>> loadVouchers() async {
    final response = await _voucherApi.getVouchers();
    if (response is VoucherListResponse) {
      final voucherData = response.vouchers.mapToList((element) => element.toVoucherData());
      return SuccessfulDataResult.online(voucherData);
    } else if (response is NoInternetResponse) {
      return NoInternetConnectionDataResult(const []);
    } else {
      return UnsuccessfulDataResult(const []);
    }
  }
}

extension SkiLiftConverter on VoucherResponse {
  VoucherData toVoucherData() => VoucherData(
    id: id,
    code: code,
    ownerName: ownerName,
    isActive: isActive,
    startDate: startDate,
    expireDate: expireDate,
  );
}
