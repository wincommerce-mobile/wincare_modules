class BaseErrorEntity {
  BaseErrorEntity({
    required this.statusCode,
    required this.message,
    this.errorCode,
  });

  final int? statusCode;
  final String? message;
  final String? errorCode;

  factory BaseErrorEntity.noNetworkError() => BaseErrorEntity(
      statusCode: 0,
      message: 'Bạn không có kết nối mạng. Vui lòng kiểm tra lại kết nối của bạn.');

  factory BaseErrorEntity.noData() =>
      BaseErrorEntity(statusCode: 1, message: 'Không có dữ liệu');
}
