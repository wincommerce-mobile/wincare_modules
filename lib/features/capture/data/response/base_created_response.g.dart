// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_created_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCreatedResponse _$BaseCreatedResponseFromJson(Map<String, dynamic> json) =>
    BaseCreatedResponse(
      id: (json['ID'] as num?)?.toInt(),
      message: json['Message'] as String?,
      systemMessage: json['SystemMessage'] as String?,
    );

Map<String, dynamic> _$BaseCreatedResponseToJson(
  BaseCreatedResponse instance,
) => <String, dynamic>{
  'ID': instance.id,
  'Message': instance.message,
  'SystemMessage': instance.systemMessage,
};
