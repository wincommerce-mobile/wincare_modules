import 'package:json_annotation/json_annotation.dart';

part 'complaint_reason_response.g.dart';

@JsonSerializable()
class ComplaintReasonResponse {
  final int? id;
  final String? reason;
  final String? createdAt;
  final String? createdByName;
  final int? createdBy;
  final String? updatedAt;
  final String? updatedByName;
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
