class UserEntity {
  final String displayName;
  final String sessionLogin;
  final String employeeCode;
  final String siteId;
  final int? userId;
  final String imageGarnitureId;
  final String outletCode;

  UserEntity({
    required this.displayName,
    required this.sessionLogin,
    required this.employeeCode,
    required this.siteId,
    required this.userId,
    required this.imageGarnitureId,
    required this.outletCode,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      displayName: json['displayName'] ?? '',
      sessionLogin: json['sessionLogin'] ?? '',
      employeeCode: json['employeeCode'] ?? '',
      siteId: json['siteId'] ?? '',
      userId: json['userId'] ?? '',
      imageGarnitureId: json['imageGarnitureId'] ?? '',
      outletCode: json['outletCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'sessionLogin': sessionLogin,
      'userId': userId,
      'employeeCode': employeeCode,
      'siteId': siteId,
      'imageGarnitureId': imageGarnitureId,
      'outletCode': outletCode,
    };
  }
}
