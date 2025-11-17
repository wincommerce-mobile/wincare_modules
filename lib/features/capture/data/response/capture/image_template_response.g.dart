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
  collageImageToolTip: json['CollageImageToolTip'] as String?,
  level: (json['Level'] as num?)?.toInt(),
  isConfirmed: json['IsConfirmed'] as bool?,
  type: json['Type'] as String?,
  resultImageGarniture: json['ComplianceResult'] == null
      ? null
      : ResultImageGarnitureResponse.fromJson(
          json['ComplianceResult'] as Map<String, dynamic>,
        ),
  images: (json['Images'] as List<dynamic>?)
      ?.map((e) => ImageResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
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
  'CollageImageToolTip': instance.collageImageToolTip,
  'Level': instance.level,
  'IsConfirmed': instance.isConfirmed,
  'Type': instance.type,
  'ComplianceResult': instance.resultImageGarniture,
  'Images': instance.images,
};
