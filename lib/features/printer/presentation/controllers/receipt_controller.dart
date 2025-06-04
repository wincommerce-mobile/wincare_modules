import 'package:get/get.dart';

import '../../domain/usecases/get_receipt_use_case.dart';

class ReceiptController extends GetxController {
  GetReceiptUseCase getReceiptUseCase;

  ReceiptController({required this.getReceiptUseCase});
}
