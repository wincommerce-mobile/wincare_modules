import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/presentation/history/history_controller.dart';

import '../../di/modules.dart';
import '../../domain/usecases/sampling_history_image_garniture_use_case.dart';

class HistoryBinding extends Bindings
    with ConfigModule, ClientModule, DatasourceModule, RepositoryModule {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HistoryController(
        historyImageGarnitureUseCase: SamplingHistoryImageGarnitureUseCase(
          repository: historyRepository,
        ),
      ),
    );
  }
}
