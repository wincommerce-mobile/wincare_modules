import '../../../../app/app_enum.dart';

class SamplingUploadImageRequest {
  final int? userId;
  final String? userName;
  final String? employeeCode;
  final String? siteId;

  /// Mã bộ hình trong object DMS_SamplingOutletDetailImageGarniture
  final String? imageGarnitureId;

  /// Zone ID
  final String? planogramCode;
  final ImageType? imageType;
  final String? img;
  final String? urlImg;
  final String? fileName;
  final String? fileExtension;
  final double? latitude;
  final double? longitude;

  const SamplingUploadImageRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.siteId,
    required this.imageGarnitureId,
    required this.planogramCode,
    required this.imageType,
    required this.img,
    required this.urlImg,
    required this.fileName,
    required this.fileExtension,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SiteId': siteId,
      'ID': imageGarnitureId,
      'PlanogramCode': planogramCode,
      'ImageTypeId': imageType?.id,
      'Img': img,
      'UrlImg': urlImg,
      'FileName': fileName,
      'FileExtension': fileExtension,
      if (latitude != null) 'Latitude': latitude,
      if (longitude != null) 'Longitude': longitude,
    };
  }
}
