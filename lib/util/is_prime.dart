bool isPrime(int number) {
  if (number <= 1) return false;
  for (var i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}
