import 'package:dio/dio.dart';

import 'api_client_type.dart';
import 'interceptor/base_query_interceptor.dart';
import 'interceptor/curl_log.dart';

class APIClient {
  static APIClientType apiClient() {
    final dio = Dio();
    dio.interceptors.add(CurlLogInterceptor());
    dio.interceptors.add(BaseQueryInterceptor(dio: dio));
    return APIClientType(dio, baseUrl: '');
  }
}
