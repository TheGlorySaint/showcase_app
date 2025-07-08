sealed class Either<L, R> {
  const Either();

  factory Either.left(L value) = Left<L, R>;
  factory Either.right(R value) = Right<L, R>;
}

final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}

extension EitherFold<L, R> on Either<L, R> {
  T fold<T>({
    required T Function(L l) onLeft,
    required T Function(R r) onRight,
  }) {
    return switch (this) {
      Left<L, R>(value: final l) => onLeft(l),
      Right<L, R>(value: final r) => onRight(r),
    };
  }
}

extension EitherAsyncFold<L, R> on Either<L, R> {
  Future<T> asyncFold<T>({
    required Future<T> Function(L l) onLeft,
    required Future<T> Function(R r) onRight,
  }) {
    return switch (this) {
      Left<L, R>(value: final l) => onLeft(l),
      Right<L, R>(value: final r) => onRight(r),
    };
  }
}
