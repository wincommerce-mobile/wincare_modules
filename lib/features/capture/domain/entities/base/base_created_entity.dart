class BaseCreatedEntity {
  final int? id;
  final String? message;
  final String? systemMessage;

  BaseCreatedEntity({
    required this.id,
    required this.message,
    required this.systemMessage,
  });
}
