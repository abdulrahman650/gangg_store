import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'api_consumer.dart';
import 'api_endpoints.dart';
import 'auth_interceptor.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        // شيلت Content-Type من هنا عشان GET requests
      },
      validateStatus: (status) => true,
    );
    
    dio.interceptors.add(
      AuthInterceptor(),
    );
  }

  RemoteException _handleDioException(DioException e) {
    if (e.response != null) {
      print('ERROR STATUS: ${e.response?.statusCode}');
      print('ERROR DATA: ${e.response?.data}');
      print('ERROR HEADERS: ${e.response?.headers}');
    }

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
        if (e.response != null &&
            e.response!.data is Map<String, dynamic>) {
          final data = e.response!.data as Map<String, dynamic>;
          return RemoteException(
            data['message'] ?? data['title'] ?? 'Something went wrong',
          );
        }

        return const RemoteException('Something went wrong');
    }
  }

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
        options: Options(
          headers: {
            ...?headers,
            // GET requests: Accept بس، مش Content-Type
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

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
        options: Options(
          headers: {
            ...?headers,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

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
        options: Options(
          headers: {
            ...?headers,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

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
        options: Options(
          headers: {
            ...?headers,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

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
        options: Options(
          headers: {
            ...?headers,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }
}