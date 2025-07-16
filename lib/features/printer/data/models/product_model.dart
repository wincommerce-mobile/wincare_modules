class MProduct {
  String? productCode;
  String? productName;
  String? productBarcode;
  String? unitCode;
  String? unitName;
  double? quantity;
  double? quantityRequire;
  String? sapLineItem;
  String? carrierCode;
  String? carrierName;
  num? promotionPrice;
  String? promotionFrom;
  String? promotionTo;
  String? sloc;
  num? sellPrice;
  double? lenBarcode;
  double? buyPrice;
  bool? isAllowDecimal;
  int? vatRate;
  int? groupVAT;
  String? promotionCode;
  bool? isBlockedEarnPoint;
  String? mch3;
  String? mch3Name;
  bool? isRequiredReason;
  int? reasonId;
  String? reasonName;
  String? reasonNote;
  bool? requestCancelIsWarning;
  String? requestCancelWarningText;
  int? numerator;
  int? denominator;
  num? specPromotionPrice;
  String? specPromotionFrom;
  String? specPromotionTo;
  String? plu;
  String? strQty;
  String? countryOri;
  String? countryOriName;

  bool isPromotion() {
    return (promotionFrom != null &&
        promotionFrom!.isNotEmpty &&
        promotionTo != null &&
        promotionTo!.isNotEmpty);
  }

  MProduct({
    this.productCode,
    this.productName,
    this.productBarcode,
    this.unitCode,
    this.unitName,
    this.quantity,
    this.quantityRequire,
    this.sapLineItem,
    this.carrierCode,
    this.carrierName,
    this.promotionPrice,
    this.promotionFrom,
    this.promotionTo,
    this.sloc,
    this.sellPrice,
    this.lenBarcode,
    this.buyPrice,
    this.isAllowDecimal,
    this.vatRate,
    this.groupVAT,
    this.promotionCode,
    this.isBlockedEarnPoint,
    this.mch3,
    this.mch3Name,
    this.isRequiredReason,
    this.reasonId,
    this.reasonName,
    this.reasonNote,
    this.requestCancelIsWarning,
    this.requestCancelWarningText,
    this.numerator,
    this.denominator,
    this.specPromotionPrice,
    this.specPromotionFrom,
    this.specPromotionTo,
    this.plu,
    this.strQty,
    this.countryOri,
    this.countryOriName,
  });

  factory MProduct.fromJson(Map<String, dynamic> json) {
    return MProduct(
      productCode: json['ProductCode'],
      productName: json['ProductName'],
      productBarcode: json['ProductBarcode'],
      unitCode: json['UnitCode'],
      unitName: json['UnitName'],
      quantity: (json['Quantity'] as num?)?.toDouble(),
      quantityRequire: (json['QuantityRequire'] as num?)?.toDouble(),
      sapLineItem: json['SAPLineItem'],
      carrierCode: json['CarrierCode'],
      carrierName: json['CarrierName'],
      promotionPrice: json['PromotionPrice'] as num?,
      promotionFrom: json['PromotionFrom'],
      promotionTo: json['PromotionTo'],
      sloc: json['Sloc'],
      sellPrice: json['SellPrice'] as num?,
      lenBarcode: (json['LenBarcode'] as num?)?.toDouble(),
      buyPrice: (json['BuyPrice'] as num?)?.toDouble(),
      isAllowDecimal: json['IsAllowDecimal'],
      vatRate: json['VATRate'],
      groupVAT: json['GroupVAT'],
      promotionCode: json['PromotionCode'],
      isBlockedEarnPoint: json['IsBlockedEarnPoint'],
      mch3: json['Mch3'],
      mch3Name: json['Mch3Name'],
      isRequiredReason: json['IsRequiredReason'],
      reasonId: json['ReasonId'],
      reasonName: json['ReasonName'],
      reasonNote: json['ReasonNote'],
      requestCancelIsWarning: json['RequestCancelIsWarning'],
      requestCancelWarningText: json['RequestCancelWarningText'],
      numerator: json['Numerator'],
      denominator: json['Denominator'],
      specPromotionPrice: json['SpecPromotionPrice'],
      specPromotionFrom: json['SpecPromotionFrom'],
      specPromotionTo: json['SpecPromotionTo'],
      plu: json['PLU'],
      strQty: json['_strQty'],
      countryOri: json['CountryOri'],
      countryOriName: json['CountryOriName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductCode': productCode,
      'ProductName': productName,
      'ProductBarcode': productBarcode,
      'UnitCode': unitCode,
      'UnitName': unitName,
      'Quantity': quantity,
      'QuantityRequire': quantityRequire,
      'SAPLineItem': sapLineItem,
      'CarrierCode': carrierCode,
      'CarrierName': carrierName,
      'PromotionPrice': promotionPrice,
      'PromotionFrom': promotionFrom,
      'PromotionTo': promotionTo,
      'Sloc': sloc,
      'SellPrice': sellPrice,
      'LenBarcode': lenBarcode,
      'BuyPrice': buyPrice,
      'IsAllowDecimal': isAllowDecimal,
      'VATRate': vatRate,
      'GroupVAT': groupVAT,
      'PromotionCode': promotionCode,
      'IsBlockedEarnPoint': isBlockedEarnPoint,
      'Mch3': mch3,
      'Mch3Name': mch3Name,
      'IsRequiredReason': isRequiredReason,
      'ReasonId': reasonId,
      'ReasonName': reasonName,
      'ReasonNote': reasonNote,
      'RequestCancelIsWarning': requestCancelIsWarning,
      'RequestCancelWarningText': requestCancelWarningText,
      'Numerator': numerator,
      'Denominator': denominator,
      'SpecPromotionPrice': specPromotionPrice,
      'SpecPromotionFrom': specPromotionFrom,
      'SpecPromotionTo': specPromotionTo,
      'PLU': plu,
      '_strQty': strQty,
      'CountryOri': countryOri,
      'CountryOriName': countryOriName,
    };
  }
}
