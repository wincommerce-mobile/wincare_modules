import 'package:json_annotation/json_annotation.dart';
part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'Url')
  final String? url;

  BannerResponse({this.url});

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
