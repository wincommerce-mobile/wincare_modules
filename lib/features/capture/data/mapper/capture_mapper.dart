import 'package:wincare_modules/app/app_enum.dart';
import 'package:wincare_modules/features/capture/data/response/capture/complaint_reason_response.dart';
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
      level: level,
      type: TemplateType.fromServer(type),
      templateImage: SampleImageEntity(url: imageTemplate, path: null),
      sampleImages: urlImages != null
          ? urlImages!
                .map((url) => SampleImageEntity(url: url, path: null))
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
