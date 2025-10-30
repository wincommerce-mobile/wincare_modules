import '../../data/request/employee_overview_request.dart';
import '../entities/employee/employee_overview_entity.dart';

abstract class EmployeeRepository {
  Future<EmployeeOverviewEntity> getEmployeeOverview(
    EmployeeOverviewRequest request,
  );
}
