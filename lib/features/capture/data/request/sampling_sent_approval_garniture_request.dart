class SamplingSentApprovalGarnitureRequest {
  int? userId;
  String? employeeCode;
  String? userName;
  String? samplingId;
  String? outletCode;
  String? planogramCode;

  SamplingSentApprovalGarnitureRequest({
    this.userId,
    this.employeeCode,
    this.userName,
    this.samplingId,
    this.outletCode,
    this.planogramCode,
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
