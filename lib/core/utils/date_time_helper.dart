import 'package:intl/intl.dart';

class DateTimeHelper {
  static String todaysDateFormatted() {
    final now = DateTime.now();
    return DateFormat('yyyyMMdd').format(now);
  }

  static DateTime createDateTimeObject(String yyyymmdd) {
    if (yyyymmdd.length != 8 || int.tryParse(yyyymmdd) == null) {
      return DateTime.now();
    }
    return DateTime(
      int.parse(yyyymmdd.substring(0, 4)),
      int.parse(yyyymmdd.substring(4, 6)),
      int.parse(yyyymmdd.substring(6, 8)),
    );
  }

  static String convertDateTimeToString(DateTime dateTime) {
    return DateFormat('yyyyMMdd').format(dateTime);
  }

  static bool isValidDateString(String dateStr) {
    if (dateStr.length != 8) return false;
    try {
      int.parse(dateStr);
      return true;
    } catch (_) {
      return false;
    }
  }
}
