import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/barrel_util.dart';
import '../../domain/repositories/prime_repository.dart';

part 'prime_cubit.freezed.dart';
part 'prime_state.dart';

@injectable
class PrimeCubit extends Cubit<PrimeState> {
  final PrimeRepository productRepository;
  final SharedPreferences prefs;
  Timer? _timer;

  PrimeCubit(this.productRepository, this.prefs)
    : super(PrimeState.uninitialized()) {
    _startTimer();
    _loadLastPrime();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _fetchNumber());
  }

  Future<void> _loadLastPrime() async {
    final lastPrime = prefs.getInt('last_prime');
    final lastTime = prefs.getString('last_time');

    if (lastPrime != null && lastTime != null) {
      emit(
        PrimeState.loaded(
          prime: lastPrime,
          numberResponse: null,
          elapsed: DateTime.now().difference(DateTime.parse(lastTime)),
        ),
      );
    }
  }

  Future<void> _fetchNumber() async {
    if (isClosed) return;
    emit(const PrimeState.loading());

    try {
      final response = await productRepository.getNumber(path: '');

      if (isClosed) return;

      response.fold(
        onLeft: (error) => emit(PrimeState.error(error: error)),
        onRight: (number) async {
          final now = DateTime.now();
          final lastTime = prefs.getString('last_time');
          var elapsed = Duration.zero;

          if (lastTime != null) {
            elapsed = now.difference(DateTime.parse(lastTime));
          }

          if (isPrime(number.first)) {
            await prefs.setInt('last_prime', number.first);
            await prefs.setString('last_time', now.toIso8601String());

            emit(
              PrimeState.loaded(
                numberResponse: number.first,
                prime: number.first,
                elapsed: elapsed,
              ),
            );
          } else {
            emit(
              PrimeState.loaded(
                numberResponse: number.first,
                prime: state.latestPrime,
                elapsed: elapsed,
              ),
            );
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(PrimeState.error(error: e));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  @visibleForTesting
  Future<void> fetchNumberForTest() => _fetchNumber();

  @visibleForTesting
  Future<void> initializeForTest() async {
    await _loadLastPrime();
  }
}
