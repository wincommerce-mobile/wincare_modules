class ResultImageGarnitureRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? outletCode;
  String? imageGarnitureId;
  String? planogramCode;
  int? planogramId;
  String? samplingId;

  ResultImageGarnitureRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.outletCode,
    required this.imageGarnitureId,
    required this.planogramCode,
    required this.planogramId,
    required this.samplingId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'OutletCode': outletCode,
      'ImageGarnitureId': imageGarnitureId,
      'PlanogramCode': planogramCode,
      'PlanogramId': planogramId,
      'SamplingId': samplingId,
    };
  }
}
