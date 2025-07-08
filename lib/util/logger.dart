import 'dart:developer';

DateTime get _now => DateTime.now();

logger({required String message}) => log(message, name: '$_now');
