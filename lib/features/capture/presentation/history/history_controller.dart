import 'package:get/get.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_error_entity.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/loading_indicator.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/snack_bar.dart';

import '../../data/request/image_garniture_history_request.dart';
import '../../domain/entities/history/capture_history_entity.dart';
import '../../domain/usecases/sampling_history_image_garniture_use_case.dart';
import '../common/capture_method_channel.dart';

class HistoryController extends GetxController {
  final SamplingHistoryImageGarnitureUseCase historyImageGarnitureUseCase;

  HistoryController({required this.historyImageGarnitureUseCase});

  var imageGarnitureHistories = RxList<ImageGarnitureHistoryEntity>([]);

  Future<void> getImageGarnitureHistory() async {
    final user = await AppSecureStorage.getUser();
    //TODO - get from native
    final samplingId = '';
    final outletCode = '';
    final imageGarnitureId = '';
    try {
      showLoadingIndicator();
      final request = ImageGarnitureHistoryRequest(
        userId: user?.userId,
        userName: user?.displayName,
        employeeCode: user?.employeeCode,
        samplingId: samplingId,
        outletCode: outletCode,
        imageGarnitureId: imageGarnitureId,
      );
      final result = await historyImageGarnitureUseCase.call(request);
      imageGarnitureHistories.value = result;
      hideLoadingIndicator();
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return;
      }
      hideLoadingIndicator();
      showSnackBar(description: error.message ?? '');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getImageGarnitureHistory();
  }
}
