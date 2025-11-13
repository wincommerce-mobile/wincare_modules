import 'package:wincare_modules/features/capture/data/request/complaint_request.dart';
import 'package:wincare_modules/features/capture/data/response/base_created_response.dart';

import '../../request/complaint_reason_request.dart';
import '../../request/image_template_request.dart';
import '../../request/result_image_garniture_request.dart';
import '../../request/sampling_confirm_garniture_request.dart';
import '../../request/sampling_sent_approval_garniture_request.dart';
import '../../request/sampling_upload_image_request.dart';
import '../../response/capture/complaint_reason_response.dart';
import '../../response/capture/image_template_response.dart';
import '../../response/capture/result_image_garniture_response.dart';

abstract class CaptureDataSource {
  Future<ResultImageGarnitureResponse?> samplingOutletResultImageGarniture(
    ResultImageGarnitureRequest request,
  );

  Future<List<ImageTemplateResponse>?> getImageTemplateGarniture(
    ImageTemplateRequest request,
  );

  Future<BaseCreatedResponse?> samplingOutletUploadImage(
    SamplingUploadImageRequest request,
  );

  Future<BaseCreatedResponse?> samplingOutletCancelImage(
    SamplingUploadImageRequest request,
  );

  Future<BaseCreatedResponse?> samplingOutletSentApprovalImageGarniture(
    SamplingSentApprovalGarnitureRequest request,
  );

  Future<BaseCreatedResponse?> samplingOutletConfirmImageGarniture(
    SamplingConfirmGarnitureRequest request,
  );

  Future<BaseCreatedResponse?> promotionAIVComplaint(ComplaintRequest request);

  Future<List<ComplaintReasonResponse>?> getPromotionAIVComplaintReason(
    ComplaintReasonRequest request,
  );
}
