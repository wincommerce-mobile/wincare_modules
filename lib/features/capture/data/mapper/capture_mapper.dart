import 'package:wincare_modules/app/app_enum.dart';
import 'package:wincare_modules/features/capture/data/response/capture/complaint_reason_response.dart';
import 'package:wincare_modules/features/capture/data/response/capture/product_result_response.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/complaint_reason_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/image_template_entity.dart';
import 'package:wincare_modules/features/capture/domain/entities/capture/result_image_garniture_entity.dart';

import '../response/capture/image_template_response.dart';
import '../response/capture/result_image_garniture_response.dart';

extension ResultImageGarnitureMapper on ResultImageGarnitureResponse {
  ResultImageGarnitureEntity toEntity() {
    return ResultImageGarnitureEntity(
      complianceStatusId: complianceStatusId,
      complianceStatus: complianceStatus,
      complianceStatusEnum: ComplianceStatusEnum.fromServer(complianceStatusId),
      complianceSummary: complianceSummary,
      products: products != null
          ? products!.map((e) => e.toEntity()).toList()
          : [],
      createdByName: createdByName,
      createdDate: createdDate,
    );
  }
}

extension ImageTemplateMapper on ImageTemplateResponse {
  ImageTemplateEntity toEntity() {
    return ImageTemplateEntity(
      imageGarnitureId: imageGarnitureId,
      planogramId: planogramId,
      planogramCode: planogramCode,
      promotionCode: promotionCode,
      imageTemplate: imageTemplate,
      zoneName: zoneName,
      collageImageToolTip: collageImageToolTip,
      finalComplianceStatus: isConfirmed ?? false,
      level: level,
      isSendConfirm: resultImageGarniture != null,
      type: TemplateType.fromServer(type),
      result: resultImageGarniture?.toEntity(),
      templateImage: SampleImageEntity(
        url: imageTemplate,
        path: null,
        isSendConfirm: true,
      ),
      sampleImages: images != null
          ? images!
                .map(
                  (img) => SampleImageEntity(
                    url: img.urlImage,
                    path: null,
                    isSendConfirm: resultImageGarniture != null,
                    isHandled: img.isCollage ?? false,
                  ),
                )
                .toList()
          : [],
    );
  }
}

extension ComplaintReasonMapper on ComplaintReasonResponse {
  ComplaintReasonEntity toEntity() {
    return ComplaintReasonEntity(
      id: id,
      reason: reason,
      createdAt: createdAt,
      createdByName: createdByName,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedByName: updatedByName,
      updatedBy: updatedBy,
    );
  }
}

extension ProductResultMapper on ProductResultResponse {
  ProductResultEntity toEntity() {
    return ProductResultEntity(
      productName: productName,
      productCode: productCode,
      skuDetected: skuDetected,
    );
  }
}
