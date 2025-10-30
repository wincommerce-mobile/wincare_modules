import '../../../../app/app_connectivity.dart';
import '../../api/base/base_error_response.dart';
import '../../domain/entities/base/base_error_entity.dart';
import '../../domain/entities/employee/employee_overview_entity.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/employee/employee_data_source.dart';
import '../mapper/employee_mapper.dart';
import '../mapper/exception_mapper.dart';
import '../request/employee_overview_request.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeDataSource employeeDataSource;

  EmployeeRepositoryImpl({required this.employeeDataSource});

  @override
  Future<EmployeeOverviewEntity> getEmployeeOverview(
    EmployeeOverviewRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await employeeDataSource.getEmployeeOverview(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = EmployeeMapper.toEmployeeOverviewEntity(response);
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }
}
