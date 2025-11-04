import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_image_template_use_case.dart';
import 'package:wincare_modules/features/capture/domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import '../di/modules.dart';
import '../domain/usecases/get_employee_overview_use_case.dart';
import 'capture_controller.dart';

class CaptureBinding extends Bindings
    with ConfigModule, ClientModule, DatasourceModule, RepositoryModule {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CaptureController(
        getEmployeeOverviewUseCase: GetEmployeeOverviewUseCase(
          repository: employeeRepository,
        ),
        getImageTemplateUseCase: GetImageTemplateUseCase(
          repository: captureRepository,
        ),
        getPromotionAivComplaintReasonUseCase:
            GetPromotionAivComplaintReasonUseCase(
              repository: captureRepository,
            ),
      ),
    );
  }
}
