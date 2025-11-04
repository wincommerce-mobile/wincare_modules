// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_garniture_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGarnitureHistoryResponse _$ImageGarnitureHistoryResponseFromJson(
  Map<String, dynamic> json,
) => ImageGarnitureHistoryResponse(
  imageGarnitureId: json['ImageGarnitureId'] as String?,
  statusId: (json['StatusId'] as num?)?.toInt(),
  statusName: json['StatusName'] as String?,
  note: json['Note'] as String?,
  createdDate: json['CreatedDate'] as String?,
  createdByName: json['CreatedByName'] as String?,
);

Map<String, dynamic> _$ImageGarnitureHistoryResponseToJson(
  ImageGarnitureHistoryResponse instance,
) => <String, dynamic>{
  'ImageGarnitureId': instance.imageGarnitureId,
  'StatusId': instance.statusId,
  'StatusName': instance.statusName,
  'Note': instance.note,
  'CreatedDate': instance.createdDate,
  'CreatedByName': instance.createdByName,
};
