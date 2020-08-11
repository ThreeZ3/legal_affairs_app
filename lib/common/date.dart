import 'package:intl/intl.dart';

import 'check.dart';

class DateTimeForMater {
  static String full = "yyyy-MM-dd HH:mm:ss";

  static int secondToLimit(second) {
    int _second;
    if (second == null) {
      return 0;
    } else if (second is int) {
      _second = second;
    } else {
      _second = int.parse(second.toString());
    }
    return int.parse(stringDisposeWithDouble(_second ~/ 60));
  }

  static String formatDateV(DateTime dateTime, {bool isUtc, String format}) {
    if (dateTime == null) return "";
    format = format ?? full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /*
* 时间格式转换
* @param timestamp
* @param format format yyyy-MM-dd HH:nn:ss
*
* */
  static String formatTimeStampToString(timestamp, [format]) {
    assert(timestamp != null);

    int time = 0;

    if (timestamp is int) {
      time = timestamp;
    } else {
      time = int.parse(timestamp.toString());
    }

    if (format == null) {
      format = 'yyyy-MM-dd';// HH:mm:ss
    }

    DateFormat dateFormat = new DateFormat(format);

    var date = new DateTime.fromMillisecondsSinceEpoch(time * 1000);

    return dateFormat.format(date);
  }
}
