import 'package:wincare_modules/features/capture/data/request/capture_request.dart';
import 'package:wincare_modules/features/capture/data/response/capture/capture_response.dart';

abstract class CaptureDataSource {
  Future<CaptureResponse> captureResult(CaptureRequest request);
}
