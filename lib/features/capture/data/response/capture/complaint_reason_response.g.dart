// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintReasonResponse _$ComplaintReasonResponseFromJson(
  Map<String, dynamic> json,
) => ComplaintReasonResponse(
  id: (json['id'] as num?)?.toInt(),
  reason: json['reason'] as String?,
  createdAt: json['createdAt'] as String?,
  createdByName: json['createdByName'] as String?,
  createdBy: (json['createdBy'] as num?)?.toInt(),
  updatedAt: json['updatedAt'] as String?,
  updatedByName: json['updatedByName'] as String?,
  updatedBy: (json['updatedBy'] as num?)?.toInt(),
);

Map<String, dynamic> _$ComplaintReasonResponseToJson(
  ComplaintReasonResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'reason': instance.reason,
  'createdAt': instance.createdAt,
  'createdByName': instance.createdByName,
  'createdBy': instance.createdBy,
  'updatedAt': instance.updatedAt,
  'updatedByName': instance.updatedByName,
  'updatedBy': instance.updatedBy,
};
