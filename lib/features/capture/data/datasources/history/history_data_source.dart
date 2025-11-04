import '../../request/image_garniture_history_request.dart';
import '../../response/history/image_garniture_history_response.dart';

abstract class HistoryDataSource {
  Future<List<ImageGarnitureHistoryResponse>?>
  samplingOutletHistoryImageGarniture(ImageGarnitureHistoryRequest request);
}
