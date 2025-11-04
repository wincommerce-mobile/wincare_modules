enum LabelTypeEnum {
  temThuong(description: 'Tem thường', type: 1),
  temThuongCoXuatXu(description: 'Tem thường có xuất xứ', type: 2),
  temKhuyenMai(description: 'Tem khuyến mại', type: 3),
  temKhuyenMaiCoXuatXu(description: 'Tem khuyến mại có xuất xứ', type: 4),
  temHoiVien(description: 'Tem hội viên', type: 5),
  temHoiVienCoXuatXu(description: 'Tem hội viên', type: 6);

  const LabelTypeEnum({required this.description, required this.type});

  final String description;
  final int type;
}

enum TemplateType {
  require(title: 'require'),
  option(title: 'option');

  const TemplateType({required this.title});

  final String title;

  static TemplateType fromServer(String? type) {
    switch (type) {
      case 'require':
        return TemplateType.require;
      case 'option':
        return TemplateType.option;
      default:
        return TemplateType.option;
    }
  }
}

/// 1: Hình trưng bày
/// 2: Hình Outlet
enum ImageType {
  sampling(id: 1, title: 'sampling'),
  outlet(id: 2, title: 'outlet');

  const ImageType({required this.title, required this.id});

  final String title;
  final int id;
}
