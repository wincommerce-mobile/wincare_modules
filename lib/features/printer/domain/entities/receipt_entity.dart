class ReceiptEntity {
  final String saleDate;
  final String receiptCode;
  final String counter;
  final String orderCode;
  final String customerName;
  final String customerPhone;
  final List<ItemEntity> items;
  final String totalAmount;
  final String totalProductAmount;
  final String customerPaid;
  final String voucherAmount;
  final String refundAmount;
  final String customerCardId;
  final String accumulatedPoints;
  final String deliveryMethod;
  final String deliveryTime;
  final String deliveryAddress;

  ReceiptEntity({
    required this.saleDate,
    required this.receiptCode,
    required this.counter,
    required this.orderCode,
    required this.customerName,
    required this.customerPhone,
    required this.items,
    required this.totalAmount,
    required this.totalProductAmount,
    required this.customerPaid,
    required this.voucherAmount,
    required this.refundAmount,
    required this.customerCardId,
    required this.accumulatedPoints,
    required this.deliveryMethod,
    required this.deliveryTime,
    required this.deliveryAddress,
  });
}

class ItemEntity {
  final String name;
  final String price;
  final String qty;
  final String unit;
  final String total;

  ItemEntity({
    required this.name,
    required this.price,
    required this.qty,
    required this.unit,
    required this.total,
  });
}