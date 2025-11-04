import '../../data/request/result_image_garniture_request.dart';
import '../entities/base/base_error_entity.dart';
import '../entities/capture/result_image_garniture_entity.dart';
import '../repositories/capture_repository.dart';

class SamplingResultImageGarniture {
  final CaptureRepository repository;

  SamplingResultImageGarniture({required this.repository});

  Future<ResultImageGarnitureEntity> call(
    ResultImageGarnitureRequest request,
  ) async {
    try {
      return await repository.samplingOutletResultImageGarniture(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
