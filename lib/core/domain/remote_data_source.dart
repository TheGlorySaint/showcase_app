import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../util/logger.dart';

abstract class RemoteDatasource {
  /// Dispatches a HTTP GET request.
  ///
  /// Throws [DioException] if status code is other than 200.
  Future<dynamic> getApiEndpoint(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool removeCookie = false,
  });
}

@LazySingleton(as: RemoteDatasource)
class RemoteDatasourceImpl implements RemoteDatasource {
  RemoteDatasourceImpl(this.dioClient);
  final Dio dioClient;
  final Map<String, String> _cookieMap = {};

  @override
  Future<dynamic> getApiEndpoint(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool removeCookie = false,
  }) async => _startRequest(
    'GET',
    url,
    headers: headers,
    queryParameters: queryParameters,
    removeCookie: removeCookie,
  );

  Future _startRequest(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool removeCookie = false,
    bool returnHeaders = false,
    String? requestContentType,
  }) async {
    try {
      final uri = Uri.parse(url);
      if (removeCookie) {
        _removeCookie(uri);
      }
      final mergedHeaders = _getHeaderWithCookiesAndMerge(
        uri,
        headers: headers,
      );
      final options = Options(
        headers: mergedHeaders,
        method: method,
        contentType: requestContentType,
      );
      final response = await dioClient.request<dynamic>(
        url,
        data: data,
        options: options,
        queryParameters: queryParameters,
      );
      _setCookieFromHeaders(uri, response.headers);

      if (returnHeaders) {
        return response.headers;
      } else {
        return response.data;
      }
    } on DioException catch (exception, stack) {
      logger(message: 'DioException: ${exception.message}, Stack $stack');
      rethrow;
    }
  }

  Map<String, dynamic> _getHeaderWithCookiesAndMerge(
    Uri uri, {
    Map<String, dynamic>? headers,
  }) {
    String? cookie;

    cookie = _cookieMap[uri.host];
    final cookieHeader = <String, dynamic>{};
    if (cookie != null) cookieHeader['Cookie'] = cookie;

    if (headers == null) return cookieHeader;

    final mergedMap = <String, dynamic>{}
      ..addAll(cookieHeader)
      ..addAll(headers);

    return mergedMap;
  }

  void _setCookieFromHeaders(Uri uri, Headers headers) {
    final rawCookie = headers['set-cookie'];
    if (rawCookie != null) {
      final cookie = rawCookie.first;
      _cookieMap[uri.host] = cookie;
    }
  }

  void _removeCookie(Uri uri) {
    _cookieMap.remove(uri.host);
  }
}
