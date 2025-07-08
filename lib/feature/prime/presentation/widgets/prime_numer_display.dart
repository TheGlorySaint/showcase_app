import 'package:flutter/material.dart';

class PrimeNumberDisplay extends StatelessWidget {
  final int prime;

  const PrimeNumberDisplay({required this.prime, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Prime Number: $prime',
      style: const TextStyle(fontSize: 24, color: Colors.white70),
    );
  }
}
