class ReceiptModel {
  String? saleDate;
  String? receiptCode;
  String? counter;
  String? orderCode;
  String? customerName;
  String? customerPhone;
  List<ItemModel>? items;
  String? totalAmount;
  String? totalProductAmount;
  String? customerPaid;
  String? voucherAmount;
  String? refundAmount;
  String? customerCardId;
  String? accumulatedPoints;
  String? deliveryMethod;
  String? deliveryTime;
  String? deliveryAddress;

  ReceiptModel({
    this.saleDate,
    this.receiptCode,
    this.counter,
    this.orderCode,
    this.customerName,
    this.customerPhone,
    this.items,
    this.totalAmount,
    this.totalProductAmount,
    this.customerPaid,
    this.voucherAmount,
    this.refundAmount,
    this.customerCardId,
    this.accumulatedPoints,
    this.deliveryMethod,
    this.deliveryTime,
    this.deliveryAddress,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
    saleDate: json['saleDate'],
    receiptCode: json['receiptCode'],
    counter: json['counter'],
    orderCode: json['orderCode'],
    customerName: json['customerName'],
    customerPhone: json['customerPhone'],
    items: json['items'] != null
        ? (json['items'] as List)
              .map((item) => ItemModel.fromJson(item))
              .toList()
        : [],
    totalAmount: json['totalAmount'],
    totalProductAmount: json['totalProductAmount'],
    customerPaid: json['customerPaid'],
    voucherAmount: json['voucherAmount'],
    refundAmount: json['refundAmount'],
    customerCardId: json['customerCardId'],
    accumulatedPoints: json['accumulatedPoints'],
    deliveryMethod: json['deliveryMethod'],
    deliveryTime: json['deliveryTime'],
    deliveryAddress: json['deliveryAddress'],
  );
}

class ItemModel {
  String? name;
  String? price;
  String? qty;
  String? unit;
  String? total;

  ItemModel({this.name, this.price, this.qty, this.unit, this.total});

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    name: json['name'],
    price: json['price'],
    qty: json['qty'],
    unit: json['unit'],
    total: json['total'],
  );
}
