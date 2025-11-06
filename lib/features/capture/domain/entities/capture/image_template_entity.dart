import 'dart:ui';

import 'package:image_picker/image_picker.dart';

import '../../../../../app/app_colors.dart';
import '../../../../../app/app_enum.dart';

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
  ImageResult? result;
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
    ImageResult? result,
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

enum MyImageStatus {
  created(name: 'Mới tạo', color: AppColors.black4D),
  processing(name: 'Chờ kết quả chấm', color: Color(0xFFE7B400)),
  verified(name: 'Đạt', color: Color(0xFF3A73FF)),
  failed(name: 'Rớt', color: AppColors.red);

  const MyImageStatus({required this.name, required this.color});

  final String name;
  final Color color;
}

class ImageResult {
  final MyImageStatus status;
  final String name;
  final String resultDate;

  ImageResult({
    required this.status,
    required this.name,
    required this.resultDate,
  });

  copyWith({MyImageStatus? status, String? name, String? resultDate}) {
    return ImageResult(
      status: status ?? this.status,
      name: name ?? this.name,
      resultDate: resultDate ?? this.resultDate,
    );
  }
}
