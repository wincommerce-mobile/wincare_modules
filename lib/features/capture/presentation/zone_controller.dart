import 'dart:async';

import 'package:get/get.dart';

import '../domain/entities/capture/complaint_reason_entity.dart';
import 'capture_controller.dart';

class ZoneController extends GetxController {
  final int zoneId;
  final List<ComplaintReasonEntity> complaintReasons;

  ZoneController({required this.zoneId, required this.complaintReasons});

  final Rxn<ImageResult> result = Rxn<ImageResult>();
  Timer? _pollTimer;
  bool _isPolling = false;
  var reasons = RxList<ComplaintReasonEntity>([]);
  var selectedReason = Rxn<ComplaintReasonEntity>();

  @override
  void onInit() {
    super.onInit();
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

  @override
  void onClose() {
    stopPolling();
    super.onClose();
  }
}
