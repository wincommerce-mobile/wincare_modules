import 'package:wincare_modules/features/capture/data/request/complaint_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../entities/base/base_error_entity.dart';

class PromotionAivComplaintUseCase {
  final CaptureRepository repository;

  PromotionAivComplaintUseCase({required this.repository});

  Future<BaseCreatedEntity> call(ComplaintRequest request) async {
    try {
      return await repository.promotionAIVComplaint(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
