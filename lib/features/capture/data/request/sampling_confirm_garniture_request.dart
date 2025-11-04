class SamplingConfirmGarnitureRequest {
  int? userId;
  String? employeeCode;
  String? userName;
  String? imageGarnitureId;
  String? outletCode;
  String? planogramCode;

  SamplingConfirmGarnitureRequest({
    required this.userId,
    required this.employeeCode,
    required this.userName,
    required this.outletCode,
    required this.imageGarnitureId,
    required this.planogramCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'OutletCode': outletCode,
      'ImageGarnitureId': imageGarnitureId,
      'PlanogramCode': planogramCode,
    };
  }
}
