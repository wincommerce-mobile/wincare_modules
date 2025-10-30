import 'package:dio/dio.dart';


import '../../../api/api_client_type.dart';
import '../../../api/base/base_error_response.dart';
import '../../../api/global_request_builder.dart';
import '../../request/employee_overview_request.dart';
import '../../response/employee/employee_overview_response.dart';
import 'employee_data_source.dart';

class EmployeeDataSourceImpl implements EmployeeDataSource {
  EmployeeDataSourceImpl({required this.apiClient});

  final APIClientType apiClient;

  @override
  Future<EmployeeOverviewResponse?> getEmployeeOverview(
    EmployeeOverviewRequest request,
  ) async {
    final req = await GlobalRequestBuilder.build<EmployeeOverviewRequest>(
      request,
    );
    final jsonBody = req.toJson((p) => p?.toJson() ?? {});
    try {
      final response = await apiClient.getEmployeeOverview(jsonBody);
      if (response.data != null) {
        return response.data;
      }

      throw BaseErrorResponse.fromApiException(
        response.errorMessage,
        response.statusCode,
      );
    } on DioException catch (error) {
      throw BaseErrorResponse.fromDioException(error);
    }
  }
}
