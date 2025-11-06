import 'package:json_annotation/json_annotation.dart';

part 'complaint_reason_response.g.dart';

@JsonSerializable()
class ComplaintReasonResponse {
  @JsonKey(name: 'Id')
  final int? id;
  @JsonKey(name: 'Reason')
  final String? reason;
  @JsonKey(name: 'CreatedAt')
  final String? createdAt;
  @JsonKey(name: 'CreatedByName')
  final String? createdByName;
  @JsonKey(name: 'CreatedBy')
  final int? createdBy;
  @JsonKey(name: 'UpdatedAt')
  final String? updatedAt;
  @JsonKey(name: 'UpdatedByName')
  final String? updatedByName;
  @JsonKey(name: 'UpdatedBy')
  final int? updatedBy;

  ComplaintReasonResponse({
    this.id,
    this.reason,
    this.createdAt,
    this.createdByName,
    this.createdBy,
    this.updatedAt,
    this.updatedByName,
    this.updatedBy,
  });

  factory ComplaintReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$ComplaintReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ComplaintReasonResponseToJson(this);
}
