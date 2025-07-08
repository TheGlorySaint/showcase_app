import 'package:flutter/material.dart';

import '../../../../util/barrel_util.dart';

class ElapsedTimeDisplay extends StatelessWidget {
  final Duration elapsed;

  const ElapsedTimeDisplay({required this.elapsed, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time since last prime: ${TimeHelper().formatDuration(elapsed)}',
      style: const TextStyle(fontSize: 20, color: Colors.white60),
    );
  }
}
