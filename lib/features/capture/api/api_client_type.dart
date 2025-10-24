import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

import '../data/response/employee_overview_response.dart';
import 'base/base_response.dart';

part 'api_client_type.g.dart';

@retrofit.RestApi()
abstract class APIClientType {
  factory APIClientType(Dio dio, {String baseUrl}) = _APIClientType;

  @retrofit.POST('/api/MobileEmployee/GetEmployeeOverview')
  Future<BaseResponse<EmployeeOverviewResponse>> getEmployeeOverview(
    @retrofit.Body() Map<String, dynamic> body,
  );
}
