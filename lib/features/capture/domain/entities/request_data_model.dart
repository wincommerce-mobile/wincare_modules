class RequestDataModel {
  final String displayName;
  final String sessionLogin;
  final String employeeCode;
  final String siteId;
  final int? userId;
  final String? samplingId;
  final String? imageGarnitureId;
  final String? outletCode;
  final String? versionInfo;
  final bool isAllowEdit;
  final bool isAllowAddImage;
  final bool isAllowCancelImage;
  final bool isAllowSendApproval;

  RequestDataModel({
    required this.displayName,
    required this.sessionLogin,
    required this.employeeCode,
    required this.siteId,
    required this.userId,
    required this.samplingId,
    required this.imageGarnitureId,
    required this.outletCode,
    required this.versionInfo,
    required this.isAllowEdit,
    required this.isAllowAddImage,
    required this.isAllowCancelImage,
    required this.isAllowSendApproval,
  });

  factory RequestDataModel.fromJson(Map<String, dynamic> json) {
    return RequestDataModel(
      displayName: json['displayName'] ?? '',
      sessionLogin: json['sessionLogin'] ?? '',
      employeeCode: json['employeeCode'] ?? '',
      siteId: json['siteId'] ?? '',
      userId: json['userId'] ?? '',
      samplingId: json['samplingId'] ?? '',
      imageGarnitureId: json['imageGarnitureId'] ?? '',
      outletCode: json['outletCode'] ?? '',
      versionInfo: json['versionInfo'] ?? '',
      isAllowEdit: json['isAllowEdit'] ?? false,
      isAllowAddImage: json['isAllowAddImage'] ?? false,
      isAllowCancelImage: json['isAllowCancelImage'] ?? false,
      isAllowSendApproval: json['isAllowSendApproval'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'sessionLogin': sessionLogin,
      'userId': userId,
      'employeeCode': employeeCode,
      'siteId': siteId,
      'samplingId': samplingId,
      'imageGarnitureId': imageGarnitureId,
      'outletCode': outletCode,
      'versionInfo': versionInfo,
      'isAllowEdit': isAllowEdit,
      'isAllowAddImage': isAllowAddImage,
      'isAllowCancelImage': isAllowCancelImage,
      'isAllowSendApproval': isAllowSendApproval,
    };
  }
}
