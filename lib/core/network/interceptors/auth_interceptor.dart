// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';

import 'package:dio/dio.dart';

typedef AccessTokenRepo = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AccessTokenRepo? accessTokenRepo;

  String? _accessToken;

  AuthInterceptor({required this.dio, this.accessTokenRepo});

  static const String _authorizationHeader = 'Authorization';
  static const Duration _retryDelay = Duration(seconds: 2);

  bool get isAccessTokenExpired {
    //  Replace with real expiry logic if you have JWT or expiry timestamp
    return _accessToken == null || _accessToken!.isEmpty;
  }

  void saveAccessToken(String? token) {
    _accessToken = token;
  }

  String _authorizationHeaderValue(String? token) => 'Bearer $token';

  void _updateHeader(String key, String value) {
    dio.options.headers[key] = value;
  }

  Future<Response<dynamic>> _sendRequest(RequestOptions requestOptions) async {
    // clone request
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
      contentType: requestOptions.contentType,
      followRedirects: requestOptions.followRedirects,
      validateStatus: requestOptions.validateStatus,
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
      cancelToken: requestOptions.cancelToken,
      onSendProgress: requestOptions.onSendProgress,
      onReceiveProgress: requestOptions.onReceiveProgress,
    );
  }

  bool shouldRetry(DioException err) {
    // Retry only network-related or timeout errors (not auth errors)
    return err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout || err.type == DioExceptionType.sendTimeout || err.type == DioExceptionType.connectionError;
  }

  // --- Interceptor overrides ---

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isAccessTokenExpired) {
      try {
        final newAccessToken = await accessTokenRepo?.call();
        if (newAccessToken != null) {
          options.headers[_authorizationHeader] = _authorizationHeaderValue(newAccessToken);
          saveAccessToken(newAccessToken);
        }
      } catch (error) {
        saveAccessToken(null);
        return handler.reject(
          DioException(requestOptions: options, error: error),
        );
      }
    } else if (_accessToken != null) {
      // add current token if still valid
      options.headers[_authorizationHeader] = _authorizationHeaderValue(_accessToken);
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && _accessToken != null) {
      // token might have just expired, refresh
      try {
        ///   Refresh Token From Repository
        final newAccessToken = await accessTokenRepo?.call();
        if (newAccessToken != null) {
          saveAccessToken(newAccessToken);
          _updateHeader(
            _authorizationHeader,
            _authorizationHeaderValue(newAccessToken),
          );

          // retry original request with new token
          final retryResponse = await _sendRequest(err.requestOptions);
          return handler.resolve(retryResponse);
        }
      } catch (_) {
        saveAccessToken(null);
      }
    }

    try {
      if (shouldRetry(err)) {
        await Future.delayed(_retryDelay);

        final retryResponse = await _sendRequest(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    } catch (_) {}

    return handler.next(err);
  }
}
