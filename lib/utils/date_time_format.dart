import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDateTime(String dateString) {
    var inputDate = DateTime.parse(dateString);
    var formatDate = DateFormat('HH:mm a, d MMM');
    var newFormat = formatDate.format(inputDate);
    return newFormat.toString();
  }

  static String homeDate() {
    var now = DateTime.now();
    var format = DateFormat('EEEE, MMM d yyyy').format(now);
    return format;
  }

  static Duration difference() {
    DateTime notificationDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 30, 00);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    return difference;
  }
}
