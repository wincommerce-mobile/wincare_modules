import 'package:get/get.dart';
import 'package:wincare_modules/features/capture/presentation/capture_binding.dart';
import 'package:wincare_modules/features/capture/presentation/history/history_page.dart';

import '../features/printer/presentation/pages/page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.receipt, page: () => const ReceiptPage()),
    GetPage(
      name: AppRoutes.printLabel,
      page: () => const PrintShelfLabelPage(),
    ),
    GetPage(
      name: AppRoutes.capture,
      page: () => const CapturePage(),
      binding: CaptureBinding(),
    ),
    GetPage(name: AppRoutes.history, page: () => const HistoryPage()),
  ];
}

class AppRoutes {
  static const receipt = '/receipt';
  static const selectLabel = '/selectLabel';
  static const printLabel = '/printLabel';
  static const scanProduct = '/scanProduct';
  static const label = '/label';

  /// display-capture
  static const capture = '/capture';
  static const history = '/history';
}
