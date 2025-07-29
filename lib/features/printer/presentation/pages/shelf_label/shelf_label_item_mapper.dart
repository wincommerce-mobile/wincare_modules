import '../../../data/models/product_model.dart';
import '../../../data/models/shelf_label_item.dart';

class ShelfLabelItemMapper {
  static ShelfLabelItem toShelfLabelItem(MProduct? product) {
    return ShelfLabelItem(
      name: product?.productName ?? "",
      originalPrice: parsePrice(product?.sellPrice),
      discountedPrice: parsePrice(product?.promotionPrice),
      qrCode: product?.productBarcode ?? "",
      countryOri: product?.countryOri ?? '',
      unitOfMeasure: product?.unitName ?? "",
      fromDate: product?.promotionFrom ?? "",
      toDate: product?.promotionTo ?? "",
    );
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
}
