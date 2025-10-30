import 'package:json_annotation/json_annotation.dart';
part 'capture_history_response.g.dart';

@JsonSerializable()
class CaptureHistoryResponse {
  @JsonKey(name: 'title')
  final String? title;

  CaptureHistoryResponse({this.title});

  factory CaptureHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptureHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CaptureHistoryResponseToJson(this);
}
