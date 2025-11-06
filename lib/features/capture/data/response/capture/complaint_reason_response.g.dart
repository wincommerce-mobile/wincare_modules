// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintReasonResponse _$ComplaintReasonResponseFromJson(
  Map<String, dynamic> json,
) => ComplaintReasonResponse(
  id: (json['Id'] as num?)?.toInt(),
  reason: json['Reason'] as String?,
  createdAt: json['CreatedAt'] as String?,
  createdByName: json['CreatedByName'] as String?,
  createdBy: (json['CreatedBy'] as num?)?.toInt(),
  updatedAt: json['UpdatedAt'] as String?,
  updatedByName: json['UpdatedByName'] as String?,
  updatedBy: (json['UpdatedBy'] as num?)?.toInt(),
);

Map<String, dynamic> _$ComplaintReasonResponseToJson(
  ComplaintReasonResponse instance,
) => <String, dynamic>{
  'Id': instance.id,
  'Reason': instance.reason,
  'CreatedAt': instance.createdAt,
  'CreatedByName': instance.createdByName,
  'CreatedBy': instance.createdBy,
  'UpdatedAt': instance.updatedAt,
  'UpdatedByName': instance.updatedByName,
  'UpdatedBy': instance.updatedBy,
};
