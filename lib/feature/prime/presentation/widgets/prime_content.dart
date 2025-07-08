import 'package:flutter/material.dart';

import 'widgets_barrel.dart';

class PrimeContent extends StatelessWidget {
  final int prime;
  final Duration elapsed;

  const PrimeContent({required this.prime, required this.elapsed, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PrimeHeader(),
              const SizedBox(height: 16),
              PrimeNumberDisplay(prime: prime),
              const SizedBox(height: 8),
              ElapsedTimeDisplay(elapsed: elapsed),
              const SizedBox(height: 32),
              const BackButtonToClock(),
            ],
          ),
        ),
      ),
    );
  }
}
