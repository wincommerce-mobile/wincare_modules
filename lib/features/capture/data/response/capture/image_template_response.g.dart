// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_template_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageTemplateResponse _$ImageTemplateResponseFromJson(
  Map<String, dynamic> json,
) => ImageTemplateResponse(
  imageGarnitureId: json['ImageGarnitureId'] as String?,
  planogramId: (json['PlanogramId'] as num?)?.toInt(),
  planogramCode: json['PlanogramCode'] as String?,
  promotionCode: json['PromotionCode'] as String?,
  imageTemplate: json['ImageTemplate'] as String?,
  zoneName: json['ZoneName'] as String?,
  level: (json['Level'] as num?)?.toInt(),
  type: json['Type'] as String?,
);

Map<String, dynamic> _$ImageTemplateResponseToJson(
  ImageTemplateResponse instance,
) => <String, dynamic>{
  'ImageGarnitureId': instance.imageGarnitureId,
  'PlanogramId': instance.planogramId,
  'PlanogramCode': instance.planogramCode,
  'PromotionCode': instance.promotionCode,
  'ImageTemplate': instance.imageTemplate,
  'ZoneName': instance.zoneName,
  'Level': instance.level,
  'Type': instance.type,
};
