import '../../domain/entities/employee/banner_entity.dart';
import '../../domain/entities/employee/employee_overview_entity.dart';
import '../response/employee/employee_overview_response.dart';

class EmployeeMapper {
  static EmployeeOverviewEntity toEmployeeOverviewEntity(
    EmployeeOverviewResponse response,
  ) {
    return EmployeeOverviewEntity(
      employeeCode: response.employeeCode ?? '',
      banners: response.banners == null
          ? []
          : response.banners!
                .map((e) => BannerEntity(url: e.url ?? ''))
                .toList(),
    );
  }
}
