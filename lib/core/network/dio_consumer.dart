// core/network/dio_consumer.dart
import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'api_consumer.dart';
import 'api_endpoints.dart';
import 'interceptor.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio.interceptors.add(
      AuthInterceptor(),
    );
  }

///Exception
RemoteException _handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return const RemoteException('Connection timeout');

    case DioExceptionType.sendTimeout:
      return const RemoteException('Send timeout');

    case DioExceptionType.receiveTimeout:
      return const RemoteException('Receive timeout');

    case DioExceptionType.connectionError:
      return const RemoteException('No internet connection');

    default:
      print("========== DIO ERROR ==========");
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");
      print("===============================");

      if (e.response != null) {
        return RemoteException(
          e.response!.data.toString(),
        );
      }

      return RemoteException(
        e.message ?? 'Something went wrong',
      );
  }
}
///get
  @override
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {

  print("========== GET ERROR ==========");
  print(e);
  print(e.response?.statusCode);
  print(e.response?.data);
  print("===============================");

  throw _handleDioException(e);
}
  }

///post
  @override
  Future<dynamic> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

///put
  @override
  Future<dynamic> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

///patch
  @override
  Future<dynamic> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

///delete
  @override
  Future<dynamic> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }
}