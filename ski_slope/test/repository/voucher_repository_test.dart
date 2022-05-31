import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/voucher_response.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/voucher_data.dart';
import 'package:ski_slope/data/repository/voucher_repository.dart';

import '../mock.mocks.dart';

void main() {
  late MockVoucherApi _api;
  late VoucherRepository _repository;

  setUpAll(() {
    _api = MockVoucherApi();
    _repository = VoucherRepository(_api);
  });

  setUp(() {
    clearInteractions(_api);
  });

  group('load vouchers', () {
    test('when api succeeds should return SuccessfulDataResult with data', () async {
      when(_api.getVouchers()).thenAnswer((_) async => VoucherListResponse(jsonDecode("""[
    {
      "id": 13,
      "code": "code",
      "ownerName": "zmienione",
      "active": true,
      "startDate": null,
      "expireDate": null
    },
    {
      "id": 14,
      "code": "90cbd6c8-11a0-4153-9a62-d63f1a0e172d",
      "ownerName": "Anna May",
      "active": false,
      "startDate": "2022-05-18 21:05:28.663723",
      "expireDate": "2022-05-18 21:30:28.663723"
    }
      ]""")));

      await expectLater(
        _repository.loadVouchers(),
        completion(
          SuccessfulDataResult.online([
            const VoucherData(
              id: 13,
              code: "code",
              ownerName: "zmienione",
              isActive: true,
              startDate: null,
              expireDate: null,
            ),
            VoucherData(
              id: 14,
              code: "90cbd6c8-11a0-4153-9a62-d63f1a0e172d",
              ownerName: "Anna May",
              isActive: false,
              startDate: DateTime.parse("2022-05-18 21:05:28.663723"),
              expireDate: DateTime.parse("2022-05-18 21:30:28.663723"),
            ),
          ]),
        ),
      );

      verify(_api.getVouchers()).called(1);
      verifyNoMoreInteractions(_api);
    });

    test('when api fails because of unknown reason should return NoInternetConnectionDataResult with empty list',
        () async {
          when(_api.getVouchers()).thenAnswer((_) async => StatusCodeNotHandledResponse("test", 502));

      await expectLater(
        _repository.loadVouchers(),
        completion(UnsuccessfulDataResult(const <VoucherData>[])),
      );

      verify(_api.getVouchers()).called(1);
      verifyNoMoreInteractions(_api);
    });

    test('when api fails because of internet should return NoInternetConnectionDataResult with empty list', () async {
      when(_api.getVouchers()).thenAnswer((_) async => NoInternetResponse());

      await expectLater(
        _repository.loadVouchers(),
        completion(NoInternetConnectionDataResult(const <VoucherData>[])),
      );

      verify(_api.getVouchers()).called(1);
      verifyNoMoreInteractions(_api);
    });
  });
}
