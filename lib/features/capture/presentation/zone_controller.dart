import 'dart:async';

import 'package:get/get.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_result_image_garniture.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_sent_approval_image_use_case.dart';

import '../data/request/complaint_reason_request.dart';
import '../data/request/result_image_garniture_request.dart';
import '../data/request/sampling_sent_approval_garniture_request.dart';
import '../domain/entities/base/base_error_entity.dart';
import '../domain/entities/capture/complaint_reason_entity.dart';
import '../domain/entities/capture/image_template_entity.dart';
import '../domain/entities/request_data_model.dart';
import '../domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import '../domain/usecases/promotion_aiv_complaint_use_case.dart';
import 'capture_controller.dart';
import 'common/capture_method_channel.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/snack_bar.dart';

class ZoneController extends GetxController {
  final int zoneId;

  /// Lấy kết quá bộ hình theo zone
  final SamplingResultImageGarniture samplingResultImageGarnitureUseCase;

  /// Xác nhận bộ hình theo zone
  final SamplingSentApprovalImageUseCase samplingSentApprovalImageUseCase;

  /// Khiếu nại bộ hình theo zone
  final PromotionAivComplaintUseCase promotionAivComplaintUseCase;

  final GetPromotionAivComplaintReasonUseCase
  getPromotionAivComplaintReasonUseCase;

  ZoneController({
    required this.zoneId,
    required this.samplingResultImageGarnitureUseCase,
    required this.samplingSentApprovalImageUseCase,
    required this.promotionAivComplaintUseCase,
    required this.getPromotionAivComplaintReasonUseCase,
  });

  final Rxn<ImageResult> result = Rxn<ImageResult>();
  Timer? _pollTimer;
  bool _isPolling = false;
  var reasons = RxList<ComplaintReasonEntity>([]);
  var selectedReason = Rxn<ComplaintReasonEntity>();
  final _requestData = Rxn<RequestDataModel>();

  Future<void> getComplaintReason() async {
    _requestData.value = await AppSecureStorage.getRequestData();
    try {
      showLoadingIndicator();
      final requestData = _requestData.value;
      final request = ComplaintReasonRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        siteId: requestData?.siteId,
      );
      final result = await getPromotionAivComplaintReasonUseCase.call(request);
      reasons.value = result;
      print('_getComplaintReason: ${result.length}');
      hideLoadingIndicator();
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        hideLoadingIndicator();
        await CaptureMethodChannel.logOut();
      }
      showSnackBar(description: error.message ?? '');
      hideLoadingIndicator();
    }
  }

  void setSelectReason(ComplaintReasonEntity? s) {
    selectedReason.value = s;
  }

  void startPolling({Duration interval = const Duration(seconds: 10)}) {
    if (_isPolling) return;
    _isPolling = true;
    // run immediately and then every [interval]
    _poll();
    _pollTimer = Timer.periodic(interval, (_) => _poll());
  }

  Future<ImageResult> getResult() async {
    return ImageResult(
      status: MyImageStatus.verified,
      name: "AAa",
      resultDate: '',
    );
  }

  int count = 0;

  Future<void> _poll() async {
    try {
      await samplingResultImageGarniture();
      // stop when result is final (not processing)
      if (count > 3) {
        stopPolling();
      }
    } catch (e) {
      // optionally log
    }
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _isPolling = false;
  }

  /// =================== API call Area ==================
  Future<void> samplingResultImageGarniture() async {
    count++;
    final requestData = _requestData.value;
    final planogramCode = '';
    try {
      showLoadingIndicator();
      final request = ResultImageGarnitureRequest(
        userId: requestData?.userId,
        userName: requestData?.displayName,
        employeeCode: requestData?.employeeCode,
        outletCode: requestData?.outletCode,
        imageGarnitureId: requestData?.imageGarnitureId,
        planogramCode: planogramCode,
        samplingId: requestData?.samplingId,
      );
      final result = await samplingResultImageGarnitureUseCase.call(request);

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

  Future<void> samplingSentApprovalImageUse() async {
    final requestData = _requestData.value;
    final planogramCode = '';
    try {
      showLoadingIndicator();
      final request = SamplingSentApprovalGarnitureRequest(
        userId: requestData?.userId,
        employeeCode: requestData?.employeeCode,
        userName: requestData?.displayName,
        samplingId: requestData?.samplingId,
        outletCode: requestData?.samplingId,
        planogramCode: planogramCode,
      );
      final result = await samplingSentApprovalImageUseCase.call(request);

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
  void onClose() {
    stopPolling();
    super.onClose();
  }
}
