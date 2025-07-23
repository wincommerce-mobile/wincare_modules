

class ShelfLabelItem {
  final String title;
  final String name;
  final num originalPrice;
  final num discountedPrice;
  final String qrCode;
  final String countryOri;
  final String unitOfMeasure;
  final String fromDate;
  final String toDate;

  String getApplyDate() {
    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      final range = getFormattedDateRange();
      return "${range['fromDate'] ?? ""} - ${range['toDate'] ?? ""}";
    }
    if (fromDate.isNotEmpty) {
      return formatDateDDMMYYYY(_parseDate(fromDate));
    }

    final formatted = formatDateDDMMYYYY(DateTime.now());
    return formatted;
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
    try {
      if (dateStr.contains('T')) {
        // ISO 8601 format like "2025-07-16T14:30:00"
        return DateTime.parse(dateStr);
      } else {
        // Custom format "dd/MM/yyyy"
        final parts = dateStr.split('/');
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (_) {
      return DateTime.now();
    }
  }

  Map<String, String> splitPrice(num value) {
    if (value < 1000) {
      return {
        'major': value % 1 == 0 ? value.toInt().toString() : value.toString(),
        'decimal': '',
      };
    }

    final major = (value ~/ 1000).toString(); // Integer division
    final decimal = '.${(value % 1000).toInt().toString().padLeft(3, '0')}';

    return {'major': major, 'decimal': decimal};
  }

  String formatPrice(num value) {
    // If value < 1000, return without trailing .0 if it's an int
    if (value < 1000) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    // Convert to int to ignore decimal part and format with dot as thousands separator
    final intValue = value.toInt();
    final str = intValue.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < str.length; i++) {
      buffer.write(str[i]);
      int remaining = str.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }

    return buffer.toString();
  }

  String discountedPriceFormatted() {
    if (discountedPrice == 0) {
      return "";
    }
    return "${formatPrice(originalPrice)}đ";
  }

  String get major {
    final parts = splitPrice(
      discountedPrice > 0 ? discountedPrice : originalPrice,
    );
    return '${parts['major']}';
  }

  String get decimal {
    final parts = splitPrice(
      discountedPrice > 0 ? discountedPrice : originalPrice,
    );
    return '${parts['decimal']}đ';
  }

  ShelfLabelItem({
    this.title = '',
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.qrCode,
    required this.countryOri,
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
