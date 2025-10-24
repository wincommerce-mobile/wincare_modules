import 'package:dio/dio.dart';

class BaseErrorResponse {
  BaseErrorResponse({
    required this.statusCode,
    required this.statusMessage,
    this.errorCode,
  });

  /// The HTTP status code for the response.
  ///
  /// This can be null if the response was constructed manually.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  String? statusMessage;

  /// Error code
  String? errorCode;

  factory BaseErrorResponse.unknownError() =>
      BaseErrorResponse(statusCode: 400, statusMessage: 'Unknown Error');

  factory BaseErrorResponse.fromDioException(DioException exception) {
    try {
      Map<String, dynamic> error = exception.response?.data;
      final message = error['jlMessageFormat'];
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: message ?? 'Unknown Error',
      );
    } catch (e) {
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: exception.response?.statusMessage ?? 'Unknown Error',
      );
    }
  }

  factory BaseErrorResponse.fromApiException(
    String? errorMessage,
    int? statusCode,
  ) {
    try {
      return BaseErrorResponse(
        statusCode: statusCode ?? 400,
        statusMessage: errorMessage ?? 'Unknown Error',
      );
    } catch (e) {
      return BaseErrorResponse(
        statusCode: statusCode ?? 400,
        statusMessage: errorMessage ?? 'Unknown Error',
      );
    }
  }

  factory BaseErrorResponse.handleErrorResponse(DioException exception) {
    try {
      Map<String, dynamic> error = exception.response?.data;
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: error['error'] ?? 'Unknown Error',
        errorCode: error['errorCode'] ?? '',
      );
    } catch (e) {
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: exception.response?.statusMessage ?? 'Unknown Error',
      );
    }
  }
}
