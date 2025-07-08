import 'package:flutter/material.dart';

import 'feature/prime/presentation/pages/clock_screen.dart';

class Routes {
  Routes._();

  static const String clockScreen = '/clock';

  static final routes = <String, WidgetBuilder>{
    clockScreen: (BuildContext context) => const ClockScreen(),
  };
}
