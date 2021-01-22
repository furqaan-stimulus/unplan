import 'package:intl/intl.dart';
import 'package:unplan/model/log_model.dart';

class Utils {
  static const LOGIN = 'login';
  static const ADD_ATTENDANCE = 'attendenceDetail';
  static const base_url = 'https://dev.stimulusco.com/api/';
  static const login_url = base_url + LOGIN;
  static const attendance_url = base_url + ADD_ATTENDANCE;

  static int get getNowInMillisecond => DateTime.now().millisecondsSinceEpoch;

  static int get getTodayInMillisecond {
    DateTime today = DateTime.now();
    return DateTime(
      today.year,
      today.month,
      today.day,
    ).millisecondsSinceEpoch;
  }

  static double calculateHoursForSingleDay(List<LogModel> logs,
      {String unit = 'hours'}) {
    List<Duration> pairs = createPairsFromList(logs);
    double timeInSeconds = pairs.fold(0, (previousValue, element) {
      return previousValue + element.inSeconds;
    });
    switch (unit) {
      case 'hours':
        {
          return double.parse((timeInSeconds / (60 * 60)).toStringAsFixed(2));
        }

      case 'minutes':
        {
          return double.parse((timeInSeconds / (60)).toStringAsFixed(2));
        }

      case 'seconds':
        {
          return double.parse((timeInSeconds / (1)).toStringAsFixed(2));
        }
    }
  }

  static List<Duration> createPairsFromList(List<LogModel> logs) {
    return logs.map((value) {
      int index = logs.indexOf(value);
      int nextElementIndex = index + 1;
      if (logs.length != nextElementIndex) {
        return value
            .getDateWithMinutes()
            .difference(logs[nextElementIndex].getDateWithMinutes());
      } else {
        return Duration.zero;
      }
    }).toList();
  }

  static String timeAgoSinceDate() {
    DateTime notificationDate = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 10, 30, 00);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inMinutes <= 5) {
      return 'ON TIME';
    } else if (difference.inMinutes == 5 && difference.inMinutes <= 20) {
      return 'LATE';
    } else if (difference.inMinutes == 20 && difference.inMinutes <= 60) {
      return 'VERY LATE!!!';
    } else if (difference.inMinutes == 60 && difference.inMinutes <= 210) {
      return 'OH! HALF DAY';
    } else {
      return 'blank';
    }
  }
}
