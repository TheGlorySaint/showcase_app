import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    logger(
      message: 'onCreate -- ${bloc.runtimeType} -- ${bloc.state.runtimeType}',
    );
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    logger(
      message:
          'onChange -- ${bloc.runtimeType} -- ${bloc.state.runtimeType} -> ${change.nextState.runtimeType}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger(
      message: 'onError -- ${bloc.runtimeType} -- ${bloc.runtimeType}, $error',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger(message: 'onClose -- ${bloc.runtimeType} -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
