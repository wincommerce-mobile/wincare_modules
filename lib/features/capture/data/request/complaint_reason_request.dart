class ComplaintReasonRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? siteId;

  ComplaintReasonRequest({
    required this.userId,
    required this.userName,
    required this.employeeCode,
    required this.siteId,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'UserName': userName,
      'EmployeeCode': employeeCode,
      'SiteId': siteId,
    };
  }
}
