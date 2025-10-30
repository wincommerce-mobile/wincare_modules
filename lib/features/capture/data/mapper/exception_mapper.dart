import '../../api/base/base_error_response.dart';
import '../../domain/entities/base/base_error_entity.dart';

class ExceptionMapper {
  static BaseErrorEntity toBaseErrorEntity(BaseErrorResponse error) {
    return BaseErrorEntity(
      statusCode: error.statusCode,
      message: error.statusMessage,
      errorCode: error.errorCode,
    );
  }
}
