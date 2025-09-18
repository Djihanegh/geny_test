// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocation

import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final shouldRetry = _shouldRetry(err);
    final retries = (err.requestOptions.extra['retries'] is int) ? err.requestOptions.extra['retries'] as int : 0;

    if (shouldRetry && retries < maxRetries) {
      final nextRetry = retries + 1;

      // Exponential backoff with jitter
      final delay = baseDelay.inMilliseconds * pow(2, retries);
      final jitter = Random().nextInt(200); // add randomness
      final wait = Duration(milliseconds: delay.toInt() + jitter);

      debugPrint('🔄 Retry $nextRetry/$maxRetries after ${wait.inMilliseconds}ms '
          'for ${err.requestOptions.uri}');

      // update retry count
      err.requestOptions.extra['retries'] = nextRetry;

      // wait before retrying
      await Future.delayed(wait);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(e as DioException);
      }
    }

    // Forward the error if not retried
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    // Retry only on network or timeout issues
    return err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout || err.type == DioExceptionType.sendTimeout;
  }
}
