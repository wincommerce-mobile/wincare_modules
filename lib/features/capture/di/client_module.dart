

import '../api/api_client.dart';
import '../api/api_client_type.dart';

mixin ClientModule {
  /// Base API/REST Client
  APIClientType get apiClient {
    return APIClient.apiClient();
  }
}