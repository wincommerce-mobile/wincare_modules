class SamplingConfirmGarnitureRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? siteId;
  String? planogramCode;
  int? level;
  String? promotionCode;
  int? rowNumber;
  String? outletCode;
  String? outletName;
  String? zoneName;
  bool? isComplaint;
  String? reasonComplaint;
  String? imageGarnitureId;

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SiteId': siteId,
      'PlanogramCode': planogramCode,
      'Level': level,
      'PromotionCode': promotionCode,
      'RowNumber': rowNumber,
      'OutletCode': outletCode,
      'OutletName': outletName,
      'ZoneName': zoneName,
      'IsComplaint': isComplaint,
      'ReasonComplaint': reasonComplaint,
      'ImageGarnitureId': imageGarnitureId,
    };
  }
}
