import 'package:json_annotation/json_annotation.dart';

part 'employee_overview_response.g.dart';

@JsonSerializable()
class EmployeeOverviewResponse {
  @JsonKey(name: 'EmployeeCode')
  final String? employeeCode;

  EmployeeOverviewResponse({this.employeeCode});

  factory EmployeeOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeOverviewResponseToJson(this);
}
