import 'package:get/get.dart';
import 'capture_controller.dart';

class CaptureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CaptureController());
  }
}
