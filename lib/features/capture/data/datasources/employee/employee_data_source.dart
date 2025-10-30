
import '../../request/employee_overview_request.dart';
import '../../response/employee/employee_overview_response.dart';

abstract class EmployeeDataSource {
  Future<EmployeeOverviewResponse?> getEmployeeOverview(
    EmployeeOverviewRequest request,
  );
}
