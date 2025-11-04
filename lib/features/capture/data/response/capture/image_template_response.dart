import 'package:json_annotation/json_annotation.dart';
part 'image_template_response.g.dart';

@JsonSerializable()
class ImageTemplateResponse {
  @JsonKey(name: 'ImageGarnitureId')
  final String? imageGarnitureId;

  @JsonKey(name: 'PlanogramId')
  final int? planogramId;

  @JsonKey(name: 'PlanogramCode')
  final String? planogramCode;

  @JsonKey(name: 'PromotionCode')
  final String? promotionCode;

  @JsonKey(name: 'ImageTemplate')
  final String? imageTemplate;

  @JsonKey(name: 'ZoneName')
  final String? zoneName;

  @JsonKey(name: 'Level')
  final int? level;

  @JsonKey(name: 'Type')
  final String? type;

  ImageTemplateResponse({
    this.imageGarnitureId,
    this.planogramId,
    this.planogramCode,
    this.promotionCode,
    this.imageTemplate,
    this.zoneName,
    this.level,
    this.type,
  });

  factory ImageTemplateResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageTemplateResponseToJson(this);
}
