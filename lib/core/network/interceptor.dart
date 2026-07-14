import 'dart:developer';

import 'package:dio/dio.dart';

import '../services/cache_helper.dart';
import '../services/cache_keys.dart';



class AuthInterceptor extends Interceptor {
  @override
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final token = CacheHelper.getData(CacheKeys.accessToken);

    final path = options.path;

    if (!path.endsWith('auth/login') &&
        !path.endsWith('auth/register') &&
        !path.endsWith('auth/forgot-password') &&
        !path.endsWith('auth/reset-password') &&
        !path.endsWith('auth/validate-otp') &&
        !path.endsWith('auth/resend-otp') &&
        !path.endsWith('auth/verify-email') &&
        !path.endsWith('auth/refresh-token')) {
      if (token != null && token.toString().isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    log('REQUEST => ${options.method}');
    log('URL => ${options.uri}');
    log('HEADERS => ${options.headers}');
    log('QUERY => ${options.queryParameters}');
    log('BODY => ${options.data}');

    handler.next(options);
  }
  // void onRequest(
  //     RequestOptions options,
  //     RequestInterceptorHandler handler,
  //     ) {
  //   final token = CacheHelper.getData(
  //     CacheKeys.accessToken,
  //   );
  //
  //   if (token != null) {
  //     options.headers['Authorization'] = 'Bearer $token';
  //   }
  //
  //   log('REQUEST => ${options.method}');
  //   log('URL => ${options.uri}');
  //   log('HEADERS => ${options.headers}');
  //   log('QUERY => ${options.queryParameters}');
  //   log('BODY => ${options.data}');
  //
  //   handler.next(options);
  // }
  //
  // @override
  // void onResponse(
  //     Response response,
  //     ResponseInterceptorHandler handler,
  //     ) {
  //   log('STATUS => ${response.statusCode}');
  //   log('RESPONSE => ${response.data}');
  //
  //   handler.next(response);
  // }
  //
  // @override
  // void onError(
  //     DioException err,
  //     ErrorInterceptorHandler handler,
  //     ) {
  //   log('ERROR => ${err.message}');
  //
  //   handler.next(err);
  // }
}