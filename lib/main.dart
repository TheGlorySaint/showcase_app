import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/prime/presentation/cubit/prime_cubit.dart';
import 'feature/prime/presentation/pages/clock_screen.dart';
import 'injection.dart';
import 'routes.dart';
import 'util/barrel_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await configureInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => getIt<PrimeCubit>()),
      ],
      child: MaterialApp(routes: Routes.routes, home: ClockScreen()),
    );
  }
}
