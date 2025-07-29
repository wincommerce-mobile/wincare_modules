class MProduct {
  String? productCode;
  String? productName;
  String? productBarcode;
  String? unitCode;
  String? unitName;
  dynamic promotionPrice;
  String? promotionFrom;
  String? promotionTo;
  dynamic sellPrice;
  String? promotionCode;
  dynamic specPromotionPrice;
  String? specPromotionFrom;
  String? specPromotionTo;
  String? countryOri;
  String? countryOriName;

  bool isPromotion() {
    return (parsePrice(promotionPrice) > 0);
  }

  static num parsePrice(dynamic input) {
    if (input == null) return 0;

    if (input is num) {
      return input;
    }

    if (input is String) {
      // Remove all non-digit characters
      final numericString = input.replaceAll(RegExp(r'[^\d]'), '');
      return num.tryParse(numericString) ?? 0;
    }

    return 0;
  }

  MProduct({
    this.productCode,
    this.productName,
    this.productBarcode,
    this.unitCode,
    this.unitName,
    this.promotionPrice,
    this.promotionFrom,
    this.promotionTo,
    this.sellPrice,
    this.promotionCode,
    this.specPromotionPrice,
    this.specPromotionFrom,
    this.specPromotionTo,
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
      promotionPrice: json['PromotionPrice'],
      promotionFrom: json['PromotionFrom'],
      promotionTo: json['PromotionTo'],
      sellPrice: json['SellPrice'],
      promotionCode: json['PromotionCode'],
      specPromotionPrice: json['SpecPromotionPrice'],
      specPromotionFrom: json['SpecPromotionFrom'],
      specPromotionTo: json['SpecPromotionTo'],
      countryOri: json['CountryOri'],
      countryOriName: json['CountryOriName'],
    );
  }
}
