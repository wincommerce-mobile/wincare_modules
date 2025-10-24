class UserEntity {
  final String displayName;
  final String sessionLogin;
  final String email;
  final String employeeCode;
  final String siteId;
  final int userId;
  final String urlAvatar;

  UserEntity({
    required this.displayName,
    required this.sessionLogin,
    required this.email,
    required this.employeeCode,
    required this.siteId,
    required this.userId,
    required this.urlAvatar,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      displayName: json['displayName'] ?? '',
      sessionLogin: json['sessionLogin'] ?? '',
      email: json['email'] ?? '',
      employeeCode: json['employeeCode'] ?? '',
      siteId: json['siteId'] ?? '',
      userId: json['userId'] ?? '',
      urlAvatar: json['urlAvatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'sessionLogin': sessionLogin,
      'email': email,
      'userId': userId,
      'employeeCode': employeeCode,
      'siteId': siteId,
      'urlAvatar': urlAvatar,
    };
  }
}
