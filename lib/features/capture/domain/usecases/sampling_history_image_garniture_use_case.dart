import 'package:wincare_modules/features/capture/domain/entities/history/capture_history_entity.dart';
import 'package:wincare_modules/features/capture/domain/repositories/history_repository.dart';

import '../../data/request/image_garniture_history_request.dart';
import '../entities/base/base_error_entity.dart';

class SamplingHistoryImageGarnitureUseCase {
  final HistoryRepository repository;

  SamplingHistoryImageGarnitureUseCase({required this.repository});

  Future<List<ImageGarnitureHistoryEntity>> call(
    ImageGarnitureHistoryRequest request,
  ) async {
    try {
      return await repository.samplingOutletHistoryImageGarniture(request);
    } on BaseErrorEntity catch (_) {
      rethrow;
    }
  }
}
