import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/domain/entities/base/base_error_entity.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/loading_indicator.dart';
import 'package:wincare_modules/features/capture/presentation/widgets/snack_bar.dart';

import '../../../../app/app_constants.dart';
import '../../data/request/image_garniture_history_request.dart';
import '../../domain/entities/history/capture_history_entity.dart';
import '../../domain/usecases/sampling_history_image_garniture_use_case.dart';
import '../common/capture_method_channel.dart';

class HistoryController extends GetxController {
  final SamplingHistoryImageGarnitureUseCase historyImageGarnitureUseCase;

  HistoryController({required this.historyImageGarnitureUseCase});

  var imageGarnitureHistories = RxList<ImageGarnitureHistoryEntity>([]);

  static final _channel = MethodChannel(AppConstants.captureChannel);

  Future<void> onRefresh() async {
    await getImageGarnitureHistory();
  }

  Future<void> getImageGarnitureHistory() async {
    final requestData = await AppSecureStorage.getRequestData();
    try {
      showLoadingIndicator();
      final request = ImageGarnitureHistoryRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        samplingId: requestData?.samplingId,
        outletCode: requestData?.outletCode,
        imageGarnitureId: requestData?.imageGarnitureId,
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

  Future<void> setupChannelHandler() async {
    /// ------------------ ///
    _channel.setMethodCallHandler((call) async {
      try {
        switch (call.method) {
          case AppConstants.onNativeBackPressed:
            Get.back();
          default:
            break;
        }
      } catch (e) {
        debugPrint('Error setting up channel handler: $e');
      }
    });
  }

  @override
  void onInit() async {
    super.onInit();
    await getImageGarnitureHistory();
    //await setupChannelHandler();
  }
}
