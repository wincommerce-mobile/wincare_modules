class ResultImageGarnitureRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? outletCode;
  String? imageGarnitureId;

  ResultImageGarnitureRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.outletCode,
    required this.imageGarnitureId,
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
