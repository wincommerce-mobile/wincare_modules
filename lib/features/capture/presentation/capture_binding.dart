import 'package:get/get.dart';
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
      ),
    );
  }
}
