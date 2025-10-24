import 'dart:io';
import 'package:dio/dio.dart';

import '../../di/config_module.dart';

class BaseQueryInterceptor extends InterceptorsWrapper with ConfigModule {
  /// Base domain
  String get baseDomain => appConfig.baseDomain;

  /// Dio
  final Dio dio;

  BaseQueryInterceptor({required this.dio});

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return super.onRequest(options.copyWith(baseUrl: baseDomain), handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!err.shouldRetry || err.badRequest) {
      return super.onError(err, handler);
    }
    return super.onError(err, handler);
  }
}

extension on DioException {
  bool get shouldRetry => response?.statusCode == HttpStatus.unauthorized;

  bool get badRequest => response?.statusCode == HttpStatus.badRequest;
}
