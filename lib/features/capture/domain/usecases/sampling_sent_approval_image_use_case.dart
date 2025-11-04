import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../../data/request/sampling_sent_approval_garniture_request.dart';
import '../entities/base/base_error_entity.dart';

class SamplingSentApprovalImageUseCase {
  final CaptureRepository repository;

  SamplingSentApprovalImageUseCase({required this.repository});

  Future<BaseCreatedEntity> call(
    SamplingSentApprovalGarnitureRequest request,
  ) async {
    try {
      return await repository.samplingOutletSentApprovalImageGarniture(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
