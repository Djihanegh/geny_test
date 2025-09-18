import 'package:dio/dio.dart';

class CancelInterceptor extends Interceptor {
  final CancelToken cancelToken;

  CancelInterceptor(this.cancelToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Attach the cancelToken to every request
    options.cancelToken = cancelToken;
    return handler.next(options);
  }
}
