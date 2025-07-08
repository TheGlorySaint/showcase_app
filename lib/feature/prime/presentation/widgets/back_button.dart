import 'package:flutter/material.dart';

import '../pages/pages_barrel.dart';

class BackButtonToClock extends StatelessWidget {
  const BackButtonToClock({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ClockScreen()),
        );
      },
      child: const Text('Back to Clock'),
    );
  }
}
