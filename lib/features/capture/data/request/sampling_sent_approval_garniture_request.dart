class SamplingSentApprovalGarnitureRequest {
  int? userId;
  String? employeeCode;
  String? userName;
  String? samplingId;
  String? outletCode;
  String? planogramCode;

  SamplingSentApprovalGarnitureRequest({
    required this.userId,
    required this.employeeCode,
    required this.userName,
    required this.samplingId,
    required this.outletCode,
    required this.planogramCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SamplingId': samplingId,
      'OutletCode': outletCode,
      'PlanogramCode': planogramCode,
    };
  }
}
