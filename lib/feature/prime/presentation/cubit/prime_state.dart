part of 'prime_cubit.dart';

@freezed
sealed class PrimeState with _$PrimeState {
  const PrimeState._();

  const factory PrimeState.uninitialized() = Uninitialized;
  const factory PrimeState.initial() = Initial;
  const factory PrimeState.loading() = Loading;
  const factory PrimeState.loaded({
    required int? prime,
    required int? numberResponse,
    required Duration elapsed,
  }) = Loaded;
  const factory PrimeState.error({required Object error}) = Error;

  int? get latestPrime => switch (this) {
    Loaded(:final prime) => prime,
    _ => null,
  };
}
