# showcase

## Patterns & Libraries Used

### 1. State Management: `Cubit` (from `flutter_bloc`)

- Lightweight, reactive state management.
- Separates UI from logic for better testability and maintainability.
- Used `BlocListener` to respond to prime number detection and navigate accordingly.

### 2. Dependency Injection: `get_it` + `injectable`

- Enables modular, loosely coupled code.
- `injectable` automates dependency registration.

### 3. Networking: `dio`

- More powerful than `http`, supports interceptors, logging, and timeouts.
- Used with `pretty_dio_logger` for easy debugging of HTTP requests.

### 4. Immutable Data & Serialization: `freezed` + `json_serializable` + `equatable`

- `freezed` for immutable models and union types.
- `json_serializable` for automatic serialization.
- `equatable` for accurate and efficient comparison in Cubit states.

### 5. Persistence: `shared_preferences`

- Used to store last prime number and the timestamp when it was found.
- Simple key-value storage that works well for this use case.

### 6. Time Formatting: `intl`

- Formats current time (`HH:mm`), date (`dd.MM.yyyy`), and weekday in English.
- Ensures consistent and locale-aware formatting.

### 7. Timer

- Used to trigger periodic API calls (e.g., every 10 seconds).
- Could be extended for live clock updates if needed.

### 8. Cubit Lifecycle Safety: `!isClosed` Check

In the Cubit, a `!isClosed` check is used before calling `emit(...)` in async code like timers or API polling.

This avoids runtime exceptions when the Cubit is disposed (e.g. due to navigation or hot reload), but a delayed operation still tries to update state.

### 9. Custom `Either<L, R>` Implementation

Instead of using a third-party functional programming library (like `dartz` or `fpdart`), a lightweight and idiomatic custom `Either<L, R>` was implemented using Dart's sealed classes:

```dart
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

```

Why this approach?

    ✅ Avoids unnecessary dependencies

    ✅ Keeps error/result handling explicit and type-safe

    ✅ Full control and customization possible

    ✅ Great for use with Cubits and BLoC without bloating the codebase

---

## Assumptions Made

### API

- The API always returns a **non-empty JSON list of numbers**.
- No structural changes are expected (e.g., switching to a JSON object).
- `freezed` + `json_serializable` do not support `fromJson` for raw lists, so parsing is handled manually.

### Concurrency

- No mutex, lock, or completer is used.
- Assumed polling interval avoids overlapping requests.
- No critical shared-state conflicts expected.

### Persistence

- Only the **last prime number and its timestamp** need to be stored.
- No need for history, multi-device sync, or complex persistence logic.

### Navigation

- Navigation uses Flutter's built-in `Navigator`.
- No deep linking or routing library is used.

### Clock

- Displays a time snapshot when the screen is built or updated.
- No second-by-second live clock assumed unless added via a `Timer.periodic`.

---

## Limitations

- `freezed` + `json_serializable` do not support top-level list deserialization out of the box.

  - Workaround: manually parse the list before converting to your model.

- No mutex or cancellation mechanism used for ongoing network requests.

  - Could be improved with `CancelableOperation` or a custom `isFetching` flag.

```

```
