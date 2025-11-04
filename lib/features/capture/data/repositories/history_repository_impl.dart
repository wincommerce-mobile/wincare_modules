import '../../../../app/app_connectivity.dart';
import '../../api/base/base_error_response.dart';
import '../../domain/entities/base/base_error_entity.dart';
import '../../domain/entities/history/capture_history_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history/history_data_source.dart';
import '../mapper/exception_mapper.dart';
import '../mapper/history_mapper.dart';
import '../request/image_garniture_history_request.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource historyDataSource;

  HistoryRepositoryImpl({required this.historyDataSource});

  @override
  Future<List<ImageGarnitureHistoryEntity>> samplingOutletHistoryImageGarniture(
    ImageGarnitureHistoryRequest request,
  ) async {
    if (await AppConnectivity.instance.isInternetAvailable()) {
      try {
        final response = await historyDataSource
            .samplingOutletHistoryImageGarniture(request);
        if (response == null) {
          throw BaseErrorEntity.noData();
        } else {
          final data = response.map((e) => e.toEntity()).toList();
          return data;
        }
      } on BaseErrorResponse catch (error) {
        throw ExceptionMapper.toBaseErrorEntity(error);
      }
    } else {
      throw BaseErrorEntity.noNetworkError();
    }
  }
}
