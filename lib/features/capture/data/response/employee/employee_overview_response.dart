import 'package:json_annotation/json_annotation.dart';

import 'banner_response.dart';

part 'employee_overview_response.g.dart';

@JsonSerializable()
class EmployeeOverviewResponse {
  @JsonKey(name: 'EmployeeCode')
  final String? employeeCode;
  @JsonKey(name: 'banners')
  final List<BannerResponse>? banners;

  EmployeeOverviewResponse({this.employeeCode, this.banners});

  factory EmployeeOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeOverviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeOverviewResponseToJson(this);
}
