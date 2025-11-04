import 'package:dio/dio.dart';
import 'package:wincare_modules/features/capture/data/request/image_garniture_history_request.dart';

import '../../../api/api_client_type.dart';
import '../../../api/base/base_error_response.dart';
import '../../../api/global_request_builder.dart';
import '../../response/history/image_garniture_history_response.dart';
import 'history_data_source.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  HistoryDataSourceImpl({required this.apiClient});

  final APIClientType apiClient;

  @override
  Future<List<ImageGarnitureHistoryResponse>?>
  samplingOutletHistoryImageGarniture(
    ImageGarnitureHistoryRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<ImageGarnitureHistoryRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.samplingOutletHistoryImageGarniture(
        jsonBody,
      );
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }
}
