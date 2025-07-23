import '../../../../app/app_enum.dart';

class LabelType {
  final String id;
  final String name;
  final String imagePath;
  final LabelTypeEnum labelType;
  bool isKM;
  bool checked;

  LabelType({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.labelType,
    this.checked = false,
    this.isKM = false,
  });

  copyWith({
    String? id,
    String? name,
    String? imagePath,
    LabelTypeEnum? labelType,
    bool? checked,
    bool? isKM,
  }) {
    return LabelType(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      labelType: labelType ?? this.labelType,
      checked: checked ?? this.checked,
      isKM: isKM ?? this.isKM,
    );
  }
}
