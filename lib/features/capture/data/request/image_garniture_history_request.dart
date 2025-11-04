class ImageGarnitureHistoryRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? samplingId;
  String? outletCode;
  String? imageGarnitureId;

  ImageGarnitureHistoryRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.samplingId,
    required this.outletCode,
    required this.imageGarnitureId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SamplingId': samplingId,
      'OutletCode': outletCode,
      'ImageGarnitureId': imageGarnitureId,
    };
  }
}
