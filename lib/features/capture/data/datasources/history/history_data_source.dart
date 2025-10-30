import 'package:wincare_modules/features/capture/data/request/capture_history_request.dart';
import 'package:wincare_modules/features/capture/data/response/history/capture_history_response.dart';

abstract class HistoryDataSource {
  Future<List<CaptureHistoryResponse>?> getCaptureHistories(
    CaptureHistoryRequest request,
  );
}
