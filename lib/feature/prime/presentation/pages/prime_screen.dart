import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation_barrel.dart';

class PrimeScreen extends StatelessWidget {
  const PrimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrimeCubit, PrimeState>(
      listener: (context, state) {
        switch (state) {
          case Loaded(numberResponse: final n, prime: final p) when n != p:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ClockScreen()),
            );
          default:
            break;
        }
      },
      child: BlocBuilder<PrimeCubit, PrimeState>(
        builder: (context, state) {
          return switch (state) {
            Loaded(numberResponse: final n, prime: final p, elapsed: final e)
                when n == p && p != null =>
              PrimeContent(prime: p, elapsed: e),

            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
