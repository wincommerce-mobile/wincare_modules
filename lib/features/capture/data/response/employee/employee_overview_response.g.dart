// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeOverviewResponse _$EmployeeOverviewResponseFromJson(
  Map<String, dynamic> json,
) => EmployeeOverviewResponse(
  employeeCode: json['EmployeeCode'] as String?,
  banners: (json['banners'] as List<dynamic>?)
      ?.map((e) => BannerResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EmployeeOverviewResponseToJson(
  EmployeeOverviewResponse instance,
) => <String, dynamic>{
  'EmployeeCode': instance.employeeCode,
  'banners': instance.banners,
};
