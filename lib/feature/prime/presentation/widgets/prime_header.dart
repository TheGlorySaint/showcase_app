import 'package:flutter/material.dart';

class PrimeHeader extends StatelessWidget {
  const PrimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "🎉 It's a prime!",
      style: TextStyle(
        fontSize: 36,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
