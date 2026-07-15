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
    log(options.path);
    if (!options.path.contains('/auth/login') &&
        !options.path.contains('/auth/register') &&
        !options.path.contains('/auth/forgot-password') &&
        !options.path.contains('/auth/reset-password') &&
        !options.path.contains('/auth/validate-otp') &&
        !options.path.contains('/auth/resend-otp') &&
        !options.path.contains('/auth/verify-email') &&
        !options.path.contains('/auth/refresh-token')) {

      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
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