import 'package:wincare_modules/features/capture/domain/entities/history/capture_history_entity.dart';

import '../response/history/image_garniture_history_response.dart';

extension ImageGarnitureHistoryMapper on ImageGarnitureHistoryResponse {
  ImageGarnitureHistoryEntity toEntity() {
    return ImageGarnitureHistoryEntity(
      imageGarnitureId: imageGarnitureId,
      statusId: statusId,
      statusName: statusName,
      note: note,
      createdDate: createdDate,
      createdByName: createdByName,
    );
  }
}
