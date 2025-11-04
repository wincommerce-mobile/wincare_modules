import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../../data/request/sampling_confirm_garniture_request.dart';
import '../entities/base/base_error_entity.dart';

class SamplingConfirmImageUseCase {
  final CaptureRepository repository;

  SamplingConfirmImageUseCase({required this.repository});

  Future<BaseCreatedEntity> call(
    SamplingConfirmGarnitureRequest request,
  ) async {
    try {
      return await repository.samplingOutletConfirmImageGarniture(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
