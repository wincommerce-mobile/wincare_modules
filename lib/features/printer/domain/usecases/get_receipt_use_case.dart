import '../entities/receipt_entity.dart';
import '../repositories/receipt_repository.dart';

class GetReceiptUseCase {
  final ReceiptRepository repository;

  GetReceiptUseCase(this.repository);

  Future<ReceiptEntity> call(String receiptCode) async {
    return await repository.getReceipt(receiptCode);
  }
}
