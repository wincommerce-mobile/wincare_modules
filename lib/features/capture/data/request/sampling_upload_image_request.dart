import '../../../../app/app_enum.dart';

class SamplingUploadImageRequest {
  final int userId;
  final String userName;
  final String employeeCode;
  final String siteId;

  /// Mã bộ hình trong object DMS_SamplingOutletDetailImageGarniture
  final String id;
  final ImageType imageType;
  final String? img;
  final String? urlImg;
  final String? fileName;
  final String? fileExtension;

  const SamplingUploadImageRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.siteId,
    required this.id,
    required this.imageType,
    this.img,
    this.urlImg,
    this.fileName,
    this.fileExtension,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SiteId': siteId,
      'ID': id,
      'ImageTypeId': imageType.id,
      'Img': img,
      'UrlImg': urlImg,
      'FileName': fileName,
      'FileExtension': fileExtension,
    };
  }
}
