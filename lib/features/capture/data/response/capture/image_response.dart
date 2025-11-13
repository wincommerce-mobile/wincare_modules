import 'package:json_annotation/json_annotation.dart';

part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: 'IsCollage')
  final bool? isCollage;

  @JsonKey(name: 'UrlImage')
  final String? urlImage;

  ImageResponse({this.isCollage, this.urlImage});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
