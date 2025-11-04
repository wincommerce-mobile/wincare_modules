class ImageGarnitureHistoryEntity {
  final String? imageGarnitureId;
  final int? statusId;
  final String? statusName;
  final String? note;
  final String? createdDate;
  final String? createdByName;

  ImageGarnitureHistoryEntity({
    required this.imageGarnitureId,
    required this.statusId,
    required this.statusName,
    required this.note,
    required this.createdDate,
    required this.createdByName,
  });
}
