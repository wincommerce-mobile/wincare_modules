import 'package:image_picker/image_picker.dart';

import '../../../../../app/app_enum.dart';
import 'result_image_garniture_entity.dart';

class ImageTemplateEntity {
  final String? imageGarnitureId;
  final int? planogramId;
  final String? planogramCode;
  final String? promotionCode;
  final String? imageTemplate;
  final String? zoneName;
  final String? collageImageToolTip;
  final int? level;
  final TemplateType? type;
  final SampleImageEntity? templateImage;
  final List<SampleImageEntity> sampleImages;
  final ResultImageGarnitureEntity? result;
  final bool finalComplianceStatus;

  /// bộ hình đã gửi chấm hình và có kết quả
  bool isSendConfirm;
  bool selected;

  bool get allImagesConfirmed => sampleImages.every((e) => e.isSendConfirm);

  ImageTemplateEntity({
    required this.imageGarnitureId,
    required this.planogramId,
    required this.planogramCode,
    required this.promotionCode,
    required this.imageTemplate,
    required this.zoneName,
    required this.collageImageToolTip,
    required this.level,
    required this.type,
    required this.templateImage,
    required this.sampleImages,
    required this.result,
    this.selected = false,
    required this.isSendConfirm,
    required this.finalComplianceStatus,
  });

  copyWith({
    List<SampleImageEntity>? sampleImages,
    ResultImageGarnitureEntity? result,
    bool? finalComplianceStatus,
    bool? selected,
    bool? isSendConfirm,
  }) {
    return ImageTemplateEntity(
      imageGarnitureId: imageGarnitureId,
      planogramId: planogramId,
      planogramCode: planogramCode,
      promotionCode: promotionCode,
      imageTemplate: imageTemplate,
      zoneName: zoneName,
      collageImageToolTip: collageImageToolTip,
      level: level,
      type: type,
      templateImage: templateImage,
      result: result ?? this.result,
      selected: selected ?? this.selected,
      isSendConfirm: isSendConfirm ?? this.isSendConfirm,
      finalComplianceStatus:
          finalComplianceStatus ?? this.finalComplianceStatus,
      sampleImages: sampleImages ?? this.sampleImages,
    );
  }
}

class SampleImageEntity {
  final String? url;
  final XFile? path;
  final String? address;
  final String? takenDate;

  /// Hình đã xử lý và trả về từ AI (in case hình ghép)
  final bool isHandled;
  final bool isAllowEdit;

  /// Hình đã gửi chấm hình và có kết quả
  final bool isSendConfirm;

  /// Đang chờ kết quả chấm hình
  ///
  bool isWaitingResult;

  SampleImageEntity({
    required this.url,
    required this.path,
    this.isHandled = false,
    this.isAllowEdit = true,
    this.isWaitingResult = false,
    this.address,
    this.takenDate,
    required this.isSendConfirm,
  });

  copyWith({
    String? url,
    String? address,
    XFile? path,
    bool? isHandled,
    bool? isAllowEdit,
    bool? isWaitingResult,
    bool? isSendConfirm,
  }) {
    return SampleImageEntity(
      url: url ?? this.url,
      address: address ?? this.address,
      takenDate: takenDate,
      path: path ?? this.path,
      isHandled: isHandled ?? this.isHandled,
      isWaitingResult: isWaitingResult ?? this.isWaitingResult,
      isAllowEdit: isAllowEdit ?? this.isAllowEdit,
      isSendConfirm: isSendConfirm ?? this.isSendConfirm,
    );
  }
}
