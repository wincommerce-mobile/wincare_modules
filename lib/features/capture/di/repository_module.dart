import 'package:wincare_modules/features/capture/data/repositories/capture_repository_impl.dart';
import 'package:wincare_modules/features/capture/data/repositories/history_repository_impl.dart';
import 'package:wincare_modules/features/capture/domain/repositories/capture_repository.dart';
import 'package:wincare_modules/features/capture/domain/repositories/history_repository.dart';

import '../data/repositories/employee_repository_impl.dart';
import '../domain/repositories/employee_repository.dart';
import 'datasource_module.dart';

mixin RepositoryModule on DatasourceModule {
  /// EmployeeRepository
  EmployeeRepository get employeeRepository {
    return EmployeeRepositoryImpl(employeeDataSource: employeeDataSource);
  }

  /// CaptureRepository
  CaptureRepository get captureRepository {
    return CaptureRepositoryImpl(captureDataSource: captureDataSource);
  }

  /// History
  HistoryRepository get historyRepository {
    return HistoryRepositoryImpl(historyDataSource: historyDataSource);
  }
}
