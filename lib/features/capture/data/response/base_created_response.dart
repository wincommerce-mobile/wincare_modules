import 'package:json_annotation/json_annotation.dart';

part 'base_created_response.g.dart';

@JsonSerializable()
class BaseCreatedResponse {
  @JsonKey(name: 'ID')
  final int? id;

  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'SystemMessage')
  final String? systemMessage;

  BaseCreatedResponse({this.id, this.message, this.systemMessage});

  factory BaseCreatedResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseCreatedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseCreatedResponseToJson(this);
}
