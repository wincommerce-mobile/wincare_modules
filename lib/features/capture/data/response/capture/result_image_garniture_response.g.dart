// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_image_garniture_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultImageGarnitureResponse _$ResultImageGarnitureResponseFromJson(
  Map<String, dynamic> json,
) => ResultImageGarnitureResponse(
  complianceStatusId: (json['ComplianceStatusId'] as num?)?.toInt(),
  complianceStatus: json['ComplianceStatus'] as String?,
  complianceSummary: json['ComplianceSummary'] as String?,
  createdByName: json['CreatedByName'] as String?,
  createdDate: json['CreatedDate'] as String?,
);

Map<String, dynamic> _$ResultImageGarnitureResponseToJson(
  ResultImageGarnitureResponse instance,
) => <String, dynamic>{
  'ComplianceStatusId': instance.complianceStatusId,
  'ComplianceStatus': instance.complianceStatus,
  'ComplianceSummary': instance.complianceSummary,
  'CreatedByName': instance.createdByName,
  'CreatedDate': instance.createdDate,
};
