import '../../../../../app/app_enum.dart';

class ResultImageGarnitureEntity {
  final int? complianceStatusId;
  final String? complianceStatus;
  final ComplianceStatusEnum complianceStatusEnum;
  final String? complianceSummary;
  final String? createdByName;
  final String? createdDate;

  ResultImageGarnitureEntity({
    required this.complianceStatusId,
    required this.complianceStatus,
    required this.complianceStatusEnum,
    required this.complianceSummary,
    required this.createdByName,
    required this.createdDate,
  });
}
