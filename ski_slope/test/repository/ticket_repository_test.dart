import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/ticket_response.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ticket_data.dart';
import 'package:ski_slope/data/repository/ticket_repository.dart';

import '../mock.mocks.dart';

void main() {
  late MockTicketApi api;
  late TicketRepository repository;

  setUpAll(() {
    api = MockTicketApi();
    repository = TicketRepository(api);
  });

  setUp(() {
    clearInteractions(api);
  });

  group('load tickets', () {
    test('when api succeeds should return SuccessfulDataResult with data', () async {
      when(api.getTicketById(any)).thenAnswer((_) async => TicketListResponse(jsonDecode("""[
    {
      "id": 15,
      "code": "code",
      "ownerName": "Anna may",
      "active": true,
      "entryAmount": 5,
      "skiLiftName": "Tommy Beginner"
    },
    {
      "id": 16,
      "code": "1f3139ea-e570-49d7-8aaa-b724d171745b",
      "ownerName": "Magda may",
      "active": false,
      "entryAmount": 2,
      "skiLiftName": "Tommy Beginner"
    }
      ]""")));

      await expectLater(
        repository.loadTicketsById(1),
        completion(
          SuccessfulDataResult.online(const [
            TicketData(
              id: 15,
              code: "code",
              ownerName: "Anna may",
              isActive: true,
              entryAmount: 5,
            ),
            TicketData(
                id: 16,
                code: "1f3139ea-e570-49d7-8aaa-b724d171745b",
                ownerName: "Magda may",
                isActive: false,
                entryAmount: 2),
          ]),
        ),
      );

      verify(api.getTicketById(any)).called(1);
      verifyNoMoreInteractions(api);
    });

    test('when api fails because of unknown reason should return NoInternetConnectionDataResult with empty list',
        () async {
      when(api.getTicketById(any)).thenAnswer((_) async => StatusCodeNotHandledResponse("test", 502));

      await expectLater(
        repository.loadTicketsById(1),
        completion(UnsuccessfulDataResult(const <TicketData>[])),
      );

      verify(api.getTicketById(any)).called(1);
      verifyNoMoreInteractions(api);
    });

    test('when api fails because of internet should return NoInternetConnectionDataResult with empty list', () async {
      when(api.getTicketById(any)).thenAnswer((_) async => NoInternetResponse());

      await expectLater(
        repository.loadTicketsById(1),
        completion(NoInternetConnectionDataResult(const <TicketData>[])),
      );

      verify(api.getTicketById(any)).called(1);
      verifyNoMoreInteractions(api);
    });
  });
}
