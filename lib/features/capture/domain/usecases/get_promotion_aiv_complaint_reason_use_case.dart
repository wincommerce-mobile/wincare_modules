import 'package:wincare_modules/features/capture/data/request/complaint_reason_request.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';

import '../entities/base/base_error_entity.dart';
import '../entities/capture/complaint_reason_entity.dart';

class GetPromotionAivComplaintReasonUseCase {
  final CaptureRepository repository;

  GetPromotionAivComplaintReasonUseCase({required this.repository});

  Future<List<ComplaintReasonEntity>> call(
    ComplaintReasonRequest request,
  ) async {
    try {
      return await repository.getPromotionAIVComplaintReason(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
