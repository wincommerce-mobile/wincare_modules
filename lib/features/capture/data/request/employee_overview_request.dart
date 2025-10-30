class EmployeeOverviewRequest {
  int? userId;
  String? userName;
  String? employeeCode;
  String? siteId;

  EmployeeOverviewRequest({
    this.userId,
    this.userName,
    this.employeeCode,
    this.siteId,
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
