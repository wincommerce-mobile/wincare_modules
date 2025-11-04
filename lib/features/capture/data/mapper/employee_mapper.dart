import '../../domain/entities/employee/banner_entity.dart';
import '../../domain/entities/employee/employee_overview_entity.dart';
import '../response/employee/employee_overview_response.dart';

extension EmployeeMapper on EmployeeOverviewResponse {
  EmployeeOverviewEntity toEntity() {
    return EmployeeOverviewEntity(
      employeeCode: employeeCode ?? '',
      banners: banners == null
          ? []
          : banners!.map((e) => BannerEntity(url: e.url ?? '')).toList(),
    );
  }
}
