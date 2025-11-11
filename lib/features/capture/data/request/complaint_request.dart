class ComplaintRequest {
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

  ComplaintRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.siteId,
    required this.planogramCode,
    required this.level,
    required this.promotionCode,
    required this.rowNumber,
    required this.outletCode,
    required this.outletName,
    required this.zoneName,
    required this.isComplaint,
    required this.reasonComplaint,
    required this.imageGarnitureId,
  });

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
