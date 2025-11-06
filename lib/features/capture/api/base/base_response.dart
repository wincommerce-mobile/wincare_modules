class BaseResponse<T> {
  final int? statusCode;
  final String? statusName;
  final String? messageTechnical;
  final String? errorMessage;
  final T? data;

  BaseResponse({
    this.statusCode,
    this.statusName,
    this.messageTechnical,
    this.errorMessage,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponse<T>(
      statusCode: json['StatusCode'] ?? 0,
      statusName: json['StatusName'] ?? '',
      messageTechnical: json['MessageTechnical'],
      errorMessage: json['ErrorMessage'] ?? '',
      data: json['Data'] != null ? fromJsonT(json['Data']) : null,
    );
  }
}

class BaseListResponse<T> {
  final int? statusCode;
  final String? statusName;
  final String? messageTechnical;
  final String? errorMessage;
  final List<T>? data;

  BaseListResponse({
    this.statusCode,
    this.statusName,
    this.messageTechnical,
    this.errorMessage,
    this.data,
  });

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) create,
  ) {
    List<T> data = [];
    if (json['Data'] != null) {
      json['Data'].forEach((v) {
        data.add(create(v));
      });
    }
    return BaseListResponse<T>(
      statusCode: json['StatusCode'] ?? 0,
      statusName: json['StatusName'] ?? '',
      messageTechnical: json['MessageTechnical'],
      errorMessage: json['ErrorMessage'] ?? '',
      data: data,
    );
  }
}
