import 'dart:async';

import 'package:get/get.dart';
import 'package:wincare_modules/app/app_secure_storage.dart';
import 'package:wincare_modules/features/capture/domain/entities/user_entity.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_result_image_garniture.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_sent_approval_image_use_case.dart';

import '../data/request/result_image_garniture_request.dart';
import '../data/request/sampling_sent_approval_garniture_request.dart';
import '../domain/entities/base/base_error_entity.dart';
import '../domain/entities/capture/complaint_reason_entity.dart';
import '../domain/usecases/promotion_aiv_complaint_use_case.dart';
import 'capture_controller.dart';
import 'common/capture_method_channel.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/snack_bar.dart';

class ZoneController extends GetxController {
  final int zoneId;
  final List<ComplaintReasonEntity> complaintReasons;
  /// Lấy kết quá bộ hình theo zone
  final SamplingResultImageGarniture samplingResultImageGarnitureUseCase;

  /// Xác nhận bộ hình theo zone
  final SamplingSentApprovalImageUseCase samplingSentApprovalImageUseCase;

  /// Khiếu nại bộ hình theo zone
  final PromotionAivComplaintUseCase promotionAivComplaintUseCase;

  ZoneController({
    required this.zoneId,
    required this.complaintReasons,
    required this.samplingResultImageGarnitureUseCase,
    required this.samplingSentApprovalImageUseCase,
    required this.promotionAivComplaintUseCase,
  });

  final Rxn<ImageResult> result = Rxn<ImageResult>();
  Timer? _pollTimer;
  bool _isPolling = false;
  var reasons = RxList<ComplaintReasonEntity>([]);
  var selectedReason = Rxn<ComplaintReasonEntity>();
  final _userEntity = Rxn<UserEntity>();

  @override
  void onInit() async {
    super.onInit();
    _userEntity.value = await AppSecureStorage.getUser();
    reasons.value = complaintReasons;
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

  Future<void> _poll() async {
    // try {
    //   final res = await fetchZoneResult(zoneId);
    //   result.value = res;
    //   // stop when result is final (not processing)
    //   if (res!=null && res.status != MyImageStatus.processing) {
    //     stopPolling();
    //   }
    // } catch (e) {
    //   // optionally log
    // }
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _isPolling = false;
  }

  /// =================== API call Area ==================
  Future<void> samplingResultImageGarniture() async {
    final user = _userEntity.value;
    final outletCode = '';
    final imageGarnitureId = '';
    try {
      showLoadingIndicator();
      final request = ResultImageGarnitureRequest(
        userId: user?.userId,
        userName: user?.displayName,
        employeeCode: user?.employeeCode,
        outletCode: outletCode,
        imageGarnitureId: imageGarnitureId,
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
    final user = _userEntity.value;
    final outletCode = '';
    final samplingId = '';
    final planogramCode = '';
    try {
      showLoadingIndicator();
      final request = SamplingSentApprovalGarnitureRequest(
        userId: user?.userId,
        employeeCode: user?.employeeCode,
        userName: user?.displayName,
        samplingId: samplingId,
        outletCode: outletCode,
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
