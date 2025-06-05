class SaleOrderHeader {
  String? billCode;
  DateTime? billDate;
  String? customerName;
  String? customerPhone;
  DateTime? deliveryDate;
  String? fullAddress;
  bool? isAllowCancel;
  bool? isAllowConfirm;
  List<SaleOrderItem>? items;
  int? memberLevel;
  String? memberLevelName;
  String? posCode;
  String? posName;
  int? saleType;
  int? statusId;
  String? statusName;
  String? storeId;
  String? storeName;
  double? totalPrice;
  int? userId;
  bool? check;

  SaleOrderHeader({
    this.billCode,
    this.billDate,
    this.customerName,
    this.customerPhone,
    this.deliveryDate,
    this.fullAddress,
    this.isAllowCancel,
    this.isAllowConfirm,
    this.items,
    this.memberLevel,
    this.memberLevelName,
    this.posCode,
    this.posName,
    this.saleType,
    this.statusId,
    this.statusName,
    this.storeId,
    this.storeName,
    this.totalPrice,
    this.userId,
    this.check,
  });

  factory SaleOrderHeader.fromJson(Map<String, dynamic> json) {
    return SaleOrderHeader(
      billCode: json['BillCode'] as String?,
      billDate: json['BillDate'] != null ? DateTime.tryParse(json['BillDate']) : null,
      customerName: json['CustomerName'] as String?,
      customerPhone: json['CustomerPhone'] as String?,
      deliveryDate: json['DeliveryDate'] != null ? DateTime.tryParse(json['DeliveryDate']) : null,
      fullAddress: json['FullAddress'] as String?,
      isAllowCancel: json['IsAllowCancel'] as bool?,
      isAllowConfirm: json['IsAllowConfirm'] as bool?,
      items: (json['Items'] as List<dynamic>?)
          ?.map((item) => SaleOrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      memberLevel: json['MemberLevel'] as int?,
      memberLevelName: json['MemberLevelName'] as String?,
      posCode: json['PosCode'] as String?,
      posName: json['PosName'] as String?,
      saleType: json['SaleType'] as int?,
      statusId: json['StatusId'] as int?,
      statusName: json['StatusName'] as String?,
      storeId: json['StoreId'] as String?,
      storeName: json['StoreName'] as String?,
      totalPrice: (json['TotalPrice'] as num?)?.toDouble(),
      userId: json['UserId'] as int?,
      check: json['check'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BillCode': billCode,
      'BillDate': billDate?.toIso8601String(),
      'CustomerName': customerName,
      'CustomerPhone': customerPhone,
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'FullAddress': fullAddress,
      'IsAllowCancel': isAllowCancel,
      'IsAllowConfirm': isAllowConfirm,
      'Items': items?.map((item) => item.toJson()).toList(),
      'MemberLevel': memberLevel,
      'MemberLevelName': memberLevelName,
      'PosCode': posCode,
      'PosName': posName,
      'SaleType': saleType,
      'StatusId': statusId,
      'StatusName': statusName,
      'StoreId': storeId,
      'StoreName': storeName,
      'TotalPrice': totalPrice,
      'UserId': userId,
      'check': check,
    };
  }
}

class SaleOrderItem {
  String? barcode;
  String? description;
  String? documentNo;
  String? itemNo;
  String? lineNo;
  double? marketPrice;
  double? netPrice;
  double? quantity;
  double? quantityConfirm;
  double? totalAmount;
  String? unitOfMeasure;
  double? unitPrice;
  String? urlImage;
  int? vatGroup;
  int? vatRate;

  SaleOrderItem({
    this.barcode,
    this.description,
    this.documentNo,
    this.itemNo,
    this.lineNo,
    this.marketPrice,
    this.netPrice,
    this.quantity,
    this.quantityConfirm,
    this.totalAmount,
    this.unitOfMeasure,
    this.unitPrice,
    this.urlImage,
    this.vatGroup,
    this.vatRate,
  });

  factory SaleOrderItem.fromJson(Map<String, dynamic> json) {
    return SaleOrderItem(
      barcode: json['Barcode'] as String?,
      description: json['Description'] as String?,
      documentNo: json['DocumentNo'] as String?,
      itemNo: json['ItemNo'] as String?,
      lineNo: json['LineNo'] as String?,
      marketPrice: (json['MarketPrice'] as num?)?.toDouble(),
      netPrice: (json['NetPrice'] as num?)?.toDouble(),
      quantity: (json['Quantity'] as num?)?.toDouble(),
      quantityConfirm: (json['QuantityConfirm'] as num?)?.toDouble(),
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      unitOfMeasure: json['UnitOfMeasure'] as String?,
      unitPrice: (json['UnitPrice'] as num?)?.toDouble(),
      urlImage: json['UrlImage'] as String?,
      vatGroup: json['VatGroup'] as int?,
      vatRate: json['VatRate'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Barcode': barcode,
      'Description': description,
      'DocumentNo': documentNo,
      'ItemNo': itemNo,
      'LineNo': lineNo,
      'MarketPrice': marketPrice,
      'NetPrice': netPrice,
      'Quantity': quantity,
      'QuantityConfirm': quantityConfirm,
      'TotalAmount': totalAmount,
      'UnitOfMeasure': unitOfMeasure,
      'UnitPrice': unitPrice,
      'UrlImage': urlImage,
      'VatGroup': vatGroup,
      'VatRate': vatRate,
    };
  }
}
