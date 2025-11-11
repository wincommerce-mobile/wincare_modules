class ImageTemplateRequest {
  int? userId;
  String? employeeCode;
  String? samplingId;
  String? outletCode;
  String? imageGarnitureId;

  ImageTemplateRequest({
    required this.userId,
    required this.employeeCode,
    required this.samplingId,
    required this.outletCode,
    required this.imageGarnitureId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'EmployeeCode': employeeCode,
      'SamplingId': samplingId,
      'OutletCode': outletCode,
      'ImageGarnitureId': imageGarnitureId,
    };
  }
}
