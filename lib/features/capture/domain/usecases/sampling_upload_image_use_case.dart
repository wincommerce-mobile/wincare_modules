import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../../data/request/sampling_upload_image_request.dart';
import '../entities/base/base_error_entity.dart';

class SamplingUploadImageUseCase {
  final CaptureRepository repository;

  SamplingUploadImageUseCase({required this.repository});

  Future<BaseCreatedEntity> call(SamplingUploadImageRequest request) async {
    try {
      return await repository.samplingOutletUploadImage(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
