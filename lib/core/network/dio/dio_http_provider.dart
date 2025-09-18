import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:geny_test/core/network/interceptors/auth_interceptor.dart';
import 'package:geny_test/core/network/interceptors/cancel_interceptor.dart';
import 'package:geny_test/core/network/interceptors/error_interceptor.dart';
import 'package:geny_test/core/network/interceptors/logging_interceptor.dart';

abstract class DioHttpProvider {
  DioHttpProvider({
    required this.baseUrl,
  }) {
    _dio = Dio(_createBaseOptions(baseUrl));

    _dio.interceptors.addAll(
      [
        LoggyDioInterceptor(),
        LoggingInterceptor(),
        AuthInterceptor(
          dio: _dio,
          accessTokenRepo: () async {
            return 'new-access-token';
          },
        ),
        ErrorInterceptor(),
        CancelInterceptor(CancelToken()),
        //  RetryInterceptor(dio: _dio),
      ],
    );
  }

  late final Dio _dio;
  final String baseUrl;

  Future<Response<List<dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.post(
      path,
      queryParameters: queryParameters,
    );
  }

  static BaseOptions _createBaseOptions(String baseUrl) => BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: const Duration(seconds: 15000),
        sendTimeout: const Duration(seconds: 15000),
        connectTimeout: const Duration(seconds: 5000),
        headers: {'Content-Type': 'application/json'},
      );
}
