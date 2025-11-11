import 'package:wincare_modules/features/capture/data/request/image_template_request.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/complaint_reason_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/image_template_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/result_image_garniture_entity.dart';

import '../../data/request/complaint_reason_request.dart';
import '../../data/request/complaint_request.dart';
import '../../data/request/result_image_garniture_request.dart';
import '../../data/request/sampling_confirm_garniture_request.dart';
import '../../data/request/sampling_sent_approval_garniture_request.dart';
import '../../data/request/sampling_upload_image_request.dart';

abstract class CaptureRepository {
  Future<ResultImageGarnitureEntity> samplingOutletResultImageGarniture(
    ResultImageGarnitureRequest request,
  );

  Future<List<ImageTemplateEntity>> getImageTemplateGarniture(
    ImageTemplateRequest request,
  );

  Future<BaseCreatedEntity> samplingOutletUploadImage(
    SamplingUploadImageRequest request,
  );

  Future<BaseCreatedEntity> samplingOutletCancelImage(
    SamplingUploadImageRequest request,
  );

  Future<ResultImageGarnitureEntity> samplingOutletSentApprovalImageGarniture(
    SamplingSentApprovalGarnitureRequest request,
  );

  Future<BaseCreatedEntity> samplingOutletConfirmImageGarniture(
    SamplingConfirmGarnitureRequest request,
  );

  Future<BaseCreatedEntity> promotionAIVComplaint(ComplaintRequest request);

  Future<List<ComplaintReasonEntity>> getPromotionAIVComplaintReason(
    ComplaintReasonRequest request,
  );
}
