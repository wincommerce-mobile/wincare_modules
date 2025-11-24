// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResultResponse _$ProductResultResponseFromJson(
  Map<String, dynamic> json,
) => ProductResultResponse(
  productName: json['product_name'] as String?,
  productCode: json['product_code'] as String?,
  skuDetected: json['sku_detected'] as String?,
);

Map<String, dynamic> _$ProductResultResponseToJson(
  ProductResultResponse instance,
) => <String, dynamic>{
  'product_name': instance.productName,
  'product_code': instance.productCode,
  'sku_detected': instance.skuDetected,
};
