import 'package:intl/intl.dart';

/// int extensions for formatting numbers
extension IntExtension on int {
  String toTwoDigits() {
    return toString().padLeft(2, '0');
  }
}

/// double extensions for formatting numbers
extension DoubleExtension on double {
  String toTwoDigits() {
    return toStringAsFixed(2);
  }
}

/// double extensions for formatting numbers
extension NumberExtension on num {
  String get toVND {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
}

/// DateTime extensions for formatting date and time
extension DateTimeExtension on DateTime {
  String toDateString() {
    return '${year}-${month.toTwoDigits()}-${day.toTwoDigits()}';
  }

  String toTimeString() {
    return '${hour.toTwoDigits()}:${minute.toTwoDigits()}';
  }

  String toDateTimeString() {
    return '${toDateString()} ${toTimeString()}';
  }

  String formatDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String formatDateNoYear() {
    return DateFormat('dd/MM').format(this);
  }

  String toAppDateTimeFormat() {
    // 'this' ở đây chính là đối tượng DateTime mà bạn gọi hàm
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    return formatter.format(this);
  }
}

extension StringExtension on String {
  String toDateTimeString() {
    try {
      DateTime dateTime = DateTime.parse(this);
      return dateTime.toDateTimeString();
    } catch (e) {
      return this; // Return original string if parsing fails
    }
  }
}
