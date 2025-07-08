import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/date_helper.dart';
import '../presentation_barrel.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateHelper = DateHelper();

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<PrimeCubit, PrimeState>(
        listener: (context, state) {
          switch (state) {
            case Loaded(numberResponse: final n, prime: final p)
                when n == p && n != null:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const PrimeScreen()),
              );
            default:
              break;
          }
        },
        child: Center(child: DateTimeDisplay(helper: dateHelper)),
      ),
    );
  }
}
