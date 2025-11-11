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
  final int? level;
  final TemplateType? type;
  final SampleImageEntity? templateImage;
  final List<SampleImageEntity> sampleImages;
  ResultImageGarnitureEntity? result;
  bool finalComplianceStatus;
  bool selected;

  ImageTemplateEntity({
    required this.imageGarnitureId,
    required this.planogramId,
    required this.planogramCode,
    required this.promotionCode,
    required this.imageTemplate,
    required this.zoneName,
    required this.level,
    required this.type,
    required this.templateImage,
    required this.sampleImages,
    this.result,
    this.selected = false,
    this.finalComplianceStatus = false,
  });

  copyWith({
    List<SampleImageEntity>? sampleImages,
    ResultImageGarnitureEntity? result,
    bool? finalComplianceStatus,
    bool? selected,
  }) {
    return ImageTemplateEntity(
      imageGarnitureId: imageGarnitureId,
      planogramId: planogramId,
      planogramCode: planogramCode,
      promotionCode: promotionCode,
      imageTemplate: imageTemplate,
      zoneName: zoneName,
      level: level,
      type: type,
      templateImage: templateImage,
      result: result ?? this.result,
      selected: selected ?? this.selected,
      finalComplianceStatus: finalComplianceStatus ?? this.finalComplianceStatus,
      sampleImages: sampleImages ?? this.sampleImages,
    );
  }
}

class SampleImageEntity {
  final String? url;
  final XFile? path;
  final String? address;
  final String? takenDate;
  final bool isHandled;

  SampleImageEntity({
    required this.url,
    required this.path,
    this.isHandled = false,
    this.address,
    this.takenDate,
  });

  copyWith({String? url, String? address, XFile? path, bool? isHandled}) {
    return SampleImageEntity(
      url: url ?? this.url,
      address: address ?? this.address,
      takenDate: takenDate,
      path: path ?? this.path,
      isHandled: isHandled ?? this.isHandled,
    );
  }
}