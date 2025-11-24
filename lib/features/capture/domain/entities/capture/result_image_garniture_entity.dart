import '../../../../../app/app_enum.dart';

class ResultImageGarnitureEntity {
  final int? complianceStatusId;
  final String? complianceStatus;
  final ComplianceStatusEnum? complianceStatusEnum;
  final String? complianceSummary;
  final List<ProductResultEntity> products;
  final String? createdByName;
  final String? createdDate;

  ResultImageGarnitureEntity({
    required this.complianceStatusId,
    required this.complianceStatus,
    required this.complianceStatusEnum,
    required this.complianceSummary,
    required this.products,
    required this.createdByName,
    required this.createdDate,
  });
}

class ProductResultEntity {
  final String? productName;
  final String? productCode;
  final String? skuDetected;

  ProductResultEntity({
    required this.productName,
    required this.productCode,
    required this.skuDetected,
  });
}
