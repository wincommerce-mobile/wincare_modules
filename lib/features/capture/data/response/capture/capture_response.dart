import 'package:json_annotation/json_annotation.dart';

part 'capture_response.g.dart';

@JsonSerializable()
class CaptureResponse {
  @JsonKey(name: 'result')
  final bool? result;

  CaptureResponse({this.result});

  factory CaptureResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CaptureResponseToJson(this);
}
