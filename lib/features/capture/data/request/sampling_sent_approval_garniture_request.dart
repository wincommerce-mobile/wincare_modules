class SamplingSentApprovalGarnitureRequest {
  int? userId;
  String? employeeCode;
  String? userName;
  String? samplingId;
  String? imageGarnitureId;
  String? outletCode;
  String? planogramCode;
  int? planogramId;

  SamplingSentApprovalGarnitureRequest({
    required this.userId,
    required this.employeeCode,
    required this.userName,
    required this.samplingId,
    required this.imageGarnitureId,
    required this.outletCode,
    required this.planogramCode,
    required this.planogramId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SamplingId': samplingId,
      'OutletCode': outletCode,
      'PlanogramCode': planogramCode,
      'ImageGarnitureId': imageGarnitureId,
      'PlanogramId': planogramId,
    };
  }
}
