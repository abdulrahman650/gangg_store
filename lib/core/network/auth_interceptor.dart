import 'dart:developer';

import 'package:dio/dio.dart';

import '../services/cache_helper.dart';
import '../services/cache_keys.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final token = CacheHelper.getData(
      CacheKeys.accessToken,
    );

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Fix: Remove Content-Type for GET requests
    if (options.method == 'GET') {
      options.headers.remove('Content-Type');
    }

    log('REQUEST => ${options.method}');
    log('URL => ${options.uri}');
    log('HEADERS => ${options.headers}');
    log('QUERY => ${options.queryParameters}');
    log('BODY => ${options.data}');

    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    log('STATUS => ${response.statusCode}');
    log('RESPONSE => ${response.data}');

    handler.next(response);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    log('ERROR STATUS => ${err.response?.statusCode}');
    log('ERROR MESSAGE => ${err.message}');
    log('ERROR DATA => ${err.response?.data}');

    handler.next(err);
  }
}