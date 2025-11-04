import 'package:json_annotation/json_annotation.dart';

part 'image_garniture_history_response.g.dart';

@JsonSerializable()
class ImageGarnitureHistoryResponse {
  @JsonKey(name: 'ImageGarnitureId')
  final String? imageGarnitureId;

  @JsonKey(name: 'StatusId')
  final int? statusId;

  @JsonKey(name: 'StatusName')
  final String? statusName;

  @JsonKey(name: 'Note')
  final String? note;

  @JsonKey(name: 'CreatedDate')
  final String? createdDate;

  @JsonKey(name: 'CreatedByName')
  final String? createdByName;

  ImageGarnitureHistoryResponse({
    this.imageGarnitureId,
    this.statusId,
    this.statusName,
    this.note,
    this.createdDate,
    this.createdByName,
  });

  factory ImageGarnitureHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageGarnitureHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageGarnitureHistoryResponseToJson(this);
}
