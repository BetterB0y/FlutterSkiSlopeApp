import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ski_slope/data/api/model/response.dart';
import 'package:ski_slope/data/api/model/ski_lift_response.dart';
import 'package:ski_slope/data/model/result/result.dart';
import 'package:ski_slope/data/model/ski_lift_data.dart';
import 'package:ski_slope/data/repository/ski_lift_repository.dart';

import '../mock.mocks.dart';

void main() {
  late MockSkiLiftApi api;
  late SkiLiftRepository repository;

  setUpAll(() {
    api = MockSkiLiftApi();
    repository = SkiLiftRepository(api);
  });

  setUp(() {
    clearInteractions(api);
  });

  group('load ski lifts', () {
    test('when api succeeds should return SuccessfulDataResult with data', () async {
      when(api.getSkiLifts()).thenAnswer((_) async => SkiLiftListResponse(jsonDecode("""[
    {
      "id": 1,
      "name": "Tommy Beginner",
      "maxHeight": 344.6,
      "skiRunLength": 2090.0,
      "description": "A",
      "active": true
    },
    {
      "id": 2,
      "name": "skiLift 2 name",
      "maxHeight": 42.0,
      "skiRunLength": 120.0,
      "description": "skiLift 2 description",
      "active": false
    },
    {
      "id": 3,
      "name": "skiLift 3 name",
      "maxHeight": 34.0,
      "skiRunLength": 56.0,
      "description": "skiLift 3 description",
      "active": true
    }
      ]""")));

      await expectLater(
        repository.loadSkiLifts(),
        completion(
          SuccessfulDataResult.online(const [
            SkiLiftData(
              id: 1,
              name: "Tommy Beginner",
              maxHeight: 344.6,
              skiRunLength: 2090.0,
              description: "A",
              isActive: true,
            ),
            SkiLiftData(
              id: 2,
              name: "skiLift 2 name",
              maxHeight: 42.0,
              skiRunLength: 120.0,
              description: "skiLift 2 description",
              isActive: false,
            ),
            SkiLiftData(
              id: 3,
              name: "skiLift 3 name",
              maxHeight: 34.0,
              skiRunLength: 56.0,
              description: "skiLift 3 description",
              isActive: true,
            ),
          ]),
        ),
      );

      verify(api.getSkiLifts()).called(1);
      verifyNoMoreInteractions(api);
    });

    test('when api fails because of unknown reason should return NoInternetConnectionDataResult with empty list',
        () async {
      when(api.getSkiLifts()).thenAnswer((_) async => StatusCodeNotHandledResponse("test", 502));

      await expectLater(
        repository.loadSkiLifts(),
        completion(UnsuccessfulDataResult(const <SkiLiftData>[])),
      );

      verify(api.getSkiLifts()).called(1);
      verifyNoMoreInteractions(api);
    });

    test('when api fails because of internet should return NoInternetConnectionDataResult with empty list', () async {
      when(api.getSkiLifts()).thenAnswer((_) async => NoInternetResponse());

      await expectLater(
        repository.loadSkiLifts(),
        completion(NoInternetConnectionDataResult(const <SkiLiftData>[])),
      );

      verify(api.getSkiLifts()).called(1);
      verifyNoMoreInteractions(api);
    });
  });
}