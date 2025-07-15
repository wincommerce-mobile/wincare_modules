class LabelType {
  final String id;
  final String name;
  final String imagePath;
  bool isKM;
  bool checked;

  LabelType({required this.id, required this.name, required this.imagePath, this.checked = false, this.isKM = false});

  copyWith({
    String? id,
    String? name,
    String? imagePath,
    bool? checked,
    bool? isKM,
  }) {
    return LabelType(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      checked: checked ?? this.checked,
      isKM: isKM ?? this.isKM,
    );
  }
}