class ImageTemplateRequest {
  int? userId;
  String? employeeCode;
  String? samplingId;
  String? outletCode;
  String? imageGarnitureId;

  ImageTemplateRequest({
    this.userId,
    this.employeeCode,
    this.samplingId,
    this.outletCode,
    this.imageGarnitureId,
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
