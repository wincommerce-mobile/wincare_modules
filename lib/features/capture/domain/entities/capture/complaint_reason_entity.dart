class ComplaintReasonEntity {
  final int? id;
  final String? reason;
  final String? createdAt;
  final String? createdByName;
  final int? createdBy;
  final String? updatedAt;
  final String? updatedByName;
  final int? updatedBy;

  ComplaintReasonEntity({
    required this.id,
    required this.reason,
    required this.createdAt,
    required this.createdByName,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedByName,
    required this.updatedBy,
  });
}
