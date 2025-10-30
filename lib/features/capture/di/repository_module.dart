import '../data/repositories/employee_repository_impl.dart';
import '../domain/repositories/employee_repository.dart';
import 'datasource_module.dart';

mixin RepositoryModule on DatasourceModule {
  /// EmployeeRepository
  EmployeeRepository get employeeRepository {
    return EmployeeRepositoryImpl(employeeDataSource: employeeDataSource);
  }
}
