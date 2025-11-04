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

  ImageTemplateEntity({
    required this.imageGarnitureId,
    required this.planogramId,
    required this.planogramCode,
    required this.promotionCode,
    required this.imageTemplate,
    required this.zoneName,
    required this.level,
    required this.type,
  });
}
