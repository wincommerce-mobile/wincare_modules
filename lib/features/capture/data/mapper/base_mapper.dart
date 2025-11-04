import 'package:wincare_modules/features/capture/data/response/base_created_response.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_created_entity.dart';

extension BaseMapper on BaseCreatedResponse {
  BaseCreatedEntity toEntity() {
    return BaseCreatedEntity(
      id: id,
      message: message,
      systemMessage: systemMessage,
    );
  }
}
