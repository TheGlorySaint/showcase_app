import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../api_settings.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio() {
    final options = BaseOptions(
      baseUrl: kApiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    return Dio(options);
  }
}
