import '../entities/receipt_entity.dart';

abstract class ReceiptRepository {
  Future<ReceiptEntity> getReceipt(String receiptCode);
}
