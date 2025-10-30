import '../data/datasources/employee/employee_data_source.dart';
import '../data/datasources/employee/employee_data_source_impl.dart';
import 'client_module.dart';

mixin DatasourceModule on ClientModule {
  /// EmployeeDataSource
  EmployeeDataSource get employeeDataSource {
    return EmployeeDataSourceImpl(apiClient: apiClient);
  }
}
