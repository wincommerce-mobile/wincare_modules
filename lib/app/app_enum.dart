enum LabelTypeEnum {
  temThuong(description: 'Tem thường', type: 1),
  temThuongCoXuatXu(description: 'Tem thường có xuất xứ', type: 2),
  temKhuyenMai(description: 'Tem khuyến mại', type: 3),
  temKhuyenMaiCoXuatXu(description: 'Tem khuyến mại có xuất xứ', type: 4);

  const LabelTypeEnum({required this.description, required this.type});

  final String description;
  final int type;
}
