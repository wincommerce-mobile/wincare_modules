class ImageGarnitureHistoryRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? samplingId;
  String? outletCode;
  String? imageGarnitureId;

  ImageGarnitureHistoryRequest({
    this.userId,
    this.userName,
    this.employeeCode,
    this.samplingId,
    this.outletCode,
    this.imageGarnitureId,
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
