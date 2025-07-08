import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_settings.dart'; // for kApiUrl
import '../../util/logger.dart';

@module
abstract class InjectionModule {
  @singleton
  Dio get dioClient {
    logger(message: 'Creating Dio instance');
    final options = BaseOptions(
      baseUrl: kApiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    return Dio(options);
  }

  @preResolve
  Future<SharedPreferences> get prefs {
    logger(message: 'SharedPreferences - get instance');
    return SharedPreferences.getInstance();
  }
}
