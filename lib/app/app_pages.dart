import 'package:get/get.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/print_shelf_label_page.dart';

import '../features/printer/presentation/pages/page.dart';
import '../features/printer/presentation/pages/shelf_label/scan_shelf_label_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.receipt, page: () => const ReceiptPage()),
    GetPage(
      name: AppRoutes.printLabel,
      page: () => const PrintShelfLabelPage(),
    ),
  ];
}

class AppRoutes {
  static const receipt = '/receipt';
  static const selectLabel = '/selectLabel';
  static const printLabel = '/printLabel';
  static const scanProduct = '/scanProduct';
  static const label = '/label';
}
