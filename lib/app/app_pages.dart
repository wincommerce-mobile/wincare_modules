import 'package:get/get.dart';

import '../features/printer/presentation/pages/page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.receipt, page: () => const ReceiptPage()),
    GetPage(
      name: AppRoutes.selectLabel,
      page: () => const SelectLabelTypePage(),
    ),
    GetPage(name: AppRoutes.label, page: () => const ShelfLabelPage()),
  ];
}

class AppRoutes {
  static const receipt = '/receipt';
  static const selectLabel = '/selectLabel';
  static const label = '/label';
}
