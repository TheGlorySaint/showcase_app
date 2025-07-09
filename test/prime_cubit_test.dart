import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcase/core/error/barrel_error.dart';
import 'package:showcase/feature/prime/domain/repositories/repositories_barrel.dart';
import 'package:showcase/feature/prime/presentation/cubit/cubit_barrel.dart';
import 'package:showcase/util/barrel_util.dart';

class MockPrimeRepository extends Mock implements PrimeRepository {}

void main() {
  late MockPrimeRepository mockRepository;
  late SharedPreferences prefs;

  setUpAll(() {
    registerFallbackValue(<int>[]);
  });

  setUp(() async {
    mockRepository = MockPrimeRepository();
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  blocTest<PrimeCubit, PrimeState>(
    'emits [loaded] on startup if last prime and time are stored',
    build: () {
      final now = DateTime.now().toIso8601String();
      prefs.setInt('last_prime', 7);
      prefs.setString('last_time', now);

      return PrimeCubit(mockRepository, prefs);
    },
    act: (cubit) async {
      await cubit.initializeForTest();
    },
    expect: () => [
      isA<Loaded>()
          .having((s) => s.prime, 'prime', 7)
          .having((s) => s.numberResponse, 'numberResponse', null)
          .having((s) => s.elapsed.inSeconds >= 0, 'elapsed', true),
    ],
  );

  blocTest<PrimeCubit, PrimeState>(
    'emits [loading, loaded] when fetched number is prime',
    build: () {
      when(
        () => mockRepository.getNumber(path: any(named: 'path')),
      ).thenAnswer((_) async => Either.right([13]));

      return PrimeCubit(mockRepository, prefs);
    },
    act: (cubit) async {
      await cubit.fetchNumberForTest();
    },
    expect: () => [
      const PrimeState.loading(),
      isA<Loaded>()
          .having((s) => s.prime, 'prime', 13)
          .having((s) => s.numberResponse, 'numberResponse', 13),
    ],
  );

  blocTest<PrimeCubit, PrimeState>(
    'emits [loading, loaded] with old prime when number is not prime',
    build: () {
      prefs.setInt('last_prime', 5);
      prefs.setString('last_time', DateTime.now().toIso8601String());

      when(
        () => mockRepository.getNumber(path: any(named: 'path')),
      ).thenAnswer((_) async => Either.right([12]));

      return PrimeCubit(mockRepository, prefs);
    },
    act: (cubit) async {
      await cubit.fetchNumberForTest();
    },
    expect: () => [
      const PrimeState.loading(),
      isA<Loaded>()
          .having((s) => s.prime, 'prime', null)
          .having((s) => s.numberResponse, 'numberResponse', 12)
          .having((s) => s.elapsed.inSeconds >= 0, 'elapsed', true),
    ],
  );

  blocTest<PrimeCubit, PrimeState>(
    'emits [loading, error] when repository returns failure',
    build: () {
      when(
        () => mockRepository.getNumber(path: any(named: 'path')),
      ).thenAnswer((_) async => Either.left(UnknownFailure()));

      return PrimeCubit(mockRepository, prefs);
    },
    act: (cubit) async {
      await cubit.fetchNumberForTest();
    },
    expect: () => [
      const PrimeState.loading(),
      PrimeState.error(error: UnknownFailure()),
    ],
  );
}
