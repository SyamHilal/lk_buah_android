import 'package:intl/intl.dart';

class TimeZone {
  static DateTime convertToLocal(String date) {
    final dateUtc = DateTime.utc(
        DateTime.parse(date).year,
        DateTime.parse(date).month,
        DateTime.parse(date).day,
        DateTime.parse(date + 'Z').hour,
        DateTime.parse(date).minute,
        DateTime.parse(date).second);

    return dateUtc;
  }

  static DateTime convertToLocal2(String date) {
    final dateUtc = DateTime.utc(
        DateTime.parse(date).year,
        DateTime.parse(date).month,
        DateTime.parse(date).day,
        DateTime.parse(date).hour,
        DateTime.parse(date).minute,
        DateTime.parse(date).second);

    return dateUtc;
  }

  static DateTime convertToLocal3(String date) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").parse(date, true);
  }
}
