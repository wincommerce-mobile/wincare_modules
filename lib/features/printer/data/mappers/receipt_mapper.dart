import 'package:wincare_modules/features/printer/data/models/receipt_model.dart';
import 'package:wincare_modules/features/printer/domain/entities/receipt_entity.dart';

class ReceiptMapper {
  static ReceiptEntity toReceiptEntity(ReceiptModel model) {
    return ReceiptEntity(
      saleDate: model.saleDate ?? "",
      receiptCode: model.receiptCode ?? "",
      counter: model.counter ?? "",
      orderCode: model.orderCode ?? "",
      customerName: model.customerName ?? "",
      customerPhone: model.customerPhone ?? "",
      items: model.items != null
          ? model.items!.map((item) => toItemEntity(item)).toList()
          : [],
      totalAmount: model.totalAmount ?? "",
      totalProductAmount: model.totalProductAmount ?? "",
      customerPaid: model.customerPaid ?? "",
      voucherAmount: model.voucherAmount ?? "",
      refundAmount: model.refundAmount ?? "",
      customerCardId: model.customerCardId ?? "",
      accumulatedPoints: model.accumulatedPoints ?? "",
      deliveryMethod: model.deliveryMethod ?? "",
      deliveryTime: model.deliveryTime ?? "",
      deliveryAddress: model.deliveryAddress ?? "",
    );
  }

  static ItemEntity toItemEntity(ItemModel model) {
    return ItemEntity(
      name: model.name ?? "",
      price: model.price ?? "",
      qty: model.qty ?? "",
      unit: model.unit ?? "",
      total: model.total ?? "",
    );
  }
}
