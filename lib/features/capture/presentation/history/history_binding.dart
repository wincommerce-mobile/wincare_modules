import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/presentation/history/history_controller.dart';

import '../../di/modules.dart';

class HistoryBinding extends Bindings
    with ConfigModule, ClientModule, DatasourceModule, RepositoryModule {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());
  }
}
