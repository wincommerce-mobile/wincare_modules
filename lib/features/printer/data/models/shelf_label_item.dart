import 'package:wincare_modules/app/app_extensions.dart';

class ShelfLabelItem {
  final String title;
  final String name;
  final num originalPrice;
  final num discountedPrice;
  final String qrCode;
  final String? countryOri;
  final String unitOfMeasure;
  final String fromDate;
  final String toDate;

  String getApplyDate() {
    if (fromDate.isEmpty || toDate.isEmpty) {
      final formatted = formatDateDDMMYYYY(DateTime.now());
      return formatted;
    }
    final range = getFormattedDateRange();
    return "${range['fromDate'] ?? ""} - ${range['toDate'] ?? ""}";
  }

  String formatDateDDMMYYYY(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  /// Returns a formatted fromDate and toDate depending on year comparison
  Map<String, String?> getFormattedDateRange() {
    if (fromDate.isEmpty || toDate.isEmpty) {
      return {'fromDate': fromDate, 'toDate': toDate};
    }

    final from = _parseDate(fromDate!);
    final to = _parseDate(toDate!);

    final sameYear = from.year == to.year;

    final formattedFrom = sameYear
        ? _formatMonthDay(from)
        : _formatFullDate(from);

    final formattedTo = _formatFullDate(to);

    return {'fromDate': formattedFrom, 'toDate': formattedTo};
  }

  String _formatMonthDay(DateTime date) =>
      '${_twoDigits(date.day)}/${_twoDigits(date.month)}';

  String _formatFullDate(DateTime date) =>
      '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}';

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  DateTime _parseDate(String dateStr) {
    // Supports "dd/MM/yyyy"
    final parts = dateStr.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

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
    if (discountedPrice == 0) {
      return "";
    }
    return "${formatPrice(originalPrice)}đ";
  }

  String get major {
    final parts = splitPrice(discountedPrice > 0 ? discountedPrice : originalPrice);
    return '${parts['major']}';
  }

  String get decimal {
    final parts = splitPrice(discountedPrice > 0 ? discountedPrice : originalPrice);
    return '${parts['decimal']}đ';
  }

  ShelfLabelItem({
    this.title = '',
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.qrCode,
    this.countryOri,
    required this.unitOfMeasure,
    required this.fromDate,
    required this.toDate,
  });

  /// Create object from JSON
  factory ShelfLabelItem.fromJson(Map<String, dynamic> json) {
    return ShelfLabelItem(
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      originalPrice: json['originalPrice'] ?? 0,
      discountedPrice: json['discountedPrice'] ?? 0,
      qrCode: json['qrCode'] ?? '',
      countryOri: json['countryOri'] ?? '',
      unitOfMeasure: json['unitOfMeasure'] ?? '',
      fromDate: json['fromDate'],
      toDate: json['toDate'],
    );
  }
}
