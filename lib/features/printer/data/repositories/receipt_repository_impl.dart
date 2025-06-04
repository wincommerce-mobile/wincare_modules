import '../../domain/entities/receipt_entity.dart';
import '../../domain/repositories/receipt_repository.dart';
import '../datasources/receipt_data_source.dart';
import '../mappers/receipt_mapper.dart';

class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptDataSource receiptDataSource;

  ReceiptRepositoryImpl({required this.receiptDataSource});

  @override
  Future<ReceiptEntity> getReceipt(String receiptCode) async {
    final result = await receiptDataSource.fetchReceipts(receiptCode);
    return ReceiptMapper.toReceiptEntity(result);
  }
}
