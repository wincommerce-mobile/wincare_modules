import '../../data/request/capture_request.dart';
import '../entities/capture/capture_entity.dart';

abstract class CaptureRepository {
  Future<CaptureEntity> captureResult(CaptureRequest request);
}
