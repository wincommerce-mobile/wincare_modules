import 'package:json_annotation/json_annotation.dart';

import 'product_result_response.dart';

part 'result_image_garniture_response.g.dart';

@JsonSerializable()
class ResultImageGarnitureResponse {
  @JsonKey(name: 'ComplianceStatusId')
  final int? complianceStatusId;

  @JsonKey(name: 'ComplianceStatus')
  final String? complianceStatus;

  @JsonKey(name: 'ComplianceSummary')
  final String? complianceSummary;

  @JsonKey(name: 'CreatedByName')
  final String? createdByName;

  @JsonKey(name: 'CreatedDate')
  final String? createdDate;

  @JsonKey(name: 'ContentParsed')
  final List<ProductResultResponse>? products;

  ResultImageGarnitureResponse({
    this.complianceStatusId,
    this.complianceStatus,
    this.complianceSummary,
    this.createdByName,
    this.createdDate,
    this.products,
  });

  factory ResultImageGarnitureResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultImageGarnitureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResultImageGarnitureResponseToJson(this);
}
