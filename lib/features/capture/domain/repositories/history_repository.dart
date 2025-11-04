import '../../data/request/image_garniture_history_request.dart';
import '../entities/history/capture_history_entity.dart';

abstract class HistoryRepository {
  Future<List<ImageGarnitureHistoryEntity>> samplingOutletHistoryImageGarniture(
    ImageGarnitureHistoryRequest request,
  );
}
