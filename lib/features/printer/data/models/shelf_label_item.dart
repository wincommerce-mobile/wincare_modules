class ShelfLabelItem {
  final String title;
  final String name;
  final num originalPrice;
  final num discountedPrice;
  final String qrCode;
  final String unitOfMeasure;
  final DateTime fromDate;
  final DateTime toDate;

  Map<String, String> splitPrice(num value) {
    final major = formatPrice((value ~/ 1000));
    final remainder = value % 1000;
    final decimal =
        '.${remainder.toString().padLeft(3, '0')}'; // Always 3 digits
    return {'major': major, 'decimal': decimal};
  }

  String formatPrice(num value) {
    // Keep as-is if less than 1000
    if (value < 1000) return value.toString();

    // Format for 1000 or more
    final major = (value ~/ 1000).toString();
    final decimal = (value % 1000).toString().padLeft(3, '0');
    return '$major.$decimal';
  }

  String discountedPriceFormatted() {
    return "${formatPrice(discountedPrice)}đ";
  }

  String get major {
    final parts = splitPrice(originalPrice);
    return '${parts['major']}';
  }

  String get decimal {
    final parts = splitPrice(originalPrice);
    return '${parts['decimal']}đ';
  }

  ShelfLabelItem({
    this.title = '',
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.qrCode,
    required this.unitOfMeasure,
    required this.fromDate,
    required this.toDate,
  });
}
