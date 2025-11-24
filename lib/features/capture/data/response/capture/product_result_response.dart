import 'package:json_annotation/json_annotation.dart';

part 'product_result_response.g.dart';

@JsonSerializable()
class ProductResultResponse {
  @JsonKey(name: 'product_name')
  final String? productName;

  @JsonKey(name: 'product_code')
  final String? productCode;

  @JsonKey(name: 'sku_detected')
  final String? skuDetected;

  ProductResultResponse({this.productName, this.productCode, this.skuDetected});

  factory ProductResultResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResultResponseToJson(this);
}
