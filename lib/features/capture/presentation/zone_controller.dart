import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_result_image_garniture.dart';
import 'package:wincare_modules/features/capture/domain/usecases/sampling_sent_approval_image_use_case.dart';

import '../../../app/app_enum.dart';
import '../data/request/complaint_reason_request.dart';
import '../data/request/complaint_request.dart';
import '../data/request/result_image_garniture_request.dart';
import '../data/request/sampling_confirm_garniture_request.dart';
import '../data/request/sampling_sent_approval_garniture_request.dart';
import '../domain/entities/base/base_error_entity.dart';
import '../domain/entities/capture/complaint_reason_entity.dart';
import '../domain/entities/capture/image_template_entity.dart';
import '../domain/entities/capture/result_image_garniture_entity.dart';
import '../domain/entities/request_data_model.dart';
import '../domain/usecases/get_promotion_aiv_complaint_reason_use_case.dart';
import '../domain/usecases/promotion_aiv_complaint_use_case.dart';
import '../domain/usecases/sampling_confirm_image_use_case.dart';
import 'common/capture_method_channel.dart';
import 'widgets/loading_indicator.dart';
import 'widgets/snack_bar.dart';

class ZoneController extends GetxController {
  final ImageTemplateEntity? zone;

  final List<ComplaintReasonEntity>? reasonList;

  final RequestDataModel? requestDataModel;

  /// Lấy kết quá bộ hình theo zone
  final SamplingResultImageGarniture samplingResultImageGarnitureUseCase;

  /// Xác nhận bộ hình theo zone
  final SamplingSentApprovalImageUseCase samplingSentApprovalImageUseCase;

  /// Khiếu nại bộ hình theo zone
  final PromotionAivComplaintUseCase promotionAivComplaintUseCase;

  /// Xác nhận bộ hình
  final SamplingConfirmImageUseCase samplingConfirmImageUseCase;

  /// Lấy lý do khiếu nại
  final GetPromotionAivComplaintReasonUseCase
  getPromotionAivComplaintReasonUseCase;

  ZoneController({
    required this.zone,
    required this.reasonList,
    required this.requestDataModel,
    required this.samplingResultImageGarnitureUseCase,
    required this.samplingSentApprovalImageUseCase,
    required this.promotionAivComplaintUseCase,
    required this.getPromotionAivComplaintReasonUseCase,
    required this.samplingConfirmImageUseCase,
  });

  final Rxn<ResultImageGarnitureEntity> imageResult =
      Rxn<ResultImageGarnitureEntity>();
  Timer? _pollTimer;
  bool _isPolling = false;
  bool finalComplianceStatus = false;

  var reasons = RxList<ComplaintReasonEntity>([]);
  var selectedReason = Rxn<ComplaintReasonEntity>();

  void updateFinalResult(bool result) {
    finalComplianceStatus = result;
  }

  Future<void> onRefresh() async {
    await samplingResultImageGarniture();
  }

  void setReasonList() {
    reasons.value = reasonList ?? [];
  }

  void setSelectReason(ComplaintReasonEntity? s) {
    selectedReason.value = s;
  }

  int _attempts = 0;
  int _maxAttempts = 3;
  bool _isExecuting = false;

  void _startPolling({
    Duration interval = const Duration(seconds: 10),
    int maxAttempts = 3,
  }) {
    if (_isPolling) return;
    _isPolling = true;
    _maxAttempts = maxAttempts;
    _attempts = 0;
    // run immediately and then every [interval]
    _poll();
    _pollTimer = Timer.periodic(interval, (_) => _poll());
  }

  Future<void> _poll() async {
    if (!_isPolling) return;
    if (_isExecuting) return; // prevent overlapping calls
    _isExecuting = true;
    _attempts++;
    try {
      final result =
          await samplingResultImageGarniture(); // now returns the entity
      // stop when result is final OR reached max attempts
      if (_isFinalResult(result) || _attempts >= _maxAttempts) {
        /// temp
        imageResult.value = result;
        stopPolling();
      }
    } catch (e) {
      // optionally log
      if (_attempts >= _maxAttempts) {
        stopPolling();
      }
    } finally {
      _isExecuting = false;
    }
  }

  bool _isFinalResult(ResultImageGarnitureEntity? r) {
    if (r == null) return false;

    final csEnum = r.complianceStatusEnum;
    if (csEnum != null) {
      return csEnum == ComplianceStatusEnum.passed ||
          csEnum == ComplianceStatusEnum.notPassed;
    }

    final id = r.complianceStatusId;
    if (id != null) {
      return id == ComplianceStatusEnum.passed.id ||
          id == ComplianceStatusEnum.notPassed.id;
    }

    return false;
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _isPolling = false;
    _attempts = 0;
  }

  /// =================== API call Area ==================
  /// Gọi chấm hình
  Future<void> samplingSentApprovalImage() async {
    try {
      showLoadingIndicator();
      final request = SamplingSentApprovalGarnitureRequest(
        userId: requestDataModel?.userId,
        employeeCode: requestDataModel?.employeeCode,
        userName: requestDataModel?.displayName,
        samplingId: requestDataModel?.samplingId,
        imageGarnitureId: requestDataModel?.imageGarnitureId,
        outletCode: requestDataModel?.outletCode,
        planogramCode: zone?.planogramCode,
        planogramId: zone?.planogramId,
      );
      final result = await samplingSentApprovalImageUseCase.call(request);
      if (result.id != null && result.id! > 0) {
        final r = ResultImageGarnitureEntity(
          complianceStatusId: ComplianceStatusEnum.waitingResult.id,
          complianceStatus: 'Chờ kết quả chấm hình',
          complianceStatusEnum: ComplianceStatusEnum.waitingResult,
          complianceSummary: '',
          createdByName: '',
          createdDate: DateTime.now().toIso8601String(),
        );
        imageResult.value = r;
        debugPrint(
          'samplingSentApprovalImage: ${imageResult.value?.complianceStatusEnum}',
        );

        /// Sau khi gọi api chấm hình thành công, gọi tiếp api để listen kq chấm hình
        showSuccessSnackBar(description: "Thành công");
        Future.delayed(const Duration(seconds: 2), () {
          hideLoadingIndicator();
          _startPolling();
        });
      } else {
        showSnackBar(description: result.message ?? '');
      }

      hideLoadingIndicator();
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return;
      }
      showSnackBar(description: error.message ?? '');
    }
  }

  /// Gọi để lấy kết quá chấm
  Future<ResultImageGarnitureEntity?> samplingResultImageGarniture() async {
    try {
      final request = ResultImageGarnitureRequest(
        userId: requestDataModel?.userId,
        userName: requestDataModel?.displayName,
        employeeCode: requestDataModel?.employeeCode,
        outletCode: requestDataModel?.outletCode,
        imageGarnitureId: requestDataModel?.imageGarnitureId,
        planogramCode: zone?.planogramCode,
        planogramId: zone?.planogramId,
        samplingId: requestDataModel?.samplingId,
      );
      final result = await samplingResultImageGarnitureUseCase.call(request);
      imageResult.value = result;
      return result;
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return null;
      }
      if (error.statusCode != 1) {
        showSnackBar(description: error.message ?? '');
      }
      return null;
    }
  }

  /// Xác nhận kq chấm hình
  Future<bool> samplingConfirmImage() async {
    try {
      showLoadingIndicator();
      final request = SamplingConfirmGarnitureRequest(
        userId: requestDataModel?.userId,
        userName: requestDataModel?.displayName,
        employeeCode: requestDataModel?.employeeCode,
        siteId: requestDataModel?.siteId,
        planogramCode: zone?.planogramCode,
        level: zone?.level,
        promotionCode: zone?.promotionCode,
        rowNumber: 1,
        outletCode: requestDataModel?.outletCode,
        outletName: "",
        zoneName: zone?.zoneName,
        isComplaint: false,
        reasonComplaint: null,
        imageGarnitureId: requestDataModel?.imageGarnitureId,
        planogramId: zone?.planogramId,
      );
      final result = await samplingConfirmImageUseCase.call(request);
      if (result.id == 1) {
        hideLoadingIndicator();
        showSuccessSnackBar(description: "Xác nhận thành công");
        return true;
      }
      hideLoadingIndicator();
      return false;
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return false;
      }
      showSnackBar(description: error.message ?? '');
      return false;
    }
  }

  /// Khiếu nại kq chấm hình
  Future<bool> promotionAivComplaint() async {
    if (selectedReason.value == null) {
      showSnackBar(description: 'Vui lòng chọn lý do khiếu nại');
      return false;
    }
    try {
      showLoadingIndicator();
      final request = ComplaintRequest(
        userId: requestDataModel?.userId,
        userName: requestDataModel?.displayName,
        employeeCode: requestDataModel?.employeeCode,
        siteId: requestDataModel?.siteId,
        planogramCode: zone?.planogramCode,
        level: zone?.level,
        promotionCode: zone?.promotionCode,
        rowNumber: 1,
        outletCode: requestDataModel?.outletCode,
        outletName: "",
        zoneName: zone?.zoneName,
        planogramId: zone?.planogramId,
        isComplaint: true,
        reasonComplaint: selectedReason.value?.reason,
        imageGarnitureId: requestDataModel?.imageGarnitureId,
      );
      final result = await promotionAivComplaintUseCase.call(request);
      if (result.id == 1) {
        showSuccessSnackBar(description: "Gửi khiếu nại thành công");
        hideLoadingIndicator();
        return true;
      }
      hideLoadingIndicator();
      return false;
    } on BaseErrorEntity catch (error) {
      hideLoadingIndicator();
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return false;
      }
      showSnackBar(description: error.message ?? '');
      return false;
    }
  }

  Future<void> getComplaintReason() async {
    try {
      final request = ComplaintReasonRequest(
        userId: requestDataModel?.userId,
        userName: requestDataModel?.displayName,
        employeeCode: requestDataModel?.employeeCode,
        siteId: requestDataModel?.siteId,
      );
      final result = await getPromotionAivComplaintReasonUseCase.call(request);
      reasons.value = result;
      debugPrint('getComplaintReason: ${reasons.length}');
    } on BaseErrorEntity catch (error) {
      if (error.statusCode == 1002) {
        await CaptureMethodChannel.logOut();
        return;
      }
      showSnackBar(description: error.message ?? '');
    }
  }

  @override
  void onClose() {
    stopPolling();
    super.onClose();
    debugPrint('onClose');
  }
}
