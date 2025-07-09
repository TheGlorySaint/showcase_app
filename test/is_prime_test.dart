import 'package:flutter_test/flutter_test.dart';
import 'package:showcase/util/barrel_util.dart';

void main() {
  group('Either sync fold tests', () {
    test('is prime test true', () {
      final prime = isPrime(17);

      expect(prime, true);
    });

    test('is prime test false', () {
      final prime = isPrime(16);

      expect(prime, false);
    });
  });
}
