import 'package:flutter/material.dart';

import '../../../../util/date_helper.dart';

class DateTimeDisplay extends StatelessWidget {
  final DateHelper helper;

  const DateTimeDisplay({required this.helper, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          helper.time,
          style: const TextStyle(
            fontSize: 72,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          helper.date,
          style: const TextStyle(fontSize: 32, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          helper.weekday,
          style: const TextStyle(fontSize: 28, color: Colors.white54),
        ),
      ],
    );
  }
}
