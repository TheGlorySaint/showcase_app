import 'package:flutter_test/flutter_test.dart';
import 'package:showcase/util/barrel_util.dart';

void main() {
  group('Either sync fold tests', () {
    test('Right.fold calls onRight', () {
      final either = Right<String, int>(42);

      final result = either.fold(
        onLeft: (l) => 'Error: $l',
        onRight: (r) => 'Value: $r',
      );

      expect(result, 'Value: 42');
    });

    test('Left.fold calls onLeft', () {
      final either = Left<String, int>('failure');

      final result = either.fold(
        onLeft: (l) => 'Error: $l',
        onRight: (r) => 'Value: $r',
      );

      expect(result, 'Error: failure');
    });
  });

  group('Either async fold tests', () {
    test('Right.asyncFold calls onRight', () async {
      final either = Right<String, int>(42);

      final result = await either.asyncFold(
        onLeft: (l) async => 'Error: $l',
        onRight: (r) async => 'Value: $r',
      );

      expect(result, 'Value: 42');
    });

    test('Left.asyncFold calls onLeft', () async {
      final either = Left<String, int>('failure');

      final result = await either.asyncFold(
        onLeft: (l) async => 'Error: $l',
        onRight: (r) async => 'Value: $r',
      );

      expect(result, 'Error: failure');
    });
  });
}
