import '../../../../app/app_secure_storage.dart';
import '../../data/request/employee_overview_request.dart';
import '../entities/base/base_error_entity.dart';
import '../entities/employee/employee_overview_entity.dart';
import '../repositories/employee_repository.dart';

class GetEmployeeOverviewUseCase {
  final EmployeeRepository repository;

  GetEmployeeOverviewUseCase({required this.repository});

  Future<EmployeeOverviewEntity> call(EmployeeOverviewRequest request) async {
    try {
      return await repository.getEmployeeOverview(request);
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        /// Sign out
        await AppSecureStorage.clearUser();
      }
      throw error.message ?? '';
    }
  }
}
