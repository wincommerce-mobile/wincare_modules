class SamplingConfirmGarnitureRequest {
  int? userId;
  String? employeeCode;
  String? userName;
  String? imageGarnitureId;
  String? outletCode;

  SamplingConfirmGarnitureRequest({
    this.userId,
    this.employeeCode,
    this.userName,
    this.outletCode,
    this.imageGarnitureId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'OutletCode': outletCode,
      'ImageGarnitureId': imageGarnitureId,
    };
  }
}
