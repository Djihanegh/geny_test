import 'package:dio/dio.dart';
import 'package:geny_test/core/logger/logger.dart';

enum AppException {
  noInternet,
  noLocalData,
  // Dio errors
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  // Other
  unknown,
  ;

  const AppException();

  factory AppException.createAndLog(String tag, dynamic e, StackTrace? s) {
    final appException = AppException._create(e);

    if (appException == unknown) {
      // Log unknown exceptions
      logError('[$tag] unknown error', e, s);
    } else {
      logInfo('[$tag] $appException');
    }

    return appException;
  }

  factory AppException._create(dynamic e) {
    if (e is AppException) {
      return e;
    }

    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return AppException.connectionTimeout;
        case DioExceptionType.sendTimeout:
          return AppException.sendTimeout;
        case DioExceptionType.receiveTimeout:
          return AppException.receiveTimeout;
        case DioExceptionType.badCertificate:
          return AppException.badCertificate;
        case DioExceptionType.badResponse:
          return AppException.badResponse;
        case DioExceptionType.cancel:
          return AppException.cancel;
        case DioExceptionType.connectionError:
          return AppException.connectionError;
        case DioExceptionType.unknown:
          return AppException.unknown;
      }
    }

    return unknown;
  }

  String getText() => switch (this) {
        AppException.noInternet => 'No network connection',
        AppException.noLocalData => 'No Businesses available',
        AppException.connectionTimeout => 'Connection timed out',
        AppException.sendTimeout => 'Request timed out while sending',
        AppException.receiveTimeout => 'Response timed out',
        AppException.badCertificate => 'Invalid SSL certificate',
        AppException.badResponse => 'Server responded with an error',
        AppException.cancel => 'Request was cancelled',
        AppException.connectionError => 'Failed to connect to server',
        AppException.unknown => 'Unknown error occurred',
      };
}
