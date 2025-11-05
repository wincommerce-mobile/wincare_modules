import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_image_template_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_result_image_garniture.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_sent_approval_image_use_case.dart';
import '../di/modules.dart';
import '../domain/usecases/promotion_aiv_complaint_use_case.dart';
import '../domain/usecases/sampling_cancel_image_use_case.dart';
import '../domain/usecases/sampling_confirm_image_use_case.dart';
import '../domain/usecases/sampling_upload_image_use_case.dart';
import 'capture_controller.dart';

class CaptureBinding extends Bindings
    with ConfigModule, ClientModule, DatasourceModule, RepositoryModule {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CaptureController(
        getImageTemplateUseCase: GetImageTemplateUseCase(
          repository: captureRepository,
        ),
        getPromotionAivComplaintReasonUseCase:
            GetPromotionAivComplaintReasonUseCase(
              repository: captureRepository,
            ),
        samplingUploadImageUseCase: SamplingUploadImageUseCase(
          repository: captureRepository,
        ),
        samplingCancelImageUseCase: SamplingCancelImageUseCase(
          repository: captureRepository,
        ),
        samplingConfirmImageUseCase: SamplingConfirmImageUseCase(
          repository: captureRepository,
        ),
        promotionAivComplaintUseCase: PromotionAivComplaintUseCase(
          repository: captureRepository,
        ),
        samplingResultImageGarniture: SamplingResultImageGarniture(
          repository: captureRepository,
        ),
        samplingSentApprovalImageUseCase: SamplingSentApprovalImageUseCase(
          repository: captureRepository,
        ),
      ),
    );
  }
}
