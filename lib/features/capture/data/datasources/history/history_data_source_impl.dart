import 'package:wincare_modules/features/capture/data/request/capture_history_request.dart';

import 'package:wincare_modules/features/capture/data/response/history/capture_history_response.dart';

import 'history_data_source.dart';

class HistoryDataSourceImpl implements HistoryDataSource {
  @override
  Future<List<CaptureHistoryResponse>?> getCaptureHistories(
    CaptureHistoryRequest request,
  ) async {
    // TODO: implement getCaptureHistories
    throw UnimplementedError();
  }
}
