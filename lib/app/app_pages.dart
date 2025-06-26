import 'package:get/get.dart';
import 'package:wincare_modules/features/printer/presentation/pages/receipt/receipt_page.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/select_label_type_page.dart';
import 'package:wincare_modules/features/printer/presentation/pages/shelf_label/shelf_label_page.dart';

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
